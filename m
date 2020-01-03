Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB02222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9xOLwRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgACNTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:19:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35184 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgACNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:19:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so8593090wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7MNMC46L/ZLy5R5phEKgqsEJ5fPW0pXEGQb1S+WQ7H0=;
        b=M9xOLwRq3vPs0yI+fSX3UERn74IUU9+YGNtfF2Ng8qV6D/lwtGy7PjGjfASN99PiTj
         Nc3GnpzMRRfJ/Gqfz0B1o3RFuIErJPcK4XLUAVNqntTAV28pAYt1nNttYPjnAMW5m28i
         MrGwC4eR7MPjQHjNo1Ib9k1ikRBp2Xq0+AqNyGsIc04pknCK9yHLZZjt4sYkRpDrNIWy
         LcbwnxEWtNg1B+X+iJJsdNY4qkNGhytDZgSidny4j6RE4bfdZp48P/rw6tl5/TaEo/Bw
         cJ69Icnmv7EogGExcUd5TfEIY7QZpyLOAAk9xqUPk2mrmZIOxWkGtNUlkEzBXCpKesOo
         jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7MNMC46L/ZLy5R5phEKgqsEJ5fPW0pXEGQb1S+WQ7H0=;
        b=fs6HMIGYQZ5s3QCsjHj8HEAK0nKHeNtP/TxEA9wqp2RRq6UnwRy8TBydeaP19SWVMR
         jB6MFFfaDZoX/DD3mGq64QcyurBKvG7wM/KrsrBXRp9brYyhbNWuZR4eyfEwK3I5Q/Zf
         ATC/bfo2IWAanDDuBRpGsw0g8nz+yUwULQ7ms4iwC129AEVHkFJ4BOYyDQOhOM7bOQ1S
         +culhoZET8CqhBdnJdT4QPE6E5QXBqxM+AL1ohG6D11/WbE/g4wCSiNx0tzEVqZzU82L
         dIWOnt2ANcI0qObQuvS1W8C+qhE9mGndAbsYLqr+tPggTXrWCQUzNTUAKE+frTzo559/
         vY4A==
X-Gm-Message-State: APjAAAXnx1t9yfCu96FeAQwNWZLBMGB45wC3rjHmTU4hP/RfeKCMrbnG
        YkEAkKYyJNN2n9Zm8JfRUAA=
X-Google-Smtp-Source: APXvYqzJDcoJXUwYdfBuRdf5nQmRqO8mMd5FgOZEpdbYqx6iEIs7isAHjwOJN8oUcszOVzdfxbponw==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr19849978wmg.163.1578057558341;
        Fri, 03 Jan 2020 05:19:18 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id p18sm12130679wmg.4.2020.01.03.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 05:19:17 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: remove boolean checks in if statements.
Date:   Fri,  3 Jan 2020 16:19:12 +0300
Message-Id: <20200103131912.26681-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable comparisions to true/false in if statements
and check the value of the variable directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/radeon/cik_sdma.c               |  2 +-
 drivers/gpu/drm/radeon/r100.c                   |  2 +-
 drivers/gpu/drm/radeon/r600.c                   |  2 +-
 drivers/gpu/drm/radeon/radeon_bios.c            | 12 ++++++------
 drivers/gpu/drm/radeon/radeon_connectors.c      |  4 ++--
 drivers/gpu/drm/radeon/radeon_display.c         |  4 ++--
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  4 ++--
 drivers/gpu/drm/radeon/radeon_pm.c              |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
index 35b9dc6ce46a..68403e77756d 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -333,7 +333,7 @@ void cik_sdma_enable(struct radeon_device *rdev, bool enable)
 	u32 me_cntl, reg_offset;
 	int i;
 
-	if (enable == false) {
+	if (!enable) {
 		cik_sdma_gfx_stop(rdev);
 		cik_sdma_rlc_stop(rdev);
 	}
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 0017aa7a9f17..957994258860 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -2815,7 +2815,7 @@ void r100_vga_set_state(struct radeon_device *rdev, bool state)
 	uint32_t temp;
 
 	temp = RREG32(RADEON_CONFIG_CNTL);
-	if (state == false) {
+	if (!state) {
 		temp &= ~RADEON_CFG_VGA_RAM_EN;
 		temp |= RADEON_CFG_VGA_IO_DIS;
 	} else {
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 0d453aa09352..eb56fb48a6b7 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -3191,7 +3191,7 @@ void r600_vga_set_state(struct radeon_device *rdev, bool state)
 	uint32_t temp;
 
 	temp = RREG32(CONFIG_CNTL);
-	if (state == false) {
+	if (!state) {
 		temp &= ~(1<<0);
 		temp |= (1<<1);
 	} else {
diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index c84d965c283e..c42f73fad3e3 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -664,17 +664,17 @@ bool radeon_get_bios(struct radeon_device *rdev)
 	uint16_t tmp;
 
 	r = radeon_atrm_get_bios(rdev);
-	if (r == false)
+	if (!r)
 		r = radeon_acpi_vfct_bios(rdev);
-	if (r == false)
+	if (!r)
 		r = igp_read_bios_from_vram(rdev);
-	if (r == false)
+	if (!r)
 		r = radeon_read_bios(rdev);
-	if (r == false)
+	if (!r)
 		r = radeon_read_disabled_bios(rdev);
-	if (r == false)
+	if (!r)
 		r = radeon_read_platform_bios(rdev);
-	if (r == false || rdev->bios == NULL) {
+	if (!r || rdev->bios == NULL) {
 		DRM_ERROR("Unable to locate a BIOS ROM\n");
 		rdev->bios = NULL;
 		return false;
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 0851e6817e57..90d2f732affb 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -440,7 +440,7 @@ radeon_connector_analog_encoder_conflict_solve(struct drm_connector *connector,
 				if (radeon_conflict->use_digital)
 					continue;
 
-				if (priority == true) {
+				if (priority) {
 					DRM_DEBUG_KMS("1: conflicting encoders switching off %s\n",
 						      conflict->name);
 					DRM_DEBUG_KMS("in favor of %s\n",
@@ -700,7 +700,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 			else
 				ret = radeon_legacy_get_tmds_info_from_combios(radeon_encoder, tmds);
 		}
-		if (val == 1 || ret == false) {
+		if (val == 1 || !ret) {
 			radeon_legacy_get_tmds_info_from_table(radeon_encoder, tmds);
 		}
 		radeon_property_change_mode(&radeon_encoder->base);
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index dfb921899853..e42d9e0a4b8c 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -847,11 +847,11 @@ static bool radeon_setup_enc_conn(struct drm_device *dev)
 	if (rdev->bios) {
 		if (rdev->is_atom_bios) {
 			ret = radeon_get_atom_connector_info_from_supported_devices_table(dev);
-			if (ret == false)
+			if (!ret)
 				ret = radeon_get_atom_connector_info_from_object_table(dev);
 		} else {
 			ret = radeon_get_legacy_connector_info_from_bios(dev);
-			if (ret == false)
+			if (!ret)
 				ret = radeon_get_legacy_connector_info_from_table(dev);
 		}
 	} else {
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index a33b19566b2d..44d060f75318 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -1712,7 +1712,7 @@ static struct radeon_encoder_int_tmds *radeon_legacy_get_tmds_info(struct radeon
 	else
 		ret = radeon_legacy_get_tmds_info_from_combios(encoder, tmds);
 
-	if (ret == false)
+	if (!ret)
 		radeon_legacy_get_tmds_info_from_table(encoder, tmds);
 
 	return tmds;
@@ -1735,7 +1735,7 @@ static struct radeon_encoder_ext_tmds *radeon_legacy_get_ext_tmds_info(struct ra
 
 	ret = radeon_legacy_get_ext_tmds_info_from_combios(encoder, tmds);
 
-	if (ret == false)
+	if (!ret)
 		radeon_legacy_get_ext_tmds_info_from_table(encoder, tmds);
 
 	return tmds;
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index b37121f2631d..8c5d6fda0d75 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -1789,7 +1789,7 @@ static bool radeon_pm_debug_check_in_vbl(struct radeon_device *rdev, bool finish
 	u32 stat_crtc = 0;
 	bool in_vbl = radeon_pm_in_vbl(rdev);
 
-	if (in_vbl == false)
+	if (!in_vbl)
 		DRM_DEBUG_DRIVER("not in vbl for pm change %08x at %s\n", stat_crtc,
 			 finish ? "exit" : "entry");
 	return in_vbl;
-- 
2.17.1

