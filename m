Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD5BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DF420863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR9gD2hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfDHTjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfDHTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so8192417pfi.12;
        Mon, 08 Apr 2019 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0UJoYAqIWL8MWfY4mue8flNXi0lxQzA3Ojf53WPbeQ=;
        b=CR9gD2hfp1sTXzlbkMBXjvJNPhVopjkJzMGnLmhYgwPlFwqAvRttLfydjCIt3BWFkA
         UbTMKmbE93FugnPJ2OID2WtMBO9ZNX/ojJHHQvuleAcjZPudGaEKp4UBsiCdrFy6em50
         8gknuqJuuV7OBR4UiL/B8bMF7qSgpKapyrV16/WZfJZB0BJDAW1voYSCMqycciplJpiZ
         mN3Q4tVMzGHXKttU5nuBawh+WsNO0oM5x3PJc7NawJ8VnTB7jQRq+g5/Q2M6XNIbw+xL
         0C5YS+piYWQl/ltpmZ9RGky8cgIWOzCNNrXFjn+8s96ySwHEJOzuRmJlD8l1HV0M/Ocr
         CcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=P0UJoYAqIWL8MWfY4mue8flNXi0lxQzA3Ojf53WPbeQ=;
        b=tzVKVFypnJgdgc/LxK9S9YZ3NSaxflXfVtTqCjIpx87IzKAsMA1SBbbaz/yVZrHo95
         kICt0srXECw67kklgacD3QOE0RrXxA4WV/rlZ78tk+E8LACtW74WgicztgGeWPnv7WXx
         DfywBFx6oKGUwyURP5FsBYS3TELEprdPqFbDYs/TdRsSyP9o0+62go1x7EPGzszJ1HXR
         p9wYfHnL0repS/74c3fHKxBORGB/0vwinuAgG4SghRVwEP9+sgMr4M1kQkj6la50pcTm
         jjIaeuvVjqntgFFSbe4jm8jDT5dFzUTw2+Js/muoKX6WGQKyMVOxXvgiCYHYJ0sTPg3z
         G6Mw==
X-Gm-Message-State: APjAAAUfJQsZHYW6qNfndAgGzYL0OEPiFLdIVW28DoLw9JbwShfeIFcx
        e/2NEslmkXuC0rh8aDkzWRzsgXRC
X-Google-Smtp-Source: APXvYqx0xd9x3HdNECU1T29vgKjUPtLinL40XEYbBTLflWJGF5IAvYPq0bv96YW6DoRqOGsz4OCdmA==
X-Received: by 2002:a62:1d94:: with SMTP id d142mr30962597pfd.83.1554752380107;
        Mon, 08 Apr 2019 12:39:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm41600993pgd.32.2019.04.08.12.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:39 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/22] watchdog: asm9260_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:26 -0700
Message-Id: <1554752326-13319-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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
- Replace 'goto l; ... l: return e;' with 'return e;'
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/asm9260_wdt.c | 73 +++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 1de272bb2070..c5b9aae544dd 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -196,6 +196,11 @@ static const struct watchdog_ops asm9260_wdt_ops = {
 	.restart	= asm9260_restart,
 };
 
+static void asm9260_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
 {
 	int err;
@@ -219,26 +224,32 @@ static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
 		dev_err(priv->dev, "Failed to enable ahb_clk!\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(priv->dev,
+				       asm9260_clk_disable_unprepare,
+				       priv->clk_ahb);
+	if (err)
+		return err;
 
 	err = clk_set_rate(priv->clk, CLOCK_FREQ);
 	if (err) {
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed to set rate!\n");
 		return err;
 	}
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed to enable clk!\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(priv->dev,
+				       asm9260_clk_disable_unprepare,
+				       priv->clk);
+	if (err)
+		return err;
 
 	/* wdt has internal divider */
 	clk = clk_get_rate(priv->clk);
 	if (!clk) {
-		clk_disable_unprepare(priv->clk);
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed, clk is 0!\n");
 		return -EINVAL;
 	}
@@ -274,23 +285,23 @@ static void asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
 
 static int asm9260_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct asm9260_wdt_priv *priv;
 	struct watchdog_device *wdd;
 	int ret;
 	static const char * const mode_name[] = { "hw", "sw", "debug", };
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
-			    GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(struct asm9260_wdt_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->dev = &pdev->dev;
+	priv->dev = dev;
 
 	priv->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
-	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
+	priv->rst = devm_reset_control_get_exclusive(dev, "wdt_rst");
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
@@ -303,7 +314,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &asm9260_wdt_ops;
 	wdd->min_timeout = 1;
 	wdd->max_timeout = BM_WDTC_MAX(priv->wdt_freq);
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, priv);
 
@@ -313,7 +324,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	 * the max instead.
 	 */
 	wdd->timeout = ASM9260_WDT_DEFAULT_TIMEOUT;
-	watchdog_init_timeout(wdd, 0, &pdev->dev);
+	watchdog_init_timeout(wdd, 0, dev);
 
 	asm9260_wdt_get_dt_mode(priv);
 
@@ -325,49 +336,25 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 		 * Not all supported platforms specify an interrupt for the
 		 * watchdog, so let's make it optional.
 		 */
-		ret = devm_request_irq(&pdev->dev, priv->irq,
-				       asm9260_wdt_irq, 0, pdev->name, priv);
+		ret = devm_request_irq(dev, priv->irq, asm9260_wdt_irq, 0,
+				       pdev->name, priv);
 		if (ret < 0)
-			dev_warn(&pdev->dev, "failed to request IRQ\n");
+			dev_warn(dev, "failed to request IRQ\n");
 	}
 
 	watchdog_set_restart_priority(wdd, 128);
 
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
-		goto clk_off;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
-	dev_info(&pdev->dev, "Watchdog enabled (timeout: %d sec, mode: %s)\n",
+	dev_info(dev, "Watchdog enabled (timeout: %d sec, mode: %s)\n",
 		 wdd->timeout, mode_name[priv->mode]);
 	return 0;
-
-clk_off:
-	clk_disable_unprepare(priv->clk);
-	clk_disable_unprepare(priv->clk_ahb);
-	return ret;
-}
-
-static void asm9260_wdt_shutdown(struct platform_device *pdev)
-{
-	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
-
-	asm9260_wdt_disable(&priv->wdd);
-}
-
-static int asm9260_wdt_remove(struct platform_device *pdev)
-{
-	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
-
-	asm9260_wdt_disable(&priv->wdd);
-
-	watchdog_unregister_device(&priv->wdd);
-
-	clk_disable_unprepare(priv->clk);
-	clk_disable_unprepare(priv->clk_ahb);
-
-	return 0;
 }
 
 static const struct of_device_id asm9260_wdt_of_match[] = {
@@ -382,8 +369,6 @@ static struct platform_driver asm9260_wdt_driver = {
 		.of_match_table	= asm9260_wdt_of_match,
 	},
 	.probe = asm9260_wdt_probe,
-	.remove = asm9260_wdt_remove,
-	.shutdown = asm9260_wdt_shutdown,
 };
 module_platform_driver(asm9260_wdt_driver);
 
-- 
2.7.4

