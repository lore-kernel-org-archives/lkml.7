Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D753D206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9+f1tvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfC3BHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:07:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33746 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfC3BHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:07:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id e5so3139883oii.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gu85X8LZN6C7oHVSet0QH8mc/kyb7PRzLWgUWMwEEQ=;
        b=F9+f1tvuteKTGXx3wfSoKKzkqUSMRgeTbOyfkY/RizGwVlq/bRNsN1BAn4UUzdJ5kL
         HnDjBe2v6m6PlffJohsupzsaag/+rm5RrfILgj96iIJV3XEyAfRz+iMZ6b3Z2+bhkLj3
         vXqpZQ+56747V4SlSRgv44cQPOoU/dYkfYJo25DrFqlq2hae0eXsSdMAYB/x9TkcoPqI
         G3TpQ2Zl01WXoYqyKwMVlu6yWEeZsASjL3k3QxnC9l9OegmGi+7pU2GPb3VEWLmiVe4N
         a2S7QFosHSWqEmCsKcf9/Rh8dbIHZSYjVfyz7O5kBbTCgO4QE9gKFZU5ssC0YTQgt80h
         o+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gu85X8LZN6C7oHVSet0QH8mc/kyb7PRzLWgUWMwEEQ=;
        b=VVKHabmcO0Ae4zVXm3PQkKxE+XfZ54aQX/VLRWuiUwHFs6HtKdE+fDAvuTlem3iY2b
         vDu8Ea8rMu2oK1VyIU0P6Vqi3DxU93bbyuvd9fK/cdCxJpzxZviB23mk+y3p+TUwXObK
         VgddVnAEgeEA16hD7lIe7RF/4bHEy9Q+1IzvFOE71IcpMR4QjWX4V6XvSY8TQDOlkW1W
         L6jvL+lwYUTTwWTtI3xDtlTOVKX8mc6Jzr43zkb+AiwGjHcURQ2eaA4M365ad3teXO1K
         nK5TbNqK8Anz8e4zTk5RTF1eDX9B9UqKuNNpxh14Nysp7H6REZpfVf4MGZyRE/9UOmHL
         1ekg==
X-Gm-Message-State: APjAAAVOmkAwh8LqxbxzagqtfnhHhrBsUIRfajwun9IFw5ZELBaq3Eq1
        33NDrzYNRsTNBaURoibrLiRoyGKn/7Qj57Gcdvcpxw==
X-Google-Smtp-Source: APXvYqyym+o6LLLxgG/MFtaj5tzWadGfEvPUtZ8tMNobZYP5LoNz5AjeJlpMtZ7hEyUEi045lmlaPozizzss2wdEAlI=
X-Received: by 2002:aca:e18b:: with SMTP id y133mr5822178oig.157.1553908020218;
 Fri, 29 Mar 2019 18:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <20190329155425.26059-5-christian@brauner.io>
In-Reply-To: <20190329155425.26059-5-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 Mar 2019 02:06:34 +0100
Message-ID: <CAG48ez0=Q2CzgTGLiEU7F9B=gS-58VrpKz2XQ369cemo2FJdbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] signal: PIDFD_SIGNAL_TID threads via pidfds
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 4:54 PM Christian Brauner <christian@brauner.io> wrote:
> With the addition of pidfd_open() it is possible for users to reference a
> specific thread by doing:
>
> int pidfd = pidfd_open(<tid>, 0);
>
> This means we can extend pidfd_send_signal() to signal a specific thread.
> As promised in the commit for pidfd_send_signal() [1] the extension is
> based on a flag argument, i.e. the scope of the signal delivery is based on
> the flag argument, not on the type of file descriptor.
> To this end the flag PIDFD_SIGNAL_TID is added. With this change we now
> cover most of the functionality of all the other signal sending functions
> combined:
[...]
> diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> index d6c7c0701997..b72f0ef84fe5 100644
> --- a/include/uapi/linux/wait.h
> +++ b/include/uapi/linux/wait.h
[...]
> +/* Flags to pass to pidfd_send_signal */
> +#define PIDFD_SIGNAL_TID 1 /* Send signal to specific thread */

nit: s/1/1U/; the flags argument is an `unsigned int`

>  #endif /* _UAPI_LINUX_WAIT_H */
> diff --git a/kernel/signal.c b/kernel/signal.c
> index eb97d0cc6ef7..9f93da85b2b9 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
[...]
> +static int pidfd_send_signal_specific(struct pid *pid, int sig,
> +                                     struct kernel_siginfo *info)
> +{
> +       struct task_struct *p;
> +       int error = -ESRCH;
> +
> +       rcu_read_lock();
> +       p = pid_task(pid, PIDTYPE_PID);
> +       if (p)
> +               error = __do_send_specific(p, sig, info);
> +       rcu_read_unlock();
> +
> +       return error;
> +}
> +
>  /**
> - * sys_pidfd_send_signal - send a signal to a process through a task file
> - *                          descriptor
> + * sys_pidfd_send_signal - send a signal to a process through a pidfd
> +
>   * @pidfd:  the file descriptor of the process
>   * @sig:    signal to be sent
>   * @info:   the signal info
>   * @flags:  future flags to be passed

nit: comment is outdated, it isn't "future flags" anymore

[...]
> + *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
> + * - pidfd_send_signal(<pidfd>, <sig>, <info>, PIDFD_SIGNAL_TID);
> + *   which is equivalent to
> + *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
> + *
>   * In order to extend the syscall to threads and process groups the @flags
>   * argument should be used. In essence, the @flags argument will determine
>   * what is signaled and not the file descriptor itself. Put in other words,

nit: again, outdated comment about @flags

[...]
> @@ -3626,43 +3695,16 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>                 prepare_kill_siginfo(sig, &kinfo);
>         }
>
> -       ret = kill_pid_info(sig, &kinfo, pid);
> +       if (flags & PIDFD_SIGNAL_TID)
> +               ret = pidfd_send_signal_specific(pid, sig, &kinfo);
> +       else
> +               ret = kill_pid_info(sig, &kinfo, pid);

nit: maybe give pidfd_send_signal_specific() and kill_pid_info() the
same signatures, since they perform similar operations with the same
argument types?

Something that was already kinda weird in the existing code, but is
getting worse with TIDs is the handling of SI_USER with siginfo.
Copying context lines from above here:

        if (info) {
                ret = copy_siginfo_from_user_any(&kinfo, info);
                if (unlikely(ret))
                        goto err;
                ret = -EINVAL;
                if (unlikely(sig != kinfo.si_signo))
                        goto err;
                if ((task_pid(current) != pid) &&
                    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
                        /* Only allow sending arbitrary signals to yourself. */
                        ret = -EPERM;
                        if (kinfo.si_code != SI_USER)
                                goto err;
                        /* Turn this into a regular kill signal. */
                        prepare_kill_siginfo(sig, &kinfo);
                }
        } else {
                prepare_kill_siginfo(sig, &kinfo);
        }

So for signals to PIDs, the rule is that if you send siginfo with
SI_USER to yourself, the siginfo is preserved; otherwise the kernel
silently clobbers it. That's already kind of weird - silent behavior
difference depending on a security check. But now, for signals to
threads, I think the result is going to be that signalling the thread
group leader preserves information, and signalling any other thread
clobbers it? If so, that seems bad.

do_rt_sigqueueinfo() seems to have the same issue, from a glance - but
there, at least the error case is just a -EPERM, not a silent behavior
difference.

Would it make sense to refuse sending siginfo with SI_USER to
non-current? If you actually want to send a normal SI_USER signal, you
can use info==NULL, right? That should create wrongness parity with
do_rt_sigqueueinfo().
To improve things further, I guess you'd have to move the comparison
against current into pidfd_send_signal_specific(), or move the task
lookup out of it, or something like that?

>  err:
>         fdput(f);
>         return ret;
>  }
[...]
