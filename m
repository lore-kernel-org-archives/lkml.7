Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1689E2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQuJAcSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKMDCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:02:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36084 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:02:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so401980pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=Dpd5uTeG1GRO8WYQOMFdyd5CNMfNTlaCpN0JYUg6WgU=;
        b=uQuJAcSCKkmH97BvEde5l2uvPlhaRpfqm8mmjpU2h+l4i5KrHKi++xUWoJALJ+5fJC
         W3C68IYE5j3bYB4eE7/42fRYqxdRYl4f/hcnj7NelRFeSkkSJSGGVG9GJu5OYQ46HMYF
         3rXOyPknbJGQ9ODH1AlNp6lfCaKSkgayIewo5pfkqinaTc9fmjqU2G4HqzZs8PZseEIy
         ugGHCtBKSPdxliOUJbl7Z2dAeVLk3rFVWsmrol/pBtJAx7c10dkYeGoZLv5RE85eeiUb
         0UJsxPOnUoB7yUN/kgF/nxgNR/TGMat/TF2HHGjCWIrzbzlC5x2HoDmiVB3p/UTg0QB7
         1M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=Dpd5uTeG1GRO8WYQOMFdyd5CNMfNTlaCpN0JYUg6WgU=;
        b=ntJZzJPk5M51qoSdV8JX3Fc/4UVTL57xZ+2Tp4gWAG5PrJKz2kbO6QgSvTiU0JU34X
         nmMbMlTmWM7qMs4bdvVJltGYlo/PKBdVSdC6VehY875bS3bjeoC4NCkAenrkqZl98bws
         YQqLpz/7tvG05M8IsoQn9oGJ10HWY8urc4OZQuFfU5EQaFb5wj3+MzsNx1c6b3sQ4eJK
         Yw8/iv//CfPaTMTDo357AugAU2h2spNlKG2RMdM2FT7mVfbytfTefpdslRR51vNmfKqn
         T1W9lrNXDUl0WtkAt9yLjVT25ZX9yhTxFPhgoBqi4dB26ZdJhd2GIYU5tTw/ONsn/47a
         vWAQ==
X-Gm-Message-State: APjAAAWRW14ADP8VNzgGXKtCWZxndmPUSbcsRvz7TUAS+vLxxlZ2Jd7A
        xwnpl3UO5zNV7Ayo8gENqGQ=
X-Google-Smtp-Source: APXvYqzXMHO/HtcVU5p9xv5xJK6VdYM/AfdUxrqLIz9XH3Tn6c4z6jFONsTXy9a5sBeWG0AWrbt9Dw==
X-Received: by 2002:a63:6c4:: with SMTP id 187mr974149pgg.421.1573614120606;
        Tue, 12 Nov 2019 19:02:00 -0800 (PST)
Received: from localhost (193-116-100-125.tpgi.com.au. [193.116.100.125])
        by smtp.gmail.com with ESMTPSA id s2sm400490pgv.48.2019.11.12.19.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 19:02:00 -0800 (PST)
Date:   Wed, 13 Nov 2019 13:02:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 31/33] powerpc/64: make buildable without CONFIG_COMPAT
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell Currey <ruscur@russell.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <cover.1573576649.git.msuchanek@suse.de>
        <13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de>
In-Reply-To: <13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1573613683.ylw9dz9mlc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchanek's on November 13, 2019 2:52 am:
> There are numerous references to 32bit functions in generic and 64bit
> code so ifdef them out.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

For the most part these seem okay to me.

> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 45f1d5e54671..35874119b398 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -44,16 +44,16 @@ CFLAGS_btext.o +=3D -DDISABLE_BRANCH_PROFILING
>  endif
> =20
>  obj-y				:=3D cputable.o ptrace.o syscalls.o \
> -				   irq.o align.o signal_32.o pmc.o vdso.o \
> +				   irq.o align.o signal_$(BITS).o pmc.o vdso.o \
>  				   process.o systbl.o idle.o \
>  				   signal.o sysfs.o cacheinfo.o time.o \
>  				   prom.o traps.o setup-common.o \
>  				   udbg.o misc.o io.o misc_$(BITS).o \
>  				   of_platform.o prom_parse.o
> -obj-$(CONFIG_PPC64)		+=3D setup_64.o sys_ppc32.o \
> -				   signal_64.o ptrace32.o \
> +obj-$(CONFIG_PPC64)		+=3D setup_64.o \
>  				   paca.o nvram_64.o firmware.o note.o \
>  				   syscall_64.o
> +obj-$(CONFIG_COMPAT)		+=3D sys_ppc32.o ptrace32.o signal_32.o
>  obj-$(CONFIG_VDSO32)		+=3D vdso32/
>  obj-$(CONFIG_PPC_WATCHDOG)	+=3D watchdog.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+=3D hw_breakpoint.o
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 00173cc904ef..c339a984958f 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -52,8 +52,10 @@
>  SYS_CALL_TABLE:
>  	.tc sys_call_table[TC],sys_call_table
> =20
> +#ifdef CONFIG_COMPAT
>  COMPAT_SYS_CALL_TABLE:
>  	.tc compat_sys_call_table[TC],compat_sys_call_table
> +#endif
> =20
>  /* This value is used to mark exception frames on the stack. */
>  exception_marker:
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 60436432399f..61678cb0e6a1 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
>  	sigset_t *oldset =3D sigmask_to_save();
>  	struct ksignal ksig =3D { .sig =3D 0 };
>  	int ret;
> -	int is32 =3D is_32bit_task();
> =20
>  	BUG_ON(tsk !=3D current);
> =20
> @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> =20
>  	rseq_signal_deliver(&ksig, tsk->thread.regs);
> =20
> -	if (is32) {
> +	if (is_32bit_task()) {
>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>  			ret =3D handle_rt_signal32(&ksig, oldset, tsk);
>  		else

This is just a clean up I guess.

> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/sysca=
ll_64.c
> index d00cfc4a39a9..319ebd4f494d 100644
> --- a/arch/powerpc/kernel/syscall_64.c
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -17,7 +17,6 @@ typedef long (*syscall_fn)(long, long, long, long, long=
, long);
> =20
>  long system_call_exception(long r3, long r4, long r5, long r6, long r7, =
long r8, unsigned long r0, struct pt_regs *regs)
>  {
> -	unsigned long ti_flags;
>  	syscall_fn f;
> =20
>  	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
> @@ -64,8 +63,7 @@ long system_call_exception(long r3, long r4, long r5, l=
ong r6, long r7, long r8,
> =20
>  	__hard_irq_enable();
> =20
> -	ti_flags =3D current_thread_info()->flags;
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
>  		/*
>  		 * We use the return value of do_syscall_trace_enter() as the
>  		 * syscall number. If the syscall was rejected for any reason
> @@ -81,7 +79,7 @@ long system_call_exception(long r3, long r4, long r5, l=
ong r6, long r7, long r8,
>  	/* May be faster to do array_index_nospec? */
>  	barrier_nospec();
> =20
> -	if (unlikely(ti_flags & _TIF_32BIT)) {
> +	if (unlikely(is_32bit_task())) {
>  		f =3D (void *)compat_sys_call_table[r0];
> =20
>  		r3 &=3D 0x00000000ffffffffULL;

I guess this is okay, I did want to be careful about where ti_flags
was loaded exactly, but I think DOTRACE and 32BIT are not volatile.
Is it possible to define _TIF_32BIT to zero for 64-bit !compat case
and have the original branch eliminated, or does that cause other
problems?

Thanks,
Nick
=
