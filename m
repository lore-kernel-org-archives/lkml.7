Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC7C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A69208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfHONFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:05:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfHONFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:05:30 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hyFRX-0004uh-TQ; Thu, 15 Aug 2019 15:05:27 +0200
Message-ID: <1565874327.3011.11.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Add driver for dispmix reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Fancy Fang <chen.fang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 15 Aug 2019 15:05:27 +0200
In-Reply-To: <AM6PR04MB49369AD1DE69A51B38471608F3E20@AM6PR04MB4936.eurprd04.prod.outlook.com>
References: <20190625055557.7507-1-chen.fang@nxp.com>
         <1561474623.5559.4.camel@pengutronix.de>
         <AM6PR04MB49369AD1DE69A51B38471608F3E20@AM6PR04MB4936.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fancy,

On Wed, 2019-06-26 at 06:46 +0000, Fancy Fang wrote:
> Hi Philipp,
> 
> Thanks for your comments. And please see my answers below.
> 
[...]
> > +Specifying sft-rstn control of devices 
> > +======================================
> > +
> > +Device nodes in Display Mix should specify the reset channel required 
> > +in their "resets" property, containing a phandle to the sft-rstn 
> > +device node and an index to specify which channel to use, as 
> > +described in Documentation/devicetree/bindings/reset/reset.txt.
> > +
> > +example:
> > +
> > +        lcdif_resets: lcdif-resets {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                #reset-cells = <0>;
> > +
> > +                lcdif-soft-resetn {
> > +                        compatible = "lcdif,soft-resetn";
> > +                        resets = <&dispmix_sft_rstn IMX8MN_LCDIF_APB_CLK_RESET>,
> > +                                 <&dispmix_sft_rstn 
> > + IMX8MN_LCDIF_PIXEL_CLK_RESET>;
> 
> From these names, on i.MX8MN these look like they could be an internal property of the DISPMIX clocks provided to the submodules. But on i.MX8MM the soft reset bits do look like actual module resets. Can you confirm whether this is true?
> [FF] I'll check this with the IC designer, and I'll let you know the result when I get the answer.

Did you get some feedback on what these resets actually are?

I'm asking because I'm wondering about how to best support VPUMIX for
the three VPU cores on i.MX8MM. The VPUMIX seems to have a SOFT_RESET
register and a CLOCK_ENABLE register, each with three bits, one bit for
each VPU. I'd be interested in knowing what these actually reset / gate
as well.

regards
Philipp
