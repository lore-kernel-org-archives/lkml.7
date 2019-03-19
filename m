Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5322520989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KN3eCPkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcFJkauk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCSCBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:01:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57439 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbfCSCBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:01:33 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 22:01:32 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 64CE338A4;
        Mon, 18 Mar 2019 21:55:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Mar 2019 21:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=B
        dDMfLWon0gS70GFcawr94/BS88oRVvld76WOiH0fJs=; b=KN3eCPkqC44UDThXA
        tcAp6NleE/orGFdkADfKnfVzgQcNQ7Wz94FnGp590cfqwv56aUYD35JNVGB5piQD
        NQ9OuM3ZmFT3biK65LMHhalHrGcGALIkcH+bCcUGyDTOhfixj80+QejcEFj03i1w
        hqnkODpHqDIvGOeyP9gUeYLUMsFxwqIc2tePyO6mZI3GTgisI33E2CaC0hMNninU
        /grY5gX4TZlcVAD9UTG6DrdwySxxFW6E9Elr/z+qJUH8mPxdcUBFHRdKtrHcMCVo
        vqJV4T8J93wv5POUV5rsgeJyALnebcnhCjBWp1ZMJQ040GHE9CPiNjVWbvL9RDIL
        CCb2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=BdDMfLWon0gS70GFcawr94/BS88oRVvld76WOiH0f
        Js=; b=PcFJkaukoF1yKTiVmFBHKvQpVQlpREQNABHiCzdgymwlsrzfpmK7e5aUE
        UReiNWZk9P3uZ3nTGWohMpfCcjqgiUOXRF5WN62peua+4rBrQioIIUvMPHT4C9W0
        iSmLwayMHnWp75T/W7MbUPNuQcuGyzCpFx37rIpfX3K2r837CSnxn5SaVHuoHRyd
        kSp9BAPQS9+pFy9dEM0dOU0rzKOGVse3i4nRjrE8puCxcXHcMHnkLDKz23K6clr7
        TpbAN2KamPwoNlJ3t924+0JMWFKAQ1bmK/BvsFYVka4tK+S2zrc25vkzipSTG1fo
        OZ7nskbNObnHKyHoexzWlALzwUueA==
X-ME-Sender: <xms:-UuQXOh_e6L-HMlk_aCpZ1cA0IiMIaSoaUUt0LEHYwDQqblLqfQwgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrieefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-UuQXOEOcVnNfWGFWd-XuAS-vfJEtvA9zhLkbvJgN4E9uGNM0Vrnhg>
    <xmx:-UuQXDmNkaQPnN4XGhogN-Imln7mSMK2fzc9A1pTuKrR2r8RhsI3tg>
    <xmx:-UuQXIEM8VtQJXOcGFjpU1OHhasSdKrBCdaT2RgwTgGZZp76_M5tUQ>
    <xmx:-kuQXI_bnCVnMr0JfA-BShLHMOl4qZKmdEjBPyAmSAB8y6qPD1Nycw>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02F2AE47A9;
        Mon, 18 Mar 2019 21:55:04 -0400 (EDT)
Subject: Re: [linux-sunxi] [PATCH 6/6] ARM: dts: sunxi: h3/h5: Add device node
 for SID
To:     wens@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190318073354.12151-1-wens@kernel.org>
 <20190318073354.12151-7-wens@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8e9ef57f-1d24-b151-f8a4-812b7bb65388@sholland.org>
Date:   Mon, 18 Mar 2019 20:55:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190318073354.12151-7-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/19 02:33, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The device tree binding already lists compatible strings for these two
> SoCs. Add a device node for them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi              | 4 ++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 959d265e7254..e37c30e811d3 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -231,3 +231,7 @@
>  &rtc {
>  	compatible = "allwinner,sun8i-h3-rtc";
>  };
> +
> +&sid {
> +	compatible = "allwinner,sun8i-h3-sid";
> +};
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index d74a6cbbfdf4..e2100b673a51 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -227,6 +227,11 @@
>  			#size-cells = <0>;
>  		};
>  
> +		sid: eeprom@1c14000 {
> +			/* compatible and clocks are in per SoC .dtsi file */

There are no clocks for this node, just a compatible string.

> +			reg = <0x1c14000 0x400>;
> +		};
> +
>  		usb_otg: usb@1c19000 {
>  			compatible = "allwinner,sun8i-h3-musb";
>  			reg = <0x01c19000 0x400>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index 96acafd3a852..f002a496d7cb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -209,3 +209,7 @@
>  &rtc {
>  	compatible = "allwinner,sun50i-h5-rtc";
>  };
> +
> +&sid {
> +	compatible = "allwinner,sun50i-h5-sid";
> +};
> 

