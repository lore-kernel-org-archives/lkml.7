Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E57C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3397A2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0HFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:05:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33285 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfF0HFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:05:31 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hgOTI-0007Bx-DH; Thu, 27 Jun 2019 09:05:28 +0200
Message-ID: <1561619128.4216.3.camel@pengutronix.de>
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
Date:   Thu, 27 Jun 2019 09:05:28 +0200
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

On Wed, 2019-06-26 at 06:46 +0000, Fancy Fang wrote:
[...]
> > The same goes for the clock soft enable bits on i.MX8MM. If those 
> > bits actually control clock gates, they should not be described as 
> > reset controls in the device tree.
>
> [FF] Make sense. The functions provided by the "dispmix reset" is more
> likely to be a combination of a clock gating module and a reset
> control than a standard reset controller. The reason why I choose
> reset framework to implement this device is that: First, this module
> is named as "dispmix reset" in the dispmix's design spec, so it gives
> me the first impression that it should be acted as a reset controller.
> And I'll check this with the IC designer.

Thank you.

> Second, the "dispmix reset" is separated from the CCM LPCG module
> which is used as the only clock controller device for the whole
> platform. So the CCM clock driver seems cannot cover this device.
> Last, the "dispmix reset" is shared by all the submodules in the
> dispmix, so I abstract this device to be a reset controller driver to
> simplify the 'reset' logic for all the submodules drivers.

Agreed on both points.

> If using clock framework to cover this device, another driver needs to
> be implemented. I'll take a close look at it to see if this can
> happen.

Yes, if my assumptions are correct, it would be good if this could be
rewritten as a combined clock and reset driver. There are quite a few
examples for this in drivers/clk already.

[...]
> > Is there any reason not to just use straight readl/writel besides 
> > the automatic clock handling?
>
> [FF] Use regmap is for simplifying the register modifications since
> the register has no SET or CLR shadow, so when set or clear one bit,
> the register needs to be read-and-modify. And besides, the register
> access requires disp-apb clock open, and regmap can handle this
> properly.

Ok, this makes sense to me.

regards
Philipp
