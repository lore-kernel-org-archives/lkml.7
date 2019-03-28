Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67767C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33046206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553793235;
	bh=VosJJsvAijZFo4pN9YC/8nciusGgK9mvdANx4wy9OCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SCW1zpPi3XmfYSpMrDt48X3sVvMhtulqh/x3q9j6N0IrO68Y/23/MLXLN07tHhL4n
	 SPdumMTTYUu8dUPYZLNFosCIvtqtB0BytmWpa3idWhIil806N6JxaBUjf7pEcpuMul
	 BZajHJdW2dqvqzQvLQs+YYjBX2K9mlGfrWNy3Xn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfC1RNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:13:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44569 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1RNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:13:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so4530224otl.11;
        Thu, 28 Mar 2019 10:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG5jHi4YxWkaT7WEpBMD91KRCE92RCx2jKSw1WWZNG0=;
        b=jWWH8XCPZuMWWTH2zOylmOginJ8wUfsbzLFvu10rHzz4vZU+CPO+2YR/v5ITyV2GBy
         QvcCX7bo3x4flC9a5ScU6HJCnyAEM8dXrhRmwKTsU3rq82LjAM09iHcytrbJlEOCBKYC
         QgerOqVj4RaWTL3GfygKijCzO13Lh0MfP01hK24smGTe6lR3ZGuxww/IlJ2jZaF/02Ua
         fjv+k/Oi3KyuR02aayQWer2A7TJT+9Hx2fZh+smw/leqdrRi9A5QM2s+M8wBAPybGiGS
         ml4v7Kk8q1FagtLo6TM+H65cibdi7o/dhT9cqd17tWAGsxJzSgcT4AwWTlq+gXO72pNs
         ERLA==
X-Gm-Message-State: APjAAAUAUwW53JYvLRd2uDWB7GkkeUzsfCtD+x6EhENk2bPKOGDSy43A
        qw7LD7kIq4OnTFGsDVOI1g==
X-Google-Smtp-Source: APXvYqyXV81/UQTnLuXAhp8zNPRE08uBnV6G8EQHClGRx2t2aUDgygsF2BXGJTeRKO6nRqx53mXxaA==
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr14351125otr.117.1553793231742;
        Thu, 28 Mar 2019 10:13:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm2860323oic.32.2019.03.28.10.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:13:50 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:13:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
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
Subject: Re: [PATCH v4 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20190328171350.GA26680@bogus>
References: <20190325124803.28904-1-gregory.clement@bootlin.com>
 <20190325124803.28904-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325124803.28904-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:47:58PM +0100, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 7b8b8eb0191f..ceeba18b4ac3 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -143,3 +143,28 @@ ap_syscon1: system-controller@6f8000 {
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
> +
> +Optional property:
> + - reg: register range associated the cluser clocks

reg can be optional to use, but should either be there or not.

And there's a typo.

> +
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	cpu_clk: clock-cpu {
> +		compatible = "marvell,ap806-cpu-clock";
> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
> +		#clock-cells = <1>;
> +	};
> +};
> -- 
> 2.20.1
> 
