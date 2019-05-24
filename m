Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3BAC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0228E217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FxmwRazM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfEXChm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:37:42 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46513 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:37:41 -0400
Received: by mail-ua1-f68.google.com with SMTP id a95so2956749uaa.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RENNt8ptqBe5aR4wFWWSl1w/4lboaHznHsC3/mWNA=;
        b=FxmwRazMYp6zFP+s/5xXuoyTsMgZ5hsK+7CnZabNco8fxkDe5S1kotafNuhgS/m31r
         Wk8AJMvL4xmyYPlEFfIxc/ZTS9/uZhL/JR5d4VTZzaK4PRGIuzEXoepMSx66z2uNDXwO
         taaau4QU5Aht+vCJxhjs4XC/nUpfTif10/vsdkJ/ieGDoz37Bbghu70sspeNmKQFsy3O
         M0h2FR1nk8aGONnPq6v+y7vKBnOTAHbHkVPL3d/0ie/H4mZf1UcVbobIXtOqQgzVoYSb
         VblSvR56Z3fO0r5oXB/6yPzQmJ4BT+tJcWat7jCfN4Mf6DuShrC1QON7gJdD2Mw25ggV
         mZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RENNt8ptqBe5aR4wFWWSl1w/4lboaHznHsC3/mWNA=;
        b=tPQmwoYas3S0mZ3YhfhTeWTla8DJW0oGteLgNaF5aUkIW2Jm/mUEtHyoE4jvPNOEls
         YRRs9HYVV9Kko1VU58dlizs+qs3MAIfpET4ePXYq9rUx0NS+iWgZTx/O8fdvfC0hBnSE
         KrXdw5Ezbt0yydP9mdK4VNRcw1MrkXWjxG89yVrA8F6yBQ1WYXJ0vIHWpBNTru+EmOS/
         qxbpLD37hL42z9JzE7UeFpTkmWnZMZhf9O8gKwddamtVoKfdS8EOqwRdreuVNbxI2vvB
         GaxLKP8lZc4gIRuRcdYudIoNOMOh8CLqdmMm8eMgLYx2S/dWcFsMd9+esSGvhJicOdF6
         +TAQ==
X-Gm-Message-State: APjAAAXUkwri04F442Rc+SEa6I1/9TjS5OZ183B1+pptI+bcA3L065H/
        U6Qmz2p2vM8xX4tE09PROyuPuw==
X-Google-Smtp-Source: APXvYqyLZhcMiUNQP58oRldrpIe1o1emae5Fhiz9Fd52qOrj6TZxcFhAKp+myirlu8bobh2O0IGTcQ==
X-Received: by 2002:ab0:e08:: with SMTP id g8mr20255829uak.32.1558665460085;
        Thu, 23 May 2019 19:37:40 -0700 (PDT)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d5sm392837vka.34.2019.05.23.19.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 19:37:39 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     thellstrom@vmware.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] drm/vmwgfx: fix a warning due to missing dma_parms
Date:   Thu, 23 May 2019 22:37:19 -0400
Message-Id: <20190524023719.1495-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting up with DMA_API_DEBUG_SG=y generates a warning below due to the
driver forgot to set dma_parms appropriately. Set it after
vmw_dma_masks(), so it can choose a size either DMA_BIT_MASK(64) or
DMA_BIT_MASK(44).

DMA-API: vmwgfx 0000:00:0f.0: mapping sg segment longer than device
claims to support [len=2097152] [max=65536]
WARNING: CPU: 2 PID: 261 at kernel/dma/debug.c:1232
debug_dma_map_sg+0x360/0x480
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 04/13/2018
RIP: 0010:debug_dma_map_sg+0x360/0x480
Call Trace:
 vmw_ttm_map_dma+0x3b1/0x5b0 [vmwgfx]
 vmw_bo_map_dma+0x25/0x30 [vmwgfx]
 vmw_otables_setup+0x2a8/0x750 [vmwgfx]
 vmw_request_device_late+0x78/0xc0 [vmwgfx]
 vmw_request_device+0xee/0x4e0 [vmwgfx]
 vmw_driver_load.cold+0x757/0xd84 [vmwgfx]
 drm_dev_register+0x1ff/0x340 [drm]
 drm_get_pci_dev+0x110/0x290 [drm]
 vmw_probe+0x15/0x20 [vmwgfx]
 local_pci_probe+0x7a/0xc0
 pci_device_probe+0x1b9/0x290
 really_probe+0x1b5/0x630
 driver_probe_device+0xa3/0x1a0
 device_driver_attach+0x94/0xa0
 __driver_attach+0xdd/0x1c0
 bus_for_each_dev+0xfe/0x150
 driver_attach+0x2d/0x40
 bus_add_driver+0x290/0x350
 driver_register+0xdc/0x1d0
 __pci_register_driver+0xda/0xf0
 vmwgfx_init+0x34/0x1000 [vmwgfx]
 do_one_initcall+0xe5/0x40a
 do_init_module+0x10f/0x3a0
 load_module+0x16a5/0x1a40
 __se_sys_finit_module+0x183/0x1c0
 __x64_sys_finit_module+0x43/0x50
 do_syscall_64+0xc8/0x606
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: fb1d9738ca05 ("drm/vmwgfx: Add DRM driver for VMware Virtual GPU")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bf6c3500d363..5c567b81174f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -747,6 +747,13 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (unlikely(ret != 0))
 		goto out_err0;
 
+	dev->dev->dma_parms =  kzalloc(sizeof(*dev->dev->dma_parms),
+				       GFP_KERNEL);
+	if (!dev->dev->dma_parms)
+		goto out_err0;
+
+	dma_set_max_seg_size(dev->dev, *dev->dev->dma_mask);
+
 	if (dev_priv->capabilities & SVGA_CAP_GMR2) {
 		DRM_INFO("Max GMR ids is %u\n",
 			 (unsigned)dev_priv->max_gmr_ids);
@@ -772,7 +779,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (unlikely(dev_priv->mmio_virt == NULL)) {
 		ret = -ENOMEM;
 		DRM_ERROR("Failed mapping MMIO.\n");
-		goto out_err0;
+		goto out_err1;
 	}
 
 	/* Need mmio memory to check for fifo pitchlock cap. */
@@ -781,7 +788,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	    !vmw_fifo_have_pitchlock(dev_priv)) {
 		ret = -ENOSYS;
 		DRM_ERROR("Hardware has no pitchlock\n");
-		goto out_err4;
+		goto out_err2;
 	}
 
 	dev_priv->tdev = ttm_object_device_init(&ttm_mem_glob, 12,
@@ -790,7 +797,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (unlikely(dev_priv->tdev == NULL)) {
 		DRM_ERROR("Unable to initialize TTM object management.\n");
 		ret = -ENOMEM;
-		goto out_err4;
+		goto out_err2;
 	}
 
 	dev->dev_private = dev_priv;
@@ -944,8 +951,11 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		pci_release_regions(dev->pdev);
 out_no_device:
 	ttm_object_device_release(&dev_priv->tdev);
-out_err4:
+out_err2:
 	memunmap(dev_priv->mmio_virt);
+out_err1:
+	kfree(dev->dev->dma_parms);
+	dev->dev->dma_parms = NULL;
 out_err0:
 	for (i = vmw_res_context; i < vmw_res_max; ++i)
 		idr_destroy(&dev_priv->res_idr[i]);
@@ -995,6 +1005,8 @@ static void vmw_driver_unload(struct drm_device *dev)
 
 	ttm_object_device_release(&dev_priv->tdev);
 	memunmap(dev_priv->mmio_virt);
+	kfree(dev->dev->dma_parms);
+	dev->dev->dma_parms = NULL;
 	if (dev_priv->ctx.staged_bindings)
 		vmw_binding_state_free(dev_priv->ctx.staged_bindings);
 
-- 
2.20.1 (Apple Git-117)

