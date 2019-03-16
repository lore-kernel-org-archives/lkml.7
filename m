Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584AD21903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMbtD2i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCPOU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:20:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40066 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:20:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so8383651pgo.7;
        Sat, 16 Mar 2019 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xLvcWqZ7N6gPGXUaGvUF5ay03DIA8CtUudxqTZwhnnE=;
        b=NMbtD2i1WneD4InE6ZpE4m630LaIZQUvtGRnkjruNzomN+AwQ72HZZgpcYtggHsGaz
         ZLXZXwvlbjteTAuNXriMVnSkC0fPjofGvkKSfUNU5EFYRPem2Z+gGeq73AcYVhLxXt0r
         DQAlMMbWT/6jlT/2PcECe90nCoNF2PBB+jK36El5tY8I0K2r6/fpl1FluGJ8WlSCsh0X
         avLObByHxDhAk9zjMmwA5leKXKIj+4uVlcfs+qSrTA77itXeHaRFjiW4Piwzt1KyqM6B
         9uaA7fgrAfPAmvb92nSkgQMpkjglxlWDzUm676qnAo3CcQRExoEVav6G/2LqaKDwYsVF
         kJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLvcWqZ7N6gPGXUaGvUF5ay03DIA8CtUudxqTZwhnnE=;
        b=GW4ILdTPbQcPVq5hZPOjqHWc/mq7/EKNoSfUd9u8sUqMgGMCVeZX00+dZE5m7Kp53n
         JUwEx1QhEqIMYQUpsdZMgRn7GpGdgfAIzfPMYetsBnvQBk5JqaLJZBRHQA03n/k1UszU
         MBmhmjrEfe1pl/fp/PLACvF8c9WUjDvlwjmWOj36Ps7b3jeRP+1dG5VeS115DofV+3cf
         sVUnkRkPSUPFlFHeXD4BNsDTcRR56jcyu7wfy+hubXgK+FB0McONJHsLcr5KJcHA1UYv
         sDo2AyvW3YRQHVWZc8FsAE1pQk2bBwyv99c1CPC/Yr6pGD4p4zqCG+ApihXVFUjE9TxS
         +g8Q==
X-Gm-Message-State: APjAAAVZ8xUKuK5cSh+fIyIeSATyRKutrm5GsdoIgVY8V+to3me7tRqw
        GHXZ58cwgw+Y0C+9/+SUmSQ=
X-Google-Smtp-Source: APXvYqxDs0L8Z08zcOXbukEWDbYhMu7uaARXmL53mTZJJcpP1AZxtYmc6SU6mfZmCfOzbSjknw4R6w==
X-Received: by 2002:a63:ee58:: with SMTP id n24mr8641743pgk.247.1552746026045;
        Sat, 16 Mar 2019 07:20:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q62sm13771204pfi.183.2019.03.16.07.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 07:20:24 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:20:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more
 places
Message-ID: <20190316142023.GA10494@roeck-us.net>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
 <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
 <20190316014352.GA6124@roeck-us.net>
 <20190316144519.07805478@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316144519.07805478@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 02:45:19PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 15 Mar 2019 18:43:52 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index cf8a4402fef1..9762a836fec9 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -2762,7 +2762,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
> > >  	}
> > >  
> > >  	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> > > -	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> > > +	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);  
> > 
> > Are you sure this is correct ? This patch results in a number of tracebacks
> > in mainline. Reverting it fixes the problem.
> > 
> > gpio_set_config() seems to pack config, but it is already packed above.
> > That seems a bit suspicious.
> 
> I'll have a look. In the mean time, I'm fine with the patch being
> reverted.
> 

I don't know the code well enough to make a recommendation one way or another
(meaning I am not entirely sure if the aspeed code generating the traceback code
is correct). However, the attached does fix the problem for me, suggesting that
gpio_set_config() might be missing an argument.

Guenter

---

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 144af0733581..e972836e8d8f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2563,9 +2563,9 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  */
 
 static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			   enum pin_config_param mode)
+			   enum pin_config_param mode, u32 argument)
 {
-	unsigned long config = { PIN_CONF_PACKED(mode, 0) };
+	unsigned long config = { PIN_CONF_PACKED(mode, argument) };
 
 	return gc->set_config ? gc->set_config(gc, offset, config) : -ENOTSUPP;
 }
@@ -2619,10 +2619,10 @@ int gpiod_direction_input(struct gpio_desc *desc)
 
 	if (test_bit(FLAG_PULL_UP, &desc->flags))
 		gpio_set_config(chip, gpio_chip_hwgpio(desc),
-				PIN_CONFIG_BIAS_PULL_UP);
+				PIN_CONFIG_BIAS_PULL_UP, 0);
 	else if (test_bit(FLAG_PULL_DOWN, &desc->flags))
 		gpio_set_config(chip, gpio_chip_hwgpio(desc),
-				PIN_CONFIG_BIAS_PULL_DOWN);
+				PIN_CONFIG_BIAS_PULL_DOWN, 0);
 
 	trace_gpio_direction(desc_to_gpio(desc), 1, status);
 
@@ -2727,7 +2727,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_config(gc, gpio_chip_hwgpio(desc),
-				      PIN_CONFIG_DRIVE_OPEN_DRAIN);
+				      PIN_CONFIG_DRIVE_OPEN_DRAIN, 0);
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open drain by not actively driving the line high */
@@ -2736,7 +2736,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 	}
 	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
 		ret = gpio_set_config(gc, gpio_chip_hwgpio(desc),
-				      PIN_CONFIG_DRIVE_OPEN_SOURCE);
+				      PIN_CONFIG_DRIVE_OPEN_SOURCE, 0);
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open source by not actively driving the line low */
@@ -2744,7 +2744,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			return gpiod_direction_input(desc);
 	} else {
 		gpio_set_config(gc, gpio_chip_hwgpio(desc),
-				PIN_CONFIG_DRIVE_PUSH_PULL);
+				PIN_CONFIG_DRIVE_PUSH_PULL, 0);
 	}
 
 set_output_value:
@@ -2764,19 +2764,11 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 {
 	struct gpio_chip	*chip;
-	unsigned long		config;
 
 	VALIDATE_DESC(desc);
 	chip = desc->gdev->chip;
-	if (!chip->set || !chip->set_config) {
-		gpiod_dbg(desc,
-			  "%s: missing set() or set_config() operations\n",
-			  __func__);
-		return -ENOTSUPP;
-	}
-
-	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpio_set_config(chip, gpio_chip_hwgpio(desc),
+			       PIN_CONFIG_INPUT_DEBOUNCE, debounce);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -2791,7 +2783,6 @@ EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 {
 	struct gpio_chip *chip;
-	unsigned long packed;
 	int gpio;
 	int rc;
 
@@ -2807,13 +2798,8 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 
 	/* If the driver supports it, set the persistence state now */
 	chip = desc->gdev->chip;
-	if (!chip->set_config)
-		return 0;
-
-	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
-					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = gpio_set_config(chip, gpio, packed);
+	rc = gpio_set_config(chip, gpio, PIN_CONFIG_PERSIST_STATE, !transitory);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
