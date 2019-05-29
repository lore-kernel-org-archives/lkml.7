Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA6AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732F22070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAFV5d7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfE2JqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:46:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ynLC/A1PZWZKFWVRq0ZWVkXzNlwLp37v/DNdYCI54TQ=; b=lAFV5d7S2l4izwN7C2cekbkik
        iJ8GEfwS4n4a0Ubs7px2GgBs4MmosXaZMGMLY7usb5dVBVhDC4DlSHxC72Nkd1hpujIs6ctrZYw7M
        YT71sv3nGy0KZydXd9LFb5oJx8kf/Bn/6tqunM90OTl+iiu6O7q6YS49jGGbyJz9ccOkFD1C4MUS2
        VjatY1CAUq1FyyODrtGgszkwxul4nWNxIoBVl988YpYY5VQwriXLHnJvnYwj/vQkMltqUnwyYgGG7
        eemxzlO8wn72soIv9XBQDwtL45uIEdzG3n7vvzqI8mkejqnprm+/7L6VmWR5JQ0NuQtUBxW+zJcPA
        8Xk10Lgbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVv9j-0006BG-4Q; Wed, 29 May 2019 09:45:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0D30201A7E42; Wed, 29 May 2019 11:45:56 +0200 (CEST)
Date:   Wed, 29 May 2019 11:45:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com
Subject: Re: [RFC 5/7] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Message-ID: <20190529094556.GJ2623@hirez.programming.kicks-ass.net>
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-6-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528150320.25953-6-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:03:18PM +0100, Raphael Gault wrote:
> +static int emulate_pmu(struct pt_regs *regs, u32 insn)
> +{
> +	u32 sys_reg, rt;
> +	u32 pmuserenr;
> +
> +	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
> +	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
> +	pmuserenr = read_sysreg(pmuserenr_el0);
> +
> +	if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
> +	    (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
> +		return -EINVAL;
> +

I would really prefer there to be a comment here that explain how the
'0' value works. Maybe something like:

	/*
	 * Userspace is expected to only use this in the context of the
	 * scheme described in the struct perf_event_mmap_page comments.
	 *
	 * Given that context, we can only get here if we got migrated
	 * between getting the register index and doing the MSR read.
	 * This in turn implies we'll fail the sequence and retry, so
	 * any value returned is 'good', all we need is to be non-fatal.
	 */

> +	pt_regs_write_reg(regs, rt, 0);

And given the above, we don't even need to do this, we can simply
preserve whatever garbage was in the register and return to userspace.

The only thing we really need is for the trap to be non-fatal.

> +
> +	arm64_skip_faulting_instruction(regs, 4);
> +	return 0;
> +}
> +
> +/*
> + * This hook will only be triggered by mrs
> + * instructions on PMU registers. This is mandatory
> + * in order to have a consistent behaviour even on
> + * big.LITTLE systems.
> + */
> +static struct undef_hook pmu_hook = {
> +	.instr_mask = 0xffff8800,
> +	.instr_val  = 0xd53b8800,
> +	.fn = emulate_pmu,
> +};
> +
> +static int __init enable_pmu_emulation(void)
> +{
> +	register_undef_hook(&pmu_hook);
> +	return 0;
> +}
> +
> +core_initcall(enable_pmu_emulation);
