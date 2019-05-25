Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ADFC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42261217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJGtl5if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEYHZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 03:25:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46022 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYHZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 03:25:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so1591823pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3/HXmCveeAbDHijcuKaxjc8S8ha3SNVf6PI9wjQHBaU=;
        b=iJGtl5ifVwJd8BjCR93hGbqtuqBchM1RWraUzeQUQoQ2O9vIRPkkaX9QRvxuuCr4Uc
         nQD2tWFlXUVRN+Qig2B3ShbJzo1YM4FdaCl3vEoU2LA25xV4K3POmnQM9RLw3b0RVF4L
         oC+iDk+pdJfldY2GLBfZhy6+jAuqsoLK8koBh0lwLGgX0CQz3ZtsocUEk6RDP1PhizlR
         D2Mg+l5vVefIdCFCLeGSphk4tzW+C2r3SUjG5HPYmk+YIiuBSH7BYAhJHnTW+H/57C6h
         n+b5SXSTPcPntvqtNyhhfOYSjTfMXxC3jqx+oiQ4RlfO5u9nPu6z+m9AZvq7IBWtgNIo
         1Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3/HXmCveeAbDHijcuKaxjc8S8ha3SNVf6PI9wjQHBaU=;
        b=MymIF3zzPUb/u9+XS0qXX5IPpGFs3R9ZLk6zPyZZUefc3iJaiK1pheoiNf0HWP5frb
         EEPUc+2VlWnQ7iajoIduQaCd05x7M6c7Q6W0WhQNA5EPaxozSCnkpoLD3ES68ILA8o4N
         vm8/PQoArZ9WPdyXIjmSpbV016Gq/e5DMsF9tnkTF6VaTtAmLetdC6m0ry/od/6Kq/vd
         0GHGBH2mD37EuEPezQfhg0EEXs/jwKWYE0rJTcJwq/czzunK0N7JD//Opcqlu3S3uExy
         fgLN/qOOpvOCcLOoXfz/rlEWVep3WTRupAuQD19q+UUXlH/7/zxePa5O2iTMpP1gBzfq
         6CBg==
X-Gm-Message-State: APjAAAXuRSnKcB5Zkra2NIDC83nQOnX1VB3nY1a+lNnB28LTOsn1P4fx
        k2MOPlpkBawTCFo5t4T4lYQ=
X-Google-Smtp-Source: APXvYqzI7XugKhrUD2ISKoSITMC4xDXu1F2+tRQ/O+1otSv26NNTnycbocgJEljBBIvtNXuOVEpEZg==
X-Received: by 2002:a65:4349:: with SMTP id k9mr22299168pgq.243.1558769114822;
        Sat, 25 May 2019 00:25:14 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id w12sm3997009pgp.51.2019.05.25.00.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 00:25:14 -0700 (PDT)
Date:   Sat, 25 May 2019 12:55:09 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525072509.GA6979@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

./drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c:174:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c:236:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c:285:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c:142:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_dotclock.c:198:1-3: WARNING:
PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c      | 4 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  | 4 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c      | 4 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 4 +---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c  | 4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 2a15f2f..e0fd19d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -195,10 +195,8 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
 	dclk->hw.init = &init;
 
 	tcon->dclk = clk_register(dev, &dclk->hw);
-	if (IS_ERR(tcon->dclk))
-		return PTR_ERR(tcon->dclk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(tcon->dclk);
 }
 EXPORT_SYMBOL(sun4i_dclk_create);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index e826da3..1e74040 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -139,8 +139,6 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
 	ddc->m_offset = hdmi->variant->ddc_clk_m_offset;
 
 	hdmi->ddc_clk = devm_clk_register(hdmi->dev, &ddc->hw);
-	if (IS_ERR(hdmi->ddc_clk))
-		return PTR_ERR(hdmi->ddc_clk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->ddc_clk);
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
index 58e9d37..b72f9c7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -282,10 +282,8 @@ static int sun4i_hdmi_init_regmap_fields(struct sun4i_hdmi *hdmi)
 	hdmi->field_ddc_sck_en =
 		devm_regmap_field_alloc(hdmi->dev, hdmi->regmap,
 					hdmi->variant->field_ddc_sck_en);
-	if (IS_ERR(hdmi->field_ddc_sck_en))
-		return PTR_ERR(hdmi->field_ddc_sck_en);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->field_ddc_sck_en);
 }
 
 int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 2598741..389c1c5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -233,8 +233,6 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 	tmds->div_offset = hdmi->variant->tmds_clk_div_offset;
 
 	hdmi->tmds_clk = devm_clk_register(hdmi->dev, &tmds->hw);
-	if (IS_ERR(hdmi->tmds_clk))
-		return PTR_ERR(hdmi->tmds_clk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index a4d31fe..d52f581 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -171,8 +171,6 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
 	priv->hw.init = &init;
 
 	phy->clk_phy = devm_clk_register(dev, &priv->hw);
-	if (IS_ERR(phy->clk_phy))
-		return PTR_ERR(phy->clk_phy);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy->clk_phy);
 }
-- 
2.7.4

