Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BE6218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551383603;
	bh=VHOZSt3/lGcwjw0jMV3D5wi+d80WAu1Ey4VzJKay0yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UnKsFN+UW/sxwF+e1HYLnlna4AZySyqGEZOFHoLsez/m/S0tCWcmJSf0kiOD+9h8w
	 96+G3Bt5+YyNKh1EMX/yLTBRlCbV6g9zc6SkH8AaNFUK+ag0kt95MDdaAfbFONwwUo
	 2Jz5ZjSqM2TLOcZ8p7FrHITYqhJVEmkYCybks6HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfB1TxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:53:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39420 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1TxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:53:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id e15so9242086otk.6;
        Thu, 28 Feb 2019 11:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSH0ECHj/ABaHItasGXv6gcJGL6UIhUfL8xXvasQiBw=;
        b=D6YTga7UFz35jd/nS31kynv71yr6irq24HtLf+s/YJwwexZN8LmPqQhaQ3ryAoHbZX
         /XhR+P0HoV6gb3TquvMaWFiKglWFDQqy6XCT6JW5hRIOKCAmCZAj2grXzgqR7xOL0UY5
         Sz5N4g0EiI+01y/P4tymWM7/+ekjOzRR3BR7ZzXOu9iEac6aqtIfXK1kz9Bjkf2+MkFT
         wSZLgLCB102PDt68hEMoFKjxpbe9HR1yE9TPp/OTwB5olzUOKt6GReQBBmOMJmJGiZMq
         TZwh1+UdjMZM+dlktBdz/gPD9ULSbB17JK8KxvjRdshKBpA3a4CQFMJ1QH9saB97OtNX
         ipCw==
X-Gm-Message-State: APjAAAWcJ9dB4Js1BDmZ2/gidQhGoKPmqKlA4fbGmnmy5DNwwGhSt28k
        vGmM/SrIDpTxcQlHnIy/hg==
X-Google-Smtp-Source: APXvYqzc5kyVhsn2GqpBakhlHjIjKBVm3Iouo8uT1dLj3QLCOOR8zkjzx7mmq5NTWrTgauEyDLULXA==
X-Received: by 2002:a9d:6755:: with SMTP id w21mr869911otm.87.1551383600911;
        Thu, 28 Feb 2019 11:53:20 -0800 (PST)
Received: from localhost ([2607:fb90:20de:307f:59ce:35b2:628:2365])
        by smtp.gmail.com with ESMTPSA id o124sm1718250oif.14.2019.02.28.11.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:53:20 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:53:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, broonie@kernel.org,
        lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: sprd: Add dma properties to
 support DMA mode
Message-ID: <20190228195319.GA13133@bogus>
References: <cover.1550560916.git.baolin.wang@linaro.org>
 <8f0a032f9bcce28bb0d147f9646950f64fc22a74.1550560916.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0a032f9bcce28bb0d147f9646950f64fc22a74.1550560916.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 03:31:14PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> This patch adds dmas and dma-names properties for the UART DMA mode.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> index 6eb5863..9ac28f6 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> @@ -15,12 +15,18 @@ Required properties:
>    UART clock and source clock are optional properties, but enable clock
>    is required.
>  
> +Optional properties:
> +- dma-names: Should contain "tx" for transmit and "rx" for receive channels.

The order here doesn't match the example.

> +- dmas: A list of dma specifiers, one for each entry in dma-names.
> +
>  Example:
>  	uart0: serial@0 {
>  		compatible = "sprd,sc9860-uart",
>  			     "sprd,sc9836-uart";
>  		reg = <0x0 0x100>;
>  		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +		dma-names = "rx", "tx";
> +		dmas = <&ap_dma 19 19>, <&ap_dma 20 20>;
>  		clock-names = "enable", "uart", "source";
>  		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
>  	};
> -- 
> 1.7.9.5
> 
