Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6779CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4211521734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfEALBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 07:01:19 -0400
Received: from foss.arm.com ([217.140.101.70]:58034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfEALBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 07:01:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7534580D;
        Wed,  1 May 2019 04:01:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E603F719;
        Wed,  1 May 2019 04:01:16 -0700 (PDT)
Date:   Wed, 1 May 2019 12:01:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: Fix size of __early_cpu_boot_status
Message-ID: <20190501110113.GD11740@lakrids.cambridge.arm.com>
References: <1556620535-10060-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556620535-10060-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:05:04PM +0530, Arun KS wrote:
> __early_cpu_boot_status is of type long. Use quad
> assembler directive to allocate proper size.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> ---
>  arch/arm64/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index eecf792..115f332 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -684,7 +684,7 @@ ENTRY(__boot_cpu_mode)
>   * with MMU turned off.
>   */
>  ENTRY(__early_cpu_boot_status)
> -	.long 	0
> +	.quad 	0

This is the last element in .mmuoff.data.write, which is padded to 2K,
so luckily we don't clobber anything else (and don't need a backport).

For consistency with __boot_cpu_mode, we could instead change the c
declaration to int, and fix up the calls to
update_early_cpu_boot_status, to use a w register, but either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  	.popsection
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
