Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B21C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D802C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPC5S0rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCKG2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37928 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfCKG2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id m2so3262767pgl.5;
        Sun, 10 Mar 2019 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ti8CTTyqVMHcCG7X7EwulhuQcYMDuiNtlg/ZNN9cabc=;
        b=bPC5S0rCKyYd21+kJ9RMCAe7f4nwmBvmI9+envNojwJgEv2z3rXx6gqk21A9IzxYZs
         eQyIphYd+WlqRmUGhQDxQf9VLFgRuhu5EFYmgH1Fkil27vdapAXACuep6csKPgF294Wi
         R7ZcRdMUcIPqhf5I236NMPFSd7MbVb2SPvyX0/gdko7l+R6HQiT8WuwLBaARTDWkOOGg
         xv83y2KxEP1joPzQFlqfgY8BZiDofEg25dXD+rwiHuhY17mMjRLqQMIizemqu8jUTcNo
         sDEQ9tRfOkgyr28JhjHLnDn8wrBPN2NCCEtINVesyp/elm3stSWobP4P3qV2LgueZxWa
         hnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ti8CTTyqVMHcCG7X7EwulhuQcYMDuiNtlg/ZNN9cabc=;
        b=tueo4qCJvLjWJ+NNa4p7YDDYCaXc+/hnSbwATWDeaw5aGkPXYMNIz5HUFGBGZyJg+x
         yxmXrV/ef+nW7K72PTePMUo0tXieGTdhTlld8/evYZkH521iR0n4kmV4/Dd8i004rj2+
         wwaNHJ8YqxyqvNup9z2fITZF104rmuFVgKSFzETnrFHjfLR0Vrmp1MrwYhGH9eTLCPq2
         skt+ex3/vqiURbCyKG8dLFGfeoWk1FiO5oIZAJqNVwR6rOmVSqyfMnswnPjVmj8nN/nD
         SolXJg2nysM23JW1hhVRFACjkN5f4HAnq3zORQyPycNNIPXxnFjdqIy0C4v/vBb9IbcX
         7n5A==
X-Gm-Message-State: APjAAAWLQ9B17mId29I4d6poESGlZ3E7qDODiVHI206PvJ1qLYiD+Mji
        0OC/nhXoIeEu+wTG2ZMQYbtlUsPyjJA=
X-Google-Smtp-Source: APXvYqwpfkLoJFAkL7bKlffIDPUtp71iZSUCn3Iz/7dB8mXLzeonFgYg+GgXk8u5ripHdWf6eu2EfQ==
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr32639162plx.13.1552285694899;
        Sun, 10 Mar 2019 23:28:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 7/7] gpio: vf610: Don't use explicit &pdev->dev in vf610_gpio_probe()
Date:   Sun, 10 Mar 2019 23:27:37 -0700
Message-Id: <20190311062737.6652-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code already defines "dev" variable to help with that, so make
sure all of the code uses it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 drivers/gpio/gpio-vf610.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 7db2fa229035..6f6558715b88 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -248,7 +248,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
-	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
@@ -267,7 +267,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (port->irq < 0)
 		return port->irq;
 
-	port->clk_port = devm_clk_get(&pdev->dev, "port");
+	port->clk_port = devm_clk_get(dev, "port");
 	if (!IS_ERR(port->clk_port)) {
 		ret = clk_prepare_enable(port->clk_port);
 		if (ret)
@@ -284,7 +284,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(port->clk_port);
 	}
 
-	port->clk_gpio = devm_clk_get(&pdev->dev, "gpio");
+	port->clk_gpio = devm_clk_get(dev, "gpio");
 	if (!IS_ERR(port->clk_gpio)) {
 		ret = clk_prepare_enable(port->clk_gpio);
 		if (ret)
-- 
2.20.1

