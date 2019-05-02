Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7710C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B137620873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEBHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:41:07 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56209 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfEBHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:41:07 -0400
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 321A3100012;
        Thu,  2 May 2019 07:41:03 +0000 (UTC)
Date:   Thu, 2 May 2019 09:41:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Add
 Bluetooth device node
Message-ID: <20190502074103.vtuxmsl55u3ygyvl@flea>
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
 <1556040365-10913-8-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djstwku7pbrd4t2z"
Content-Disposition: inline
In-Reply-To: <1556040365-10913-8-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djstwku7pbrd4t2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 02:26:04PM -0300, Pablo Greco wrote:
> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
>
> The Bluetooth side is connected to UART3 in a 4 wire configuration. Same
> as the WiFi side, due to being the same chip and package, DLDO1 and
> DLDO2 regulator outputs from the PMIC provide overall power via VBAT and
> I/O power via VDDIO. The CLK_OUT_A clock output from the SoC provides
> the LPO low power clock at 32.768 kHz.
>
> This patch enables Bluetooth on this board, and also adds the missing
> LPO clock on the WiFi side. There is also a PCM connection for
> Bluetooth, but this is not covered here.
>
> The LPO clock is fed from CLK_OUT_A, which needs to be muxed on pin
> PI12. This can be represented in multiple ways. This patch puts the
> pinctrl property in the pin controller node. This is due to limitations
> in Linux, where pinmux settings, even the same one, can not be shared
> by multiple devices. Thus we cannot put it in both the WiFi and
> Bluetooth device nodes. Putting it the CCU node is another option, but
> Linux's CCU driver does not handle pinctrl. Also the pin controller is
> guaranteed to be initialized after the CCU, when clocks are available.
> And any other devices that use muxed pins are guaranteed to be
> initialized after the pin controller. Thus having the CLK_OUT_A pinmux
> reference be in the pin controller node is a good choice without having
> to deal with implementation issues.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> ---
>  arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> index c87f2c0..15c22b0 100644
> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> @@ -96,6 +96,8 @@
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
> +		clocks = <&ccu CLK_OUTA>;
> +		clock-names = "ext_clock";

So if you don't have that patch (that enables bluetooth) the wifi
doesn't work (even though the previous patch is supposed to enable it)
?

>  	};
>  };
>
> @@ -173,6 +175,7 @@
>
>  &pio {
>  	pinctrl-names = "default";
> +	pinctrl-0 = <&clk_out_a_pin>;

This one should bein the previous one as well

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--djstwku7pbrd4t2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqfDwAKCRDj7w1vZxhR
xf1yAP0UUsp41Xj0RtPUCE7G8iW/EOtIede2VKkjSbtSJnpIBwD+PuiABK9pwo3G
FQErru6yLl0Q9pLeQNMdT3ZQ2I3Ubgo=
=xEhS
-----END PGP SIGNATURE-----

--djstwku7pbrd4t2z--
