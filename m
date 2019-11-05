Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31559C010A7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459321D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfKEKaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:30:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44125 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbfKEKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:30:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so15053057ljl.11;
        Tue, 05 Nov 2019 02:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ob9HSuMhR66NnLGsiN9Kf7XuZxMaGmEbKI+aKByDMTg=;
        b=V6i7iRvyQfYk5CXR+9oggF0lsXlXe4abklySfsmJUD4SUyoFHFFt0beMTE2R1z8wCO
         io/kqqOCCesKRGHYtlj5SujyMcohJcl0td92sUF50NQdd8F4HLW/qWc5CMSSz2ikWOHw
         HfV7OvFRMBCddDHJkMfEDY6UytXKPFMURmbupGpkxtDRqaAshSSkIBx6SUbrfsp6mD+x
         aqgIylEKi84W1GmOEqfCX8xAHSoaRLJfRMSXfB/EqyFHbfZC+5gh8PO9v72Et7AHTZxh
         k4k4liJpJW4bIYoSzWxkJIVRRcoxePqdjrs8x8KyL56Lnxr/fwVBjO67UqatAgCmaIdu
         3Iyg==
X-Gm-Message-State: APjAAAW1/1lvTkt1FKUq8HPj9cOZF/WplpakLB6PSsuHVxct2uRsN7oj
        0IBb5acZ1SfcUzMq8IPpkE8=
X-Google-Smtp-Source: APXvYqxvQhcdcurNjRxBC9UfcvDV6J3QCVm2KCalMbLgtYz7T3qpYF+zU/YA3H475CTur5xjyyKbTA==
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr7028699ljo.90.1572949810898;
        Tue, 05 Nov 2019 02:30:10 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k187sm1285227lfd.54.2019.11.05.02.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 02:30:10 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:30:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 38/62] gpio: gpio-sch311x: Use new GPIO_LINE_DIRECTION
Message-ID: <e7e814133adf3ef8c8602448a87b2a194e3cdc88.1572945893.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945893.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572945893.git.matti.vaittinen@fi.rohmeurope.com>
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
 drivers/gpio/gpio-sch311x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sch311x.c b/drivers/gpio/gpio-sch311x.c
index 8ecf336c9af4..da01e1cad7cb 100644
--- a/drivers/gpio/gpio-sch311x.c
+++ b/drivers/gpio/gpio-sch311x.c
@@ -228,7 +228,10 @@ static int sch311x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	data = inb(block->runtime_reg + block->config_regs[offset]);
 	spin_unlock(&block->lock);
 
-	return !!(data & SCH311X_GPIO_CONF_DIR);
+	if (data & SCH311X_GPIO_CONF_DIR)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int sch311x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
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
