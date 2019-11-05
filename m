Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9AC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE93214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCPyYI+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfKETTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:19:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403757AbfKETTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:19:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so7871884plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:from:to:user-agent:date;
        bh=hbU+lnz3PoPpDd5LQBdnFKQTsx0QptkCCfC4Iao/bDw=;
        b=LCPyYI+iiiAIz7UBJ5PzgsIyD7zIA1uqeTHw3tC+72i8g7Cd0+VH7cG+XhA2/7lcB+
         zzQN2EXWfjp3gN86AMcii+zGOnj7ouaZ3RwHLkptQH4xa3Jw8ev6FXa/zKE+0NOh5SK1
         yY+s6T06b17ToJZleH5KhQo/aE/+4rsCtvI94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:from:to
         :user-agent:date;
        bh=hbU+lnz3PoPpDd5LQBdnFKQTsx0QptkCCfC4Iao/bDw=;
        b=ujke4x8KyYNYqvWA1X1LxEae4Foouit44VSlMUD2YNiJBxvXfXdXyG6il+q3Lb48N0
         Sp9OKEWxJnNsqfYRSklgnXPvgtK10aX7wtIOYq3LhvebAg3tfVlK5UCGJoG0SYOW+HRV
         RAlOcxOKL4qKSfV70kAd1Eo+PHUWpuZjM76Wr5stRdSVurkd3cQNoAjKh4cyG+4JyYGI
         E+w0yZ5iv0jI8hnOovdgCq9b/zPe8Ic1dG0aSApUTnFDFP6b34C2XjEEEeopByQMgS22
         5v8UALxgH1ANjfKvmCR0cjQ23RKspSBzmURNwfNAzf5j672K1Yhjdw10/t4AaCXwI5DD
         Iybg==
X-Gm-Message-State: APjAAAWM09HLDTce/EaSXAw2zuC+ejI2MqSKdquUXg4G8VdHiDH5mOoJ
        7pUbtD5JGbcvf7/yF0Dzo1+lkQ==
X-Google-Smtp-Source: APXvYqxKzQO2ljg2ThUedxjlJI/pyjirxn7/sziOiQy2u+ZZNeDvVJNw560Tzryh1Ox/hYTy/FAEow==
X-Received: by 2002:a17:902:102:: with SMTP id 2mr35224735plb.156.1572981581248;
        Tue, 05 Nov 2019 11:19:41 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 39sm198792pjo.7.2019.11.05.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 11:19:40 -0800 (PST)
Message-ID: <5dc1cb4c.1c69fb81.af253.0b8a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1572931309-16250-1-git-send-email-kgunda@codeaurora.org>
References: <1572931309-16250-1-git-send-email-kgunda@codeaurora.org>
Cc:     rnayak@codeaurora.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: Re: [PATCH V2] mfd: qcom-spmi-pmic: Add support for pm6150 and pm6150l
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 05 Nov 2019 11:19:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kiran Gunda (2019-11-04 21:21:49)
> Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
> found on SC7180 based platforms.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  - Changes from V1:
>    Sorted the macros and compatibles.

I don't see anything sorted though.

>=20
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 2 ++
>  drivers/mfd/qcom-spmi-pmic.c                             | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/D=
ocumentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> index 1437062..b5fc64e 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> @@ -32,6 +32,8 @@ Required properties:
>                     "qcom,pm8998",
>                     "qcom,pmi8998",
>                     "qcom,pm8005",
> +                  "qcom,pm6150",
> +                  "qcom,pm6150l",

And this looks badly tabbed or something?

>                     or generalized "qcom,spmi-pmic".
>  - reg:             Specifies the SPMI USID slave address for this device.
>                     For more information see:
> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
> index e8fe705..74b7980 100644
> --- a/drivers/mfd/qcom-spmi-pmic.c
> +++ b/drivers/mfd/qcom-spmi-pmic.c
> @@ -34,6 +34,8 @@
>  #define PM8998_SUBTYPE         0x14
>  #define PMI8998_SUBTYPE                0x15
>  #define PM8005_SUBTYPE         0x18
> +#define PM6150_SUBTYPE         0x28
> +#define PM6150L_SUBTYPE                0x27
> =20
>  static const struct of_device_id pmic_spmi_id_table[] =3D {
>         { .compatible =3D "qcom,spmi-pmic", .data =3D (void *)COMMON_SUBT=
YPE },
> @@ -53,6 +55,8 @@
>         { .compatible =3D "qcom,pm8998",    .data =3D (void *)PM8998_SUBT=
YPE },
>         { .compatible =3D "qcom,pmi8998",   .data =3D (void *)PMI8998_SUB=
TYPE },
>         { .compatible =3D "qcom,pm8005",    .data =3D (void *)PM8005_SUBT=
YPE },
> +       { .compatible =3D "qcom,pm6150",    .data =3D (void *)PM6150_SUBT=
YPE },
> +       { .compatible =3D "qcom,pm6150l",   .data =3D (void *)PM6150L_SUB=
TYPE },
>         { }
>  };
> =20
