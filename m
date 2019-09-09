Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3885C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F2B21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WGXq+WpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfIIKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:13:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41568 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfIIKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:13:23 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89A1pit016851;
        Mon, 9 Sep 2019 12:13:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eaDnefryRKb0WXqhwir54zXZzPWWXudlNrduZXInUhY=;
 b=WGXq+WpQNhSscPYoOE6mVpFGFO4NJ/SW3A1GtwgMvn9YNO2jk2AXabhjz66nQ4hacclT
 hEd58OAWUH1sKTT/dVpr878Y0aoYoyqxU7eRINMkaBxwSS3TeDe7iUIrl/tpum3cPTCB
 0ghIEWVYXZs5vTbWoAQsQJVydoLW3wPZf1py9lSfu3W48GJUP4ZS8oKgrP3X13EBdtrq
 hzYRTLIXn4IPNjA5aVnRLMD3fvRo64E6PBRv07+/z0Gi5eTz6suUXkUkpns+XWAniAJb
 FCAqVJIrvgUm6G5GgIBhMYtrxOiCbIie3ZoU0uCqD/aECIEGtdfcxC22epnd4wKJMQXn Vw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uv212ctu2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Sep 2019 12:13:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8C6E559;
        Mon,  9 Sep 2019 10:13:01 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19A8A2C6D25;
        Mon,  9 Sep 2019 12:13:01 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 12:13:00 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019 12:13:00
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <benjamin.gaignard@linaro.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: sti: fix W=1 warnings
Date:   Mon, 9 Sep 2019 12:12:53 +0200
Message-ID: <20190909101254.24191-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_04:2019-09-09,2019-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings when W=1.
No code changes, only clean up in sti internal structures and functions
descriptions.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/sti/sti_cursor.c |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c    |  2 +-
 drivers/gpu/drm/sti/sti_gdp.c    |  2 +-
 drivers/gpu/drm/sti/sti_hda.c    |  2 +-
 drivers/gpu/drm/sti/sti_hdmi.c   |  4 ++--
 drivers/gpu/drm/sti/sti_tvout.c  | 10 +++++-----
 drivers/gpu/drm/sti/sti_vtg.c    |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index 0bf7c332cf0b..ea64c1dcaf63 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -47,7 +47,7 @@ struct dma_pixmap {
 	void *base;
 };
 
-/**
+/*
  * STI Cursor structure
  *
  * @sti_plane:    sti_plane structure
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 9e6d5d8b7030..c33d0aaee82b 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -65,7 +65,7 @@ static struct dvo_config rgb_24bit_de_cfg = {
 	.awg_fwgen_fct = sti_awg_generate_code_data_enable_mode,
 };
 
-/**
+/*
  * STI digital video output structure
  *
  * @dev: driver device
diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 8e926cd6a1c8..11595c748844 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -103,7 +103,7 @@ struct sti_gdp_node_list {
 	dma_addr_t btm_field_paddr;
 };
 
-/**
+/*
  * STI GDP structure
  *
  * @sti_plane:          sti_plane structure
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 94e404f13234..3512a94a0fca 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -230,7 +230,7 @@ static const struct sti_hda_video_config hda_supported_modes[] = {
 	 AWGi_720x480p_60, NN_720x480p_60, VID_ED}
 };
 
-/**
+/*
  * STI hd analog structure
  *
  * @dev: driver device
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f03d617edc4c..87e34f7a6cfe 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -333,7 +333,6 @@ static void hdmi_infoframe_reset(struct sti_hdmi *hdmi,
  * Helper to concatenate infoframe in 32 bits word
  *
  * @ptr: pointer on the hdmi internal structure
- * @data: infoframe to write
  * @size: size to write
  */
 static inline unsigned int hdmi_infoframe_subpack(const u8 *ptr, size_t size)
@@ -543,13 +542,14 @@ static int hdmi_vendor_infoframe_config(struct sti_hdmi *hdmi)
 	return 0;
 }
 
+#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
+
 /**
  * Software reset of the hdmi subsystem
  *
  * @hdmi: pointer on the hdmi internal structure
  *
  */
-#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
 static void hdmi_swreset(struct sti_hdmi *hdmi)
 {
 	u32 val;
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index e1b3c8cb7287..b1fc77b150da 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -157,9 +157,9 @@ static void tvout_write(struct sti_tvout *tvout, u32 val, int offset)
  *
  * @tvout: tvout structure
  * @reg: register to set
- * @cr_r:
- * @y_g:
- * @cb_b:
+ * @cr_r: red chroma or red order
+ * @y_g: y or green order
+ * @cb_b: blue chroma or blue order
  */
 static void tvout_vip_set_color_order(struct sti_tvout *tvout, int reg,
 				      u32 cr_r, u32 y_g, u32 cb_b)
@@ -214,7 +214,7 @@ static void tvout_vip_set_rnd(struct sti_tvout *tvout, int reg, u32 rnd)
  * @tvout: tvout structure
  * @reg: register to set
  * @main_path: main or auxiliary path
- * @sel_input: selected_input (main/aux + conv)
+ * @video_out: selected_input (main/aux + conv)
  */
 static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
 				    int reg,
@@ -251,7 +251,7 @@ static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
  *
  * @tvout: tvout structure
  * @reg: register to set
- * @in_vid_signed: used video input format
+ * @in_vid_fmt: used video input format
  */
 static void tvout_vip_set_in_vid_fmt(struct sti_tvout *tvout,
 		int reg, u32 in_vid_fmt)
diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index ef4009f11396..0b17ac8a3faa 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -121,7 +121,7 @@ struct sti_vtg_sync_params {
 	u32 vsync_off_bot;
 };
 
-/**
+/*
  * STI VTG structure
  *
  * @regs: register mapping
-- 
2.15.0

