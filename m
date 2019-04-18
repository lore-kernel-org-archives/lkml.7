Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED5D217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVcgtSBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbfDRRxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:53:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42528 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbfDRRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:53:46 -0400
Received: by mail-vs1-f65.google.com with SMTP id f15so1619125vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+aCB51wSzBRb+g6w79GERBDmxHkdK0m0brStvsO0x24=;
        b=SVcgtSBLmc2xM0J5DquLhMFb3hyfz4jZTgTJA9db/Q8DtxuxUWeCly6ndSd7MftMTo
         QSxPEAq4uZJkuDwesNVjJGjqmFdzN6buw4++xszB5VkqtCrdrpX9PieeYFgpI96cXT45
         KXQIMoPCG8r/4kLJ+982MtD6FxhXq+tNQPbV781ZYkeXwRkVr0ysQEwRPekTwrcD5x07
         SG5s+UWiaynVqfgkx5W66M0NiitSqBM7uZmj/7Dhv6noOVotqh8WVRNN+ThVMo065w6T
         ljotwg4tXAZEcg+fOmJM3yf8jBBMUVSb1ZU/FGvZVS62zlKzO3C3t/uYTBoME2J/VhkP
         YkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aCB51wSzBRb+g6w79GERBDmxHkdK0m0brStvsO0x24=;
        b=lg4ZSI8beqgPrJDT1wSqpu9hs/X6E++ujitXmersWAInDROOiGZcXAt2Ea6/airxpr
         kbMo/NLBtPuCHn3LTdXk6H0iDqIKbZIOMLuzikKCiPUuomPLsjpAoLfuTzQjkbSaYEHh
         TXASNxbStoWl0rSWPVFl/CUrSdC/oBzOKDagPnROP4FVRa16IWtwJEYPiSQ7UW6avUJA
         tcmdRqYWCkKCgeIqYvT/GoWFIsoACGP/LJuSG7vX2gzAuGVXS/5BJbg93m4/Kd6Q4RVa
         Gu36ZsVOPj9k1iLogRWxWVbmiJPLRTq0/n3NhL0NWDrJhfGErr8dLo8nVd9A+vlDopT1
         FhoQ==
X-Gm-Message-State: APjAAAXkNRPQl6ybP1oE6/bJmr1sjw+YJQMToE6i55msJxVRD6Y4VBLU
        mkBv8Wc1fZw9t5lUnKUHR453Cximf38Zo3fq+F+b5Q==
X-Google-Smtp-Source: APXvYqzHYvVcAcOQAwnRLj6YgPyJZ7DIOcssgUOygTW1U3l1rCQmKILucHf0R9Ig/AIM9bDZMr/6LQyMo2j+hWPp2EU=
X-Received: by 2002:a05:6102:18d:: with SMTP id r13mr55413741vsq.171.1555610025262;
 Thu, 18 Apr 2019 10:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
In-Reply-To: <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 18 Apr 2019 10:53:33 -0700
Message-ID: <CAKOZues8mnjvUUopNoeXcDezXKscQLNAgCgodqUno_Z39kV7Dw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:26 AM Christian Brauner <christian@brauner.io> wrote:
>
> On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >> On 04/16, Joel Fernandes wrote:
> >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> >> > >
> >> > > Could you explain when it should return POLLIN? When the whole
> >process exits?
> >> >
> >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> >or when it
> >> > is in a zombie state and there's no other thread in the thread
> >group.
> >>
> >> IOW, when the whole thread group exits, so it can't be used to
> >monitor sub-threads.
> >>
> >> just in case... speaking of this patch it doesn't modify
> >proc_tid_base_operations,
> >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> >going to use
> >> the anonymous file returned by CLONE_PIDFD ?
> >
> >I don't think procfs works that way. /proc/sub-thread-tid has
> >proc_tgid_base_operations despite not being a thread group leader.

Huh. That seems very weird. Is that too late to change now? It feels like a bug.

> >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> >be hit trivially, and then the code will misbehave.
> >
> >@Joel: I think you'll have to either rewrite this to explicitly bail
> >out if you're dealing with a thread group leader

If you're _not_ dealing with a leader, right?

> , or make the code
> >work for threads, too.
> The latter case probably being preferred if this API is supposed to be useable for thread management in userspace.

IMHO, focusing on the thread group case for now might be best. We can
always support thread management in future work.

Besides: I'm not sure that we need kernel support for thread
monitoring. Can't libc provide a pollable FD for a thread internally?
libc can always run code just before thread exit, and it can wake a
signalfd at that point. Directly terminating individual threads
without going through userland is something that breaks the process
anyway: it's legal and normal to SIGKILL a process a whole, but if an
individual thread terminates without going through libc, the process
is likely going to be fatally broken anyway. (What if it's holding the
heap lock?)

I know that in some tools want to wait for termination of individual
threads in an external monitored process, but couldn't these tools
cooperate with libc to get these per-thread eventfds?

Is there a use case I'm missing?
