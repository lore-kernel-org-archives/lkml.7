Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC7C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C1D2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578455742;
	bh=JftRvXVFwQzK5TFz0eBlDkz/oVyzRb8OT45eKAi6z8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1u6vJCJvTn8XdImIyzLlI/Vrk8RuC/DaZ6EIJeno52wlLHK25haHJ/f6ThDdDsG1
	 pS+wt4AxnL+Yzu1Y9/yffW3KpUEZ9TTyn/66fwoTS4cUUGV5FVHm8EomUMZo/sGfQ3
	 83dfD5U+197C5P3avJHjPLb/Blxjpy6wu3WnC7uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgAHDzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:55:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45459 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:55:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so2226556otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLfZmUczJHxkBJ7qYbPJXerVFSLgsQsJgvS5hmfmovA=;
        b=tAGDonicHDwatPwnv7BCkloURrfRym2tQ/X7b1w+2xHtKgbmkoS7LkUKtFwgabXiA5
         HCEISGyVzd1xXWdt4vNeHHrEnpq/OD3qnqm+3DRuKW5mwYXKVXY11IQO7feRzaEXBdtZ
         aN16gMEoBc5hEG70xd4qwSMujpLxe9Vn3z3fxV8NP4xHq55ZilA5VS24oRYEimNnD6jQ
         2b/WokUcodmsVd4d1A2iJSQSK50GcAUhrEq1pxcjWCt5VW76UCnXolPldXflWPaxZZEE
         r+WFae49uYXd9dTh9dIYgGRVFLG6ZrupjVibflqVO0NxX8oTrJFyG6mPwSrP1q3mcNBp
         7ETA==
X-Gm-Message-State: APjAAAVvUV+jQHtmrV/v7tBprAMBslk+b9GZbAJFeSnIekyC7xihyhfE
        iJfHCXV1FaV4IVcwNkICCurR1Vw=
X-Google-Smtp-Source: APXvYqyqZFDwe8uYJKD0qmSvqUkNLrOj3QXGfZ9mc0W7mNWmqyIkn30ngDkui66DnK/iTrT8yMC32w==
X-Received: by 2002:a05:6830:1f95:: with SMTP id v21mr2732579otr.325.1578455739478;
        Tue, 07 Jan 2020 19:55:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f4sm701873oij.25.2020.01.07.19.55.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 19:55:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219e3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 07 Jan 2020 21:55:37 -0600
Date:   Tue, 7 Jan 2020 21:55:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add UniPhier external DMA
 controller bindings
Message-ID: <20200108035537.GA7843@bogus>
References: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 09:56:59AM +0900, Kunihiko Hayashi wrote:
> Add external DMA controller bindings implemented in Socionext UniPhier
> SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/dma/uniphier-xdmac.txt     | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-xdmac.txt

Please make this a DT schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> new file mode 100644
> index 00000000..4e3927f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> @@ -0,0 +1,86 @@
> +Socionext UniPhier external DMA controller bindings
> +
> +This describes the devicetree bindings for an external DMA engine to perform
> +memory-to-memory or peripheral-to-memory data transfer, implemented in
> +Socionext UniPhier SoCs.
> +
> +* DMA controller
> +
> +Required properties:
> +- compatible: Should be "socionext,uniphier-xdmac".
> +- reg: Specifies offset and length of the register set for the device.
> +- interrupts: An interrupt specifier associated with the DMA controller.
> +- #dma-cells: Must be <2>. The first cell represents the channel index.
> +	The second cell represents the factor for transfer request.
> +	This is mentioned in DMA client section.
> +- dma-channels : Number of DMA channels supported. Should be 16.

If always 16, then why do you need this?

> +
> +Example:
> +	xdmac: dma-controller@5fc10000 {
> +		compatible = "socionext,uniphier-xdmac";
> +		reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
> +		interrupts = <0 188 4>;
> +		#dma-cells = <2>;
> +		dma-channels = <16>;
> +	};
> +
> +* DMA client
> +
> +Required properties:
> +- dmas: A list of DMA channel requests.
> +- dma-names: Names of the requested channels corresponding to dmas.
> +
> +DMA clients must use the format described in the dma.txt file, using a two cell
> +specifier for each channel.

No need to redefine the client binding here. Just need the cell format 
as below.

> +
> +Each DMA request consists of 3 cells:
> + 1. A phandle pointing to the DMA controller
> + 2. Channel index
> + 3. Transfer request factor number, If no transfer factor, use 0.
> +	The number is SoC-specific, and this should be specified with relation
> +	to the device to use the DMA controller. The list of the factor number
> +	can be found below.
> +
> +	0x0	none
> +	0x8	UART ch0 Rx
> +	0x9	UART ch0 Tx
> +	0xa	UART ch1 Rx
> +	0xb	UART ch1 Tx
> +	0xc	UART ch2 Rx
> +	0xd	UART ch2 Tx
> +	0xe	UART ch3 Rx
> +	0xf	UART ch3 Tx
> +	0x14	SCSSI ch1 Rx
> +	0x15	SCSSI ch1 Tx
> +	0x16	SCSSI ch0 Rx
> +	0x17	SCSSI ch0 Tx
> +	0x18	SCSSI ch2 Rx
> +	0x19	SCSSI ch2 Tx
> +	0x1a	SCSSI ch3 Rx
> +	0x1b	SCSSI ch3 Tx
> +	0x21	I2C ch0 Rx
> +	0x22	I2C ch0 Tx
> +	0x23	I2C ch1 Rx
> +	0x24	I2C ch1 Tx
> +	0x25	I2C ch2 Rx
> +	0x26	I2C ch2 Tx
> +	0x27	I2C ch3 Rx
> +	0x28	I2C ch3 Tx
> +	0x29	I2C ch4 Rx
> +	0x2a	I2C ch4 Tx
> +	0x2b	I2C ch5 Rx
> +	0x2c	I2C ch5 Tx
> +	0x2d	I2C ch6 Rx
> +	0x2e	I2C ch6 Tx
> +
> +Example:
> +	spi3: spi@54006300 {
> +		compatible = "socionext,uniphier-scssi";
> +		reg = <0x54006300 0x100>;
> +		interrupts = <0 39 4>;
> +		clocks = <&peri_clk 14>;
> +		resets = <&peri_rst 14>;
> +
> +		dmas = <&xdmac 0 0x1a>, <&xdmac 1 0x1b>;
> +		dma-names = "rx", "tx";
> +	};
> -- 
> 2.7.4
> 
