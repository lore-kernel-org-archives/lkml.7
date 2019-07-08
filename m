Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D28C606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2132D20645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfGHH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9F72300602A;
        Mon,  8 Jul 2019 07:58:30 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC44D5D9E2;
        Mon,  8 Jul 2019 07:58:27 +0000 (UTC)
Subject: Re: [PATCH 7/8] iommu/arm-smmu-v3: Improve add_device() error
 handling
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-8-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1e35f298-25bb-719a-b314-c46ded4886a3@redhat.com>
Date:   Mon, 8 Jul 2019 09:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190610184714.6786-8-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Jul 2019 07:58:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> Let add_device() clean up behind itself. The iommu_bus_init() function
> does call remove_device() on error, but other sites (e.g. of_iommu) do
> not.
> 
> Don't free level-2 stream tables because we'd have to track if we
> allocated each of them or if they are used by other endpoints. It's not
> worth the hassle since they are managed resources.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 633d829f246f..972bfb80f964 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2398,14 +2398,16 @@ static int arm_smmu_add_device(struct device *dev)
>  	for (i = 0; i < master->num_sids; i++) {
>  		u32 sid = master->sids[i];
>  
> -		if (!arm_smmu_sid_in_range(smmu, sid))
> -			return -ERANGE;
> +		if (!arm_smmu_sid_in_range(smmu, sid)) {
> +			ret = -ERANGE;
> +			goto err_free_master;
> +		}
>  
>  		/* Ensure l2 strtab is initialised */
>  		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
>  			ret = arm_smmu_init_l2_strtab(smmu, sid);
>  			if (ret)
> -				return ret;
> +				goto err_free_master;
>  		}
>  	}
>  
> @@ -2419,13 +2421,25 @@ static int arm_smmu_add_device(struct device *dev)
>  	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>  		master->ssid_bits = min(master->ssid_bits, 10U);
>  
> +	ret = iommu_device_link(&smmu->iommu, dev);
> +	if (ret)
> +		goto err_free_master;
> +
>  	group = iommu_group_get_for_dev(dev);
> -	if (!IS_ERR(group)) {
> -		iommu_group_put(group);
> -		iommu_device_link(&smmu->iommu, dev);
> +	if (IS_ERR(group)) {
> +		ret = PTR_ERR(group);
> +		goto err_unlink;
>  	}
>  
> -	return PTR_ERR_OR_ZERO(group);
> +	iommu_group_put(group);
> +	return 0;
> +
> +err_unlink:
> +	iommu_device_unlink(&smmu->iommu, dev);
> +err_free_master:
> +	kfree(master);
> +	fwspec->iommu_priv = NULL;
> +	return ret;
>  }
>  
>  static void arm_smmu_remove_device(struct device *dev)
> 
