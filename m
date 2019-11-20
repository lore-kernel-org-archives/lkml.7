Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14308C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604722445
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="nrS5ftCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0JWxE14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKTFzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:55:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55681 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKTFzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:55:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 463E321EBC;
        Wed, 20 Nov 2019 00:55:24 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 20 Nov 2019 00:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=f3+K46N0DWX5LuAKDC/fiNXYVVrmkSg
        hYy+SQPmLsVo=; b=nrS5ftCQfJhb/0SIriK4G4/USapAcazY5+vRGPrXnyUajqo
        mr0cUrqurVBtgUBulgP/odWXDPhQU7PGQEoa319vP7IYQHHcuej3zbq3x/xaxL/J
        Abac7EzsOusr1YxoJSj44wgX7c26KRsuf5/mOCUs39a1FE05ma9dwCBN5jRzdUOg
        zC3IovVzEwZ5l87a67SjHfBRGW3K+8hoDZSYE/NM61EBPEUjvGPGAnTxA1FBlDjx
        4Poi08XpAR/OCyWf6doXY5ERtZMulMOgFjmLBUMArwUsleUkca8efD5scGT+03Mq
        BcLGKKD4zsTULYqAja70jDfV+ZwegmAuqAqSnbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=f3+K46
        N0DWX5LuAKDC/fiNXYVVrmkSghYy+SQPmLsVo=; b=k0JWxE14P4oWIkMi8r0cec
        p9Ihj7W1MZ2ZBJ7l+gcvoPC4o2DR7sanbIj1fHNAUmD+Lnpj2Tjsi1/F2a/fj5Xj
        +4DgYuHeuJdw5HKV2R9zE70EBuAQ6/k3KEsKleTcFtoVKwwzbLJKPpdep++Ik+Mr
        LmhulH+vUEIbsPuGITgNBgqdU3WKSKtTuwVFYH5cASMiPoGZDXUkQ3V4b70a7Cvx
        NAC7okXuQfRIFTNzBGhwJNRZoQ6Q0N5dlMcvDA+JVXvXdo82Xz6vNH1LQslqHLHP
        ePnaU10QZ1pyiSDAgmVdhDeTTR2tLd7WFOYB3GE3rL6lJiYBcs0CkRA27kzlsE+w
        ==
X-ME-Sender: <xms:S9XUXSJb3U14OItt0wTjrNZLrg9dG1Fea4rYhQgLJs-wsKt5njRlZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:S9XUXdZR2lOHYxQmHC-_uMAhfesKHzpPbPmi8khFOFVYiUyzaJy9jw>
    <xmx:S9XUXaP45WKf_5a4zcQwkCo6gf1KdknjpyZ8ZZV8rEaU5_Fs_KEnaA>
    <xmx:S9XUXVBipktyQxJgGIXnGMUNn3LdYtcmpNTQiEo5xMawg44uKjqfWw>
    <xmx:TNXUXXHUBuf3suYLL8HFUbDvVpD9VkhWywoUWb_QzzVDgn6FfgcFmw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 478B9E00A3; Wed, 20 Nov 2019 00:55:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
In-Reply-To: <20191118123707.GA5560@cnn>
References: <20191118123707.GA5560@cnn>
Date:   Wed, 20 Nov 2019 16:26:47 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Nov 2019, at 23:07, manikandan-e wrote:
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 170 +++++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> new file mode 100644
> index 0000000..46a285a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018 Facebook Inc.
> +// Author:
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook Yosemitev2 BMC";
> +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	iio-hwmon {
> +		// VOLATAGE SENSOR
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +	};
> +};
> +
> +&lpc_snoop {
> +	status = "okay";
> +	snoop-ports = <0x80>;
> +};
> +
> +&lpc_ctrl {
> +	// Enable lpc clock
> +	status = "okay";

Something I'm intending to fix in the devicetrees using LPC is to hog
the pins in the pinctrl node. You should consider doing the same here.

> +};
> +
> +&vuart {
> +	// VUART Host Console
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	// Host Console
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +		     &pinctrl_rxd1_default>;
> +};
> +
> +&uart2 {
> +	// SoL Host Console
> +	status = "okay";

Also needs pinctrl configuration.

> +};
> +
> +&uart3 {
> +	// SoL BMC Console
> +	status = "okay";

Again needs pinctrl.

> +};
> +
> +&uart5 {
> +	// BMC Console
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	use-ncsi;
> +};
> +
> +&adc {
> +	status = "okay";

Strongly suggest adding the pinctrl properties here to ensure
exclusive access for the ADC pins.

Otherwise it looks reasonable.

Andrew
