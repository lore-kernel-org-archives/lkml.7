Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E3C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F7E2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="N5HOs7+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFoFNF7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGJCQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:16:06 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36031 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfGJCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:16:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EC4122460;
        Tue,  9 Jul 2019 22:16:05 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Jul 2019 22:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=5bWrIcP8UjAg5UmoomU2W8F9lAlb5kN
        yGswff6nCzsI=; b=N5HOs7+r/2TZvYRABQ4YWWnYO2Ie8R/7nMD6N3kktwfqBsc
        WFBGym4M379zo71+ww9HItVnfeB+UfwDN0ImjXLJn0ObHQhKAMJYelRmTpiq8Yew
        +b/fMAxaPcLLvHZr8zmf90JfWqg+THvTNaTR+2bzgFJ8YI7+XiF3wJ7QTeRg64ky
        jFeGA+wL7FmPh4Om49B1wfHybk7FYpKEE8tcbBvCa3FLOqLRBHlQgbrOcl1VChhd
        fTtr5u7kd6D5v3wj6lLdDNGicPCPYkIIagN2IWFZxM2XhF1B4xZ5vXlIlIp9OI1i
        1QT0G+pmCzKmK50fMWD0rLVk2Y+1IEDCZ3d2IvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5bWrIc
        P8UjAg5UmoomU2W8F9lAlb5kNyGswff6nCzsI=; b=rFoFNF7VTheq4MajAP4eWv
        tCsH1eTUG0hw6Jrj4alZRgVhsi9z+1yo5Ki4CcyHJeTQrUKgA0eBjlBT4cpB+zbh
        YwnEMC9DNOCYG9yj0wXMcPpNLc61O0XEGuVi4N3pCtoON5S3G535G8rKiDI+ST5x
        JvXYjl0BYv7/OT8u48OCPXIjzRlq1NSXcNYUo0bn9ptWy8Kt+To1Ax4EA9CrCLq/
        USWx/QMWwveWfEX/khKk3vNvAejc6gXrxAoDyvXuQVXgmjeMWOiautovFyB/Gnte
        ce571NETXRQCPiZdoQov0gMqwyvSbnQZvf4MKq8WrZbbW9/yyrHrUmbmJhr6x8Qw
        ==
X-ME-Sender: <xms:ZEolXR3XnW_F9wcBrukA_vPC2dshfB1wGZn2h4ZUZ0bQjppNTjH8wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:ZEolXS43bZlKOBuVAFi2pePMIKLwiGbiXq37QxMkh0yqvzh_t-HQFA>
    <xmx:ZEolXQKfowdlI6P6qiLUQ9hrUZy1MZCBAAWumnxtXs0luTEi4dUC1Q>
    <xmx:ZEolXeY3Rp21OAB7TFnCNpY1KXNW-ANyIw6U73CgV89AwKq_qGmvuQ>
    <xmx:ZUolXeCjcCokGqAaci2yJaWt4bTUso15OfSVoGw9WKt9nsq8t9lb8Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 660EFE0193; Tue,  9 Jul 2019 22:16:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <9c998f5f-42ef-43bd-b024-839ee00126de@www.fastmail.com>
In-Reply-To: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
References: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
Date:   Wed, 10 Jul 2019 11:46:09 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Hongwei Zhang" <hongweiz@ami.com>, devicetree@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jul 2019, at 05:31, Hongwei Zhang wrote:
> Add bindings to support SGPIO on AST2400 or AST2500.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt 
> b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> new file mode 100644
> index 0000000..f5fc6ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> @@ -0,0 +1,36 @@
> +Aspeed SGPIO controller Device Tree Bindings
> +-------------------------------------------
> +
> +Required properties:
> +- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
> +
> +- #gpio-cells 		: Should be two
> +			  - First cell is the GPIO line number
> +			  - Second cell is used to specify optional
> +			    parameters (unused)
> +
> +- reg			: Address and length of the register set for the device
> +- gpio-controller	: Marks the device node as a GPIO controller.
> +- interrupts		: Interrupt specifier (see interrupt bindings for
> +			  details)
> +- interrupt-controller	: Mark the GPIO controller as an 
> interrupt-controller

As this is a serial GPIO controller, a critical piece of configuration
information is how many GPIOs we wish to serialise. This is done
in multiples of 8, up to 80 pins.

The bindings need to describe the "ngpios" property from the
generic GPIO bindings and how this affects the behaviour of
the controller.

We also need to add the "bus-frequency" property here to control
the rate of SGPMCK.

> +
> +Optional properties:
> +
> +- clocks                : A phandle to the clock to use for debounce 
> timings

We need this, but not for the reason specified, and it should be a
required property. We need PCLK (the APB clock) to derive the SGPIO
bus frequency. Despite what the datasheet blurb says, there's no
debounce control for the SGPIO master (this is a copy/paste mistake
from the description of the parallel GPIO master).

> +
> +The sgpio and interrupt properties are further described in their 
> respective
> +bindings documentation:
> +
> +- Documentation/devicetree/bindings/sgpio/gpio.txt
> +- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +  Example:
> +	sgpio@1e780200 {
> +		#gpio-cells = <2>;
> +		compatible = "aspeed,ast2500-sgpio";
> +		gpio-controller;
> +		interrupts = <40>;
> +		reg = <0x1e780200 0x0100>;
> +		interrupt-controller;
> +	};

You'll need to fix up the example after making the changes mentioned
above.

Andrew

> -- 
> 2.7.4
> 
>
