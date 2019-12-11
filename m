Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC9DC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0B206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Aa0ceLCu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApLBdml7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLKDrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:47:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48843 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfLKDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:47:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D945622373;
        Tue, 10 Dec 2019 22:47:06 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 10 Dec 2019 22:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=brTnepl9m5s/ksfArYTl/Nhn+h2HCCY
        jrL1gHLQabRI=; b=Aa0ceLCufNUZeaOvxMekuQdZ6rTZrqXpZUtfb1HcEHbolDE
        NvFp56/ta9wB5Bi98c09ELWGUzc5ky0KEFrxA7cXpN6STjSs3yu8WjEkR0VSsfM6
        zKoyT2sIxjgxGiPqszM2BBhZBmAClQsVptbqFV+yJhn+H0t+G5JuiVn+CRuYtJ+n
        QQXVJVEVRAbuZ+iFoImw6q1zVXFeZSqyYOdMTDvbwEscPisgHv1QJHsfNca7N6/u
        Eu9Kt0oSNu5MjJ6fEBbuYhkKx73ySeNMwSJZg1JJ247WEBsOvFwvOjNkltgeiqDH
        ttGlwrNdm7V4y+vZToxaKWuQ8rWGxO9k6z0ckOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=brTnep
        l9m5s/ksfArYTl/Nhn+h2HCCYjrL1gHLQabRI=; b=ApLBdml7EgXKEBemGF6g+i
        8WaU1pQv9lgcmYuhO3vLeKF7N9SCSw+Ei1nXEcbMeiGBYNCrRpqWHM7txYkBCZ/1
        V4Wwtlm8On2Ui3mTmaVpW30k0xKfvDUg1avmGYP8wct3zocQ3ELrzRbqWivmwGRA
        gA2f/Sgpo/1MhuZP/F4TH7fFEZrSwTAOSJIGPi6LnnRBmmyuP1dpVhuJ1LL0ad1F
        GH/jNUan/rfTat/0GVDvAB+5QJDbtn4akZvikB54p4rYux1Tt654NulErtcTOItA
        O6yo3LvsbHcb9Ndd/bEBfLxqHql6HRIEZsPrmVhnSSMVV8ZPdJHoLVVoYEbvZcYw
        ==
X-ME-Sender: <xms:umbwXcLW2pAVcnjhoYa--3sMmbdEnaxe4sZAoaL2-e7MBOT3g901Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepvd
X-ME-Proxy: <xmx:umbwXaimatRuH5D7BzyUWD2zkCeDcvK9eb4gndzlf_yLxyKPY4lyOw>
    <xmx:umbwXYuebxEBGSwAlb5JObPQMygTRkrQPavki8p8fjelv3iQe59xSA>
    <xmx:umbwXcj5didO8Wg2faiIquBOB2EikzTL68BYjD_Xyp2QXekqT6Tavg>
    <xmx:umbwXcj4wTsXn8iPDE5GJEEledoM4pU_Cr1845Jb94LgXatzYTGmUQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AFEF0E00A2; Tue, 10 Dec 2019 22:47:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <5086ee4b-bddb-40c1-9841-005b233f837b@www.fastmail.com>
In-Reply-To: <1575566112-11658-10-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-10-git-send-email-eajames@linux.ibm.com>
Date:   Wed, 11 Dec 2019 14:18:45 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 09/12] ARM: dts: aspeed: ast2600: Add XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Add a node for the XDMA engine with all the necessary information. Also
> add a simple syscon node for the SDRAM memory controller.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Add a syscon SDRAM controller
>  - Add various properties to XDMA node
> 
>  arch/arm/boot/dts/aspeed-g6.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index ead336e..514d685 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/ast2600-clock.h>
> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>  
>  / {
>  	model = "Aspeed BMC";
> @@ -265,6 +266,11 @@
>  			status = "disabled";
>  		};
>  
> +		sdmc: sdram@1e6e0000 {
> +			compatible = "syscon";
> +			reg = <0x1e6e0000 0xb8>;
> +		};
> +

Hopefully we can drop this. We also need to figure out how whatever the solution is interacts
with the EDAC driver.

>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -311,6 +317,19 @@
>  				quality = <100>;
>  			};
>  
> +			xdma: xdma@1e6e7000 {
> +				compatible = "aspeed,ast2600-xdma";
> +				reg = <0x1e6e7000 0x100>;
> +				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +				resets = <&syscon ASPEED_RESET_DEV_XDMA>;
> +				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
> +				pcie-device = "bmc";
> +				scu = <&syscon>;
> +				sdmc = <&sdmc>;

sdmc property should go away also.

> +				status = "disabled";
> +			};
> +
>  			gpio0: gpio@1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 1.8.3.1
> 
>
