Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31958218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555104789;
	bh=G0n+RD7WzgKE1Bp1mc3p0Joa9QfqNlG2x2vv8QQloFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wktaVI/2CaVk4S+zAEAxDai+CatZnRQ5J/Jn/PZQffoOowXegLy9Qh/B0wuUJS5I1
	 XyXbplfwjdHbKAvp4onjQd6xyeJ4cSshHHk+7i/gPmW0fQ5OROVgCysfXoLftJWSd2
	 gLTHr/C5fV8ofDUbksoVKQuxZ5uL5ADExs6w3dCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLVdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:33:07 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46627218FC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555104786;
        bh=G0n+RD7WzgKE1Bp1mc3p0Joa9QfqNlG2x2vv8QQloFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l1mS0Z24mBEOBqu7t+gfQYA/4aNAmm/de1JMGdrebrcsJTEO0eQJAi8KLGHN2QxIv
         IJW4Rq68JGkEkOhGRtIfrgeB9FZnegy5KHhd8bL8CLnp72/krW2UC6pwsENTnp2BM4
         gozCPH03EqkYozUSEhN4GfWFoBXwzIzR+HY9O1z8=
Received: by mail-wm1-f50.google.com with SMTP id h18so12598832wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 14:33:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWyKkVBxluG7EWsfaGOTLQS+cFSHjM1b4mr3kbv1mQjrSpEYarO
        BUHVciwMgjJthiKNG+fSv2pwaS05j3tq8/28ThZJkQ==
X-Google-Smtp-Source: APXvYqyWkWQmR3dFfAyiKEnxHZBFm/hmsqTjQDWvcKZLincV//nNnrTxC3QydrvhPfst/4cCh1lb1GQGZR7GLK845pM=
X-Received: by 2002:a1c:99d5:: with SMTP id b204mr12313630wme.95.1555104784796;
 Fri, 12 Apr 2019 14:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
In-Reply-To: <20190411175043.31207-1-joel@joelfernandes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Apr 2019 14:32:53 -0700
X-Gmail-Original-Message-ID: <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
Message-ID: <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:51 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> pidfd are /proc/pid directory file descriptors referring to a task group
> leader. Android low memory killer (LMK) needs pidfd polling support to
> replace code that currently checks for existence of /proc/pid for
> knowing a process that is signalled to be killed has died, which is both
> racy and slow. The pidfd poll approach is race-free, and also allows the
> LMK to do other things (such as by polling on other fds) while awaiting
> the process being killed to die.
>
> It prevents a situation where a PID is reused between when LMK sends a
> kill signal and checks for existence of the PID, since the wrong PID is
> now possibly checked for existence.
>
> In this patch, we follow the same mechanism used uhen the parent of the
> task group is to be notified, that is when the tasks waiting on a poll
> of pidfd are also awakened.
>
> We have decided to include the waitqueue in struct pid for the following
> reasons:
> 1. The wait queue has to survive for the lifetime of the poll. Including
> it in task_struct would not be option in this case because the task can
> be reaped and destroyed before the poll returns.

Are you sure?  I admit I'm not all that familiar with the innards of
poll() on Linux, but I thought that the waitqueue only had to survive
long enough to kick the polling thread and did *not* have to survive
until poll() actually returned.

>
> 2. By including the struct pid for the waitqueue means that during
> de_exec, the thread doing de_thread() automatically gets the new
> waitqueue/pid even though its task_struct is different.

I didn't follow this.  Can you clarify?

Also, please don't call your new helper wake_up_pidfd_pollers().  One
of the goals of my patch was to make it generically possible for
kernel code to wait for a task to exit.  There are other cases besides
pidfd for which this would be useful.  Ahem, kthread.  (The kthread
implementation currently does some seriously awful things to detect
when kthreads die.)  Also, some hypothetical future vastly improved
debugging API (to supercede ptrace for new applications) might want
this.

--Andy
