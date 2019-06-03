Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA464C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB0425ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="T42dqUDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFCVp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:45:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42873 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFCVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:45:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so11339559qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gvdrQo5B70PjVzTAGPUvQj7fvSXVzP6mxSVdEzCLASY=;
        b=T42dqUDnlxUcv42X+xpZZ9Wm2JW57MKk1cKisSf9YDQbjcXzBoFwP6e/stsMbCe6gE
         0Pzg4myXqP5r5dH2OzSVt2SEs20IPwSCthC4VfPoa+N1i1Jt9yobmyV7hWGXYy1Sdw8c
         WcIkyT5UcFrW9E5+OOw0rC+EZoB5B5etU3u7D7ed8RRqfekvVMZGlB2ClXH6FEmAxhWN
         fp1y0jjJ8Gpaim5JLck1meM2kXiodMWkEdomDrzHG1GDm1N8PiXsHqPKf2hO0Ddcec3K
         s2b+ppo+bQ6P79c2lKKpspngweqqWf5nGWLQ3pIVHVUmD61Ji8D3Vk+OfHM/IHm49KBm
         GW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gvdrQo5B70PjVzTAGPUvQj7fvSXVzP6mxSVdEzCLASY=;
        b=dFgiwIpzvSMvu1AiB/U37S77/u2IS4fFYeEM4Yzw8dimT2yY6MI739VOmYdbXdKQiu
         8VyjZzlNBOTD6N6lG60x/rwoHHJQQHArdH/ErwR9DmbbyZ61grbTxi7uHG39EbAXbM9b
         l01SgeAQ8Ue8ZZlTdPsIdHcKdmMQ7sQYQDX4zStYOLZwClc9hFaqyqu51iIbeLjIMaF5
         jNjke8X6pirMv3q4bRXasPfmXGCsv7JrhW82Qdq3bqZHsRrgoZTGqWPA14yh4KDACitO
         c8sTdXKzstf4adlLYOcpiul4BcuIVj4dPnn7yvlVTnRnqFpc7rNjAd5/nv7RH2aazqeK
         FlbA==
X-Gm-Message-State: APjAAAUepfP2s8OndyhLkcpayscVpZhrwuv+KF61zIvkKmq6kn2G5kdH
        VVFvryNxKb614sBDwcNCmB/+j0Ez5tQ=
X-Google-Smtp-Source: APXvYqxTQ/VyJ9mLBkuhiu277acvqJ0JTn+d00JBzZnk9wtjBACFQ0jxMb87m6w56/kleGG9LYW/dA==
X-Received: by 2002:ac8:68e:: with SMTP id f14mr11737655qth.366.1559594674546;
        Mon, 03 Jun 2019 13:44:34 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e66sm9481525qtb.55.2019.06.03.13.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:44:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, thellstrom@vmware.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH v2] drm/vmwgfx: fix a warning due to missing dma_parms
Date:   Mon,  3 Jun 2019 16:44:15 -0400
Message-Id: <1559594655-30324-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting up with DMA_API_DEBUG_SG=y generates a warning due to the driver
forgot to set dma_parms appropriately. Set it just after vmw_dma_masks()
in vmw_driver_load().

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
Suggested-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 4ff11a0077e1..5f690429eb89 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -747,6 +747,8 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (unlikely(ret != 0))
 		goto out_err0;
 
+	dma_set_max_seg_size(dev->dev, U32_MAX);
+
 	if (dev_priv->capabilities & SVGA_CAP_GMR2) {
 		DRM_INFO("Max GMR ids is %u\n",
 			 (unsigned)dev_priv->max_gmr_ids);
-- 
1.8.3.1

