Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2051220684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3zjjhJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfDONK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:10:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43248 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDONK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:10:26 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so14432756iol.10;
        Mon, 15 Apr 2019 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3BEBsotfDryLUDef2PzvA8YNpjmE9UBcZeERGUDsjE=;
        b=l3zjjhJw5q5Fe40iN27J6By4aPsgsbvvUTONve+AznHyT9mxuKDagPaBe0u26vfRpe
         kEZu/4da4r+uylzHSO3mMvucbhRXTuIM88pFdQk9hcDyEKVu990XjmMT0WcHv2H+TS/D
         /MrOBlnA53sh4kUEd6DluRkJ1pOrKy+tx517FJLFHHoIDJwaTfxvMDM2LgJ8nn+arHad
         vG9QqDf19rN67cjE89L84nJe6bB+C3AcIXWrKr3EeVkJ3ygUB1pXV0o/oP3K+ENj2/hV
         ftwOznkyt6QTomCTRPLr4h7StJOirzas4jbmU5kHqDjO+uH08UkbnSR9DbU6+3PGArbz
         5sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3BEBsotfDryLUDef2PzvA8YNpjmE9UBcZeERGUDsjE=;
        b=WzXIByc8iY1nhWR2Pw9mnn3cKsAagR4y/+PO4AHadZSsEQxlnQ8y2cRrzPebP3VKJK
         hdxaAp+YLyCpOVm4qDlAV/i0OtOXuO4hH55WJ+4Up8i6sVXkmh+87GJDvNoW+TSX1LQV
         EGF+Tip3E8ACBKwIQBVe1FmwHNg6OHP7J+sZagmKx/EDtmKon7izIOYMEZD8DVVVB9oZ
         e9xMtiwDOs1iddxaQFJO7GLzAKGeQ5IzrQjxwYLGJu1CO16CAnWpXW5ey+yBDHoap9r+
         CzzMaZ4MWAhH9xzR8r0AihC00lm/MnQMjOeDJhhKv2dCWEjeFUELFgy1qnYW8hkgF5ay
         i6xw==
X-Gm-Message-State: APjAAAWOVhSevvaiw6knS/t8NpM67wTdZvE4xclyC/d7N6dDN0bFEkfJ
        7Nm7bukDYWHZpoFQAGJkKePsf5M2UikmmFDUaZY=
X-Google-Smtp-Source: APXvYqw7QzDOjIxCXi/Fz57Z2qhP6VJrG99xHhA0AdjgCrvwQHDEFFbL/qA9z9BOP3osTn+2OmPHNUZR3Sa/TC4LPIU=
X-Received: by 2002:a5d:8918:: with SMTP id b24mr49794108ion.241.1555333825852;
 Mon, 15 Apr 2019 06:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190412134437.14864-1-brgl@bgdev.pl> <20190412134437.14864-5-brgl@bgdev.pl>
In-Reply-To: <20190412134437.14864-5-brgl@bgdev.pl>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 15 Apr 2019 08:10:14 -0500
Message-ID: <CAHCN7xK2BKasMUt-Ytnfw1yewtZePcQhe4PRUQCMG_T8dsVHpQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:44 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> tps6507 pmic with configurable output voltage. By default da850-evm

 It's just a little minor typo, but technically, the PMIC is TPS65070.

> boards support frequencies up to 375MHz so enable this operating
> point.
>
Reviewed-by: Adam Ford <aford173@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index f04bc3e15332..f94bb38fdad9 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -191,6 +191,19 @@
>         };
>  };
>
> +&cpu {
> +       cpu-supply = <&vdcdc3_reg>;
> +};
> +
> +/*
> + * The standard da850-evm kits and SOM's are 375MHz so enable this operating
> + * point by default. Higher frequencies must be enabled for custom boards with
> + * other variants of the SoC.
> + */
> +&opp_375 {
> +       status = "okay";
> +};
> +
>  &sata {
>         status = "okay";
>  };
> --
> 2.21.0
>
