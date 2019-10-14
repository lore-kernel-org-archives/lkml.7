Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86076C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615B820673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfJNOlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:41:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfJNOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:41:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698BE337;
        Mon, 14 Oct 2019 07:41:10 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C9E3F68E;
        Mon, 14 Oct 2019 07:41:09 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:41:07 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191014144105.GR27757@arm.com>
References: <20191014102113.16546-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014102113.16546-1-julien.grall@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> will hide the feature from the from userspace.
> 
> Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> lead to undefined behavior in userspace.
> 
> The kernel should not used the register when CONFIG_SVE is disabled.
> Therefore, we only need to hidden them from the userspace.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Fixes: 06a916feca2b ('arm64: Expose SVE2 features for userspace')

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/cpufeature.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cabebf1a7976..80f459ad0190 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -176,11 +176,16 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SM4_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SHA3_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_BITPERM_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_AES_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SVEVER_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SM4_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SHA3_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_BITPERM_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_AES_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SVEVER_SHIFT, 4, 0),
>  	ARM64_FTR_END,
>  };
>  
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
