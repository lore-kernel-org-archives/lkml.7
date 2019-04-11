Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082092173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yab0OJV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDKPSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:18:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so7173061wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfEK8JoLnvAlTYEmh21BcBw02CXXgGJ+pRY212fyXL4=;
        b=Yab0OJV0hfZlGhVyhQz2zWocwjswsQTgaw86r5tDsLSMTmwgtOkRI/qA3UFkflzIjy
         gBezNvRpXWgtbn9dFGopyDj+JpT0S/7HQDn0nNsC4tNybXyZlI+l/U7K9CSPgBV9ic+o
         Ld+hPMuncJTInlNHvyGKOQQa5metvW0TK1Z1OdCkcUP0uMW3VURKry6YGh/v61dMdKt1
         riKa0SP8oNoSUbHRwThtjcXZmFrTys2XkCt7BNTrGPOzt6f1UHWbLvbCsxxKqPWYdapH
         n8+hjdawuSnEbuCEYTeKmCrsxkg9KC8MptIXKXzI5LUw//THa2KbIMurdsWBhnmcMmGt
         +yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfEK8JoLnvAlTYEmh21BcBw02CXXgGJ+pRY212fyXL4=;
        b=BxZSMK+EMf7bFtUaS5Dq74kplauXUvOpxTncip+k57ma+Sx/b8PqStBk5rvJ28x5ZT
         l6W+NNAiPnU/K9ZLVy+Ni2LM1yNaqGw+GhCXHwfiPAMQ9AZOn+F0qigOeZ8b1TBIQcvM
         QuUNwjMKvMETKakxDFW4qDiMJl9qyO/4gBaaF1cvKHQr6uBMeEbswnjNuroGv02cCPOD
         NFg/iWW6oZozVTEqpZpCz4W8SxDaKuGU5AwipB/T5jUUWYOEzLZY7V2fPU8YexmsIOn1
         5UEBr3rTaAkWdrw/JgDY5Cdvf8laQbIG1GFU2kQ0RvxSiFQL8+3ZfU13DjAEPhzyJ+iB
         HLqA==
X-Gm-Message-State: APjAAAWFwBmJ2Pa+iavuER4oumi56fnwKz40tDkKKyFk/YDvZ1rel/uo
        5oanBxecu3b1S0ZRIL9uRRG9bsen0FzS1tnQX2T3vQ==
X-Google-Smtp-Source: APXvYqwXz2rkMapEv1YNphBoRYrg5AYN2B8owq1UP/71hpxEPcnWFIDc4qPw2tlXxwP3LIM7mt4qTdXlcor5Gl8qzFg=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr6956266wma.91.1554995921942;
 Thu, 11 Apr 2019 08:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411103018.tcsinifuj7klh6rp@brauner.io>
In-Reply-To: <20190411103018.tcsinifuj7klh6rp@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 08:18:30 -0700
Message-ID: <CAJuCfpE4BsUHUZp_5XzSYrXbampFwOZoJ-XYp2iZtT6vqSEruQ@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        ebiederm@xmission.com, Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!
Just to be clear, this implementation is used in this RFC as a
reference to explain the intent. To be honest I don't think it will be
adopted as is even if the idea survives scrutiny.

On Thu, Apr 11, 2019 at 3:30 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > victim process. The usage of this flag is currently limited to SIGKILL
> > signal and only to privileged users.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/sched/signal.h |  3 ++-
> >  include/linux/signal.h       | 11 ++++++++++-
> >  ipc/mqueue.c                 |  2 +-
> >  kernel/signal.c              | 37 ++++++++++++++++++++++++++++--------
> >  kernel/time/itimer.c         |  2 +-
> >  5 files changed, 43 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> > index e412c092c1e8..8a227633a058 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -327,7 +327,8 @@ extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
> >  extern void force_sigsegv(int sig, struct task_struct *p);
> >  extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
> >  extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
> > -extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
> > +extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid,
> > +                             bool expedite);
> >  extern int kill_pid_info_as_cred(int, struct kernel_siginfo *, struct pid *,
> >                               const struct cred *);
> >  extern int kill_pgrp(struct pid *pid, int sig, int priv);
> > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > index 9702016734b1..34b7852aa4a0 100644
> > --- a/include/linux/signal.h
> > +++ b/include/linux/signal.h
> > @@ -446,8 +446,17 @@ int __save_altstack(stack_t __user *, unsigned long);
> >  } while (0);
> >
> >  #ifdef CONFIG_PROC_FS
> > +
> > +/*
> > + * SS_FLAGS values used in pidfd_send_signal:
> > + *
> > + * SS_EXPEDITE indicates desire to expedite the operation.
> > + */
> > +#define SS_EXPEDITE  0x00000001
>
> Does this make sense as an SS_* flag?
> How does this relate to the signal stack?

It doesn't, so I agree that the name should be changed.
PIDFD_SIGNAL_EXPEDITE_MM_RECLAIM would seem appropriate.

> Is there any intention to ever use this flag with stack_t?
>
> New flags should be PIDFD_SIGNAL_*. (E.g. the thread flag will be
> PIDFD_SIGNAL_THREAD.)
> And since this is exposed to userspace in contrast to the mm internal
> naming it should be something more easily understandable like
> PIDFD_SIGNAL_MM_RECLAIM{_FASTER} or something.
>
> > +
> >  struct seq_file;
> >  extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
> > -#endif
> > +
> > +#endif /* CONFIG_PROC_FS */
> >
> >  #endif /* _LINUX_SIGNAL_H */
> > diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> > index aea30530c472..27c66296e08e 100644
> > --- a/ipc/mqueue.c
> > +++ b/ipc/mqueue.c
> > @@ -720,7 +720,7 @@ static void __do_notify(struct mqueue_inode_info *info)
> >                       rcu_read_unlock();
> >
> >                       kill_pid_info(info->notify.sigev_signo,
> > -                                   &sig_i, info->notify_owner);
> > +                                   &sig_i, info->notify_owner, false);
> >                       break;
> >               case SIGEV_THREAD:
> >                       set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index f98448cf2def..02ed4332d17c 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/posix-timers.h>
> >  #include <linux/livepatch.h>
> > +#include <linux/oom.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/signal.h>
> > @@ -1394,7 +1395,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
> >       return success ? 0 : retval;
> >  }
> >
> > -int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> > +int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid,
> > +                               bool expedite)
> >  {
> >       int error = -ESRCH;
> >       struct task_struct *p;
> > @@ -1402,8 +1404,17 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> >       for (;;) {
> >               rcu_read_lock();
> >               p = pid_task(pid, PIDTYPE_PID);
> > -             if (p)
> > +             if (p) {
> >                       error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
> > +
> > +                     /*
> > +                      * Ignore expedite_reclaim return value, it is best
> > +                      * effort only.
> > +                      */
> > +                     if (!error && expedite)
> > +                             expedite_reclaim(p);
>
> SIGKILL will take the whole thread group down so the reclaim should make
> sense here.
>

This sounds like confirmation. I hope I'm not missing some flaw that
you are trying to point out.

> > +             }
> > +
> >               rcu_read_unlock();
> >               if (likely(!p || error != -ESRCH))
> >                       return error;
> > @@ -1420,7 +1431,7 @@ static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
> >  {
> >       int error;
> >       rcu_read_lock();
> > -     error = kill_pid_info(sig, info, find_vpid(pid));
> > +     error = kill_pid_info(sig, info, find_vpid(pid), false);
> >       rcu_read_unlock();
> >       return error;
> >  }
> > @@ -1487,7 +1498,7 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
> >
> >       if (pid > 0) {
> >               rcu_read_lock();
> > -             ret = kill_pid_info(sig, info, find_vpid(pid));
> > +             ret = kill_pid_info(sig, info, find_vpid(pid), false);
> >               rcu_read_unlock();
> >               return ret;
> >       }
> > @@ -1704,7 +1715,7 @@ EXPORT_SYMBOL(kill_pgrp);
> >
> >  int kill_pid(struct pid *pid, int sig, int priv)
> >  {
> > -     return kill_pid_info(sig, __si_special(priv), pid);
> > +     return kill_pid_info(sig, __si_special(priv), pid, false);
> >  }
> >  EXPORT_SYMBOL(kill_pid);
> >
> > @@ -3577,10 +3588,20 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >       struct pid *pid;
> >       kernel_siginfo_t kinfo;
> >
> > -     /* Enforce flags be set to 0 until we add an extension. */
> > -     if (flags)
> > +     /* Enforce no unknown flags. */
> > +     if (flags & ~SS_EXPEDITE)
> >               return -EINVAL;
> >
> > +     if (flags & SS_EXPEDITE) {
> > +             /* Enforce SS_EXPEDITE to be used with SIGKILL only. */
> > +             if (sig != SIGKILL)
> > +                     return -EINVAL;
>
> Not super fond of this being a SIGKILL specific flag but I get why.

Understood. I was thinking that EXPEDITE flag might make sense for
other signals in the future but from internal feedback sounds like if
we go this way the flag name should be more specific.

> > +
> > +             /* Limit expedited killing to privileged users only. */
> > +             if (!capable(CAP_SYS_NICE))
> > +                     return -EPERM;
>
> Do you have a specific (DOS or other) attack vector in mind that renders
> ns_capable unsuitable?
>
> > +     }
> > +
> >       f = fdget_raw(pidfd);
> >       if (!f.file)
> >               return -EBADF;
> > @@ -3614,7 +3635,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >               prepare_kill_siginfo(sig, &kinfo);
> >       }
> >
> > -     ret = kill_pid_info(sig, &kinfo, pid);
> > +     ret = kill_pid_info(sig, &kinfo, pid, (flags & SS_EXPEDITE) != 0);
> >
> >  err:
> >       fdput(f);
> > diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
> > index 02068b2d5862..c926483cdb53 100644
> > --- a/kernel/time/itimer.c
> > +++ b/kernel/time/itimer.c
> > @@ -140,7 +140,7 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
> >       struct pid *leader_pid = sig->pids[PIDTYPE_TGID];
> >
> >       trace_itimer_expire(ITIMER_REAL, leader_pid, 0);
> > -     kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid);
> > +     kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid, false);
> >
> >       return HRTIMER_NORESTART;
> >  }
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
