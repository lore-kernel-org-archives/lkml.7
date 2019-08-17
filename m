Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C7C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C630321019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtMdo8GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQEQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:16:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35789 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQEQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:16:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so4139598pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=TPUXoZ1NzImxZaqU1kQTGHfT7R1dYMoLUZJDIh8RY3c=;
        b=FtMdo8GDJ3dX+F1qXTJgR5de4PkLTpWKO0veMkJvhBhTEynsDmbMKc2OGMGNewk3ms
         M5R2TgpawHavE1X/wdEjHzvtliHNenPpjDNolCVvBlkzntIu+G02//O20UGXImYWYxX5
         Vs7FfUy58cQTQ/NrRG0+IhG2kEMpImgi9xLjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=TPUXoZ1NzImxZaqU1kQTGHfT7R1dYMoLUZJDIh8RY3c=;
        b=VQZEQ8orIIS3gJjthj/zHFJ/aLQjKJN0GH9eaiDEwDh+f5HgwvhaaN14a0vIYxueZn
         nrRtx17RDDFwLPtwBu/+gBjFNiwhgg1ugTzHRcota91IzxqbxO3mTssHBOj50lixln2u
         NiKSsfXZyGRiG8jvDehnvD3AeGtgLEDN5qhcK3WchcRjkFJ0FKNeTE3u1/Sb1wt8i5z3
         rQzpQ/boWzI0ngzPMlkzUe+bQALsDTfVXDHp79GU4WESQVEGfbuGvQ6M0laQclxlpp/G
         AhTz/S8dkVsskmAzbYN59AvOPWYzio7cgAs6ulD6QWKUk14uYDF6Ap+pzIaiPMGeifj+
         Fkcw==
X-Gm-Message-State: APjAAAWdftGkSduv/5TNw3QNESEulqDXBuSv1eUGJzJSQyYOopKPivf/
        TkVTC/inXY1em2EKAzygnC8m7g==
X-Google-Smtp-Source: APXvYqzQiESfEtJrhmlKbanzDv8GArJOzLrYmUJpA1P1xEriqO7kJzBwuZQeyF00hlBCpHARGZBaew==
X-Received: by 2002:a62:1808:: with SMTP id 8mr14129781pfy.177.1566015381746;
        Fri, 16 Aug 2019 21:16:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t9sm7168070pgj.89.2019.08.16.21.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:16:21 -0700 (PDT)
Message-ID: <5d577f95.1c69fb81.6c07e.44da@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07de61a57cf2362169d3b128405d7305eb20785f.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <07de61a57cf2362169d3b128405d7305eb20785f.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 21:16:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:49)
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index 7ab2e740a1da..13a875b99094 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -84,13 +84,35 @@ static inline int code_to_degc(u32 adc_code, const st=
ruct tsens_sensor *s)
>         return degc;
>  }
> =20
> +/**
> + * tsens_hw_to_mC - Return properly sign extended temperature in mCelsiu=
s,

Can you make this proper kernel-doc? Describe the arguments and have a
"Return:" section.

> + * whether in ADC code or deciCelsius depending on IP version.
> + * This function handles the different widths of the signed integer acro=
ss IPs.
> + */
> +static int tsens_hw_to_mC(char *str, struct tsens_sensor *s, int field, =
int temp)
> +{
> +       struct tsens_priv *priv =3D s->priv;
> +       u32 mask;
> +
> +       if (priv->feat->adc) {
> +               /* Convert temperature from ADC code to milliCelsius */
> +               return code_to_degc(temp, s) * 1000;
> +       } else {

Please deindent and drop the else because there's a return above.

> +               mask =3D GENMASK(priv->fields[field].msb,
> +                              priv->fields[field].lsb) >> priv->fields[f=
ield].lsb;

Why is the mask generated, shifted right, sent into fls(), and then
passed to sign_extend32? Shoudln't it be something like=20

	sign_extend32(temp, priv->fields[field].msg - priv->fiels[field].lsb - 1)

> +               dev_dbg(priv->dev, "%s: mask: %d\n", str, fls(mask));
> +               /* Convert temperature from deciCelsius to milliCelsius */
> +               return sign_extend32(temp, fls(mask) - 1) * 100;
> +       }
> +}
> +
> @@ -112,15 +134,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int=
 *temp)
>         if (ret)
>                 return ret;
> =20
> -       if (priv->feat->adc) {
> -               /* Convert temperature from ADC code to milliCelsius */
> -               *temp =3D code_to_degc(last_temp, s) * 1000;
> -       } else {
> -               mask =3D GENMASK(priv->fields[LAST_TEMP_0].msb,
> -                              priv->fields[LAST_TEMP_0].lsb);
> -               /* Convert temperature from deciCelsius to milliCelsius */
> -               *temp =3D sign_extend32(last_temp, fls(mask) - 1) * 100;

Oh the code is copied. Seems really complicated still.

> -       }
> +       *temp =3D tsens_hw_to_mC("get_temp", s, LAST_TEMP_0, last_temp);
