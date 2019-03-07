Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CA620851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCGPR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:17:57 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:17:57 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsrV2-1gmjPT1ofQ-00tC3t; Thu, 07 Mar 2019 16:17:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dmaengine: omap-dma: make omap_dma_filter_fn private
Date:   Thu,  7 Mar 2019 16:16:09 +0100
Message-Id: <20190307151646.1016966-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190307151646.1016966-1-arnd@arndb.de>
References: <20190307151646.1016966-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nBbEoXNunGoswjO+f6BrSVCztX4BCUBg4VQTJBpJ7EeSO7fsZXx
 kNFmU0I1zJ5hxjK4o1FHlEMQdpNk64xMCjDIMEF1fhfC0kMXml3sb49g7VP9bnB2nBv8d7U
 UYa3QGirbDMn6j/79M8MImQmWPNkjJTIpqQH7D3jx3KC64plLm6W3UhVnVISDubTDQ98vux
 SLHiWEhM+t+c3eeCAeURQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y06xl6dcahY=:sqNdPImkh60jq2Io1jTQaE
 Q1uJA7aCyc7bndqCPSvIn9RPP07LjpSVx2ObrG6d7zAQuiN5/1V9pUlNBfapZfArzwnWV2sQr
 1X2/LZyw9wFWN0VNJq6pG/uC4UUiUhwkY5rKbvxl+6+j0O0RxgtwtaM6OItdwAyxstTuow3dN
 qb2srxf21m60+9Bb9LiuNt9BPKDIVMo4xUl6ZG9OuSlzoVubTfh4SmHEFPGATmXOvFDWDCXvG
 XGVzAbVdgueHhYqaa83QNAoMRV8AxxgxXojuvkADnNuDRJOUlGJAyIRi9DaB413HHksXYZ/M5
 ALXvG2onR1hGS0RKR5boxrJcat4NhSIQhtpcJKL+ijD/pFpb2/B7HRo88my0q2xz7IrOxdOEf
 Zsa2OYUNOqGB72wSqiwXnhX17vtYcfW/EUOF/3cQJ3JFru7bfsJHUZudkWrNocrekUX1obgGw
 9khgtP8C+SUCtz2iANYotczknpJe5DEGJZYflYwT5zxQ1egL9q/NQE/r2lDQ3eWZUwmr5PXPR
 HqKuX+ni3ljwstdNJC4hAFODQ86tbGdsiGgNAuTt2iGseItoonaZ6N4+wVymR/WZYBDZwOHz4
 v0LNC+GjfKqn4MRWAdAfYqDjL01wyqbU5U9lsoMgaNNrYGdm0jik9rcDyZBzkyGSTerzpGNos
 jZHYw00bWGzqlpefXYgXuXv45TJJmn8ASLWLNINQLhIvV67feM9Jv5AqxIgq+i1Co5an/LlTy
 3qTfxq4NmFlW+4qYvcslPgxozNS24wqUIFtxWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the audio driver no longer referring to this function, it
can be made private to the dmaengine driver itself, and the
header file removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/omap-dma.c      |  3 ++-
 include/linux/omap-dma.h       |  2 --
 include/linux/omap-dmaengine.h | 21 ---------------------
 3 files changed, 2 insertions(+), 24 deletions(-)
 delete mode 100644 include/linux/omap-dmaengine.h

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a4a931ddf6f6..5bf635ba234d 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -205,6 +205,7 @@ static const unsigned es_bytes[] = {
 	[CSDP_DATA_TYPE_32] = 4,
 };
 
+static bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
 static struct of_dma_filter_info omap_dma_info = {
 	.filter_fn = omap_dma_filter_fn,
 };
@@ -1640,7 +1641,7 @@ static struct platform_driver omap_dma_driver = {
 	},
 };
 
-bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
+static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	if (chan->device->dev->driver == &omap_dma_driver.driver) {
 		struct omap_dmadev *od = to_omap_dma_dev(chan->device);
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 840ce551e773..ba3cfbb52312 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_OMAP_DMA_H
 #define __LINUX_OMAP_DMA_H
-#include <linux/omap-dmaengine.h>
-
 /*
  *  Legacy OMAP DMA handling defines and functions
  *
diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
deleted file mode 100644
index 8e6906c72e90..000000000000
--- a/include/linux/omap-dmaengine.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * OMAP DMA Engine support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __LINUX_OMAP_DMAENGINE_H
-#define __LINUX_OMAP_DMAENGINE_H
-
-struct dma_chan;
-
-#if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
-bool omap_dma_filter_fn(struct dma_chan *, void *);
-#else
-static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
-{
-	return false;
-}
-#endif
-#endif /* __LINUX_OMAP_DMAENGINE_H */
-- 
2.20.0

