Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9797E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="kqltYjhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BumDUUVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfDBDm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:42:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53707 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfDBDm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:42:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B3BBB2211F;
        Mon,  1 Apr 2019 23:42:55 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 01 Apr 2019 23:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=vselwbExjJw6ikMBabXG4tGwIOM/tVD
        dj5bOsECpN/A=; b=kqltYjhsRJF4dpUTQjPoq8LLJDYRYxXPnnd4e1BtfjuO+Q3
        OdeADCGyzWJ2zchyRMdcve/YrAV3Nv2eqEMLaCp6GdXY/GpeNBhSKHUnjw8+Bodp
        iLeUYvcwZPqXe4zxYknZeabGuo5FLM3cuQklp44IF72L0ZBikWI92M8TzH40bqFx
        3hcjtzcBoQ0jBHlmkkTFudD5uLuIDYeGftQfUZOis8lLKSDxHt6iZGdeeVE4ReGX
        SF15MEnxgL6wan+K8tbkMfcqeO4HgdEtfjJg3JrUClfFMQaCye5w3ZyRsf1ORJ0O
        H+/uLIGFxRX3tQK0rFVwXzjSVAx8XLbOXYUuUhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vselwb
        ExjJw6ikMBabXG4tGwIOM/tVDdj5bOsECpN/A=; b=BumDUUVkf/nswF1yF+tm2H
        zU5Hm1D1vUvg0NXlNmA3HJoUvTMrt5SMr4/iR3lQRyXlVxO4TWZd6gTwgMYHckYB
        vteXqjPb0nn1SLLgj0XolxMw1I781i6As59d8go3Fkl13rMX0nxa1fb/LBC5mUcP
        93CG+JR97iJBMbpd72+pnFovgd4M4OfZ8N45stOmxoOIXLr9h1sgTC4+7qsJUnGe
        fJmAQT5xgMCSKV0hgsSsXzgiNpMpdcd0jIy5Yf8Uww5yCuGx/sePh6gGxWLNvlX4
        ShuSGFdWh2C2dRWhH3RV1b+bqqB4MIO4tO8h6yoBdiUYtP3M08TttTs5Q5dj0EVg
        ==
X-ME-Sender: <xms:PtqiXJpVo-sdXGxt8AYbysy1ztxqLvzUQUcRVSpJ9GVDp4COxp-r0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrleehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:PtqiXPKzLfBqiF4sP03-VwJ4vAJ9jQio5ZddRKgG9ltsW2s1MipOCA>
    <xmx:PtqiXOuwStiv2a-mB_JCh3vYwLDEu2y9nO8U-b7TI9idCa1653RW_A>
    <xmx:PtqiXHsSX-OyTi8ZqISo3G0bfuBTymCJZ0pebLnu39pdFr67ja1YjA>
    <xmx:P9qiXM79vG-GWBWqg-HnkTOt7MQHaoKYRT_yIfcY3WnzcovU_HomlA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 982C27C1B9; Mon,  1 Apr 2019 23:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <e33bc539-2350-4b7d-9833-df270383b062@www.fastmail.com>
In-Reply-To: <20190329151025.204094-1-venture@google.com>
References: <20190329151025.204094-1-venture@google.com>
Date:   Mon, 01 Apr 2019 23:42:53 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Patrick Venture" <venture@google.com>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

I held off on reviewing this until we'd hashed out what we needed in the driver.

I have some comments below.

On Sat, 30 Mar 2019, at 01:40, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
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
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt 
> b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 0000000000000..088cc4e3dc54b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,48 @@
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
> + - syscon: handle to syscon device node controlling PCI.

The p2a-ctrl node is meant to be a child of the syscon. I noted this in my review
of the associated driver - you need to remove the description of the syscon
property.

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

The note above should go where you've described the syscon property above.

Cheers,

Andrew

> +
> +Example:
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
