Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B9C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FAB2465A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0vLtx81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgABWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:31:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50134 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgABWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:30:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 002MUgnv064697;
        Thu, 2 Jan 2020 16:30:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578004242;
        bh=u/NjnNFDv+DUjWFH0ZddWGRh3O0gXqdBXm664jtPmcM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=h0vLtx81Nijrya0QkJAbUn8q4GVV76NzhkqR9m8sKlNpODjCBpCqwATbV+niICcjT
         W4X5GSdr6VI47oYFty0egsWwnUVuyqjZLBtiQViGMI3m1BdvASAlE2y51tE3/p70pY
         TrU1mCQV0MDln72oUwvtQqfanbD+YQzNQOG+NPes=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 002MUggq073137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jan 2020 16:30:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Jan
 2020 16:30:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Jan 2020 16:30:42 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 002MUgIU053811;
        Thu, 2 Jan 2020 16:30:42 -0600
Subject: Re: [PATCH 2/3] iommu: omap: Fix printing format for size_t on 64-bit
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tero Kristo <t-kristo@ti.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20191230172619.17814-1-krzk@kernel.org>
 <20191230172619.17814-2-krzk@kernel.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2c797855-1967-007e-bbbc-e9f414fc9887@ti.com>
Date:   Thu, 2 Jan 2020 16:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191230172619.17814-2-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 11:26 AM, Krzysztof Kozlowski wrote:
> Print size_t as %zu or %zx to fix -Wformat warnings when compiling on
> 64-bit platform (e.g. with COMPILE_TEST):
> 
>     drivers/iommu/omap-iommu.c: In function ‘flush_iotlb_page’:
>     drivers/iommu/omap-iommu.c:437:47: warning:
>         format ‘%x’ expects argument of type ‘unsigned int’,
>         but argument 7 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

With "iommu/omap: ..." on the subject-line as per the current convention,

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/iommu/omap-iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 50e8acf88ec4..887fefcb03b4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -434,7 +434,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
>  		bytes = iopgsz_to_bytes(cr.cam & 3);
>  
>  		if ((start <= da) && (da < start + bytes)) {
> -			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
> +			dev_dbg(obj->dev, "%s: %08x<=%08x(%zx)\n",
>  				__func__, start, da, bytes);
>  			iotlb_load_cr(obj, &cr);
>  			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> @@ -1352,11 +1352,11 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
>  
>  	omap_pgsz = bytes_to_iopgsz(bytes);
>  	if (omap_pgsz < 0) {
> -		dev_err(dev, "invalid size to map: %d\n", bytes);
> +		dev_err(dev, "invalid size to map: %zu\n", bytes);
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%x\n", da, &pa, bytes);
> +	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%zx\n", da, &pa, bytes);
>  
>  	iotlb_init_entry(&e, da, pa, omap_pgsz);
>  
> @@ -1393,7 +1393,7 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  	size_t bytes = 0;
>  	int i;
>  
> -	dev_dbg(dev, "unmapping da 0x%lx size %u\n", da, size);
> +	dev_dbg(dev, "unmapping da 0x%lx size %zu\n", da, size);
>  
>  	iommu = omap_domain->iommus;
>  	for (i = 0; i < omap_domain->num_iommus; i++, iommu++) {
> 

