Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6770C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CBB20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="buFWZKNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDMAJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:09:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42082 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfDMAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:09:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so5904854pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZaGr3WgExHMh9wQG0gQSM2UGEHJ7mH3Q5u/gKtIcV5Q=;
        b=buFWZKNA27fK0QCirnp8Rr4tRDYdX/qiV1weqkyNFsCdAZNRgWL8/W4sJ8yWKlxj6g
         4EvMQDfxyAywDcUYkHzcmpyeEXLFXFdzLtDH/+B3leWiq5/gLgAJ1TCdSRcKbro+nDmU
         KbWFGFJ8xiMaHuFSIejg9Radvl7jHZHEZUGyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZaGr3WgExHMh9wQG0gQSM2UGEHJ7mH3Q5u/gKtIcV5Q=;
        b=Z+JErn10aYDcp3Al2NjHdIqInamV72pMt7IU73JbhZwTg1CjjH8h7NEKqQXguhtEfL
         DtYGOoB9ZEBxVt2Akm9LRoR4SpWymk7u27VXqs4uZTLQ3WrXiv62PQqegPDvEDAryuir
         7OBZLBI+9x+g9XMVYM3u0yk69zwW30ys0Hetw4YrlHdZYNKYC7BFHqaxKWmy95FY/eWc
         P6jsh2bvu2/G9RfrdDhWVD5McpJjyDsYWU8Funq3FgNZbi9ZjGAMxIXEH/PmSjvm0n7l
         T7FK+1Z5btN3K+gsM67ED/w3+kaoJBLkqWCY8+g9XFuFQI28Na0NcgSUY5nciR78r1Vb
         KXWw==
X-Gm-Message-State: APjAAAVEAYJE24fOnj+Aww3ITLBJftWoC6io69Pave5w7sOkDYHQHo6r
        aezrM1wQZtao3J4V22xoWxQWwQ==
X-Google-Smtp-Source: APXvYqzsSJ1ByR1zj4Uczcq09iyvKxoz9RDlgHKlEee8kgbs/jtTj4wcJ6371KCbc/5YMNiU6KjFaA==
X-Received: by 2002:a65:4105:: with SMTP id w5mr24260779pgp.222.1555114183393;
        Fri, 12 Apr 2019 17:09:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l88sm71082518pfb.104.2019.04.12.17.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 17:09:42 -0700 (PDT)
Date:   Fri, 12 Apr 2019 20:09:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190413000941.GA53420@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy!

On Fri, Apr 12, 2019 at 02:32:53PM -0700, Andy Lutomirski wrote:
> On Thu, Apr 11, 2019 at 10:51 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > pidfd are /proc/pid directory file descriptors referring to a task group
> > leader. Android low memory killer (LMK) needs pidfd polling support to
> > replace code that currently checks for existence of /proc/pid for
> > knowing a process that is signalled to be killed has died, which is both
> > racy and slow. The pidfd poll approach is race-free, and also allows the
> > LMK to do other things (such as by polling on other fds) while awaiting
> > the process being killed to die.
> >
> > It prevents a situation where a PID is reused between when LMK sends a
> > kill signal and checks for existence of the PID, since the wrong PID is
> > now possibly checked for existence.
> >
> > In this patch, we follow the same mechanism used uhen the parent of the
> > task group is to be notified, that is when the tasks waiting on a poll
> > of pidfd are also awakened.
> >
> > We have decided to include the waitqueue in struct pid for the following
> > reasons:
> > 1. The wait queue has to survive for the lifetime of the poll. Including
> > it in task_struct would not be option in this case because the task can
> > be reaped and destroyed before the poll returns.
> 
> Are you sure?  I admit I'm not all that familiar with the innards of
> poll() on Linux, but I thought that the waitqueue only had to survive
> long enough to kick the polling thread and did *not* have to survive
> until poll() actually returned.

I am not sure now. I thought epoll(2) was based on the wait_event APIs,
however more closely looking at the eventpoll code, it looks like there are 2
waitqueues involved, one that we pass and the other that is a part of the
eventpoll session itself, so you could be right about that. Daniel Colascione
may have some more thoughts about it since he brought up the possiblity of a
wq life-time issue. Daniel?   We were just playing it safe.

Either way the waitqueue in struct pid has the advantage mentioned below:

> > 2. By including the struct pid for the waitqueue means that during
> > de_exec, the thread doing de_thread() automatically gets the new
> > waitqueue/pid even though its task_struct is different.
> 
> I didn't follow this.  Can you clarify?

Sure. de_thread() can called when all threads of a thread group need to die
when any thread in the group does an execve. The thread doing the execve will
become the new thread leader. In this case, the thread that did the exec gets
the pid of the new leader. The semantics of wait(2) are such that the wait
should not return (unblock) in the above scenario because the group is
non-empty even though the task_struct of the group leader died. IOW, we
should not wake up any pidfd pollers in this cases.

So basically what I was trying to say in point 2 above is that because of
putting the waitqueue in struct pid, the change_pid() in de_thread()
automatically carries the waiting tasks to the new task_struct leader,
because the pid gets transferred to the new leader. If we put it in
task_struct, then that wouldn't work since the leader's task_struct would get
destroyed and we would have to handle the case in some other way. At least
that is the theory.  Anyway we specifically test for this case in patch 2/2
and also tested that not handling this case fails the test.

> Also, please don't call your new helper wake_up_pidfd_pollers().  One

I will call it wake_up_pollers() then, if that's Ok.

> of the goals of my patch was to make it generically possible for
> kernel code to wait for a task to exit.  There are other cases besides
> pidfd for which this would be useful.  Ahem, kthread.  (The kthread
> implementation currently does some seriously awful things to detect
> when kthreads die.)  Also, some hypothetical future vastly improved
> debugging API (to supercede ptrace for new applications) might want
> this.

Ah I see :-) Nice to know we can use this to improve the kthread code.

thanks,

 - Joel

