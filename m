Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140AC01061
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE45217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfKEKSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:18:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38322 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbfKEKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:18:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so5487168ljh.5;
        Tue, 05 Nov 2019 02:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rE64YBUFBpssw5HSHcGsR1skBXXoL6cAXEqo/3wJhk8=;
        b=ReI4/ymwO14KXtRKxEZVec0oKrmE1RSEAgYWDPuSK2CeWIxmh9FojZvI0DVuKie5eB
         V35ZNpv3OBba7cZNQ6oqvOBXL9+3g/4vmjpPgEPGTxu7CNY8A344QtSDqOkQ6w0fwc8z
         9SCX0vST9xbqpunKDHF0Bih3/g7LKiVZ0eJKU22xR61633mzb4jCPwgeGR/t8ygZCOtw
         5JfwrbuBKCcxvLReoGjKr6LaE8BQjk5K9fnOLIdDeSPnTVhrqNQ6kWrW+oQWKNaqettP
         XwZkGue4c4fGr9dsZGoiCj0ugXDcLTL8IMIjo2RpWpye/tE9xYe9XqYXtwLXobQchP5E
         ZMrA==
X-Gm-Message-State: APjAAAXf4TUHIB7GVz8kS6G7JwbDHIvEusgF5rN62yu/Z2o4PVHok0yI
        QmIOQ7ZwbKGKEZLaciGU/+o=
X-Google-Smtp-Source: APXvYqwAId6+rd9q8mVTWvyavGDaz+2/I0qGNLGOAWMb4EGvc2Vh0FtYIVUkIK2BQhWdIoe1to9WBg==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr16661247ljq.242.1572949085485;
        Tue, 05 Nov 2019 02:18:05 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u2sm2459126ljg.34.2019.11.05.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 02:18:05 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:17:56 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/62] gpio: gpio-kempld: Use new GPIO_LINE_DIRECTION
Message-ID: <d86a3caffb9edcb024eae26f216c8d9a2539141e.1572945773.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945773.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572945773.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard for occasional GPIO code reader/writer to know if values 0/1
equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
GPIO_LINE_DIRECTION_OUT to help them out.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/gpio/gpio-kempld.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-kempld.c b/drivers/gpio/gpio-kempld.c
index ef51638f3f75..4ea15f08e0f4 100644
--- a/drivers/gpio/gpio-kempld.c
+++ b/drivers/gpio/gpio-kempld.c
@@ -104,7 +104,10 @@ static int kempld_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	struct kempld_gpio_data *gpio = gpiochip_get_data(chip);
 	struct kempld_device_data *pld = gpio->pld;
 
-	return !kempld_gpio_get_bit(pld, KEMPLD_GPIO_DIR_NUM(offset), offset);
+	if (kempld_gpio_get_bit(pld, KEMPLD_GPIO_DIR_NUM(offset), offset))
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
 }
 
 static int kempld_gpio_pincount(struct kempld_device_data *pld)
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
