Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA2C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A95D2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="u8zchJDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbfETRhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:37:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41475 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389971AbfETRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:37:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so10622282oia.8;
        Mon, 20 May 2019 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Byof9QMyRlXAVRlao9zpR9wxkvesAP37VT+Jt615gkI=;
        b=u8zchJDskvrP7jFMiyYauwOOdtCHZzj1r5rVC2jUd9LSRQmQgxFenyHft5HTH3rb6n
         SEL3IbDUY+55egOzikEtDiXQh8VSv5oqAc8C3afREBl1l9hm74ezxh06oVgW9/zLxxyX
         u+mEJkxVGg2mSDUlxDKIy4FFCf1MMzbZ+XHQKOEEidFY4vLhlApfA6nmwgXbhDq67bA2
         4VlLxGLhOHtix0qPAWOUUjlZw77Me5UptKeNYyG2oWIZsMjwoUrpMP9jZarnPRaQjHSV
         v1l5Bh7Xy0jh83KaWyYU1MYukc4WmB+wLYB71akSMNTYpNqbJy9xapAm5bEGIh0bn/m8
         0+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Byof9QMyRlXAVRlao9zpR9wxkvesAP37VT+Jt615gkI=;
        b=HsTYhgE+WJj6rhCzaBGOLmHBBG89iyba9vXvjkv/TXhmYYW97R+LuhJv4YGvp/Pem2
         zzlCaL4BfHXbilQv0vFrYVV5MPqP8ZHxVSJhglDfiGUGI9cn3khdC//8Gf4XCjxUXh2g
         aDyko2/b+8+MSJuKK9dLmgD0YqbZQWINqAPVBp6nLa7VR21fxy9vrWwjPgo/2YR+Pevg
         lZHQvuAnZkqIO2u/h2cnVwxolnPBQiulb+r7PyDUClQ9Cwtl3VlrDzJ2OPpiLkZ7PIpG
         JuTDWaWs6AinSuWMI3pmv/GP8LRckhx37HS8xDmdLyfsBSk2j1jvpDychlwqUMMKi1yk
         g3Cg==
X-Gm-Message-State: APjAAAUcjFx5GImYPC57+BuqE7ciZCaYU9sW3oKtca5gT7zzfb3gwFE8
        +XLjekCVM1BCpUMUBR6WH2eA1sRd6xV+F3fwbVc=
X-Google-Smtp-Source: APXvYqw/zO6zSTi7ReX5SAMdwUjkDfPLA+p+nLQgWrhqenyVH+hGrdhdWvJSJQ3ReYvIxP+VsOEJm+jxqFCcXuLP1q8=
X-Received: by 2002:aca:4341:: with SMTP id q62mr257982oia.140.1558373866454;
 Mon, 20 May 2019 10:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-4-jbrunet@baylibre.com>
In-Reply-To: <20190520131401.11804-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:37:35 +0200
Message-ID: <CAFBinCA_XE86eqCMpEFc3xMZDH8J7wVQPRj7bFZyqDxQx-w-qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: meson: g12a: add mdio multiplexer
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, May 20, 2019 at 3:14 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the g12a mdio multiplexer which allows to connect to either
> an external phy through the SoC pins or the internal 10/100 phy
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index def02ebf6501..90da7cc81681 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -1698,6 +1698,38 @@
>                                 assigned-clock-rates = <100000000>;
>                                 #phy-cells = <1>;
>                         };
> +
> +                       eth_phy: mdio-multiplexer@4c000 {
> +                               compatible = "amlogic,g12a-mdio-mux";
> +                               reg = <0x0 0x4c000 0x0 0xa4>;
> +                               clocks = <&clkc CLKID_ETH_PHY>,
> +                                        <&xtal>,
> +                                        <&clkc CLKID_MPLL_50M>;
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
Based on your comment on v1 of this patch [0] the Ethernet PHY ID is
defined by this "mdio-multiplexer" (write arbitrary value to a
register then that's the PHY ID which will show up on the bus)
I'm fine with explicitly listing the ID which the PHY driver binds to
because I don't know a better way.

+Cc Andrew, Florian and Heiner because I think they should be aware of
such cases (it seems like a special case to me).


Martin


[0] https://patchwork.kernel.org/patch/10939255/
