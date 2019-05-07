Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D1821479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maZFVIBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEGGKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33821 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEGGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so7743160pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QS4oURfHIZFUpa7KdJQnPIiOEuTfxlscK4edcryrvp4=;
        b=maZFVIBNrGmfcQkxEh1uEEdXnaUgHkn3AsT3Rf/6klFaj6bfdmt1TliBoh7dY/CcSx
         YInGUoE9/OW4UzgCS1ptn9nWpJ97rk4CGoDlUcraSG3BFloczr+Y862nxym6+52jMg0z
         VIwqdFmTKB/etS/WqQfKc45L9vn2ZbxUpoSvWbYU0JTCOfaSy+jrOo47Hb3vNWNYuAA4
         16TmzMN6uOMSc0NFoCSnkAm3i0sIMCtXl4saaqrFyn7gVT8BoIfXwfPQecLimNaDvq2z
         iuP/ykZ9Vpch7A1Z9HwQxiVZlsFLXcLjGq79ZTZy45jB9ERN2ejUJC9wkHSAv+p/yfXy
         D4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QS4oURfHIZFUpa7KdJQnPIiOEuTfxlscK4edcryrvp4=;
        b=H/eLbhPZJy/YH/uGrXXrk0+ELiVteOv+kZQ7MNTDymhQcXnkRawC4vnXAFFk5EeIsI
         0W0qvphYfau/YENWy+gMmEQU6fPSu33l4VSiQ2ifSJuUQ6wjrrw8KTwmG8xjcO2OjGhm
         Acx4nWgRk8p2dDJtgXoBVKUAcno3RuHo7BN7t85b119/DFi49jQOYZTLXDXPNmGaHpQW
         UcBxMjE9uhnp8QG0GwHlqUXVcanmisp9dgodvLo5nj5Ss3TW7pVpdvamR0igEKS9nahN
         X9+tuoruBiPow9rnJPsZRAoRN61qH7L/TGJ6zbgOfFmUyPo95DJV0wCFdn/bEAn3M5PQ
         d6rA==
X-Gm-Message-State: APjAAAVahru177VHzgHqV7D7ChAN9jBkxfOWzhEIVTt3Ws/Zy9oMNRLr
        8RYZ1ltHXQEBFfszr8/DHNnT2Q==
X-Google-Smtp-Source: APXvYqyMCecB9APKxojYDXIZUFxgGkKIgYuzDbt4utaG9C2XtwojM6Mg5/IhTiAoLuBssJD5TQCV+Q==
X-Received: by 2002:a63:42:: with SMTP id 63mr37776526pga.337.1557209443520;
        Mon, 06 May 2019 23:10:43 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] dmaengine: sh: rcar-dmac: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:44 +0800
Message-Id: <e5a9e3101218d5216dae62da447e9a80d04a741e.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sh/rcar-dmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 2b4f256..9474d5b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1632,8 +1632,7 @@ static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	 * Forcing it to call dma_request_channel() and iterate through all
 	 * channels from all controllers is just pointless.
 	 */
-	if (chan->device->device_config != rcar_dmac_device_config ||
-	    dma_spec->np != chan->device->dev->of_node)
+	if (chan->device->device_config != rcar_dmac_device_config)
 		return false;
 
 	return !test_and_set_bit(dma_spec->args[0], dmac->modules);
@@ -1653,7 +1652,8 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, rcar_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, rcar_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

