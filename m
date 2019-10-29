Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5709CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F642087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572386503;
	bh=3fc7Ts5HHom8d34FAVmiMY7ndX39+/H9gZugDWD7gs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M54MvscKW51kYqiw5yY0xuiUihvjDueR1qDw9lDlctdkou5ihpPCJltMe/5BS3i+t
	 jOClZRwbQrheeiHb/nP8et5RrhL9bUDz5hsTNTlIUEaUoXp8ZH1HQgu2AXOOlEAWX4
	 Q1M+WW/2Stm7NfzipkIvMvCrqoKyupiGGDHiqGJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfJ2WBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:01:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35389 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfJ2WBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:01:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id n16so237785oig.2;
        Tue, 29 Oct 2019 15:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qg4Gf6moqefeeqI07wtw6l7UkCvJIw6VyE8bqTKlLAc=;
        b=iVriIAyDX9iR7k4l7rhANxZePMZrDljZPOx3VH61qQVkLzq09PZfUpdXnCOWOBKu0U
         xSGTDeP1joLFWrPX6VC0Fz0S3l2FVBqscQ/lw7gs8EKIMABm6Pz9jcC227DeT4zD+bqt
         nVY+DHcePmu7Gx5RZqfGiQrgMR7yeqDxrgM/Q1vlqhweqxg2S5iACdKZKCQAh0UVBh3q
         /LJPmbJrXv0dZPGmR25HWjEsYFZaoZhbPfNMKhJnWwF5z5P35wdXyaGP+/GBPTarD3Tm
         Ha9hslh4+06BOXWSM9BwT791BJJgksNnjbG2DaKPLywl/XIk11Rv45zT7oB9vBc1NPow
         eD1w==
X-Gm-Message-State: APjAAAUOt8EEnwWBxDOnae2eS83PJu7+XQDSfGS4B1eFbz3mtl2tJZ0s
        tvQ496SxR0LP8KN+8u8sZw==
X-Google-Smtp-Source: APXvYqwsHmT4CxNx7HGQ2Pj7np4YP84sY8W19SV2rKvXRYl4qc9Cffx9exEaYAtWsBx+dK7CagS+5w==
X-Received: by 2002:aca:281a:: with SMTP id 26mr5884115oix.82.1572386501064;
        Tue, 29 Oct 2019 15:01:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k18sm13904oik.58.2019.10.29.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:01:40 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:01:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
Message-ID: <20191029220139.GA24212@bogus>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
 <20191025111338.27324-4-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025111338.27324-4-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 07:13:36PM +0800, Chunyan Zhang wrote:
> 
> add a new bindings to describe sc9863a clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.txt       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt

Please make this a DT schema.

> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt
> new file mode 100644
> index 000000000000..a73ae5574c82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt
> @@ -0,0 +1,59 @@
> +Unisoc SC9863A Clock Binding
> +------------------------
> +
> +Required properties:
> +- compatible: should contain the following compatible strings:
> +	- "sprd,sc9863a-ap-clk"
> +	- "sprd,sc9863a-pmu-gate"
> +	- "sprd,sc9863a-pll"
> +	- "sprd,sc9863a-mpll"
> +	- "sprd,sc9863a-rpll"
> +	- "sprd,sc9863a-dpll"
> +	- "sprd,sc9863a-aon-clk"
> +	- "sprd,sc9863a-apahb-gate"
> +	- "sprd,sc9863a-aonapb-gate"
> +	- "sprd,sc9863a-mm-gate"
> +	- "sprd,sc9863a-mm-clk"
> +	- "sprd,sc9863a-vspahb-gate"
> +	- "sprd,sc9863a-apapb-gate"
> +
> +- #clock-cells: must be 1
> +
> +- clocks : Should be the input parent clock(s) phandle for the clock, this
> +	   property here just simply shows which clock group the clocks'
> +	   parents are in, since each clk node would represent many clocks
> +	   which are defined in the driver.  The detailed dependency
> +	   relationship (i.e. how many parents and which are the parents)
> +	   are implemented in driver code.

You need to define how many clocks for each block.

> +
> +Optional properties:
> +
> +- reg:	Contain the registers base address and length. It must be configured
> +	only if no 'sprd,syscon' under the node.
> +
> +- sprd,syscon: phandle to the syscon which is in the same address area with
> +	       the clock, and so we can get regmap for the clocks from the
> +	       syscon device.

Can't these be child nodes of the syscon instead?

> +
> +Example:
> +	ap_clk: clock-controller@21500000 {
> +		compatible = "sprd,sc9863a-ap-clk";
> +		reg = <0 0x21500000 0 0x1000>;
> +		clocks = <&ext_32k>, <&ext_26m>,
> +			 <&pll 0>, <&rpll 0>;
> +		#clock-cells = <1>;
> +	};
> +
> +	pmu_gate: pmu-gate {
> +		compatible = "sprd,sc9863a-pmu-gate";
> +		sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
> +		clocks = <&ext_26m>;
> +		#clock-cells = <1>;
> +	};
> +
> +	pll: pll {
> +		compatible = "sprd,sc9863a-pll";
> +		sprd,syscon = <&anlg_phy_g2_regs>; /* 0x40353000 */
> +		clocks = <&pmu_gate 0>;
> +		#clock-cells = <1>;
> +	};
> -- 
> 2.20.1
> 
> 
