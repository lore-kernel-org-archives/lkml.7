Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB5A2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfKZJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:58:14 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:32276 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727397AbfKZJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:58:14 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Nov 2019 17:58:12 +0800
Received: from csbcas.internal.ite.com.tw (csbcas2.internal.ite.com.tw [192.168.65.47])
        by mse.ite.com.tw with ESMTP id xAQ9w0kU081586;
        Tue, 26 Nov 2019 17:58:00 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas2.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 26 Nov 2019 17:58:01 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
Date:   Tue, 26 Nov 2019 17:46:12 +0800
Message-ID: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw xAQ9w0kU081586
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
 drivers/gpu/drm/drm_edid.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index f5926bf..e11e585 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -93,6 +93,12 @@ struct detailed_mode_closure {
 	int modes;
 };
 
+struct edid_support_rb_closure {
+	struct edid *edid;
+	bool valid_support_rb;
+	bool support_rb;
+};
+
 #define LEVEL_DMT	0
 #define LEVEL_GTF	1
 #define LEVEL_GTF2	2
@@ -2017,23 +2023,41 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
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
+	struct edid_support_rb_closure *closure = data;
+	struct edid *edid = closure->edid;
+
+	if (is_display_descriptor(r, EDID_DETAIL_MONITOR_RANGE)) {
+		if (edid->features & BIT(0) && r[10] == BIT(2)) {
+			closure->valid_support_rb = true;
+			closure->support_rb = (r[15] & 0x10) ? true : false;
+		}
+	}
 }
 
 /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
 static bool
 drm_monitor_supports_rb(struct edid *edid)
 {
+	struct edid_support_rb_closure closure = {
+		.edid = edid,
+		.valid_support_rb = false,
+		.support_rb = false,
+	};
+
 	if (edid->revision >= 4) {
-		bool ret = false;
-		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
-		return ret;
+		drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
+		if (closure.valid_support_rb)
+			return closure.support_rb;
 	}
 
 	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);
-- 
1.9.1

