Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D91C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C7A206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556289031;
	bh=+CgIByK4xaetqopphwulVdK7RYppoILHRQ9dNf0zA74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xWsoZXu1D+krKbSLKRQBI3cLTOusNIqs4Ksxubeq49fmtzJkyQpmCsNah/6jIzYCb
	 a+qmmuEAHu9sfSVWeg6Rb6hB7Ug4Z3qY2wJ6WuijC0hZ/Cn78FDpXdv0ijYy5Uvwuk
	 if1/u7wBrxH2Vh8M502cMCfuOoPMaOo7DHgQVjLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:30:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36218 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:30:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so3100289oia.3;
        Fri, 26 Apr 2019 07:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNG/0QpUCaT9lx2u5hHDw2Uwd0JzNWO4DjhMbkVIeuw=;
        b=jdTAcF+aJFooptJRfOuLufmI7QrRIRBZfPnyQanG+sQjzsuIwPOVbK1DdoXMcxkUXN
         ZH5nnFG3gqeJQ2d3DnNH2B8i1m7hQebKEytxO+eKPdrOEBwtsVUs+yl63reMP+Fq8UuE
         5/EhW+cNDvue2KmKT5OdVjjLnH6AYdLY0eo9+N+1dx0EiVxVLeMnh656mmBEFzCli/3Z
         sxtSq2gLWjM4C1gqnGuQWxYHDNr90w0u6eRrvxQTUiFGqvk1ihktUszqDbpQ5OmYXkPC
         ujiMUIUolQF1B1Ntsxz9KDnWrxL9UM7upStzvY2cIFGcOtoQw4juuraQWEJlhEiyQIVI
         qwsw==
X-Gm-Message-State: APjAAAWnoWUATd1xiGSjhv5TT913MRh9ywCWB5pR92yX5b3vddswmhIl
        a+BgYeB49VB8hVUrdSklpQ==
X-Google-Smtp-Source: APXvYqy6niOVpevFXbrBpfSYrmPPwaca4AgezLS9/JVhRiw+sgF2t41sPPeQDVj7hkQenEW/O8z3Iw==
X-Received: by 2002:aca:da07:: with SMTP id r7mr7638281oig.5.1556289028625;
        Fri, 26 Apr 2019 07:30:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm9969662otq.68.2019.04.26.07.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:30:27 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:30:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20190426143027.GA17777@bogus>
References: <20190423095107.21091-1-gregory.clement@bootlin.com>
 <20190423095107.21091-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423095107.21091-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:51:02AM +0200, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 7b8b8eb0191f..a65d3e9ff915 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -143,3 +143,29 @@ ap_syscon1: system-controller@6f8000 {
>  		#thermal-sensor-cells = <1>;
>  	};
>  };
> +
> +Cluster clocks:
> +---------------
> +
> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> +cluster contain up to 2 CPUs running at the same frequency.
> +
> +Required properties:
> +- compatible: must be  "marvell,ap806-cpu-clock";
> +- #clock-cells : should be set to 1.
> +- clocks : shall be the input parents clock phandle for the clock.
> +- reg: register range associated the cluster clocks, offset must be 0
> +  and the size have to be the whole size of the system-controller
> +
> +
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";

This should have a specific compatible.

> +	reg = <0x6f8000 0x1000>;
> +
> +	cpu_clk: clock-cpu@0 {
> +		compatible = "marvell,ap806-cpu-clock";
> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
> +		#clock-cells = <1>;
> +		reg = <0x0 0x1000>;

This takes the entire address range of the parent, then why the child 
node? You can't add any other child nodes without creating an overlap.

Your example also won't compile.

Rob
