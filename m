Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3176C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6821897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YLB6RCVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfIALla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 07:41:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIALla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 07:41:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so11172234otp.1;
        Sun, 01 Sep 2019 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+ifEZAzJQwmHDrw7qQ44oHKKTpN0loOr0Zh74/UU5o=;
        b=YLB6RCVgPnAMWngSByRnivbUT7FyzLApPl0dPg5dI1mq4pCGW/khzy3JZBzh4hzSEC
         k6eCa6/JJE47EY6NMtQo280U4nH5vO90SMV2n1E/B9+PexgS5CQleUAqXeUIoYTtr9d4
         i6ip9pXV6xy3l1o/6KhPNaY8TOw3b7/Kb1lUM1Pk0+AK+USpFtd3BQFdOMu6vziSCtB7
         xGB8flqBsf80JGZwXkL1G4ezynHokrH5n14l1PwuAVYMJFUt8XHrqfv7M56/poOG+dfE
         Sid0/29YUrTMvV50/yltifLs5nZPnaj+ubMR5WOyn4mv/CD/ggXZM2ELNQqN8SC4WWyt
         jTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+ifEZAzJQwmHDrw7qQ44oHKKTpN0loOr0Zh74/UU5o=;
        b=Cpx282na/zumcZ1+Pu5dDjmltnqSfwxv7ilStC4UpEH4F2TrfNFmk71K6I7aO2WLMJ
         vLAiwXbjVcck9bXmOHMPfuaffw5RsqHreFh1Sb7nK/CRAfY8DtaMIfjOJ2ZHgS7HexbJ
         oTruVdv3LHI/IT++EvqmykN8gS+5b+ir/ZOrDXVWJXRoizKrjOWOPXtZyT2pMGvhadXt
         7w6Nrvqd9zfVkrjHcR0tZaNMppl5i4FTdtcGL56D+uoBHh8KHGYwmRpAC5Ro9ABfAtCe
         Aoa8kTuL3oJiqYELkY72XZuwg4ab2U/xfbH1JW9V2FKhH6kdNto4QcfLMG2Ro82bNq7Q
         8VZw==
X-Gm-Message-State: APjAAAVZI58ltsV3XRvvqy/EVbX8/fy+YWeOLn9HneAi1PuBgFRMH/ig
        brgApgjPL8KNJCNgRefvBLhYoVy6NnUgb0IM+Lc=
X-Google-Smtp-Source: APXvYqx5j+6QgoQYDILBAc7XTNLaYWT6cuFB2toneCe5Tn0bUMhwPnpLrnv61xMBV8BeutJFkCmQZ0J6X4i0Lph2H9Y=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr9265369otq.6.1567338088855;
 Sun, 01 Sep 2019 04:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-3-linux.amoon@gmail.com>
In-Reply-To: <20190828202723.1145-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 13:41:17 +0200
Message-ID: <CAFBinCBA-sQcshd9iAVn=ZDBKkDN3OgJs-WjKEhVLw===b0AdQ@mail.gmail.com>
Subject: Re: [PATCHv1 2/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to VDDIO_AO3V3 regulator
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per shematics TFLASH_VDD, TF_IO, VCC3V3 fixed regulator output which
typo: "schematics"

> is supplied by VDDIO_AO3V3.
please add a short sentence to the description (since you probably
have to re-send a v2) like:
"While here, move the comment name with the signal name in the
schematics above the gpio property to make it consistent with other
regulators"

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
with the patch rebased (see below) and the two issues from above addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 98e742bf44c1..a078a1ee5004 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -67,17 +67,19 @@
>         };
>
>         tflash_vdd: regulator-tflash_vdd {
> -               /*
> -                * signal name from schematics: TFLASH_VDD_EN
> -                */
>                 compatible = "regulator-fixed";
>
>                 regulator-name = "TFLASH_VDD";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>
> +               /*
> +                * signal name from schematics: TFLASH_VDD_EN
> +                */
>                 gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
> +               /* U16 RT9179GB */
> +               vin-supply = <&vddio_ao3v3>;
>         };
>
>         tf_io: gpio-regulator-tf_io {
> @@ -95,6 +97,8 @@
>
>                 states = <3300000 0
>                           1800000 1>;
> +               /* U12/U13 RT9179GB */
> +               vin-supply = <&vddio_ao3v3>;
>         };
thank you for the patch but I think it won't apply on top of Neil's
"arm64: dts: meson: fix boards regulators states format" (which was
applied just after you sent this series)


Martin
