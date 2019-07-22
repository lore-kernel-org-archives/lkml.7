Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB85C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AE5216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfGVKKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:10:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGVKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:10:51 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpVHL-00043N-KJ; Mon, 22 Jul 2019 12:10:47 +0200
Date:   Mon, 22 Jul 2019 12:10:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jan Beulich <jbeulich@suse.com>, x86@kernel.org
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
In-Reply-To: <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907221207000.1782@nanos.tec.linutronix.de>
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com> <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019, Arnd Bergmann wrote:

Trimmed CC list and added Jan

> See below for the patch I am using locally to work around this.
> That patch is probably wrong, so I have not submitted it yet, but it
> gives you a clean build ;-)
> 
>      Arnd
> 8<---
> Subject: [PATCH] x86: percpu: fix clang 32-bit build
> 
> clang does not like an inline assembly with a "=q" contraint for
> a 64-bit output:
> 
> arch/x86/events/perf_event.h:824:21: error: invalid output size for
> constraint '=q'
>         u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
>                            ^
> include/linux/percpu-defs.h:447:2: note: expanded from macro '__this_cpu_read'
>         raw_cpu_read(pcp);                                              \
>         ^
> include/linux/percpu-defs.h:421:28: note: expanded from macro 'raw_cpu_read'
>  #define raw_cpu_read(pcp)
> __pcpu_size_call_return(raw_cpu_read_, pcp)
>                                         ^
> include/linux/percpu-defs.h:322:23: note: expanded from macro
> '__pcpu_size_call_return'
>         case 1: pscr_ret__ = stem##1(variable); break;                  \
>                              ^
> <scratch space>:357:1: note: expanded from here
> raw_cpu_read_1
> ^
> arch/x86/include/asm/percpu.h:394:30: note: expanded from macro 'raw_cpu_read_1'
>  #define raw_cpu_read_1(pcp)             percpu_from_op(, "mov", pcp)
>                                         ^
> arch/x86/include/asm/percpu.h:189:15: note: expanded from macro 'percpu_from_op'
>                     : "=q" (pfo_ret__)                  \
>                             ^
> 
> According to the commit that introduced the "q" constraint, this was
> needed to fix miscompilation, but it gives no further detail.

Jan, do you have any memory why you added those 'q' constraints? The
changelog of 3c598766a2ba is not really helpful.

Thanks,

	tglx

> Using the normal "=r" constraint seems to work so far.
> 
> Fixes: 3c598766a2ba ("x86: fix percpu_{to,from}_op()")
> Cc: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 2278797c769d..e791fbf4018f 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -99,7 +99,7 @@ do {                                                  \
>         case 1:                                         \
>                 asm qual (op "b %1,"__percpu_arg(0)     \
>                     : "+m" (var)                        \
> -                   : "qi" ((pto_T__)(val)));           \
> +                   : "ri" ((pto_T__)(val)));           \
>                 break;                                  \
>         case 2:                                         \
>                 asm qual (op "w %1,"__percpu_arg(0)     \
> @@ -144,7 +144,7 @@ do {
>                          \
>                 else                                                    \
>                         asm qual ("addb %1, "__percpu_arg(0)            \
>                             : "+m" (var)                                \
> -                           : "qi" ((pao_T__)(val)));                   \
> +                           : "ri" ((pao_T__)(val)));                   \
>                 break;                                                  \
>         case 2:                                                         \
>                 if (pao_ID__ == 1)                                      \
> @@ -186,7 +186,7 @@ do {
>                          \
>         switch (sizeof(var)) {                          \
>         case 1:                                         \
>                 asm qual (op "b "__percpu_arg(1)",%0"   \
> -                   : "=q" (pfo_ret__)                  \
> +                   : "=r" (pfo_ret__)                  \
>                     : "m" (var));                       \
>                 break;                                  \
>         case 2:                                         \
> @@ -215,7 +215,7 @@ do {
>                          \
>         switch (sizeof(var)) {                          \
>         case 1:                                         \
>                 asm(op "b "__percpu_arg(P1)",%0"        \
> -                   : "=q" (pfo_ret__)                  \
> +                   : "=r" (pfo_ret__)                  \
>                     : "p" (&(var)));                    \
>                 break;                                  \
>         case 2:                                         \
> 
