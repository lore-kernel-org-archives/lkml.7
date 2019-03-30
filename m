Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59529C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C18E20811
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VDKKojFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfC3BWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:22:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45454 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfC3BWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:22:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so3513863edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uAxXVF4d84cSnS42+0/Wy6BQeKAXk0hqm8kgCyxTpM=;
        b=VDKKojFDuQO4YCecNO0vNgAd6mfZV04QVtOA69m1advtLJQicZsKKYN5IXq9p//WHR
         nZAJ7KuwAhJxPQgsrzcCjs5cE4/Ar1hjwAUDS54NZhLV6fiXAgGV1A2GSwMPTj0DpnSr
         0/30/UrYLNDe1vMVFaN0oHMJ/JeBGj3W5CtLLW8Dmfx34VKi1NpyJWr4MdCuCU/4Bqzh
         plPoEP6yW2dZQlE4v2dMAzgJBuX3bOM4YPabTj13gFAEkanl4PC21LsRI49UMNMZG/mh
         1Bg8WPBXVJJzjDLIaqgKX1ZmpW7zTe/eLZClSlRUN/8z5/0e52KvVzgdZgYFh0osIv5p
         GHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uAxXVF4d84cSnS42+0/Wy6BQeKAXk0hqm8kgCyxTpM=;
        b=LZpIFNR6qESDM3WqElQ1Noqd19xkcmYDP3GJXPt3pzy1RKZbdmHWhABQ2XY5VVevXn
         7tIUtD2vCKtoCbRYqhB3FQBx4RsFt/B5T36oVQ6vGnew+jtwOVieUpquMhsvVtJxBH+h
         /HaI0VXMT6AGjnXKTj9tIKnZpxNoh3HrctLbPNITU/mQvWU9UI2fg3Y/OfPB6SfswgJM
         Oc3Pr/TJYH6jYHuZRoCrJKYmHYcl26w28V6sJkOhpwTqXoQpRqs2JXDj005KGg4rIj/a
         8kMMajLYmCRiwO9Rb6mgxiC7NqrfLtI77svtVRyY4VRI+bjeGgIDwvWOE5/Kla2gg0y0
         Va1Q==
X-Gm-Message-State: APjAAAWG5k3uWPbi2x2G9N9FXJ0AS3BeQyyddh+Vrwsx/GtWYZWWpY0+
        KY2q0G+onogj1+n2KKtC0ZVcPw==
X-Google-Smtp-Source: APXvYqzEgcyioVv6aLGfQjZ7ABMvCQ8lFz5EiJsHj5vUJ+sV3dez0ej+dwh4J6JgJVFGX2q2e568ag==
X-Received: by 2002:a50:a4db:: with SMTP id x27mr13309215edb.120.1553908953509;
        Fri, 29 Mar 2019 18:22:33 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id q45sm1057320edd.88.2019.03.29.18.22.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 18:22:32 -0700 (PDT)
Date:   Sat, 30 Mar 2019 02:22:31 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH v2 4/5] signal: PIDFD_SIGNAL_TID threads via pidfds
Message-ID: <20190330012229.yt3hecmgaj2r6vp7@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <20190329155425.26059-5-christian@brauner.io>
 <CAG48ez0=Q2CzgTGLiEU7F9B=gS-58VrpKz2XQ369cemo2FJdbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0=Q2CzgTGLiEU7F9B=gS-58VrpKz2XQ369cemo2FJdbQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 02:06:34AM +0100, Jann Horn wrote:
> On Fri, Mar 29, 2019 at 4:54 PM Christian Brauner <christian@brauner.io> wrote:
> > With the addition of pidfd_open() it is possible for users to reference a
> > specific thread by doing:
> >
> > int pidfd = pidfd_open(<tid>, 0);
> >
> > This means we can extend pidfd_send_signal() to signal a specific thread.
> > As promised in the commit for pidfd_send_signal() [1] the extension is
> > based on a flag argument, i.e. the scope of the signal delivery is based on
> > the flag argument, not on the type of file descriptor.
> > To this end the flag PIDFD_SIGNAL_TID is added. With this change we now
> > cover most of the functionality of all the other signal sending functions
> > combined:
> [...]
> > diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> > index d6c7c0701997..b72f0ef84fe5 100644
> > --- a/include/uapi/linux/wait.h
> > +++ b/include/uapi/linux/wait.h
> [...]
> > +/* Flags to pass to pidfd_send_signal */
> > +#define PIDFD_SIGNAL_TID 1 /* Send signal to specific thread */
> 
> nit: s/1/1U/; the flags argument is an `unsigned int`

Will change.

> 
> >  #endif /* _UAPI_LINUX_WAIT_H */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index eb97d0cc6ef7..9f93da85b2b9 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> [...]
> > +static int pidfd_send_signal_specific(struct pid *pid, int sig,
> > +                                     struct kernel_siginfo *info)
> > +{
> > +       struct task_struct *p;
> > +       int error = -ESRCH;
> > +
> > +       rcu_read_lock();
> > +       p = pid_task(pid, PIDTYPE_PID);
> > +       if (p)
> > +               error = __do_send_specific(p, sig, info);
> > +       rcu_read_unlock();
> > +
> > +       return error;
> > +}
> > +
> >  /**
> > - * sys_pidfd_send_signal - send a signal to a process through a task file
> > - *                          descriptor
> > + * sys_pidfd_send_signal - send a signal to a process through a pidfd
> > +
> >   * @pidfd:  the file descriptor of the process
> >   * @sig:    signal to be sent
> >   * @info:   the signal info
> >   * @flags:  future flags to be passed
> 
> nit: comment is outdated, it isn't "future flags" anymore

Will remove.

> 
> [...]
> > + *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
> > + * - pidfd_send_signal(<pidfd>, <sig>, <info>, PIDFD_SIGNAL_TID);
> > + *   which is equivalent to
> > + *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
> > + *
> >   * In order to extend the syscall to threads and process groups the @flags
> >   * argument should be used. In essence, the @flags argument will determine
> >   * what is signaled and not the file descriptor itself. Put in other words,
> 
> nit: again, outdated comment about @flags

Will update.

> 
> [...]
> > @@ -3626,43 +3695,16 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >                 prepare_kill_siginfo(sig, &kinfo);
> >         }
> >
> > -       ret = kill_pid_info(sig, &kinfo, pid);
> > +       if (flags & PIDFD_SIGNAL_TID)
> > +               ret = pidfd_send_signal_specific(pid, sig, &kinfo);
> > +       else
> > +               ret = kill_pid_info(sig, &kinfo, pid);
> 
> nit: maybe give pidfd_send_signal_specific() and kill_pid_info() the
> same signatures, since they perform similar operations with the same
> argument types?

Yes, let's do
pidfd_send_signal_specific.(pid, sig, &kinfo);
kill_pid_info..............(pid, sig, &kinfo);

so it matches the argument order of the syscalls itself too.

> 
> Something that was already kinda weird in the existing code, but is
> getting worse with TIDs is the handling of SI_USER with siginfo.

Right, that's what we discussed earlier.

> Copying context lines from above here:
> 
>         if (info) {
>                 ret = copy_siginfo_from_user_any(&kinfo, info);
>                 if (unlikely(ret))
>                         goto err;
>                 ret = -EINVAL;
>                 if (unlikely(sig != kinfo.si_signo))
>                         goto err;
>                 if ((task_pid(current) != pid) &&
>                     (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
>                         /* Only allow sending arbitrary signals to yourself. */
>                         ret = -EPERM;
>                         if (kinfo.si_code != SI_USER)
>                                 goto err;
>                         /* Turn this into a regular kill signal. */
>                         prepare_kill_siginfo(sig, &kinfo);
>                 }
>         } else {
>                 prepare_kill_siginfo(sig, &kinfo);
>         }
> 
> So for signals to PIDs, the rule is that if you send siginfo with
> SI_USER to yourself, the siginfo is preserved; otherwise the kernel
> silently clobbers it. That's already kind of weird - silent behavior

Clobbers as in "silently replaces it whatever it seems fit?

> difference depending on a security check. But now, for signals to
> threads, I think the result is going to be that signalling the thread
> group leader preserves information, and signalling any other thread
> clobbers it? If so, that seems bad.
> 
> do_rt_sigqueueinfo() seems to have the same issue, from a glance - but
> there, at least the error case is just a -EPERM, not a silent behavior
> difference.
> 
> Would it make sense to refuse sending siginfo with SI_USER to
> non-current? If you actually want to send a normal SI_USER signal, you

Yeah.

> can use info==NULL, right? That should create wrongness parity with
> do_rt_sigqueueinfo().

So you'd just do (just doing it non-elegantly rn):
if ((task_pid(current) != pid) &&
    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
        ret = -EPERM;
        goto err;
}

> To improve things further, I guess you'd have to move the comparison
> against current into pidfd_send_signal_specific(), or move the task
> lookup out of it, or something like that?

Looks like a sane suggestion to me. Would you care to send a patch for
that? This is clearly a bugfix suitable for 5.1 so I'd rather not wait
until 5.2.
