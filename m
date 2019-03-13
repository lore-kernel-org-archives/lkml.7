Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84528C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D62177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfCMKl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:41:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59715 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:41:59 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1h41KZ-0007NO-1z; Wed, 13 Mar 2019 11:41:51 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1h41KX-0004gK-M3; Wed, 13 Mar 2019 11:41:49 +0100
Date:   Wed, 13 Mar 2019 11:41:49 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] clk: imx: Allow re-parenting by default on set rate
Message-ID: <20190313104149.blhwqgn53lsgow6z@pengutronix.de>
References: <1551950425-7346-1-git-send-email-abel.vesa@nxp.com>
 <20190311102825.g7d5mmorcltxnnzf@pengutronix.de>
 <20190311104140.n65jvamx76rzkonr@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311104140.n65jvamx76rzkonr@fsr-ub1664-175>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:39:41 up 29 days, 19:05, 89 users,  load average: 0.16, 0.21,
 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:41:40AM +0000, Abel Vesa wrote:
> On 19-03-11 11:28:25, Sascha Hauer wrote:
> > Hi Abel,
> > 
> > On Thu, Mar 07, 2019 at 09:20:37AM +0000, Abel Vesa wrote:
> > > By default, the muxes should re-parent on set_rate.
> > > This would allow the drivers to control only the leaf clock node,
> > > leaving the rest to the clock driver, that way simplifying the
> > > clock control.
> > 
> > I am afraid of this change. Besides the rate there might be other
> > reasons to choose one mux input over another, consider for example low
> > power audio playback where we need one specific mux setting because it
> > provides a clock which runs at low power mode.
> > On the IPU on i.MX5/6 there are clocks being used as pixel clocks
> > derived from different muxes. I don't think you want to pick an input
> > clock just because it happens to deliver the best clock rate at that
> > point in time, but really is shared with some other clock that changes
> > its rate in the next moment.
> > 
> 
> > I have no concrete examples for things that break with this change, but
> > I would be more confident if we change the behaviour explicitly only for
> > the muxes that we have reviewed to cope with this change.
> > 
> 
> Fair enough. We could replace all the imx_clk_mux with imx_clk_mux_noreparent
> and after that we can independently switch the clocks that are safe (to switch)
> to imx_clk_mux (which would not have the noreparent flag set).

Ok with me.

> 
> The main idea is to simplify the clock control from drivers point of view.

Which drivers do you have in mind? I hardly ever missed reparenting on
rate changes, so where is this feature useful?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
