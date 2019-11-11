Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEEFC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKKR1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:27:00 -0500
Received: from muru.com ([72.249.23.125]:41588 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfKKR1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:27:00 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4423B8047;
        Mon, 11 Nov 2019 17:27:33 +0000 (UTC)
Date:   Mon, 11 Nov 2019 09:26:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 net-next 06/13] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Message-ID: <20191111172652.GV5610@atomide.com>
References: <20191109151525.18651-1-grygorii.strashko@ti.com>
 <20191109151525.18651-7-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109151525.18651-7-grygorii.strashko@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [191109 15:17]:
> +    mac_sw: switch@0 {
> +        compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
> +        reg = <0x0 0x4000>;
> +        ranges = <0 0 0x4000>;
> +        clocks = <&gmac_main_clk>;
> +        clock-names = "fck";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        syscon = <&scm_conf>;
> +        inctrl-names = "default", "sleep";
> +
> +        interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "rx_thresh", "rx", "tx", "misc";

I think with the ti-sysc managing the interconnect target module as the
parent of this, you should be able add all the modules as direct children
of ti-sysc with minor fixups. This would simplify things, and makes it
easier to update the driver later on when the child modules get
changed/updated/moved around.

The child modules just need to call PM runtime to have access to their
registers, and whatever cpsw control module part could be a separate
driver providing Linux standard services for example for clock gating :)

> +        davinci_mdio_sw: mdio@1000 {
> +                compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> +                reg = <0x1000 0x100>;
> +                clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 0>;
> +                clock-names = "fck";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                bus_freq = <1000000>;
> +
> +                ethphy0_sw: ethernet-phy@0 {
> +                        reg = <0>;
> +                };
> +
> +                ethphy1_sw: ethernet-phy@1 {
> +                        reg = <41>;
> +                };
> +        };

And in this case, mdio above would just move up one level.

This goes back to my earlier comments saying the cpsw is really just
a private interconnect with a collection of various mostly independent
modules. Sounds like you're heading that way already though at the
driver level :)

Regards,

Tony
