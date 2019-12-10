Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08520637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KA6STw31";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VgUU8lX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLJBFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:05:31 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:52114
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbfLJBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575939928;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=IoJP81yvas+Y8PbDTZ2le7VkBKgRd/d79Bw8gvv+4IU=;
        b=KA6STw31o5tf2KS2jdA2IuXrwfTx+0ZfheM0x4M6PR74kq01ZfgSaBvI+tHqNFCX
        BH1vTlQC1nhObFOBvEq/OGYR9i2GyN1W54Ql9B79ZDhSvl3jhO1xD9Q30Lai1aAQL9G
        9hxfpHOOd6Izc9bRDzLNZl81VHfDPXBhle1QdXQE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575939928;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=IoJP81yvas+Y8PbDTZ2le7VkBKgRd/d79Bw8gvv+4IU=;
        b=VgUU8lX1E6wgVarlF+IV5Jtf9XNShDkiKxkTknAvJrsXR4Gi5KhahiHJEzaL0cAf
        HwbTsxiqz02SnXGo5fJceGCyncQ08xPRhwduqIIp2JPhvzTXgtzO5/dc1bvmV31SZnl
        BOTWNUGdO+aHcnuCVK4cqCG2p/arAHDAP3b6KrFw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 079FAC447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>
Cc:     <lee.jones@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <ztuowen@gmail.com>, <mika.westerberg@linux.intel.com>,
        <mcgrof@kernel.org>, <gregkh@linuxfoundation.org>,
        <alexios.zavras@intel.com>, <allison@lohutok.net>,
        <will@kernel.org>, <rfontana@redhat.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <geert@linux-m68k.org>,
        <linux-hexagon@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        "'Sid Manning'" <sidneym@codeaurora.org>
References: <20191209222956.239798-1-ndesaulniers@google.com> <20191209222956.239798-3-ndesaulniers@google.com>
In-Reply-To: <20191209222956.239798-3-ndesaulniers@google.com>
Subject: RE: [PATCH 2/2] hexagon: parenthesize registers in asm predicates
Date:   Tue, 10 Dec 2019 01:05:28 +0000
Message-ID: <0101016eed56efa6-84668b8b-1745-4418-8f53-9338de9eb40c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIttLPFE8ad6Ohy6/JIQvGwI+sJfQL2CfyLpurRnTA=
Content-Language: en-us
X-SES-Outgoing: 2019.12.10-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Monday, December 9, 2019 4:30 PM
> To: bcain@codeaurora.org
> Cc: Nick Desaulniers <ndesaulniers@google.com>; lee.jones@linaro.org;
> andriy.shevchenko@linux.intel.com; ztuowen@gmail.com;
> mika.westerberg@linux.intel.com; mcgrof@kernel.org;
> gregkh@linuxfoundation.org; alexios.zavras@intel.com;
> allison@lohutok.net; will@kernel.org; rfontana@redhat.com;
> tglx@linutronix.de; peterz@infradead.org; boqun.feng@gmail.com;
> mingo@redhat.com; akpm@linux-foundation.org; geert@linux-m68k.org;
> linux-hexagon@vger.kernel.org; clang-built-linux@googlegroups.com; =
linux-
> kernel@vger.kernel.org; Sid Manning <sidneym@codeaurora.org>
> Subject: [PATCH 2/2] hexagon: parenthesize registers in asm predicates
>=20
> Hexagon requires that register predicates in assembly be =
parenthesized.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/754
> Suggested-by: Sid Manning <sidneym@codeaurora.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/hexagon/include/asm/atomic.h   |  8 ++++----
>  arch/hexagon/include/asm/bitops.h   |  8 ++++----
>  arch/hexagon/include/asm/cmpxchg.h  |  2 +-
>  arch/hexagon/include/asm/futex.h    |  6 +++---
>  arch/hexagon/include/asm/spinlock.h | 20 ++++++++++----------
>  arch/hexagon/kernel/vm_entry.S      |  2 +-
>  6 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/hexagon/include/asm/atomic.h
> b/arch/hexagon/include/asm/atomic.h
> index 12cd9231c4b8..0231d69c8bf2 100644
> --- a/arch/hexagon/include/asm/atomic.h
> +++ b/arch/hexagon/include/asm/atomic.h
> @@ -91,7 +91,7 @@ static inline void atomic_##op(int i, atomic_t *v)
> 		\
>  		"1:	%0 =3D memw_locked(%1);\n"			\
>  		"	%0 =3D "#op "(%0,%2);\n"
> 	\
>  		"	memw_locked(%1,P3)=3D%0;\n"			\
> -		"	if !P3 jump 1b;\n"				\
> +		"	if (!P3) jump 1b;\n"				\
>  		: "=3D&r" (output)					\
>  		: "r" (&v->counter), "r" (i)				\
>  		: "memory", "p3"					\
> @@ -107,7 +107,7 @@ static inline int atomic_##op##_return(int i, =
atomic_t
> *v)		\
>  		"1:	%0 =3D memw_locked(%1);\n"			\
>  		"	%0 =3D "#op "(%0,%2);\n"
> 	\
>  		"	memw_locked(%1,P3)=3D%0;\n"			\
> -		"	if !P3 jump 1b;\n"				\
> +		"	if (!P3) jump 1b;\n"				\
>  		: "=3D&r" (output)					\
>  		: "r" (&v->counter), "r" (i)				\
>  		: "memory", "p3"					\
> @@ -124,7 +124,7 @@ static inline int atomic_fetch_##op(int i, =
atomic_t *v)
> 			\
>  		"1:	%0 =3D memw_locked(%2);\n"			\
>  		"	%1 =3D "#op "(%0,%3);\n"
> 	\
>  		"	memw_locked(%2,P3)=3D%1;\n"			\
> -		"	if !P3 jump 1b;\n"				\
> +		"	if (!P3) jump 1b;\n"				\
>  		: "=3D&r" (output), "=3D&r" (val)				\
>  		: "r" (&v->counter), "r" (i)				\
>  		: "memory", "p3"					\
> @@ -173,7 +173,7 @@ static inline int atomic_fetch_add_unless(atomic_t
> *v, int a, int u)
>  		"	}"
>  		"	memw_locked(%2, p3) =3D %1;"
>  		"	{"
> -		"		if !p3 jump 1b;"
> +		"		if (!p3) jump 1b;"
>  		"	}"
>  		"2:"
>  		: "=3D&r" (__oldval), "=3D&r" (tmp)
> diff --git a/arch/hexagon/include/asm/bitops.h
> b/arch/hexagon/include/asm/bitops.h
> index 47384b094b94..71429f756af0 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -38,7 +38,7 @@ static inline int test_and_clear_bit(int nr, =
volatile void
> *addr)
>  	"1:	R12 =3D memw_locked(R10);\n"
>  	"	{ P0 =3D tstbit(R12,R11); R12 =3D clrbit(R12,R11); }\n"
>  	"	memw_locked(R10,P1) =3D R12;\n"
> -	"	{if !P1 jump 1b; %0 =3D mux(P0,#1,#0);}\n"
> +	"	{if (!P1) jump 1b; %0 =3D mux(P0,#1,#0);}\n"
>  	: "=3D&r" (oldval)
>  	: "r" (addr), "r" (nr)
>  	: "r10", "r11", "r12", "p0", "p1", "memory"
> @@ -62,7 +62,7 @@ static inline int test_and_set_bit(int nr, volatile =
void
> *addr)
>  	"1:	R12 =3D memw_locked(R10);\n"
>  	"	{ P0 =3D tstbit(R12,R11); R12 =3D setbit(R12,R11); }\n"
>  	"	memw_locked(R10,P1) =3D R12;\n"
> -	"	{if !P1 jump 1b; %0 =3D mux(P0,#1,#0);}\n"
> +	"	{if (!P1) jump 1b; %0 =3D mux(P0,#1,#0);}\n"
>  	: "=3D&r" (oldval)
>  	: "r" (addr), "r" (nr)
>  	: "r10", "r11", "r12", "p0", "p1", "memory"
> @@ -88,7 +88,7 @@ static inline int test_and_change_bit(int nr, =
volatile void
> *addr)
>  	"1:	R12 =3D memw_locked(R10);\n"
>  	"	{ P0 =3D tstbit(R12,R11); R12 =3D togglebit(R12,R11); }\n"
>  	"	memw_locked(R10,P1) =3D R12;\n"
> -	"	{if !P1 jump 1b; %0 =3D mux(P0,#1,#0);}\n"
> +	"	{if (!P1) jump 1b; %0 =3D mux(P0,#1,#0);}\n"
>  	: "=3D&r" (oldval)
>  	: "r" (addr), "r" (nr)
>  	: "r10", "r11", "r12", "p0", "p1", "memory"
> @@ -223,7 +223,7 @@ static inline int ffs(int x)
>  	int r;
>=20
>  	asm("{ P0 =3D cmp.eq(%1,#0); %0 =3D ct0(%1);}\n"
> -		"{ if P0 %0 =3D #0; if !P0 %0 =3D add(%0,#1);}\n"
> +		"{ if (P0) %0 =3D #0; if (!P0) %0 =3D add(%0,#1);}\n"
>  		: "=3D&r" (r)
>  		: "r" (x)
>  		: "p0");
> diff --git a/arch/hexagon/include/asm/cmpxchg.h
> b/arch/hexagon/include/asm/cmpxchg.h
> index 6091322c3af9..92b8a02e588a 100644
> --- a/arch/hexagon/include/asm/cmpxchg.h
> +++ b/arch/hexagon/include/asm/cmpxchg.h
> @@ -30,7 +30,7 @@ static inline unsigned long __xchg(unsigned long x,
> volatile void *ptr,
>  	__asm__ __volatile__ (
>  	"1:	%0 =3D memw_locked(%1);\n"    /*  load into retval */
>  	"	memw_locked(%1,P0) =3D %2;\n" /*  store into memory */
> -	"	if !P0 jump 1b;\n"
> +	"	if (!P0) jump 1b;\n"
>  	: "=3D&r" (retval)
>  	: "r" (ptr), "r" (x)
>  	: "memory", "p0"
> diff --git a/arch/hexagon/include/asm/futex.h
> b/arch/hexagon/include/asm/futex.h
> index cb635216a732..0191f7c7193e 100644
> --- a/arch/hexagon/include/asm/futex.h
> +++ b/arch/hexagon/include/asm/futex.h
> @@ -16,7 +16,7 @@
>  	    /* For example: %1 =3D %4 */ \
>  	    insn \
>  	"2: memw_locked(%3,p2) =3D %1;\n" \
> -	"   if !p2 jump 1b;\n" \
> +	"   if (!p2) jump 1b;\n" \
>  	"   %1 =3D #0;\n" \
>  	"3:\n" \
>  	".section .fixup,\"ax\"\n" \
> @@ -84,10 +84,10 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32
> __user *uaddr, u32 oldval,
>  	"1: %1 =3D memw_locked(%3)\n"
>  	"   {\n"
>  	"      p2 =3D cmp.eq(%1,%4)\n"
> -	"      if !p2.new jump:NT 3f\n"
> +	"      if (!p2.new) jump:NT 3f\n"
>  	"   }\n"
>  	"2: memw_locked(%3,p2) =3D %5\n"
> -	"   if !p2 jump 1b\n"
> +	"   if (!p2) jump 1b\n"
>  	"3:\n"
>  	".section .fixup,\"ax\"\n"
>  	"4: %0 =3D #%6\n"
> diff --git a/arch/hexagon/include/asm/spinlock.h
> b/arch/hexagon/include/asm/spinlock.h
> index bfe07d842ff3..ef103b73bec8 100644
> --- a/arch/hexagon/include/asm/spinlock.h
> +++ b/arch/hexagon/include/asm/spinlock.h
> @@ -30,9 +30,9 @@ static inline void arch_read_lock(arch_rwlock_t =
*lock)
>  	__asm__ __volatile__(
>  		"1:	R6 =3D memw_locked(%0);\n"
>  		"	{ P3 =3D cmp.ge(R6,#0); R6 =3D add(R6,#1);}\n"
> -		"	{ if !P3 jump 1b; }\n"
> +		"	{ if (!P3) jump 1b; }\n"
>  		"	memw_locked(%0,P3) =3D R6;\n"
> -		"	{ if !P3 jump 1b; }\n"
> +		"	{ if (!P3) jump 1b; }\n"
>  		:
>  		: "r" (&lock->lock)
>  		: "memory", "r6", "p3"
> @@ -46,7 +46,7 @@ static inline void arch_read_unlock(arch_rwlock_t
> *lock)
>  		"1:	R6 =3D memw_locked(%0);\n"
>  		"	R6 =3D add(R6,#-1);\n"
>  		"	memw_locked(%0,P3) =3D R6\n"
> -		"	if !P3 jump 1b;\n"
> +		"	if (!P3) jump 1b;\n"
>  		:
>  		: "r" (&lock->lock)
>  		: "memory", "r6", "p3"
> @@ -61,7 +61,7 @@ static inline int arch_read_trylock(arch_rwlock_t =
*lock)
>  	__asm__ __volatile__(
>  		"	R6 =3D memw_locked(%1);\n"
>  		"	{ %0 =3D #0; P3 =3D cmp.ge(R6,#0); R6 =3D add(R6,#1);}\n"
> -		"	{ if !P3 jump 1f; }\n"
> +		"	{ if (!P3) jump 1f; }\n"
>  		"	memw_locked(%1,P3) =3D R6;\n"
>  		"	{ %0 =3D P3 }\n"
>  		"1:\n"
> @@ -78,9 +78,9 @@ static inline void arch_write_lock(arch_rwlock_t =
*lock)
>  	__asm__ __volatile__(
>  		"1:	R6 =3D memw_locked(%0)\n"
>  		"	{ P3 =3D cmp.eq(R6,#0);  R6 =3D #-1;}\n"
> -		"	{ if !P3 jump 1b; }\n"
> +		"	{ if (!P3) jump 1b; }\n"
>  		"	memw_locked(%0,P3) =3D R6;\n"
> -		"	{ if !P3 jump 1b; }\n"
> +		"	{ if (!P3) jump 1b; }\n"
>  		:
>  		: "r" (&lock->lock)
>  		: "memory", "r6", "p3"
> @@ -94,7 +94,7 @@ static inline int arch_write_trylock(arch_rwlock_t =
*lock)
>  	__asm__ __volatile__(
>  		"	R6 =3D memw_locked(%1)\n"
>  		"	{ %0 =3D #0; P3 =3D cmp.eq(R6,#0);  R6 =3D #-1;}\n"
> -		"	{ if !P3 jump 1f; }\n"
> +		"	{ if (!P3) jump 1f; }\n"
>  		"	memw_locked(%1,P3) =3D R6;\n"
>  		"	%0 =3D P3;\n"
>  		"1:\n"
> @@ -117,9 +117,9 @@ static inline void arch_spin_lock(arch_spinlock_t
> *lock)
>  	__asm__ __volatile__(
>  		"1:	R6 =3D memw_locked(%0);\n"
>  		"	P3 =3D cmp.eq(R6,#0);\n"
> -		"	{ if !P3 jump 1b; R6 =3D #1; }\n"
> +		"	{ if (!P3) jump 1b; R6 =3D #1; }\n"
>  		"	memw_locked(%0,P3) =3D R6;\n"
> -		"	{ if !P3 jump 1b; }\n"
> +		"	{ if (!P3) jump 1b; }\n"
>  		:
>  		: "r" (&lock->lock)
>  		: "memory", "r6", "p3"
> @@ -139,7 +139,7 @@ static inline unsigned int
> arch_spin_trylock(arch_spinlock_t *lock)
>  	__asm__ __volatile__(
>  		"	R6 =3D memw_locked(%1);\n"
>  		"	P3 =3D cmp.eq(R6,#0);\n"
> -		"	{ if !P3 jump 1f; R6 =3D #1; %0 =3D #0; }\n"
> +		"	{ if (!P3) jump 1f; R6 =3D #1; %0 =3D #0; }\n"
>  		"	memw_locked(%1,P3) =3D R6;\n"
>  		"	%0 =3D P3;\n"
>  		"1:\n"
> diff --git a/arch/hexagon/kernel/vm_entry.S
> b/arch/hexagon/kernel/vm_entry.S index 65a1ea0eed2f..554371d92bed
> 100644
> --- a/arch/hexagon/kernel/vm_entry.S
> +++ b/arch/hexagon/kernel/vm_entry.S
> @@ -369,7 +369,7 @@ ret_from_fork:
>  		R26.L =3D #LO(do_work_pending);
>  		R0 =3D #VM_INT_DISABLE;
>  	}
> -	if P0 jump check_work_pending
> +	if (P0) jump check_work_pending
>  	{
>  		R0 =3D R25;
>  		callr R24
> --
> 2.24.0.393.g34dc348eaf-goog

Acked-by: Brian Cain <bcain@codeaurora.org>


