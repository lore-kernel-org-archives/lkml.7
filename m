Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D132071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTlCJq9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0CZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:25:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35208 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfK0CZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 21:25:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id k196so2308428oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 18:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xC9RVEUN60MRiDoiCowOLH+Vqpm85ZffCJiku49WmOU=;
        b=aTlCJq9kHNPfUA7x56iC66yzyHWWV01ste/kdv/OU2wt7kxCa03HxNWVB7oANK+hTY
         t7vx2q+uAWO5GJan2gg4AWeDnW9t+P8g2GQKcF1C8Oh3KOuqdUk1WXSZhirPEqIVdbps
         kODPMv0tSl6uM81EmJ2k2nwyzt0GfAVkjYARBaBdde9X1f0sp0jovhLMiDY2Afk4MRaY
         2kiGtrlWAk5ZHmTJqqBQnSXsRwHQgDUCVBKRfy/MhtsSA6qA44gLINLvuGNwniwJklHc
         gypbhCS7uSZU4p4z2W6mcX4pM/NUlaHgVNNBqhcHILj3XLsKB9nE7peWPCBnphPHS4s/
         63Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC9RVEUN60MRiDoiCowOLH+Vqpm85ZffCJiku49WmOU=;
        b=ii9vYoGr9C5OajXp0i+K0EZ7pereMSN7qNMq7e6v/QwLBNKqfDCcsgTZG/f6eE+DHM
         ezl+bq8OHAY+KWaQLkARGulcvbQjW2W6QaUDfUum2OltsEXG5AGcJZWUhm1tLsDIANgs
         Fa/7JVj07mUgB4JoLZW6Z+WDOO7qiCOAzfvTkQyfUQvf8NpRJsI4s3RwOcN0Afc1gNRU
         v7rAAzlx0mll6pPE/vapAe5kxG8ACX19ZYZXZh+OQY7P4LB8+MaZmpNRTnGT4k+jW1e2
         luf8qBsA6N6MiQ+q488pENK8dwOehMulC3UMNnKNNjsLXSa3A784Fzv6D//js6XiJQFc
         WRxQ==
X-Gm-Message-State: APjAAAVWfq1BVaJyT9Ko3V8YeHHh32Xr58aKDKFsf2fq0jSeYK+bKxDS
        YajEmfwv/dZS/xkX1MgnjHtyk2s6F5ikOW3UKps=
X-Google-Smtp-Source: APXvYqyQ+qoWokmJpwljroZqf+blVEyS0Tls/wjXa9zQycM+neHHQ0Zehnyeq+CXDZzKQyCm/g4iTieXckglPDt3ux4=
X-Received: by 2002:aca:330a:: with SMTP id z10mr1993629oiz.98.1574821501100;
 Tue, 26 Nov 2019 18:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20191126165529.30703-1-katsuhiro@katsuster.net>
In-Reply-To: <20191126165529.30703-1-katsuhiro@katsuster.net>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 26 Nov 2019 18:24:35 -0800
Message-ID: <CA+E=qVcqu7OJayOdrEXRaWYW1JBhJKk7dPDTEJtCD-hDAKohxg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: split rk3399-rockpro64 for v2 and
 v2.1 boards
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:55 AM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:

Hi Katsuhiro,

> This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
> v2.1 boards.

Thanks for the patch!

> Both v2 and v2.1 boards can use almost same settings but we find a
> difference in I2C address of audio CODEC ES8136.

I'd prefer to avoid moving and renaming dts files since it can cause a
mess if you don't upgrade your bootloader.

Can we use existing rk3399-rockpro64.dts for v2.1 (and change model
name accordingly) and introduce new dts for v2.0?

Regards,
Vasily


> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  3 +-
>  .../dts/rockchip/rk3399-rockpro64-v2.1.dts    | 30 +++++++++++++++++++
>  .../boot/dts/rockchip/rk3399-rockpro64-v2.dts | 30 +++++++++++++++++++
>  ...99-rockpro64.dts => rk3399-rockpro64.dtsi} | 18 -----------
>  4 files changed, 62 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
>  rename arch/arm64/boot/dts/rockchip/{rk3399-rockpro64.dts => rk3399-rockpro64.dtsi} (97%)
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 48fb631d5451..3debaeb517fd 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> -dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
> new file mode 100644
> index 000000000000..9450207bedad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
> + */
> +
> +/dts-v1/;
> +#include "rk3399-rockpro64.dtsi"
> +
> +/ {
> +       model = "Pine64 RockPro64 v2.1";
> +       compatible = "pine64,rockpro64", "rockchip,rk3399";
> +};
> +
> +&i2c1 {
> +       es8316: codec@11 {
> +               compatible = "everest,es8316";
> +               reg = <0x11>;
> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
> +               clock-names = "mclk";
> +               #sound-dai-cells = <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint = <&i2s1_p0_0>;
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
> new file mode 100644
> index 000000000000..7bd37eaa1d57
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
> + */
> +
> +/dts-v1/;
> +#include "rk3399-rockpro64.dtsi"
> +
> +/ {
> +       model = "Pine64 RockPro64 v2";
> +       compatible = "pine64,rockpro64", "rockchip,rk3399";
> +};
> +
> +&i2c1 {
> +       es8316: codec@10 {
> +               compatible = "everest,es8316";
> +               reg = <0x10>;
> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
> +               clock-names = "mclk";
> +               #sound-dai-cells = <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint = <&i2s1_p0_0>;
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> rename to arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 7f4b2eba31d4..183eda4ffb9c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -4,16 +4,12 @@
>   * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
>   */
>
> -/dts-v1/;
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/pwm/pwm.h>
>  #include "rk3399.dtsi"
>  #include "rk3399-opp.dtsi"
>
>  / {
> -       model = "Pine64 RockPro64";
> -       compatible = "pine64,rockpro64", "rockchip,rk3399";
> -
>         chosen {
>                 stdout-path = "serial2:1500000n8";
>         };
> @@ -476,20 +472,6 @@ &i2c1 {
>         i2c-scl-rising-time-ns = <300>;
>         i2c-scl-falling-time-ns = <15>;
>         status = "okay";
> -
> -       es8316: codec@11 {
> -               compatible = "everest,es8316";
> -               reg = <0x11>;
> -               clocks = <&cru SCLK_I2S_8CH_OUT>;
> -               clock-names = "mclk";
> -               #sound-dai-cells = <0>;
> -
> -               port {
> -                       es8316_p0_0: endpoint {
> -                               remote-endpoint = <&i2s1_p0_0>;
> -                       };
> -               };
> -       };
>  };
>
>  &i2c3 {
> --
> 2.24.0
>
