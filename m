Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B22218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NGUYb0Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCOWGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:06:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42637 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCOWGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:06:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id m4so8573975oim.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jya+9RCRvi8f3hy3KrmXPCNzwRcwhmTgVhI/Vls/16Q=;
        b=NGUYb0YkbIpf3hRAi1SRGukmm/A+bN5U5uuG3mUswPrXLy3P28qsJdtynWFdxG7OE/
         avF9iuZi8hbc61pec+6Vc7tW7m6cnKyf9jJkVnSBqo2K1ltTWWR0f5VYE4PFPTSooJh0
         DIAEMyx591V2Q0CLdlbSY8+MHqVdicF9nXFaRPb2LVah/SBUmtqP1s7eO3AuD3owZBrr
         kF4Kqw9ZsZ8uVn1c/G5t5CHjgBnUnRIF9Y8aRqwlVMj1Sb5nowPNBBYRI2zT9ORo3sBv
         YkFTYw+SAR/u/xOv6gL8cXxX7h2oAqpXCicmqKjMzjoneeSSwYN/FlUIOgcrfzON/qNP
         GsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jya+9RCRvi8f3hy3KrmXPCNzwRcwhmTgVhI/Vls/16Q=;
        b=uNGHXDqEekRCWSJU175sQJXt/cWnCz6a6u2Vxc9aflBYHX9leN9WUBTsTX/CsRI2iz
         M732FvoIdzztOfe2YSqPNwVBWFBj3zEtbfMbRAGNvfGEJS516uj87Yz21AoKow8owEN2
         8Q1RxkrKb+a5cV3cmBo+W9M0XjtbuHEtmDab3YF3Ao7AMReQgwoMuiSfU0lNf6YmK2jJ
         F0fLynet9haKPELG48cCWsZGjoxVHGerbGEah18wBQbJXgYqmsBtCU48wj8e0aQHEK3C
         DUczo5oMmppj2GkDNfwT18qtJMrVPnHnMgVJeH4fp/KViEfOnLEFMg+NEE1v3pKWzRDt
         QtkA==
X-Gm-Message-State: APjAAAWKd4cjdRaZFVAoXFEqwa31BnuJaj87NshYPsVjbRFl36wIxRSg
        zmJVtV8ACHwwYgyMK5RrUeM+/mLOBg4MxQx55+M=
X-Google-Smtp-Source: APXvYqzBkBng+mgCVwsVEk4Jc0ozZbWhjlGZP0JK/J8NS5FxhFERRZkadNAo+0CtRw+f9NycklPUVmQCdUPvFOTlRwQ=
X-Received: by 2002:aca:6209:: with SMTP id w9mr3026660oib.47.1552687565299;
 Fri, 15 Mar 2019 15:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-7-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 23:05:54 +0100
Message-ID: <CAFBinCBEeCAKuzOztT5wU1t9UvY=ocVVrdHB6PNG7pp+gXq1=A@mail.gmail.com>
Subject: Re: [PATCH 06/11] arm64: dts: meson-g12a-x96-max: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil and Guillaume,

On Mon, Mar 11, 2019 at 11:04 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Guillaume La Roque <glaroque@baylibre.com>
>
> Add system regulators for the X96 Max Set-Top-Box.
the hint from the "meson-g12a-sei510: add regulators" patch would be
great here as well:
  Still missing
  * VDD_EE (0.8V - PWM controlled)
  * VDD_CPU(PWM controlled)
  * VDDQ1_5

I'm not sure whether this board also has VDDQ1_5 though, but VDD_EE
and VDD_CPU should be very similar (or even identical)

>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index 0edbd00b358f..21e5de48613e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -21,6 +21,71 @@
>                 device_type = "memory";
>                 reg = <0x0 0x0 0x0 0x40000000>;
>         };
> +
> +       flash_1v8: regulator-flash_1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "FLASH_1V8";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               vin-supply = <&vcc_3v3>;
> +               regulator-always-on;
> +       };
> +
> +       main_12v: regulator-main_12v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "12V";
> +               regulator-min-microvolt = <12000000>;
> +               regulator-max-microvolt = <12000000>;
> +               regulator-always-on;
> +       };
mine has a 5V DC in. can you please check this on your board?


Regards
Martin
