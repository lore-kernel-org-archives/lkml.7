Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444EC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6147A2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Y4QFUcdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/1AR8Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgAIEnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:43:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42869 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgAIEnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 23:43:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 347CE21FC3;
        Wed,  8 Jan 2020 23:43:41 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 08 Jan 2020 23:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=taiDRc8Qpn+ljKa3v+JJ2VH/VhF+HU9
        gTcCq/CXJk/Q=; b=Y4QFUcdAPhs5F1NtsVAMZJ2NWEOAQ3L/WrrnMLss4MSII0p
        QiI5kEHAFxW5H2fKyD3JX3qWjq6ym8typst52yTTaPLyv3JTY4gzC3EnnQ6TyFOG
        IjC2tY1dbW25noiZcxj219g6P+yxs86qmtmv7BGORj2SFjOXHqOCUdH+XhxSxuyt
        nCqGAcuObjKawHVOUdItpRGZhHI87J/S4gJiUyYncjJubrZ/aoTW1UGaDqvwmOtp
        MZvpF9gg2MqV/6Meq0UIryB7hRoG6fCpwdh2gAxEnfXYuKGKlh7+BHT2Q0Y+zqgC
        wSNaoJV1lL+d0Mh79GhT9Is8bNZQ6OU/WXqMX/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=taiDRc
        8Qpn+ljKa3v+JJ2VH/VhF+HU9gTcCq/CXJk/Q=; b=p/1AR8Sj4FRNX27JOUsn4p
        aUcnnvRcxVuKz/3S3MYDjDCNh0iw2uCKc+uwND2IOU/NZJbdVkTR8PyNS8l7n+6g
        CY1lj5cUJ/AKcZ/gi/DnoQIJlTL5PBS96s/oda4UbS6wlBTIUaF0ZIQVuRs2c7zO
        fjWkosezJSirHrGyvMJMqgllF1OeX0YiT1QrjJYLdSDqWqWVlXjAxB9Ttr8BkaKE
        J/2kDa53QU8wNXl4bWBw0kDH/YUd4A5ghjgF3bTwAcRhsRs92KpLYrOyiYvYBA8i
        DDG0Bl69O8JBjl43BQQd3E4fzwqp0c0uaAudGHizyDmXTbPbzl1j6gC4j7+6i1xw
        ==
X-ME-Sender: <xms:e68WXtp7DRwcGksY0anL9lWdG07_eQplFUzX1X8U6c0lX63E1mv0xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:e68WXkiLTErI05O4GuCxW-TaO8gGcLJexpQ3xM5oxeB1_NfEjZahVw>
    <xmx:e68WXnwORpaCJmSfvwt4kT0n3K9dtJhAEua37HFmM9qO3QdTFpSfag>
    <xmx:e68WXq9iyttuAOaajY1Xx-_jTjrBeCFxBDx8JIpPac5GhwP-qhWIpg>
    <xmx:fa8WXiCG33PCe2CDF5pZawSJe8ZqQxsu0hb66VbLIG8wUmp62xBwWA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC54CE00A2; Wed,  8 Jan 2020 23:43:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <3cc1006c-c107-4864-b652-118e84060c38@www.fastmail.com>
In-Reply-To: <1577993276-2184-6-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-6-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 15:15:38 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v3:
>  - Switch "scu" property to "aspeed,scu"
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 000000000000..e0740ccfa910
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
> + - aspeed,scu		: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - memory		: contains the address and size of the memory area to
> +			  be used by the XDMA engine for DMA operations
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

You missed fixing the example :)

Andrew
