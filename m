Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A92C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60AE2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIB9HLyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfEPVmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:42:37 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:47250 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfEPVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:42:35 -0400
Received: by mail-ot1-f74.google.com with SMTP id e88so2320228ote.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9bgH5ddVtCLjQIU2Q7/Cyhth48wZAFNpISOX0pGwTj8=;
        b=uIB9HLyqlIkDQpDDHN7iA1Zy9AFgPFTWgf8H4VfTEOnVMBmcsUvgBm23XCDsmQ6FVi
         T+Qa/wMIn0MAMTaaFvSu/9INMeroOP5Q3HATux072BRRqoEqgjtzGUQbk0T/HkjsVYxt
         UHOFmW8T+dEsN0TggqHI5R6I5JDRz6J685ecazye0TpS2RSX9pvhZ71MWiLGbzUIuvqQ
         eGXQ6x2R4VT+a+xKuO93JiskvjnJnojPkiCuKgnoyQ5gHpqsPm7Ce9E9xiGO2fhPcU0m
         k5MLgAZya5yi9GSGmavy0RvHuIu5zO5we1CczznoKIulzYH08hOEZd9dZ9GmiaKdrB4Y
         eVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9bgH5ddVtCLjQIU2Q7/Cyhth48wZAFNpISOX0pGwTj8=;
        b=AuLNfMLzfh+Wdb9q6iFhDDN+SchBzyW3bxHYRc0lqxftZ7q38VUHWZtJSGsqfC1fQI
         6zIN5AEdqUXlmw0vlzLAM4bx4lX95PwV0qM5IqCEMr/vsjoahn6ybQUMiNSSA62Mbrwd
         Edzxvzs2DtJ1i0P7A7v+enHjOonwT48igI0+O41l4vg84zxe/g3pVI8Sa9S6nLUL7sI6
         vv9NAkDs/CMb9Oe7lY8ZHk7knSNE27gtAlnHnET1USA+goefdQ+JMl1ELCnMuNjrPOwR
         FUWeUdrYz/qYhegtgLBAfO15JSBhlLllr4ZNRzQ4rrSxSBnsany8ZiQMrRIqx6LxsmaZ
         0EEA==
X-Gm-Message-State: APjAAAUwlgq0TBAoNXswWd5bDWFceRGZHjG4U+jUbr1eNXpZ9kTo8bQp
        vEnlSwF84AieUxwytcmXJpGnLjYkOQ==
X-Google-Smtp-Source: APXvYqwAwfcX72HV/mN5/TwK+IT7YLRRhD64nNPUwBATF23Kdc7MZNwITwETXRiSBsZsHnqE2mRJzK3Tug==
X-Received: by 2002:aca:f007:: with SMTP id o7mr11981585oih.59.1558042955083;
 Thu, 16 May 2019 14:42:35 -0700 (PDT)
Date:   Thu, 16 May 2019 14:42:09 -0700
In-Reply-To: <20190516214209.139726-1-kunyi@google.com>
Message-Id: <20190516214209.139726-3-kunyi@google.com>
Mime-Version: 1.0
References: <20190516214209.139726-1-kunyi@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 2/2] ledtrig-gpio: 0 is a valid GPIO number
From:   Kun Yi <kunyi@google.com>
To:     linux-leds@vger.kernel.org
Cc:     Kun Yi <kunyi@google.com>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, dmurphy@ti.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO number 0 is a valid case to handle. Use -1 as initial value
and use gpio_is_valid() to determine validity of the GPIO
number.

Signed-off-by: Kun Yi <kunyi@google.com>
Change-Id: I4a29f98b237fd0d8ba4dd2a28219d4429f2ccfff
---
 drivers/leds/trigger/ledtrig-gpio.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index f6d50e031492..48d8ef8538bd 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -22,7 +22,7 @@ struct gpio_trig_data {
 
 	unsigned desired_brightness;	/* desired brightness when led is on */
 	unsigned inverted;		/* true when gpio is inverted */
-	unsigned gpio;			/* gpio that triggers the leds */
+	int gpio;			/* gpio that triggers the leds */
 };
 
 static irqreturn_t gpio_trig_irq(int irq, void *_led)
@@ -114,13 +114,12 @@ static ssize_t gpio_trig_gpio_show(struct device *dev,
 {
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", gpio_data->gpio);
+	return sprintf(buf, "%d\n", gpio_data->gpio);
 }
 
-static inline void free_used_gpio_if_valid(unsigned int gpio,
-					   struct led_classdev *led)
+static inline void free_used_gpio_if_valid(int gpio, struct led_classdev *led)
 {
-	if (gpio == 0)
+	if (!gpio_is_valid(gpio))
 		return;
 
 	free_irq(gpio_to_irq(gpio), led);
@@ -144,12 +143,6 @@ static ssize_t gpio_trig_gpio_store(struct device *dev,
 	if (gpio_data->gpio == gpio)
 		return n;
 
-	if (!gpio) {
-		free_used_gpio_if_valid(gpio_data->gpio, led);
-		gpio_data->gpio = 0;
-		return n;
-	}
-
 	ret = gpio_request(gpio, "ledtrig-gpio");
 	if (ret) {
 		dev_err(dev, "gpio_request failed with error %d\n", ret);
@@ -195,6 +188,7 @@ static int gpio_trig_activate(struct led_classdev *led)
 		return -ENOMEM;
 
 	gpio_data->led = led;
+	gpio_data->gpio = -1;
 	led_set_trigger_data(led, gpio_data);
 
 	return 0;
-- 
2.21.0.1020.gf2820cf01a-goog

