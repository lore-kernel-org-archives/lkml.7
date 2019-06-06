Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C618C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0928320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkbxgUrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfFFXc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:32:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43503 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFXc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:32:57 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so1762ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0A3A4PZm4/qsXsHFur2v9UHOlrbEBQyk4vcKPIBFw0=;
        b=fkbxgUrEv8PfhTy3wvjiFFp1EImbq7M90vH3PXzj1KqC9QVgYow75jLTgKOq3FfxOL
         ZUcYMofKM9SzoTgEA4dphTznhi2DKKtXgfDNcaq0CjU9oVG3wuL1B/toPbhiZNpICNSa
         po1KErA7hXKSYO31giKbUpqEV3GmbqFoGEnmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0A3A4PZm4/qsXsHFur2v9UHOlrbEBQyk4vcKPIBFw0=;
        b=EeKn4sl89dJTFmbiMTAs2Lx0Em0FNTLAZnZ5oIkl/Nt+2lFyAHiUTzMDXUFLl0CuzI
         B/57kgwj3DxXUZ4gf9Q/VG97vEGjhxp0i/B8OZS/VKAF759eIAQYaEdOGAOqEH+TsrUm
         tzSl8vnK/Jwd/myZvK9F9+pxxgWlq3k9uPbWiMN5K2tKOEBTtf5GIDCjI+fPoXW/xT9P
         gy1xsO0DMOxdWJV9FLy14Oa06PF40hMIcgrduXXcbwtPuj5cseAf3cgU68W35pZ8yXCg
         2GhEi274E8NB3N/UWbLWQ6GJnvwNkYfL/iq/O3+4ql9UZraWyTcIvA3MsgZadtlOjlm+
         s6qQ==
X-Gm-Message-State: APjAAAUpkHwxaTH9ru8OBdliC5YIneAdr6nE3C+ZtdjPOQpxVSmrnGsU
        o3GJwCDrsMmMocj+17Iy3P9zOtWUNfs=
X-Google-Smtp-Source: APXvYqxndvzYlkw2SP4GCUDCFU5lOPtlA9OoTpCR7DBfJE6LebLkO3Zs1ia6fNFS8Q+hU1NfYSvgsg==
X-Received: by 2002:a5e:a606:: with SMTP id q6mr22658677ioi.82.1559863976788;
        Thu, 06 Jun 2019 16:32:56 -0700 (PDT)
Received: from mail-it1-f176.google.com (mail-it1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id z202sm162607itb.2.2019.06.06.16.32.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 16:32:55 -0700 (PDT)
Received: by mail-it1-f176.google.com with SMTP id n189so92768itd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 16:32:55 -0700 (PDT)
X-Received: by 2002:a02:9143:: with SMTP id b3mr9665780jag.12.1559863975142;
 Thu, 06 Jun 2019 16:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190605204320.22343-1-mka@chromium.org> <20190605204320.22343-2-mka@chromium.org>
In-Reply-To: <20190605204320.22343-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jun 2019 16:32:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnjRPokOp+DH5H04Ej=TSxKDeDWhbbJt46b6cVFnOosQ@mail.gmail.com>
Message-ID: <CAD=FV=VnjRPokOp+DH5H04Ej=TSxKDeDWhbbJt46b6cVFnOosQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up
 signal on veyron
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 5, 2019 at 1:43 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> This enables wake up on Bluetooth activity when the device is
> suspended. The BT_HOST_WAKE signal is only connected on devices
> with BT module that are connected through UART.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index cc4c3595f145..145cac7c0847 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -23,6 +23,31 @@
>                 reg = <0x0 0x0 0x0 0x80000000>;
>         };
>
> +       bt_activity: bt-activity {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&bt_host_wake>;
> +
> +               /*
> +                * HACK: until we have an LPM driver, we'll use an
> +                * ugly GPIO key to allow Bluetooth to wake from S3.
> +                * This is expected to only be used by BT modules that
> +                * use UART for comms.  For BT modules that talk over
> +                * SDIO we should use a wakeup mechanism related to SDIO.
> +                *
> +                * Use KEY_RESERVED here since that will work as a wakeup but
> +                * doesn't get reported to higher levels (so doesn't confuse
> +                * Chrome).
> +                */
> +               bt-wake {
> +                       label = "BT Wakeup";
> +                       gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +                       linux,code = <KEY_RESERVED>;
> +                       wakeup-source;
> +               };
> +
> +       };
> +
>         power_button: power-button {
>                 compatible = "gpio-keys";
>                 pinctrl-names = "default";
> @@ -555,6 +580,10 @@
>                         rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
>
> +               bt_host_wake: bt-host-wake {
> +                       rockchip,pins = <4 31 RK_FUNC_GPIO &pcfg_pull_down>;

nit: s/31/RK_PD7

Other than that, feel free to add my Reviewed-by assuming that this
isn't too hacky for mainline to accept while we wait for someone to
come up with a better solution.

-Doug
