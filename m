Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7FF21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDLPd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:33:27 -0400
Received: from muru.com ([72.249.23.125]:45608 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfDLPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:33:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 803F880F3;
        Fri, 12 Apr 2019 15:33:40 +0000 (UTC)
Date:   Fri, 12 Apr 2019 08:33:21 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v6 06/12] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190412153321.GV2839@atomide.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-7-lokeshvutla@ti.com>
 <20190411150023.GQ2839@atomide.com>
 <9cd4b818-905c-08a4-5675-a5ee763cea98@ti.com>
 <7e41405b-74e2-dc53-982a-766dee8a6884@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e41405b-74e2-dc53-982a-766dee8a6884@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190412 08:43]:
> On 12/04/2019 07:24, Lokesh Vutla wrote:
> > 
> > 
> > On 11/04/19 8:30 PM, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Lokesh Vutla <lokeshvutla@ti.com> [190410 04:15]:
> > > > +Example:
> > > > +--------
> > > > +The following example demonstrates both interrupt router node and the consumer
> > > > +node(main gpio) on the AM654 SoC:
> > > > +
> > > > +main_intr: interrupt-controller0 {
> > > > +	compatible = "ti,sci-intr";
> > > > +	ti,intr-trigger-type = <1>;
> > > > +	interrupt-controller;
> > > > +	interrupt-parent = <&gic500>;
> > > > +	#interrupt-cells = <3>;
> > > > +	ti,sci = <&dmsc>;
> > > > +	ti,sci-dst-id = <56>;
> > > > +	ti,sci-rm-range-girq = <0x1>;
> > > > +};
> > > 
> > > To me it seems there should not be too many of these interrupt
> > > controller nodes for each SoC. Maybe you're already planning on
> > > doing it, but I suggest that you just add more specific compatibles
> > > and then look up the dst-id from a mapping table in the driver
> > > similar to what patch 04/12 in this series is already doing.
> > > 
> > > That way you don't need to add custom TI specific (firmware
> > > defined) device tree properties listed above ;)
> > 
> 
> < snip: I think Lokesh had a bad day or something :) >

Certainly custom bindings need to be discussed properly on the lists :)

> Anyways, the reason why we want these as custom properties in the DT is that
> there are multiple instances of the routers within one SoC. On AM65x we have
> MAIN NAVSS, MCU NAVSS, GPIOs for both etc., if we add driver data for each
> of these, it easily explodes quite a bit. Especially going forward with new
> SoCs.

Yup and I keep getting worried about this every time I see it still. But like
I've mentioned when we chatted offline, as long as Arnd, Marc and Rob ack this
use, I can live with it.

I'm just trying to avoid another "ti,hwmods" type custom property here..
We are still dealing with it to replace it with just standard use of
"compatible" property, and every time Rob sees it he still comments on it :)

Reagrds,

Tony
