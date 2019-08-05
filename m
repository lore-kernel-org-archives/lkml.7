Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0608C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972F2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="d0wHezom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHEI36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:29:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:29:58 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so165390292iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=utE9KIcR0f6O7/Nl0QrtDLlS9or1TsF6Brw5BfMNxCA=;
        b=d0wHezomM4JELxNG1RXAvHXwky0XmyiTzsKSe/aaydaB+Ep00jiSc2XOmm0T0UKf0/
         R3IFTCaY3ORDePWQlzE3eOFpwpxXiQ8zgDy3i5+KDN58y3neju2XC7Pckm7hreBAxOUN
         kjxtmBubW+ncgwetw2nwYN0Fwk3A3EN8rpYKLBhlYRbmmdT309CeqHJUhZZdk93w1X2u
         Ic6sFRLmi+qnfvmJzkDgbtOtWKajfXoyG6CnlfxNiYNNVkTlfQ8I+vyWC2q/QsL+Wt/K
         G9zcgXiIhggUoQfWc/TreThgGqt5sC0c31QQJlY04qPhVKKwBfNUlTU2e7f6VtLywHvx
         XayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=utE9KIcR0f6O7/Nl0QrtDLlS9or1TsF6Brw5BfMNxCA=;
        b=PjVrxE3S4+Y8nuJiqol0DMp2hQxnFvwN2VZHJ9ZYWyhAY8CTYuHMvnXWL4rGDDCB6/
         tMCDpR6Hkm1Vdrqrp9VrIk/UiQNk9KClfLUHT/Z4yabEQddeNvCEA9oXgwSYD7sbJtRk
         ixmdz+YJbFC/Fk2vv4ZD3ZEOtv3iSqGD50qA5r2cVru6a1kvA8ukw+IbtwFOxXB/Rz7r
         sT7bEgdXWEvJ3gUdr5Nujciatm5qN6CS4iqrrsSh2Wg33FAdio+fAeLkJ+gbntO4BOyy
         xjUllx8R/Rx+4GTjy0Po1IislZQvuwVCwt5ojYlnZYnCHuv6hC4yl3w/udxtSxvFmbQC
         Z4xA==
X-Gm-Message-State: APjAAAXYVL+T8CVDBC1cmIBk5sWb5dQ1Ja6zq8xPCilwwqqXILqhq0Vx
        I4IgPsBk9pUJpx132YEOZC78q+eSw+w5B3E5u0U=
X-Google-Smtp-Source: APXvYqwG2qGnHr5QDUaSd+OFbMEQGTuAoyrOpHr27vtVqWcgtgIvxk1ESLat++QpC/1nyVQeDMRQ2DrEjrqx+c8O4Rg=
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr20730801ior.167.1564993796136;
 Mon, 05 Aug 2019 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190703084811.9582-1-brgl@bgdev.pl>
In-Reply-To: <20190703084811.9582-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Aug 2019 10:29:45 +0200
Message-ID: <CAMRc=MdzZDHLRpgC966CGQMBj8O9FXuXLvjKJNf_N0UwcXzZgA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max77650: add MODULE_ALIAS()
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 3 lip 2019 o 10:48 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Define a MODULE_ALIAS() in the charger sub-driver for max77650 so that
> the appropriate module gets loaded together with the core mfd driver.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/power/supply/max77650-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> index e34714cb05ec..5f9477c5cf5a 100644
> --- a/drivers/power/supply/max77650-charger.c
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -366,3 +366,4 @@ module_platform_driver(max77650_charger_driver);
>  MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
>  MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:max77650-charger");
> --
> 2.21.0
>

Hi Sebastian,

just a gentle ping for this patch.

Bart
