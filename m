Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67E8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C028720684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570473516;
	bh=NAn+q6yf4CHs6Mu3N4wO/Uqn6OEuK70VfBhue/aQrmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A+nzzp8ULurAMHRb+bNuD8XASkxUIDyjuZ4GTb9olWptS+TDPpuX14DNG8vTKEilV
	 wzt0zbLwMp/HrEuXKSvEoNJ4q2rW6xgfKYdr2ib5RPQB5WONuUyLQCvWZNbHC4PVgh
	 W/O6U7sgqadjhUot7gwuQ4gQMp1iHh0FH0wfdKvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJGSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfJGSif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:38:35 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810AF21655;
        Mon,  7 Oct 2019 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570473513;
        bh=NAn+q6yf4CHs6Mu3N4wO/Uqn6OEuK70VfBhue/aQrmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h6OBPyL/UW1tVbfEOBO4SpOwNmrWpZKcca/DqzkkWBlQW89u7QwvHRvL5eWfgt5b9
         jk0hyfEQaCOvfSHuhYr+gsoSZdrtb8IDXXbMTudalWPQ7BHV89kvap97lRstRxPXO+
         wCNY3dXkEBaNBT0LxAFO25hBZMbmMzNixvTlekuY=
Received: by mail-qk1-f182.google.com with SMTP id f16so13598023qkl.9;
        Mon, 07 Oct 2019 11:38:33 -0700 (PDT)
X-Gm-Message-State: APjAAAWMktNLSAOM7GZb2N3v9iNLLYr3i98UObOKZ/LzUjsKOW8L99qk
        aDWb6mDLhTilcpk3TpPjAyRTi1CzltF/xiw4xg==
X-Google-Smtp-Source: APXvYqw1uMDNOBK4id6x2x90eI0DouFlvWMcqOx1OkyvNHbflg90LosKjYFToraQFwlrtde7/0IP7Djz+EDPbZVrG/U=
X-Received: by 2002:a05:620a:549:: with SMTP id o9mr25361081qko.223.1570473512597;
 Mon, 07 Oct 2019 11:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007175553.66940-1-john.stultz@linaro.org> <20191007175553.66940-5-john.stultz@linaro.org>
In-Reply-To: <20191007175553.66940-5-john.stultz@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Oct 2019 13:38:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
Message-ID: <CAL_JsqJLY2n7hfneNptAGswVZtGm3vJbSR6W2wUG+ZTzMN8wZA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 4/5] dt-bindings: usb: dwc3: of-simple: add
 compatible for HiSi
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:56 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Add necessary compatible flag for HiSi's DWC3 so
> dwc3-of-simple will probe.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Tweaked clock names as clk_usb3phy_ref didn't seem right.
> ---
>  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt

Can you make this a schema.

> diff --git a/Documentation/devicetree/bindings/usb/hisi,dwc3.txt b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> new file mode 100644
> index 000000000000..3a3e5c320f2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> @@ -0,0 +1,52 @@
> +HiSi SuperSpeed DWC3 USB SoC controller
> +
> +Required properties:
> +- compatible:          should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> +- clocks:              A list of phandle + clock-specifier pairs for the
> +                       clocks listed in clock-names
> +- clock-names:         Should contain the following:
> +  "clk_abb_usb"                USB reference clk
> +  "aclk_usb3otg"       USB3 OTG aclk
> +
> +- assigned-clocks:     Should be:
> +                               HI3660_ACLK_GATE_USB3OTG
> +- assigned-clock-rates: Should be:
> +                               229Mhz (229000000) for HI3660_ACLK_GATE_USB3OTG
> +
> +Optional properties:
> +- resets:              Phandle to reset control that resets core and wrapper.

Looks like 4 resets though.

> +
> +Required child node:
> +A child node must exist to represent the core DWC3 IP block. The name of
> +the node is not important. The content of the node is defined in dwc3.txt.
> +
> +Example device nodes:
> +
> +       usb3: hisi_dwc3 {
> +               compatible = "hisilicon,hi3660-dwc3";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +                        <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +               clock-names = "clk_abb_usb", "aclk_usb3otg";
> +
> +               assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +               assigned-clock-rates = <229 000 000>;
> +               resets = <&crg_rst 0x90 8>,
> +                        <&crg_rst 0x90 7>,
> +                        <&crg_rst 0x90 6>,
> +                        <&crg_rst 0x90 5>;
> +
> +               dwc3: dwc3@ff100000 {

If it's only clocks and resets for the wrapper node, just make this
all one node.

And 'usb3' for the node name.

> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0xff100000 0x0 0x100000>;
> +                       interrupts = <0 159 4>, <0 161 4>;
> +                       phys = <&usb_phy>;
> +                       phy-names = "usb3-phy";
> +                       dr_mode = "otg";
> +
> +                       ...
> +               };
> +       };
> --
> 2.17.1
>
