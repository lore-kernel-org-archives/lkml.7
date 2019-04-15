Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3907AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169E2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UncmXVMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfDORPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:15:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45462 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfDORPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:15:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so10299474qkb.12;
        Mon, 15 Apr 2019 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgY988J5MmT52aqvYksvcGCD5FJa6IhC1tvL+3Puv5o=;
        b=UncmXVMSz7OXjTXGY8qYgsCV3V3MfYl1p/zr9dPy+Dw86ciXPF8XlEdW/6d+ClBGzj
         /QgVDJz6pYBxVvYI5ii4Nm15MvvOSW1+JYa4BWHqpiClrG/sxdIgzUTKjwZO9ymF3ju4
         3uOFLTT+lg9vuszGDB106bGfXo9yHxgMOWuV/Wpz0MwoTZ2/FW1NwNnQohaNC0Xhy3RA
         mKLa2Y/fM5SzPORcD+6mF2IKcVm0yYUSrdFKW7+a4GSFMUP9GUyUKE3r979fELVphAon
         7Smrr3iceGFmvaZ5FoZQ63YQ3FH2i/EAZ2bHk4b/kpBrZr5MSEUCC/+Y+A0+O+6BzaTU
         MigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgY988J5MmT52aqvYksvcGCD5FJa6IhC1tvL+3Puv5o=;
        b=WTl0HphSiMLKk4QApW+1w4daty5rRyvJBPKr125myjjHYCVu++zgbLyiYGazCpHku5
         8ry3SfmVwFJMghTlOpGJ8xUZp4rku7+V4W7kIlLGV/cP45H8Yi0ceJJXMOVqSyPGBP0d
         8KFxEYRDuQq9LYlvsvigwtFvZjwClQj5exUD8p58Vj+jtLZUi5Vy20vpOviU1q3vqYMZ
         t510exASni6Xu1iMtKOMO5PTMyMfjf8D6Mk55UliXulkytbb0u87TpNkrhdDTkWO4tCJ
         XKyXE3fky77qIINTUH66s0Bl4gylWHRRm7HWCfFkbdJID4LT5PubWsDJOxbZBRn4SOxt
         Q2Uw==
X-Gm-Message-State: APjAAAVxO/xq9MHiuPArh/GLj3TQECivRmLEerZZYIzEntdxDpVkeSQz
        gXP2lkRChzJbEbeYIBabObvzHdjJuHAZNZzghGs3i+SX
X-Google-Smtp-Source: APXvYqw1MK5FSmsuONXQmrCkRY3oUgJceCGXJ6TXbL5RUTk5+LpKBSmIxb5OuYprFFLXOErGeFsmbLdYvYBUIxSgtg4=
X-Received: by 2002:a37:9cc1:: with SMTP id f184mr35404220qke.211.1555348507518;
 Mon, 15 Apr 2019 10:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <20190414201436.19502-3-christian@brauner.io>
 <20190415105209.GA22204@redhat.com> <20190415114204.ydczeuwmi74wfsuv@brauner.io>
 <20190415132416.GB22204@redhat.com>
In-Reply-To: <20190415132416.GB22204@redhat.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 15 Apr 2019 18:15:28 +0100
Message-ID: <CAGLj2rHpZ92txk2=yf7dtHFcic2H0bGB0=FzEo7w2rNpC2zxDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 2:25 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 04/15, Christian Brauner wrote:
> >
> > > CLONE_PARENT_SETTID doesn't look very usefule, so what if we add
> > >
> > >     if ((clone_flags & (CLONE_PIDFD|CLONE_PARENT_SETTID)) ==
> > >                        (CLONE_PIDFD|CLONE_PARENT_SETTID))
> > >             return ERR_PTR(-EINVAL);
> > >
> > > at the start of copy_process() ?
> > >
> > > Then it can do
> > >
> > >     if (clone_flags & CLONE_PIDFD) {
> > >             retval = pidfd_create(pid, &pidfdf);
> > >             if (retval < 0)
> > >                     goto bad_fork_free_pid;
> > >             retval = put_user(retval, parent_tidptr)
> > >             if (retval < 0)
> > >                     goto bad_fork_free_pid;
> > >     }
> >
> > Uhhh Oleg, that is nifty. I have to say I like that a lot. This would
> > let us return the pid and the pidfd in one go and we can also start
> > pidfd numbering at 0.
>
> Christian, sorry if it was already discussed, but I can't force myself to
> read all the previous discussions ;)
>
> If we forget about CONFIG_PROC_FS, why do we really want to create a file?
>
>
> Suppose we add a global u64 counter incremented by copy_process and reported
> in /proc/$pid/status. Suppose that clone(CLONE_PIDFD) writes this counter to
> *parent_tidptr. Let's denote this counter as UNIQ_PID.
>
> Now, if you want to (say) safely kill a task and you have its UNIQ_PID, you
> can do
>
>         kill_by_pid_uniq(int pid, u64 uniq_pid)
>         {
>                 pidfd = open("/proc/$pid", O_DIRECTORY);
>
>                 status = openat(pidfd, "status");
>                 u64 this_uniq_pid = ... read UNIQ_PID from status ...;
>
>                 if (uniq_pid != this_uniq_pid)
>                         return;
>
>                 pidfd_send_signal(pidfd);
>         }
>
> Why else do we want pidfd?

Apart from what others have already pointed out, there are two other
things I am looking forward to:

* Currently, when ptracing from a thread, waitpid means that I need to
block or constantly loop over with pauses to receive the ptrace
related results, since ptrace is thread directed (and to be able to
poll other event sources as well, eg. to receive further commands over
a pipe/message passing fd), and related waitpid responses only arrive
to the attached thread. The waitfd patchset was rejected on the
grounds that one could use a separate thread to do the waitpid while
polling from the attached thread or a new thread, but due to ptrace
this is false. pidfds would allow for this to work (this does mean
we'd also need to be able to return one at ATTACH/SEIZE time, though).
Note that waitid and other variants throw away a lot of needed
information.

* Descriptors mean you can optionally choose to bind your privileges
to the file descriptor and then pass it around to others. They do not
work this way now but the choice of such an extension has been kept
open. One of the examples is binding one's CAP_KILL capability and
then pass it to another process, so that it can freely signal the said
process (and only that), or be able to optionally poke holes in the
restrictions imposed by PID namespaces (possibly in the future), etc.

>
> Oleg.
>
