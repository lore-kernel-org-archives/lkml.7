Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C907C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZ4BRql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfDHTkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfDHTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so8222534pfd.1;
        Mon, 08 Apr 2019 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERMFdfRvh7kZl1Kk7yPs6AsCvVFzP42gT21bBI7whoA=;
        b=jAZ4BRql/9NJk8pWEtGVC+l+pevg+dMYpP8pJXmw5XFiP8esW55M0gyNVUKwMQjqah
         Y1O8xxX+igDrNNGbnuhcNO1l/rGLna9OuL4mt4tY70C96y9oTIkNVYVMyn2+zieeY1JB
         bF1Pb2DzFNHk7JONU1+TrfkODiF2QyCkgiRTiJzMPgXvLtp7aFMlCkMZfX5k/WrsTlSe
         FRKPqtnlZJUab4WPIhetBTEVDopuATW3zmV5ErdmRUPZTpRzloNR8aGmpko9J7NBnG1Z
         ff5jVHPrFtK05qF7XCjkhYHXpfpay3u7khatGUoUkIBBsGLuQnc7EkCekQYUeL3h9klS
         bsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ERMFdfRvh7kZl1Kk7yPs6AsCvVFzP42gT21bBI7whoA=;
        b=r5URLiWFHW6EAW8qY4egf3XTnPhlTG0ZBLcGLlDa1aqLDMt5altIOd2heql4JEAwD7
         irSTmx6hjFC24ZDhDn5eZ6QVDf5BavkFppRl3ByhsKZMpJCVbvTpIK92fUmnUFi5oWxP
         u5Y7EIlkkEa10fTTBF47VVwOzNeI1Io1V0wwOpPQDPfBZ1qjm6NirqxgHqCQu8wFDVzU
         B+dwb1tmTcTEHs7Xw2FArXJQRUTVnRp05mbTyeWsEr79cacMMYdOnhlZhljW7BCai0pT
         j2oTUn7hk2achaq2uXq99jaERF0XyKukxogrhQd6M1kMo6xWpUjzfT0aBm3Cg9SBvfHB
         voZA==
X-Gm-Message-State: APjAAAWrSipOlpVS4IH5SmX19n5tt/l7AQ6CEl+x4EIra6etyA+Itih4
        Lnyt+WSDNtElPlzdh81qkfY=
X-Google-Smtp-Source: APXvYqyH7xbTPuNXARFRppdpZyz/ZsYmLQNKBPqKADeU0rCIwWWo8wLpgHJN1Kp11E+jcUJNU4LCpg==
X-Received: by 2002:a63:185a:: with SMTP id 26mr3809215pgy.337.1554752396788;
        Mon, 08 Apr 2019 12:39:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v12sm40836857pfe.148.2019.04.08.12.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:56 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 14/22] watchdog: ep93xx_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:38 -0700
Message-Id: <1554752326-13319-15-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatedly.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ep93xx_wdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 1e721c2f9eac..38e26f160b9a 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -89,12 +89,13 @@ static const struct watchdog_ops ep93xx_wdt_ops = {
 
 static int ep93xx_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct ep93xx_wdt_priv *priv;
 	struct watchdog_device *wdd;
 	unsigned long val;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -110,21 +111,21 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &ep93xx_wdt_ops;
 	wdd->min_timeout = 1;
 	wdd->max_hw_heartbeat_ms = 200;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	watchdog_set_nowayout(wdd, nowayout);
 
 	wdd->timeout = WDT_TIMEOUT;
-	watchdog_init_timeout(wdd, timeout, &pdev->dev);
+	watchdog_init_timeout(wdd, timeout, dev);
 
 	watchdog_set_drvdata(wdd, priv);
 
-	ret = devm_watchdog_register_device(&pdev->dev, wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
-	dev_info(&pdev->dev, "EP93XX watchdog driver %s\n",
-		(val & 0x08) ? " (nCS1 disable detected)" : "");
+	dev_info(dev, "EP93XX watchdog driver %s\n",
+		 (val & 0x08) ? " (nCS1 disable detected)" : "");
 
 	return 0;
 }
-- 
2.7.4

