Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F99C2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgAINmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:42:00 -0500
Received: from foss.arm.com ([217.140.110.172]:59304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgAINl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:41:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2492031B;
        Thu,  9 Jan 2020 05:41:59 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329D43F534;
        Thu,  9 Jan 2020 05:41:58 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: simplify parse_driver_options()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20191226095141.30352-1-yamada.masahiro@socionext.com>
 <20191226095141.30352-2-yamada.masahiro@socionext.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1383eeb0-4148-a798-5e24-81ce33013f1d@arm.com>
Date:   Thu, 9 Jan 2020 13:41:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191226095141.30352-2-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/2019 9:51 am, Masahiro Yamada wrote:
> Using ARRAY_SIZE() instead of the sentinel is slightly simpler, IMHO.

Given that it's fairly well-decided that we don't want to add any more 
of these anyway, I'd be inclined to lose the array/loop machinery 
altogether. As it is we'd need a lot more options for it to actually 
offer any kind of code size saving.

Robin.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>   drivers/iommu/arm-smmu-v3.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ed9933960370..b27489b7f9d8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -676,7 +676,6 @@ struct arm_smmu_option_prop {
>   static const struct arm_smmu_option_prop arm_smmu_options[] = {
>   	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>   	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
> -	{ 0, NULL},
>   };
>   
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> @@ -696,16 +695,16 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
>   {
> -	int i = 0;
> +	int i;
>   
> -	do {
> +	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++) {
>   		if (of_property_read_bool(smmu->dev->of_node,
>   						arm_smmu_options[i].prop)) {
>   			smmu->options |= arm_smmu_options[i].opt;
>   			dev_notice(smmu->dev, "option %s\n",
>   				arm_smmu_options[i].prop);
>   		}
> -	} while (arm_smmu_options[++i].opt);
> +	};
>   }
>   
>   /* Low-level queue manipulation functions */
> 
