Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC98C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B20D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PUkfCqSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfCKJb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37116 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfCKJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id w66so3067850oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqIA2qFNCheeLaC8TLgaUrIC9uHMFVYT0YrqgKTZVek=;
        b=PUkfCqSUQP12KMyFb9NfnfBgXE6E/Qpvf/JSjLJ80MpL1aT5Bepohve3GoQXsUslkC
         11V3wMtE7prbopjGh6XifLrHouud67Pfo6DhzLskheS3qmEgrEJecAL0x6i4KOzwbhq3
         QT3Gx42k32xJtZgr5zj4KeLltSp5s0gwXEd4DX8DexJx6tbQwOdkBtqjVmfW8XwsZ/FO
         5gaoMZtKw8ZqubBNpCYpFSL1xlUgS9oj5JlCivqBChzqPwdq5H0be3vSZYctEE22Eygz
         mz6nN3x9JTXfBDCC0BvX6ePFnYuG9oGORSReP7InQho7lZeEPg9xIc1K7vWLt+P6RatL
         pKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqIA2qFNCheeLaC8TLgaUrIC9uHMFVYT0YrqgKTZVek=;
        b=bT8uAYX0eC0ke77A54p0fIrzlnm+mcA7WwNWWFgKb6woGq8n9AqLLjbBjsd5fOm32i
         ch+apeDzZos3qcx0yV1p3Jq38mdJnvVnam05hhCHfxJn4LsTek3K2MI7z4aPdWEa1/5U
         UPqIsDBbeV169t4hBIqO9XZu1+nP5I+iZPjYYapTpsHSLXQIAKdqWJjiv6LlLuduPpuv
         vSVRwynfPbjID3rRT5ROHKKR4lrDbYyV2TuX2iFaJ1a7+5z3o0ujPIOxlrH/VULiat2z
         xTJnhc3aO8kqxeOG1OHisTfay1y5E6tNG0bYBzQCxc+UlRGU47Re30GEV5n3NBfGU63A
         cM6w==
X-Gm-Message-State: APjAAAVhAm+tZixhjLMPMa73+ZtsXiEKVTNBZmPgyI2M45E5bwQC5k2v
        ogoUCLshjZ2dLZEZSukZoES53MJ1ItjLszIyQxfoxQ==
X-Google-Smtp-Source: APXvYqx7mpcRSRL1z8DbYgm/GylDWgJ0boexIpSijHxu1YbiJNQ5n4B90b/nflqKot2g2LBnLI0nUtP6gF17w7gKrIs=
X-Received: by 2002:aca:c1d7:: with SMTP id r206mr16243248oif.147.1552296714716;
 Mon, 11 Mar 2019 02:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190309040757.924-1-kjlu@umn.edu>
In-Reply-To: <20190309040757.924-1-kjlu@umn.edu>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Mar 2019 10:31:43 +0100
Message-ID: <CAMpxmJUjUJSfQuFYqHmwvcBwdt7e6g1crGfkMdKR6wObePptdQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: add a check for the return value of ida_simple_get fails
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 9 mar 2019 o 05:08 Kangjie Lu <kjlu@umn.edu> napisa=C5=82(a):
>
> ida_simple_get may fail and return a negative error number.
> The fix checks its return value; if it fails, go to err_destroy.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/gpio/gpio-exar.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index 0ecd2369c2ca..a09d2f9ebacc 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -148,6 +148,8 @@ static int gpio_exar_probe(struct platform_device *pd=
ev)
>         mutex_init(&exar_gpio->lock);
>
>         index =3D ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +       if (index < 0)
> +               goto err_destroy;
>
>         sprintf(exar_gpio->name, "exar_gpio%d", index);
>         exar_gpio->gpio_chip.label =3D exar_gpio->name;
> --
> 2.17.1
>

Applied, I Cc'ed stable and will send it to Linus Walleij once
v5.1-rc1 is tagged.

Bart
