Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751B2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D62133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnteAQz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDIR01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:26:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37902 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfDIRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so5321127plb.5;
        Tue, 09 Apr 2019 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7pXl0rEiajoRYlmlyCcHrLu1k72W3SQ3h4ZaNh/x7o=;
        b=tnteAQz1tdJzzwbiVs2GoawFebbqelB4dQlH3F4MJnezM74hZoa9Xu2ooG4FA3ICta
         UBp1WKLAE+w5mfRVhRUWc/eQ7DFpeHnwk3KDrfHA3wrNvaN1j7HsjVTDrG0nxjTEEebJ
         GYDL1FFJ52KNEKvHXTHsWQQLeQMIFRdT56BENTSHgL34A2yW0V6Os/GkkfOKuEt23yEW
         fBDK8woJ1SJn65MOz6R8Nsl0lQ11PUJKkbRnbQ9dJyHSiBBa0+NKtGnVAYFb1X+P/xTS
         EiRhXIbluHBQhFX5zzGLCM7+Z2m8AaK8WagQjtQYmHctvh72UKI6vkAh8YrDwSBtkaIW
         DuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=N7pXl0rEiajoRYlmlyCcHrLu1k72W3SQ3h4ZaNh/x7o=;
        b=m/L64qry3Z/PfD8mTZOZU+abkNms1d5G1F7vxGu/XYAt4sv1OcRES0U9I2izr7zNb0
         EYIh+aLB38k9JVZtBLQCK+Dr7At6V5Mef+lmnc4A5qOssln1338/f0qGcpPIIDkmBhH+
         TvNyUzCZr/2uvqhm9+7ozbvwFngQHt2YslUDKSsIwURTggE2wwL7GR/NN1S828XNndl/
         uyWHUH7SXD/8xW/7vktkT5XOC9QeEU3IIEwj9s3tF2P2WSxFfbJwxpqp1nukUmn3HytU
         hzZ3DnoOGb32xYdbfwh5JtAi4gUxhjhfZsAloeWyv7C6p0iM+f3EL4fX31vk+5B/JK1u
         9RjQ==
X-Gm-Message-State: APjAAAWpLSmiDhTbJRtu9dyGxOfpNhJifLbUQcGTUiK4oYIsot2Z7APU
        RLq6voH90hIs8Y6Wszu0SN8=
X-Google-Smtp-Source: APXvYqzlxQr64knfrR1xhd2KeQOIXl/VzuGHLqSS4vGWT91fbY6ysozucteFE2bwgHBbr27xlCjkJQ==
X-Received: by 2002:a17:902:e709:: with SMTP id co9mr38932668plb.86.1554830657206;
        Tue, 09 Apr 2019 10:24:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5sm39338725pgp.80.2019.04.09.10.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:16 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 04/23] watchdog: meson_gxbb_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:42 -0700
Message-Id: <1554830641-9247-5-git-send-email-linux@roeck-us.net>
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
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/meson_gxbb_wdt.c | 45 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index a8ed75cc9a6e..d17c1a6ed723 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -136,12 +136,18 @@ static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
 
+static void meson_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct meson_gxbb_wdt *data;
 	int ret;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -149,17 +155,21 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->reg_base))
 		return PTR_ERR(data->reg_base);
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
+	data->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
 	ret = clk_prepare_enable(data->clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(dev, meson_clk_disable_unprepare,
+				       data->clk);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, data);
 
-	data->wdt_dev.parent = &pdev->dev;
+	data->wdt_dev.parent = dev;
 	data->wdt_dev.info = &meson_gxbb_wdt_info;
 	data->wdt_dev.ops = &meson_gxbb_wdt_ops;
 	data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
@@ -176,37 +186,12 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 
 	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
 
-	ret = watchdog_register_device(&data->wdt_dev);
-	if (ret) {
-		clk_disable_unprepare(data->clk);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int meson_gxbb_wdt_remove(struct platform_device *pdev)
-{
-	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&data->wdt_dev);
-
-	clk_disable_unprepare(data->clk);
-
-	return 0;
-}
-
-static void meson_gxbb_wdt_shutdown(struct platform_device *pdev)
-{
-	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
-
-	meson_gxbb_wdt_stop(&data->wdt_dev);
+	watchdog_stop_on_reboot(&data->wdt_dev);
+	return devm_watchdog_register_device(dev, &data->wdt_dev);
 }
 
 static struct platform_driver meson_gxbb_wdt_driver = {
 	.probe	= meson_gxbb_wdt_probe,
-	.remove	= meson_gxbb_wdt_remove,
-	.shutdown = meson_gxbb_wdt_shutdown,
 	.driver = {
 		.name = "meson-gxbb-wdt",
 		.pm = &meson_gxbb_wdt_pm_ops,
-- 
2.7.4

