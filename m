Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C45C76190
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560B92075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlhkQmH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfG1XiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:38:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37567 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1XiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:38:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so40690562lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2YoLjOmjoi0MvPq3QD0hmADDj+Ydfv3BHipfJHYsV4=;
        b=XlhkQmH67dhcBDB/Xr7JvFPOG2VU81DTdMdboPT/HeIYWgB9tdya4Qu7sHgU0WMkaM
         vLenZczcXQneLoQwwIMosVAUQ7eROBagrCowwDdHynkzWR6TG6G/348pyMvV2ko15fAX
         J6eOaYIHqHdN2UumITKAxV05/2xTZbsY0nfOHx2zKefVEAWZk/V94esJyXg+dV04m9ZC
         3T6esDVVvsV2RDBV0sLFBEN22b9i5xaNaCrAxueDIdJQotuNWYkqh9CJdvvAgneQ8VYO
         PxSF+7xqWZhasZ+4KJQhOOybJ6f/GiXAs/huwwXy1rfoOxGb0FkKxX89PQJ4JjNcb5+Z
         0kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2YoLjOmjoi0MvPq3QD0hmADDj+Ydfv3BHipfJHYsV4=;
        b=EwMOS5FHWY+pwOIMNOv55N6ZPbRssgR9r43cninGz3oPJPTZbWDXPbmShezwBLfuYE
         MMxQmBDRmCQZK7kUD6YOHbzkBkm0OsRMrVQVfSL9aCIfShi3mmgdin4pdlRp9mDZaNQI
         gCxW8m5KMr6AsEB3xlU0pKyunKDIVWd8zQCI696I5aQBltk1YacczAYo6B1RKO54Kzhe
         TQPWhyDmMyG2iXRlY4w+kmhEZLMkMC5EM6zZix60WFHQnK0V6Ierepuc3StnQEWuOx/o
         ZB32bNQQbSqNAtsBhv5mZZ8mJobC2+1AjzgNdIWAapmRfkm4R5tiD+Axx2VJ1or+V8Sz
         DzUA==
X-Gm-Message-State: APjAAAV+sx6XnJALmm1zov5hJsSM67AlihzY1DZxCmTKMtz4aY0qpXj/
        sgzwjEOEFUA81Zw1cBExNRZ/sPGuYm9AiAK52PfBMw==
X-Google-Smtp-Source: APXvYqzNLF2GKPsxU0k1Fl9UXDm3yiIIWBYWeFyjCRu2eWqJIj+FDChdYuoS6Cmi6P1mJrVQoHtEsToFX8UBgZc9YJM=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr45895639lfg.152.1564357090803;
 Sun, 28 Jul 2019 16:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <1563564291-9692-3-git-send-email-hongweiz@ami.com> <1563827815-15092-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1563827815-15092-1-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:37:33 +0200
Message-ID: <CACRpkdbkLj7WDMp7vtNDR81yezw-zPq3MWvVRLKvpkvAueo0uw@mail.gmail.com>
Subject: Re: [v5 2/2] gpio: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:37 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> As you suspected it correctly, AST2500 utilizes all the 32 bits of the registers
> (data value, interrupt, etc...), such that using 8-bit bands
> [7:0]/[15:8]/23:16]/[31:24] of GPIO_200H for SGPIO_A/B/C/D .
> so registering 10 gpiochip drivers separately will make code more
> complicated, for example gpio_200 register (data_value reg) has to be
> shared by 4 gpiochip instances, and the same is true for gpio204 (interrupt reg),
> and other more registers.
> So we would prefer to keeping current implementation.

OK this is a pretty good argument. My review assumed one
32-bit register was not shared between banks but it is,
I see.

The above situation can be managed by regmap, but that will
just a different complexity so go with this approach then.

Yours,
Linus Walleij
