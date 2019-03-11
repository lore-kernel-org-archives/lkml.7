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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4614820850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAZ2mVhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCKG2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfCKG2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so2963368pfh.10;
        Sun, 10 Mar 2019 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKL7eW1poGCQmaULAOmnoaVFxxTL+cJk49BCVKea4N0=;
        b=IAZ2mVhyYFRuxyvCiTtvbi7Iivi1OV1uRcbtI8EGoiOTOUCAPfqvnUDVbRkqm76moH
         vunXTnWEkPeK0O8RP7YoKWAghl5rU3S/3suequkkS9bQJdq303FC2pPAnPycY9V2zdWf
         BuryiZfQgnPDs7p9m72JvOgj0RW0yplb0qatjOVpIxLe26WmrZtg7oEL0vkqVF7Ug6wk
         QI6hcVQS0fP7yg1oG/sPAnLPPhHv9h7rtH7Ufk2lqhJIMchr/qGIIrtQwR1859ywEf5e
         TJ3TYfGU+okQ77DX1hcBY/8g6/w+MULVJ9sgergD+B2yWg3MctpUi5BGERWeDhENtlxN
         x9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKL7eW1poGCQmaULAOmnoaVFxxTL+cJk49BCVKea4N0=;
        b=E3ipo9E3t0dvwQItEY8kIOXQ5zBU6ruL9HtFfWBDJ5PuGwvkWuyWzSElMeJHmubNGX
         pZ9cTX9lx/ZWUG6BQOYv/ellqtXXpcmKx7m02y/ZXvVOp9hKxd81taCtG5igu6mra5eX
         gb1A5LTimQ45QSfa0c3dj+NUhtxsZSG8Zxitfy3LFEKMDKGMSdZ/d5vHhzTqBNxpiYNe
         xXpIfW35OViFezieH7czamcHexSbtCDzKZfvWFcqdEU59mABDdqGvPTsSvU++/17lR3T
         OiawvwNkH/x5Cv3HwEZt66/Wn91xa44dVtfuQiI+7hzV457kgLWJ0syB6do4GRs5uRWw
         oxHQ==
X-Gm-Message-State: APjAAAVVJfBEuLHSwFJfZmNrZJMs6ilaVVRKnKt4dNd4/+yv21BOfGr+
        td14TVYbCjcpgG+qodnLgw136gKKSlo=
X-Google-Smtp-Source: APXvYqyiKb0bfD2ZCOFEcoXC4uTwizn3IGP3xDhXnBQKJuOfaxHmmkwkm8gibTR0//f1LeS9dnFyNA==
X-Received: by 2002:a17:902:2a48:: with SMTP id i66mr31389015plb.14.1552285690897;
        Sun, 10 Mar 2019 23:28:10 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:10 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 4/7] gpio: vf610: Use devres to disable clk_port
Date:   Sun, 10 Mar 2019 23:27:34 -0700
Message-Id: <20190311062737.6652-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk_port should be disabled in all error paths in the code that
follws, including the case when either gpiochip_add_data() or
gpiochip_irqchip_add() fail. To simplify things fix this by using
devm_add_action_or_reset() to disable corresponding clock in case of
any erros as well as driver/device removal.

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
 drivers/gpio/gpio-vf610.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index bb35cedd05e3..78c1f8ebbe8f 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -232,6 +232,11 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
 	return 0;
 }
 
+static void vf610_gpio_disable_clk(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -267,6 +272,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(port->clk_port);
 		if (ret)
 			return ret;
+		ret = devm_add_action_or_reset(dev, vf610_gpio_disable_clk,
+					       port->clk_port);
+		if (ret)
+			return ret;
 	} else if (port->clk_port == ERR_PTR(-EPROBE_DEFER)) {
 		/*
 		 * Percolate deferrals, for anything else,
@@ -278,12 +287,9 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	port->clk_gpio = devm_clk_get(&pdev->dev, "gpio");
 	if (!IS_ERR(port->clk_gpio)) {
 		ret = clk_prepare_enable(port->clk_gpio);
-		if (ret) {
-			clk_disable_unprepare(port->clk_port);
+		if (ret)
 			return ret;
-		}
 	} else if (port->clk_gpio == ERR_PTR(-EPROBE_DEFER)) {
-		clk_disable_unprepare(port->clk_port);
 		return PTR_ERR(port->clk_gpio);
 	}
 
@@ -339,8 +345,6 @@ static int vf610_gpio_remove(struct platform_device *pdev)
 	struct vf610_gpio_port *port = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&port->gc);
-	if (!IS_ERR(port->clk_port))
-		clk_disable_unprepare(port->clk_port);
 	if (!IS_ERR(port->clk_gpio))
 		clk_disable_unprepare(port->clk_gpio);
 
-- 
2.20.1

