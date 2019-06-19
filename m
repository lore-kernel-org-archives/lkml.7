Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C0C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE67E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7YTlEiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfFSSjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:39:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46991 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSSjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:39:13 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so718357iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upe+kPLR7/GeOqeBD5ktrgjPKSUUFPLYfd4Aq1vyU9c=;
        b=R7YTlEiTJ6NjLuKauQara9BSR2VXFSZ9ykEVmaqb4o0RaxVyI+IXcs7ivnnQCBGn2/
         t4GHFapVL0erq/PKWThOVdPPI7JT1xS1vhTRID/odRFR3qRE3Y0bqjjb9Zst2smtL+pn
         Q7GPhA4zEDlseZS3N6TGzSLN26Bj5Zw/vq8BmDE6bh2yHEfZEDwZ0WYbEzSzYpCBn4BS
         VCG1Uz+MIOib0WSUhSCorBWP2mjjx2BTlaCf+q93Xbz/dWG6QKonDDKj9OE7nGWsi3fd
         A7VyHHaf3/uWN+jHH3ih5/i4y4ewZJVFcFjLBeqv+FDFjKYAt+8YQ3F1w4u8zGrpB9zk
         /MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upe+kPLR7/GeOqeBD5ktrgjPKSUUFPLYfd4Aq1vyU9c=;
        b=c66waBtMLqGQtwUpqKvduSu+VkQesarT4/WYNsRawwFqz9SWmnSwyV67+xbDiEWtIb
         JlGbVtaWII3c+Dx1nGZ1M08cDAbOOLDAk7WPZ+pK9L243Y4jvoAOOgcBt2TAOUreCtDR
         tTieS2Nm0qZ6cA9R7KGF6XebJnA3650pEbHfXT8WDi5zMqMXiQkluj0h3bcUwdv4LSlv
         ZzAe/aDwA2L5Np1YsAuiaLqDq98Bz0WB+cGvOnyyWlVzuU8LZynoaS8Ey/YxUYNeTlm4
         ByXR2bMYPK5M4GHA9on9sr87Vrx6aLmJ7JGeJhVRKb5+PEXXrLfHOR9UkbvVKCtO3paT
         qJYQ==
X-Gm-Message-State: APjAAAWXpFTtXl3zvE4aT4vwLdx0lOU4qpHQrx6ng8LzIPPOuM9B1VD2
        0qdEGSogBb1pCv7E1IF/L6kMeevR
X-Google-Smtp-Source: APXvYqxNceTma3Jg+FVVJiVsrEHC1qmWzZW1+1U3uElHQaPqpEUPKITw1GfT09u4FA8Opx/1JPi1LA==
X-Received: by 2002:a02:1a86:: with SMTP id 128mr99230610jai.95.1560969551259;
        Wed, 19 Jun 2019 11:39:11 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id l5sm16606999ioq.83.2019.06.19.11.39.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 11:39:10 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH] drm/etnaviv: optionally set gpu linear window to cma area
Date:   Wed, 19 Jun 2019 14:38:56 -0400
Message-Id: <20190619183856.467-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Vivante GPUs with an iommu-v1, the gpu linear window's
position must be determined at probe time, and cannot change
during the driver's lifetime.

The existing code attempts to guess a suitable window position
using the dma mask, but this does not always work [1].

According to a recent thread [2], Lucas Stach mentions that
on MC2.0 GPUs, one may simply point the window to the start
of the global cma area.

This patch provides an optional method to set the window
to the cma area, by adding a phandle to the etnaviv driver's
devicetree node, pointing to the global cma area.

Note that on iommu-v2 GPUs, this setting has no effect:
they do not depend on a fixed window position.

<Example>

/ {
	reserved-memory {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		cma_area: linux,cma {
			compatible = "shared-dma-pool";
			reusable;
			size = <0x10000000>;
			linux,cma-default;
		};
	};
};

/* Tell the Vivante GPUS where the CMA area is */

&gpu_3d {
	default-cma-region = <&cma_area>;
};

&gpu_2d {
	default-cma-region = <&cma_area>;
};

</Example>

[1] iMX6Q 2G ram, 256M cma, v5.2-rc4 kernel:
    cma area @ 0x30000000 (auto-assigned by kernel)
    dma mask is 0xffffffff
    driver sets gpu window to 0x80000000
    result: gpu iommu-v1 cannot access cma area

[2] https://lkml.org/lkml/2017/11/15/599

To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

devicetree documentation patch to follow, depending on how this patch
is received.

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 48 +++++++++++++++++++++------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 ++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 72d01e873160..7ed8705744d0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -8,6 +8,7 @@
 #include <linux/dma-fence.h>
 #include <linux/moduleparam.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/regulator/consumer.h>
 #include <linux/thermal.h>
 
@@ -687,6 +688,12 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 			     prefetch);
 }
 
+static bool gpu_is_3d_mc10(const struct etnaviv_chip_identity *id)
+{
+	return (id->features & chipFeatures_PIPE_3D) &&
+		!(id->minor_features0 & chipMinorFeatures0_MC20);
+}
+
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 {
 	int ret, i;
@@ -713,23 +720,33 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto fail;
 	}
 
-	/*
-	 * Set the GPU linear window to be at the end of the DMA window, where
-	 * the CMA area is likely to reside. This ensures that we are able to
-	 * map the command buffers while having the linear window overlap as
-	 * much RAM as possible, so we can optimize mappings for other buffers.
-	 *
-	 * For 3D cores only do this if MC2.0 is present, as with MC1.0 it leads
-	 * to different views of the memory on the individual engines.
-	 */
-	if (!(gpu->identity.features & chipFeatures_PIPE_3D) ||
-	    (gpu->identity.minor_features0 & chipMinorFeatures0_MC20)) {
+	if (!gpu_is_3d_mc10(&gpu->identity) && gpu->cma_base) {
+		/*
+		 * If we know the location of the CMA area, point the
+		 * GPU linear window to it. This ensures that we are able to
+		 * map the command buffers while having the linear window
+		 * overlap as much RAM as possible, so we can optimize mappings
+		 * for other buffers.
+		 */
+		gpu->memory_base = (u32)gpu->cma_base;
+	} else if (!gpu_is_3d_mc10(&gpu->identity)) {
+		/*
+		 * Set the GPU linear window to be at the end of the DMA window,
+		 * where the CMA area is likely to reside. In most cases, this
+		 * ensures that we are able to map the command buffers while
+		 * having the linear window overlap as much RAM as possible, so
+		 * we can optimize mappings for other buffers.
+		 */
 		u32 dma_mask = (u32)dma_get_required_mask(gpu->dev);
 		if (dma_mask < PHYS_OFFSET + SZ_2G)
 			gpu->memory_base = PHYS_OFFSET;
 		else
 			gpu->memory_base = dma_mask - SZ_2G + 1;
 	} else if (PHYS_OFFSET >= SZ_2G) {
+		/*
+		 * For MC1.0 3D cores, moving the linear window leads to
+		 * different views of the memory on the individual engines.
+		 */
 		dev_info(gpu->dev, "Need to move linear window on MC1.0, disabling TS\n");
 		gpu->memory_base = PHYS_OFFSET;
 		gpu->identity.features &= ~chipFeatures_FAST_CLEAR;
@@ -1709,7 +1726,9 @@ MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
 
 static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 {
+	struct reserved_mem *rmem = NULL;
 	struct device *dev = &pdev->dev;
+	struct device_node *node;
 	struct etnaviv_gpu *gpu;
 	struct resource *res;
 	int err;
@@ -1718,6 +1737,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (!gpu)
 		return -ENOMEM;
 
+	node = of_parse_phandle(dev->of_node, "default-cma-region", 0);
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+	if (rmem)
+		gpu->cma_base = rmem->base;
+
 	gpu->dev = &pdev->dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->fence_lock);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 9bcf151f706b..3e968b395a72 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -106,6 +106,8 @@ struct etnaviv_gpu {
 
 	/* bus base address of memory  */
 	u32 memory_base;
+	/* base of the cma area */
+	phys_addr_t cma_base;
 
 	/* event management: */
 	DECLARE_BITMAP(event_bitmap, ETNA_NR_EVENTS);
-- 
2.17.1

