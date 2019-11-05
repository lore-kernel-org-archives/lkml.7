Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD4AC010A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbfKEKeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:34:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbfKEKeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:34:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so14700222lfb.8;
        Tue, 05 Nov 2019 02:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nl3V8hPsZ7zorwMjFvvngXDr616FzmE5l3rhQCO5IDU=;
        b=D/S/2/3sF0FExSYDu+cLHHbD+zfEhN7p733bmflqfa16T0UL3RTPrUFER40Q7T2kNH
         wkIrHBzq6jUpK8AnNVrn0n15rZ7RkddqzGqeeNb+sNg0VKqJxRrGwtCTZrKcI+nHsFPV
         uy67idHYsR3vvaGR8x90NGXb2ue2z7VSsswtbomHH32zvSMh9liudlji6LtWIbZZj+Zl
         q6/pHivI1IUmlY+T7ZvnuEMMosCMKY5aqxtqr1V69Tc2Hf7vV9YmizTrwAfY4TwfrtNv
         yEna+DUkAEjpqTt0YJEXuin90nuEulGh0UCXa0eeGrtPIGcOzkaD0J4GxQ4y/playN2H
         bwsQ==
X-Gm-Message-State: APjAAAWBem84PGoqd2MG/yTyfNpcsmAaE1AQqg90mF5J2G2KvWhR0x3H
        cLDzyTJojoEzTvvwlYBH6SI=
X-Google-Smtp-Source: APXvYqymaxdqniV0fZ3b3bt92oxxN45XtWzFpt8G8OjFLQMVFS+AEOJ3rdomF7/csPMkFQrTSALSGw==
X-Received: by 2002:ac2:51c5:: with SMTP id u5mr20598902lfm.154.1572950051845;
        Tue, 05 Nov 2019 02:34:11 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s7sm8251593ljo.98.2019.11.05.02.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 02:34:11 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:34:07 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 48/62] gpio: gpio-tps65912: Use new GPIO_LINE_DIRECTION
Message-ID: <715be0e29536f90d41bdecc05ce3b337b52ec63b.1572945979.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945979.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572945979.git.matti.vaittinen@fi.rohmeurope.com>
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
 drivers/gpio/gpio-tps65912.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index 3ad68bd78282..510d9ed9fd2a 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -32,9 +32,9 @@ static int tps65912_gpio_get_direction(struct gpio_chip *gc,
 		return ret;
 
 	if (val & GPIO_CFG_MASK)
-		return 0;
+		return GPIO_LINE_DIRECTION_OUT;
 	else
-		return 1;
+		return GPIO_LINE_DIRECTION_IN;
 }
 
 static int tps65912_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
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
