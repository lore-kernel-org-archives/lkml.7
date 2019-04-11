Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB655C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E022075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WR7cmCux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKKeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:34:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40081 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:34:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so4746959edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SLtwlQnsi2lxcF6BSEB1RE69e3LNi43QlxoMz0lcnyM=;
        b=WR7cmCuxaqUTW3U8NCvm3nHG1pEljHfaby69xQf7Yzpfr6r72pl0gd7FUC5bNIXWAr
         Lkb52vpBxGi0q0E1vCBrHjrwd97EqS3DUUqpzYX3P/fFCqsbyl/imgNs+VHbiNkdlslg
         V/yywiCR4LWDNPIuTrXdE8hnXTBn7GT0EmZM4tQsZTT5Htt2rw78Mqwezbw3etngp1MB
         V4xleOURfQF2S0QRBXQBFmYMFxfQ1UYskDWKPyBqZ77tE6a9UxiSIgFtqBO0s/m8mQ7N
         B62XNWDenkl0iaEFES/inbg7cx7fFzOJpE3EMU+KmZHAMuWksB7YDB7I9UwQ1/niTvEf
         eNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SLtwlQnsi2lxcF6BSEB1RE69e3LNi43QlxoMz0lcnyM=;
        b=OcXPEnoBJBFW6zrFjrb5k4C+l+XYqCLuvBoYasQ0NxCejBZGwEcq7YlH6ccJfXG1f/
         wUowvjIEF0HokFb1WXyj5QN9QkATLFX9R3fxQsXFvbvxvdOE/CkOIc4upKmPb8cRcrfQ
         90CyF4Mp4YXt/TcexiMEenZgM9YL+Sx91pGpVnzuOAocRU4Yb5RzyA/UddVq1tevbMkD
         HlBR0CYQws+xoHP1sbgLsVyPtl5J4GOZICQmpiqI1UIBaOvx+U2LSs1ijo8UE7iq7+HV
         3M4vNwq2sgpQC8eVWYUdsZ+liBvbnr+3uyE5z+m9vNjrOFgR1ZRIQzEvHNY8Q3Ns1Vad
         8wow==
X-Gm-Message-State: APjAAAX7u/VsvsjoU3+BLIAzbWlj/tbknMcLZczH0XhYkBxxLdaao575
        tgChzL1lr5unjVvZu+OHRwp/Zg==
X-Google-Smtp-Source: APXvYqwA6LgvLM60i09zDdeKKwXX937omKO+V0ZH1k2dUoOGwbesknRoF0Nc2lHHpaDhrf2UXCInCg==
X-Received: by 2002:a50:93a6:: with SMTP id o35mr31398796eda.245.1554978850611;
        Thu, 11 Apr 2019 03:34:10 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id h16sm2378946edq.73.2019.04.11.03.34.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Apr 2019 03:34:10 -0700 (PDT)
Date:   Thu, 11 Apr 2019 12:34:08 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, yuzhoujian@didichuxing.com,
        jrdr.linux@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, minchan@kernel.org, timmurray@google.com,
        dancol@google.com, joel@joelfernandes.org, jannh@google.com,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        oleg@redhat.com
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
Message-ID: <20190411103407.67zdy5zzp7lsyaa4@brauner.io>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
 <20190411103018.tcsinifuj7klh6rp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411103018.tcsinifuj7klh6rp@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Oleg too

On Thu, Apr 11, 2019 at 12:30:18PM +0200, Christian Brauner wrote:
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
> > +				bool expedite);
> >  extern int kill_pid_info_as_cred(int, struct kernel_siginfo *, struct pid *,
> >  				const struct cred *);
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
> > +#define SS_EXPEDITE	0x00000001
> 
> Does this make sense as an SS_* flag?
> How does this relate to the signal stack?
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
> >  			rcu_read_unlock();
> >  
> >  			kill_pid_info(info->notify.sigev_signo,
> > -				      &sig_i, info->notify_owner);
> > +				      &sig_i, info->notify_owner, false);
> >  			break;
> >  		case SIGEV_THREAD:
> >  			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
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
> >  	return success ? 0 : retval;
> >  }
> >  
> > -int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> > +int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid,
> > +				  bool expedite)
> >  {
> >  	int error = -ESRCH;
> >  	struct task_struct *p;
> > @@ -1402,8 +1404,17 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> >  	for (;;) {
> >  		rcu_read_lock();
> >  		p = pid_task(pid, PIDTYPE_PID);
> > -		if (p)
> > +		if (p) {
> >  			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
> > +
> > +			/*
> > +			 * Ignore expedite_reclaim return value, it is best
> > +			 * effort only.
> > +			 */
> > +			if (!error && expedite)
> > +				expedite_reclaim(p);
> 
> SIGKILL will take the whole thread group down so the reclaim should make
> sense here.
> 
> > +		}
> > +
> >  		rcu_read_unlock();
> >  		if (likely(!p || error != -ESRCH))
> >  			return error;
> > @@ -1420,7 +1431,7 @@ static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
> >  {
> >  	int error;
> >  	rcu_read_lock();
> > -	error = kill_pid_info(sig, info, find_vpid(pid));
> > +	error = kill_pid_info(sig, info, find_vpid(pid), false);
> >  	rcu_read_unlock();
> >  	return error;
> >  }
> > @@ -1487,7 +1498,7 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
> >  
> >  	if (pid > 0) {
> >  		rcu_read_lock();
> > -		ret = kill_pid_info(sig, info, find_vpid(pid));
> > +		ret = kill_pid_info(sig, info, find_vpid(pid), false);
> >  		rcu_read_unlock();
> >  		return ret;
> >  	}
> > @@ -1704,7 +1715,7 @@ EXPORT_SYMBOL(kill_pgrp);
> >  
> >  int kill_pid(struct pid *pid, int sig, int priv)
> >  {
> > -	return kill_pid_info(sig, __si_special(priv), pid);
> > +	return kill_pid_info(sig, __si_special(priv), pid, false);
> >  }
> >  EXPORT_SYMBOL(kill_pid);
> >  
> > @@ -3577,10 +3588,20 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  	struct pid *pid;
> >  	kernel_siginfo_t kinfo;
> >  
> > -	/* Enforce flags be set to 0 until we add an extension. */
> > -	if (flags)
> > +	/* Enforce no unknown flags. */
> > +	if (flags & ~SS_EXPEDITE)
> >  		return -EINVAL;
> >  
> > +	if (flags & SS_EXPEDITE) {
> > +		/* Enforce SS_EXPEDITE to be used with SIGKILL only. */
> > +		if (sig != SIGKILL)
> > +			return -EINVAL;
> 
> Not super fond of this being a SIGKILL specific flag but I get why.
> 
> > +
> > +		/* Limit expedited killing to privileged users only. */
> > +		if (!capable(CAP_SYS_NICE))
> > +			return -EPERM;
> 
> Do you have a specific (DOS or other) attack vector in mind that renders
> ns_capable unsuitable?
> 
> > +	}
> > +
> >  	f = fdget_raw(pidfd);
> >  	if (!f.file)
> >  		return -EBADF;
> > @@ -3614,7 +3635,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  		prepare_kill_siginfo(sig, &kinfo);
> >  	}
> >  
> > -	ret = kill_pid_info(sig, &kinfo, pid);
> > +	ret = kill_pid_info(sig, &kinfo, pid, (flags & SS_EXPEDITE) != 0);
> >  
> >  err:
> >  	fdput(f);
> > diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
> > index 02068b2d5862..c926483cdb53 100644
> > --- a/kernel/time/itimer.c
> > +++ b/kernel/time/itimer.c
> > @@ -140,7 +140,7 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
> >  	struct pid *leader_pid = sig->pids[PIDTYPE_TGID];
> >  
> >  	trace_itimer_expire(ITIMER_REAL, leader_pid, 0);
> > -	kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid);
> > +	kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid, false);
> >  
> >  	return HRTIMER_NORESTART;
> >  }
> > -- 
> > 2.21.0.392.gf8f6787159e-goog
> > 
