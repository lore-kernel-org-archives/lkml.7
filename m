Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797C207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tslJI5N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfFFHtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:49:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56269 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:49:19 -0400
Received: by mail-it1-f196.google.com with SMTP id i21so1720770ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PcZKwq/QD7LJ9zOMqPBkBZNVNvBl9KD97CXS9sN46Ic=;
        b=tslJI5N8NVUXGgSYyFDm6Rx/IYywuSzoAMmRxkLMt2p+Rkws1bC12MUcQUVV6XICKn
         SeRyYKTpJI6IXFNceW6UkugB5Xzfu12Zxiokks8+oY+44WayWNL/dwu7VK1lozagBJG1
         R0aJaEdXMStztEXMk7SE01TbjnyvkxOADgc0T2Urm4kEc+rX18oH/jov9lzcAIs+Ymop
         rGYhGmC1Uu8GsH5IglOL2e+k4Evdano3zltIFlkQIXs19TswkBXzgdh9ZHl56VM692QH
         sLUNrdb0RD8OaLAvklfwLNop7i2G+mGH+e1xSosTSK13ldsKtrMuaSAkFaHhwLFEUxFJ
         y6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PcZKwq/QD7LJ9zOMqPBkBZNVNvBl9KD97CXS9sN46Ic=;
        b=BCSgEdNS5PjrYiV+Z/ClhNzggnioHi6UDfo7gQE1qsNB7K9GrPP5BRiRLjTK2Iy/vC
         At42EXhY7I14gCFZAwrdTldai4ntMay/AX55lBmQww4frQ8JOfb+cd60fIgB+P/iR94d
         ew8eJkH7shvNmRXVZ8oAZSuCTHWKT06X8DJE454i041opXqGExhpQMcKBLn8mTTAZ+gD
         7c+rkt/xCVmr1CiqLczIUBzM+d6YGF8jHWHOtJQmXL1slcDHX8DGGoSHUuiw0vAZPaTX
         gFzzXkewWIpY5Hvwo0ZeRbAY5f6cIWF7AfhKTC5FLjNH6+x29xoY0RTvYuEY1wmGEwRy
         XkMw==
X-Gm-Message-State: APjAAAWEb37isB45p6QQvDwkIFj34vGPIFRzxMKCKH13o6G4Uum0RanC
        qfHiBWLGeWBNTcxn2CzJgSO8BizbIuC3KNhS3Sj6wQ==
X-Google-Smtp-Source: APXvYqwY1eUY0+k0Cf3njMKrLihozk0MzOpSW1lrQzK1tT6QCcAba90QQwPbH08U+8lE1IIyz4SrsTiB3UnwXw5oF4Y=
X-Received: by 2002:a05:6638:cf:: with SMTP id w15mr9341723jao.136.1559807358196;
 Thu, 06 Jun 2019 00:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-3-j-keerthy@ti.com>
 <CAMpxmJXjMX20TAEsfEa7pqZx5-aW_rMKwS+6g9NTvRNEfuAyeA@mail.gmail.com> <96dbfd50-2a45-e3dc-3928-47fbc52f9269@ti.com>
In-Reply-To: <96dbfd50-2a45-e3dc-3928-47fbc52f9269@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 6 Jun 2019 09:49:07 +0200
Message-ID: <CAMRc=Mfe+K=s4OZp7VWRik7JtSU6Fpufx0yDZtYCMNh5+LSJuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: davinci: Add new compatible for K3 AM654 SoCs
To:     Keerthy <j-keerthy@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>, lokeshvutla@ti.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 5 cze 2019 o 17:12 Keerthy <j-keerthy@ti.com> napisa=C5=82(a):
>
>
>
> On 05/06/19 7:56 PM, Bartosz Golaszewski wrote:
> > =C5=9Br., 5 cze 2019 o 10:02 Keerthy <j-keerthy@ti.com> napisa=C5=82(a)=
:
> >>
> >> Add new compatible for K3 AM654 SoCs.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> ---
> >>   drivers/gpio/gpio-davinci.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> >> index 0977590eb996..fc494a84a29d 100644
> >> --- a/drivers/gpio/gpio-davinci.c
> >> +++ b/drivers/gpio/gpio-davinci.c
> >> @@ -632,6 +632,7 @@ static int davinci_gpio_irq_setup(struct platform_=
device *pdev)
> >>
> >>   static const struct of_device_id davinci_gpio_ids[] =3D {
> >>          { .compatible =3D "ti,keystone-gpio", keystone_gpio_get_irq_c=
hip},
> >> +       { .compatible =3D "ti,am654-gpio", keystone_gpio_get_irq_chip}=
,
> >
> > Please add a patch adding this compatible to the binding document as we=
ll.
>
> https://patchwork.kernel.org/patch/10976445/
>
> Posted but did not add you in Cc. Sorry about that.
>

I don't see it on GPIO patchwork either. Please resend it as part of
this series.

Bart
