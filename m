Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF55B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XssX3fXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfCYS3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:29:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:29:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so11513444qte.6;
        Mon, 25 Mar 2019 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OilUMnuvpwerGF1P1n/iRsvUrgIy7wan47v/puY8SbI=;
        b=XssX3fXVFVx32lbT0MzCUJGqKtvsTJiOVrZQucRbXHF4FQGgt9J4/4Jck9DuDKL5eb
         cSeMxmgXE6BY/N9/fZQc8BunKVx127PdLm0930EqkNvoiHlFh3cLkLGzP1lQVUNH9t5E
         4tH7UdEOMW9HanSTO9WBRO5ZvJlJzC229RxPvfkQeXFyWSBOqPbRa0y1oORiDnaEISDN
         6OVZe0a1pD3HirGrkU9tCONItGHsBzwfuRcPpVIaMlQVYcLJfJ3mAOevUFc2d9dadcUw
         6AKJZ8PZTQyUw3ywNJ9Gdp3glsSwlWyA8sthITlJ028qfsiLRrkSV1t1M4u5GDU24/Fp
         VpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OilUMnuvpwerGF1P1n/iRsvUrgIy7wan47v/puY8SbI=;
        b=hNAvocoIdMcMtuF19CbiDD2HWEmpVJQxmC2Qe8bhTUfWyyts6OKcpfsQ+pG89L7UGD
         ZVpI01up5471GULK47c5neSK/ncY0lJloZenYXC+084RZGVr3r08iYnfyGnGfCpNvg9n
         m/46pWqHbR3rdri///vHIEJCML52jUewgKaFzRYfFJy2lM2+vvXC3HejxwkL8jQawl4D
         moUiSadh6cOtknZYRF1BiQpEE8EUyheKdUzD+N1tjGJ2eGnooAVaE0TGN9rfuhKgVjWv
         OBf8IZR21Aoa0HEGqi9hx8AS7+L8Q0CUKQQJx6BfpDHXPWObmj7hg9wnUWVAiTvmyT3n
         nfEA==
X-Gm-Message-State: APjAAAXxtBMjz9m/YJX3KSFg6VZ11QkCduFn1g9ZYZ1zVIIafFP/lixT
        SG6lQk6ukO7V2Y/mPmUN2W4usuE7uSy/J4zmASo=
X-Google-Smtp-Source: APXvYqw/DmDuQjJNCYLW0wriesn3geMo4I8swDcIKTUhzwgCakHOHTH40NggBBpWv1IIVBAaBqV610OoCtBketutDA4=
X-Received: by 2002:ac8:2230:: with SMTP id o45mr21218157qto.111.1553538547097;
 Mon, 25 Mar 2019 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <20190325162052.28987-4-christian@brauner.io>
In-Reply-To: <20190325162052.28987-4-christian@brauner.io>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 18:28:53 +0000
Message-ID: <CAGLj2rGTK2xLhDhBjh1wSpAiuxbLBt-AwREB5kA8LeW4JFzgsg@mail.gmail.com>
Subject: Re: [PATCH 3/4] signal: support pidctl() with pidfd_send_signal()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 4:21 PM Christian Brauner <christian@brauner.io> wrote:
>
> Let pidfd_send_signal() use pidfds retrieved via pidctl(). With this patch
> pidfd_send_signal() becomes independent of procfs. This fullfils the
> request made when we merged the pidfd_send_signal() patchset. The
> pidfd_send_signal() syscall is now always available allowing for it to be
> used by users without procfs mounted or even users without procfs support
> compiled into the kernel.
>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jann Horn <jannh@google.com
> Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
> Cc: "Dmitry V. Levin" <ldv@altlinux.org>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/signal.c | 20 +++++++++-----------
>  kernel/sys_ni.c |  3 ---
>  2 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b7953934aa99..d77183be1677 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3513,7 +3513,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
>         return kill_something_info(sig, &info, pid);
>  }
>
> -#ifdef CONFIG_PROC_FS
>  /*
>   * Verify that the signaler and signalee either are in the same pid namespace
>   * or that the signaler's pid namespace is an ancestor of the signalee's pid
> @@ -3521,16 +3520,13 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
>   */
>  static bool access_pidfd_pidns(struct pid *pid)

If it is agreed upon to remove the ability of using /proc/<PID> as a
pidfd pidfd_send_signal accepts, is lifting this check acceptable?

The system call as is does not allow for a process to acquire a pidfd
without being in an ancestor namespace or the same namespace. Thus,
there are good reasons to allow for this to work and be able to work
around the limitations imposed by pid namespaces if userspace
explicitly decides to do so, by passing around the pidfd to some other
process.

Also, you would need to translate this only once, when filling in the
structure. The other process is bound to its pid ns as long as it is
alive, therefore it would be simple without having to do anything
fancy at read side (unlike unix sockets).

>  {
> +       int ret;
>         struct pid_namespace *active = task_active_pid_ns(current);
>         struct pid_namespace *p = ns_of_pid(pid);
>
> -       for (;;) {
> -               if (!p)
> -                       return false;
> -               if (p == active)
> -                       break;
> -               p = p->parent;
> -       }
> +       ret = pidnscmp(active, p);
> +       if (ret < 0)
> +               return false;
>
>         return true;
>  }
> @@ -3581,12 +3577,15 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>         if (flags)
>                 return -EINVAL;
>
> -       f = fdget_raw(pidfd);
> +       f = fdget(pidfd);
>         if (!f.file)
>                 return -EBADF;
>
>         /* Is this a pidfd? */
> -       pid = tgid_pidfd_to_pid(f.file);
> +       if (f.file->f_op == &pidfd_fops)
> +               pid = f.file->private_data;
> +       else
> +               pid = tgid_pidfd_to_pid(f.file);
>         if (IS_ERR(pid)) {
>                 ret = PTR_ERR(pid);
>                 goto err;
> @@ -3625,7 +3624,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>         fdput(f);
>         return ret;
>  }
> -#endif /* CONFIG_PROC_FS */
>
>  static int
>  do_send_specific(pid_t tgid, pid_t pid, int sig, struct kernel_siginfo *info)
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index d21f4befaea4..4d9ae5ea6caf 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -167,9 +167,6 @@ COND_SYSCALL(syslog);
>
>  /* kernel/sched/core.c */
>
> -/* kernel/signal.c */
> -COND_SYSCALL(pidfd_send_signal);
> -
>  /* kernel/sys.c */
>  COND_SYSCALL(setregid);
>  COND_SYSCALL(setgid);
> --
> 2.21.0
>
