Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969EAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7922083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDKQmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:42:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:42:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AA02374;
        Thu, 11 Apr 2019 09:42:23 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115063F59C;
        Thu, 11 Apr 2019 09:42:21 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:42:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>, peter.maydell@linaro.org,
        richard.earnshaw@arm.com
Subject: Re: rseq/arm32: choosing rseq code signature
Message-ID: <20190411164219.GE29081@fuggles.cambridge.arm.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
 <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Apr 10, 2019 at 04:29:19PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> > We are about to include the code signature required prior to restartable
> > sequences abort handlers into glibc, which will make this ABI choice final.
> > We need architecture maintainer input on that signature value.
> > 
> > That code signature is placed before each abort handler, so the kernel can
> > validate that it is indeed jumping to an abort handler (and not some
> > arbitrary attacker-chosen code). The signature is never executed.
> > 
> > The current discussion thread on the glibc mailing list leads us towards
> > using a trap with uncommon immediate operand, which simplifies integration
> > with disassemblers, emulators, makes it easier to debug if the control
> > flow gets redirected there by mistake, and is nicer for some architecture's
> > speculative execution.
> > 
> > We can have different signatures for each sub-architecture, as long as they
> > don't have to co-exist within the same process. We can special-case with
> > #ifdef for each sub-architecture and endianness if need be. If the architecture
> > has instruction set extensions that can co-exist with the architecture
> > instruction set within the same process (e.g. thumb for arm), we need to take
> > into account to which instruction the chosen signature value would map (and
> > possibly decide if we need to extend rseq to support many signatures).
> > 
> > Here is an example of rseq signature definition template:
> > 
> > /*
> > * TODO: document trap instruction objdump output on each sub-architecture
> > * instruction sets, as well as instruction set extensions.
> > */
> > #define RSEQ_SIG 0x########
> > 
> > Ideally we'd need a patch on top of the Linux kernel
> > tools/testing/selftests/rseq/rseq-arm.h file that updates
> > the signature value, so I can then pick it up for the glibc
> > patchset.
> 
> Would the following diff work for you ? If so, can I get your
> acked-by ?

I had a quick chat with Richard and Peter (CC'd), since they're much more
familiar with the A32 instruction set than I am and also have a better view
of what might already be in use.

Peter suggests that anything of the form 0xe7fxdefx should trap in both A32
and T32, although it does assemble to UDF; B <imm11> in T16. I'm not sure we
should get too obsessed with trying to encode a signature that universally
decodes to a trap.

Whatever you choose, it would be worth checking that it doesn't clash with
other allocations such as software breakpoints in GDB.

Will

> diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
> index 5f262c54364f..1f261ad2ac1b 100644
> --- a/tools/testing/selftests/rseq/rseq-arm.h
> +++ b/tools/testing/selftests/rseq/rseq-arm.h
> @@ -5,7 +5,17 @@
>   * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
>  
> -#define RSEQ_SIG       0x53053053
> +/*
> + * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
> + * value 0x5305. This traps if user-space reaches this instruction by mistake,
> + * and the uncommon operand ensures the kernel does not move the instruction
> + * pointer to attacker-controlled code on rseq abort.
> + *
> + * The instruction pattern is:
> + *
> + * e7f530f5    udf    #21253    ; 0x5305
> + */
> +#define RSEQ_SIG       0xe7f530f5
>  
>  #define rseq_smp_mb()  __asm__ __volatile__ ("dmb" ::: "memory", "cc")
>  #define rseq_smp_rmb() __asm__ __volatile__ ("dmb" ::: "memory", "cc")
> @@ -78,7 +88,8 @@ do {                                                                  \
>                 __rseq_str(table_label) ":\n\t"                         \
>                 ".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
>                 ".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
> -               ".word " __rseq_str(RSEQ_SIG) "\n\t"                    \
> +               ".arm\n\t"                                              \
> +               ".inst " __rseq_str(RSEQ_SIG) "\n\t"                    \
>                 __rseq_str(label) ":\n\t"                               \
>                 teardown                                                \
>                 "b %l[" __rseq_str(abort_label) "]\n\t"
