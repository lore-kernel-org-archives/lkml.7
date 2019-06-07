Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9EBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D5B2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZecb40z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfFGEqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfFGEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so464142pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lMquvZFr8N9KwzJc1akq7l4rDT1SQxgVj99qRTol7M=;
        b=NZecb40zvEyKE8KgAcakEzvjav3va4X9nd/LcYBLp/F6hfe7+GDHpyissyDVImwFeG
         T+oD81BcxDGo5GAMTdxrhQ919Hoa4G27tZF0LwPbdiWwsZgmPOoUtltUIXgONg4cVH8C
         vXrEvhxERTtIu9v+VDgmrnLRq0JJaVeZ+R0bgyKWW/BsGzqsD6SqlBSboUBMtLLiVtNi
         iwfYFYNHollYhvHniTOFr3faAKIwNyz9FPsAp9Eq0UF8MrDMQGNYEN2pvGJJyxDM6e2D
         FbZM8dsOWe/cBW7fmGetr9ItJMj7rBtjJtyrtKT1zuyfjtsEtaxYvN+RTyhX14oww6EL
         2OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lMquvZFr8N9KwzJc1akq7l4rDT1SQxgVj99qRTol7M=;
        b=NpSLGPWOVWjXD83eX4pAixCqdivZsr79Y8Kb2V8nf+hm2QJEOrJq6eTypAEh9MDvvl
         tQ62DfUDd6daDaB5cKHG+INNNlhIlGh5nr1+CbG3F4sOPrAcJzcd2p7DK9yEGYnhx26s
         pl4lPRZOXr6BiXW5x7NRFBX0eoBUHwwzron4GFJvfAuAI1sCOfC3UQ8lH7Ow6lJ3e+S4
         vqIBuFd2LP/gR6/u4RBmylS1CwdUBvyn9YZiiVIpXRtXZYD5RuDdBWSycyrdYyO4jqQs
         KObbh3C36YPqATqzz4/8cn8rXiABfBCY6rolU6iQ/Dn4ny48IRgi6nVwdTtjd0pp0TN/
         n6FQ==
X-Gm-Message-State: APjAAAWEZuesayfqo/KGHoP12xU7Qp1yXPCJRgiW2fUqTrmVobrtE5Ko
        Ts66tPgnvCH1knB5sTRbe+s=
X-Google-Smtp-Source: APXvYqy6pDwltCxT+kKsO6VjdtBeU2vPe4+qFr30hYLI/OIAbRjER6oN+9+hzEWqForbce5aUyf/iw==
X-Received: by 2002:a17:90a:8e86:: with SMTP id f6mr3396902pjo.66.1559882802943;
        Thu, 06 Jun 2019 21:46:42 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:42 -0700 (PDT)
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
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/15] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Thu,  6 Jun 2019 21:45:46 -0700
Message-Id: <20190607044550.13361-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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

