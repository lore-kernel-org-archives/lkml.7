Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CE720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfDPQ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:58:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35866 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDPQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:58:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so17601371oia.3;
        Tue, 16 Apr 2019 09:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O9UWoKPONz+bYSG+75bKCi216wdgvOgo062zGz4RQY=;
        b=qx7F/ZY+aLxksEEp+TmZIhoE12Hwxfh0oUwP8Gb2iG9IXre9ae8Hl9+wDXYLXpKJl9
         roFL3FupuK5V6bVPbsJRnmvQzri66Z3SKqFzGbsZrKF4gk3UB1LTwAgQE3AefxR3fi8n
         fIcE7uI/3rTgV9BB4ZQ7F8MdZjPRv9HCojI1NUbVhrAZak6N1AstYRsNAo6PMDRJqWbq
         B0hBe8hVXu8an8g1Gg9EcBBKyAnGe14KDpIp7489YAf8MBBGmhxw1mN1cdsn+/ASG/CA
         h9NPMR5e0GoPwDB9tNqYrlWw0Wvhbn+MI+SbzjnGJ0O0auxAnb+ENzGXzf24m9qEEfPY
         h6Eg==
X-Gm-Message-State: APjAAAU2g7JSJLP5yLrUuOD2p1RDCqM8iqIx5OlYl/NcGqOI+I2q9W0j
        xr8Cw9cN//g94hBOPqApWKYehK96
X-Google-Smtp-Source: APXvYqwCyk2MSmArCItUUEXzMboe9a1lQnKsCsb+7B/H+9b5akIvFvLJY4JVAU3OBGzBc3KA3sD6fA==
X-Received: by 2002:aca:310a:: with SMTP id x10mr25043639oix.161.1555433885649;
        Tue, 16 Apr 2019 09:58:05 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id s63sm18944847oif.52.2019.04.16.09.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:58:04 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id x188so17562064oia.13;
        Tue, 16 Apr 2019 09:58:04 -0700 (PDT)
X-Received: by 2002:aca:f1d4:: with SMTP id p203mr25036958oih.154.1555433884418;
 Tue, 16 Apr 2019 09:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190411232315.19588-1-olteanv@gmail.com> <20190411232315.19588-2-olteanv@gmail.com>
In-Reply-To: <20190411232315.19588-2-olteanv@gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 16 Apr 2019 11:57:53 -0500
X-Gmail-Original-Message-ID: <CADRPPNS2kecKh=MXJZafKW1x7wZ2MJh4qng1jdZ=-Pij2nXi2g@mail.gmail.com>
Message-ID: <CADRPPNS2kecKh=MXJZafKW1x7wZ2MJh4qng1jdZ=-Pij2nXi2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: ls1021: Fix SGMII PCS link remaining
 down after PHY disconnect
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, claudiu.manoil@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:28 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
> But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
> are pointing towards the same internal PCS. Therefore nobody is
> controlling the internal PCS of eTSEC0.
>
> Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
> initialization. But upon an ifdown/ifup sequence, the code path from
> ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
> the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
> link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
> failure condition, the PHY driver keeps printing
> '803x_aneg_done: SGMII link is not ok'.
>
> Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR")
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

Thanks,
Leo
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 9 ++++++++-
>  arch/arm/boot/dts/ls1021a.dtsi    | 9 +++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index 97e1fb7ea932..9b1fe99d55b1 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -145,7 +145,7 @@
>  };
>
>  &enet0 {
> -       tbi-handle = <&tbi1>;
> +       tbi-handle = <&tbi0>;
>         phy-handle = <&sgmii_phy2>;
>         phy-connection-type = "sgmii";
>         status = "okay";
> @@ -225,6 +225,13 @@
>         sgmii_phy2: ethernet-phy@2 {
>                 reg = <0x2>;
>         };
> +       tbi0: tbi-phy@1f {
> +               reg = <0x1f>;
> +               device_type = "tbi-phy";
> +       };
> +};
> +
> +&mdio1 {
>         tbi1: tbi-phy@1f {
>                 reg = <0x1f>;
>                 device_type = "tbi-phy";
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 1a2a9509d9c2..89eab1fd1f7f 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -709,6 +709,15 @@
>                               <0x0 0x2d10030 0x0 0x4>;
>                 };
>
> +               mdio1: mdio@2d64000 {
> +                       compatible = "fsl,etsec2-mdio";
> +                       device_type = "mdio";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2d64000 0x0 0x4000>,
> +                             <0x0 0x2d50030 0x0 0x4>;
> +               };
> +
>                 ptp_clock@2d10e00 {
>                         compatible = "fsl,etsec-ptp";
>                         reg = <0x0 0x2d10e00 0x0 0xb0>;
> --
> 2.17.1
>
