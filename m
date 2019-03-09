Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2107207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QzgBmLnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCITWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:22:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44268 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCITWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:22:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so753897edw.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kvxd+scmXz0MzF284uOfPySE7SNrv3x+7LNon9D3Zg8=;
        b=QzgBmLnFfxuj3eXdmp2jyOkf7jr/tDCT8wzx0GxX7cLv47vh4bBu3GE3J6iXYl3whO
         RIj/p/UjBpZxuPLDOyRbzgF9zLTFX/ft0CVoJ16SNtKC3KsPWj3MINnyRXyf8H2wAC8P
         /hB2sQ7qJZzktvda/V7lvIe/DXMuuN4FkqoCqKiomwyXrGJ7tvDX+uKGt28EVTQLNUSA
         CpcTaFE4JTq219Fn+5KuWEhNvrx6xBNJlEsezT1E4cGb8xjtVQYTkVtFbD/eza/4DsaN
         hXy5FyMOfei12dzFXi7HJDzNJll5bwtUsJaQoTNPaUmIGavnawIzsmi+hRpzakEOVrk6
         7fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kvxd+scmXz0MzF284uOfPySE7SNrv3x+7LNon9D3Zg8=;
        b=faiw5GnHOwqrDgs7VXBEJQJfCPM17/EHMyiUypFl8UEn/LOfT/ldQzTgLVxh89R1rD
         oacvtlpHBWpHsvRZFCZ72K4hLrjXTrGl/sPkSA/UVpOUAGTrt5m24Ywlmer4OxGCESJn
         Sr1CTGawN1vAbehzuqVWBhd9QNpf+mejeCWwe7gujvMAzJKj8HXaj2rBXPZXL0ztnKQB
         UkN8qaDpkq4A0OFM3W9F6PIjieCKM7aAwYcvjq3+BbpWM6csl7N3ZrV8aK+LAFPHRDck
         7Smn9d61dhZS1PT1xI1grXfg2ntnm1aciB88rG1mY58NSjmuQZhjSpMUlGZyWgUhiize
         4cnA==
X-Gm-Message-State: APjAAAWI+MoxrggImaMIYwx560JgOrwEZ4UNniY+c0jmJkwmM2/uAE4/
        R0Q1V1+RSLzJisdJyYaYzGQp3w==
X-Google-Smtp-Source: APXvYqyMzLcZjXe0FMxDSF2qNxUdyV7KWhYx3on7089p+owR7KggPqpeVqLFuOH5IhAr6p7SM+xihg==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr16090334eji.26.1552159365798;
        Sat, 09 Mar 2019 11:22:45 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id 36sm3220017edz.58.2019.03.09.11.22.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 09 Mar 2019 11:22:45 -0800 (PST)
Date:   Sat, 9 Mar 2019 20:22:44 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        torvalds@linux-foundation.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        arnd@arndb.de, Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] pidfd patches for v5.1-rc1
Message-ID: <20190309192243.m6etvhb4qpeyhrzq@brauner.io>
References: <20190305171301.23147-1-christian@brauner.io>
 <20190306100713.09b519ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306100713.09b519ea@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:07:13AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue,  5 Mar 2019 18:13:01 +0100 Christian Brauner <christian@brauner.io> wrote:
> >
> > This is the first direct pr I had to send so I hope I didn't make any
> > horrible mistakes.
> 
> One thing: you probably should have mentioned that these changes
> conflict with changes in the block and tip trees:

Ah, apparently I didn't make this clear enough in the PR message: Arnd,
Jens, and I aligned the three PRs wrt to the syscall numbers to minimize
merge conflicts. 424 for this one and 425-427 for Jens' io_uring
syscalls. There will still be a minor conflict resulting from this that
hopefully should be easy to fix. I hope that's ok.

Christian

> 
> > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the pidfd tree got conflicts in:
> > > 
> > >   arch/x86/entry/syscalls/syscall_32.tbl
> > >   arch/x86/entry/syscalls/syscall_64.tbl
> > >   include/uapi/asm-generic/unistd.h
> > > 
> > > between commits:
> > > 
> > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > > 
> > > from the y2038 tree and commit:
> > > 
> > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > > 
> > > from the pidfd tree.  
> > 
> > This is now a conflict between the block, tip and pidfd trees.  The
> > resolution now looks like below.
> > 
> > diff --cc arch/x86/entry/syscalls/syscall_32.tbl
> > index 8da78595d69d,234d91df8ca6..000000000000
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@@ -396,39 -396,6 +396,40 @@@
> >   382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
> >   383	i386	statx			sys_statx			__ia32_sys_statx
> >   384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
> >  -385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
> >  +385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
> >   386	i386	rseq			sys_rseq			__ia32_sys_rseq
> >  +# don't use numbers 387 through 392, add new calls at the end
> >  +393	i386	semget			sys_semget    			__ia32_sys_semget
> >  +394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
> >  +395	i386	shmget			sys_shmget    			__ia32_sys_shmget
> >  +396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
> >  +397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
> >  +398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
> >  +399	i386	msgget			sys_msgget    			__ia32_sys_msgget
> >  +400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
> >  +401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
> >  +402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
> >  +403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
> >  +404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
> >  +405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
> >  +406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
> >  +407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
> >  +408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
> >  +409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
> >  +410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
> >  +411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
> >  +412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
> >  +413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
> >  +414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
> >  +416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
> >  +417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
> >  +418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
> >  +419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
> >  +420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
> >  +421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
> >  +422	i386	futex_time64		sys_futex			__ia32_sys_futex
> >  +423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
> > + 424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
> >  +425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
> >  +426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
> >  +427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
> > diff --cc arch/x86/entry/syscalls/syscall_64.tbl
> > index c768447f97ec,58f4b3ad4fe0..000000000000
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@@ -343,11 -343,7 +343,12 @@@
> >   332	common	statx			__x64_sys_statx
> >   333	common	io_pgetevents		__x64_sys_io_pgetevents
> >   334	common	rseq			__x64_sys_rseq
> >  +# don't use numbers 387 through 423, add new calls after the last
> >  +# 'common' entry
> > + 424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
> >  +425	common	io_uring_setup		__x64_sys_io_uring_setup
> >  +426	common	io_uring_enter		__x64_sys_io_uring_enter
> >  +427	common	io_uring_register	__x64_sys_io_uring_register
> >   
> >   #
> >   # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --cc include/uapi/asm-generic/unistd.h
> > index 94fde9a14830,c861e7d1053b..000000000000
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@@ -740,58 -740,11 +740,60 @@@ __SC_COMP_3264(__NR_io_pgetevents, sys_
> >   __SYSCALL(__NR_rseq, sys_rseq)
> >   #define __NR_kexec_file_load 294
> >   __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> >  +/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
> >  +#if __BITS_PER_LONG == 32
> >  +#define __NR_clock_gettime64 403
> >  +__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
> >  +#define __NR_clock_settime64 404
> >  +__SYSCALL(__NR_clock_settime64, sys_clock_settime)
> >  +#define __NR_clock_adjtime64 405
> >  +__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
> >  +#define __NR_clock_getres_time64 406
> >  +__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
> >  +#define __NR_clock_nanosleep_time64 407
> >  +__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
> >  +#define __NR_timer_gettime64 408
> >  +__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
> >  +#define __NR_timer_settime64 409
> >  +__SYSCALL(__NR_timer_settime64, sys_timer_settime)
> >  +#define __NR_timerfd_gettime64 410
> >  +__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
> >  +#define __NR_timerfd_settime64 411
> >  +__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
> >  +#define __NR_utimensat_time64 412
> >  +__SYSCALL(__NR_utimensat_time64, sys_utimensat)
> >  +#define __NR_pselect6_time64 413
> >  +__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
> >  +#define __NR_ppoll_time64 414
> >  +__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
> >  +#define __NR_io_pgetevents_time64 416
> >  +__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
> >  +#define __NR_recvmmsg_time64 417
> >  +__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
> >  +#define __NR_mq_timedsend_time64 418
> >  +__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
> >  +#define __NR_mq_timedreceive_time64 419
> >  +__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
> >  +#define __NR_semtimedop_time64 420
> >  +__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
> >  +#define __NR_rt_sigtimedwait_time64 421
> >  +__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
> >  +#define __NR_futex_time64 422
> >  +__SYSCALL(__NR_futex_time64, sys_futex)
> >  +#define __NR_sched_rr_get_interval_time64 423
> >  +__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
> >  +#endif
> > + #define __NR_pidfd_send_signal 424
> > + __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> >  +#define __NR_io_uring_setup 425
> >  +__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
> >  +#define __NR_io_uring_enter 426
> >  +__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
> >  +#define __NR_io_uring_register 427
> >  +__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> >   
> >   #undef __NR_syscalls
> >  -#define __NR_syscalls 425
> >  +#define __NR_syscalls 428
> >   
> >   /*
> >    * 32 bit systems traditionally used different
> 
> -- 
> Cheers,
> Stephen Rothwell


