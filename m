Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F11C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E8C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Omtw/7fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfFNQoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:44:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfFNQoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:44:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so1872530pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McEpOMxF1Vqb5MJSgPkNba+7ZuPO/C5gMlpl5BrKm+A=;
        b=Omtw/7fqRACdWb3zRgWBPH7EAE2HAfbPSZ2rNPxyrMfcrOvdFYkSFohGF4Ohfaasdp
         7f9VvcNqpcAkJ2IOqcijPmAnLsmJ9C5Dis36l0V0HjciBE5O4bepOtik7swQAd4gb8dr
         jAa437e0YKrxrgEUlm1JoqaR10yDDYdzfv1e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McEpOMxF1Vqb5MJSgPkNba+7ZuPO/C5gMlpl5BrKm+A=;
        b=k8INNp12JJqRQYMXOXwqvi/petrnPfmPiJLuaoMw3UssuPgw0ZgzOATfbDVq4yA3Ws
         ktoEyBXvvfC9vG0VS+7O05MFNrthKPdRcoHEJx9c6fRH8kTOwrr1u9CFnaK4gIg4wC9L
         8/K9yX+/g2MO9Quo1XuLzcj2phIJCOabIfSruZFewuXwNgz3BzDugawm2nDw9Q75zOT4
         R795VAdCxdzEEURYDxo5SWZsHZ5Wz7FpB8H5a808t2wpmBw2lTAKJvB/wXQP02f7KaoJ
         gNee/3JBzLEW6uE/Avc7spHHG0jr/YLZS7vXegxVlIdembqEdncgDDykKRnO5jhiZrFT
         XILg==
X-Gm-Message-State: APjAAAU/sr5F5+uHIo+sKJT1Y/YyehxX2wR3GP37rv0E9K6CVQudNLvu
        8mswB0e6OE57xqFNEZrFYByRTQ==
X-Google-Smtp-Source: APXvYqzzA+CXCBhKMf8rKwu5vgA3fMFWJoxmx7tNZQBVGL/nc+y3J9OVfW6PCTjNCi7M0y2RH+py1w==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr12317652pje.59.1560530641316;
        Fri, 14 Jun 2019 09:44:01 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:00 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 5/9] drm/sun4i: tcon_top: Register clock gates in probe
Date:   Fri, 14 Jun 2019 22:13:20 +0530
Message-Id: <20190614164324.9427-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON TOP have clock gates for TV0, TV1, dsi and right
now these are register during bind call.

Of which, dsi clock gate would required during DPHY probe
but same can miss to get since tcon top is not bound at
that time.

To solve, this circular dependency move the clock gate
registration from bind to probe so-that DPHY can get the
dsi gate clock on time.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 465e9b0cdfee..a8978b3fe851 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
 static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 			       void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(tcon_top->rst);
+	if (ret) {
+		dev_err(dev, "Could not deassert ctrl reset control\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tcon_top->bus);
+	if (ret) {
+		dev_err(dev, "Could not enable bus clock\n");
+		goto err_assert_reset;
+	}
+
+	return 0;
+
+err_assert_reset:
+	reset_control_assert(tcon_top->rst);
+
+	return ret;
+}
+
+static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
+				  void *data)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
+	int i;
+
+	of_clk_del_provider(dev->of_node);
+	for (i = 0; i < CLK_NUM; i++)
+		if (clk_data->hws[i])
+			clk_hw_unregister_gate(clk_data->hws[i]);
+
+	clk_disable_unprepare(tcon_top->bus);
+	reset_control_assert(tcon_top->rst);
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
@@ -132,7 +178,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	void __iomem *regs;
 	int ret, i;
 
-	quirks = of_device_get_match_data(&pdev->dev);
+	quirks = of_device_get_match_data(dev);
 
 	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
 	if (!tcon_top)
@@ -164,18 +210,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	ret = reset_control_deassert(tcon_top->rst);
-	if (ret) {
-		dev_err(dev, "Could not deassert ctrl reset control\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(tcon_top->bus);
-	if (ret) {
-		dev_err(dev, "Could not enable bus clock\n");
-		goto err_assert_reset;
-	}
-
 	/*
 	 * At least on H6, some registers have some bits set by default
 	 * which may cause issues. Clear them here.
@@ -226,45 +260,15 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 
 	dev_set_drvdata(dev, tcon_top);
 
-	return 0;
+	return component_add(dev, &sun8i_tcon_top_ops);
 
 err_unregister_gates:
 	for (i = 0; i < CLK_NUM; i++)
 		if (!IS_ERR_OR_NULL(clk_data->hws[i]))
 			clk_hw_unregister_gate(clk_data->hws[i]);
-	clk_disable_unprepare(tcon_top->bus);
-err_assert_reset:
-	reset_control_assert(tcon_top->rst);
-
 	return ret;
 }
 
-static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
-				  void *data)
-{
-	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
-	struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
-	int i;
-
-	of_clk_del_provider(dev->of_node);
-	for (i = 0; i < CLK_NUM; i++)
-		if (clk_data->hws[i])
-			clk_hw_unregister_gate(clk_data->hws[i]);
-
-	clk_disable_unprepare(tcon_top->bus);
-	reset_control_assert(tcon_top->rst);
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
-
 static int sun8i_tcon_top_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &sun8i_tcon_top_ops);
-- 
2.18.0.321.gffc6fa0e3

