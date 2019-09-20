Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DFE20820
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDPl0GG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfITWDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:03:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41283 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfITWDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:03:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so3466170pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=/EQwbpIsvd1cytDYn0HntBTy9k3TGtcIL0KkXrfCaiQ=;
        b=YDPl0GG4EI8wJoWxtR1nfBaelslT8/kTPV7iNWiqqjHZFPISQDIQWQD016P911qdJQ
         aibMH+xB7INC43BG0DInOi9+0rmKL4zekRRgR+Jc/n8EqKcu9d8kiSxm7tYnV3EuqysS
         6xevhW6w/zrCEkrmond8+1jcLyEjxrtllbKg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=/EQwbpIsvd1cytDYn0HntBTy9k3TGtcIL0KkXrfCaiQ=;
        b=EuGKPtaoeOUE4IP1A2VdhkQ2KEVjAYhNqd5oFbU2HkRza0XS28BguzqZYP7Bn3YsoT
         B4fQf7pJb9xxYZqsk+P7nvwACzBnf+Chp4H1fWzBnyhi+j7HVuU/p2E/VCakVVAAFIVy
         T2cvvBVqbHJbTO+pNKXWg4boIXA4LNk6EBX5y8HryX1EItfxNDfjMlCS8NuS2B9Qt6Fz
         6iLx40c9t0CbhXNUclMJ7IvzFyKyZJxnUiUapbUfk/MwxQj0bs7q/nwg9kp7T5tylhFV
         QnBPcxfWZYtFPh81G+JewowkDSDeegy7tRKs7n9gbDoJSo5bIXcI7u2B7nbW3jFZda2k
         r+1w==
X-Gm-Message-State: APjAAAV0EGxbmmSRSlrGrCj/OzQfu1vwwi0cbRX1Ru6A9z27aSlPQNyh
        V3EHXGjYgOtJn+Bj/VXRhw33qg==
X-Google-Smtp-Source: APXvYqyBgz+MphNZfB4Kvgk3Xd1zPioLjL8mQsK1TqROI5tdB+AxFL4uyLGMg25Kl2Cgn2fDtdeeHA==
X-Received: by 2002:a17:90a:8c89:: with SMTP id b9mr7128649pjo.45.1569017027567;
        Fri, 20 Sep 2019 15:03:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z2sm4706797pfq.58.2019.09.20.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:03:47 -0700 (PDT)
Message-ID: <5d854cc3.1c69fb81.4264c.bab8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org> <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:03:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-09-20 14:52:29)
> Hide the details of how to convert values read from TSENS HW to mCelsius
> behind a function. All versions of the IP can be supported as a result.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Just one nit below.

>  drivers/thermal/qcom/tsens-common.c | 50 +++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index ea2c46cc6a66..6b6b3841c2d0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -310,6 +331,7 @@ int __init init_common(struct tsens_priv *priv)
>                         goto err_put_device;
>                 }
>         }
> +
>         for (i =3D 0, j =3D VALID_0; i < priv->feat->max_sensors; i++, j+=
+) {
>                 priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
>                                                       priv->fields[j]);

Drop this hunk?

