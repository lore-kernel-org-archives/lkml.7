Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C32CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712F820862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJaLIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:08:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42819 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfJaLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:08:15 -0400
X-Originating-IP: 91.217.168.176
Received: from localhost (unknown [91.217.168.176])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 942B6FF810;
        Thu, 31 Oct 2019 11:08:11 +0000 (UTC)
Date:   Thu, 31 Oct 2019 12:08:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?K=E9vin?= RAYMOND <k.raymond@overkiz.com>,
        Mickael GARDET <m.gardet@overkiz.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: add a common kizboxmini dtsi file
Message-ID: <20191031110811.GC2967@piout.net>
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
 <20191018140304.31547-3-kamel.bouhara@bootlin.com>
 <20191029123426.GB8412@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029123426.GB8412@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 07:34:26-0500, Rob Herring wrote:
> On Fri, Oct 18, 2019 at 04:03:04PM +0200, Kamel Bouhara wrote:
> > Split the Kizbox Mini boards into two board configuration, the
> > Kizboxmini Mother board and the Kizboxmini RailDIN board.
> > 
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
> > Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
> > ---
> >  arch/arm/boot/dts/Makefile                    |   2 +
> >  arch/arm/boot/dts/at91-kizboxmini-mb.dts      |  38 ++++
> >  arch/arm/boot/dts/at91-kizboxmini-rd.dts      |  54 ++++++
> >  arch/arm/boot/dts/at91-kizboxmini_common.dtsi | 166 ++++++++++++++++++
> >  4 files changed, 260 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
> >  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
> >  create mode 100644 arch/arm/boot/dts/at91-kizboxmini_common.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index c976b72a4c94..6b3a65f3f6f8 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -38,6 +38,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
> >  	at91-ariettag25.dtb \
> >  	at91-cosino_mega2560.dtb \
> >  	at91-kizboxmini.dtb \
> > +	at91-kizboxmini-mb.dtb \
> > +	at91-kizboxmini-rd.dtb \
> >  	at91-wb45n.dtb \
> >  	at91sam9g15ek.dtb \
> >  	at91sam9g25ek.dtb \
> > diff --git a/arch/arm/boot/dts/at91-kizboxmini-mb.dts b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
> > new file mode 100644
> > index 000000000000..52921f547dd6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2015-2018 Overkiz SAS
> > + *   Author: Mickael Gardet <m.gardet@overkiz.com>
> > + *           Kévin Raymond <k.raymond@overkiz.com>
> > + */
> > +/dts-v1/;
> > +#include "at91-kizboxmini_common.dtsi"
> > +
> > +/ {
> > +	model = "Overkiz Kizbox Mini Mother Board";
> > +	compatible = "overkiz,kizboxmini-mb", "atmel,at91sam9g25",
> > +		     "atmel,at91sam9x5", "atmel,at91sam9";
> > +
> > +	clocks {
> > +		slow_xtal {
> 
> Don't use '_' in node names.
> 

We are stuck with that one until we change the dtsi.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
