Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE81C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172642654B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZZYrGWUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ve1EEkjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfEaIAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:00:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43047 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfEaIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:00:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A7DFD21E90;
        Fri, 31 May 2019 04:00:00 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Fri, 31 May 2019 04:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=Vt88uEygPIcGWjDilRhdbj1DAz7EhM7
        E+LtWenHZ1O0=; b=ZZYrGWUUAz2vapErJCAJ4ZmletpYCqHknQtpEUb+h1fc026
        G5nvCaCk8jLoLeFNJreiXFtg84DxRbcdHgdkkraHqAwBZyqm9paXl9YSDuiWsD8v
        JdCdZezsjdhATbCXsp0MY2Q6qjp9ox/XaS2tFKl/9CqXGB4pQ2jO+HMEttwjJCxC
        1SY4kZ6xAKU8rMHxLz9ExAevcwdIGBVfuRdq4xjz7qilVyMjwoqWkJToGC8FlBbr
        hV1ey7bjOdayPsVJLhFgCk+W4YZrqrIcSvy1haZuOqk4Uuu/4j1t/GOOnELcoGnA
        GrrSZkOTOXcOM6aF3PG+lNz8PPLrAEte1slsQWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Vt88uE
        ygPIcGWjDilRhdbj1DAz7EhM7E+LtWenHZ1O0=; b=Ve1EEkjJpwz8q1Iz8lT+Mc
        VucTu7d03lo5+5+xgcOu6iKgdtdd46Qgw5PeDLSHihSYZXfj/y51wRtIQit5GjJV
        rScXa40dShDcp8IJxvQctEVpflI/tJSlxJNu8s9RXcU0FWQ0WRaO7g1A6N4RPi+3
        SpnjneAKmt87yVvgKwZ58jPQhlOPE1OP+bodaEQvi+OGuB+oM0PdOkR/4nwfzXO2
        W72mRaKz+FQXBszHoMnr98CMOQHMuH7gh9hEXP4OWrXHfaUjMJE1dfTzbNDOMx95
        mhIaOj0AQHBmtrhxtgsg8GfoiQiutTn3PDJziWguT+oe3RKsqPgVKVoRKYgcKNVA
        ==
X-ME-Sender: <xms:_t7wXI4mJrbZtDPpUcAO99yNhOrs8BgfuPiQZkzPI31h5RjEgtvgKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeftddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:_t7wXOLz7iSkzy0OmvZjy7v5Or6mbBRqYAGF6gKSBFztJBNA6q_0jQ>
    <xmx:_t7wXCfQ3fqbeejk0d8YbBdxC2L9PM4nGHCmJteRuTM9NHl_x6f0_w>
    <xmx:_t7wXBe0Z94-Nax48W4uyERu_iT9ddofTJYWC8oxirvIIW2aSqCN7g>
    <xmx:AN_wXDrdEg5grihZAGO7MhqlPB682nuhUMwj8qSe3NO3DhBRnpZiLw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CD0FE00A2; Fri, 31 May 2019 03:59:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <af088bbb-d55f-4477-a564-ef9fcc306433@www.fastmail.com>
In-Reply-To: <20190530093544.12215-1-a.filippov@yadro.com>
References: <20190530093544.12215-1-a.filippov@yadro.com>
Date:   Fri, 31 May 2019 17:29:58 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: g4: add video engine support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 May 2019, at 19:06, Alexander Filippov wrote:
> Add a node to describe the video engine on AST2400.
> 
> These changes were copied from aspeed-g5.dtsi
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 6011692df15a..5a9e3f684359 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -195,6 +195,16 @@
>  				reg = <0x1e720000 0x8000>;	// 32K
>  			};
>  
> +			video: video@1e700000 {
> +				compatible = "aspeed,ast2400-video-engine";
> +				reg = <0x1e700000 0x1000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +					 <&syscon ASPEED_CLK_GATE_ECLK>;
> +				clock-names = "vclk", "eclk";
> +				interrupts = <7>;
> +				status = "disabled";
> +			};
> +
>  			gpio: gpio@1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 2.20.1
> 
>
