Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF74820811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sivt99Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfDXMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43832 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbfDXMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id k2so2454549lje.10;
        Wed, 24 Apr 2019 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6jZN0Vl+RAhZC6JCcbsfReiinM9CSI7nwA9921XKbc=;
        b=Sivt99FtZ99ucSadBRT7+jKo6PgRiDrIdIKM0xeRsSIYW/nyie0pdUBsvctRCNeRKD
         BdIsG3m6AZ14SyyPu+wcDSQv5eslrWcYVnmjM8GLQqCZnfXFyABunMOx46ZZEMBRNn5T
         +v6u3uW3so/LFGe9u/K9rGKklt1etx+znyhLwrBVvudo1TN5g2SoEvbWF+OZybrIdihc
         AOwgOZKwpcPOHCv4wfL/+2q5ewDl1xUArMvhR3ttB/1IbBxn7dd7RhXLdEch9B63BlEt
         sdVjrqvilxql6CyamolZaOdLJYREmqcKylkAqUpCPPK5Ewk1/9XH1Ah+ciBHl9tEBj2L
         1k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6jZN0Vl+RAhZC6JCcbsfReiinM9CSI7nwA9921XKbc=;
        b=hAagbGuaBcMoxZW6N/JsSpNbJWu6wcX8xVMgvKMn5NIb+WRokdaz0xSfZ2P3vUNiM3
         rBFtLUP4XGIDSLGFieT1JpWFx2TAX/3kwP0tjhlVh7Kq/zvm6pl5UN6jxUZqOUFUNend
         zivZZn1RpBtzNlGSrnPrptQI/aIfHlGydloR0CWkZH3a1mZAUyqX0hs63tZ2JyfWWavE
         2NkCoVi3I/V/NNZYcHgbpn3NAI8a91Uf6RF4Q5TL6MJ5xbFlMtyRbP0JUahnljmNcSBv
         J+h9D7nXvhyMwx3J7z9wRQ3nibT6mSmS60B5+TkRwhVne8ZQgmGE/TWoHTSRSA0xzY8j
         Vjjw==
X-Gm-Message-State: APjAAAV0Ryv1wbQWRsPNAY5EW3viIVLHcTqCh26tiG6FURk+84j8PhS0
        iLdzjiMte+yrgeel7iB68D0=
X-Google-Smtp-Source: APXvYqxVoKFpn7RTcP5ZMITNPRVJKuo+skfqYWzaaAff9L8EQ6XAYTdO9V4ba83QxyiXOrbdHBWkDg==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr17260574ljh.17.1556109269170;
        Wed, 24 Apr 2019 05:34:29 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:28 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Date:   Wed, 24 Apr 2019 15:34:11 +0300
Message-Id: <20190424123414.25311-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's pointless and might be even errors prone to proceed with further
initialization if neither of- no platform-based settings were discovered.
Just return an error in this case.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 24cf6ec02e75..a14fe132b0c3 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -132,7 +132,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
-	return 0;
+	return -EINVAL;
 }
 #endif
 
@@ -142,6 +142,9 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
 	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
 	struct gpio_chip *gpio;
 
+	if (!data)
+		return -EINVAL;
+
 	/*
 	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
 	 * relative to its base GPIO number. Otherwise they are absolute.
@@ -175,11 +178,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!mux)
 		return -ENOMEM;
 
-	if (!dev_get_platdata(&pdev->dev))
+	ret = i2c_mux_gpio_probe_plat(mux, pdev);
+	if (ret)
 		ret = i2c_mux_gpio_probe_dt(mux, pdev);
-	else
-		ret = i2c_mux_gpio_probe_plat(mux, pdev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	parent = i2c_get_adapter(mux->data.parent);
-- 
2.21.0

