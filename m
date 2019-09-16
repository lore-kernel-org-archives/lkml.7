Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89981206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfIPKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:46:16 -0400
Received: from foss.arm.com ([217.140.110.172]:43194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbfIPKqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:46:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C462F1000;
        Mon, 16 Sep 2019 03:46:15 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC62A3F59C;
        Mon, 16 Sep 2019 03:46:12 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Axe a useless test in
 'arm_smmu_master_alloc_smes()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        will@kernel.org, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190915193401.27426-1-christophe.jaillet@wanadoo.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <de9ee628-9efb-3078-590c-6852be61c7d2@arm.com>
Date:   Mon, 16 Sep 2019 11:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190915193401.27426-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2019 20:34, Christophe JAILLET wrote:
> 'ommu_group_get_for_dev()' never returns NULL, so this test can be removed.

Nit: typo in the function name.

Otherwise, there definitely used to be some path where a NULL return 
could leak out, so I would have had that in mind at the time I wrote 
this, but apparently I never noticed that that had already been cleaned 
up by the time this got merged.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/iommu/arm-smmu.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c3ef0cc8f764..6fae8cdbe985 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1038,8 +1038,6 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
>   	}
>   
>   	group = iommu_group_get_for_dev(dev);
> -	if (!group)
> -		group = ERR_PTR(-ENOMEM);
>   	if (IS_ERR(group)) {
>   		ret = PTR_ERR(group);
>   		goto out_err;
> 
