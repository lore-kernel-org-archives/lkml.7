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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE40CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA8E206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXEbFOfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCKG2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38972 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCKG2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id i20so2969966pfo.6;
        Sun, 10 Mar 2019 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q61okzQLGrbhI4rcbZXifSBtd7n/ivAfi57IgaXUs8I=;
        b=ZXEbFOfDRcV0Y46G+5qtwRCdO6WuWmQtZ8h/MWa8zXDbwoburAP9f8GLe6TKyTJlUE
         my+T45zIEz3QB/ZDb4rg7Rd5npopAYgckkbfKVRxz0vD1R8QKxIlRt/YvwAxg+UE6SF4
         55Gs/ZY3ESMerZjjGxDfjuYX4udWnk4uy3+JjCjppLBHENZwfow2Nst1WS+tMHniKrRH
         ZoU9Ms5pXJg07T9n22zekh3NRRfE6XpTcQU9Mb2+Yk4JrN/VbZlBjEiY7IXVjSojnmJ2
         +BHH+BgR+CC4mqHMLbWdNUeGkCA1pQrBFIAM1CgCCNlhZgRu3G3kQSIqwSbDTVYBUfF2
         469g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q61okzQLGrbhI4rcbZXifSBtd7n/ivAfi57IgaXUs8I=;
        b=fXFaNGJyrK9lezh/03nAUTpYFW3oqd4tHQfaABaakJqmsYTMJOE/eWMUGQKDswO4bx
         N9rRw7U/k4Ec5xj6lGF1yTxVfoa/Y4rwqFPuu1KWFaFw62z6//kPSDI19fVrfkR/uZ2o
         M+uG3Da00BctxSw93y4buJgqqQQDw2CKilU9+kowSq7d3p6rL6tzH030xabhKIEhcKF0
         MbEr6M9807pSm3yHOudrNcYDD1uCklxV4ej8qBy+BCw3fUIZjQJ+hAokbX+c0X4RNIA5
         IrwqBxudsFBgHK9MR8e75t7tmcy2CJVPKzRcKF0ZaVnxVFGvBgsPx/tgfNcQJ/dnl58F
         vEVg==
X-Gm-Message-State: APjAAAUE5M0d3Rul5E4bmZAsqrg5gMyeH8H5bOCFAlq9pZCLqJybB0gg
        remWfcRgIulLuzcfL2htdcfu1UXj7Kk=
X-Google-Smtp-Source: APXvYqzyA1WayQVBbaaucUXplrjVOwPGMZti72n2FowIf9WLI0uRrLiR0A7oO11EdF6yEirBbCoIdA==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6mr3280975plq.221.1552285689718;
        Sun, 10 Mar 2019 23:28:09 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:09 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 3/7] gpio: vf610: Simplify vf610_gpio_get()
Date:   Sun, 10 Mar 2019 23:27:33 -0700
Message-Id: <20190311062737.6652-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both branches of the if statement do exactly the same thing, just at
different offsets. Simplify the code a bit by moving shared action
code outside of the if statement. No functional change intended.

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
 drivers/gpio/gpio-vf610.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 2ea17870e9da..bb35cedd05e3 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -85,17 +85,15 @@ static int vf610_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct vf610_gpio_port *port = gpiochip_get_data(gc);
 	unsigned long mask = BIT(gpio);
-	void __iomem *addr;
+	unsigned long offset = GPIO_PDIR;
 
 	if (port->sdata && port->sdata->have_paddr) {
 		mask &= vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
-		addr = mask ? port->gpio_base + GPIO_PDOR :
-			      port->gpio_base + GPIO_PDIR;
-		return !!(vf610_gpio_readl(addr) & BIT(gpio));
-	} else {
-		return !!(vf610_gpio_readl(port->gpio_base + GPIO_PDIR)
-					   & BIT(gpio));
+		if (mask)
+			offset = GPIO_PDOR;
 	}
+
+	return !!(vf610_gpio_readl(port->gpio_base + offset) & BIT(gpio));
 }
 
 static void vf610_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-- 
2.20.1

