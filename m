Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E28C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC736206E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PnbjPwcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfL2MMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:12:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36099 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfL2MMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:12:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id q20so27958752qtp.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGWz5AM5inYzBgxg6kj3I2Blj1fXV3aW/S3gsQEojU8=;
        b=PnbjPwcmu+f1M4IjS4OVgxrtUhLIU0Ogt50LaWkc0w8nx6Wn6CElPIGmfX+ZpmHrjo
         UuINDbyroy5Tzj6QxXq2Gtg1lORMAbptUSIHwoRjAEM91mNY7UIG/k38aIyz4YKtKEFU
         y0mQAfT8kU9ZApI5aeUXY043sZTFCH0tuRn4huEH9SsHSReX+SWuEJItypspy4rgaKto
         CSymFzSPsEJe59T5Gazd1umjasT4MHbmN4gqyzKY3c6SNRMWgadQN9vlSg7eZCyarPLy
         97jwANzdunhqmPktKAQRvDTNG2ikJuL6ZSB5VbqnpTjLIAtq+c8s0v+NGZtKXXgy6Li4
         OwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGWz5AM5inYzBgxg6kj3I2Blj1fXV3aW/S3gsQEojU8=;
        b=QpdPmj2gkVIea/MSzdNsPX/XEhYLIjkxv3jPN3g7GIElZ4uEWbhWurkuFMMSy/g9/P
         PUCXfDIOqbh1IGWe+f0wPAn9YW1kwPaW3sgsCXkBJETfu88OdIqHULBNRkwSLcyJbDWP
         5tIDdTUaA+dqrh4UKF9te/Sq0ggUxZ1E5rFqiQmY0ovbPlLwiDlDnolis8kkyN8PecaH
         fK+TEtePaxv4DmzCsoZSfAbohtDdumZ7jgu4YDGBViAw5xJbx7SmId4nxXpXy8O6GMAR
         ec2DfapAo6rF5wfH2I1/DUO07mmOzUdn2movwh55/rnATYXSUsibrFm8mUF+ZjDl+vrp
         Y/3A==
X-Gm-Message-State: APjAAAUikF/AzFoaJA2fa2+YUu80JETHVnaehi28W/AZBquTObmQwsjW
        YJ68+TyWMmXoiHrhHkZIFTMxrVrLiRAuY9K43DAA3w==
X-Google-Smtp-Source: APXvYqxAQYwRbGFcIWe8dI09XkAUHi1OK4gNXwmk+KqpZWY63Vya7Kxw2RZ71yJc4mkiQLhG6IL216Lw+0sekhX+yko=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr43162165qtp.27.1577621535860;
 Sun, 29 Dec 2019 04:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191229104325.10132-1-tiny.windzz@gmail.com> <20191229104325.10132-3-tiny.windzz@gmail.com>
In-Reply-To: <20191229104325.10132-3-tiny.windzz@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 29 Dec 2019 13:12:05 +0100
Message-ID: <CAMpxmJWMjae8vuNA7feLWp1aXte4a3_RTA+C1PoDBkx3EPpO0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: platform: provide devm_platform_ioremap_resource_nocache()
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
> Provide a nocache variant of devm_platform_ioremap_resource().
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../driver-api/driver-model/devres.rst        |  1 +
>  drivers/base/platform.c                       | 19 +++++++++++++++++++
>  include/linux/platform_device.h               |  3 +++
>  3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index af1b1b9e3a17..3b79a3207490 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -320,6 +320,7 @@ IOMAP
>    devm_ioremap_resource_nocache()
>    devm_ioremap_resource_wc()
>    devm_platform_ioremap_resource() : calls devm_ioremap_resource() for p=
latform device
> +  devm_platform_ioremap_resource_nocache()
>    devm_platform_ioremap_resource_wc()
>    devm_platform_ioremap_resource_byname()
>    devm_iounmap()
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index cf6b6b722e5c..80f420b9b4d7 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -79,6 +79,25 @@ void __iomem *devm_platform_ioremap_resource(struct pl=
atform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
>
> +/**
> + * devm_platform_ioremap_resource_nocache - nocache variant of
> + *                                         devm_platform_ioremap_resourc=
e()
> + *
> + * @pdev: platform device to use both for memory resource lookup as well=
 as
> + *        resource management
> + * @index: resource index
> + */
> +void __iomem *
> +devm_platform_ioremap_resource_nocache(struct platform_device *pdev,
> +                                      unsigned int index)
> +{
> +       struct resource *res;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       return devm_ioremap_resource_nocache(&pdev->dev, res);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_nocache);
> +
>  /**
>   * devm_platform_ioremap_resource_wc - write-combined variant of
>   *                                     devm_platform_ioremap_resource()
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 276a03c24691..b803e670b1c5 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -58,6 +58,9 @@ extern void __iomem *
>  devm_platform_ioremap_resource(struct platform_device *pdev,
>                                unsigned int index);
>  extern void __iomem *
> +devm_platform_ioremap_resource_nocache(struct platform_device *pdev,
> +                                      unsigned int index);
> +extern void __iomem *
>  devm_platform_ioremap_resource_wc(struct platform_device *pdev,
>                                   unsigned int index);
>  extern void __iomem *
> --
> 2.17.1
>

Please see my response to patch 1/2.

Bart
