Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD66C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEAA20850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVzGgZk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCKG2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46881 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfCKG2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so3243002pgg.13;
        Sun, 10 Mar 2019 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LW2I2A0GfzGjATQcc1Dji37pj8zhE0Cw+KXjlFdr9M0=;
        b=BVzGgZk4QGkjGOm5qjGzxhWHd8C8SXbsXeFgLFnq2WS1id/wdX0HQhY5BXeUjoH419
         cSM8fX3yYutEy3mCFuExPIqhIHBlWVu+4g6FhyXT1qYI2sQn71V6j6UsbAYSOSF/UbRo
         9vc2XoJcFXpzPCNRpblGv/7JxKfqAIgXGHM62vPJ4IpJSSyI798vfr/4yxy4eGvtNlKP
         ex6dEFObR0nUf+rMp8EEOQkW5iGFmi6HpQ9TNKm4wq9ydwGbRCJWHiKm6/vEdO5rSWTo
         /QXtaz3YTB5qm2uGYZZaPJF+84+LD1Di5CLUvExxKKY8X53RK02v5b/baeuyApHOn3F/
         TayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LW2I2A0GfzGjATQcc1Dji37pj8zhE0Cw+KXjlFdr9M0=;
        b=pxs+ZEQk72YKImCzAOmahSuDVaL+k0xfjPhYisbisGFS81+27huXelBWFGHosmNv0Q
         Pu6fy8Zb7yZN06t30VMfRZddnI+sf+CC3T5NH7h3TfWPXQpDHM2+9o8cpX2LY+XSxTyl
         xgpbS83PkKXPY5eAg1DhNutNXD7yyLOVTH0edCDs2QjDQgzky26FRpleDOYBajTbgduy
         rFone1Y1V6jlFpQ3ZqnrbyRYX+y2Cb0olrwObWohWHMCFRjEE18bOW/FjBV7n+R9HtoR
         HIhMKVyCFhmbKHeGodCVVD55kCO6iQMaI4Aw0CqcLxRudVmL7y9cIYtktCsSYvLedpEa
         DkVg==
X-Gm-Message-State: APjAAAXIoeet7trJ0gg2KUr1GcLwdXT+Yi0DeO9IlvnB1W6EMapAfV4C
        RWu1YYW49+dOtmgOxF3f34G0zwXJAnY=
X-Google-Smtp-Source: APXvYqws5TvRVrEiQxbUg3sNE6ilGUJbFex0XN0VCFlow0DX+mt38lCz4zmT4LmqKJHZm89mdvuvuQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr26876491pla.226.1552285693716;
        Sun, 10 Mar 2019 23:28:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 6/7] gpio: vf610: Use devres to remove gpiochip
Date:   Sun, 10 Mar 2019 23:27:36 -0700
Message-Id: <20190311062737.6652-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver's custom remove hook contains only a single
action, replace it by converting the code to use
devm_gpiochip_add_data() to simplify things.

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
 drivers/gpio/gpio-vf610.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index f7445468677d..7db2fa229035 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -297,8 +297,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(port->clk_gpio);
 	}
 
-	platform_set_drvdata(pdev, port);
-
 	gc = &port->gc;
 	gc->of_node = np;
 	gc->parent = dev;
@@ -321,7 +319,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	ic->irq_set_type = vf610_gpio_irq_set_type;
 	ic->irq_set_wake = vf610_gpio_irq_set_wake;
 
-	ret = gpiochip_add_data(gc, port);
+	ret = devm_gpiochip_add_data(dev, gc, port);
 	if (ret < 0)
 		return ret;
 
@@ -335,7 +333,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	ret = gpiochip_irqchip_add(gc, ic, 0, handle_edge_irq, IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(dev, "failed to add irqchip\n");
-		gpiochip_remove(gc);
 		return ret;
 	}
 	gpiochip_set_chained_irqchip(gc, ic, port->irq,
@@ -344,22 +341,12 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int vf610_gpio_remove(struct platform_device *pdev)
-{
-	struct vf610_gpio_port *port = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&port->gc);
-
-	return 0;
-}
-
 static struct platform_driver vf610_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-vf610",
 		.of_match_table = vf610_gpio_dt_ids,
 	},
 	.probe		= vf610_gpio_probe,
-	.remove		= vf610_gpio_remove,
 };
 
 builtin_platform_driver(vf610_gpio_driver);
-- 
2.20.1

