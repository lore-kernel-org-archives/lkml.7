Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5DAECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B062054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJZ9w+VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfJOOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43367 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbfJOOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:51 -0400
Received: by mail-io1-f66.google.com with SMTP id v2so46493344iob.10;
        Tue, 15 Oct 2019 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lR+fhPNWor2rYZMGYZDZtF6Wt6PhWh078oo5smcPWbw=;
        b=MJZ9w+VR4SFMaPZYIna1r3mj3e36YkhvZ1IdOtv8qjqDmJhTXTlqITpoqccq7AwgWW
         NsTWW8ftDTCbwVR5fHTrtYCrjmjd2CtLBp8y1+RicahyIuZGeoONq8nwLSpJ66hZYGNj
         ZbpMNivy5IHSzWONETf1DHvVJO4ZCDG0M10fVpGdt3lyIw7FTGFrn7qxXZ8BgkbFdnOO
         NaAaxE2AOvqlMagIN/pFYvcYwdv7JpKn9t/GwWin5j0yTUtMtx/KY0bUuSfF4Hy6aNnO
         tZVdFU+m2NgFXiQK287gPdv3t4OF4Z9QLOb3BXRVnvHdS1O7mmJsWH0WL4yjRHtaK9sY
         r5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lR+fhPNWor2rYZMGYZDZtF6Wt6PhWh078oo5smcPWbw=;
        b=euTFRlWMsfAd3ilpLFm2yYX9L+MCRXVKL+Xao/4huEa/cjkDPaXX2rS2Nyrry/xPbI
         26Bx82PaVex5MoMjEaKzLrX0f8N48R5E7qDSQ29Ocp5YHBztXTzaITd4U3qdIYf6OZeA
         cJ7hSzIWlV8TQHUW8+zYkN3jPoICkrMdyOtcdmsxffR1i4xU74JY74AjkRhg47K7nIM+
         uByHkiOq6LbWnYq6qLa0fIkW9wDtNKYEsefUPGtqpMNe8lGorKKQPeeKWebWAiiFw9aK
         airHL5WT22BXbndjLLEJ58u32b4pMSeiTbEXyTeaSLQd4fv5sI/m1GQmbNrvnJPJMP6x
         UbRA==
X-Gm-Message-State: APjAAAWUq0KyPUT+ZZy5g4GVPS3AqI//3alMLdEXm6leq619ImxjAwWP
        l4SgjAtuTCnYmxohEqzueVD6cGws74sI29UQMpOdDQ==
X-Google-Smtp-Source: APXvYqy1Ajm+FY69Bd8FosgGeFPehh7/h8rWF2Bp7Qa2VvtQg18WBXbmBLNJGBSkFZNXJ6QtB6gMbldg00EplaHfJ/A=
X-Received: by 2002:a92:6701:: with SMTP id b1mr912513ilc.181.1571151170241;
 Tue, 15 Oct 2019 07:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 15 Oct 2019 23:52:39 +0900
Message-ID: <CA+Ln22HJmVwC1r+SuWG6RgFLCtsG6TPzQK_t8rUtB=SsZ0LyhA@mail.gmail.com>
Subject: Re: [PATCH 01/36] ARM: samsung: make S3C24XX_MISCCR access indirect
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

2019=E5=B9=B410=E6=9C=8811=E6=97=A5(=E9=87=91) 5:30 Arnd Bergmann <arnd@arn=
db.de>:
>
> The clk driver uses both a function call into an exported
> platform file and a direct register access to a hardcoded
> virtual address for accessing the MISCCR register, both
> become are a problem for a multiplatform kernel because
> of the header file dependency.
>
> Make this an indirect function call through platform data
> instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/common.c         |  3 +++
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 10 ++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/commo=
n.c
> index 3dc029c2d2cb..ebf6bde67816 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -667,5 +667,8 @@ struct platform_device s3c2410_device_dclk =3D {
>         .id             =3D 0,
>         .num_resources  =3D ARRAY_SIZE(s3c2410_dclk_resource),
>         .resource       =3D s3c2410_dclk_resource,
> +       .dev            =3D {
> +               .platform_data =3D s3c2410_modify_misccr,

Thanks for the patch!

Just one minor nit: It doesn't look very nice to pass a function
pointer directly as platform data. Could we have a struct defined
instead - with a kerneldoc comment describing the function pointer
field?

Best regards,
Tomasz
