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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F70F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2LUceRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCKG2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45194 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfCKG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so3242696pgc.12;
        Sun, 10 Mar 2019 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEPMSe+y1Wnet8aE00jivssdBV+kRDfyJTfuYg2drPA=;
        b=d2LUceRXrC5hy9h7GundvO10yQ4SAVfrwlL5qiOysujUls+wWYgRuat0kAuAnBWLtE
         ZFhBDCAZTsu1pUb+41j1DQ6aNUuCAfSYJEVu/c6VmrT4ninlSi2e9mLUtomzsTmQVJD1
         yjgXLA6BNg+jDwp4+5wgKYjIyosKw2uHTOwxEEpDZUsLZ242dMfNXNHemF/asRZvPzLd
         C+t16Y3EJAJadPB3CQ+TX3v6qj/t7Qe1i8q0nFHhlX9mUNqBrdkkoBQmNSg2A8T+KJx+
         76Gzi6+CxoCFWwlDas5+y1tQYeTRnM4j0AIAEKwilxbFx8uPzb/IOrPLTz3hNP558zSs
         Y6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEPMSe+y1Wnet8aE00jivssdBV+kRDfyJTfuYg2drPA=;
        b=KPdWlldyYHbmuDM4i7PGhTiMaVsT+enEAW8wSiSgvPaWUzYNsX5TAcjByJjvY4WgRy
         idOmEUpXeNsg0EDp0LRUZfTPHbE8NaLh7xa7RcYNINTn0m+AFGbjDeus6Zwe55nbkzpj
         Bi0ddREYJEsNLwjIV1HDH9Yb0by+/t/9Ap+qZUo95LD+Ad807SBiTZy58lMTOLUeMINZ
         ORm2qDWszB16ssygcxw+GBOhj9SKg8rhYTE8QIx8NaZaelGWC8LVDbfEkN5TfvJ3pFJy
         x2Wb9I+H3Tl2E6KUconxVu7TIMn3QpzNiCtHOwRSHS9AA5/PGNyWxpDnRV83tN0zLXGP
         CUog==
X-Gm-Message-State: APjAAAWtNSSVeB5oxe3ryfZ64Ihy7D7JjS5km2tnpUowGoHMArEtjE5x
        HVQZCv+ewVMr7KFnJdou3IG5yHIgs2s=
X-Google-Smtp-Source: APXvYqw4dj8QjrVKvt5ra4ms+z9xG49tQnx2CI2dSEZCZHOeVy91Y8t8aP/qn6ZvAvstFUOmorBVSA==
X-Received: by 2002:a65:43c7:: with SMTP id n7mr15922039pgp.173.1552285692368;
        Sun, 10 Mar 2019 23:28:12 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:11 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 5/7] gpio: vf610: Use devres to disable clk_gpio
Date:   Sun, 10 Mar 2019 23:27:35 -0700
Message-Id: <20190311062737.6652-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk_gpio should be disabled in all error paths in the code that
follws, including the case when either gpiochip_add_data() or
gpiochip_irqchip_add() fail. To simplify things fix this by using
devm_add_action() to disable corresponding clock in case of any erros
as well as driver/device removal.

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
 drivers/gpio/gpio-vf610.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 78c1f8ebbe8f..f7445468677d 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -289,6 +289,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(port->clk_gpio);
 		if (ret)
 			return ret;
+		ret = devm_add_action_or_reset(dev, vf610_gpio_disable_clk,
+					       port->clk_gpio);
+		if (ret)
+			return ret;
 	} else if (port->clk_gpio == ERR_PTR(-EPROBE_DEFER)) {
 		return PTR_ERR(port->clk_gpio);
 	}
@@ -345,8 +349,6 @@ static int vf610_gpio_remove(struct platform_device *pdev)
 	struct vf610_gpio_port *port = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&port->gc);
-	if (!IS_ERR(port->clk_gpio))
-		clk_disable_unprepare(port->clk_gpio);
 
 	return 0;
 }
-- 
2.20.1

