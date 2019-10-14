Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D9ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADC220854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfJNPaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:30:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbfJNPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB9C028;
        Mon, 14 Oct 2019 08:30:02 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D5B3F68E;
        Mon, 14 Oct 2019 08:30:02 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
To:     Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com
References: <20191014102113.16546-1-julien.grall@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <82ee2a7c-1061-f954-4ff1-3dfb94ec3419@arm.com>
Date:   Mon, 14 Oct 2019 16:30:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014102113.16546-1-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

Some minor nits in the description.

On 14/10/2019 11:21, Julien Grall wrote:
> The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> will hide the feature from the from userspace.
> 
> Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> lead to undefined behavior in userspace.
> 
> The kernel should not used the register when CONFIG_SVE is disabled.

s/used/use ?

> Therefore, we only need to hidden them from the userspace.

s/hidden/hide ?

With the above:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Fixes: 06a916feca2b ('arm64: Expose SVE2 features for userspace')
> ---
>   arch/arm64/kernel/cpufeature.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cabebf1a7976..80f459ad0190 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -176,11 +176,16 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
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
>   	ARM64_FTR_END,
>   };
>   
> 
