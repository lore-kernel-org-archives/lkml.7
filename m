Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68893C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C1C215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGpaeohe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfFSVLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:11:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:11:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so329888pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy05C9mn0/yIf2WjCYd8ymGDA+P844rg5bgddBHlUN8=;
        b=KGpaeoheFWBtMSk4WBMgOkawtt9gRWlcsmiS6qSo8xgzQC0X5za9DjD3rUH7b2a0re
         Tfg2n0jZMP+ZXKpDk2U9LapSmaxrigwOaUBbPePTSX7TI28dHCYv/th/bDTLjH3Bs2tJ
         dt8drzYooa55fn0wXwevkiH+aWBOLbRRBPZMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy05C9mn0/yIf2WjCYd8ymGDA+P844rg5bgddBHlUN8=;
        b=TEVA1owruPsSiab5qQDOb3sTABwH/XcLc4mZUvCg14GTZ/0NgsQCfUsNXPjghwTmRJ
         5HY9QayimoVHz5EBF7UlH6xHQ4ZRbGZGz1LcLaAozW343gbSkOPzNQ+WOdAhRgQUovo1
         767I9GT5YQaRQFV+q0kyO8MWjY57VMcIK7r95bYMyUEPHjqv3mZ+FVsLOEHIojNNo2nE
         sPYAzyPbu4/Y84xp1Ty2TIo2j6ZCJgcaxa9oWPg5yNZg1dEt4K5F/cbkfBugRcN9Y9vj
         CJCdYIBNt3AJM2D5QY4T0ISNsq9cteYjrXsv2Bp1jh8i3Lrlw9oHmvAbmUCaEb/Pv+E2
         8g1A==
X-Gm-Message-State: APjAAAU2RX/0o7N52LfuT+SVz6f576hzOFVdrq6Yh20olyP/LdyWJD+X
        8F/Bh+wRUa8dudKCAx7HfV14Gw==
X-Google-Smtp-Source: APXvYqwXqPl24uyJF3v+5dkgkWEhaRF4Tfy/+nmYhsNEFIVfi0rh/PxJeKfAiWOS6/1USM4Ra2YThw==
X-Received: by 2002:a63:6b46:: with SMTP id g67mr1788869pgc.45.1560978708910;
        Wed, 19 Jun 2019 14:11:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p7sm35319117pfp.131.2019.06.19.14.11.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 14:11:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        seanpaul@chromium.org
Cc:     jernej.skrabec@siol.net, heiko@sntech.de, jonas@kwiboo.se,
        maxime.ripard@bootlin.com, narmstrong@baylibre.com,
        linux-rockchip@lists.infradead.org, dgreid@chromium.org,
        cychiang@chromium.org, jbrunet@baylibre.com,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 2/2] drm/bridge/synopsys: dw-hdmi: Allow platforms to provide custom audio tables
Date:   Wed, 19 Jun 2019 14:07:18 -0700
Message-Id: <20190619210718.134951-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190619210718.134951-1-dianders@chromium.org>
References: <20190619210718.134951-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms using dw_hdmi it may not be possible to make an HDMI
pixel clock exactly, but it may be possible to make a rate that is
close enough to be within spec.  For instance on rk3288 we can make
25,176,471 Hz instead of 25,174,825.1748... Hz (25.2 MHz / 1.001).  A
future patch to the rk3288 platform code could enable support for this
clock rate and specify the N/CTS that would be ideal.

NOTE: I haven't yet posted said patch due to complexities with knowing
whether dw_hdmi can control the dynamic PLL on rk3288.  Thus for now
there are no users of this feature yet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split out the ability of a platform to provide custom tables.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 27 ++++++++++++++---------
 include/drm/bridge/dw_hdmi.h              |  8 +++++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7cdffebcc7cb..b6027edf2942 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -60,13 +60,6 @@ enum hdmi_datamap {
 	YCbCr422_12B = 0x12,
 };
 
-struct dw_hdmi_audio_tmds_n {
-	unsigned long tmds;
-	unsigned int n_32k;
-	unsigned int n_44k1;
-	unsigned int n_48k;
-};
-
 /*
  * Unless otherwise noted, entries in this table are 100% optimization.
  * Values can be obtained from hdmi_compute_n() but that function is
@@ -603,6 +596,7 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
 static int hdmi_match_tmds_n_table(struct dw_hdmi *hdmi, unsigned int freq,
 				   unsigned long pixel_clk)
 {
+	const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
 	const struct dw_hdmi_audio_tmds_n *tmds_n = NULL;
 	int mult = 1;
 	int i;
@@ -612,10 +606,21 @@ static int hdmi_match_tmds_n_table(struct dw_hdmi *hdmi, unsigned int freq,
 		freq /= 2;
 	}
 
-	for (i = 0; common_tmds_n_table[i].tmds != 0; i++) {
-		if (pixel_clk == common_tmds_n_table[i].tmds) {
-			tmds_n = &common_tmds_n_table[i];
-			break;
+	if (plat_data->tmds_n_table) {
+		for (i = 0; plat_data->tmds_n_table[i].tmds != 0; i++) {
+			if (pixel_clk == plat_data->tmds_n_table[i].tmds) {
+				tmds_n = &plat_data->tmds_n_table[i];
+				break;
+			}
+		}
+	}
+
+	if (tmds_n == NULL) {
+		for (i = 0; common_tmds_n_table[i].tmds != 0; i++) {
+			if (pixel_clk == common_tmds_n_table[i].tmds) {
+				tmds_n = &common_tmds_n_table[i];
+				break;
+			}
 		}
 	}
 
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index c402364aec0d..5ee6b0a127aa 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -90,6 +90,13 @@ enum dw_hdmi_phy_type {
 	DW_HDMI_PHY_VENDOR_PHY = 0xfe,
 };
 
+struct dw_hdmi_audio_tmds_n {
+	unsigned long tmds;
+	unsigned int n_32k;
+	unsigned int n_44k1;
+	unsigned int n_48k;
+};
+
 struct dw_hdmi_mpll_config {
 	unsigned long mpixelclock;
 	struct {
@@ -137,6 +144,7 @@ struct dw_hdmi_plat_data {
 	const struct dw_hdmi_mpll_config *mpll_cfg;
 	const struct dw_hdmi_curr_ctrl *cur_ctr;
 	const struct dw_hdmi_phy_config *phy_config;
+	const struct dw_hdmi_audio_tmds_n *tmds_n_table;
 	int (*configure_phy)(struct dw_hdmi *hdmi,
 			     const struct dw_hdmi_plat_data *pdata,
 			     unsigned long mpixelclock);
-- 
2.22.0.410.gd8fdbe21b5-goog

