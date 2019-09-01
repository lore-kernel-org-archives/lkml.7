Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB99C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293622CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bkdN6BO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfIAL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 07:29:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45355 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfIAL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 07:29:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id v12so8549012oic.12;
        Sun, 01 Sep 2019 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjNYoP0TZjOYpbU4nYIgEpFHwbIKmPPLiFzVEjdvaZg=;
        b=bkdN6BO8eAl30cWYew33QHGFT9cJopCCWlD/vsFFjQaGz3Fc9EjQZ4W/ukbLppZV2P
         Zg9MvFarnFdjh9jp06N9mwJjvs7IKsXhhc7JTFb9AenAojzTgNiTBRGE0v7hXusB0Qg7
         b17iL8zwOQ2XgKagS1q4RHVeuaNhOjSajZH8WKsArRWkywx+0A69Fui74XQtKwzyvJpS
         uRM1U8i23COUJLo7/cQeuM3vRiEQrU3JytSkE/CjSid0Ol1HkKoH/pytDodkRbgFFBls
         qFgih7cva/RE8Tq6BCxXLe8jJjnrokgKTZk/Rh8NqVS8drzarN/QKLjHSPZzufu6rv1N
         RJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjNYoP0TZjOYpbU4nYIgEpFHwbIKmPPLiFzVEjdvaZg=;
        b=V7U2pmQi8uXg6y4nLU34le6GzD/ms5HMG4X8OrCSL2oudhOQhTj+NZgEEX0oKPyqy6
         B3tK1Rdyn9gcQlLPX+eCArudU7QiBWps1F6mmjk4aR/fgXvGehnXZDuMlr9S0/XQ6Z4v
         76wXCOojxJI9sKhVQupSYaeOOKKfjaMa5OADl1jeTUX8qrhg37pz9HlRYAe2GRCnWrYq
         BKPC3qDO88hQxizFZ8c7MzGQ/0oCnuJbdfO85MmEGQpCjvDXjqbUyBwtUbmuDyQexJtI
         //DtjNz3QegqN9/X+9Hu0yoT6573dD0k9brIoKpDCs638tGZNPMq5QLWqPfv7M1aNmcE
         tQcg==
X-Gm-Message-State: APjAAAUWYErSBfVxmZ2+THPDSrGdMAS9jr+7QmeJ1M6hd59IFbwLaBif
        qZ8V3Z76c4EniNDZ1M/MkWhnLRiEuxD/uk3SUgM=
X-Google-Smtp-Source: APXvYqxxXKXRUZLMHQgk0XoewqNh98k6Y0rpItgSJzPuoeBuz1EBdkqcp55bFlX0B41vfDbAAe9Icj/tVYTN6vp7Ft8=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr15778496oij.15.1567337355596;
 Sun, 01 Sep 2019 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190901105410.23567-1-repk@triplefau.lt>
In-Reply-To: <20190901105410.23567-1-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 13:29:04 +0200
Message-ID: <CAFBinCD96nJBPnyNgWA6CgwE2kZrkXB3-cgbV9aQLB=JtbrN2w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elie Roudninski <xademax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 12:45 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> meson_saradc's irq handler uses priv->regmap so make sure that it is
> allocated before the irq get enabled.
>
> This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> managed resources are freed in the inverted order they had been
> allocated, priv->regmap was freed before the spurious fake irq that
> CONFIG_DEBUG_SHIRQ adds called the handler.
>

Fixes: 3af109131b7eb8 ("iio: adc: meson-saradc: switch from polling to
interrupt mode")
> Reported-by: Elie Roudninski <xademax@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for fixing this!


Martin
