Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D90DC468AF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE62089C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XtRF2BQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfGFLLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 07:11:52 -0400
Received: from onstation.org ([52.200.56.107]:43804 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfGFLLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 07:11:51 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 34FC93EE72;
        Sat,  6 Jul 2019 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1562411510;
        bh=9cS2ydOA+KgzUTCiP9CODFmbS9Ga+mbp4SRgk17zSTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XtRF2BQeKmlC7mlP1jE2b+HH2EKT8V8epfArAt0Xr+rEx2WTrCMk6HDBxy6ITdgXE
         8REsIhod/4UHChJjWb1I3fGfUjQmrWi2ebroo0hNR0Ib9p67bwaxmilIw14Nf+o54p
         YPJYX/LbQIsnt+mMpR+6DV6pmvevRKcxmzBzmdzs=
From:   Brian Masney <masneyb@onstation.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/phy/dsi_phy: silence -EPROBE_DEFER warnings
Date:   Sat,  6 Jul 2019 07:11:38 -0400
Message-Id: <20190706111138.2238-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following errors show up when booting the Nexus 5:

msm_dsi_phy fd922a00.dsi-phy: [drm:dsi_phy_driver_probe] *ERROR*
 dsi_phy_regulator_init: failed to init regulator, ret=-517
msm_dsi_phy fd922a00.dsi-phy: [drm:dsi_phy_driver_probe] *ERROR*
 dsi_phy_driver_probe: failed to init regulator

dsi_phy_regulator_init() already logs the error, so no need to log
the same error a second time in dsi_phy_driver_probe(). This patch
also changes dsi_phy_regulator_init() to not log the error if the
error code is -EPROBE_DEFER to reduce noise in dmesg.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 4097eca1b3ef..d0e1cc6728dc 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -396,8 +396,11 @@ static int dsi_phy_regulator_init(struct msm_dsi_phy *phy)
 
 	ret = devm_regulator_bulk_get(dev, num, s);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "%s: failed to init regulator, ret=%d\n",
-						__func__, ret);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev,
+				      "%s: failed to init regulator, ret=%d\n",
+				      __func__, ret);
+
 		return ret;
 	}
 
@@ -584,10 +587,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 	}
 
 	ret = dsi_phy_regulator_init(phy);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "%s: failed to init regulator\n", __func__);
+	if (ret)
 		goto fail;
-	}
 
 	phy->ahb_clk = msm_clk_get(pdev, "iface");
 	if (IS_ERR(phy->ahb_clk)) {
-- 
2.20.1

