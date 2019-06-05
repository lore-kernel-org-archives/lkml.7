Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75368C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CDC206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hPtw3Y2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfFEO0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:26:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34748 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbfFEO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:26:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id z24so898158oto.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL4eMTZZT/wE0hkK6FB5FP6G9IkYTdMLMu0xfJfFr7U=;
        b=hPtw3Y2E/pyB1XksMc4M9rKgdTFSwDoAiNpq17NbygQ4SdKgCaa47EOQAjcHTYcAKM
         IfYPvJCb6gfPNiZyLRemhD3EvfH+m8QxJi2ap0FmTZ3g7j4p1Ptza2VCOdWBC72AcVhR
         hvCUjIvTt8mEYQXDq5fSTuOwuP68R9N0DdKrTWbkv+zYR/5jYq7gMGkAgRiTHY4OZ1TM
         kjGraZRqrdmV8g2jGWNX9tdZ38yodTXxaDHkIQdI/F+L2T1qM7f8L4o0kTPXxqyZDLyV
         zlRnw7m0GS9IdXnaEZP5yMIy5OnR0jDbPACnZCiiZJwQH1qyDiNGTMLE+7MHeOs3fDt8
         VZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL4eMTZZT/wE0hkK6FB5FP6G9IkYTdMLMu0xfJfFr7U=;
        b=sbm1wQg15JnzneB/v5MO3iGA50G++lZ1tQlDl6xuZUBU3thkLEBMI3pQMhpqlyVaBF
         n7wFTYevOMwzORnhF9U+LkTgeAzu6535GG8HrYn5WrzRTAboWFxRq1s+VxUIZweJwM6Z
         /xDNMhcW5ZNIrua57zoKQyeW8eEdCDuP4rwg8R4s1x28BQuvhytJxDw3JtXQ/XT7m6Rd
         vaDLYiOqowCu0nz+IuXxCq5b3VHdBBYokdhIRAGdUS8fU8ifF0CJK3yV26lSeJmp7yNg
         JEs9Mt8YeQtDctWycVTq0sHtftX4r4O5cAMDLVkZYE6e7p/K6FY8FXXBODElmfwJDiD4
         7ofA==
X-Gm-Message-State: APjAAAWcLTY3VZq2WCIN+3CUNntQnlCRluA2gID0lqU1Xvw9Ne0QRQNI
        mqSUzU3A5NpYnYskxg21qXF4x7xxkTczBD4T6n/lPY5E
X-Google-Smtp-Source: APXvYqw0kmvusudeqy9V/YEc9PQOJ92G0SUc1WeRY1/0tv+zokrX949p13XS9w+Bkx+NZCHWYyFvZUgH6PJ3gksG+9I=
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr10316423otq.194.1559744796485;
 Wed, 05 Jun 2019 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-3-j-keerthy@ti.com>
In-Reply-To: <20190605080259.2462-3-j-keerthy@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 5 Jun 2019 16:26:25 +0200
Message-ID: <CAMpxmJXjMX20TAEsfEa7pqZx5-aW_rMKwS+6g9NTvRNEfuAyeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: davinci: Add new compatible for K3 AM654 SoCs
To:     Keerthy <j-keerthy@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, lokeshvutla@ti.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 5 cze 2019 o 10:02 Keerthy <j-keerthy@ti.com> napisa=C5=82(a):
>
> Add new compatible for K3 AM654 SoCs.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 0977590eb996..fc494a84a29d 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -632,6 +632,7 @@ static int davinci_gpio_irq_setup(struct platform_dev=
ice *pdev)
>
>  static const struct of_device_id davinci_gpio_ids[] =3D {
>         { .compatible =3D "ti,keystone-gpio", keystone_gpio_get_irq_chip}=
,
> +       { .compatible =3D "ti,am654-gpio", keystone_gpio_get_irq_chip},

Please add a patch adding this compatible to the binding document as well.

Bart

>         { .compatible =3D "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
>         { /* sentinel */ },
>  };
> --
> 2.17.1
>
