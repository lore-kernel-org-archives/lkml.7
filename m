Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FBC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVByu2Ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408657AbfFLId1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38513 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408628AbfFLIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so6342025plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keSCKeia5rVqG04ZabahyFVQsK++406Zomkh+XqD9yQ=;
        b=QVByu2HoT/nJlM5jE+eRfFtcHUFhKeuuqDodq0ul6OOOgMr75lXrDL3cNBmC15cZwd
         X3V8aj+gm0LNuwqKoV9D2Ou78mRrJwhR5nc1aMN5uw7a6ttOmvkB3no1d5UlbiERk9W2
         MQ8gr1nupekFxtel9//SMGCDjzHOSCEa2u4lbE4Xa0t6tWo5VOfZ3cS50UVDVXccmvEl
         lGGkPoTnpBJ1z0JAM6tdwmOtEAmdnOCmIIva682+RoWyPPmvPAZbxiRL+mGu00VCsN8E
         h0sHAo0NxKjcPJvwDacIHL+xIWsiwRKkewUdYOR4H9lwGumfL0QBQn5QFle1HTkQxG12
         qF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keSCKeia5rVqG04ZabahyFVQsK++406Zomkh+XqD9yQ=;
        b=YBxTATPoQQ+OHIRcpMYHFI8QhCYslny7aqJtU7hvWO5nrcbu+6+DtPwWxkLKLg/l9H
         RdhPo2gmu4ANPTR/w9x4QR1aHFjnMqZwiJI+IH00Sbz5kApaLQo5r4WszLojNqvHKiaR
         R8twMIpz2voltUQhubFKxCDfhlFaTcGGotkdza5ARIJBiF6lSLVsJnQ4trzIiC8QaidX
         vhPWXhGuKS7rRvemioagp6HuketTjdNi/Kw6GK61gUA0BOeQdaHj769aGjrxIk7N4j4y
         Hq/OBqIR/pbQFLmOaTjJNfYy5qCErCWk768FqRUrmLDfMOINdiY/JF88/paCyOtg4ooG
         0L0w==
X-Gm-Message-State: APjAAAWdbzGjXTsIh4Gptq0aLUFzEe7b249Sb9wVphOo1alAV0JFGgff
        Gee5CUln26R/Tx1cpXP7RvGv7kMJl5E=
X-Google-Smtp-Source: APXvYqw77IJvfmWESu6Fkz82MTk/bw5xbnFo/exhAZ9jZ6mrHPK6zgE4uZhDbO5/R00RiYh0KcLtDQ==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr33003851plt.238.1560328403048;
        Wed, 12 Jun 2019 01:33:23 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/15] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Wed, 12 Jun 2019 01:32:48 -0700
Message-Id: <20190612083252.15321-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 46 +++++++++++--------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4bb9b15e1324..ac55b59249e3 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -581,35 +581,40 @@ static int tc_stream_clock_calc(struct tc_data *tc)
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
+	u32 dp0_auxcfg1;
+
 	/* Setup DP-PHY / PLL */
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		goto err;
 
@@ -868,7 +873,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
-	unsigned int rate;
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
@@ -896,25 +900,7 @@ static int tc_main_link_enable(struct tc_data *tc)
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
2.21.0

