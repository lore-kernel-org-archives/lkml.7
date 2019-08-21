Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98264C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BCB206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566421867;
	bh=+VJ9BnZMEd5OG2sv/6xiu+7Kz9m45pMGGNtS1ilREYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0pG7llUDPKmwmmvS7TSuy+64CfpbyVwVpdBEw61Ena+3QXtlhwE7pByd8j/mPZia0
	 sgylceU51nyapvJhc856zJ10p0BLC6in97AMplSsv1lQq8GDqAnaBq30GBoi0CrwkR
	 LJJj5o+qHKY5Qqpvhzi6o4gZgpUF00N4ZsubNNiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfHUVLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:11:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41192 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfHUVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:11:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so2726575oia.8;
        Wed, 21 Aug 2019 14:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRsSuAZz6QfRjgNZ8P6+tSp6lptZDI8kWZHn7cMGurw=;
        b=n+ISQv0qXFpd58yYWcUbrG0e0MoQ7HIJtg0rMXnzW94EI6zF9gZXM6+gehybL8i39O
         SnTubL7QV4MtLgfYGzPDunFhRVVzaxVyPAv4JY0k0eGh2QAsnZ4s2MwmGKXUrIlGwwd4
         zyRrktMJIA2ApFBUAzuoUQRPlMAlTQPfeIrHGu9XPFrkmIFfk8Gar5G2SZzEB3geCNRV
         lYrvmzDnVj2gOr5uWem1PAuFrGqT4m9YjCBGaAtKQmURl3mOyM4HMHgDccP1sWv2MaX2
         C3ew/iJjfd8OLCntLRvObtIxbtkdE0FvPOUi3OCWVQ+ZZ3bJZ1xvBXWsMsmwj6kqXUC3
         Ig+Q==
X-Gm-Message-State: APjAAAVHS/fb2yxsz75R0Ar6mvxOcANd+wT7Jec4KAr6VpG6FBlW/xDz
        e2ww42DThrrGIOzpmmYMiA==
X-Google-Smtp-Source: APXvYqxSDZHs4c1PVvP+wjeXiVw6s6Xa1KEl627aBD7it4c2vHLG2m+iz6Z0UmTJ9EmpncnD8q2VwA==
X-Received: by 2002:aca:4950:: with SMTP id w77mr1468364oia.28.1566421864593;
        Wed, 21 Aug 2019 14:11:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm8184684otk.64.2019.08.21.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:11:04 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:11:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 03/19] dt-bindings: mrvl,intc: Add a MMP3 interrupt
 controller
Message-ID: <20190821211103.GA32263@bogus>
References: <20190809093158.7969-1-lkundrak@v3.sk>
 <20190809093158.7969-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809093158.7969-4-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:31:42AM +0200, Lubomir Rintel wrote:
> Similar to MMP2 one, but has an extra range for the other core. The
> muxes stay the same.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../interrupt-controller/mrvl,intc.txt        | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
> index 608fee15a4cfc..41c131d026f94 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
> @@ -1,13 +1,15 @@
>  * Marvell MMP Interrupt controller
>  
>  Required properties:
> -- compatible : Should be "mrvl,mmp-intc", "mrvl,mmp2-intc" or
> -  "mrvl,mmp2-mux-intc"
> +- compatible : Should be "mrvl,mmp-intc", "mrvl,mmp2-intc",
> +  "marvell,mmp3-intc", "mrvl,mmp2-mux-intc"

Reformat to 1 valid combination per line.

>  - reg : Address and length of the register set of the interrupt controller.
>    If the interrupt controller is intc, address and length means the range
> -  of the whole interrupt controller. If the interrupt controller is mux-intc,
> -  address and length means one register. Since address of mux-intc is in the
> -  range of intc. mux-intc is secondary interrupt controller.
> +  of the whole interrupt controller. The "marvell,mmp3-intc" controller
> +  also has a secondary range for the second CPU core.  If the interrupt
> +  controller is mux-intc, address and length means one register. Since
> +  address of mux-intc is in the range of intc. mux-intc is secondary
> +  interrupt controller.
>  - reg-names : Name of the register set of the interrupt controller. It's
>    only required in mux-intc interrupt controller.
>  - interrupts : Should be the port interrupt shared by mux interrupts. It's
> @@ -20,7 +22,7 @@ Required properties:
>  - mrvl,clr-mfp-irq : Specifies the interrupt that needs to clear MFP edge
>    detection first.
>  
> -Example:
> +Examples:
>  	intc: interrupt-controller@d4282000 {
>  		compatible = "mrvl,mmp2-intc";
>  		interrupt-controller;
> @@ -29,6 +31,15 @@ Example:
>  		mrvl,intc-nr-irqs = <64>;
>  	};
>  
> +	intc: interrupt-controller@d4282000 {

What's special about this to warrant another example. Examples aren't 
supposed to be an enumeration of all possible dts entries.

> +		compatible = "marvell,mmp3-intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0xd4282000 0x1000>,
> +		      <0xd4284000 0x100>;
> +		mrvl,intc-nr-irqs = <64>;
> +	};
> +
>  	intcmux4@d4282150 {
>  		compatible = "mrvl,mmp2-mux-intc";
>  		interrupts = <4>;
> -- 
> 2.21.0
> 
