Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69019C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE7520868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="h5Wo0W4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390997AbfEXMdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:33:20 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46286 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbfEXMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:33:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id x8so5586076vsx.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpPNoIC1GN9SZAPFrAZ1DEWNYJLtZRJh/8Vm70kdQY=;
        b=h5Wo0W4wYQSNbEtBUOtEjv2mFS7sx5PLQyT6f+FgCDnFqm4c/BA8RLbPBKn2W0vncJ
         HREMO01fI1VIGxVlRczxWVnh93X0XJsdP46jPef2BpqFNB4JceGw/Ux1MLwQBefwPjR6
         BK8GbyWL1/+EzqZYeYQWCanHYPdSnOoXJjngj8z9u139FabvHux0wch3HBjZaLBL1p0j
         ob/Sf6P1iESiqMwF9mkfhW1i+ZjuvzuJXRnfT5IK4PGNkVAYqO0orlv2gU2T7ug8jnpM
         wiqOkTu7Gi4c6KAR9V2kYsgs+MaSfjbA0Vyg2mKlYYF8PizoVrrWOSCvdbO670Fxduz9
         kCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpPNoIC1GN9SZAPFrAZ1DEWNYJLtZRJh/8Vm70kdQY=;
        b=io8f3fcedJHzEQOuvooR34pLoCmE7MR+QRxm0yeYWSMl/ORE5JJV82Yx82R4bfygHd
         3bwp8HGFH1F4vlW0Ukgz3MIWSLB6xx7fqyiFgwVu5sQoD5uk+ndrjjepELlGWaq0QCjb
         VWGhztDLUuH9MVAD4bkWiP7P1qRdZUCwN4vUovxKST8dGOhVggiWux7p/OQCysIKejJO
         k5Rl/TER9E2+3J/UMpBJ6cDc4VVr+vtYXRVSMZ1slIMkkcDO6StcAQePwPlpyfvsmk4o
         TXqQxlsssNvqw6xBheTA0FKUuhPGm9JbSyTcniJX7UFTQ+u1PsK20RpTcEIuQQ9oArs8
         Mz1w==
X-Gm-Message-State: APjAAAUbk/XU9+2LMxoxQWcGBTh02fb41kXE/DOHvHJVFKIAZRuBB7j2
        dNBEQcIl3FMxiJjJbn4pbkWDvA==
X-Google-Smtp-Source: APXvYqxocOPWqazKpYvK52ldaWs3QWs6ADA0TDILFcNg/N/v82vBtE3OmFd+neCaIGMF4lnF+tWsWQ==
X-Received: by 2002:a67:f245:: with SMTP id y5mr44003746vsm.210.1558701198882;
        Fri, 24 May 2019 05:33:18 -0700 (PDT)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o66sm661717vke.17.2019.05.24.05.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 05:33:18 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     thellstrom@vmware.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] drm/vmwgfx: fix a warning due to missing dma_parms
Date:   Fri, 24 May 2019 08:33:03 -0400
Message-Id: <20190524123303.915-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bf6c3500d363..e10fe109ee48 100644
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
2.20.1 (Apple Git-117)

