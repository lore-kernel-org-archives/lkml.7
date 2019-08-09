Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DACC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AA72166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QPLLSo/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406284AbfHIKBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:01:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40320 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIKBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:01:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79A0fRI048307;
        Fri, 9 Aug 2019 05:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565344841;
        bh=j7mV9yfiX1/T+LAXN7sKBAuBWQGSmBtE1m1dH8dWDMg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QPLLSo/c7PIM3IuGLr4tUxL+fOeHcEbojhZeuCoDWET+gNyhZpH6nmpNZaHGQBVqj
         DNMViz9lSN0NsV7J62W8tS312+ItZBvVahpOkRRl20KnZxzYEJnTOHZ4Mqqr1H55pO
         F+wWLyu8c25UQA5TzPsQSgN4Dm2lBLMw9gis9LUQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79A0fBs067623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 05:00:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 05:00:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 05:00:41 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79A0dKm006580;
        Fri, 9 Aug 2019 05:00:39 -0500
Subject: Re: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
To:     Christoph Hellwig <hch@lst.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190808101042.18809-1-hch@lst.de>
 <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com> <20190809080750.GA21874@lst.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <c219e7e6-0f66-d6fd-e0cf-59c803386825@ti.com>
Date:   Fri, 9 Aug 2019 13:00:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809080750.GA21874@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 11:07, Christoph Hellwig wrote:
> On Fri, Aug 09, 2019 at 09:40:32AM +0300, Tomi Valkeinen wrote:
>> We do call dma_set_coherent_mask() in omapdrm's probe() (in omap_drv.c),
>> but apparently that's not enough anymore. Changing that call to
>> dma_coerce_mask_and_coherent() removes the WARN. I can create a patch for
>> that, or Christoph can respin this one.
> 
> Oh, yes - that actually is the right thing to do here.  If you already
> have it please just send it out.
> 
>>
>> I am not too familiar with the dma mask handling, so maybe someone can
>> educate:
>>
>> dma_coerce_mask_and_coherent() overwrites dev->dma_mask. Isn't that a bad
>> thing? What if the platform has set dev->dma_mask, and the driver
>> overwrites it with its value? Or who is supposed to set dev->dma_mask?
> 
> ->dma_mask is a complete mess.  It is a pointer when it really should
> just be a u64, and that means every driver layer has to allocate space
> for it.  We don't really do that for platform_devices, as that breaks
> horribly assumptions in the usb code.  That is why
> dma_coerce_mask_and_coherent exists as a nasty workaround that sets
> the dma_mask to the coherent_dma_mask for devices that don't have
> space for ->dma_mask allocated, which works as long as the device
> doesn't have differnet addressing requirements for both.
> 
> I'm actually working to fix that mess up at the moment, but it is going
> to take a few cycles until everything falls into place.

Alright, thanks for the clarification!

Here's my version.

From c258309e36fc86076db155aead03a3900b96c3d4 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 9 Aug 2019 09:54:49 +0300
Subject: [PATCH] drm/omap: ensure we have a valid dma_mask

The omapdrm driver uses dma_set_coherent_mask(), but that's not enough
anymore when LPAE is enabled.

From Christoph Hellwig <hch@lst.de>:

The traditional arm DMA code ignores, but the generic dma-direct/swiotlb
has stricter checks and thus fails mappings without a DMA mask.  As we
use swiotlb for arm with LPAE now, omapdrm needs to catch up and
actually set a DMA mask.

Change the dma_set_coherent_mask() call to
dma_coerce_mask_and_coherent() so that the dev->dma_mask is also set.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 288c59dae56a..1bad0a2cc5c6 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -669,7 +669,7 @@ static int pdev_probe(struct platform_device *pdev)
 	if (omapdss_is_initialized() == false)
 		return -EPROBE_DEFER;
 
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set the DMA mask\n");
 		return ret;




-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
