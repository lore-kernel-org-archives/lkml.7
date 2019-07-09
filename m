Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61644C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1D2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562703053;
	bh=6KeAg4M0ZNJdEfil41ivnYQhcpz7Cpb/a0UYFg5mDgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jhoJfdORs8Xv3az5IhFl3yoUUtE2Rw+W0WndX+qjLf9JKi3u+qHNqv5v9m41sF7Ty
	 wwf5OWF98x/xeZKc3SJ90GAtBAWcvyMO5Egn9OUbeFlIQQ38VMeYQpt8J8uAmwC3sW
	 AxYNvjX/EcEXeg+nX4kMPfi7a+7fb2BZtWBJDk4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfGIUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:10:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32800 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfGIUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:10:52 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so30950149iog.0;
        Tue, 09 Jul 2019 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=luNJE8BvXARpab3XzCQ15FBQrWF1rNzC/iLJy1IUEEs=;
        b=CV03TCigFfARpQ32DkdMLDr1idxPE5RkcSarymnNfE3qLbKKqRMi/NYyoUuVcLxbaJ
         mUGV2jfzprgsYztZ6jc9ugja1Wr4SwnAYdbml6fQMBb46e5ed5N6BHQ6ndWUDbdzVABQ
         666l2UasrXaiSFNQW4ujdJ3kp788vqvZRq0DXi9Ni8nevkKI8vIKWycefu/sysbFwZzi
         QBw1Fa8zQZytfFSKnqnj0IPL1mXreA8JXOHzqVuSsNTALOcivGJHm17WO85XmO+ZQ/MP
         2aJPyihiB0NiAaTDGFRZGDkG9J3ApzAgdppXrp3nWWYde7rEbtVN/LGVdbTEjxiSfiUN
         H/Sw==
X-Gm-Message-State: APjAAAVOeU4SDewD6/CuvG7Tgaz4p/0sXG7VshsyZ8q8jD9Ki+wOlrXD
        EAL67yWrk6der2jPXeKI1Q==
X-Google-Smtp-Source: APXvYqwF5+aQ/lNe/JZtahZEU+glNSOV421HouSJnPFiLSoCgOmuEapJp66+Clcdr1Iz0ijEWr4gKg==
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr5766700iok.252.1562703051005;
        Tue, 09 Jul 2019 13:10:51 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t4sm17166284iop.0.2019.07.09.13.10.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:10:50 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:10:49 -0600
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
Subject: Re: [PATCH v6 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20190709201049.GA8692@bogus>
References: <20190619141539.16884-1-gregory.clement@bootlin.com>
 <20190619141539.16884-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619141539.16884-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 04:15:34PM +0200, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 7b8b8eb0191f..4a3bb9c12312 100644
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

How many clocks?

> +- reg: register range associated with the cluster clocks
> +
> +
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "marvell,armada-ap806-syscon1", "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	cpu_clk: clock-cpu@0 {

Should be '...@274'

> +		compatible = "marvell,ap806-cpu-clock";
> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
> +		#clock-cells = <1>;
> +		reg = <0x274 0xa30>;
> +	};
> +};
> -- 
> 2.20.1
> 
