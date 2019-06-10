Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63764C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5D207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxF1nMuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfFJRwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:52:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46090 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbfFJRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:52:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so5713589pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+j33U/KoRlNgTFzxm2+JBRTgicwoY0lYBd07TSgrA8=;
        b=cxF1nMuo6dYPyZe7IW550Tuvt/62sqAH3zxqkBDBP60Zvf09/H9NyJ84Hes67AMcs+
         FT0mKqC866kkF5lMJa9TjElrohQWwc7L7NecmxSE5p/88FgBlI315lwC72hDmcLD12FS
         La1s9o0nVajzrUxY6540kLZ1wY50dWzDdtCIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+j33U/KoRlNgTFzxm2+JBRTgicwoY0lYBd07TSgrA8=;
        b=SME/1in9dkzPcAYhOZXYt7+XuOnsZ37WfRG2mBGVpScuMzxHUpd2bpDXcgyuS75fWL
         cfTu5ZDosLXavWiX9JFkmWqYAKiwxNfgcwG1WDCfnlKGkRt6apfVDHPhRlocifsPrdfd
         BfdQ8Hnot+vKpJpKFMP9Z/fU1mxMuYj2DEyYO29w2Gk9lZwn5YQDFMZW5GHqR9CuUK9i
         r0EI/fs2CgtxLex8eHppue5CiWQg24zSokolJhp9UnOeMHCU3oxBtDSqqZSleuJ6Q6Ix
         W0mZAX+kvQOqigyhxuYrtzEDGF/FmImXY9QmYRTzLdWwuT1r+fxG0mG1WrdA4NNb/vYB
         f0Aw==
X-Gm-Message-State: APjAAAXtqAz3dpnkgPBTIgIDQhdMb49vF5Hxlf/8ex5zfZyWcOLwm/Tu
        tKPQ68YRxirw/pKXcOM9F1WMUQ==
X-Google-Smtp-Source: APXvYqzU1Wm58XzoJcqWjPmPcWmK6k9fe25HmAb+1sgysyHkY4qvbyB6DYlP3+BcnzlJSNDd0YA7aA==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr22154592pjz.140.1560189169114;
        Mon, 10 Jun 2019 10:52:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o192sm12247158pgo.74.2019.06.10.10.52.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 10:52:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Erico Nunes <nunes.erico@gmail.com>, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/bridge/synopsys: dw-hdmi: Fix unwedge crash when no pinctrl entries
Date:   Mon, 10 Jun 2019 10:52:34 -0700
Message-Id: <20190610175234.196844-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge"
for ddc bus") I stupidly used IS_ERR() to check for whether we have an
"unwedge" pinctrl state even though on most flows through the driver
the unwedge state will just be NULL.

Fix it so that we consistently use NULL for no unwedge state.

Fixes: 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus")
Reported-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f25e091b93c5..5e4e9408d00f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -251,7 +251,7 @@ static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
 static bool dw_hdmi_i2c_unwedge(struct dw_hdmi *hdmi)
 {
 	/* If no unwedge state then give up */
-	if (IS_ERR(hdmi->unwedge_state))
+	if (!hdmi->unwedge_state)
 		return false;
 
 	dev_info(hdmi->dev, "Attempting to unwedge stuck i2c bus\n");
@@ -2686,11 +2686,13 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->default_state =
 				pinctrl_lookup_state(hdmi->pinctrl, "default");
 
-			if (IS_ERR(hdmi->default_state) &&
-			    !IS_ERR(hdmi->unwedge_state)) {
-				dev_warn(dev,
-					 "Unwedge requires default pinctrl\n");
-				hdmi->unwedge_state = ERR_PTR(-ENODEV);
+			if (IS_ERR(hdmi->default_state) ||
+			    IS_ERR(hdmi->unwedge_state)) {
+				if (!IS_ERR(hdmi->unwedge_state))
+					dev_warn(dev,
+						 "Unwedge requires default pinctrl\n");
+				hdmi->default_state = NULL;
+				hdmi->unwedge_state = NULL;
 			}
 		}
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

