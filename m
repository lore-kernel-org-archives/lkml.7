Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CEC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A52C206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Wv04Kge3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBdrpwmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLKAjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:39:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49977 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfLKAjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:39:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 367C122623;
        Tue, 10 Dec 2019 19:39:07 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 10 Dec 2019 19:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=y2FrhHpDPOu5fdVkuCVeBpGXEJEWJIy
        03EFs89q06sc=; b=Wv04Kge3rgMOsTc+ChSiTXuBJpuLEi+WHFIzLZPFC5qeVFh
        SPLfjvNkFAdCY/BlKgzYj1ZO0Bo0pSdnbWGdn4FdSloaiQVRHK4UZsjV6ioEKZZn
        U6bJrSbNBBWvL85bw9tZwu5CKqmmrqsR9NocxPDHPzcn8RJ0mf03W6yrBsbewnxk
        MarNB1C3bHasi3wNcCPYDNpX2szVEStdDzxeuZdfaO5x1iJLc8MnaLqGT8UUDnRH
        KMhWaFr5DHAifOpifCE5BrKZ859DmZNpvDq/Id5zRJFYaenA4OsDG1vzECd1BK8F
        WMCnp+yF2jU+VnJjXenohHzmQAGqmgIb/zao0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y2FrhH
        pDPOu5fdVkuCVeBpGXEJEWJIy03EFs89q06sc=; b=wBdrpwmXzqO0F6O7G+o++O
        qSOiCLZw3dicrtkazdOf57QTp40fDa6Z9Dn3LZTLt69CIFtqego63ds3AnCJjKpa
        8yR46Ej26bh+Fh7VSRmL4uJW1SFPK1uxgOYuXGIAsOqzPF56KsPXjWh1tDAgEAjk
        LUV1u8x8lSc8+ZMJDQnQtBhCDnADPleeMWswzpXfIC/IBXFpKEGHW0sTNoK0brRw
        0PkviHO6HphnSIjOS3DXUC/VGfMQOhKkdICk+r17mvOgOeD525PFA7S7LTnD4wj0
        S31OS70ia3fsxXQhzUui4Y8TMKoiRg7rGqP175Ph51zddJEA9fO9D/2gVlx+lgug
        ==
X-ME-Sender: <xms:qjrwXR6tGOtpZ6mczjISZGwoQ2RNXzP_V01XeH4xYv0X3EP8JddjoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:qjrwXZuUFYMNFzDZ90aaO7UuwtBEpA43e_a6YNVzgaYqlVnDaDPwEQ>
    <xmx:qjrwXeFNGS4bwrcnUCiQZb9BQI7uQFT9Pk9DFezQjKMhdGdH0Up4yg>
    <xmx:qjrwXe7l0eVNSk0mgUKd2zjS8cR0ip6THvTVRNuFTfmgn6j_qplrgQ>
    <xmx:qzrwXQ9Om7FV5HtLJCbM2t1-uumtt5G4GCjCmIYHduCxUwGSVUNprg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09D80E00A2; Tue, 10 Dec 2019 19:39:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <6be1f1d3-8d85-4363-938d-1265e9f95d6f@www.fastmail.com>
In-Reply-To: <1575566112-11658-6-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-6-git-send-email-eajames@linux.ibm.com>
Date:   Wed, 11 Dec 2019 11:10:45 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v1:
>  - Add 'clocks', 'scu', 'sdmc', 'vga-mem', and 'pcie-device' property
>    documentation
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt        | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 0000000..942dc07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,43 @@
> +Aspeed AST25XX and AST26XX XDMA Engine
> +
> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform 
> automatic
> +DMA operations over PCI between the SOC (acting as a BMC) and a host 
> processor.
> +
> +Required properties:
> + - compatible		: must be "aspeed,ast2500-xdma" or
> +			  "aspeed,ast2600-xdma"
> + - reg			: contains the address and size of the memory region
> +			  associated with the XDMA engine registers
> + - clocks		: clock specifier for the clock associated with the
> +			  XDMA engine
> + - resets		: reset specifier for the syscon reset associated with
> +			  the XDMA engine
> + - interrupts-extended	: two interrupt nodes; the first specifies the 

s/nodes/cells/?

> global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - scu			: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - sdmc			: a phandle to the syscon node for the SDRAM memory
> +			  controller of the SOC

This is a driver and is unrelated to the XDMA hardware. I think we can avoid
touching the SDMC in the XDMA driver anyway (it should be up to the
platform configuration to make sure the remapping is set correctly, not a
behaviour of the XDMA driver).

> + - vga-mem		: contains the address and size of the VGA memory space
> +			  to be used by the XDMA engine

Shouldn't we generalise this to just a 'memory' property? It doesn't have to
be the VGA memory, just we tend to use the VGA memory to uphold security
properties of our platforms.

> +
> +Optional properties:
> + - pcie-device		: should be either "bmc" or "vga", corresponding to
> +			  which device should be used by the XDMA engine for
> +			  DMA operations. If this property is not set, the XDMA
> +			  engine will use the BMC PCI-E device.
> +
> +Example:
> +
> +    xdma@1e6e7000 {
> +        compatible = "aspeed,ast2500-xdma";
> +        reg = <0x1e6e7000 0x100>;
> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +        resets = <&syscon ASPEED_RESET_XDMA>;
> +        interrupts-extended = <&vic 6>, <&scu_ic 
> ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
> +        scu = <&syscon>;
> +        sdmc = <&edac>;
> +        pcie-device = "bmc";
> +        vga-mem = <0x9f000000 0x01000000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 398861a..528a142 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2707,6 +2707,12 @@ S:	Maintained
>  F:	drivers/media/platform/aspeed-video.c
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  
> +ASPEED XDMA ENGINE DRIVER
> +M:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> -- 
> 1.8.3.1
> 
>
