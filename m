Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E4C21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839178;
	bh=2kvTNJ/WtCOi8bWsTdXHkWIo4rho6UoaXin9Tpgh2C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uc3uBqNOY/NTcV09/wxE8kDCnjcSPwEoK/FewV6Xo3rxX3bEhJAQBkbZa+pptw6jD
	 JasXUFCRxitHuC7YtQjEceTAYBfDb33xlbVt4x4vvI3FXFt9GEsd/R/tLRDhnZqAk1
	 PMOSs3642DcA9cC/OPPd/V0dsjsTVqoIbZY4DLxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfGVXqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:46:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34390 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfGVXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:46:17 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so77941824iot.1;
        Mon, 22 Jul 2019 16:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sv3qs1LiG1cFkAf5nI2IFon5jGR413J80KduD7S3roU=;
        b=QjPFNXhrA/svKLVLuUN+JhbRjjIPpEDlecb+zESUjN9nywOl2WyDjNcXcoz+Ir5u+4
         8WFCcbDE5EV1lCW3/IMDKb/cRRk57nrr8XvF0XHoSFBWBw54uQ2a9cGy5dNLZ6R8W6bC
         09W3xhaNdsAvRxEJz3BalBAgl8ZyzLVcBaJFB9qJkh+JXffzJiXughOwOt5tQStp04nT
         dkXnAhEeA6D0oZ8bBa5OKIu/XEJJ9DzYH+GXydVNtlfZCbnGK/aj5MyS+IL4b7CSTQTq
         C9Eu7Xi1fiuJN4bfber5I4uFTPDgUAZWgFbvchtD5q5QkJl3nIKCTtKQl+y3NY8i4cqu
         3d/Q==
X-Gm-Message-State: APjAAAVVL3S/Biquh/WhrNqZiheTWQCDkXdDj9O5ZtGREMejjsFGnAV2
        6Ll4S8E/YQcL2/bWeNdf0A==
X-Google-Smtp-Source: APXvYqw1qg7734Vxs9hak2lfaWjc22w1+joRV0CBw3JzSvesU72Jp8TsxdwSaK3mf2yQyW8xrm3tVA==
X-Received: by 2002:a02:7303:: with SMTP id y3mr74340417jab.97.1563839175981;
        Mon, 22 Jul 2019 16:46:15 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m20sm39702147ioh.4.2019.07.22.16.46.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:46:15 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:46:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        stefan@agner.ch, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw, paul.burton@mips.com, liang.yang@amlogic.com,
        lee.jones@linaro.org, anders.roxell@linaro.org,
        christophe.kerello@st.com, paul@crapouillou.net,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190722234614.GA11971@bogus>
References: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw>
 <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:15:44PM +0800, Mason Yang wrote:
> Document the bindings used by the Macronix raw NAND controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  Documentation/devicetree/bindings/mtd/mxic-nand.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> new file mode 100644
> index 0000000..ddd7660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> @@ -0,0 +1,20 @@
> +Macronix Raw NAND Controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "macronix,nand-controller"

That's not very specific. There's only 1 version of this h/w?

> +- reg: should contain 1 entrie for the registers

s/entrie/entry/

> +- interrupts: interrupt line connected to this raw NAND controller
> +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> +- clocks: should contain 3 phandles for the "ps_clk", "send_clk" and
> +	 "send_dly_clk" clocks

You can drop '_clk' as that is redundant.

> +
> +Example:
> +
> +	nand: mxic-nfc@43c30000 {
> +		compatible = "macronix,nand-controller";
> +		reg = <0x43c30000 0x10000>;
> +		reg-names = "regs";

Not documented. You can drop as *-names is not generally useful when 
there is only 1 entry.

> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +	};
> -- 
> 1.9.1
> 
