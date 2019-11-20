Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343EC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39612088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfKTQnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:43:17 -0500
Received: from foss.arm.com ([217.140.110.172]:42500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbfKTQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:43:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 254A81FB;
        Wed, 20 Nov 2019 08:43:15 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2973A3F703;
        Wed, 20 Nov 2019 08:43:13 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:43:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, allison@lohutok.net, info@metux.net,
        alexios.zavras@intel.com
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
Message-ID: <20191120164307.GA19681@lakrids.cambridge.arm.com>
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, Nov 19, 2019 at 05:10:06PM -0500, Pavel Tatashin wrote:
> Userland access functions (__arch_clear_user, __arch_copy_from_user,
> __arch_copy_in_user, __arch_copy_to_user), enable and disable PAN
> for the duration of copy. However, when copy fails for some reason,
> i.e. access violation the code is transferred to fixedup section,
> where we do not disable PAN.

Thanks for reporting this. This is a very nasty bug.

> The bug is a security violation as the access to userland is still
> open when it should be disabled, but it also causes memory corruptions
> when software emulated PAN is used: CONFIG_ARM64_SW_TTBR0_PAN=y.

I see that with CONFIG_ARM64_SW_TTBR0_PAN=y, this means that we may
leave the stale TTBR0 value installed across a context-switch (and have
reproduced that locally), but I'm having some difficulty reproducing the
corruption that you see.

> I was able to reproduce memory corruption problem on Broadcom's SoC
> ARMv8-A like this:
> 
> Enable software perf-events with PERF_SAMPLE_CALLCHAIN so userland's
> stack is accessed and copied.

IIUC this tickles the issue by performing a faulting uaccess in IRQ
context. On the path to returnign from the exception, it directly calls
into the scheduler as part of el1_preempt, erroneously passing the TTBR0
value to the next task. Note that a preemption would remove the stale
TTBR0 value as part of kernel entry.

It looks like if we're in this state, and return from an exception taken
from EL1 with SW PAN enabled, we'll also leave the stale TTBR0 value
installed. If PAN was disabled (e.g. in the middle of a uaccess region),
then we'll restore the correct TTBR0.

> The test program performed the following on every CPU and forking many
> processes:
> 
> 	unsigned long *map = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
> 				  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 	map[0] = getpid();
> 	sched_yield();
> 	if (map[0] != getpid()) {
> 		fprintf(stderr, "Corruption detected!");
> 	}
> 	munmap(map, PAGE_SIZE);

Can you provide the whole test, please? And precisely how you're
launching it?

I've tried turning the above into a main() function, and spawning a
number of instances in parallel while perf is running, but I haven't
been able to reproduce the issue locally, and I'm concerned that I'm
missing something.

> From time to time I was getting map[0] to contain pid for a different
> process.

How often is "from time to time"? How many processes are you running,
across how many CPUs?

> 
> Fixes: 338d4f49d6f7114 ("arm64: kernel: Add support for Privileged...")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/lib/clear_user.S     | 1 +
>  arch/arm64/lib/copy_from_user.S | 1 +
>  arch/arm64/lib/copy_in_user.S   | 1 +
>  arch/arm64/lib/copy_to_user.S   | 1 +
>  4 files changed, 4 insertions(+)

FWIW, the diff below looks correct to me, but we might want to fold this
into the C wrappers, so that this is consistent with the other uaccess
cases (and done in one place in the code).

Thanks,
Mark.

> 
> diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
> index 10415572e82f..322b55664cca 100644
> --- a/arch/arm64/lib/clear_user.S
> +++ b/arch/arm64/lib/clear_user.S
> @@ -48,5 +48,6 @@ EXPORT_SYMBOL(__arch_clear_user)
>  	.section .fixup,"ax"
>  	.align	2
>  9:	mov	x0, x2			// return the original size
> +	uaccess_disable_not_uao x2, x3
>  	ret
>  	.previous
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 680e74409ff9..8472dc7798b3 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -66,5 +66,6 @@ EXPORT_SYMBOL(__arch_copy_from_user)
>  	.section .fixup,"ax"
>  	.align	2
>  9998:	sub	x0, end, dst			// bytes not copied
> +	uaccess_disable_not_uao x3, x4
>  	ret
>  	.previous
> diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
> index 0bedae3f3792..8e0355c1e318 100644
> --- a/arch/arm64/lib/copy_in_user.S
> +++ b/arch/arm64/lib/copy_in_user.S
> @@ -68,5 +68,6 @@ EXPORT_SYMBOL(__arch_copy_in_user)
>  	.section .fixup,"ax"
>  	.align	2
>  9998:	sub	x0, end, dst			// bytes not copied
> +	uaccess_disable_not_uao x3, x4
>  	ret
>  	.previous
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 2d88c736e8f2..6085214654dc 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -65,5 +65,6 @@ EXPORT_SYMBOL(__arch_copy_to_user)
>  	.section .fixup,"ax"
>  	.align	2
>  9998:	sub	x0, end, dst			// bytes not copied
> +	uaccess_disable_not_uao x3, x4
>  	ret
>  	.previous
> -- 
> 2.24.0
> 
