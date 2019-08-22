Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637DDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E3221655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbfHVJG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29615 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732927AbfHVJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:06:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03B7930872C5;
        Thu, 22 Aug 2019 09:06:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDAF7E43;
        Thu, 22 Aug 2019 09:06:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 13DB259EC; Thu, 22 Aug 2019 11:06:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] fbdev: drop res_id parameter from remove_conflicting_pci_framebuffers
Date:   Thu, 22 Aug 2019 11:06:43 +0200
Message-Id: <20190822090645.25410-2-kraxel@redhat.com>
In-Reply-To: <20190822090645.25410-1-kraxel@redhat.com>
References: <20190822090645.25410-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 22 Aug 2019 09:06:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b0e999c95581 ("fbdev: list all pci memory bars as
conflicting apertures") the parameter was used for some sanity checks
only, to make sure we detect any issues with the new approach to just
list all memory bars as apertures.

No issues turned up so far, so continue to cleanup:  Drop the res_id
parameter, drop the sanity checks.  Also downgrade the logging from
"info" level to "debug" level and update documentation.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h      |  2 +-
 include/linux/fb.h               |  2 +-
 drivers/video/fbdev/core/fbmem.c | 17 +++++------------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index c8a8ae2a678a..5a5f4b1d8241 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -560,7 +560,7 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 	 * otherwise the vga fbdev driver falls over.
 	 */
 #if IS_REACHABLE(CONFIG_FB)
-	ret = remove_conflicting_pci_framebuffers(pdev, resource_id, name);
+	ret = remove_conflicting_pci_framebuffers(pdev, name);
 #endif
 	if (ret == 0)
 		ret = vga_remove_vgacon(pdev);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 756706b666a1..41e0069eca0a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -607,7 +607,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
 extern void unlink_framebuffer(struct fb_info *fb_info);
-extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
+extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
 					   const char *name, bool primary);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index e6a1c805064f..95c32952fa8a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1758,21 +1758,19 @@ EXPORT_SYMBOL(remove_conflicting_framebuffers);
 /**
  * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
  * @pdev: PCI device
- * @res_id: index of PCI BAR configuring framebuffer memory
  * @name: requesting driver name
  *
  * This function removes framebuffer devices (eg. initialized by firmware)
- * using memory range configured for @pdev's BAR @res_id.
+ * using memory range configured for any of @pdev's memory bars.
  *
  * The function assumes that PCI device with shadowed ROM drives a primary
  * display and so kicks out vga16fb.
  */
-int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const char *name)
+int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, const char *name)
 {
 	struct apertures_struct *ap;
 	bool primary = false;
 	int err, idx, bar;
-	bool res_id_found = false;
 
 	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
@@ -1789,16 +1787,11 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 			continue;
 		ap->ranges[idx].base = pci_resource_start(pdev, bar);
 		ap->ranges[idx].size = pci_resource_len(pdev, bar);
-		pci_info(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
-			 (unsigned long)pci_resource_start(pdev, bar),
-			 (unsigned long)pci_resource_end(pdev, bar));
+		pci_dbg(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
+			(unsigned long)pci_resource_start(pdev, bar),
+			(unsigned long)pci_resource_end(pdev, bar));
 		idx++;
-		if (res_id == bar)
-			res_id_found = true;
 	}
-	if (!res_id_found)
-		pci_warn(pdev, "%s: passed res_id (%d) is not a memory bar\n",
-			 __func__, res_id);
 
 #ifdef CONFIG_X86
 	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
-- 
2.18.1

