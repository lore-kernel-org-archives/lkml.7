Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8863218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfCOQnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfCOQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:43:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09713218AC;
        Fri, 15 Mar 2019 16:43:49 +0000 (UTC)
Date:   Fri, 15 Mar 2019 12:43:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?UTF-8?B?SGrDuG5uZXY=?= =?UTF-8?B?w6Vn?= 
        <arve@android.com>, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for
 Android
Message-ID: <20190315124348.528ecd87@gandalf.local.home>
In-Reply-To: <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
        <20190311174320.GC5721@dhcp22.suse.cz>
        <20190311175800.GA5522@sultan-box.localdomain>
        <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
        <20190311204626.GA3119@sultan-box.localdomain>
        <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
        <20190312080532.GE5721@dhcp22.suse.cz>
        <20190312163741.GA2762@sultan-box.localdomain>
        <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
        <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
        <20190314204911.GA875@sultan-box.localdomain>
        <20190314231641.5a37932b@oasis.local.home>
        <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 21:36:43 -0700
Daniel Colascione <dancol@google.com> wrote:

> On Thu, Mar 14, 2019 at 8:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 14 Mar 2019 13:49:11 -0700
> > Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >  
> > > Perhaps I'm missing something, but if you want to know when a process has died
> > > after sending a SIGKILL to it, then why not just make the SIGKILL optionally
> > > block until the process has died completely? It'd be rather trivial to just
> > > store a pointer to an onstack completion inside the victim process' task_struct,
> > > and then complete it in free_task().  
> >
> > How would you implement such a method in userspace? kill() doesn't take
> > any parameters but the pid of the process you want to send a signal to,
> > and the signal to send. This would require a new system call, and be
> > quite a bit of work.  
> 
> That's what the pidfd work is for. Please read the original threads
> about the motivation and design of that facility.

I wasn't Cc'd on the original work, so I haven't read them.

> 
> > If you can solve this with an ebpf program, I
> > strongly suggest you do that instead.  
> 



> We do want killed processes to die promptly. That's why I support
> boosting a process's priority somehow when lmkd is about to kill it.
> The precise way in which we do that --- involving not only actual
> priority, but scheduler knobs, cgroup assignment, core affinity, and
> so on --- is a complex topic best left to userspace. lmkd already has
> all the knobs it needs to implement whatever priority boosting policy
> it wants.
> 
> Hell, once we add a pidfd_wait --- which I plan to work on, assuming
> nobody beats me to it, after pidfd_send_signal lands --- you can
> imagine a general-purpose priority inheritance mechanism expediting
> process death when a high-priority process waits on a pidfd_wait
> handle for a condemned process. You know you're on the right track
> design-wise when you start seeing this kind of elegant constructive
> interference between seemingly-unrelated features. What we don't need
> is some kind of blocking SIGKILL alternative or backdoor event
> delivery system.
> 
> We definitely don't want to have to wait for a process's parent to
> reap it. Instead, we want to wait for it to become a zombie. That's
> why I designed my original exithand patch to fire death notification
> upon transition to the zombie state, not upon process table removal,
> and I expect pidfd_wait (or whatever we call it) to act the same way.
> 
> In any case, there's a clear path forward here --- general-purpose,
> cheap, and elegant --- and we should just focus on doing that instead
> of more complex proposals with few advantages.

If you add new pidfd systemcalls then making a new way to send a signal
and block till it does die or whatever is more acceptable than adding a
new signal that changes the semantics of sending signals, which is what
I was against.

I do agree with Joel about bloating task_struct too. If anything, have
a wait queue you add, where you can allocate a descriptor with the task
dieing and task killing, and just search this queue on dying. We could
add a TIF flag to the task as well to let the exiting of this task know
it should do such an operation.

-- Steve
