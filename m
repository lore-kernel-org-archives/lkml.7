Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A00C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54012173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="WzoZBkJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfEVU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43224 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfEVU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so3390422lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqCPCoACDLrIdM2VOYCKs6C/ASVTEPrZ/Yn9ydg742c=;
        b=WzoZBkJGbm5qEiA84+al1JaNL937RHDrIzHIaDa+oIzzgavjzI3SIWy1BnK3DnnZjr
         yS7hceBfhWvsTxQdJSwWfu82DMyyBpIZlrjUQjWn4FbNHpWFI3vEkMYZxISorNAsP22H
         s6v2VJ+BfyEFYA8/AMmCtLEinMpOfkUi//ygzs5lgCCVG7hfSJPKSvAC4b+SrK8l1hiH
         Hc7qcVm6oAg/xMY6sOcSTNldk+Uql19kWIbjwNAMYp497mCWBV7iRyErNNgDtTgepBSS
         g2S+jOALtneoHm8KCcDcAqjW1FrQncom+ufUWBuipr2rtwPUVujnmQW+A+TBywLkolnz
         b2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqCPCoACDLrIdM2VOYCKs6C/ASVTEPrZ/Yn9ydg742c=;
        b=ZC90T7am4EzgyrCul1jOu3rpdg6vTgxxTp6JZc81cR9RVDl5NuedHuvVxm8fq5sUWu
         vplMmrkWKHFLYwiXNgkZavIXdPcKwOvTcD16P94uJkUt6W4FLUf0pnOJJnvud21R9jYF
         ct9yQt0GhyMG3R1w1FOyJmmzvteGADtapeI7ZU05lukPdg0tnUJDQcsChFjM+i3YM2lL
         0F9DVp9wPx9sK0AulecbIJKU1VxrJQpiLQCaAHLOiD8E/GYqulQRZQPLyZ7KimyVl7sz
         cnBFKHMl/sHfLKIKsYP2i3xI7p3/LUWYPgv0Nr13Sx66hMOkRMTsQ4ki8SrQoav2ZXIr
         TtLQ==
X-Gm-Message-State: APjAAAVjQF7Wv01e0yS2WBXiw3fp7+F3tHjkUnHa8eBfIRM/5KDvDjrh
        KuNND58JabQo8k36pzq2pyK6CQ==
X-Google-Smtp-Source: APXvYqxdqwcnA4Gt04dhqh8/LTKwWjx/XQP8Sw0q0xNbi8DWVzr6YGYmpbMRVZ39CmrD3Ty60zI1SA==
X-Received: by 2002:a2e:8796:: with SMTP id n22mr35380065lji.75.1558558755267;
        Wed, 22 May 2019 13:59:15 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:14 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 6/6] staging: kpc2000: remove invalid spaces in cell_probe.c
Date:   Wed, 22 May 2019 22:58:49 +0200
Message-Id: <20190522205849.17444-7-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522205849.17444-1-simon@nikanor.nu>
References: <20190522205849.17444-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error "space prohibited before/after that
parenthesis".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 7d4986502013..98a7a3194519 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -388,7 +388,7 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 
 	// S2C Engines
 	for (i = 0 ; i < 32 ; i++) {
-		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
+		capabilities_reg = readq(pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i));
 		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), i,  pcard->pdev->irq);
 			if (err)
@@ -397,7 +397,7 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 	}
 	// C2S Engines
 	for (i = 0 ; i < 32 ; i++) {
-		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
+		capabilities_reg = readq(pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i));
 		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32 + i,  pcard->pdev->irq);
 			if (err)
-- 
2.20.1

