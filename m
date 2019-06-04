Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E22C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15F2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ0KHhet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFDPJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:09:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39388 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfFDPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:09:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so7380104otq.6;
        Tue, 04 Jun 2019 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKSHYo9ctUMrD0sjylIwNb1es2ByOZKas8LIpRbYBmw=;
        b=iQ0KHhetCVR5IsqwtBICpgv+IF3ki1lApWvboK97GBOeFeF30aJpMMIc+Pv7G75AzY
         fbNFD0cVlFkARgRfffG0B0/ymhuaz58CPbPj1tRw3w/wzMKB/Q9gh9wimCyFPHETfFCB
         dIlApbe6rwG169C0YAk650uTa+EZqQlRNnBrNEBsmKxauoxatj6zeERRwK4njpSkGPQV
         Sda9jJhVREVTr/Wpb2Z+NAAcN0xOxA0sXnrZarbBM3lS0tAqTyWiI86aYo1/4ZcACEZ/
         B6v91CjdXTlpIAC3w9zSbHeDKu1YHNDQILpNAF6OD0np8sOXOnghUlUz0KHM/jlYzvDX
         hhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKSHYo9ctUMrD0sjylIwNb1es2ByOZKas8LIpRbYBmw=;
        b=Js0iqgWnJaiGmMKS33Iq8amWB4kUlypHRK4b/Pl+YMijDaG5Mgj9cxM9opRufVN/0Z
         NnMWBgwpwD5snw6dJwziOGiaotKcbLziOv5ijxJVxL0bmxHVfarFrx6AXcvD4nfb9X+O
         KtfevzfzUzU9IDv5cD3iVsgpwxclp7IUaybqPddve5zUCTNIYocb4GN65QqtahucB8Le
         EnyRn2QaJwxOsEmKyNG+5F4+4feC9/QMQVl4EN8L5Z4Td3z6aZiyoI0FyQsVp/4CWqEQ
         Q1Ck1OSTRJhNgfdjgPVDWlQvew954AGvVTa5VBcyRxP6lDHgvObO6vFA/Ogaoc/3la2A
         sg/w==
X-Gm-Message-State: APjAAAXhb/B8bEf44/k36HtFqyByl6tWsTMtaa3XhIcJd13qPbc45/Rj
        Sq2oyEDy3ZvxGORXmN45evHBUCP3j1GN69U1GPs=
X-Google-Smtp-Source: APXvYqwWBcudZPjaM9b9iqmRFgfE4JacyimajXEuFISTyDx4p3PP+AK36wMIWf9cNbNJe5l9iy35X4ISimTqp7AgU2I=
X-Received: by 2002:a9d:d87:: with SMTP id 7mr5183267ots.263.1559660947275;
 Tue, 04 Jun 2019 08:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190604122150.29D6468B05@newverein.lst.de> <20190604122308.98D4868B20@newverein.lst.de>
In-Reply-To: <20190604122308.98D4868B20@newverein.lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 4 Jun 2019 08:08:40 -0700
Message-ID: <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 5:23 AM Torsten Duwe <duwe@lst.de> wrote:
>
> Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
> the I2C controlling signals are connected to I2C0 bus. eDP output goes
> to an Innolux N116BGE panel.
>
> Enable it in the device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 65 ++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index 0ec46b969a75..a0ad438b037f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -65,6 +65,21 @@
>                 };
>         };
>
> +       panel: panel {
> +               compatible ="innolux,n116bge", "simple-panel";

It's still "simple-panel". I believe I already mentioned that Rob
asked it to be edp-connector.

> +               status = "okay";
> +               power-supply = <&reg_dcdc1>;
> +               backlight = <&backlight>;
> +
> +               ports {
> +                       panel_in: port {
> +                               panel_in_edp: endpoint {
> +                                       remote-endpoint = <&anx6345_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         reg_usb1_vbus: usb1-vbus {
>                 compatible = "regulator-fixed";
>                 regulator-name = "usb1-vbus";
> @@ -81,20 +96,48 @@
>         };
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci1 {
>         status = "okay";
>  };
>
>
> -/* The ANX6345 eDP-bridge is on i2c0. There is no linux (mainline)
> - * driver for this chip at the moment, the bootloader initializes it.
> - * However it can be accessed with the i2c-dev driver from user space.
> - */
>  &i2c0 {
>         clock-frequency = <100000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0_pins>;
>         status = "okay";
> +
> +       anx6345: anx6345@38 {
> +               compatible = "analogix,anx6345";
> +               reg = <0x38>;
> +               reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> +               dvdd25-supply = <&reg_dldo2>;
> +               dvdd12-supply = <&reg_dldo3>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               anx6345_in: endpoint {
> +                                       remote-endpoint = <&tcon0_out_anx6345>;
> +                               };
> +                       };
> +                       port@1 {
> +                               anx6345_out: endpoint {
> +                                       remote-endpoint = <&panel_in_edp>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&mixer0 {
> +       status = "okay";
>  };
>
>  &mmc0 {
> @@ -279,6 +322,20 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&tcon0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&lcd_rgb666_pins>;
> +
> +       status = "okay";
> +};
> +
> +&tcon0_out {
> +       tcon0_out_anx6345: endpoint@0 {
> +               reg = <0>;
> +               remote-endpoint = <&anx6345_in>;
> +       };
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.16.4
>
