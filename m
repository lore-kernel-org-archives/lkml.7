Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A95AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741202077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLLCjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:39:35 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:47361 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLLCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:39:35 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 12 Dec 2019 10:39:33 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id xBC2dSJ3065779;
        Thu, 12 Dec 2019 10:39:28 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 12 Dec 2019 10:39:28 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/edid: fixup EDID 1.4 judge reduced-blanking timings logic
Date:   Thu, 12 Dec 2019 10:33:42 +0800
Message-ID: <1576118022-4347-1-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw xBC2dSJ3065779
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
(Defines EDID Structure Version 1, Revision 4) page: 39
How to determine whether the monitor support RB timing or not?
EDID 1.4
First:  read detailed timing descriptor and make sure byte 0 = 0x00,
	byte 1 = 0x00, byte 2 = 0x00 and byte 3 = 0xFD
Second: read EDID bit 0 in feature support byte at address 18h = 1
	and detailed timing descriptor byte 10 = 0x04
Third:  if EDID bit 0 in feature support byte = 1 &&
	detailed timing descriptor byte 10 = 0x04
	then we can check byte 15, if bit 4 in byte 15 = 1 is support RB
        if EDID bit 0 in feature support byte != 1 ||
	detailed timing descriptor byte 10 != 0x04,
	then byte 15 can not be used

The linux code is_rb function not follow the VESA's rule

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/gpu/drm/drm_edid.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index f5926bf..826ed78 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2017,13 +2017,21 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
 	}
 }
 
+static bool
+is_display_descriptor(const u8 *r, u8 tag)
+{
+	return (!r[0] && !r[1] && !r[2] && r[3] == tag) ? true : false;
+}
+
 static void
 is_rb(struct detailed_timing *t, void *data)
 {
 	u8 *r = (u8 *)t;
-	if (r[3] == EDID_DETAIL_MONITOR_RANGE)
-		if (r[15] & 0x10)
-			*(bool *)data = true;
+
+	if (is_display_descriptor(r, EDID_DETAIL_MONITOR_RANGE)) {
+		if (r[10] == BIT(2))
+			*(int *)data = !!(r[15] & 0x10);
+	}
 }
 
 /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
@@ -2031,9 +2039,13 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
 drm_monitor_supports_rb(struct edid *edid)
 {
 	if (edid->revision >= 4) {
-		bool ret = false;
-		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
-		return ret;
+		if (edid->features & BIT(0)) {
+			int ret = -1;
+
+			drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
+			if (ret != -1)
+				return ret;
+		}
 	}
 
 	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);
-- 
1.9.1

