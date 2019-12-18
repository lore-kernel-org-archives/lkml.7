Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA9C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51D02176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="D4G0itlD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="im2fMc8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLRXKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:10:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44553 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLRXKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:10:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A31C21EE9;
        Wed, 18 Dec 2019 18:10:41 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 18 Dec 2019 18:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=bP1o2RXoO7tNFb5/kJZExnnM5a2fcbt
        SPdIvkcQJXyA=; b=D4G0itlDbAPubKY5LU9mOuPyKcoHeft5nHCiCeUvrxboapZ
        dA4ln/pXiG26nX2Ib/RW0MzQoNz1P5GwUeb9HXJraR41akyamzEUG/aNc30GIzYA
        Kh82Y9hf9GHk9EWD04n51CR70RkfogOjfVLyfwkdWhKc9BflHLCYepKjRmFivsYo
        sbpOqUqTdrSU0WiqXF3dO0qg7ILD7zfzaT2S/C955/Xz3/sUlWVKFngtSvuTPJ5y
        L2xhGViM0EiOpvGdn3/BJLkNk4uf7naJjtH8+rkDbooZc4tvHAR5H3CXMHJgCGMW
        afvx24Vc9vOKyNjK200kHX/HsfLuB9yWrqYSg6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bP1o2R
        XoO7tNFb5/kJZExnnM5a2fcbtSPdIvkcQJXyA=; b=im2fMc8AC7tOloKDP0z5Ec
        12FXgnlAcqB8dc/Y2PbGLETB1tR+1Q8v/kAaW7fJjWikCt2Hhec0sjEiSOaROHt2
        iJi41qCIX/zWo3THTp4mu1n6XU8ScMZRtnrXWwTILTcrMPGBY9FYpjV5pCbSTvqu
        EzLZZZmeAgB496JdYCFS4P1FVNWjmDXrYok4cJ0qtw/khj2VJjcJbAPhowlmUCmY
        1y7u00HcrCiWjtFzol1DCfQ3wB9hV2jUP5562OByiT/0Zj7pNDM0q/cqTvfnGvIC
        +SZzlR/UJU2HzhXJcXWgpDelwm4zuI1X3Hsruxrdv07ZPX0vGBx2vNYGn5AvA1eA
        ==
X-ME-Sender: <xms:8bH6Xf5qSXAyWkTXvrieMhm4NMNijt1vNGVnBYVuPVPGs2UbBwD6dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:8bH6XZK3r0wLqMk_E4OLHVw7DiOQhloyQkGJF29idIq7b2azROMgnw>
    <xmx:8bH6XRdCAR5BQEy0cqpKis92i3X2W7pEvO20lYUzY-Lff6EM-wfPWA>
    <xmx:8bH6XUfXHNaY9EcFsW88V8iDB2ce0krMd7MwQm_4ww3R1MW_JVBoHQ>
    <xmx:8bH6XfB1hjKxNCcUrzw86FzEVzB2D39nOicQ30v_bqqeGsovLU73eQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BC88E00A2; Wed, 18 Dec 2019 18:10:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <73cbffea-89f1-4212-99af-10c32968cf15@www.fastmail.com>
In-Reply-To: <1576681778-18737-6-git-send-email-eajames@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-6-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 19 Dec 2019 09:42:10 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v3 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v2:
>  - Remove 'sdmc', rename 'vga-mem' to 'memory'
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 000000000000..58253ea1587b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,40 @@
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
> + - interrupts-extended	: two interrupt cells; the first specifies the 
> global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - scu			: a phandle to the syscon node for the system control
> +			  unit of the SOC

I think this should be aspeed,scu.

> + - memory		: contains the address and size of the memory area to
> +			  be used by the XDMA engine for DMA operations

Hmm, I was thinking more like a phandle to a reserved memory region,
like we have in the aspeed-lpc-ctrl binding.

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
> +        pcie-device = "bmc";
> +        memory = <0x9f000000 0x01000000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac9c120d192b..8a14d4268bdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2708,6 +2708,12 @@ S:	Maintained
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
> 2.24.0
> 
>
