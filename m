Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF08C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63AF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewXY1DQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfENRs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:48:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45468 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:48:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so7282824oie.12;
        Tue, 14 May 2019 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgsTwqqp4QTELA2VQObpORPn+MSwt+1NAVlS7rJZ1DM=;
        b=ewXY1DQNTyonbjv+uTp/T9kh8QUq73Y/yojjn/k8dI5sHJfbFDieQe+sL4QVPoQuBN
         1K4IVk3HQPF5Xur2KlUYUApzaPpx5qQ5pLt/9FMS/f10GwvcepdhPMtXWr+RwfnH3tZD
         eEoQdSlKXwdPMc4Y1zR78QoDyYqWjxFJgAuEnUgkFn+9rhBEnwuUJwzdnGMbS+eDOFWN
         zmYR9xiCmg9RcnXOAm/KBdm9mhUJ8lArU4QOmDepTfTPOCw16hBCppqu4vphtFDX8JqR
         k+BGeZSFdkKzb2PwtxyGo+NUDXZIjNWnQs8o5+p7VrxZ9LJFLS9NQt5B76M5sKKZKewt
         m1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgsTwqqp4QTELA2VQObpORPn+MSwt+1NAVlS7rJZ1DM=;
        b=mEMFPOWMK1khrzhXB6UW5qp/7q4LSU+Ss5gunT+YCBNyJS8RLGnui/IeDlbTGg3EKS
         5mwrYJ41YKveLi6cymv0xfwXwLAieeVypEmnTjLd9DWq+5NCiB6e0qEd5r4CylF3bgqh
         kWurD7hEkmVovA9csGSnxvcYh0j5K8tXzSICxX3F8u6E9mJoco+7Gvs+yBGbk5w3p0ir
         1WIhNg1nso4mOkQZK1nz+a75o37VGzbs2gnflPxGidQW/KFKGnvL6Ub+KBU91Pn3Eha7
         oS8kGVlBo9gPqGZu3V2pMwIpCiABg5580bzZuIPAQ/ISeCWmbOZjhDiZ4mCHRN05bJiq
         RKjA==
X-Gm-Message-State: APjAAAWI8LvXw8xVQQueK881CezmcfTdWL37KOm+UhJItJZJ5D5wV8es
        /mBwPP0XPZMoeAGd1lj5+CU++JM+x8Mz8luRsLQ=
X-Google-Smtp-Source: APXvYqwIlBQE8thnJAT4s73XlbxV7ceTFnF4jCgHAss0Y402uCwVNeNTcBhJBKF3isskLjwDR6meyAZ4ouAt/kG0fR8=
X-Received: by 2002:aca:240d:: with SMTP id n13mr3609989oic.145.1557856105979;
 Tue, 14 May 2019 10:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155911.6C0AC68B05@newverein.lst.de> <20190514160241.9EAC768C7B@newverein.lst.de>
In-Reply-To: <20190514160241.9EAC768C7B@newverein.lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 14 May 2019 10:48:40 -0700
Message-ID: <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:03 AM Torsten Duwe <duwe@lst.de> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> TERES-I has an ANX6345 bridge connected to the RGB666 LCD output, and
> the I2C controlling signals are connected to I2C0 bus.
>
> Enable it in the device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>
> originally: patchwork.kernel.org/patch/10646867
>
> Changed the reset polarity, which is active low,
> according to the (terse) datasheet, Teres-I and pinebook schematics,
> and the confusing parts of the linux driver code (not yet included here).
> Active low -> no more confusion.
>
> ---
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 40 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index c455b24dd079..bc1d0d6c0672 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -72,20 +72,38 @@
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
> +               port {
> +                       anx6345_in: endpoint {
> +                               remote-endpoint = <&tcon0_out_anx6345>;
> +                       };
> +               };

It doesn't comply with bindings document. You need to add out endpoint
as well, and to do so you need to add bindings for eDP connector first
and then implement panel driver.
See Rob's suggestions here: http://patchwork.ozlabs.org/patch/1042593/

> +       };
> +};
> +
> +&mixer0 {
> +       status = "okay";
>  };
>
>  &mmc0 {
> @@ -258,6 +276,20 @@
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
