Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1942DC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E2120663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HURvKWzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfILJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:51:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46669 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfILJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:50:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so22933634ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdRYvJPvrvcMWGM+o4yy0OFD2vjnmvyON9CrpokCAF4=;
        b=HURvKWzzNwOqIen9JLlFUszay1jwdNZrVw+OUaJH02nSfnCz7CvVqGly7LHz9KIuZ7
         bKsfyElQz42Rb9UJ+K9Eln4wIYBxpxF6UB8Oyvfcuk4UOylGJp8BgzBCztTU5XGTjIXA
         /EazIGzMT/Ufyzj/GQwAnE8XYzlDVQsi7M7e/LFyegdzNzZpe2cExDQwbzE/Ut0Pazoi
         N9xccxUwAy/4SLZMOsbGpm9v1vLWTQdDkVNT0FWxy5TNEtyeu29v9s3s27fYgKJEoleo
         lvtUF12sc5KZlHTwTcO2NVnE+6d6mlppSg83klp1qrOk6NwfyRu3qf3dsLG9dyPTV1tB
         qe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdRYvJPvrvcMWGM+o4yy0OFD2vjnmvyON9CrpokCAF4=;
        b=HP5ERcJwLgZ7CaUbUbV71La/7iLPThWK13hNL6M7ViRrbAQDqOHEDgaqBiLwNwv1sZ
         MmqxYXKg59PpqedYJTFzPKakJLSLNTWeWpPdNI2jgKVqYCJfupg3D09ySX2htBEhH3vl
         SwPVHVLpdGJuuHzuecS3u40DOVceBJgkodVL+FEQp4QgUAP24LAjo6UwYC9LDl0Wh4Mn
         KKtCt96xx8XcTcrkdC5r5j9hClFOu5Ha/OuXQCHRPXrlQuw5tVSHEE9gdpfVTEI90tmc
         O15pRDTUmSleL02AveCK/A5fPl/TyINOwd+X5PYcGopaQESNGrs5hdrsZ7WXEENjGLJa
         UR9w==
X-Gm-Message-State: APjAAAWi4oTzdhwLq3ZF4ZTgLPaIOYyr8IONps+h82HpXSHnkTe9OTx/
        PtgLmZX0KmOxWKkhqr7kd28W2NvzY+Lv30U29N/Zvw==
X-Google-Smtp-Source: APXvYqwzwrb438IO36oEfPSf+7fcsnQVQMy0lMdYLWC5HSg6an/q4RM9Kwj8Y1/EdXgPTXqwidtFWBMIcHQToquQEKo=
X-Received: by 2002:a2e:a408:: with SMTP id p8mr25758282ljn.54.1568281857654;
 Thu, 12 Sep 2019 02:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com> <20190911075215.78047-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20190911075215.78047-4-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:50:46 +0100
Message-ID: <CACRpkdZ61S=xCA8TQ7m-qN8NaXKjTyWBFqxvZC=qF6b7_nuNzA@mail.gmail.com>
Subject: Re: [PATCH 03/11] gpiolib: introduce fwnode_gpiod_get_index()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:52 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This introduces fwnode_gpiod_get_index() that iterates through common gpio
> suffixes when trying to locate a GPIO within a given firmware node.
>
> We also switch devm_fwnode_gpiod_get_index() to call
> fwnode_gpiod_get_index() instead of iterating through GPIO suffixes on
> its own.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

So I'd like to merge this as well for v5.4 because I see where
you're going with this and it's nice to have these APIs in place
for that.

Please rebase this and the other one and resend!

Yours,
Linus Walleij
