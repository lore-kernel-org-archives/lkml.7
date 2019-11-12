Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCEF20650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKLJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:58994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfKLJku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:40:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F941FB;
        Tue, 12 Nov 2019 01:40:49 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B1133F534;
        Tue, 12 Nov 2019 01:40:48 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:40:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, sungguk.na@samsung.com
Subject: Re: [PATCH] arm64: perf: Report arm pc registers for compat perf
Message-ID: <20191112094037.GA32269@lakrids.cambridge.arm.com>
References: <CGME20191112005902epcas1p2d9dfa6a29f2c57669b1c1eb58517016d@epcas1p2.samsung.com>
 <1573520501-29195-1-git-send-email-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573520501-29195-1-git-send-email-sw0312.kim@samsung.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:01:41AM +0900, Seung-Woo Kim wrote:
> If perf is built as arm 32-bit, it only reads 15 registers as arm
> 32-bit register map and this breaks dwarf call-chain in compat
> perf because pc register information is not filled.
> Report arm pc registers for 32-bit compat perf.
> 
> Without this, arm 32-bit perf dwarf call-graph shows below
> verbose message:
>   unwind: reg 15, val 0
>   unwind: reg 13, val ffbc6360
>   unwind: no map for 0
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  arch/arm64/kernel/perf_regs.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> index 0bbac61..d4172e7 100644
> --- a/arch/arm64/kernel/perf_regs.c
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -24,6 +24,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  			return regs->compat_sp;
>  		if ((u32)idx == PERF_REG_ARM64_LR)
>  			return regs->compat_lr;
> +		if ((u32)idx == 15) /* PERF_REG_ARM_PC */
> +			return regs->pc;
>  	}

This doesn't look quite right to me, since perf_regs_value() is
consuming the arm64 index for all other registers (e.g. the LR, in the
patch context).

i.e. this is designed for a native arm64 caller, and the fixup allows it
to view a compat task's registers as-if it were native.

How does this work for a native arm64 perf invocation with a compat
task? I assume it consumers regs->pc, and works as expected?

I suspect we need separate native and compat forms of this function, but
then it's not entirely clear how this should work -- how does this work
for a compat perf analysing a native arm64 binary?

Thanks,
Mark.
