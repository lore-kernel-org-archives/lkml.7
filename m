Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA82089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y6srGshK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfECL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:59:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36864 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfECL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:59:05 -0400
Received: by mail-it1-f194.google.com with SMTP id r85so8588545itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDgYOPNAs5a7jn6rrh+mqlUAcW/QL6gqLTt3pqvnNY8=;
        b=Y6srGshKU+8ofVAzr5oXPRlANIBEkdOrCHKBPiE3tUswNgNowbNADcWMckRUE5gkSL
         9ukukehth9mBJJ/QJCpdkUMMW2+iAg10JbBAKpi7BjWy2OQ+HfalsNh4xdNDSsHWnKVY
         6bANvGQZzE11Hw3Y7RiWx/Sk3RaGiUf3o+mJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDgYOPNAs5a7jn6rrh+mqlUAcW/QL6gqLTt3pqvnNY8=;
        b=YLSDOIcbPQ1+VGrrcBiz0nyNrdsHRrJPpqh/GIPksLfUMS722oCVkklzwy0vOQ/ahf
         VGPln1A6mWapnIw7cT5v7JDLh0UXn7zUpy93Kq3xghqvo7eCErNWyjDLCr9p0+OE1Prt
         eVsrV8B768aa+9p8sN01WLP/UBzIWCNEMwQ7A3EJ+W2s9/gvqLJ8idMc8hpuCheRLaeH
         i+8Ym4thsNVw2aZw/nreeACNtCw3xl5MLyD+m8N0dcp4eIXb9rzw9+Em2kVnMvZ7x1se
         8GEGdoSjpqsVew7TlhAx+f7g7kNheo+W3dW1hNoCVR38upSp8BNxl/eWMLm2kFqExNHZ
         kv3w==
X-Gm-Message-State: APjAAAUD5ktpNG8qszDAt2czMgyKHWeeRaMIBrAz+TUHtbH1FE7nLRAw
        h9KUf9wqSf01bBQsMwKnyT7zehmUcEbhMgHoCv1Ung==
X-Google-Smtp-Source: APXvYqxogbylovsed3LC9Wji6QY3Bj1N0GsCs2SPDNY1RvVGOuqXHQj+rfQkbvVmWscSed3alM3kokBhRmxHN3Y8JlY=
X-Received: by 2002:a24:70d5:: with SMTP id f204mr6307014itc.32.1556884744596;
 Fri, 03 May 2019 04:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190413165418.27880-1-megous@megous.com> <20190413165418.27880-6-megous@megous.com>
In-Reply-To: <20190413165418.27880-6-megous@megous.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 3 May 2019 17:28:53 +0530
Message-ID: <CAMty3ZDx6NXyYhQehYT9geeGwAk2PZidiVMwVw1nnZJa3zwyOg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 5/9] arm64: dts: allwinner: orange-pi-3:
 Enable ethernet
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 10:24 PM megous via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> Orange Pi 3 has two regulators that power the Realtek RTL8211E. According
> to the phy datasheet, both regulators need to be enabled at the same time,
> but we can only specify a single phy-supply in the DT.
>
> This can be achieved by making one regulator depedning on the other via
> vin-supply. While it's not a technically correct description of the
> hardware, it achieves the purpose.
>
> All values of RX/TX delay were tested exhaustively and a middle one of the
> working values was chosen.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index 17d496990108..6d6b1f66796d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -15,6 +15,7 @@
>
>         aliases {
>                 serial0 = &uart0;
> +               ethernet0 = &emac;
>         };
>
>         chosen {
> @@ -44,6 +45,27 @@
>                 regulator-max-microvolt = <5000000>;
>                 regulator-always-on;
>         };
> +
> +       /*
> +        * The board uses 2.5V RGMII signalling. Power sequence to enable
> +        * the phy is to enable GMAC-2V5 and GMAC-3V3 (aldo2) power rails
> +        * at the same time and to wait 100ms.
> +        */
> +       reg_gmac_2v5: gmac-2v5 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "gmac-2v5";
> +               regulator-min-microvolt = <2500000>;
> +               regulator-max-microvolt = <2500000>;
> +               startup-delay-us = <100000>;
> +               enable-active-high;
> +               gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> +
> +               /* The real parent of gmac-2v5 is reg_vcc5v, but we need to
> +                * enable two regulators to power the phy. This is one way
> +                * to achieve that.
> +                */
> +               vin-supply = <&reg_aldo2>; /* GMAC-3V3 */

The actual output supply pin name is GMAC-3V which has an input of
VCC3V3-MAC (ie aldo2), if we compatible to schematics better to use
the same, IMHO.
