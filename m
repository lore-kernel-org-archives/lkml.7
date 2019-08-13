Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E6C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA0920578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565711507;
	bh=Wzp/4xYbmDqbmpgVG0xprq2NjfU/7yfYmyfpL6wAN8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EKqrhcNr78+azdNvOHkaHS6r1DOAob6zuCE5QRe8T66JuwEuCdMcx2BXRHwSBCjXk
	 S8wuDiOeXp5N6UJ0OL6BqZtvIYeqGNF/Sae0VugtVs8Lm52yqgbuy2Svxj+Nn7gGRT
	 jrIPH/azNOHqco3LSby3XD042wFwBrk7vzPID8wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfHMPvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:51:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34951 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHMPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:51:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id g17so23350596otl.2;
        Tue, 13 Aug 2019 08:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ohFLMScLjVByBJFrR6C+4j/VSebLPBigBTSwqkkayik=;
        b=deu6LpXfX4eGd6ugD1/SvGVXVGEHISZcIQxoB/YHxAK1aXz0dokD7ipgkI2fLT2TFD
         jECnCIgwDuqwR+VnRjY3pbWXuOOpBpYtg+3bUmEGQVKNfvHwxrZO/U55nPngZq6O1giE
         uv+HtzlFPEoPFLut+RWdmwKC2xaW9aJ7lq2LkFxoCz/fbzcR3+Y0GMaNPhkvUK0kD9b5
         ApFKiVXncNxQQKi/ca7o3IRPOZZdsZ3UiMssVJNn6CNoFMQ4d1LP+9NmLBOkSClA2q3f
         J5cuC8NpzxhteIpMHMLtX06LrYagV08I5IchV+BCpBzEVR6U0Mo3SpEFa5HploqFa804
         gF5w==
X-Gm-Message-State: APjAAAWyQEmQ1bTWsYi/+uJsLgCRhFzPWQkKf5jVUBr1KO7NPYSVo4JG
        J8Q6ZC2Uc4T9AQrWkj30Yg==
X-Google-Smtp-Source: APXvYqxSeFwa1U2REzU2wk4Pb7uZS4OB2XVfpDeXm4KgsqA5BenxqxMVspOAXVlQLR7PyOR052yYjA==
X-Received: by 2002:a6b:b549:: with SMTP id e70mr32598873iof.95.1565711504396;
        Tue, 13 Aug 2019 08:51:44 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l26sm23511094ioj.24.2019.08.13.08.51.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:51:43 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:51:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v2 4/6] dt: bindings: add mt7621-pll dt binding
 documentation
Message-ID: <20190813155143.GA19830@bogus>
References: <20190724022310.28010-1-gch981213@gmail.com>
 <20190724022310.28010-5-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724022310.28010-5-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:23:08AM +0800, Chuanhong Guo wrote:
> This commit adds device tree binding documentation for MT7621
> PLL controller.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> 
> Change since v1:
> drop useless syscon in compatible string
> 
>  .../bindings/clock/mediatek,mt7621-pll.txt     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt b/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
> new file mode 100644
> index 000000000000..7dcfbd5283e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
> @@ -0,0 +1,18 @@
> +Binding for Mediatek MT7621 PLL controller
> +
> +The PLL controller provides the 2 main clocks of the SoC: CPU and BUS.
> +
> +Required Properties:
> +- compatible: has to be "mediatek,mt7621-pll"
> +- #clock-cells: has to be one
> +
> +Optional properties:
> +- clock-output-names: should be "cpu", "bus"
> +
> +Example:
> +	pll {
> +		compatible = "mediatek,mt7621-pll";

You didn't answer Stephen's question on v1.

Based on this binding, there is no way to control/program the PLL. Is 
this part of some IP block?

> +
> +		#clock-cells = <1>;
> +		clock-output-names = "cpu", "bus";
> +	};
> -- 
> 2.21.0
> 
