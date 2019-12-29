Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28999C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F316F207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a1VzCuyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfL2MLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:11:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33394 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2MLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:11:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so27981092qto.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 04:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Swsz46eThB554OL12B4SvWOkGoS/+R66JSDB4haJ7I=;
        b=a1VzCuyJIrzWDfekTgYDphYWZNbw243i/MLUBjA4RW75nZ/QjAaxkxBqSyMcer9re6
         hPSEJsZeECtBhuxWiLOaMFKmCbDyxv/1jax5dZTaVXGgfkODCRVXQOP5agaz7IFcxVme
         farOw3avr6IAM3ouW700k6ArZEbCz5Wy9rR0075KDQzt9YB9yL5Nclv1ts6YlV5Ysja+
         ZH3TfC299wmVcLzts4gM2DWvZYit3792ExKcPgJaIezC3qsIsgSB1AOqeJAka5MD9d4u
         1ZwJl5Go4LCAl99XAEICxjT+5+20vKRRXPNXATz9uCOce/KdObXm3uaPm8d0qP2hpn2J
         9SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Swsz46eThB554OL12B4SvWOkGoS/+R66JSDB4haJ7I=;
        b=bY0leB8w1SJr/9VXWlZWiCd6BR6eyaDenUJJP1WNhY3fOKmiCGVEk9YCS1S1yHSx7q
         VypXv1haTf6SPdFU9y0/OrzPMe6r6zucLC7S1f2X7AAnRnlH5UJveLpDMvvwiSHhn8Dt
         d3V5/35gldV5TcS4NX1eH+TaPWfKQX//e0VRFZFQF13Et3gnOU8nGTQheyPHEwG4IAui
         SJa2Ey8gG2+58rij3434rud4ASUmH+pVZlOEGEusF9SLWm4Mouj9wZNm7cGVoHp29k23
         J7V8xg/3PQISnFCXxrjmWXaZMITvn5pHVvP37CHJXO6mnEHK413p1cMMwaXj5+erM/En
         KKag==
X-Gm-Message-State: APjAAAX5OK6W2VTVNRhGeleGr/SbGKzcuOnhqIOowbcRHvkmy72evJQ+
        wOWo0lvNPtjduZcpJ8XESwcxXT7nNIYiyfErjrvHJg==
X-Google-Smtp-Source: APXvYqxkxqpQ1DMgUjT5WENcmTdvraHnge6qD1OfNQKzD1rjDVvwEKtdhYKdvFR+Dy/KAEKWBawcyXK5jjLTwsB2Nqw=
X-Received: by 2002:ac8:3703:: with SMTP id o3mr44535864qtb.208.1577621509578;
 Sun, 29 Dec 2019 04:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20191229104325.10132-1-tiny.windzz@gmail.com>
In-Reply-To: <20191229104325.10132-1-tiny.windzz@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 29 Dec 2019 13:11:38 +0100
Message-ID: <CAMpxmJUggb7srWeLNzkcrb+L1THhP4DNH8nkkDaYDEs316ywDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: devres: provide devm_ioremap_resource_nocache()
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        suzuki.poulose@arm.com, saravanak@google.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        dan.j.williams@intel.com, Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>, mans@mansr.com,
        Thomas Gleixner <tglx@linutronix.de>, hdegoede@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        ulf.hansson@linaro.org, ztuowen@gmail.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 29 gru 2019 o 11:43 Yangtao Li <tiny.windzz@gmail.com> napisa=C5=82=
(a):
>
> Provide a variant of devm_ioremap_resource() for nocache ioremap.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst |  1 +
>  include/linux/device.h                           |  2 ++
>  lib/devres.c                                     | 15 +++++++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index 13046fcf0a5d..af1b1b9e3a17 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -317,6 +317,7 @@ IOMAP
>    devm_ioremap_uc()
>    devm_ioremap_wc()
>    devm_ioremap_resource() : checks resource, requests memory region, ior=
emaps
> +  devm_ioremap_resource_nocache()
>    devm_ioremap_resource_wc()
>    devm_platform_ioremap_resource() : calls devm_ioremap_resource() for p=
latform device
>    devm_platform_ioremap_resource_wc()
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 96ff76731e93..3aa353aa52e2 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -962,6 +962,8 @@ extern void devm_free_pages(struct device *dev, unsig=
ned long addr);
>
>  void __iomem *devm_ioremap_resource(struct device *dev,
>                                     const struct resource *res);
> +void __iomem *devm_ioremap_resource_nocache(struct device *dev,
> +                                           const struct resource *res);
>  void __iomem *devm_ioremap_resource_wc(struct device *dev,
>                                        const struct resource *res);
>
> diff --git a/lib/devres.c b/lib/devres.c
> index f56070cf970b..a182f8479fbf 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -188,6 +188,21 @@ void __iomem *devm_ioremap_resource(struct device *d=
ev,
>  }
>  EXPORT_SYMBOL(devm_ioremap_resource);
>
> +/**
> + * devm_ioremap_resource_nocache() - nocache variant of
> + *                                   devm_ioremap_resource()
> + * @dev: generic device to handle the resource for
> + * @res: resource to be handled
> + *
> + * Returns a pointer to the remapped memory or an ERR_PTR() encoded erro=
r code
> + * on failure.
> + */
> +void __iomem *devm_ioremap_resource_nocache(struct device *dev,
> +                                           const struct resource *res)
> +{
> +       return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_NC);
> +}
> +
>  /**
>   * devm_ioremap_resource_wc() - write-combined variant of
>   *                             devm_ioremap_resource()
> --
> 2.17.1
>

This has been discussed before. The nocache variants of ioremap() are
being phased out as they're only ever needed on one obscure
architecture IIRC. This is not needed, rather we should convert all
nocache calls to regular ioremap().

Bart
