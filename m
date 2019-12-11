Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255AC205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K0vTHkkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfLKJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:47:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34735 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfLKJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:47:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so5750087qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hiyz++TEh319hVLwAB2olZ/3C2yOLqYZVb+XY1KilQk=;
        b=K0vTHkkDqUMjwhEvBZKfN8nWO6Gq+mP3OWCdvbCptx81sFRmyUM0KgerbhqMu3jV9D
         vOopYWXNC+KrffHCt+N2do5gAuACQXozX80hAE5AzkIhp8yq19kVpkwxwihnMXyxPilH
         u/mKaVAIqS9LqgEcOFph1xFHHdxE0IyfHt1M2E4RQKGb3K5iQhR0NkHtFreeEsDqzbGB
         5vyp+u5tbmDt5RdyuaaQHfLg/EVX/zMELgeM4SE1f2qiNEYJ7ek5BZ0DsyFVI1vR0jZY
         J/Rk3VdsWOyVdLRf7hHACSh1EtYjikBIN+QOM24GPj6T/GmjS+bQ2k4yh2AKc3SIEj/w
         PZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hiyz++TEh319hVLwAB2olZ/3C2yOLqYZVb+XY1KilQk=;
        b=WgVdYJb0IKrk6/cCBhE9e67O6uYVD+AEChCgpBnd1LFPNjBCnuhliM3mYYYCe3KfMo
         wlhTUaR0WX3FKGunLpv3UCZAUFQJpd2XpxYomX3cEak2u4FrZs+/wd2NoXYXASeIJcTz
         2X08cPuARYdF0MiA/SNVFWv+DZHtRqrQrMwsjkjN3NPbCbnPGmloJptDAK5dES4mb+/y
         I8+7yxAmMC+OB44f00x4sJ+idDsyQ6AVEMjCdVKsahKku70NP8p1Cifnm1ebEbPR1a/a
         jEAWbBN2UuP9sNnzlt+hLr5fReCeyZFatKtn6e78s2ZAhpuTI1VSBKfTzIpfFgB+81n7
         ifmQ==
X-Gm-Message-State: APjAAAVKRZVupGPrGNjHhSAvg6X/QYdCu6X14AwJQCtrBO278M+LTf2Z
        79PCfjU6h71bHviy92ezzrNMgvkf57BlIv4R9rugDg==
X-Google-Smtp-Source: APXvYqzTlkGWWRR1v92Ypk/ypsdwwJ2TBq+bGc8ObbcQkyfQ4eJv5X5RWRHNQNd/7jZeBOCrj7utzC6q4mjgEwlT/AU=
X-Received: by 2002:ac8:5208:: with SMTP id r8mr1888782qtn.131.1576057642143;
 Wed, 11 Dec 2019 01:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20191209062749.26429-1-vigneshr@ti.com>
In-Reply-To: <20191209062749.26429-1-vigneshr@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:47:11 +0100
Message-ID: <CAMpxmJVLZfvh0p0qpcS+V3Cwuv-mi6o-hO5X-JThj-T_0dOCVw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pca953x: Don't hardcode irq trigger type
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 9 gru 2019 o 07:27 Vignesh Raghavendra <vigneshr@ti.com> napisa=C5=82=
(a):
>
> Don't hardcode irq trigger to IRQF_TRIGGER_LOW while registering IRQ
> handler. IRQ/platform core will take care of setting appropriate trigger
> type.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> v2:
> Drop explicit call to irq_get_trigger_type() as this is take care of in c=
ore
> code.
>
>  drivers/gpio/gpio-pca953x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 6652bee01966..40e48f7d83bb 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -770,8 +770,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chi=
p, int irq_base)
>
>         ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>                                         NULL, pca953x_irq_handler,
> -                                       IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> -                                       IRQF_SHARED,
> +                                       IRQF_ONESHOT | IRQF_SHARED,
>                                         dev_name(&client->dev), chip);
>         if (ret) {
>                 dev_err(&client->dev, "failed to request irq %d\n",
> --
> 2.24.0
>

Patch applied, thanks!

Bartosz
