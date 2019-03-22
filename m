Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F32082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pETWdX7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCVD34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42971 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCVD3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so488358pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6utk7J9wv7nvQ22DGj7RjxJtV/DljhXKoSc+u7lmTcY=;
        b=pETWdX7EfJiGQ9OaW2mQm36/YbOXBXYnPq3VGksq/ZpMepoLE69m2mT4eRuQhaAhrM
         kxpJIt6HabeQub2VbQoknDt319Xmijt0aTTYTG1CrBv4K0FJ2ZmmV+IVuvWQy5puhR3d
         2kfWDD7wGtWhbrf6UUVWTIpW+Ybc7FxNFymw5ZfMp+ouK7NDWZROS6f/6fd5dzPJWVHB
         w4X6uh0s4bZASOoXxJoG0xLh8ZwBIZMFgpg+fV9f0XK8Q9VKr8ZBPFklbRo0pZ+DmG14
         hFCV5reWpcMTZZ3MYyH+Ipes9M6r2PmQqPzq09D0IPghi3Ol6QQLf0WQ2oo6191mKU7c
         zxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6utk7J9wv7nvQ22DGj7RjxJtV/DljhXKoSc+u7lmTcY=;
        b=cSApCLyCGb9ODz5MJ6oFq9/vcJG9ujTaYI2zLazyfptTrnXg6mrqVWF3ItQyeVmN2I
         n9MqkoS4EmvpS/18X3hb9uM0O/6WZpZqzWq3ONfRmLfmTFvolfE/Xp8QsB1SzmjO2b9F
         H1oMU+YCcrcK+x6srCxyXsJLMeleA8hePXAA7EbsFS08JquK06g0/hOYoGNiRzwiNAaf
         5UieItfXYzfAHC/iIKYi1iCLWgjcw3FfEjgdYNJDhhoLEqdTmpuqQwXgWrTj7nYM280i
         ySrkita8cysFbeH+0XkLJUIrcMP0l54rU38JeiihuKaGKHFF3BTeuKAKOAirmJ59r2Qf
         RIAA==
X-Gm-Message-State: APjAAAVfn0hOTqaSsQKHUMZzFmK0cMYbm2bcp5SwlSrZd9yUVEWZUMxu
        XStMio1BKgpoPxUJpBEot/s=
X-Google-Smtp-Source: APXvYqxSTlcFL3ajUgbOM6iqHwsOMLSisWMCnA4jSLDdK33REA92iMbqIrHM4pW5R6jrpa+SZMwaKA==
X-Received: by 2002:a17:902:ba8c:: with SMTP id k12mr7268257pls.193.1553225369416;
        Thu, 21 Mar 2019 20:29:29 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:28 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Thu, 21 Mar 2019 20:28:57 -0700
Message-Id: <20190322032901.12045-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common code converting clock rate to an appropriate constant and
configuring SYS_PLLPARAM register into a separate routine and convert
the rest of the code to use it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 48 +++++++++++--------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 768f01cc2a30..976a9861e537 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -585,35 +585,41 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
-static int tc_aux_link_setup(struct tc_data *tc)
+static int tc_set_syspllparam(struct tc_data *tc)
 {
 	unsigned long rate;
-	u32 dp0_auxcfg1;
-	u32 value;
-	int ret;
+	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
 	case 38400000:
-		value = REF_FREQ_38M4;
+		pllparam |= REF_FREQ_38M4;
 		break;
 	case 26000000:
-		value = REF_FREQ_26M;
+		pllparam |= REF_FREQ_26M;
 		break;
 	case 19200000:
-		value = REF_FREQ_19M2;
+		pllparam |= REF_FREQ_19M2;
 		break;
 	case 13000000:
-		value = REF_FREQ_13M;
+		pllparam |= REF_FREQ_13M;
 		break;
 	default:
 		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
 		return -EINVAL;
 	}
 
+	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
+}
+
+static int tc_aux_link_setup(struct tc_data *tc)
+{
+	int ret;
+	u32 dp_phy_ctrl;
+	u32 dp0_auxcfg1;
+
 	/* Setup DP-PHY / PLL */
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		goto err;
 
@@ -817,8 +823,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
-	unsigned int rate;
-	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -840,25 +844,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	if (ret)
 		return ret;
 
-	rate = clk_get_rate(tc->refclk);
-	switch (rate) {
-	case 38400000:
-		value = REF_FREQ_38M4;
-		break;
-	case 26000000:
-		value = REF_FREQ_26M;
-		break;
-	case 19200000:
-		value = REF_FREQ_19M2;
-		break;
-	case 13000000:
-		value = REF_FREQ_13M;
-		break;
-	default:
-		return -EINVAL;
-	}
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		return ret;
 
-- 
2.20.1

