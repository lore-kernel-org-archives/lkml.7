Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66E720661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pD4e+Zbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfCEXHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:07:19 -0500
Received: from ozlabs.org ([203.11.71.1]:59145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCEXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:07:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44DXbQ0MZdz9sBr;
        Wed,  6 Mar 2019 10:07:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551827235;
        bh=AzdPskMVQEDzVgaO5uowL1TLBY0Eej3zKeShD2MxVT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pD4e+Zbrz2VNRbqDyF+uxsv0Bjg1oCtNvkV1mG8u12fJFN149YWgebvrOQtvtywah
         KS8QT80gsbtRLkHjKMQDeWcc3V5FUlTLIW23STs25y3wDf9V0fu7RAhSeLhO+QSJud
         XHThOWffOVm62cQokGaV4DBUXLFLNFrm/mzj2S0Va3rfNMMULt9bqqjzZ9ZkIkVd5T
         ZUCrt5ZtMiLl5mp0AP2v9imS2MxZHTZyQM0jUsN8poxyJpBRRMAuuZBKNjS4pFOuWM
         2fQx052IcCVaT8qp4AdbdDkd+8H3rrxthZNUZ4tyLFiCSVkbSKBa7O6fcrF9VcAFcb
         J3zHaOhjOF/mA==
Date:   Wed, 6 Mar 2019 10:07:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] pidfd patches for v5.1-rc1
Message-ID: <20190306100713.09b519ea@canb.auug.org.au>
In-Reply-To: <20190305171301.23147-1-christian@brauner.io>
References: <20190305171301.23147-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KPREksubWrZ8yGTbc9b2Ig0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KPREksubWrZ8yGTbc9b2Ig0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue,  5 Mar 2019 18:13:01 +0100 Christian Brauner <christian@brauner.io>=
 wrote:
>
> This is the first direct pr I had to send so I hope I didn't make any
> horrible mistakes.

One thing: you probably should have mentioned that these changes
conflict with changes in the block and tip trees:

> On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the pidfd tree got conflicts in:
> >=20
> >   arch/x86/entry/syscalls/syscall_32.tbl
> >   arch/x86/entry/syscalls/syscall_64.tbl
> >   include/uapi/asm-generic/unistd.h
> >=20
> > between commits:
> >=20
> >   63a96220ad45 ("arch: add split IPC system calls where needed")
> >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit archit=
ectures")
> >=20
> > from the y2038 tree and commit:
> >=20
> >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> >=20
> > from the pidfd tree. =20
>=20
> This is now a conflict between the block, tip and pidfd trees.  The
> resolution now looks like below.
>=20
> diff --cc arch/x86/entry/syscalls/syscall_32.tbl
> index 8da78595d69d,234d91df8ca6..000000000000
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@@ -396,39 -396,6 +396,40 @@@
>   382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
>   383	i386	statx			sys_statx			__ia32_sys_statx
>   384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>  -385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgeteve=
nts
>  +385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_p=
getevents
>   386	i386	rseq			sys_rseq			__ia32_sys_rseq
>  +# don't use numbers 387 through 392, add new calls at the end
>  +393	i386	semget			sys_semget    			__ia32_sys_semget
>  +394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
>  +395	i386	shmget			sys_shmget    			__ia32_sys_shmget
>  +396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
>  +397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
>  +398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
>  +399	i386	msgget			sys_msgget    			__ia32_sys_msgget
>  +400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
>  +401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
>  +402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
>  +403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
>  +404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
>  +405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
>  +406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
>  +407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_n=
anosleep
>  +408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
>  +409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
>  +410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gett=
ime
>  +411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_sett=
ime
>  +412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
>  +413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_tim=
e64
>  +414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
>  +416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgeteven=
ts
>  +417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_tim=
e64
>  +418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
>  +419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_time=
dreceive
>  +420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
>  +421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_=
rt_sigtimedwait_time64
>  +422	i386	futex_time64		sys_futex			__ia32_sys_futex
>  +423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_=
sys_sched_rr_get_interval
> + 424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send=
_signal
>  +425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
>  +426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
>  +427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_r=
egister
> diff --cc arch/x86/entry/syscalls/syscall_64.tbl
> index c768447f97ec,58f4b3ad4fe0..000000000000
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@@ -343,11 -343,7 +343,12 @@@
>   332	common	statx			__x64_sys_statx
>   333	common	io_pgetevents		__x64_sys_io_pgetevents
>   334	common	rseq			__x64_sys_rseq
>  +# don't use numbers 387 through 423, add new calls after the last
>  +# 'common' entry
> + 424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
>  +425	common	io_uring_setup		__x64_sys_io_uring_setup
>  +426	common	io_uring_enter		__x64_sys_io_uring_enter
>  +427	common	io_uring_register	__x64_sys_io_uring_register
>  =20
>   #
>   # x32-specific system call numbers start at 512 to avoid cache impact
> diff --cc include/uapi/asm-generic/unistd.h
> index 94fde9a14830,c861e7d1053b..000000000000
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@@ -740,58 -740,11 +740,60 @@@ __SC_COMP_3264(__NR_io_pgetevents, sys_
>   __SYSCALL(__NR_rseq, sys_rseq)
>   #define __NR_kexec_file_load 294
>   __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>  +/* 295 through 402 are unassigned to sync up with generic numbers, don'=
t use */
>  +#if __BITS_PER_LONG =3D=3D 32
>  +#define __NR_clock_gettime64 403
>  +__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
>  +#define __NR_clock_settime64 404
>  +__SYSCALL(__NR_clock_settime64, sys_clock_settime)
>  +#define __NR_clock_adjtime64 405
>  +__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
>  +#define __NR_clock_getres_time64 406
>  +__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
>  +#define __NR_clock_nanosleep_time64 407
>  +__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
>  +#define __NR_timer_gettime64 408
>  +__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
>  +#define __NR_timer_settime64 409
>  +__SYSCALL(__NR_timer_settime64, sys_timer_settime)
>  +#define __NR_timerfd_gettime64 410
>  +__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
>  +#define __NR_timerfd_settime64 411
>  +__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
>  +#define __NR_utimensat_time64 412
>  +__SYSCALL(__NR_utimensat_time64, sys_utimensat)
>  +#define __NR_pselect6_time64 413
>  +__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time6=
4)
>  +#define __NR_ppoll_time64 414
>  +__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
>  +#define __NR_io_pgetevents_time64 416
>  +__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
>  +#define __NR_recvmmsg_time64 417
>  +__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time6=
4)
>  +#define __NR_mq_timedsend_time64 418
>  +__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
>  +#define __NR_mq_timedreceive_time64 419
>  +__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
>  +#define __NR_semtimedop_time64 420
>  +__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
>  +#define __NR_rt_sigtimedwait_time64 421
>  +__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_=
rt_sigtimedwait_time64)
>  +#define __NR_futex_time64 422
>  +__SYSCALL(__NR_futex_time64, sys_futex)
>  +#define __NR_sched_rr_get_interval_time64 423
>  +__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
>  +#endif
> + #define __NR_pidfd_send_signal 424
> + __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
>  +#define __NR_io_uring_setup 425
>  +__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  +#define __NR_io_uring_enter 426
>  +__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  +#define __NR_io_uring_register 427
>  +__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
>  =20
>   #undef __NR_syscalls
>  -#define __NR_syscalls 425
>  +#define __NR_syscalls 428
>  =20
>   /*
>    * 32 bit systems traditionally used different

--=20
Cheers,
Stephen Rothwell

--Sig_/KPREksubWrZ8yGTbc9b2Ig0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx/ASEACgkQAVBC80lX
0GzpFwf/e6WYhR7vW3MT+dANAIoeKQX7EBiZlePbHsTWW098UW2wS55vSdJMj/+J
dihiCGhaE1CJLykB6gLGj6t9pROFLajGTG+IURhu5Cg4DMmv8vFs8V6mhHUvPWHL
ghh+12e5y4m3U68iv4aFw08GBN0XsbB3xN57F4BWBCN6FOhV745Y783GrYlWYJYb
Xxc1BzS12RsigPF4k/qF+GTs6gQFU8sZY0iOs4SHpLyVXMj2oMVTToYhgvPPA+5Q
u/OPAAQnAiwdWaCzh/MhBsAcRbOK2oczPIQrel4ntpXkD8q0mDYloSbTLQvBxQFL
0XLctX7zihc+nuikNS3vCD9DhyE7DQ==
=Is73
-----END PGP SIGNATURE-----

--Sig_/KPREksubWrZ8yGTbc9b2Ig0--
