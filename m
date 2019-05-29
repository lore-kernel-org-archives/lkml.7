Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D4C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8012070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="hOV871nm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYZSZa2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfE2BWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:22:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53491 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfE2BWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:22:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 084352203E;
        Tue, 28 May 2019 21:22:39 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 28 May 2019 21:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=O3Xkv3EI6y00AB2M6iUlJwWyBdvRoMi
        nM2rnAHW1aYg=; b=hOV871nmAdvpcLrcayvkgFn0OV342CHDmf9kRVh6YDNmapN
        fJb/O6F+9R4mH5T2vUaw/G/lAjwe1k35zu/KVu376BtR7EMzdjcWH9srREK6cmwe
        mPrU+UuN9nSCLzEJr5KwObQEP8qgH+qWdsIZR6O1ksL5VoRb/APcKCGZyciXMzAg
        0bK5svhKSY/ZUx7jCipcmflg+MfIxXSDVXKcMeEJ2S9T2O2EB/WV+vrFDtTZeniQ
        9uocJZZ2+5sX1XfbDZ6pcoVIaL+v3nfWlbRrfT4MzCd05XZKk7rAdvwqJ3NqcUC3
        cjPOVgfq29rA/oq50mMHOJvpVP8ev72bcJDVCmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=O3Xkv3
        EI6y00AB2M6iUlJwWyBdvRoMinM2rnAHW1aYg=; b=nYZSZa2jMoyk0fHbHbePYC
        GFW/9W5yQC4kMgPoLN7SlHkfxWroFiLVNRyPRcoktMVkSYZyKyIzP5oBKRJTHBcu
        X3Tg4xxvy0eKxst8OKBpCV6NXhuN+E33sZrKPK5EhTd6z0OY3K4JYsbXhn0MOjv5
        TxK6JQMn/5/pfeOiyEMFoy/aud+7JIoqWVCKROVlJypkLRvbdxnaaOwnk7bWlb5Z
        2LrABS+yVXintxlj6vOBljfKpnsaLgscHaCtgTTnT6fkfMVIvfJOUDnC8aoZTQuV
        jHATHUB5AGUFHD8qsSFFA/FYZ+tx8uogNEBWUOvWZRUJXgRTNskpf3R/Wk4Szy/Q
        ==
X-ME-Sender: <xms:3d7tXKQ_mHmvNk8LYkpIljRURpmhytPa06O4NBRV1egLyXIuEyolqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddviedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:3d7tXFQHu7jR7Vh8F975N4hdkfE8Jvw6GtZjT_KasakbDHkvaP8hsw>
    <xmx:3d7tXG5opnSsYQh9XuURjuUhGMxzAXlIFfjMNM_ddsDKtU5zNJEtyw>
    <xmx:3d7tXKVYrp-nVot3T4GLSTfXXoqv8Scjl8fGLSdSu2wmvFXXYIETBA>
    <xmx:3t7tXL14R3RvaZCn_gnQ2MRGOzKNMaHfplYh8XlawYvBZGEjy61q4A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 42D6FE00A2; Tue, 28 May 2019 21:22:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <c0e01b11-5ea2-42d1-be67-2998809e310c@www.fastmail.com>
In-Reply-To: <20190527112753.1681-1-a.filippov@yadro.com>
References: <20190527112753.1681-1-a.filippov@yadro.com>
Date:   Wed, 29 May 2019 10:52:36 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: g4: add video engine support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 May 2019, at 20:58, Alexander Filippov wrote:
> Add a node to describe the video engine and VGA scratch registers on
> AST2400.
> 
> These changes were copied from aspeed-g5.dtsi
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>

Ugh, I should really sort out the bmc-misc stuff, I don't like to see it propagate
in its current form. That's not your problem though, and I hope to address it in
the near future.

For the OpenBMC kernel tree:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 6011692df15a..adc1804918df 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -168,6 +168,10 @@
>  					compatible = "aspeed,g4-pinctrl";
>  				};
>  
> +				vga_scratch: scratch {
> +					compatible = "aspeed,bmc-misc";
> +				};
> +
>  				p2a: p2a-control {
>  					compatible = "aspeed,ast2400-p2a-ctrl";
>  					status = "disabled";
> @@ -195,6 +199,16 @@
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
> @@ -1408,6 +1422,54 @@
>  	};
>  };
>  
> +&vga_scratch {
> +	dac_mux {
> +		offset = <0x2c>;
> +		bit-mask = <0x3>;
> +		bit-shift = <16>;
> +	};
> +	vga0 {
> +		offset = <0x50>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga1 {
> +		offset = <0x54>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga2 {
> +		offset = <0x58>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga3 {
> +		offset = <0x5c>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga4 {
> +		offset = <0x60>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga5 {
> +		offset = <0x64>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga6 {
> +		offset = <0x68>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +	vga7 {
> +		offset = <0x6c>;
> +		bit-mask = <0xffffffff>;
> +		bit-shift = <0>;
> +	};
> +};
> +
>  &sio_regs {
>  	sio_2b {
>  		offset = <0xf0>;
> -- 
> 2.20.1
> 
>
