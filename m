Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA0DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109DF22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566421014;
	bh=EcwaFkLQlmpTNJJmpwIY/fqdt6xFFKVOW0XyvB4C/OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W7gH2KfbXNZwonKrDrS2dj8stnDcaLNuvngfUjvqW89HW8b9D8Wy8JbdSle8dmzXJ
	 eutYURMomjoavQR4nPAvbLRIRgR1b77/6c6DIWbwsMlsZzBwHAg+4ntblAbygblHDt
	 EYlj1oH/iGe/wcoxTU0wg288cgFLKkPyGpJM7z34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfHUU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:56:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34394 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:56:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so3428031otp.1;
        Wed, 21 Aug 2019 13:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cw5zVFDgnti+9h09SHubCz/1zUqdZG2/3ACA1Sozj6M=;
        b=W+8fXbGV11r0GfVfolnorGu/FhbVPww2UW+KreQOVjd31gcedivq5XjBsRWIFVo4dM
         sZBZWCuH+zF9gTecnVyMQHmuNKed/EORt2B+0SFfTpnQYPENONEJST4kOc4EdpbQy/Y1
         Lsn3OunwaMq594mpksRzFQGB7uUb40m8Kexy8fAhdKwrRlXhvH+TBPJDZuGltEd6CqWd
         W5Yr+wfVMCMo7O1QC6/iqH1CuUy07KiSAOya1+GZkImpYcwdr2W7Y8PUnUQd/CTnBAN0
         CXz6/B5dS1iiUju7FJxelKh9rzn5ZatJnQmFaeo2lf10SYQpYnaPkjZ1CzJBcHA4xP7Z
         iwlQ==
X-Gm-Message-State: APjAAAWawkQCZ/2hWSnYFvjAY7h4876jaFhV3sh4Pzf64VIAELi4uBuf
        ZXH5FZ7NmcH0G1OxG79Ze1bbDCc=
X-Google-Smtp-Source: APXvYqwkzyR5k2lVn9jQ7SWqN03g1X/p1BcvTAz47w4p4sCmgewK0YLxZltsj/wiQTiBJlsmcwM1OA==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr6886407otr.222.1566421011342;
        Wed, 21 Aug 2019 13:56:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm8447750otm.5.2019.08.21.13.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:56:50 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:56:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com, vigneshr@ti.com,
        bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: spi: add NPCM FIU controller
Message-ID: <20190821205650.GA14884@bogus>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
 <20190808131448.349161-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808131448.349161-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:14:47PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM Flash Interface Unit(FIU) SPI master controller
> using SPI-MEM interface.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/spi/nuvoton,npcm-fiu.txt         | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
> new file mode 100644
> index 000000000000..ab37aae91d19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
> @@ -0,0 +1,47 @@
> +* Nuvoton FLASH Interface Unit (FIU) SPI Controller
> +
> +NPCM FIU supports single, dual and quad communication interface.
> +
> +The NPCM7XX supports three FIU modules,
> +FIU0 and FIUx supports two chip selects,
> +FIU3 support four chip select.
> +
> +Required properties:
> +  - compatible : "nuvoton,npcm750-fiu" for the NPCM7XX BMC
> +  - #address-cells : should be 1.
> +  - #size-cells : should be 0.
> +  - reg : the first contains the register location and length,
> +          the second contains the memory mapping address and length
> +  - reg-names: Should contain the reg names "control" and "memory"
> +  - clocks : phandle of FIU reference clock.
> +
> +Required properties in case the pins can be muxed:
> +  - pinctrl-names : a pinctrl state named "default" must be defined.
> +  - pinctrl-0 : phandle referencing pin configuration of the device.
> +
> +Optional property:
> +  - spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.

Is this something standard? If not, add a vendor prefix.

> +
> +Aliases:
> +- All the FIU controller nodes should be represented in the aliases node using
> +  the following format 'fiu{n}' where n is a unique number for the alias.
> +  In the NPCM7XX BMC:
> +  		fiu0 represent fiu 0 controller
> +  		fiu1 represent fiu 3 controller
> +  		fiu2 represent fiu x controller
> +
> +Example:
> +fiu3: fiu@c00000000 {

spi@...

> +	compatible = "nuvoton,npcm750-fiu";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
> +	reg-names = "control", "memory";
> +	clocks = <&clk NPCM7XX_CLK_AHB>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi3_pins>;
> +	spi-nor@0 {
> +			...
> +	};
> +};
> +
> -- 
> 2.18.0
> 
