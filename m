Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57521C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3384B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:10:34 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42088 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDKIKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:10:33 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6C63625AD6D;
        Thu, 11 Apr 2019 18:10:31 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id ED1A2940356; Thu, 11 Apr 2019 10:10:28 +0200 (CEST)
Date:   Thu, 11 Apr 2019 10:10:28 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Message-ID: <20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-2-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> /sys/class/iommus/, but their "devices" subdirectories are empty.

Hi Geert,

Should the path be /sys/class/iommu/ (no trailing 's') ?

> Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> 
> Make sure all links are created, on both arm32 and arm64.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9a380c10655e182d..9f2b781e20a0eba6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
>  
>  static int ipmmu_add_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>  	struct iommu_group *group;
> +	int ret;
>  
>  	/*
>  	 * Only let through devices that have been verified in xlate()
>  	 */
> -	if (!to_ipmmu(dev))
> +	if (!mmu)
>  		return -ENODEV;
>  
> -	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> -		return ipmmu_init_arm_mapping(dev);
> +	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> +		ret = ipmmu_init_arm_mapping(dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		group = iommu_group_get_for_dev(dev);
> +		if (IS_ERR(group))
> +			return PTR_ERR(group);
>  
> -	group = iommu_group_get_for_dev(dev);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +		iommu_group_put(group);
> +	}
>  
> -	iommu_group_put(group);
> +	iommu_device_link(&mmu->iommu, dev);
>  	return 0;
>  }
>  
>  static void ipmmu_remove_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> +
> +	iommu_device_unlink(&mmu->iommu, dev);
>  	arm_iommu_detach_device(dev);
>  	iommu_group_remove_device(dev);
>  }
> -- 
> 2.17.1
> 
