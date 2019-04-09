Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E527C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6149C2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIuUgu3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDIRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfDIRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so9810672ply.4;
        Tue, 09 Apr 2019 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H6MIpn01nQGgr4gWV6XiOub4WhlBGRZ9EDKqwwULRjo=;
        b=GIuUgu3cjFcOhhqpXuc7V9A1832EcFD0n0OCIFv+TP1czEW8TsW5Q2hgWsJH4QN+Xp
         jiVUwFs822SoFfEIL/pLConMdFxPfBlVs36jDGZEx/V3GYjNJ8zVxjqzYSNSox+gz1bY
         CGzOQkgR2UZS43ktNnV/iYmOIz4tlwLUZ0mCMmU+4yRgs/fYJpAyvzQ2+2URQsrW1TJT
         UySI/LFD4D+Nia79Rh/QnpELU+U5v/a5u4Wn8VQqzeMuCVBVmCfigm3QfTd9sc5Onpeh
         G0D2DbnseWJtKVRXh9EQdJBaHfwLqehqJgtj5+++KHTQX5uGZgrDWPIWgOdTy028kxaV
         NFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=H6MIpn01nQGgr4gWV6XiOub4WhlBGRZ9EDKqwwULRjo=;
        b=N49mgYiXcenRhTOLbSXbRGdURxzWnIkrVwVJCG68Hg1gSGowoMpLBisLGafMSTn8CT
         D0kIeZyYRyeIwuF1sehsn8nXN2OHPsI8HG2GuaD3ul2lHxCXzQv0W2ZAeAQbc7uce9MT
         SZNtIh0qVFfmeXE1PDs6lk8FX2Ev4xqwvljwHbvcXFtIeJnkYal85qeg87qLKj+//Ygf
         mycdREiazKSIyiQf3cimvx3qcKXZJPgA8cCG+Knzt6Aixg/ZT+URh+W2fOzYquGFSxMT
         fk6C59EMl/Hcq96cHQ2oRDbCPiPPw6UVMicafEnJM+cLNj5JQvz23ikASibknLxg/DOj
         D88g==
X-Gm-Message-State: APjAAAXXNJDND1zZzdLHoweqFPv+xrw1E99nKs6KkP6AEDN3r8AIQLlr
        /6CiG6XyAJoJz3xIfW9pYDk=
X-Google-Smtp-Source: APXvYqyNhRqiUe2Su255D2H++loLO0HocAMUANlsuwl1T0LaE7KWsE6DnNLODwF0hRzc+kTmQ6ZRyA==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr31531975plb.243.1554830665725;
        Tue, 09 Apr 2019 10:24:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o81sm29860950pfa.156.2019.04.09.10.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 10/23] watchdog: of_xilinx_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:48 -0700
Message-Id: <1554830641-9247-11-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/of_xilinx_wdt.c | 58 ++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 5c977164b3e5..03786992b701 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -151,41 +151,46 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
 		return XWT_TIMER_FAILED;
 }
 
+static void xwdt_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int xwdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int rc;
 	u32 pfreq = 0, enable_once = 0;
 	struct xwdt_device *xdev;
 	struct watchdog_device *xilinx_wdt_wdd;
 
-	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
+	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
 	if (!xdev)
 		return -ENOMEM;
 
 	xilinx_wdt_wdd = &xdev->xilinx_wdt_wdd;
 	xilinx_wdt_wdd->info = &xilinx_wdt_ident;
 	xilinx_wdt_wdd->ops = &xilinx_wdt_ops;
-	xilinx_wdt_wdd->parent = &pdev->dev;
+	xilinx_wdt_wdd->parent = dev;
 
 	xdev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xdev->base))
 		return PTR_ERR(xdev->base);
 
-	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
+	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-interval",
 				  &xdev->wdt_interval);
 	if (rc)
-		dev_warn(&pdev->dev,
-			 "Parameter \"xlnx,wdt-interval\" not found\n");
+		dev_warn(dev, "Parameter \"xlnx,wdt-interval\" not found\n");
 
-	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
+	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-enable-once",
 				  &enable_once);
 	if (rc)
-		dev_warn(&pdev->dev,
+		dev_warn(dev,
 			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
-	xdev->clk = devm_clk_get(&pdev->dev, NULL);
+	xdev->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(xdev->clk)) {
 		if (PTR_ERR(xdev->clk) != -ENOENT)
 			return PTR_ERR(xdev->clk);
@@ -196,10 +201,10 @@ static int xwdt_probe(struct platform_device *pdev)
 		 */
 		xdev->clk = NULL;
 
-		rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+		rc = of_property_read_u32(dev->of_node, "clock-frequency",
 					  &pfreq);
 		if (rc)
-			dev_warn(&pdev->dev,
+			dev_warn(dev,
 				 "The watchdog clock freq cannot be obtained\n");
 	} else {
 		pfreq = clk_get_rate(xdev->clk);
@@ -218,44 +223,34 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	rc = clk_prepare_enable(xdev->clk);
 	if (rc) {
-		dev_err(&pdev->dev, "unable to enable clock\n");
+		dev_err(dev, "unable to enable clock\n");
 		return rc;
 	}
+	rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
+				      xdev->clk);
+	if (rc)
+		return rc;
 
 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
-		dev_err(&pdev->dev, "SelfTest routine error\n");
-		goto err_clk_disable;
+		dev_err(dev, "SelfTest routine error\n");
+		return rc;
 	}
 
-	rc = watchdog_register_device(xilinx_wdt_wdd);
+	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
 	if (rc) {
-		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
-		goto err_clk_disable;
+		dev_err(dev, "Cannot register watchdog (err=%d)\n", rc);
+		return rc;
 	}
 
 	clk_disable(xdev->clk);
 
-	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
+	dev_info(dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
 		 xdev->base, xilinx_wdt_wdd->timeout);
 
 	platform_set_drvdata(pdev, xdev);
 
 	return 0;
-err_clk_disable:
-	clk_disable_unprepare(xdev->clk);
-
-	return rc;
-}
-
-static int xwdt_remove(struct platform_device *pdev)
-{
-	struct xwdt_device *xdev = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
-	clk_disable_unprepare(xdev->clk);
-
-	return 0;
 }
 
 /**
@@ -303,7 +298,6 @@ MODULE_DEVICE_TABLE(of, xwdt_of_match);
 
 static struct platform_driver xwdt_driver = {
 	.probe       = xwdt_probe,
-	.remove      = xwdt_remove,
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
-- 
2.7.4

