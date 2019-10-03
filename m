Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C0C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3332086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GrOKcd2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfJCI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:28:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36070 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJCI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:28:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so1837758oih.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qQG1qX2Fo7mymsvFZqN/2deIwbx2xFuKZ1SF2ngILIs=;
        b=GrOKcd2lYYN9CId0OKndMf+Pm4an+PKLS8N+dIjWg22jo7dp12Sq3GDmcMVZ7CU7oT
         k/xmDPM77AuHTjdYMTn5HGvLwKOOnYrOqhjSMm2tQjraSFmNCnkEvpncEJqzL+QjHuoQ
         qHCdQl+h5OZS4DhOC3HkF5mjC1osJTHAhlSGnVxzfhUqUc0HIzPLHSTskkKRKkJLPnw/
         43QoNAurPNvwzJ2HB8PKJRuG4/JaLDqPS/JFoz2tJ4NyVpgQzpuPBH3SvmP53HYq1aye
         YV4irhChx8QvgGTv+HpkNQnP2Lk+UA2ud/2azy5JUDiwMCIsji4m8hB6s5EfcXJrMRW9
         kWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qQG1qX2Fo7mymsvFZqN/2deIwbx2xFuKZ1SF2ngILIs=;
        b=YwwiEIVH6Sip1fAeOGcMl5ZwdvLSUlKt1g0VNtLnFjhjSLW38YwEJlNWyEmcANQK1M
         DAM4WCyziog91BPV6uIMguJQwC0VCEx3WupHb/lmceX4z7lv2jacilAD7tr3lEVatrvL
         9hG0hDFoHl/AsBQmFQjZhRU+tcm+metNng2enqazhS61YjeuRSQkoK29adAV69129bB4
         JW3RzXemCAnTr3e5mBOnXb461z20kjCQdEHlLhPes1p6OffUEw2Wt2znmjvXzlsuPi/O
         xUmCZ7wRACzEYF0jzQ4+iawhn7ZC9g6k2yqYb0rKUvoF0wRm8ASUaDY+MLbrlRf0Qjix
         Qx1g==
X-Gm-Message-State: APjAAAVRwTOR/XlihGzRL93hzft/7H1lJY1rMB2tqI3xPSg9biPMLNDx
        9UjTTujL3No+S+hsUn2PaKBaF+8n7dLgq384VZhB+Q==
X-Google-Smtp-Source: APXvYqy9YqGTY4OOqbOUV9JhiWoUFw1BE2suz8xvM8zmVI8i/k5zOkaVkzTqsFu8W9c8Cz26Nwlccda3l09vDI6lSbY=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr1949671oih.170.1570091279691;
 Thu, 03 Oct 2019 01:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191002144141.9732-1-j.neuschaefer@gmx.net>
In-Reply-To: <20191002144141.9732-1-j.neuschaefer@gmx.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Oct 2019 10:27:49 +0200
Message-ID: <CAMpxmJU7DZyQ9nJo3wc8T3+J838-MGsOOwE1wLe8SbCfR_xzHQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: driver: Format code blocks properly
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 2 pa=C5=BA 2019 o 16:41 Jonathan Neusch=C3=A4fer <j.neuschaefer@g=
mx.net> napisa=C5=82(a):
>
> This fixes a lot of Sphinx warnings, and makes the code blocks look nice
> in HTML.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/driver-api/gpio/driver.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/dri=
ver-api/gpio/driver.rst
> index 3fdb32422f8a..18dca55eddfd 100644
> --- a/Documentation/driver-api/gpio/driver.rst
> +++ b/Documentation/driver-api/gpio/driver.rst
> @@ -415,6 +415,8 @@ If you do this, the additional irq_chip will be set u=
p by gpiolib at the
>  same time as setting up the rest of the GPIO functionality. The followin=
g
>  is a typical example of a cascaded interrupt handler using gpio_irq_chip=
:
>
> +.. code-block:: c
> +
>    /* Typical state container with dynamic irqchip */
>    struct my_gpio {
>        struct gpio_chip gc;
> @@ -450,6 +452,8 @@ is a typical example of a cascaded interrupt handler =
using gpio_irq_chip:
>  The helper support using hierarchical interrupt controllers as well.
>  In this case the typical set-up will look like this:
>
> +.. code-block:: c
> +
>    /* Typical state container with dynamic irqchip */
>    struct my_gpio {
>        struct gpio_chip gc;
> --
> 2.20.1
>

Applied, thanks!

Bart
