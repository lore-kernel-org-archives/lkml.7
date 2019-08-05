Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9EBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D774720B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfHEIyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHEIyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EABAB30833C1;
        Mon,  5 Aug 2019 08:54:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9456A1000321;
        Mon,  5 Aug 2019 08:54:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3B87511AAA; Mon,  5 Aug 2019 10:54:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: get vga ioports
Date:   Mon,  5 Aug 2019 10:53:55 +0200
Message-Id: <20190805085355.12527-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 05 Aug 2019 08:54:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl has two modes: "native" (used by the drm driver) and "vga" (vga
compatibility mode, typically used for boot display and firmware
framebuffers).

Accessing any vga ioport will switch the qxl device into vga mode.
The qxl driver never does that, but other drivers accessing vga ports
can trigger that too and therefore disturb qxl operation.  So aquire
the legacy vga ioports from vgaarb to avoid that.

Reporducer: Boot kvm guest with both qxl and i915 vgpu, with qxl being
first in pci scan order.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index b57a37543613..8a2e86adc423 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -87,9 +87,15 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto disable_pci;
 
+	ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
+	if (ret) {
+		DRM_ERROR("can't get legacy vga ports\n");
+		goto put_vga;
+	}
+
 	ret = qxl_device_init(qdev, &qxl_driver, pdev);
 	if (ret)
-		goto disable_pci;
+		goto put_vga;
 
 	ret = qxl_modeset_init(qdev);
 	if (ret)
@@ -109,6 +115,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	qxl_modeset_fini(qdev);
 unload:
 	qxl_device_fini(qdev);
+put_vga:
+	vga_put(pdev, VGA_RSRC_LEGACY_IO);
 disable_pci:
 	pci_disable_device(pdev);
 free_dev:
@@ -126,6 +134,7 @@ qxl_pci_remove(struct pci_dev *pdev)
 
 	qxl_modeset_fini(qdev);
 	qxl_device_fini(qdev);
+	vga_put(pdev, VGA_RSRC_LEGACY_IO);
 
 	dev->dev_private = NULL;
 	kfree(qdev);
-- 
2.18.1

