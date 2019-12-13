Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024CC34966
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F3247F8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269667;
	bh=wllbqAkQwXX16I2gc2Q3Wg0/D5+EQ1fBg/XC/LsvQcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2g/wlMj1ub/IDd3gngEDD4V3MIPZtcJOgXZAIaDez7SEsseVI0VNPzHxjqpFzYOWM
	 9RxVmcR5BP9vgpfi07OoUnkVO5gd+mhQlBfyke2Nofp9vMHfVa5sFlSdo3X3/wDoHN
	 w1vZme3/0/+XW7yRzOCg8QkXqANolvQGhLDshi1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfLMTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:52:11 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39835 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfLMTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:52:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so1759690oib.6;
        Fri, 13 Dec 2019 11:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUyMz6kQuofRI0IuH2BvhvOA6mSu4eEqr0p1RAXMOGY=;
        b=eYMGKB0MslDUGgWyJa13ZY9AebtKcXFs1OI6QKl2IVo3u2VXGtx4xhCGLcscOiGoYe
         Jq7m//hSONkRHNFEEWfOztGW6zE6FxT1F512rIMw82r8w7FNdtnNwcwHNaF4hDC/kiCy
         urzM/mGXpyiHH6d00vyVLtMzF2UbbjrVGVFmI3r959rCr2CKhAsQi/sJ00KQ4pyipUTL
         +wwn/mv14O7bLwrKyrb8v+Mm4UyqcXmwBCkD1GZ/hJh8jpXjJ3Y55bh0Q8M7bwtZGCQK
         9okgWxUozFqCW/gv8Wu3gyuRybncDH9A7/f99c1OVEu0OQhqTm9gXbKJEL5R5Zc/GPiV
         PzYQ==
X-Gm-Message-State: APjAAAXUgH7yRMmrskIBg9wPv0PDFDXpxFE5J8qt3FXxTa7mNv2Uytud
        crRTOovjKZSa+M85br1gnZJoTa0=
X-Google-Smtp-Source: APXvYqxWnSf1TSTqNCprxjSGfagOYPCHy5twHRF/1t+lAsvvLT3qhSa46ofJ4uP1SnEwS/ykByoHmw==
X-Received: by 2002:aca:815:: with SMTP id 21mr8045671oii.52.1576266730462;
        Fri, 13 Dec 2019 11:52:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f142sm3637418oig.48.2019.12.13.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:52:09 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:52:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: add documentation of xilinx
 clocking wizard
Message-ID: <20191213195208.GB13693@bogus>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <54f8c5ce9c84265437734943f68e3ee4c2458bd5.1574922435.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f8c5ce9c84265437734943f68e3ee4c2458bd5.1574922435.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:06:08PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add the devicetree binding for the xilinx clocking wizard.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../bindings/clock/xlnx,clocking-wizard.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt

New bindings should be in DT schema format.

> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt
> new file mode 100644
> index 0000000..aedac84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt
> @@ -0,0 +1,32 @@
> +Binding for Xilinx Clocking Wizard IP Core
> +
> +This binding uses the common clock binding[1]. Details about the devices can be
> +found in the product guide[2].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Clocking Wizard Product Guide
> +http://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v5_1/pg065-clk-wiz.pdf
> +
> +Required properties:
> + - compatible: Must be 'xlnx,clocking-wizard'

That's not very specific. Is there only 1 version of this h/w?

> + - #clock-cells: Number of cells in a clock specifier. Should be 1
> + - reg: Base and size of the cores register space
> + - clocks: Handle to input clock
> + - clock-names: Tuple containing 'clk_in1' and 's_axi_aclk'
> + - clock-output-names: Names for the output clocks

You have to define the values.

> +
> +Optional properties:
> + - speed-grade: Speed grade of the device (valid values are 1..3)
> +
> +Example:
> +	clock-generator@40040000 {
> +		#clock-cells = <1>;
> +		reg = <0x40040000 0x1000>;
> +		compatible = "xlnx,clocking-wizard";
> +		speed-grade = <1>;
> +		clock-names = "clk_in1", "s_axi_aclk";
> +		clocks = <&clkc 15>, <&clkc 15>;
> +		clock-output-names = "clk_out0", "clk_out1", "clk_out2",
> +				     "clk_out3", "clk_out4", "clk_out5",
> +				     "clk_out6", "clk_out7";

Don't really need this to be in DT given all the names are the same 
except for the index.

Rob
