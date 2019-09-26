Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA84C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfIZKGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:06:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfIZKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:06:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDQet-0004yT-DP; Thu, 26 Sep 2019 12:05:59 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDQes-000329-OD; Thu, 26 Sep 2019 12:05:58 +0200
Date:   Thu, 26 Sep 2019 12:05:58 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Message-ID: <20190926100558.egils3ds37m3s5wo@pengutronix.de>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:11:00 up 131 days, 14:29, 85 users,  load average: 0.24, 0.16,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On 19-09-26 08:03, Anson Huang wrote:
> Hi, Marco
> 
> > On 19-09-25 18:07, Anson Huang wrote:
> > > The SCU firmware does NOT always have return value stored in message
> > > header's function element even the API has response data, those
> > > special APIs are defined as void function in SCU firmware, so they
> > > should be treated as return success always.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > 	- This patch is based on the patch of
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fpatch%2F11129553%2F&amp;data=02%7C01%7Canson.
> > huang%
> > >
> > 40nxp.com%7C1f4108cc25eb4618f43c08d742576fa3%7C686ea1d3bc2b4c6fa
> > 92cd99
> > >
> > c5c301635%7C0%7C0%7C637050815608963707&amp;sdata=BZBg4cOR2rP%2
> > BRBNn15i
> > > Qq3%2FXBYwhuCLkgYzFRbfEgVU%3D&amp;reserved=0
> > > ---
> > >  drivers/firmware/imx/imx-scu.c | 34
> > > ++++++++++++++++++++++++++++++++--
> > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/firmware/imx/imx-scu.c
> > > b/drivers/firmware/imx/imx-scu.c index 869be7a..ced5b12 100644
> > > --- a/drivers/firmware/imx/imx-scu.c
> > > +++ b/drivers/firmware/imx/imx-scu.c
> > > @@ -78,6 +78,11 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =
> > {
> > >  	-EIO,	 /* IMX_SC_ERR_FAIL */
> > >  };
> > >
> > > +static const struct imx_sc_rpc_msg whitelist[] = {
> > > +	{ .svc = IMX_SC_RPC_SVC_MISC, .func =
> > IMX_SC_MISC_FUNC_UNIQUE_ID },
> > > +	{ .svc = IMX_SC_RPC_SVC_MISC, .func =
> > > +IMX_SC_MISC_FUNC_GET_BUTTON_STATUS }, };
> > 
> > Is this going to be extended in the near future? I see some upcoming
> > problems here if someone uses a different scu-fw<->kernel combination as
> > nxp would suggest.
> 
> Could be, but I checked the current APIs, ONLY these 2 will be used in Linux kernel, so
> I ONLY add these 2 APIs for now.

Okay.

> However, after rethink, maybe we should add another imx_sc_rpc API for those special
> APIs? To avoid checking it for all the APIs called which may impact some performance.
> Still under discussion, if you have better idea, please advise, thanks!

Adding a special api shouldn't be the right fix. Imagine if someone (not
a nxp-developer) wants to add a new driver. How could he be expected to
know which api he should use. The better abbroach would be to fix the
scu-fw instead of adding quirks..

Regards,
  Marco


> 
> Anson
