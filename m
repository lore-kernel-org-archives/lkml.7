Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486AECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E25206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTONc3g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfJGMUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:20:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43810 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfJGMUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:20:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97CKTjO021578;
        Mon, 7 Oct 2019 07:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570450829;
        bh=7bKj1mNBNtUSIdmMJZZwZHQ0QlBSZkbso7CXV6MGnAw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sTONc3g1vwclMmaf/EZI7bG4LCnKgsOClg1cx9Dx/IVYFFlRts0gVTWbAD5Nr+0MR
         Jc3iam1lLY67jLbb6EHTysAZjbYNHOaVEnjD/G6xQccwZWrAbt0xn1Iq9eUqwFlKU9
         vk6cOVWB7GMCoHwi41WqGekVl7iZEt6BdZXFGrz0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97CKT6V059377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 07:20:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 07:20:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 07:20:26 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97CKPUo077641;
        Mon, 7 Oct 2019 07:20:26 -0500
Subject: Re: [PATCH] usb: cdns3: Fix for incorrect DMA mask.
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>
References: <1570449803-15299-1-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <fc2b8ebb-f7f8-555e-ec36-bad2e531d194@ti.com>
Date:   Mon, 7 Oct 2019 15:20:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570449803-15299-1-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2019 15:03, Pawel Laszczak wrote:
> This patch restores the correct DMA mask after switching back to device
> mode.
> The issue occurred because Device part of controller use 32 bits DMA and
> Host side use 64 bits DMA. During loading XHCI driver the DMA mask
> used by driver is overwritten by XHCI driver so it must be restored
> to 32 bits.
> 
> Reported-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

Tested-by: Roger Quadros <rogerq@ti.com>

> ---
>   drivers/usb/cdns3/gadget.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 157536753b8c..2ca280f4c054 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2663,6 +2663,13 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
>   {
>   	int ret = 0;
>   
> +	/* Ensure 32-bit DMA Mask in case we switched back from Host mode */
> +	ret = dma_set_mask_and_coherent(cdns->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(cdns->dev, "Failed to set dma mask: %d\n", ret);
> +		return ret;
> +	}
> +
>   	cdns3_drd_switch_gadget(cdns, 1);
>   	pm_runtime_get_sync(cdns->dev);
>   
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
