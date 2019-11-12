Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00780C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDCE204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOUp0Sb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLJAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:00:11 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42332 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKLJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:00:09 -0500
Received: by mail-ua1-f67.google.com with SMTP id 31so4465290uas.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mTS09YV5sLbGRhR8eLBR8az5kI+VEtyXkMiASWLN98=;
        b=YOUp0Sb06dRuaudxR7t7caTwSTstbvIIdATOS4cpPVNBtB8mbaIJyxZAurEvSsKwhu
         j6KD9pvfJYz2QJr9Wg8Lkuyx0LEC4wAwEfKx/Oti0eD8qvVCV0JQ6KoTRYOGcEDL6Qp6
         GECThp5a8BbccT0sBfHGbUfvnicncyqsspf6ISAwZ7HYOxZ1EzbF6I5mchGssao0Hv60
         GEltbF2Jfx1T1ZMhrqJwIHFXhSEVlYR9nWi9gL/l/q+lY7n3nZGptVdTOUwpA9LDRqBs
         zcn8s15pCOUOXG2SlncwUP0j8Ql61wdbe1m5siOyJ50PUmu+FxdXenD9CYpRSxaO3bI8
         rV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mTS09YV5sLbGRhR8eLBR8az5kI+VEtyXkMiASWLN98=;
        b=rrJWKLaSgZe3/6DtnCfzRcZKnTMlvPaSkmAtK2I1RA964nA009BTXwv+8rh8qwndaT
         YC9oHSoC8HjA5xnNeQiYx1czf5SdrqTcIJ2U01cVC1gJVZtljZjmma2j/KmFuiIya0rn
         HEDzNPJi+1Y1Ru5SE8NsL/tIh2kN99nrWLRYjZwCJBiBOqBrzI93eJ5WF/526stymKDi
         F2jp8IZ4bNhcgKdCRBtJRksvrHSp34PpsaFekmuXi9Gdxnsvzx4Tuqi93hZUfDlzv//u
         U3YfJgzzQgLrhJqF9cuZNpqkAcNpi61I0+SMNWxZOWck8trSj5Jey2yCkB380iho1fmw
         ok2A==
X-Gm-Message-State: APjAAAVs0aeFGoRXPQa4Oy3OnpFoHM4Hb74+jpPiQ7ikp2SBd/bZDTXW
        DTWQQ4dCmMkiYvB4Tqf4a68RXEfWIJ2EbHPhE9J4Pw==
X-Google-Smtp-Source: APXvYqxabd40sALVZ8OQ7ToAPJNZ/uS9Scd5B48SraEZjMFQA9vGEPI0Qj3t3JkXgO0wuY66RFrxxze3Ex9ZHJlQsok=
X-Received: by 2002:ab0:24ce:: with SMTP id k14mr19253276uan.15.1573549208426;
 Tue, 12 Nov 2019 01:00:08 -0800 (PST)
MIME-Version: 1.0
References: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de>
In-Reply-To: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 09:59:32 +0100
Message-ID: <CAPDyKFqo76wi0-7LQqSXuH3YOUSdTTLySzsxEGkEvZayAPuj6g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add SDR104 mode to SD-card I/F
 on rk3399-roc-pc
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 09:45, Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> Add SDR104 capability and regulators to SD card node.
> While at it, fix a typo in lcd pinctrl and remove two
> undocumented bindings from pmic.
>
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2: Remove always-on from vcc3v0_sd
> ---
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index d1eb55c855b3..a31099f7620b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -135,6 +135,19 @@
>                 vin-supply = <&vcc_1v8>;
>         };
>
> +       vcc3v0_sd: vcc3v0-sd {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vcc3v0_sd_en>;
> +               regulator-name = "vcc3v0_sd";
> +               regulator-boot-on;
> +               regulator-min-microvolt = <3000000>;
> +               regulator-max-microvolt = <3000000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };
> +
>         vcc3v3_sys: vcc3v3-sys {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc3v3_sys";
> @@ -293,8 +306,6 @@
>                 vcc10-supply = <&vcc3v3_sys>;
>                 vcc11-supply = <&vcc3v3_sys>;
>                 vcc12-supply = <&vcc3v3_sys>;
> -               vcc13-supply = <&vcc3v3_sys>;
> -               vcc14-supply = <&vcc3v3_sys>;
>                 vddio-supply = <&vcc_3v0>;
>
>                 regulators {
> @@ -576,7 +587,7 @@
>
>         lcd-panel {
>                 lcd_panel_reset: lcd-panel-reset {
> -                       rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> +                       rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
>                 };
>         };
>
> @@ -602,6 +613,10 @@
>                 vsel2_gpio: vsel2-gpio {
>                         rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
>                 };
> +
> +               pmic_int_l: pmic-int-l {
> +                       rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
>         };
>
>         sdio-pwrseq {
> @@ -610,9 +625,9 @@
>                 };
>         };
>
> -       pmic {
> -               pmic_int_l: pmic-int-l {
> -                       rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +       sdmmc {
> +               vcc3v0_sd_en: vcc3v0-sd-en {
> +                       rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
>         };
>
> @@ -667,6 +682,9 @@
>         cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>         disable-wp;
>         max-frequency = <150000000>;
> +       sd-uhs-sdr104;
> +       vmmc-supply = <&vcc3v0_sd>;
> +       vqmmc-supply = <&vcc_sdio>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>         status = "okay";
> --
> 2.20.1
>
