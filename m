Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5404C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959E62166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfqne4S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405914AbfHIIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:25:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37656 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405395AbfHIIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:25:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so37103997ljn.4;
        Fri, 09 Aug 2019 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/A/7y3FwUsdRyRWbpHY31PGn5klTkFuPU5InmeFB5Vk=;
        b=Qfqne4S2i01albbmzKziFOjlp1SXKoDMxp9rmWkJewHFL7gA+G4afjkR78ZqhWYDIQ
         cqd1c0nbWqKdgIsechuMRgIdVV9cQiusELCw/NgSM1kwEVdg4C2SXjO4a/6t7VgZHZM1
         ztT2Ube+FUfbXXynvTQIbRFeSKxOj5+x2InTwF4SSXQJgiwSKeb5hF3R3HQLTubh83d7
         Usj/aimxcOKIVIBM2bAhpz/0P/CY/ABl5DxO3XPh0QqhrUw8PgYY0RN4X4UP3JuIi6ry
         G9FXKdgUw3XgqdPYkXvUGYPk0yEIuKg+aoyOT8ZrU/bQlQBbh9ChDnIbuzM83+w5iUSA
         VaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/A/7y3FwUsdRyRWbpHY31PGn5klTkFuPU5InmeFB5Vk=;
        b=i3FVcmJmfp8emnof/N32G5PDa78hGE9Y/QMeY7Q2LBjEa01UdFQzVEAzy9vdQjCpw8
         3A1rbNgTzr2lKxadCzxC12w3Os6I18rxcL70qAQF4gOzl0CjNMJoG3EwgyKZ0lG+w9Q5
         78NsFvPAFfiG5rKVPOiN67vf4iBngniPLJBOELs/RDgyzbi+Bb9wys1VoubW4q+NMCGL
         04//XxSzM/osDGIztCPaYTv2nYGcMY5qQa9PtgHv8OmwEnsbSreFYzaoZzgEKdP92GtL
         WwR5rm/hGSY+0nNcLMVzOd3GDYuZkJHzVjqbzRKSO3PQzDkHYcd5ElIi5Py4EruUk26n
         1ryQ==
X-Gm-Message-State: APjAAAUK0hgWiwkkbsDPds09lq2PIY6AvHu/V7CHUhHfrlVRHjUEclWd
        uCv/+ulixjhhqt348H5yn/JAkBmRmwJHrdPCnn4=
X-Google-Smtp-Source: APXvYqzRX9Y6GM2LBGO/GzFpFOiYrL7yUSPZ4SglXcKIzN9V37dUNVzUdXfm4el8/ZqkKAylzB4JXgRo2vU6koy4FEA=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr10916932ljj.53.1565339144082;
 Fri, 09 Aug 2019 01:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190806155744.10263-1-megous@megous.com> <20190806155744.10263-5-megous@megous.com>
In-Reply-To: <20190806155744.10263-5-megous@megous.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Fri, 9 Aug 2019 10:25:32 +0200
Message-ID: <CAEKpxBn1nF0t-M34iRSy1yYEuUxgNMUXFBhtjXBY8Qk+43zbDQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v8 4/4] arm64: dts: allwinner: orange-pi-3:
 Enable HDMI output
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 at 17:57, <megous@megous.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> Orange Pi 3 has a DDC_CEC_EN signal connected to PH2, that enables the DDC
> I2C bus voltage shifter. Before EDID can be read, we need to pull PH2 high.
> This is realized by the ddc-en-gpios property.
Great work. Is there any chance you can move this to the
arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi?, as all the H6
based orange-pi's have this feature.
BR,
CK
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index 2c6807b74ff6..01bb1bafe284 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -22,6 +22,18 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       connector {
> +               compatible = "hdmi-connector";
> +               ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
> +               type = "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>
> @@ -72,6 +84,10 @@
>         cpu-supply = <&reg_dcdca>;
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -91,6 +107,16 @@
>         status = "okay";
>  };
>
> +&hdmi {
> +       status = "okay";
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint = <&hdmi_con_in>;
> +       };
> +};
> +
>  &mdio {
>         ext_rgmii_phy: ethernet-phy@1 {
>                 compatible = "ethernet-phy-ieee802.3-c22";
> --
> 2.22.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190806155744.10263-5-megous%40megous.com.
