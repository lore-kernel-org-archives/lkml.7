Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0392085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfCAJZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:25:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbfCAJZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:25:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBFD8301EA9B;
        Fri,  1 Mar 2019 09:25:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-211.ams2.redhat.com [10.36.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3131001DFD;
        Fri,  1 Mar 2019 09:25:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 615A717476; Fri,  1 Mar 2019 10:25:02 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 2/4] drm/fb-helper: call vga_remove_vgacon automatically.
Date:   Fri,  1 Mar 2019 10:25:00 +0100
Message-Id: <20190301092502.30948-3-kraxel@redhat.com>
In-Reply-To: <20190301092502.30948-1-kraxel@redhat.com>
References: <20190301092502.30948-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 01 Mar 2019 09:25:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vga_remove_vgacon() call to
drm_fb_helper_remove_conflicting_pci_framebuffers().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_fb_helper.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bb9acea61369..286d58efed5d 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -36,6 +36,7 @@ struct drm_fb_helper;
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <linux/kgdb.h>
+#include <linux/vgaarb.h>
 
 enum mode_set_atomic {
 	LEAVE_ATOMIC_MODE_SET,
@@ -642,11 +643,18 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 						  int resource_id,
 						  const char *name)
 {
+	int ret = 0;
+
+	/*
+	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
+	 * otherwise the vga fbdev driver falls over.
+	 */
 #if IS_REACHABLE(CONFIG_FB)
-	return remove_conflicting_pci_framebuffers(pdev, resource_id, name);
-#else
-	return 0;
+	ret = remove_conflicting_pci_framebuffers(pdev, resource_id, name);
 #endif
+	if (ret == 0)
+		ret = vga_remove_vgacon(pdev);
+	return ret;
 }
 
 #endif
-- 
2.9.3

