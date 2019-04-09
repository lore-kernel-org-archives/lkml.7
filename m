Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C02C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DAF2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opVxhz0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDIRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43108 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDIRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so10105090pfd.10;
        Tue, 09 Apr 2019 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bnlZ/hHz2P+XdfA2OTKL/VfiS9qckCeYUcGcUaZUPJQ=;
        b=opVxhz0fsOXp/x3EQw6IhRKSlx7G/xDAheArKDTVorvHhykijNsRv/ryay0ZNyAVY+
         Tb495xgJz5wWiBsTA1xAFNmxaXvDDGKmlHYE5mF/6wPzY+TQ43y4f/N42/33/sSNx8Or
         4cBMiBKIKXRSZ2CQv+ASA58+x24C6HFbZVEQpopFSQCu+GzMEiNNV+AiIvSJRQkbU5ww
         2LDsUZmTNBITJZyYBKyvwkbA+sSrH0j9ndEKdHq5DPmUIE9ROpxk+t3dL7Je8MTDqs92
         TLSuLViN/NV9WsMqZCeTiSk/XnEb48Y89OQBT+50pmXbKeqPlrxcVBShG/tbnIYSwmgP
         dARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bnlZ/hHz2P+XdfA2OTKL/VfiS9qckCeYUcGcUaZUPJQ=;
        b=NdR2y59k2kUs43pRw/UA2j0iNJoZg6OUB4XMyZsAg6WtBF1055h7ZZeFfVgNbj5hLZ
         xW0MwNxJrgrVSf/BhxxkzFXpuet2ZLpLoXPKTVyDLei3RmaxXB0G0CwWwKUl1FEsrb4H
         HNnjYiDKnowzqbEUnFSA7xXHGwGdrjA4xyM6spDOxDE0KmpmmU3sJYi+7IlgqIeH5IzQ
         YMSgFdNFm2a6yxGrHmkgGc+rNLEHRZOA9WPcdCYxUXGk1BfwSEkIcu9EfQ4GfSG3LXTs
         WH7WUk+nW3gIz2qU0M98X8y7K4EqkmOIOV7Ow85Jo2W/r/yWOrSAiFFHRLG6HqncTyae
         8Kjw==
X-Gm-Message-State: APjAAAUW7n/uzHPRkgFRgFEF+ULcHukFchVSASBbBkPNIlftCP8I86K6
        nRaLHBKtxxjNbjGSXFRrLs8=
X-Google-Smtp-Source: APXvYqw7vcq7zSxOxF96FEvco77OOLatQNEF4Wz8ihNNVOHN/q3fdJ+dmf82Ec4j8vdDUHeAUlxoIg==
X-Received: by 2002:a63:7117:: with SMTP id m23mr34950135pgc.271.1554830671117;
        Tue, 09 Apr 2019 10:24:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm65662685pgn.4.2019.04.09.10.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:30 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 14/23] watchdog: rtd119x_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:52 -0700
Message-Id: <1554830641-9247-15-git-send-email-linux@roeck-us.net>
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
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/rtd119x_wdt.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index cb17c49f3534..c4cb23d65218 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -95,12 +95,18 @@ static const struct of_device_id rtd119x_wdt_dt_ids[] = {
 	 { }
 };
 
+static void rtd119x_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
 	int ret;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -108,22 +114,24 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->clk = of_clk_get(pdev->dev.of_node, 0);
+	data->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
 	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		clk_put(data->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(dev, rtd119x_clk_disable_unprepare,
+				       data->clk);
+	if (ret)
 		return ret;
-	}
 
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
 	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
 	data->wdt_dev.min_timeout = 1;
-	data->wdt_dev.parent = &pdev->dev;
+	data->wdt_dev.parent = dev;
 
 	watchdog_stop_on_reboot(&data->wdt_dev);
 	watchdog_set_drvdata(&data->wdt_dev, data);
@@ -133,31 +141,11 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	rtd119x_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
 	rtd119x_wdt_stop(&data->wdt_dev);
 
-	ret = watchdog_register_device(&data->wdt_dev);
-	if (ret) {
-		clk_disable_unprepare(data->clk);
-		clk_put(data->clk);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int rtd119x_wdt_remove(struct platform_device *pdev)
-{
-	struct rtd119x_watchdog_device *data = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&data->wdt_dev);
-
-	clk_disable_unprepare(data->clk);
-	clk_put(data->clk);
-
-	return 0;
+	return devm_watchdog_register_device(dev, &data->wdt_dev);
 }
 
 static struct platform_driver rtd119x_wdt_driver = {
 	.probe = rtd119x_wdt_probe,
-	.remove = rtd119x_wdt_remove,
 	.driver = {
 		.name = "rtd1295-watchdog",
 		.of_match_table	= rtd119x_wdt_dt_ids,
-- 
2.7.4

