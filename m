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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF19FC10F0D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A90206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu8JKlJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfCKG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44999 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfCKG2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so2961905pff.11;
        Sun, 10 Mar 2019 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6qZwYmh/1wkXeUwGLD2lVdzV9ZsO6f2x6yJbCanhqA=;
        b=pu8JKlJ6a8uQqFuE9jvpNBWeVAJKhl6GHJtKMjwy1lqrm1LodRfAGoQPwIrPxU8uZw
         5mqHSNxKW5Nv1T/EzStN9vZzsP2dU3j8z6AQxyfXKTYxc8EkXFhlQ2veXNOmBEKRMznM
         5OgKvKdzGjw0kD6HzBpSkDxpxXoVr/bX8OTjE00EQyE/3lemtmECMUG+hp5Qx5Z1Z0Ni
         4fiFz5lb0V9kV32rGd7XPZ6Ess2b3CpZQqNeAeuHgug5jFEADbyIk0SI/ofQxtDug8NF
         yG7G2evrKWc/3Ih6mWjrdVFZrXPh9CvSaUEDCMEjfaj3LW8WEWBPXkYkXp4fCNf9Pd90
         abIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6qZwYmh/1wkXeUwGLD2lVdzV9ZsO6f2x6yJbCanhqA=;
        b=p8mgXQGzFvgUiINpXMO/uHjPLpV5U+YGj4Fr1ahad3r4YUhiSIngzveZ+EbSr2p72x
         mb3otCFhMoGHqdOa+moGWvE5YwPj0jE5OAXUf91pPANu2cjqwcU2pCW5xqFkyxALvpnV
         c1VskYdda+eac43s4r3+qib+lHje4VdPM1Sk/PmW5eOsmWEzNjlVkeGt+alHvkMhaSb7
         7t54sCjkc2v+hehu7HH+nW2SVLFD5+6JWE8qzy/uwNEWYL61XqNDKhhsU4zb/IcKTbBu
         wz+6AsIEkkuhxrtHPw1L9U6iKOZMHbaNNrvRqlEJdXdXnMifLYJUihi0GnQq2N60CTtO
         w+YA==
X-Gm-Message-State: APjAAAXewvXxmxNpOiYyD+KZa0oxu1dX8RLC1Vi9s9nYtnDqNuR+jU/m
        EBduSJcqQsCcInmPd7IiJcw3CgR8bBc=
X-Google-Smtp-Source: APXvYqxoriEqMnrs2ke02ANzsmjs9OqdTiTbXSGX/XzgHmgBXuGl/NO/V/xm9FYWiLkV9FmVhgY+og==
X-Received: by 2002:a65:4348:: with SMTP id k8mr28809193pgq.289.1552285688345;
        Sun, 10 Mar 2019 23:28:08 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 2/7] gpio: vf610: Simplify vf610_gpio_set()
Date:   Sun, 10 Mar 2019 23:27:32 -0700
Message-Id: <20190311062737.6652-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only difference between two codepaths is register offset
used. Simplify the code a bit by replacing explicit calls with a
single call with a variable offset. No functional change intended.

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
 drivers/gpio/gpio-vf610.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 7e9451f47efe..2ea17870e9da 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -102,11 +102,9 @@ static void vf610_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct vf610_gpio_port *port = gpiochip_get_data(gc);
 	unsigned long mask = BIT(gpio);
+	unsigned long offset = val ? GPIO_PSOR : GPIO_PCOR;
 
-	if (val)
-		vf610_gpio_writel(mask, port->gpio_base + GPIO_PSOR);
-	else
-		vf610_gpio_writel(mask, port->gpio_base + GPIO_PCOR);
+	vf610_gpio_writel(mask, port->gpio_base + offset);
 }
 
 static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-- 
2.20.1

