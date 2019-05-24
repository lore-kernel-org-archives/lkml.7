Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA97C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF0920879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+X9xSnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfEXJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:17:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33301 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389515AbfEXJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:17:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id x132so6605125lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MQNAZ2qpcerEvwA34HiaREcIaqtFT4giJ0gziFwgnU4=;
        b=J+X9xSnl4BIQvSLLO+SvCj3CZv19Aw7rcBirRTZtbNQGrSoMiAZ+QeWRmpfTLvK5SI
         nF+TkOmYoyoh5yZCyPXqKdtISy8OLwnbnfXPpIEszISmeTAsoHsGqxxsCHlLyQk2FUxE
         ncWjZgFlgNwVK8JqW6QZzRqdAzfSysYBShcPS2EUpT7Z7WcPZvjaNJ92KsJUQa6dL/es
         aEMhKW1JdXsBn2Zqf7oASyAc9NIhwFZlFRHysgZCK2XqHx9mKXjlqFn805pTbseKSSOd
         62za/mG/T+kxlbn0jgxGV1j5a34Z5puz1doKDlmMn7/6PtPpTNP/ozR/+bS60hlVLnbu
         GhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MQNAZ2qpcerEvwA34HiaREcIaqtFT4giJ0gziFwgnU4=;
        b=DmW10dfPzxbdNsfeDGSs+UEOJWSanTCd3ajg46ibFf7wKx0UqGvP8CKF4RKB0R/vqi
         OWTMSvxoACnLU6XUFrOE+gjfkJOw3RDUu6xpa69hk3vNsT/Ta9i58quwWAlRG4KdecLl
         hn8oYCL/TTW8EL0yoFmbs7GqATenb3pwMRQV1m0PXglUKn52UUHTPRvdtbfqpoYwNKvP
         Vs/jyVjevNy4JGd4bGQ5vAnoYzfL1ZF98yc0wrlraRTyedHSDsKhcsqMemadmMffjs9z
         4Xa6ZCntSR6mLxjbEiYIqFLMuFECrNenSZBR4QirwsosnZczT5wqXd067it6AyeAA34o
         MKKg==
X-Gm-Message-State: APjAAAUOnwOHea3q/sr8sdbCnYz2i6ErnhiAVTLhWxQ4j5QPoRM8yf54
        fD9+4gT1ADKMMNVSqVWW87gDxxLeWqFzjMAwO//s1Q==
X-Google-Smtp-Source: APXvYqwhFZnoWeef1nj+ibv3/z3Wdour3IMfS4Mk2lrPJTMx/qF2SwhC16rn6xiFF+4gJffu8ObxgV8//sWIKgFDgkQ=
X-Received: by 2002:ac2:4919:: with SMTP id n25mr4948262lfi.114.1558689433090;
 Fri, 24 May 2019 02:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <8054bec0-ea24-8590-738b-bae58c0be3b4@infradead.org>
In-Reply-To: <8054bec0-ea24-8590-738b-bae58c0be3b4@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 11:17:00 +0200
Message-ID: <CACRpkdahhJbvZw+2eQr3hFxYED94f42maOnmVKVhB6mSEKUkVw@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix gpio-adp5588 build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:00 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> The gpio-adp5588 driver uses interfaces that are provided by
> GPIOLIB_IRQCHIP, so select that symbol in its Kconfig entry.
>
> Fixes these build errors:
>
> ../drivers/gpio/gpio-adp5588.c: In function =E2=80=98adp5588_irq_handler=
=E2=80=99:
> ../drivers/gpio/gpio-adp5588.c:266:26: error: =E2=80=98struct gpio_chip=
=E2=80=99 has no member named =E2=80=98irq=E2=80=99
>             dev->gpio_chip.irq.domain, gpio));
>                           ^
> ../drivers/gpio/gpio-adp5588.c: In function =E2=80=98adp5588_irq_setup=E2=
=80=99:
> ../drivers/gpio/gpio-adp5588.c:298:2: error: implicit declaration of func=
tion =E2=80=98gpiochip_irqchip_add_nested=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
>   ret =3D gpiochip_irqchip_add_nested(&dev->gpio_chip,
>   ^
> ../drivers/gpio/gpio-adp5588.c:307:2: error: implicit declaration of func=
tion =E2=80=98gpiochip_set_nested_irqchip=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
>   gpiochip_set_nested_irqchip(&dev->gpio_chip,
>   ^
>
> Fixes: 459773ae8dbb ("gpio: adp5588-gpio: support interrupt controller")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org

Patch applied for fixes.

Yours,
Linus Walleij
