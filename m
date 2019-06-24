Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22DB208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O27JYQHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfFXI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:29:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39514 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfFXI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:29:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so12685841otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ko8aLEfz7VyLjGG2Rud4lWnzC784JMvOo3wvqWrCylY=;
        b=O27JYQHjrIVYtYPY96KP6/xDcPJQgEaFAHlXqjg5fywCA5MavXzZsPvV4g/C96xkrp
         u1113gVP75+1RepfG5TcDqwYMHtYYYaUOz8HYL5rsvLX9ka2UI9dPqkCf4WQ/XUqDNrH
         03oTYPII0Gm/Dr9s6Yt9whFrHb1nXUBdx0+kF7k6tC78MXC/Vabo+KZCByPIFoETRLZW
         TufrwEcpb5nF6inzvhBK0f6T9bNDbctr9r2KdzkW/4t/brO134v7819BJWt+wOLVJWTx
         6b63YjzgWyLQ/3WQ6hfZU0RSthxVTZT6H+fI49zO4gZZOOL3zWQRx179ba7Bg1D2TiO7
         1gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ko8aLEfz7VyLjGG2Rud4lWnzC784JMvOo3wvqWrCylY=;
        b=t8Cdopjbvi6ge7fqa5s0aygBHX1tIqrHfs2n9l1wzGquQgoGqwdBk+sXid5rWdQEgY
         JGrQREWl/JuJvX9VGjlC8dHiCKxWwnztnDK4mJxFKs+kb7+l1ENyjTX+mPUtQSIjLIVt
         VnZrT/rwVFlvoXov3zOQ035Pl/HGzNF/QeUNfguUDdj3vcWROZMri4VvenG+Lacg+5WI
         4bpayccXM+TuqDEMq293cOZ2DYJkJTawPF1TmhCrUNvqbrMaK+l0UC8WHKGOuTK8dRvT
         sAfPx51fDGxeqq014R6ey0WZ+ciXHMBfOZjtMyQnLeLDMrLfN70D9WoKPUZJ50f916w8
         OYeg==
X-Gm-Message-State: APjAAAWV4VzugEfAR4KxNd5kPa1PgEa7DCi/CCzv+LxyK2OtNUgHW8tQ
        aauu9AtcI240FqJpclTslfkuM03L1KoTVy0nzD/25OgE
X-Google-Smtp-Source: APXvYqyDMtZ2MXAaR5ez0lNQhMjjgJFRQ44etX1glmyGsTzNbGz2M7BOeIyot5fGBxeHw0eh2LFK1mEXOseX0FkrGCE=
X-Received: by 2002:a9d:7352:: with SMTP id l18mr16004836otk.292.1561364986392;
 Mon, 24 Jun 2019 01:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <9efcbce2-4d49-7197-a3d8-0e83850892d5@web.de>
In-Reply-To: <9efcbce2-4d49-7197-a3d8-0e83850892d5@web.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 24 Jun 2019 10:29:35 +0200
Message-ID: <CAMpxmJX-wXQ-ff1RWkPmJBWSsP_v2MjZrA3fhj3HQX0_zM0eZA@mail.gmail.com>
Subject: Re: [PATCH] drivers: Adjust scope for CONFIG_HAS_IOMEM before devm_platform_ioremap_resource()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 14 cze 2019 o 18:50 Markus Elfring <Markus.Elfring@web.de> napisa=C5=
=82(a):
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 14 Jun 2019 17:45:13 +0200
>
> Move the preprocessor statement =E2=80=9C#ifdef CONFIG_HAS_IOMEM=E2=80=9D=
 so that
> the corresponding scope for conditional compilation includes also comment=
s
> for this function implementation.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/base/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4d1729853d1a..a5f40974a6ef 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -78,6 +78,7 @@ struct resource *platform_get_resource(struct platform_=
device *dev,
>         return NULL;
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
> +#ifdef CONFIG_HAS_IOMEM
>
>  /**
>   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a p=
latform
> @@ -87,7 +88,6 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
>   *        resource management
>   * @index: resource index
>   */
> -#ifdef CONFIG_HAS_IOMEM
>  void __iomem *devm_platform_ioremap_resource(struct platform_device *pde=
v,
>                                              unsigned int index)
>  {
> --
> 2.22.0
>

And what is the purpose of that?

Bart
