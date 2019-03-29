Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34782075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBYY1Sv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfC2NUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:20:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57470 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbfC2NUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:20:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TDKWai082957;
        Fri, 29 Mar 2019 08:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553865632;
        bh=hIq02XTu7G3LA7AoXLszcyxgos1nraHFEvJT3ZFAFaM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TBYY1Sv8bTxRxQeO4eT6p+btyRWk612iOaWadmQaOf1xw7rucoOrpb0pbWnC9fXnR
         K9qrAgvVqTbRsTywkt25w2VQXrtj8DA+hKhSrzoRJpfPRoW1mXoVnGd5ATSbdPpttl
         3GJyYZUKcdLtVc3/mh8KIDcxzwO8++5tpCFM3G0E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TDKWmF018783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 08:20:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 08:20:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 08:20:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TDKS0A003589;
        Fri, 29 Mar 2019 08:20:29 -0500
Subject: Re: [PATCH] dma: ti: fix a missing check in omap_dma_prep_dma_cyclic
To:     Kangjie Lu <kjlu@umn.edu>
CC:     <pakki001@umn.edu>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190323223948.13885-1-kjlu@umn.edu>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0278855a-d851-4336-1abd-248b38fb939b@ti.com>
Date:   Fri, 29 Mar 2019 15:21:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190323223948.13885-1-kjlu@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2019 0.39, Kangjie Lu wrote:
> It is invalid when "buf_len" is not aligned with "period_len".
> 
> The fix adds a check for the alignment.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/dma/ti/omap-dma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a4a931ddf6f6..5f0ce1975e52 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1065,6 +1065,9 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>  	unsigned es;
>  	u32 burst;
>  
> +	if (buf_len % period_len)
> +		return NULL;
> +

if it really happens, then it might be better to do the check in
dmaengine_prep_dma_cyclic() rather than fixing _all_ drivers?

>  	if (dir == DMA_DEV_TO_MEM) {
>  		dev_addr = c->cfg.src_addr;
>  		dev_width = c->cfg.src_addr_width;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
