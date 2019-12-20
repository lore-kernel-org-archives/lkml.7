Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA9C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A7F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576881899;
	bh=v3aT8i1kmfUNSU54kS7vQUV8GP/eYzB/rE68T0MccPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYo4bMJyQM/2F3sUFJpHWtkdupoGC7Du4T0sLCgFFOG7Q1TUKawOKL8J787CKaet7
	 VEQ0YdetKqaUnvz9xNJiLwZkz3opvPYO7Q4dV6ued32g5cU8LkMr62Y6UiPCpTj+xD
	 tigNidcmu5ec6zxBI8mNE820cryRPO7guXpEY+dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLTWo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:44:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39248 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:44:58 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so9537103ioh.6;
        Fri, 20 Dec 2019 14:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7WksmJcfldBGfJZrpiFcVuuuNcslqmFm7JaA1MXSRJw=;
        b=WvV4M3SZMDzHl53cn3HF3nz3zDmc4Dtwj1+38BeOwH27LvVBnfbhYolB8FbLskxmlZ
         qm1yRDarf0SGqod6ugjwLkPs8VFxsskG3jUtaqRIs74/8iB9dcQ9wJxeGFsO5Cp58vSx
         KxGDFLCUnkoIeqsLtIQRlWSY3Z+vjZ5b+u0MkwNzY+L/PvoszZtIPjCPAzC8mR95gyDC
         uFfYSKpWb4m4i8XRcen76F/9bBZv1A5DlOdWyQNIDq8NCiRXCuCeXxclUShGEw7o/NPc
         D7n19KIL+ZLCNpDS6c4x58i9eIqtW7xH4Xw3NmJpS/L9puF4fswAbHqHAEEruY0wXI6p
         41RA==
X-Gm-Message-State: APjAAAXXqEAAHF6nmQTGRKnPrC1fa3wjn7uUpR7wPNrz09Y5zj3JCK1a
        1+KAOjSl7UjBrOYDmlV23w==
X-Google-Smtp-Source: APXvYqwtuXnxyLzSziWitzIzubl3H2AMh1E7q6ytM/gh5JGmnxiN9pRqFX6kE1zi5VLp9PQSEdPfJg==
X-Received: by 2002:a02:a309:: with SMTP id q9mr14248125jai.141.1576881897182;
        Fri, 20 Dec 2019 14:44:57 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e85sm5472679ilk.78.2019.12.20.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:44:56 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:44:55 -0700
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     p.zabel@pengutronix.de, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, lee.jones@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 1/3] dt-bindings: clocks: Convert Allwinner legacy clocks
 to schemas
Message-ID: <20191220224455.GA18967@bogus>
References: <20191219090712.947490-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219090712.947490-1-maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 10:07:10 +0100, Maxime Ripard wrote:
> The Allwinner SoCs have a legacy set of bindings (and a framework to
> support it in Linux) for their clock controllers.
> 
> Now that we have the DT validation in place, let's split into separate file
> and convert the device tree bindings for those clocks to schemas, and mark
> them all as deprecated.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../clock/allwinner,sun4i-a10-ahb-clk.yaml    | 108 +++++++++
>  .../clock/allwinner,sun4i-a10-apb0-clk.yaml   |  50 ++++
>  .../clock/allwinner,sun4i-a10-apb1-clk.yaml   |  52 ++++
>  .../clock/allwinner,sun4i-a10-axi-clk.yaml    |  61 +++++
>  .../clock/allwinner,sun4i-a10-cpu-clk.yaml    |  52 ++++
>  .../allwinner,sun4i-a10-display-clk.yaml      |  57 +++++
>  .../clock/allwinner,sun4i-a10-gates-clk.yaml  | 152 ++++++++++++
>  .../clock/allwinner,sun4i-a10-mbus-clk.yaml   |  63 +++++
>  .../clock/allwinner,sun4i-a10-mmc-clk.yaml    |  87 +++++++
>  .../clock/allwinner,sun4i-a10-mod0-clk.yaml   |  80 +++++++
>  .../clock/allwinner,sun4i-a10-mod1-clk.yaml   |  57 +++++
>  .../clock/allwinner,sun4i-a10-osc-clk.yaml    |  51 ++++
>  .../clock/allwinner,sun4i-a10-pll1-clk.yaml   |  71 ++++++
>  .../clock/allwinner,sun4i-a10-pll3-clk.yaml   |  50 ++++
>  .../clock/allwinner,sun4i-a10-pll5-clk.yaml   |  53 +++++
>  .../clock/allwinner,sun4i-a10-pll6-clk.yaml   |  53 +++++
>  .../allwinner,sun4i-a10-tcon-ch0-clk.yaml     |  77 ++++++
>  .../clock/allwinner,sun4i-a10-usb-clk.yaml    | 166 +++++++++++++
>  .../clock/allwinner,sun4i-a10-ve-clk.yaml     |  55 +++++
>  .../clock/allwinner,sun5i-a13-ahb-clk.yaml    |  52 ++++
>  .../clock/allwinner,sun6i-a31-pll6-clk.yaml   |  53 +++++
>  .../clock/allwinner,sun7i-a20-gmac-clk.yaml   |  51 ++++
>  .../clock/allwinner,sun7i-a20-out-clk.yaml    |  52 ++++
>  .../allwinner,sun8i-h3-bus-gates-clk.yaml     | 103 ++++++++
>  .../clock/allwinner,sun9i-a80-ahb-clk.yaml    |  52 ++++
>  .../clock/allwinner,sun9i-a80-apb0-clk.yaml   |  63 +++++
>  .../clock/allwinner,sun9i-a80-cpus-clk.yaml   |  52 ++++
>  .../clock/allwinner,sun9i-a80-gt-clk.yaml     |  52 ++++
>  .../allwinner,sun9i-a80-mmc-config-clk.yaml   |  68 ++++++
>  .../clock/allwinner,sun9i-a80-pll4-clk.yaml   |  50 ++++
>  .../allwinner,sun9i-a80-usb-mod-clk.yaml      |  60 +++++
>  .../allwinner,sun9i-a80-usb-phy-clk.yaml      |  60 +++++
>  .../devicetree/bindings/clock/sunxi.txt       | 225 ------------------
>  33 files changed, 2163 insertions(+), 225 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-apb0-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-apb1-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-axi-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-cpu-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-display-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-gates-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mbus-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mmc-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mod0-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mod1-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll3-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll5-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll6-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-tcon-ch0-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-usb-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ve-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun5i-a13-ahb-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun6i-a31-pll6-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun7i-a20-gmac-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun7i-a20-out-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun8i-h3-bus-gates-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-ahb-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-apb0-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-cpus-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-mmc-config-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-pll4-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-mod-clk.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-phy-clk.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
> 

Applied, thanks.

Rob
