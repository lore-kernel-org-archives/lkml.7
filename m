Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B50C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4A2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLIJ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:27:37 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42046 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfLIJ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:27:37 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieFKD-0007vX-2a; Mon, 09 Dec 2019 10:27:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        kishon@ti.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bivvy.bi@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: drop #clock-cells from rockchip,px30-dsi-dphy
Date:   Mon, 09 Dec 2019 10:27:28 +0100
Message-ID: <2785558.xRCxUMSmLi@diego>
In-Reply-To: <20191108000640.8775-1-heiko.stuebner@theobroma-systems.com>
References: <20191108000640.8775-1-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Am Freitag, 8. November 2019, 01:06:39 CET schrieb Heiko Stuebner:
> Further review of the dsi components for the px30 revealed that the
> phy shouldn't expose the pll as clock but instead handle settings
> via phy parameters.
> 
> As the phy binding is new and not used anywhere yet, just drop them
> so they don't get used.
> 
> Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
> Hi Kishon,
> 
> this should ideally get into 5.5 as a fix for the previous change
> so that the binding doesn't accidentially get used.

Could you take a look at these 2 changes for the newly added dsi-phy
for some Rockchip SoCs? From a dt-binding-hardliner standpoint, it should
ideally get fixed in 5.5, so that the (wrong) binding doesn't get released
with a full kernel release.

But as it is very much Rockchip-specific and doesn't touch other part,
5.6 would also be ok I guess ;-)


Thanks
Heiko

>  .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> index bb0da87bcd84..476c56a1dc8c 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> @@ -13,9 +13,6 @@ properties:
>    "#phy-cells":
>      const: 0
>  
> -  "#clock-cells":
> -    const: 0
> -
>    compatible:
>      enum:
>        - rockchip,px30-dsi-dphy
> @@ -49,7 +46,6 @@ properties:
>  
>  required:
>    - "#phy-cells"
> -  - "#clock-cells"
>    - compatible
>    - reg
>    - clocks
> @@ -66,7 +62,6 @@ examples:
>          reg = <0x0 0xff2e0000 0x0 0x10000>;
>          clocks = <&pmucru 13>, <&cru 12>;
>          clock-names = "ref", "pclk";
> -        #clock-cells = <0>;
>          resets = <&cru 12>;
>          reset-names = "apb";
>          #phy-cells = <0>;
> 




