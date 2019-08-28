Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F612C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1Szb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:55:31 -0400
Received: from foss.arm.com ([217.140.110.172]:35458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfH1Sza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A53337;
        Wed, 28 Aug 2019 11:55:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF12F3F59C;
        Wed, 28 Aug 2019 11:55:28 -0700 (PDT)
Subject: Re: [PATCH] arm-smmu: check for generic bindings first
To:     Stefano Stabellini <sstabellini@kernel.org>, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, michal.simek@xilinx.com,
        git@xilinx.com, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <20190828173837.29617-1-sstabellini@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f6fe31f1-52e1-8ab8-4ba4-f23db262d1b5@arm.com>
Date:   Wed, 28 Aug 2019 19:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190828173837.29617-1-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 18:38, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Today, the arm-smmu driver checks for mmu-masters on device tree, the
> legacy property, if it is absent it assumes that we are using the new
> bindings. If it is present it assumes that we are using the legacy
> bindings. All arm-smmus need to use the same bindings: legacy or new.
> 
> There are two issues with this:
> 
> - we are not actually checking for the new bindings explicitly
> It would be better to have an explicit check for the new bindings rather
> than assuming we must be using the new if the old are not there.

The legacy binding is the special case, though. Isn't it perfectly 
logical to check for the special case, and assume the normal case 
otherwise? ;)

> - old and new bindings cannot coexist
> It would be nice to be able to provide both old and new bindings so
> that software that hasn't been updated yet is still able to get IOMMU
> information from the legacy bindings while at the same time newer
> software can get the latest information via the new bindings. (Xen has
> not been updated to use the new binding yet for instance.) The current
> code breaks under these circumstances because if the old bindings are
> present, the new are not even checked.

FWIW that was a deliberate design decision. We didn't want to see DTs 
with both bindings at once - the legacy binding support remains only for 
the sake of DTBs deployed in fossilised firmware that can't/won't ever 
be updated. And I'm pretty sure the intervening 3 years have only 
reinforced that position. Only a couple more months now until it will 
have been deprecated for longer than it wasn't :)

Do note that "mmu-masters" isn't just deprecated for giggles either - 
the binding made some flawed assumptions, and there are Stream ID 
topologies that it cannot possibly describe, which do exist in the real 
world.

> This patch changes the scheme by checking for #iommu-cells, which is
> only present with the new bindings, before checking for mmu-masters.
> The new bindings are always favored when present. All SMMUs still need
> to use the same bindings: mix-and-matching new and old bindings between
> different SMMUs is not allowed.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
> 
> Let me know if you'd like me to turn the two using_*_binding variables
> into a single one.
> 
> Also, please note that this is not meant as an excuse not to get Xen
> updated to use the new binding.

Fair enough, but conversely, what makes it Linux's responsibility to 
handle? If Xen wants to deal with funky hybrid DTs then why shouldn't it 
be Xen's job to just filter deprecated properties out of whatever it 
presents to Linux?

Robin.

>   drivers/iommu/arm-smmu.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 64977c131ee6..79b518ff215c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2118,7 +2118,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   {
>   	const struct arm_smmu_match_data *data;
>   	struct device *dev = &pdev->dev;
> -	bool legacy_binding;
> +	bool legacy_binding, generic_binding;
>   
>   	if (of_property_read_u32(dev->of_node, "#global-interrupts",
>   				 &smmu->num_global_irqs)) {
> @@ -2132,16 +2132,20 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   
>   	parse_driver_options(smmu);
>   
> -	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
> -	if (legacy_binding && !using_generic_binding) {
> -		if (!using_legacy_binding)
> -			pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
> -		using_legacy_binding = true;
> -	} else if (!legacy_binding && !using_legacy_binding) {
> +	generic_binding = of_find_property(dev->of_node, "#iommu-cells", NULL);
> +	if (generic_binding && !using_legacy_binding) {
>   		using_generic_binding = true;
>   	} else {
> -		dev_err(dev, "not probing due to mismatched DT properties\n");
> -		return -ENODEV;
> +		legacy_binding = of_find_property(dev->of_node, "mmu-masters",
> +						  NULL);
> +		if (legacy_binding && !using_generic_binding) {
> +			if (!using_legacy_binding)
> +				pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
> +			using_legacy_binding = true;
> +		} else {
> +			dev_err(dev, "not probing due to mismatched DT properties\n");
> +			return -ENODEV;
> +		}
>   	}
>   
>   	if (of_dma_is_coherent(dev->of_node))
> 
