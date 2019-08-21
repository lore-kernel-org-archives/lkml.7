Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941322089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jpo+UUhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfHUMj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:39:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37998 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:39:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3so1987952lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOXeww4Uf23e729rTkwuQA6wyzC7c2QQQGmkeXPLo0s=;
        b=Jpo+UUhhwNEh5NQqmY1XLcyj6evZPbxS2DCMO+HxFkYjq8WNxh3hFd/yV1XYrNmYcb
         ZLDiCGIKgp0IFxh9WLkzoYmVaWOPjmd58Snr5QS6enSkUl7A2AVzCQVVbHZ5J+jz2FaS
         ax9U7aK2r65fEdITgKNKZqNodoCxWNAUCYN1tsPQaj4yXKtrbe6pJpCdAXdr7APQJ64r
         3hI+GbcjaiVgP3zwozN5plL4gFhhxts0sv6sa40tTcj3kq6Ho+fa2S2QTlKjbsZ386h6
         yCV5GvczH9rTA+P6PmTCzUMmlkeuwx0PPUJHwbkTPtWiqDolJb3ogoy6vUGG3mjU9ox5
         DS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOXeww4Uf23e729rTkwuQA6wyzC7c2QQQGmkeXPLo0s=;
        b=cKOrPccJApA+PpoE7Gfj1BDyLVRwUeLbK14I/0PhBXn5C+3N6VeExeLql1sBLCtLie
         27ezaWNaV4pChDbaItpbaZcGX0kEY98mq3PzvuKYgrPZ3zrjciAKOo1X0bS+b06hG3kL
         naudVy/BTG145zMU1v53FCiN2GKKd1/F4sK5BrJ4CzB67o2VmgICScR3ZJ4P42jPn55Q
         5pwZJi7nVixxBXolOA8M5MFX2ntienTJzGi/4eChN+3a3MI8cddh1eI9xqS9+bNV37dN
         saG2NR0FOJ1t3tC1OO61hAbYS0Ru0LZS9KHOdccfI1+go3UJP3tOffQSMVayIStOcfWf
         ybGA==
X-Gm-Message-State: APjAAAWyihFNGkZHO6tod7jzhfeRrqKWBihjMvGznT00+rpsAXG7WIde
        sALMWONOa4JHDfUco2gcPy3J3ajq089RZIkKJq5izQ==
X-Google-Smtp-Source: APXvYqwYkTNtKtafkV5aDsc60HSbv1wFMSkUnoyPW7zeXom6XswAJiHhBvDIFeVFr0Oqt3b6NefTIPLpC7TWMseP0BQ=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr18892987ljo.69.1566391193787;
 Wed, 21 Aug 2019 05:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Aug 2019 14:39:41 +0200
Message-ID: <CACRpkdZo9so+5UoT3QpFmL_8NZT1d1i7Yab202RNn8gDfnPK7A@mail.gmail.com>
Subject: Re: [PATCH 00/11] Face lift for bu21013_ts driver
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 2:20 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> So your patch has prompted me to take a look at the driver and
> try to clean it up. I am sure I screwed up somewhere, but you said
> you have the device, so please take a look at the series and
> see if you can salvage them

I will funnel patch 1/11 in the ARM SoC tree.

The rest work fine except on the resource release in the error path. I had
to do this:

diff --git a/drivers/input/touchscreen/bu21013_ts.c
b/drivers/input/touchscreen/bu21013_ts.c
index c89a00a6e67c..bdae4cd4243a 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -390,18 +390,18 @@ static int bu21013_init_chip(struct bu21013_ts *ts)
  return 0;
 }

-static void bu21013_power_off(void *_ts)
+static void bu21013_power_off(void *data)
 {
- struct bu21013_ts *ts = ts;
+ struct regulator *regulator = data;

- regulator_disable(ts->regulator);
+ regulator_disable(regulator);
 }

-static void bu21013_disable_chip(void *_ts)
+static void bu21013_disable_chip(void *data)
 {
- struct bu21013_ts *ts = ts;
+ struct gpio_desc *gpiod = data;

- gpiod_set_value(ts->cs_gpiod, 0);
+ gpiod_set_value(gpiod, 0);
 }

 static int bu21013_probe(struct i2c_client *client,
@@ -488,7 +488,8 @@ static int bu21013_probe(struct i2c_client *client,
  return error;
  }

- error = devm_add_action_or_reset(&client->dev, bu21013_power_off, ts);
+ error = devm_add_action_or_reset(&client->dev, bu21013_power_off,
+ ts->regulator);
  if (error) {
  dev_err(&client->dev, "failed to install power off handler\n");
  return error;
@@ -505,7 +506,7 @@ static int bu21013_probe(struct i2c_client *client,
  gpiod_set_consumer_name(ts->cs_gpiod, "BU21013 CS");

  error = devm_add_action_or_reset(&client->dev,
- bu21013_disable_chip, ts);
+ bu21013_disable_chip, ts->cs_gpiod);
  if (error) {
  dev_err(&client->dev,
  "failed to install chip disable handler\n");


I think this is because when probe() fails it first free:s the devm_kzalloc()
allocations, so the ts->foo will result in NULL dereference.

If I just reference the gpio desc or regulator directly like this in the
callback, things work fine.

With these changes:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
