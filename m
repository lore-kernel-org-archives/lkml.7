Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC72C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C98B2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHWtKbOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:00:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAFOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:00:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so49747938wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RzIMtNvAGQDbPQVx0Hz3IAid0OWJww7Kls0bXG4Uy/E=;
        b=PHWtKbOq/CrEs4SUS0sUv0iWuifZsXc4GJvxG3DUxbB4axii0Sejhfh423vwJbn5ir
         s6IUgTdi/i/a7HmdLf7FFRncae8amgnaQHDmizwDygH2u6JBVkf9kt4dFiqMDXSw1RCe
         MewDaPHANWnLQkO6Sf6xgsSeUIdj/c8hzz0s3rTL3mug6xWH5+TE+6AbV/ehr7xEIkXu
         U+x1jNhka2otSOp2qRo1jK7QXsxJ+t/QjYtJprNIkhRb9vQpNoCC9PVdRcyICnmj745t
         lHiodzueeyX9ZGfz9wNHUgE8fD4EHCAjTtt67RxGO09OfuOLbQ8DKbQbQleVMR/7Fzyy
         OONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RzIMtNvAGQDbPQVx0Hz3IAid0OWJww7Kls0bXG4Uy/E=;
        b=iSGN90t5Ghef4JmfReUFm0BkFNIZ446sEW+mLBIAHIvTDOoIdn/LsImzVdJJ28q+CK
         8SROlwNJPwsObgvmqbksI8XH00qiFn1ybdxDP883ozHuvCjuIoeNHa6rkpxhuMS7lC34
         0TzfTA2U0NyQfy1dOjUQAvAOoCgM+0CCUNXjs83u5tPWl1nvAM9xqNCHEb2ne2Y5kP8M
         mYMB/GMCy+fpk579sbqTs+okJV9R6Tuiznb51cPsuLnk1PGwMuWwGVuxImxnAYPFEL4U
         SpuXHyvWvJiVkKbBuVULdzdpX3vksaCP3Ea72ZldnXfJzc54OkIZ7fBr7m/ECKz5xuMx
         nzQg==
X-Gm-Message-State: APjAAAUJbdtzHA6PEcYdpqFlo6u2Kl9XI4YMsJA88rWrgITLy9PyMqNi
        fQxWJINIPTiRCSVitC7fz8U=
X-Google-Smtp-Source: APXvYqwegU8fPwN/m0F//DfKIlBREr//Y7HVFmc5A7QaEiFngWeOC/9nSkyQ7d0wVBce3/I6w6Zv5w==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr49594123wrx.109.1578319257965;
        Mon, 06 Jan 2020 06:00:57 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id p26sm22566715wmc.24.2020.01.06.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 06:00:57 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: use PTR_ERR_OR_ZERO macro.
Date:   Mon,  6 Jan 2020 17:00:52 +0300
Message-Id: <20200106140052.30747-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of IS_ERR and PTR_ZERO macros by returning the
PTR_ERR_OR_ZERO macro.
Changes suggested by coccinelle. 

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c     | 4 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 4 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c     | 4 +---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 417ade3d2565..84c04d8192b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -191,10 +191,8 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
 	dclk->hw.init = &init;
 
 	tcon->dclk = clk_register(dev, &dclk->hw);
-	if (IS_ERR(tcon->dclk))
-		return PTR_ERR(tcon->dclk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(tcon->dclk);
 }
 EXPORT_SYMBOL(sun4i_dclk_create);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index 2ff780114106..7a59505d6907 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -135,8 +135,6 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
 	ddc->m_offset = hdmi->variant->ddc_clk_m_offset;
 
 	hdmi->ddc_clk = devm_clk_register(hdmi->dev, &ddc->hw);
-	if (IS_ERR(hdmi->ddc_clk))
-		return PTR_ERR(hdmi->ddc_clk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->ddc_clk);
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
index b66fa27fe6ea..12a7b7b1c99c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -278,10 +278,8 @@ static int sun4i_hdmi_init_regmap_fields(struct sun4i_hdmi *hdmi)
 	hdmi->field_ddc_sck_en =
 		devm_regmap_field_alloc(hdmi->dev, hdmi->regmap,
 					hdmi->variant->field_ddc_sck_en);
-	if (IS_ERR(hdmi->field_ddc_sck_en))
-		return PTR_ERR(hdmi->field_ddc_sck_en);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->field_ddc_sck_en);
 }
 
 int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index a4d31fe3abff..fd09eff21b25 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -171,8 +171,6 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
 	priv->hw.init = &init;
 
 	phy->clk_phy = devm_clk_register(dev, &priv->hw);
-	if (IS_ERR(phy->clk_phy))
-		return PTR_ERR(phy->clk_phy);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy->clk_phy)
 }
-- 
2.17.1

