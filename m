Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE32C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6099214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUsDpz0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDIRZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41408 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfDIRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so9802356plj.8;
        Tue, 09 Apr 2019 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=INJ416e+pd21Ry2WyJYMICDziX05uHazE/a32a5u+ko=;
        b=nUsDpz0eQ7fheYMhQdWPNcTGzLYvKFdNYN6yDPkLcm682erL9LH8/51bmUaBoGCd/k
         LY9b4REzc4ZosAKIWN2cEPalss4SRG2CbcQZwMh9B/FQioT92taBZSLl0Y9VcepcpoKl
         EzGa/ZMv8B6IUtqZKQp88GPnWPis9a5szJUT6BXvcjF2+btDhN9ilA1Bg1u3R3xm55hH
         EWf6GjUd82xE1X8u68dKwQOP+1liETA++s9CTA3eIncS3aMebBA1I+9XtZVixC+TfC3g
         2Q31bzf3v/at+IzuEk3Lm4x8dzRTu05QZM8BBY6CbVDtfR/JApr1rA0H4now7rDxDB2E
         zdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=INJ416e+pd21Ry2WyJYMICDziX05uHazE/a32a5u+ko=;
        b=jOXB0RoLUTppZQe6PdQU6EJ8uU7e2YHNa7crfBXjblfa18y8BpTUnfPzTnTFc41ToD
         Xcq0IF4T4hUow4AhNQnJg7Eu0F7lBpQYGZB3Mzi7cokuL7Du7E0uYRgdlFoJGQ+HqT7C
         bZcohmc0WJ1IwDuxSfRJUR5qmWGBQ0UFnqyuFeq+E3w45zmumBBtXH/vozP1k36PyoXu
         pc+P/iLsxQapDAGVuWXMOfTcGIydJw+LN+w6W6n58TcA42ULJ6e4NFZrvkOGMucPgctb
         dLHnX0AK8JlDftev2ffr6WmDEoEHUHs5etQJqn7EqVgoYLMcu8XSAjB85rEiHrlQlhFL
         8JcQ==
X-Gm-Message-State: APjAAAUrR0PZqFzZxcnJRS2SX1WCv6UKKGW2Ld1pppdrzL20npRFlYru
        jPEiiFi9mZtO6G4/SToqB7M=
X-Google-Smtp-Source: APXvYqz2Uwp0LqP3ZB8rfsBu+VkCRxfavd7rZtFsUMq+EKMJ7TMBF7901youLmoyVm2ZAxBLfHVUtA==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr4589813plm.3.1554830672499;
        Tue, 09 Apr 2019 10:24:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm49062881pfa.90.2019.04.09.10.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:31 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/23] watchdog: rza_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:53 -0700
Message-Id: <1554830641-9247-16-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/rza_wdt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index b854f0aeb3ef..7b6c365f7cd3 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -166,11 +166,12 @@ static const struct watchdog_ops rza_wdt_ops = {
 
 static int rza_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rza_wdt *priv;
 	unsigned long rate;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -178,21 +179,21 @@ static int rza_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
 	rate = clk_get_rate(priv->clk);
 	if (rate < 16384) {
-		dev_err(&pdev->dev, "invalid clock rate (%ld)\n", rate);
+		dev_err(dev, "invalid clock rate (%ld)\n", rate);
 		return -ENOENT;
 	}
 
 	priv->wdev.info = &rza_wdt_ident,
 	priv->wdev.ops = &rza_wdt_ops,
-	priv->wdev.parent = &pdev->dev;
+	priv->wdev.parent = dev;
 
-	priv->cks = (u8)(uintptr_t)of_device_get_match_data(&pdev->dev);
+	priv->cks = (u8)(uintptr_t) of_device_get_match_data(dev);
 	if (priv->cks == CKS_4BIT) {
 		/* Assume slowest clock rate possible (CKS=0xF) */
 		priv->wdev.max_timeout = (DIVIDER_4BIT * U8_MAX) / rate;
@@ -207,19 +208,19 @@ static int rza_wdt_probe(struct platform_device *pdev)
 		 * max_hw_heartbeat_ms.
 		 */
 		priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
-		dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
-			 priv->wdev.max_hw_heartbeat_ms);
+		dev_dbg(dev, "max hw timeout of %dms\n",
+			priv->wdev.max_hw_heartbeat_ms);
 	}
 
 	priv->wdev.min_timeout = 1;
 	priv->wdev.timeout = DEFAULT_TIMEOUT;
 
-	watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
+	watchdog_init_timeout(&priv->wdev, 0, dev);
 	watchdog_set_drvdata(&priv->wdev, priv);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &priv->wdev);
+	ret = devm_watchdog_register_device(dev, &priv->wdev);
 	if (ret)
-		dev_err(&pdev->dev, "Cannot register watchdog device\n");
+		dev_err(dev, "Cannot register watchdog device\n");
 
 	return ret;
 }
-- 
2.7.4

