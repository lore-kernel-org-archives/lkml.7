Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2DB206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DZP420mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfLaNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:06:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33551 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLaNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:06:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so19528976pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILMGQ7TE10GrDN5X2gxz42T2rcYYzl5utH4bizVuaeo=;
        b=DZP420mWfQnfVWlE37Mc5cOgEn4j+vFTaGXmym5C2WWLC5bTeIa5rgJQwtNJNNGWDR
         ZJgOgh0rngjU/6G9BK3E3+O2++mKx/KQxUcIUXPxIuQhz49olxOhu3BbifgeNYXlHOzT
         HON9n6PvwA76fYj2xGIJjx5+TNJ9pAfTXsZec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILMGQ7TE10GrDN5X2gxz42T2rcYYzl5utH4bizVuaeo=;
        b=OCZCrJx5qVXEqWGbDA/OlIOHCR4vB+bccZw7Iuhgw1ytaFYxYFnoK85PkJfq3vhflJ
         LA0XSutsiny+jQgNVS72DLiFNaSRF1LELFYH8zTVuYaEH+8+5Tx1ZMWnRvuuX9RFH+ua
         ChLwjrMoBoOC8zZli+VvWE0rZWdpWEV4xhA5VHxWbDPxNsDs/Si/8rSR0tFP06B6t4g+
         mkNcwBdDh3T/NZt6TMR8sxw8gVosJ2f3h3hJE5tqbw48bykd24p5f2lfcIVZarOK5FEp
         iovIY9uMcGfJcAtmKdF4U7iSe3nlB9dxm8I+ug3qRs09to+VqyO51SSPc4wlAkppoxBy
         lHDw==
X-Gm-Message-State: APjAAAU10SMVLleeYww75Of6IW5b3nylRrh0DSGKYk5xNsXgRn3/20To
        oKW1PKcATZD8Hc+4o9iy7v9lDg==
X-Google-Smtp-Source: APXvYqzYR9X9eEbz3QVs9vCw1ydwxY3WYB9x7Vgfh8FcbAGgp7o5CF2hQkexzWnq4JrUkzJbcSw0Wg==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr77454505pgf.143.1577797567531;
        Tue, 31 Dec 2019 05:06:07 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:06:06 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 5/9] drm/sun4i: tcon_top: Register reset, clock gates in probe
Date:   Tue, 31 Dec 2019 18:35:24 +0530
Message-Id: <20191231130528.20669-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON TOP is processing clock gates and reset control for
TV0, TV1 and DSI channels during bind and release the same
during unbind component ops.

The usual DSI initialization would setup all controller
clocks along with DPHY clocking during probe.

Since the actual clock gates (along with DSI clock gate)
are initialized during ton top bind, the DPHY is failed to
get the DSI clock during that time.

To solve, this circular dependency move the reset control,
clock gate registration from bind to probe and release the
same from unbind to remove.

This eventually give a chance DPHY to initialize the DSI
clock gate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- fixed comments from Chen-Yu
- move reset control methods into probe

 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 41 +++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index e0b3c5330b9a..732ac19b4371 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -124,7 +124,22 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
 static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 			       void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	return 0;
+}
+
+static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
+				  void *data)
+{
+}
+
+static const struct component_ops sun8i_tcon_top_ops = {
+	.bind	= sun8i_tcon_top_bind,
+	.unbind	= sun8i_tcon_top_unbind,
+};
+
+static int sun8i_tcon_top_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct clk_hw_onecell_data *clk_data;
 	struct sun8i_tcon_top *tcon_top;
 	const struct sun8i_tcon_top_quirks *quirks;
@@ -132,7 +147,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	void __iomem *regs;
 	int ret, i;
 
-	quirks = of_device_get_match_data(&pdev->dev);
+	quirks = of_device_get_match_data(dev);
 
 	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
 	if (!tcon_top)
@@ -226,22 +241,21 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 
 	dev_set_drvdata(dev, tcon_top);
 
-	return 0;
+	return component_add(dev, &sun8i_tcon_top_ops);
 
 err_unregister_gates:
 	for (i = 0; i < CLK_NUM; i++)
 		if (!IS_ERR_OR_NULL(clk_data->hws[i]))
 			clk_hw_unregister_gate(clk_data->hws[i]);
-	clk_disable_unprepare(tcon_top->bus);
 err_assert_reset:
 	reset_control_assert(tcon_top->rst);
 
 	return ret;
 }
 
-static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
-				  void *data)
+static int sun8i_tcon_top_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
 	struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
 	int i;
@@ -253,21 +267,8 @@ static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
 
 	clk_disable_unprepare(tcon_top->bus);
 	reset_control_assert(tcon_top->rst);
-}
-
-static const struct component_ops sun8i_tcon_top_ops = {
-	.bind	= sun8i_tcon_top_bind,
-	.unbind	= sun8i_tcon_top_unbind,
-};
-
-static int sun8i_tcon_top_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &sun8i_tcon_top_ops);
-}
 
-static int sun8i_tcon_top_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &sun8i_tcon_top_ops);
+	component_del(dev, &sun8i_tcon_top_ops);
 
 	return 0;
 }
-- 
2.18.0.321.gffc6fa0e3

