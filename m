Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE9FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E752081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556830289;
	bh=tctTzX7apjy9b6UeMUB5X0bYBIVHcFTG5Ppyz/2U4Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=at91uTw3VvIVoYZwpOED9Misik8ruxj7GXx4bsXe5cXHswWy61tQBi85x14Nx8LTG
	 A+Bsp2azBTZZVfTxrYqfRjVaxVrVb3/11hm47cKd17CdRf8IR6MNuw+7B4h/Z7rk62
	 x2MqRZEH6ay8p26zypPZa+C4Ta+Z90UwO6bJdEbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEBUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:51:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37355 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEBUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:51:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id 143so2848629oii.4;
        Thu, 02 May 2019 13:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0M/s2a9tlTFv/FTWip3G2NKE0kpp0LnOAR85a1p4R0=;
        b=D8pVa0GjAotJ4c5N5fkYKH1jrYMnsR/I2wAZQHo/s2NfYdSlSITwuZg29YSajEZHau
         /g8uGJT6+rZkHIhIpJAekennYU/buoTfVnsq6YHgTwMzXBxmuQi4zAN1eP1D2nwctaQj
         1f2qGO1ZVzW2cfGAIC3SRL4Whw3diW+AkIPvMMnGr/ZD1yuc/A0+lCStttQG0o7UzmyE
         o9Vz07pQpZM9fHN9fDpW/zwuFxC9HSlpc5lR5O/8hrAtnka8L+KYJukrF68JKyR4J36p
         XXlI0TQGTC8VsM7nOSTkvo3S5LkF8uV/5SZS2gm4Uo7Zenpwcr+mm4M0/o8uZyLdvtEK
         B15Q==
X-Gm-Message-State: APjAAAU4rEzFbSmJFlENufR+4CP2EjNmRrfqntouYAZ/OWixXhPB7wRo
        RKgUraeoClW3ZkkZMuuZyw==
X-Google-Smtp-Source: APXvYqzDbdYwgPCIEAr+hiFN60T0e7ZJougtcItHrR9eZtQEVRkQfvLf64qmrsDMjgQaRmbSto/j/w==
X-Received: by 2002:a54:4698:: with SMTP id k24mr3819905oic.104.1556830286202;
        Thu, 02 May 2019 13:51:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w5sm21290otg.34.2019.05.02.13.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:51:24 -0700 (PDT)
Date:   Thu, 2 May 2019 15:51:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gerald BAEZA <gerald.baeza@st.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: perf: stm32: ddrperfm support
Message-ID: <20190502205124.GA17384@bogus>
References: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
 <1556532194-27904-3-git-send-email-gerald.baeza@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556532194-27904-3-git-send-email-gerald.baeza@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:03:37AM +0000, Gerald BAEZA wrote:
> The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.
> 
> This documentation indicates how to enable stm32-ddr-pmu driver on
> DDRPERFM peripheral, via the device tree.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>  .../devicetree/bindings/perf/stm32-ddr-pmu.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt b/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
> new file mode 100644
> index 0000000..dabc4c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
> @@ -0,0 +1,18 @@
> +* STM32 DDR Performance Monitor (DDRPERFM)
> +
> +Required properties:
> +- compatible: must be "st,stm32-ddr-pmu".
> +- reg: physical address and length of the registers set.
> +- clocks: list of phandles and specifiers to all input clocks listed in
> +	  clock-names property.
> +- clock-names: "bus" corresponds to the DDRPERFM bus clock and "ddr" to
> +	       the DDR frequency.

You have 'resets' in the dts.

> +
> +Example:
> +	ddrperfm: perf@5a007000 {
> +		compatible = "st,stm32-ddr-pmu";
> +		reg = <0x5a007000 0x400>;
> +		clocks = <&rcc DDRPERFM>, <&rcc PLL2_R>;
> +		clock-names = "bus", "ddr";
> +	};
> +
> -- 
> 2.7.4
