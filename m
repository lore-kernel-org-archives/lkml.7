Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3421473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="wmhz2mva";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CokE1Jxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDIAsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:48:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37121 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfDIAsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:48:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AA6D522F10;
        Mon,  8 Apr 2019 20:48:42 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 08 Apr 2019 20:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=sby3J7VDFJrL1a307BRA/APshC4O/Lx
        GlyK4eM2xlgM=; b=wmhz2mvaqmnNFsN5cbrhcaLu1A1OBsdU6um9SfFsgOMzqF2
        a1/ENrlXi/38bNSIGQbd+ONyCsFQdRkbfrxHnhg+Z26SFAHeO5pdu6UKeQoFxcZw
        7gxGnH73J/UpJ3KBCb5as9R9BljYW8RNdfBWNGtWSTFziu+KkpNfLUEAYw+u/3DP
        ziDzmhIOoOaTCrqh/UtPoA2dyiXJhSIzjtwmOhnRnmm3dsP7yav/DWdw+LjeLtO0
        eaDVza7JfnFWVpZg2tE6of3du0rQKnifMcg9047M1tSMQ02hP1Z+RN70oaF334tE
        n+xMrZI0vfrYYVs6ZfoM3faLUq6cPjGBde+5qbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sby3J7
        VDFJrL1a307BRA/APshC4O/LxGlyK4eM2xlgM=; b=CokE1Jxt8CcObh1GkyuPJT
        QTYIbPv9qJXyovvYt8MDUB6PYrU6LiZXGJAcVq3Os/gLyy9nYHrrDEsqFaOAxcjC
        y4JU6qR5hWuefOcg48zAyo/D/e5gten0Im2qf6VnfRUHIKXE8baOG8gsbYDLO051
        20X9YixFDJcdtF1bGxugka5fs7YGSNdOw9K+XwEUE000dUKuap6wCj/zcFDaC5JG
        3RcGVTY8RwzlHjK5jlgvjhohpYwyfInCJejB3gZsNqIj3AKuveZTJad1k68uxBr5
        UyjnD/J5bVdPL3XTHDpW1Nkf+77k1O1MRFWeSr8ecYo8249WsKd8PtZ/lIrxNbIQ
        ==
X-ME-Sender: <xms:5-urXKTaAXwlW0NlY8YW2w1Wz46ihJ79VSZu77HEBo3KGHIgXTCUSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:5-urXBCFC1q0oYys5euAnas0c18EqXKan6CgiFxDw7DlWOIqjSAZ_A>
    <xmx:5-urXGgJGNkNnvCAY86jhtYoi4_nGTtPLe9FfCxJOx-tRORUg0qjjg>
    <xmx:5-urXIGS8tRJp0BQpJ1W_mtvZiwa8-YXOJuMjXku7MVvT_y9Q9Q1UA>
    <xmx:6uurXFICVd5lPi0w1LlWlDFV1Sgz7KNlqjZVuIaoqMyDAfaofUJpUQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BBBA7C1B9; Mon,  8 Apr 2019 20:48:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <998d869d-de1d-4ac9-b4e6-8942945912dd@www.fastmail.com>
In-Reply-To: <20190408144216.160082-1-venture@google.com>
References: <20190408144216.160082-1-venture@google.com>
Date:   Mon, 08 Apr 2019 20:48:38 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Patrick Venture" <venture@google.com>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v10 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Apr 2019, at 00:12, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> Changes for v10:
>  - Chopped out nearly identical information.
> Changes for v9:
>  - Added missing details about syscon parent
> Changes for v8:
> - None
> Changes for v7:
> - Moved node under the syscon node it requires
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - None
> Changes for v3:
> - None
> Changes for v2:
> - Added comment about syscon required parameter.
> ---
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt 
> b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 0000000000000..854bd67ffec68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,47 @@
> +======================================================================
> +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge 
> Control Driver
> +======================================================================
> +
> +The bridge is available on platforms with the VGA enabled on the 
> Aspeed device.
> +In this case, the host has access to a 64KiB window into all of the 
> BMC's
> +memory.  The BMC can disable this bridge.  If the bridge is enabled, 
> the host
> +has read access to all the regions of memory, however the host only 
> has read
> +and write access depending on a register controlled by the BMC.
> +
> +Required properties:
> +===================
> +
> + - compatible: must be one of:
> +	- "aspeed,ast2400-p2a-ctrl"
> +	- "aspeed,ast2500-p2a-ctrl"
> +
> +Optional properties:
> +===================
> +
> +- memory-region: A phandle to a reserved_memory region to be used for 
> the PCI
> +		to AHB mapping
> +
> +The p2a-control node should be the child of a syscon node with the 
> required
> +property:
> +
> +- compatible : Should be one of the following:
> +		"aspeed,ast2400-scu", "syscon", "simple-mfd"
> +		"aspeed,g4-scu", "syscon", "simple-mfd"
> +		"aspeed,ast2500-scu", "syscon", "simple-mfd"
> +		"aspeed,g5-scu", "syscon", "simple-mfd"
> +
> +Example
> +===================
> +
> +g4 Example
> +----------
> +
> +syscon: scu@1e6e2000 {
> +	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> +	reg = <0x1e6e2000 0x1a8>;
> +
> +	p2a: p2a-control {
> +		compatible = "aspeed,ast2400-p2a-ctrl";
> +		memory-region = <&reserved_memory>;
> +	};
> +};
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
>
