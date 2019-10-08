Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A333D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570563719;
	bh=md3URdiVZXHNYYHdfhv8UFfznw+hOvoIoyHSdc6QhXM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q8iNfbU3zV2ga55v0UNZKt7u15NXPqxa9EP6N1KS0hQWiZpNbNKTbgHfhWhJLnzzi
	 cTyrAMgbD8x6GjSW+XX3geuIpOEovEzcdGZMLwwRrS6JKWsTR6GYJK4S70RnQF2mGX
	 q1T8PsrweSKqFZzc1GKmuArnbBq3LqMtBNatDQKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfJHTl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:41:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39880 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfJHTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:41:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so15080527otr.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cM/iEPaCvfOjsvb7CWmfva5BP/wvMw5x+2gKptZwcOk=;
        b=uSqWXO6GLiY71U/ccJ9Cr4TL2f3ge48+x6oNa61dPxTmLbU8XUOhF8y/cFSLqB/faB
         AGXR7KxtIRbQ6crMPKwcAPm/FeCfDB2Bh8+1Jq6aeRD5SnDwsr8kfAzODnVS/YXHfKnd
         k2v6aZpbkFui1gh1vAoadJjN2XqQiEZTBOEhJocURIJ0KXxlNaY6zvQ0Lmmg5MY0C6Uc
         oolhGzDY60sLH1467/n1cqbxFp1QsqE6jFSc375YAgIiapQXHCTypgrPIlZ3dDSkl6qS
         UmWPdpijHZrl5JCyQ9nWKsJD2XdFcUdQTAE83jOiU0fap3gEnXiTSWBAkWe0bxSR9MUX
         YZyQ==
X-Gm-Message-State: APjAAAXUoTweNjyxSl2x2C7Ty4sL04vlYXbN1klzc+ZxijHljm1/ntWd
        VMIxL4i5D/az45eYfAgx3Q==
X-Google-Smtp-Source: APXvYqxBTulxVQeCUzNrniHc4WOTx+3wOd+GgT82xa9DGnUA1ysJ04S1+2IdRLJi/4rEbo0Ce1tAvg==
X-Received: by 2002:a9d:7418:: with SMTP id n24mr2934782otk.19.1570563717135;
        Tue, 08 Oct 2019 12:41:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z12sm5364645oth.71.2019.10.08.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:41:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     xen-devel@lists.xenproject.org
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] xen: Stop abusing DT of_dma_configure API
Date:   Tue,  8 Oct 2019 14:41:55 -0500
Message-Id: <20191008194155.4810-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the removed comments say, these aren't DT based devices.
of_dma_configure() is going to stop allowing a NULL DT node and calling
it will no longer work.

The comment is also now out of date as of commit 9ab91e7c5c51 ("arm64:
default to the direct mapping in get_arch_dma_ops"). Direct mapping
is now the default rather than dma_dummy_ops.

According to Stefano and Oleksandr, the only other part needed is
setting the DMA masks and there's no reason to restrict the masks to
32-bits. So set the masks to 64 bits.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Setup dma masks
 - Also fix xen_drm_front.c
 
This can now be applied to the Xen tree independent of the coming
of_dma_configure() changes.

Rob

 drivers/gpu/drm/xen/xen_drm_front.c | 12 ++----------
 drivers/xen/gntdev.c                | 13 ++-----------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index ba1828acd8c9..4be49c1aef51 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -718,17 +718,9 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	struct device *dev = &xb_dev->dev;
 	int ret;
 
-	/*
-	 * The device is not spawn from a device tree, so arch_setup_dma_ops
-	 * is not called, thus leaving the device with dummy DMA ops.
-	 * This makes the device return error on PRIME buffer import, which
-	 * is not correct: to fix this call of_dma_configure() with a NULL
-	 * node to set default DMA ops.
-	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	ret = of_dma_configure(dev, NULL, true);
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret < 0) {
-		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
+		DRM_ERROR("Cannot setup DMA mask, ret %d", ret);
 		return ret;
 	}
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index a446a7221e13..81401f386c9c 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -22,6 +22,7 @@
 
 #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -34,9 +35,6 @@
 #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/refcount.h>
-#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
-#include <linux/of_device.h>
-#endif
 
 #include <xen/xen.h>
 #include <xen/grant_table.h>
@@ -625,14 +623,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	flip->private_data = priv;
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	priv->dma_dev = gntdev_miscdev.this_device;
-
-	/*
-	 * The device is not spawn from a device tree, so arch_setup_dma_ops
-	 * is not called, thus leaving the device with dummy DMA ops.
-	 * Fix this by calling of_dma_configure() with a NULL node to set
-	 * default DMA ops.
-	 */
-	of_dma_configure(priv->dma_dev, NULL, true);
+	dma_coerce_mask_and_coherent(priv->dma_dev, DMA_BIT_MASK(64));
 #endif
 	pr_debug("priv %p\n", priv);
 
-- 
2.20.1

