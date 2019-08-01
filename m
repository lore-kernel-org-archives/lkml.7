Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0122084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564687700;
	bh=CnTyOHs6SVPD1w0DZxSy57arQjcDX8yCyKR8zuV7UPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aChIGcjMOfWgy+pwy4ujZPelNSKdXW2hG52s8VdWgvO61iWW4CuUr2RYgQ1qGzlQW
	 MWOOVQUMgUk2SenpbadC2oO8lq9qFz062kwHJZKLztIgHjZ7+NFdIEmwu16XMfoVlr
	 S92tNN6Znb0S3fArS92wJTPOC4E2cJg52cFVIfE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfHAT2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfHAT2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:28:17 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AEBC21726;
        Thu,  1 Aug 2019 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564687696;
        bh=CnTyOHs6SVPD1w0DZxSy57arQjcDX8yCyKR8zuV7UPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJmxA9FmWeOsBWZUFy3ErUg4ADjGh33PiiugWsllosOwjDUYT/lSsgzVnjoRTmfUa
         zup0Pu4ArZeOrchdy0VzO485ZZYNrkwJqGolYbyinExTgVdumvFGopJvjHSiE7PuaO
         JdSLBxc4+608xwjeDmmqudyImj5QdJcbGkaUuHtc=
Received: by mail-qt1-f172.google.com with SMTP id 44so40431052qtg.11;
        Thu, 01 Aug 2019 12:28:15 -0700 (PDT)
X-Gm-Message-State: APjAAAU9avBGSdfEX1PHmo32NS4VZVDi36hJwFN6cTNJTvZVeZ4V/pj+
        0LBOdgEjoGIG1rpqvNJEEG4vgkH89YmZhNsUJg==
X-Google-Smtp-Source: APXvYqzlhYnhmMohXfDZ9ASXmbVGD8xUiPZIJ8UtRmzEU5RQAOSZAo/eqAX2FWifALpuTHRkWrebH4tRnMBwnNlzdTE=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr92120637qtc.143.1564687695120;
 Thu, 01 Aug 2019 12:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com> <1564147640-30753-4-git-send-email-open.sudheer@gmail.com>
In-Reply-To: <1564147640-30753-4-git-send-email-open.sudheer@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 13:28:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jP6iDdthmXdKVroq5NLWNKgBoZ8Y99TwccFFAerfKBA@mail.gmail.com>
Message-ID: <CAL_Jsq+jP6iDdthmXdKVroq5NLWNKgBoZ8Y99TwccFFAerfKBA@mail.gmail.com>
Subject: Re: [patch v4 3/5] DT nodes for AST2500 DMA UART driver
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        sudheer veliseti <sudheer.open@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 7:25 AM sudheer.v <open.sudheer@gmail.com> wrote:
>
> From: sudheer veliseti <sudheer.open@gmail.com>
>
> DT node for DMA controller(ast_uart_sdma) doesn't bind to any DMA controller driver.
> This is because Software for DMA controller is not based on DMA framework,but is dedicated
> and serves only UARTs in AST2500. ast_uart_sdma node is searched by compatible string in the
> driver software.basic use of this node is to provide register base address of DMA controller and DMA irq number(<50>).
> IRQ of DMA controller is of crucial importance, which does RX and TX of UART data.
>
> uart nodes dma_uart1,2...etc binds to the platform driver.
> irq numbers <9>,<32>,<33>,<34> in dma_uart nodes install ISRs which are of not much interest in uart data TX/RX .
>
>
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
>
> changes from v3->v4:
> -
> changes from v2->v3:
> - change logs added
>
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts | 21 +++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi         | 71 ++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> index 5dbb33c10c4f..4da09fbe94df 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -64,6 +64,27 @@
>         status = "okay";
>  };
>
> +&ast_uart_sdma {
> +       status = "okay";
> +};
> +
> +&dma_uart1 {
> +       status = "okay";
> +};
> +
> +&dma_uart2 {
> +       status = "okay";
> +};
> +
> +&dma_uart3 {
> +       status = "okay";
> +};
> +
> +&dma_uart4 {
> +       status = "okay";
> +};
> +
> +
>  &mac0 {
>         status = "okay";
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 674746513031..fb7b3ed463de 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -23,10 +23,10 @@
>                 i2c11 = &i2c11;
>                 i2c12 = &i2c12;
>                 i2c13 = &i2c13;
> -               serial0 = &uart1;
> -               serial1 = &uart2;
> -               serial2 = &uart3;
> -               serial3 = &uart4;
> +               serial0 = &dma_uart1;
> +               serial1 = &dma_uart2;
> +               serial2 = &dma_uart3;
> +               serial3 = &dma_uart4;
>                 serial4 = &uart5;
>                 serial5 = &vuart;
>                 peci0 = &peci0;
> @@ -497,6 +497,69 @@
>                                 status = "disabled";
>                         };
>
> +                       ast_uart_sdma: uart_sdma@1e79e000 {
> +                               compatible = "aspeed,ast-uart-sdma";
> +                               reg = <0x1e79e000 0x400>;
> +                               interrupts = <50>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart1: dma_uart1@1e783000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e783000 0x1000>;

Now you have 2 nodes at the same address. That's not valid. Please
build your dtbs with 'W=1' which will warn against this. Adding DMA
support should not be a whole new node. Nodes correspond to h/w
blocks, not drivers.

The old node has a reset, you don't need that? Seems strange too that
only 1 uart has a reset.

> +                               reg-shift = <2>;
> +                               interrupts = <9>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
> +                               dma-channel = <0>;

This is the channel in ast_uart_sdma? Just because you decided not to
do a DMA engine driver, doesn't mean you can't use the DMA binding.
Considering you need to map clients to the provider, use the DMA
binding.

> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd1_default
> +                                                        &pinctrl_rxd1_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart2: dma_uart2@1e78d000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78d000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <32>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
> +                               dma-channel = <1>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd2_default
> +                                                        &pinctrl_rxd2_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart3: dma_uart3@1e78e000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78e000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <33>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
> +                               dma-channel = <2>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd3_default
> +                                                        &pinctrl_rxd3_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart4: dma_uart4@1e78f000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78f000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <34>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
> +                               dma-channel = <3>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd4_default
> +                                                        &pinctrl_rxd4_default>;
> +                               status = "disabled";
> +                       };
> +
>                         i2c: bus@1e78a000 {
>                                 compatible = "simple-bus";
>                                 #address-cells = <1>;
> --
> 2.17.1
>
