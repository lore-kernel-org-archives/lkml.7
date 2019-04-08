Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7812C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D6A20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="rFzdt0F1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2F9eTyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDHCDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:03:19 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41389 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfDHCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:03:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A5C5222AF;
        Sun,  7 Apr 2019 22:03:18 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 07 Apr 2019 22:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=20J4UCiYCecX6hcevBH2xZ9e31I9HCT
        G+lXEJ8WmvoE=; b=rFzdt0F1IiyALbMh4AEUx5RBX3Vm3nV1MRpS9CgkWSRZCZZ
        V69d8IijJlE7CSSwmS57RsA4XMgcPOwolr+Ox9h2mjt7X5SGpuJ0IAg8E1bNmFv5
        dmTUIyOK8aNifwGFv2x1N7ycl/8JBg1VJ9W9be+/UcEw3KKsqvEgc4ZgmjwlLJwo
        Vl+KxDftZtyJqGX+agNJW0Ys2mb9mTX1BrZGlbq6wlG1M1Oheqxz3NvgP7pzflOm
        GOfHGQ8cptcQHoJO7QvS9B2Ep+eLz1o1ARbRwEVDMTAuKQg+bC6a8etfrP00hDZq
        QXTOe/7Rl+/9ByeU9sFVFYF2xVKyJMVyFh/QTyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=20J4UC
        iYCecX6hcevBH2xZ9e31I9HCTG+lXEJ8WmvoE=; b=g2F9eTySkjUrmxZ8odohH7
        veR7Q4uxnPXtcsG46ZR895Sbo1UuC3py49gyoVQHcaLGqxdRbfg6QW4rPfeVnGo9
        ijLombyqjoM/+gKHv2kYrkkDcM7fH5YUHb6HL8rVzu/Domnoz0uFmx7zMWRMyXqP
        eAmpWKh6sS8U43j+ZbyRHOYAMTecDdiQRRa7iCNwwdREtBNhla0gJXKzY3xwkljp
        A25M+k86wweF/DNMAhxhCt2a2a9l4pbUJfyMFrC3dZLdOofZqyXnmIcKpCTwynPi
        VPdHl1oQecxfVm6meaMjYeqLpVnSiqJZwJwMXVA6h1kL1404JIEUbWBIRVR0gslQ
        ==
X-ME-Sender: <xms:5KuqXMlDcOzJVNl_bq8tHTNGbkjaCvqMIOOhO4DeLnuZ9S8BkjfARQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvgdehheculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredt
    necuhfhrohhmpedftehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrd
    hiugdrrghuqeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:5KuqXAFoJPVjqDP07QTWsImNdqhoc7bdB09nadHA_Qi-t43j9gQVvQ>
    <xmx:5KuqXFobiJYmmwz8p-H6DC2mt7Xxpi1K3NWEJBeSX48Hv3WhYDp6NA>
    <xmx:5KuqXM6KfbKfe0CHEf1Qi4TRJH9tpG9e-ZyznTCY394Dst6R9mEvgQ>
    <xmx:5quqXHsXEWIHG_towIMRE2UHTrNKHnPbhuOm26GPUecOF0tmCz-pvw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BDD457C413; Sun,  7 Apr 2019 22:03:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <8c412bc4-6528-4496-a912-f098604e707b@www.fastmail.com>
In-Reply-To: <20190404152544.214988-1-venture@google.com>
References: <20190404152544.214988-1-venture@google.com>
Date:   Sun, 07 Apr 2019 22:03:16 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Patrick Venture" <venture@google.com>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Apr 2019, at 01:55, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
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
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt 
> b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 0000000000000..05ed654848b60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,56 @@
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
> +The aspeed-p2a-ctrl node should be the child of a syscon node with the 
> required
> +property:
> +
> +- compatible : Should be one of the following:
> +		"aspeed,ast2400-scu", "syscon", "simple-mfd"
> +		"aspeed,g4-scu", "syscon", "simple-mfd"
> +		"aspeed,ast2500-scu", "syscon", "simple-mfd"
> +		"aspeed,g5-scu", "syscon", "simple-mfd"

Agh, now the info's here twice!

Next time, surely :D

Unless Greg or Rob want to chop one out as they apply it? It looks good to
me otherwise.

Andrew

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
