Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3AEFC6196
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB5221848
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573088975;
	bh=i51IqLhaWTmG6/5mt82gvOQVLn8+8VELdhxMXcJKMqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ppeQ1tqNWnonupw7XOLjxdzBKxnZW/EEFIZqLFg14+NswYI7QAWGjU+gqGvIi2WJe
	 0GmioGxB/l1MlYnxtmAib4VZ80XL3mcPKdNIRURdvQ0MMEIU5Fsos0JC9F04ml7whR
	 A0IfXg4/1LI99paK9RldkEDfo9aaLmiT+Sc8EKIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfKGBJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:09:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfKGBJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:09:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so553453oto.3;
        Wed, 06 Nov 2019 17:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYYQ/Md98Kv7GDY9hpFC9qLnAqCXT03X+kalujOMXqA=;
        b=ipSvEgb0Aa7AQN8i5NEAdNGDzooKKj58ddkSyMercF5xL4W/GkdB2X0x/wYb/erwdj
         XfTYJGvU86LGXtSGNIrumBcQQQUdmYoVupCxyIGowDwKKKKgr93JZxcDyESYdMbPFWSs
         us0TjBYi4qmfo27EwilYv2JJd/EObi7G8MeUHJLmWKfct7MY1GtNGHNXJF27fzigT9xK
         wFf+Uz0h0l0BiXdox2QqXYXgOf09QhoWIlvv5G2VYp4YXCnkUkaY1kF+Npq4YkfHuQLL
         BKTww7nDWyyhbCkXxzZCipOv4HsfiMPwZbyWwDIRCtGLFPXjyN7t2l26X7NmLRrqsEUB
         Lsig==
X-Gm-Message-State: APjAAAUkIogf6wuAG+Avb1Kp73GxGfBOS52bg1EUa/Vu+9KhAh0BL/NN
        E4fIN8Md37LDl4wQ6iN2GLltCcY=
X-Google-Smtp-Source: APXvYqwFinuHimJdUtg64Zs1L4hsqa6lJbK/YjzRj2+ENZc7gQOQnidCjX7AyT/Xd6ftZepv0BMhww==
X-Received: by 2002:a9d:6294:: with SMTP id x20mr540695otk.31.1573088970151;
        Wed, 06 Nov 2019 17:09:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 41sm223441otd.67.2019.11.06.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:09:29 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:09:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mtd: mtk-quadspi: update bindings for
 mmap flash read
Message-ID: <20191107010928.GA14186@bogus>
References: <20191106140748.13100-1-gch981213@gmail.com>
 <20191106140748.13100-3-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106140748.13100-3-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:07:48PM +0800, Chuanhong Guo wrote:
> update register descriptions and add an example binding using it.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  .../devicetree/bindings/mtd/mtk-quadspi.txt   | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> index a12e3b5c495d..4860f6e96f5a 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> @@ -12,7 +12,10 @@ Required properties:
>  		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
>  		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
>  		  "mediatek,mt8173-nor"
> -- reg: 		  physical base address and length of the controller's register
> +- reg: 		  Contains one or two entries, each of which is a tuple consisting of a
> +		  physical address and length. The first entry is the address and length
> +		  of the controller register set. The optional second entry is the address
> +		  and length of the area where the nor flash is mapped to.

All the compatibles support 2 entries? If not, which ones?

>  - clocks: 	  the phandle of the clocks needed by the nor controller
>  - clock-names: 	  the names of the clocks
>  		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
> @@ -48,3 +51,19 @@ nor_flash: spi@1100d000 {
>  	};
>  };
>  
> +nor_flash: spi@11014000 {
> +	compatible = "mediatek,mt7629-nor",
> +		     "mediatek,mt8173-nor";
> +	reg = <0x11014000 0xe0>,
> +	      <0x30000000 0x10000000>;
> +	clocks = <&pericfg CLK_PERI_FLASH_PD>,
> +		 <&topckgen CLK_TOP_FLASH_SEL>;
> +	clock-names = "spi", "sf";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> -- 
> 2.21.0
> 
