Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A074820848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/s8Jblq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfEPVmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:42:33 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:40468 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEPVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:42:32 -0400
Received: by mail-vk1-f201.google.com with SMTP id d64so1799562vkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dzrCuR0CYk8j8JHGMP9OKcrg17nxFH7UW7yzX+clpRM=;
        b=W/s8Jblq1GsRFbjb5XVhpcEHui0zgHCgxnU2c7Tlg/gWmEhESkOmAX5zkR411ILh84
         z/8x13syAaDRUFmdNz+oEXNQVB1F9ESw4iM1KZeGb7lfpNEYp7bVsrYDy+lDjNwqIhSi
         6TL+oG1fIfRaeU+io8iPpU6hK2lDJOUHm+EsHbMObGSl/AQnACA03W/ria/AUZl50mDf
         kA0Fd+P3qjt+XINUh0rq3YiJezttup4RP6jTDNyC4ltADmKTlEGnkTYQPoxEDWWBqRUy
         HbIKRULRlW6J3sbQeo3dlKlBzy01pqL+t0LmB142tNM0/C8QXmGaWYvuCUJHIuwHkyNN
         tXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dzrCuR0CYk8j8JHGMP9OKcrg17nxFH7UW7yzX+clpRM=;
        b=YkdrMmY04f0oq6CFFQ1gt2aP/w8aotJpTvoBIFdfLP6IxqyKgHD+7b20mBtgyjOE/d
         zomJ35uuuk/R4vYvFAB7G5iEMzV070dIUoN6V5DxRyu/ISZPaWaLPgiBDkD0suY2Sx4s
         mAu01i6e64DsmiURQHiLvmNLtaAAc6EXxZUoxqWSXGW+JwsOdlBQuUhpTN5jGamZiJWE
         C5Na2i6Y+flE9vfaSvGcYYHqcR4DKeaAjhwuYiBkafpSWidbYbJOUpiVnlFmzJ2lbrvq
         mngMst09M5XDITP+UcUXOoSiUp2DAGqiDOmU8IGhEYeABQpcJAp1qbPG64Mpa0+nG5Ny
         Cr0A==
X-Gm-Message-State: APjAAAXYHgbAmXY8VsZBIUzA82nGq9RpPKWK30VJAxklCWsFUwTpONfp
        YmpetsDTo1L5okcNFnDEXQHnRwfESw==
X-Google-Smtp-Source: APXvYqxoifRO9sH2RiZFojMHVJ10usKMr33G7oMaM4OHjVll1Z9hzRSZlNR8bShxOBoIUagpMNsyS6CLkA==
X-Received: by 2002:a1f:fe81:: with SMTP id l123mr589442vki.51.1558042951597;
 Thu, 16 May 2019 14:42:31 -0700 (PDT)
Date:   Thu, 16 May 2019 14:42:08 -0700
In-Reply-To: <20190516214209.139726-1-kunyi@google.com>
Message-Id: <20190516214209.139726-2-kunyi@google.com>
Mime-Version: 1.0
References: <20190516214209.139726-1-kunyi@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 1/2] ledtrig-gpio: Request user input pin as GPIO
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

The ledtrig-gpio logic assumes the input pin can be directly converted
to IRQ using gpio_to_irq. This is problematic since there is no
guarantee on the pinmux function nor the direction of the pin. Request
the pin as an input GPIO before requesting it as an IRQ.

Tested: a free pin can be correctly requested as GPIO
Signed-off-by: Kun Yi <kunyi@google.com>
Change-Id: I657e3e108552612506775cc348a8b4b35d40cac5
---
 drivers/leds/trigger/ledtrig-gpio.c | 31 +++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index ed0db8ed825f..f6d50e031492 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -117,6 +117,16 @@ static ssize_t gpio_trig_gpio_show(struct device *dev,
 	return sprintf(buf, "%u\n", gpio_data->gpio);
 }
 
+static inline void free_used_gpio_if_valid(unsigned int gpio,
+					   struct led_classdev *led)
+{
+	if (gpio == 0)
+		return;
+
+	free_irq(gpio_to_irq(gpio), led);
+	gpio_free(gpio);
+}
+
 static ssize_t gpio_trig_gpio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t n)
 {
@@ -135,20 +145,30 @@ static ssize_t gpio_trig_gpio_store(struct device *dev,
 		return n;
 
 	if (!gpio) {
-		if (gpio_data->gpio != 0)
-			free_irq(gpio_to_irq(gpio_data->gpio), led);
+		free_used_gpio_if_valid(gpio_data->gpio, led);
 		gpio_data->gpio = 0;
 		return n;
 	}
 
+	ret = gpio_request(gpio, "ledtrig-gpio");
+	if (ret) {
+		dev_err(dev, "gpio_request failed with error %d\n", ret);
+		return ret;
+	}
+
+	ret = gpio_direction_input(gpio);
+	if (ret) {
+		dev_err(dev, "gpio_direction_input failed with err %d\n", ret);
+		return ret;
+	}
+
 	ret = request_threaded_irq(gpio_to_irq(gpio), NULL, gpio_trig_irq,
 			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING
 			| IRQF_TRIGGER_FALLING, "ledtrig-gpio", led);
 	if (ret) {
 		dev_err(dev, "request_irq failed with error %d\n", ret);
 	} else {
-		if (gpio_data->gpio != 0)
-			free_irq(gpio_to_irq(gpio_data->gpio), led);
+		free_used_gpio_if_valid(gpio_data->gpio, led);
 		gpio_data->gpio = gpio;
 		/* After changing the GPIO, we need to update the LED. */
 		gpio_trig_irq(0, led);
@@ -184,8 +204,7 @@ static void gpio_trig_deactivate(struct led_classdev *led)
 {
 	struct gpio_trig_data *gpio_data = led_get_trigger_data(led);
 
-	if (gpio_data->gpio != 0)
-		free_irq(gpio_to_irq(gpio_data->gpio), led);
+	free_used_gpio_if_valid(gpio_data->gpio, led);
 	kfree(gpio_data);
 }
 
-- 
2.21.0.1020.gf2820cf01a-goog

