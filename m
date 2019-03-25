Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A40C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273F920850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="C6TW48uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfCYUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:05:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35561 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfCYUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:05:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so10511085wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FgoJbpKbe7uoehT1u4qcYbOxqaikPNlYaS/nKHbRffI=;
        b=C6TW48uwzvIGlTn7YwHAZ50JKhbJbXNJKpN6+j0UXbeuYbZeH9ETypPgISLIvjdtZZ
         NID3Fz3e787n0Lrmr2Dm9YUtikqMK5VmCGos/1IIEmm7/XnRkTUWyPUXOaiYPse5zzfk
         WyCOfG5u97NDrRF8hQakUEH1RCmHeEIsz/Xdl2iltpv8gNylXTBN+AE0iQaNcbS/sYKa
         11HeJuAVNtIYUCoq3Nc6zS43yYpJQd6mic2DU4tRz65w32Ei8fVEHtZvNSY6sWGEgzAn
         66fFG9fAmlSjUWXiSvo8XPGAt2HlPHk8eowjDzgLdOrMK9MrvGz8s9FQM1WXm3hqNwb0
         gcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgoJbpKbe7uoehT1u4qcYbOxqaikPNlYaS/nKHbRffI=;
        b=jZsIivjjnq5HQFYFSRnP/UBW+X6hMaT6R1ooCg4hVB0lZ2M+aiM0nnfR35ZmepeiYQ
         HkkrPr6gMWNoj96NVtAF3qVpMDmkQf4rpfXXl91iheGuX+2rMvNS/t6MN+UswRvRB5Fh
         +H44MFZpIzuf2Rw7Q2Wc58K0uNyF3pdGzDCLAF9l2vn8ya9zN4t7vvPVFQ0sJCjM8H+P
         yR2wY2uqNOV0k/QedTJj/WanfKnwbj45o1tYm4R+Pl+0YccYVCl9Cd2q3sAz9o0xVZp0
         wT7gzX4BoT2nGu8gWN+5dO3LEFGUVwJspOh4j+0NwPG0vWyCBgmS7RwYlDzyaZDZouKU
         r9rA==
X-Gm-Message-State: APjAAAU0vuleCo/6YPXpVPci1ZoKi+n0ux2RX6tXVJIJoxXBYWe1kXmh
        j6BivywRvr6TLPh1yIzbXcYJOA==
X-Google-Smtp-Source: APXvYqzM+/W1tT41Kr27DBR6AsnONzUGN4hd9zMRyTW85we3LItQuEzEbji/gvxtryR/jkh3EuOZNA==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr13475819wmc.70.1553544356137;
        Mon, 25 Mar 2019 13:05:56 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id n4sm26331668wrx.39.2019.03.25.13.05.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:05:55 -0700 (PDT)
Date:   Mon, 25 Mar 2019 21:05:54 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 3/4] signal: support pidctl() with pidfd_send_signal()
Message-ID: <20190325200552.fs4exsj3fsls7adu@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-4-christian@brauner.io>
 <CAGLj2rGTK2xLhDhBjh1wSpAiuxbLBt-AwREB5kA8LeW4JFzgsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGLj2rGTK2xLhDhBjh1wSpAiuxbLBt-AwREB5kA8LeW4JFzgsg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:28:53PM +0000, Jonathan Kowalski wrote:
> On Mon, Mar 25, 2019 at 4:21 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Let pidfd_send_signal() use pidfds retrieved via pidctl(). With this patch
> > pidfd_send_signal() becomes independent of procfs. This fullfils the
> > request made when we merged the pidfd_send_signal() patchset. The
> > pidfd_send_signal() syscall is now always available allowing for it to be
> > used by users without procfs mounted or even users without procfs support
> > compiled into the kernel.
> >
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jann Horn <jannh@google.com
> > Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
> > Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
> > Cc: "Dmitry V. Levin" <ldv@altlinux.org>
> > Cc: Andy Lutomirsky <luto@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  kernel/signal.c | 20 +++++++++-----------
> >  kernel/sys_ni.c |  3 ---
> >  2 files changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index b7953934aa99..d77183be1677 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3513,7 +3513,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
> >         return kill_something_info(sig, &info, pid);
> >  }
> >
> > -#ifdef CONFIG_PROC_FS
> >  /*
> >   * Verify that the signaler and signalee either are in the same pid namespace
> >   * or that the signaler's pid namespace is an ancestor of the signalee's pid
> > @@ -3521,16 +3520,13 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
> >   */
> >  static bool access_pidfd_pidns(struct pid *pid)
> 
> If it is agreed upon to remove the ability of using /proc/<PID> as a
> pidfd pidfd_send_signal accepts, is lifting this check acceptable?
> 
> The system call as is does not allow for a process to acquire a pidfd
> without being in an ancestor namespace or the same namespace. Thus,
> there are good reasons to allow for this to work and be able to work
> around the limitations imposed by pid namespaces if userspace
> explicitly decides to do so, by passing around the pidfd to some other
> process.

The original problem with this was - I think - that we hadn't settled
what certain values in struct siginfo_t should be set to when signaling
e.g. into ancestor pid namespaces. And if we did, we need to hook into
a widely used function in the kernel (I don't have the appropriate
thread handy atm) and we decided to punt on this until userspace really
needs this feature.

> 
> Also, you would need to translate this only once, when filling in the
> structure. The other process is bound to its pid ns as long as it is
> alive, therefore it would be simple without having to do anything
> fancy at read side (unlike unix sockets).
> 
> >  {
> > +       int ret;
> >         struct pid_namespace *active = task_active_pid_ns(current);
> >         struct pid_namespace *p = ns_of_pid(pid);
> >
> > -       for (;;) {
> > -               if (!p)
> > -                       return false;
> > -               if (p == active)
> > -                       break;
> > -               p = p->parent;
> > -       }
> > +       ret = pidnscmp(active, p);
> > +       if (ret < 0)
> > +               return false;
> >
> >         return true;
> >  }
> > @@ -3581,12 +3577,15 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >         if (flags)
> >                 return -EINVAL;
> >
> > -       f = fdget_raw(pidfd);
> > +       f = fdget(pidfd);
> >         if (!f.file)
> >                 return -EBADF;
> >
> >         /* Is this a pidfd? */
> > -       pid = tgid_pidfd_to_pid(f.file);
> > +       if (f.file->f_op == &pidfd_fops)
> > +               pid = f.file->private_data;
> > +       else
> > +               pid = tgid_pidfd_to_pid(f.file);
> >         if (IS_ERR(pid)) {
> >                 ret = PTR_ERR(pid);
> >                 goto err;
> > @@ -3625,7 +3624,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >         fdput(f);
> >         return ret;
> >  }
> > -#endif /* CONFIG_PROC_FS */
> >
> >  static int
> >  do_send_specific(pid_t tgid, pid_t pid, int sig, struct kernel_siginfo *info)
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index d21f4befaea4..4d9ae5ea6caf 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -167,9 +167,6 @@ COND_SYSCALL(syslog);
> >
> >  /* kernel/sched/core.c */
> >
> > -/* kernel/signal.c */
> > -COND_SYSCALL(pidfd_send_signal);
> > -
> >  /* kernel/sys.c */
> >  COND_SYSCALL(setregid);
> >  COND_SYSCALL(setgid);
> > --
> > 2.21.0
> >
