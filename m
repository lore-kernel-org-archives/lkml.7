Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E97520869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wxm2Vrqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDMLd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 07:33:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41339 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDMLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 07:33:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id 64so10625631otb.8;
        Sat, 13 Apr 2019 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNWzVu94jtQ2U8ecDCU7aYXiQ4YbXT+d1pdYft4GMaU=;
        b=Wxm2Vrqa9RDezfjYu2xSEpPLuHl7g9vkTihGAQ1PNm3CA/QWErU8Dll8Z7giuMgR9Y
         wDjBUDN4fytU+Q7NL7GDPqVLAX6MPVKvSJGYYK6Ql0nji+AA7ArEcRp6gL9QO5FWi+OK
         ZfKhQG1OYyEFxf385Q97bGIUAS/wcSY7oz3Bz0TfM3R6BJhnSws5Ru+JkCajxcm8UcQ3
         gEE4b5KZEWnp4LmQLzeDz4saagJ28VCzJCVFigisDmI5awDDVYOb6QHXnttwd34Au61F
         kq+UZ6mwiq82IzsaSr3//H5JCOUW77ikRMBxXYHkEi1RYpFVHSRM54wiJmOokW/GefkQ
         FE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNWzVu94jtQ2U8ecDCU7aYXiQ4YbXT+d1pdYft4GMaU=;
        b=ttbKDbaZ+MDKhMv7rDoHIkYFmeUKWvc7C+oIEPLOijuJOJiZS69GvgUWJBjtQ+X3sF
         ahtEVhgWEjaCL20XfAIVcbawbg2aFdW91J/FfUO2pOkEUzJ9DeteoV/1ZuCsa0SD5Vsn
         5TWI2VktHhqlHj0aZMeczsMMydxpdhLCJMX2omGhEkyZn4NG5ORjWP1lsCYTUQz0YA3O
         UK/Zjba3ZhfNaOVteU88+nHKBH2QNTWQv+qPopZ2jnrqcL2K+ghkKgQEJ79KUaM8mT5z
         dZhyugS8bDtZL1Cj1MuHa1WalUwTUBLbDUbs2d+NITlLGnkl6nCv4uIOv4WDx/4HttNF
         G/xw==
X-Gm-Message-State: APjAAAUPhsdzIua6YQQ1v1Z79oYi9BHu1/bnAeTHW/suzR7RPiYXDIzp
        YWFiUqwYYg+Nf21A1BjGgoHw7AJy41EVDwGoDhI=
X-Google-Smtp-Source: APXvYqycLqfZRrXmYKfVN47QKA7CnpnFkz3yV1BEkokWLGGmAH33/yc+n+pVKvSJPrfooBkH4HIguFa8fasqoYl7mh4=
X-Received: by 2002:a9d:7856:: with SMTP id c22mr18040111otm.261.1555155205236;
 Sat, 13 Apr 2019 04:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190412092337.6941-1-narmstrong@baylibre.com> <20190412092337.6941-3-narmstrong@baylibre.com>
In-Reply-To: <20190412092337.6941-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 13:33:14 +0200
Message-ID: <CAFBinCA3iFSW4K8FJN913CcsxM4YFc2Of9Ldpn7230Ss427mMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pwm: meson: Add clock source configuration for Meson G12A
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Apr 12, 2019 at 11:24 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> For PWM controller in the Meson G12A SoC, the EE domain and AO domain
> have different clock sources. This patch tries to describe them in the
> DT compatible data.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 2b03938039b6..46287cc8a0eb 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -434,6 +434,15 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
>         .num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
>  };
>
> +static const char * const pwm_g12a_ee_parent_names[] = {
> +       "xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
> +};
> +
> +static const struct meson_pwm_data pwm_g12a_ee_data = {
> +       .parent_names = pwm_g12a_ee_parent_names,
> +       .num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>         {
>                 .compatible = "amlogic,meson8b-pwm",
> @@ -455,6 +464,14 @@ static const struct of_device_id meson_pwm_matches[] = {
>                 .compatible = "amlogic,meson-axg-ao-pwm",
>                 .data = &pwm_axg_ao_data
>         },
> +       {
> +               .compatible = "amlogic,meson-g12a-ee-pwm",
> +               .data = &pwm_g12a_ee_data
> +       },
the PWM part is fine for me

> +       {
> +               .compatible = "amlogic,meson-g12a-ao-pwm",
> +               .data = &pwm_axg_ao_data
> +       },
>         {},
but I'm not sure about "amlogic,meson-g12a-ao-pwm":
the public S922X datasheet from Hardkernel [0] section 6.6.1.2 "AO
Clock Tree" (page 107) mentions two different clock sources for the AO
PWMs:
- AO PWM A and B has parents xtal, aoclk81, fclk_div4 and fclk_div5
(pwm_axg_ao_data has the first two parents swapped)
- AO PWM C and D only have xtal and aoclk81 as parents

regarding the clock parents:
I'm not sure whether pwm_axg_ao_data is wrong, G12A is different from
G12B or the G12B datasheet is "correct". can you please list what you
have tested so far and confirm that the parents you are using are
"correct"

regarding the compatible string "amlogic,meson-g12a-ao-pwm":
if there are two different AO PWM modules, should we name it
differently, for example by splitting this compatible string into:
- "amlogic,meson-g12a-ao-pwm-ab" (with parents: xtal, aoclk81,
fclk_div4 and fclk_div5)
- "amlogic,meson-g12a-ao-pwm-cd" (with parents: xtal and aoclk81)


Regards
Martin


[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
