Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9700C5ED7D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A85247AC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWONLY0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfLMQAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:00:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45563 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfLMQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:00:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so2298757lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6d355onEMaQLbFzGsPL3qOJq28B0iID9uA32I/OH8KY=;
        b=RWONLY0C20iDqzVgHJOMcG0CbIMsarnktxykVv3fzYeDcK6YbJdMcv6KZE7y0BCOlw
         kLoWcGHRdoHmerJ3dVsBoOp4+zwDg69u2Io0/U/CLa1xJvkhFLD8LWAP0muL6aVREdlr
         dq+PsPNZF/el3cTFU9c2TLiU19CHe1GqHUjhb9Ao2Js8Swj/6tWPBA7nCliYmQ2ENqoq
         hV/HLAOs2jFe5nVBnbYC33Yl1pAlomhdJeOm3hDAhsk430Id7SWzriiZyxqxlmZ3qMta
         g9H4lygWNPJQKBKl3RS5+yH5mlJUPdGNspRipjnSbgj5B4PwJcy9sof2EmJsR3mce3dI
         IgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6d355onEMaQLbFzGsPL3qOJq28B0iID9uA32I/OH8KY=;
        b=hA5nFgYNJFmFv9FAyNI3AYwcGUQAEV6DGUw7prmCcqYX5LHe+PoJ6MMle4L0pg4JnM
         QeF+C/VtxRbRvJKgsw7Em41RO74a2ZmmTm/hdvs5IgEShGw6Q4+utYJh/1bZ7AydrNmm
         94iR1+cK47zmOSHB4RKwmLFJvdi6D907/wf6QSGYcvZ3hHuqKRK9RF6UYzDS9vJluYi1
         hz6UlH8WJ75kssQweYBDxnT4QR1k1WC5bOK5e/DwaSz7noIvBLafMMNRXLkdja2tSJEU
         y4pdDMJh7BswYfqXv8Rre2pRXa+3BoRHwR4NOo2Xpy0Ww5dvB3ssZRvl9US5mGjHOc0J
         LWug==
X-Gm-Message-State: APjAAAVoEoIPlqiCPdEHxYzTQTW7bnEMI+pu4ydATvuEylx30jmHaLzA
        kPzgqjX3NsptI9Qghx8vI/mD7KEX1eWDdtS+xGiokg==
X-Google-Smtp-Source: APXvYqyf9tBuza0aFqrtSUyxftprBtALJcGpe4oAZEEePdM+WgDYDegqUpqrrK70d4RPfcTRXsPPG2o1rKeoC2pjSzU=
X-Received: by 2002:a19:c648:: with SMTP id w69mr9309054lff.44.1576252802440;
 Fri, 13 Dec 2019 08:00:02 -0800 (PST)
MIME-Version: 1.0
References: <1576221873-28738-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1576221873-28738-1-git-send-email-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 16:59:50 +0100
Message-ID: <CACRpkdaQZZcaPtDfieGSP9wSow11Xv3K_x89bq=QeYGb2BhpHw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Fix missing OF and GPIOLIB dependency
 on S3C24xx and S3C64xx
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 8:24 AM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:

> All Samsung pinctrl drivers select common part - PINCTRL_SAMSUNG which us=
es
> both OF and GPIOLIB inside.  However only Exynos drivers depend on these,
> therefore after enabling COMPILE_TEST, on x86_64 build of S3C64xx driver
> failed:
>
>     drivers/pinctrl/samsung/pinctrl-samsung.c: In function =E2=80=98samsu=
ng_gpiolib_register=E2=80=99:
>     drivers/pinctrl/samsung/pinctrl-samsung.c:969:5: error: =E2=80=98stru=
ct gpio_chip=E2=80=99 has no member named =E2=80=98of_node=E2=80=99
>        gc->of_node =3D bank->of_node;
>          ^
>
> Rework the dependencies so all Samsung drivers and common
> PINCTRL_SAMSUNG part depend on OF_GPIO (which is default yes if GPIOLIB
> and OF are enabled).
>
> Reported-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

What should this be applied on? It doesn't apply to my fixes
branch which is close to v5.5-rc1. Please rebase and resend
if this was not based on that.

Should this have a Fixes: tag?

Yours,
Linus Walleij
