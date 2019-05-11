Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF6C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C52183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DgHUPAmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfEKQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 12:59:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39113 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEKQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 12:59:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so3235136oie.6;
        Sat, 11 May 2019 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjNwRGGXu5Be11Dj6PNdZiF9AujZ6/yOzswhRut3k3E=;
        b=DgHUPAmJmGQ+dEpurEqKvNioA3YxLnpoA37tONehwHuP65leqdysmLbUDtIVuDPnV+
         /rKEtvsIggCPV9P340NPO7WVHDmAYR9ebJKs8p0z3XA/Vvg94hzbCGyTtLq6dKEH0pan
         TehO7d3/jnEBgJtOjuzBYXC9ael97lD7vbSxEPcl+Q4lmoSwWGbllPFmRQdBz/oOz2L/
         8hUdNDDEwZIzI7y3psCMRKXTudT/SMAU3Bh+QkY8XBV1DNRm0zeFfGjZoHzsHp16CyZq
         2BFoqXmx8athQtcyMnV7eflqhuJLey63r3xa9yeShJ1Goud4W0K8FEbqsUzBYzwpiQXD
         5GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjNwRGGXu5Be11Dj6PNdZiF9AujZ6/yOzswhRut3k3E=;
        b=L/wBtrlH+1KkjLyJkIiK0Gl991p38I2UpuGek0/oCz/FQxx0G/xM1dRMJCWWbaJGKd
         NXOrsV0RKiVGq7qSVnD2r+5+vi2+lTPkz5j3MsE2rFpDEnA4xBB+1Czefot4FG7/CKwM
         2CQwBj5/kyHgEybP85HEfJuBcF0/T9ccODQQyh8D82/7RwLxcluy23uDOznwqA6xgEP2
         hhxX5vsiEj/i0V3GMdK/ttQ7xHHB4cV13OYtIsY231PYpkK+sHnHIhivK3ygIDN8fhxC
         5td7zrXSPsRLDn2bNxyO2SuNrOuOqHxe+X+PhGk+bKgVACTZKOfQGq51Qho8lHw74JJ3
         LSEw==
X-Gm-Message-State: APjAAAWxmfTjgHyV4isjGkRm5hNMGDRmtCJ3GNvbH37rBA/jq++GBmS3
        xqHVAZjhYt8DAoLIJYILF7SYBEBxo6+JxtNlZZc=
X-Google-Smtp-Source: APXvYqzkb2QhTyKOWMd6vfKBBm2PRJcPYttvl8GjcF3VU3IR8IZjzLtUHA8an8Ofwc8+A0v3fHlp3ise5fiwKThwlLA=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr8777744oif.47.1557593998010;
 Sat, 11 May 2019 09:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-4-jbrunet@baylibre.com>
In-Reply-To: <20190510164940.13496-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 May 2019 18:59:47 +0200
Message-ID: <CAFBinCAe3jd598MPLUGFEoBAOaeXovSz7_8Kn7ZMmSFvRLFSXg@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: meson: g12a: add mdio multiplexer
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, May 10, 2019 at 6:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the g12a mdio multiplexer which allows to connect to either
> an external phy through the SoC pins or the internal 10/100 phy
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index fe0f73730525..6e9587aafb5d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -460,6 +460,38 @@
>                                 assigned-clock-rates = <100000000>;
>                                 #phy-cells = <1>;
>                         };
> +
> +                       eth_phy: mdio-multiplexer@4c000 {
> +                               compatible = "amlogic,g12a-mdio-mux";
> +                               reg = <0x0 0x4c000 0x0 0xa4>;
> +                               clocks = <&clkc CLKID_ETH_PHY>,
> +                                        <&xtal>,
> +                                        <&clkc CLKID_MPLL_5OM>;
I haven't noticed that before but there's a typo in the MPLL_5OM clock
definition:
the O (capital o) should be a 0 (zero).
can you fix this typo in an additional clock patch for v5.2 - then we
don't have to do it in v5.3 where this .dtsi might already use it

> +                               clock-names = "pclk", "clkin0", "clkin1";
> +                               mdio-parent-bus = <&mdio0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               ext_mdio: mdio@0 {
> +                                       reg = <0>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                               };
> +
> +                               int_mdio: mdio@1 {
> +                                       reg = <1>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       internal_ephy: ethernet_phy@8 {
> +                                               compatible = "ethernet-phy-id0180.3301",
> +                                                            "ethernet-phy-ieee802.3-c22";
please drop the compatible string and replace it with a comment (if
you feel that it's needed).
quote from Documentation/devicetree/bindings/net/phy.txt:
> If the PHY reports an incorrect ID (or none at all) then the
> "compatible" list may contain an entry with the correct PHY ID in the
> form: "ethernet-phy-idAAAA.BBBB"

I am going to send a patch for other Amlogic boards to remove any
ethernet-phy-id comaptible string


Regards
Martin
