Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606FBC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDB92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556310029;
	bh=4RA8k3PWqMTHXSAnn1mkH3JpOxozLJSGW6a84K5SO5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J4AES07n/UP2+W95mFSAmUglYHI9sfeJW6faqMQQCltto8j1MI+TQyrIOb/s91XGG
	 Ebn7tQdldEgqbAta3bhV7bBPupXYmmOVK45xGdrCMZo0J3VPJgSO0K1HcYeOV4qQBU
	 mP8myAa0Xvr13J0JW64Q8DQlcePaPGWnQJJWUCHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZUU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:20:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40712 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:20:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id w6so3725193otl.7;
        Fri, 26 Apr 2019 13:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9z5p1QaGpPctFP5YJCgd6/+EOVf9obi55JfjI0sjSoM=;
        b=UPI/7LHje5XwQ1FvIA5zUL9+gYtdBwzt/JOH3kF3vUd0+2k1PDx9oLUry7ijAUY8Pk
         u9qF+04CnS0Iyl4/S31orHrZSWE4u19WTnuPAKM4ETSrvlLLV6TiH3VWqpmbLLjazz5D
         9R+0lI/jkuOodRl/0vZr06Qsw2tPcaUETumYWABf+FgjJ8tpEy91W3/l1iSwVO+3p1Fx
         b0Zvy/TM9ZHwtLJQvuob+kJjsM8k+sURmdC+cBibGTAnp2khITG0YJSDbwBACw/PJBe+
         v4uv5U6+rcEfTZ1DjdrhQbAbAfvm3rAJNXKAgG5tsV/zWDQoAt2A4choXcdsVfgrHIXS
         jmsQ==
X-Gm-Message-State: APjAAAWLe8/n8OakyFabeev1vOrKKFncGq/8gIcpzsTle6MwvZ/T8XxY
        MU0pI/LPuu7Jtph8qhluWg==
X-Google-Smtp-Source: APXvYqz/+MGdetWcvDZ7xWRB+IWKMwc7ItdeKW49XlGFTg8fKUk0WnlYDghJOZxIGqYp7TapnHODgA==
X-Received: by 2002:a9d:3663:: with SMTP id w90mr5340778otb.189.1556310027070;
        Fri, 26 Apr 2019 13:20:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b2sm469508otf.48.2019.04.26.13.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:20:26 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:20:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: mtd: Add bindings for TI's AM654
 HyperBus memory controller
Message-ID: <20190426202025.GA24486@bogus>
References: <20190423104814.5762-1-vigneshr@ti.com>
 <20190423104814.5762-5-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423104814.5762-5-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:13PM +0530, Vignesh Raghavendra wrote:
> Add binding documentation for TI's HyperBus memory controller present on
> AM654 SoC.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 32 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> new file mode 100644
> index 000000000000..fc87c7918389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> @@ -0,0 +1,32 @@
> +Bindings for HyperBus Memory Controller (HBMC) on TI's K3 family of SoCs
> +
> +Required properties:
> +- compatible : "ti,am654-hbmc" for AM654 SoC
> +- reg : Two entries:
> +	First entry pointed to the register space of HBMC controller
> +	Second entry pointing to the memory map region dedicated for
> +	MMIO access to attached flash devices
> +- ranges : Address range allocated for each chipselect in the MMIO space
> +
> +Optional properties:
> +- mux-controls : phandle to the multiplexer that controls selection of
> +		 HBMC vs OSPI. Mux state of 1 indicates HBMC is selected.

So 1 is also the default because your example doesn't have the property?

> +
> +Example:
> +
> +	hbmc: hbmc@47034000 {
> +		compatible = "ti,am654-hbmc";
> +		reg = <0x0 0x47034000 0x0 0x100>,
> +			<0x5 0x00000000 0x1 0x0000000>;
> +		power-domains = <&k3_pds 55>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
> +			 <0x1 0x5 0x04000000 0x4000000>; /* CS1 - 64MB

This is wrong. You need 2 cells for the child address. The first cell is 
the CS and the 2nd cell is the offset (typically 0). Otherwise you have 
overlapping addresses with child addresses 0 and 1.

> +
> +		/* Slave flash node */
> +		flash@0 {

And then the unit-address here would be '0,0'.

> +			compatible = "cypress,hyperflash";

Doesn't match what you defined for this binding.

> +			reg = <0x0 0x4000000>;
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5f22f85c848..1ade81f9a32a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7258,6 +7258,7 @@ S:	Supported
>  F:	drivers/mtd/hyperbus/
>  F:	include/linux/mtd/hyperbus.h
>  F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
> +F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>  
>  HYPERVISOR VIRTUAL CONSOLE DRIVER
>  L:	linuxppc-dev@lists.ozlabs.org
> -- 
> 2.21.0
> 
