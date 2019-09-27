Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B772C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfI0JGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:06:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48875 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0JGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:06:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDmCY-0000x0-Co; Fri, 27 Sep 2019 11:06:10 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDmCX-0008Rx-Qm; Fri, 27 Sep 2019 11:06:09 +0200
Date:   Fri, 27 Sep 2019 11:06:09 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Message-ID: <20190927090609.fyxdekkzrco7memt@pengutronix.de>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:49:01 up 132 days, 15:07, 85 users,  load average: 0.03, 0.07,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson, Leonard,

On 19-09-27 01:20, Anson Huang wrote:
> Hi, Leonard
> 
> > On 2019-09-26 1:06 PM, Marco Felsch wrote:
> > > On 19-09-26 08:03, Anson Huang wrote:
> > >>> On 19-09-25 18:07, Anson Huang wrote:
> > >>>> The SCU firmware does NOT always have return value stored in
> > >>>> message header's function element even the API has response data,
> > >>>> those special APIs are defined as void function in SCU firmware, so
> > >>>> they should be treated as return success always.
> > >>>>
> > >>>> +static const struct imx_sc_rpc_msg whitelist[] = {
> > >>>> +	{ .svc = IMX_SC_RPC_SVC_MISC, .func =
> > >>> IMX_SC_MISC_FUNC_UNIQUE_ID },
> > >>>> +	{ .svc = IMX_SC_RPC_SVC_MISC, .func =
> > >>>> +IMX_SC_MISC_FUNC_GET_BUTTON_STATUS }, };
> > >>>
> > >>> Is this going to be extended in the near future? I see some upcoming
> > >>> problems here if someone uses a different scu-fw<->kernel
> > >>> combination as nxp would suggest.
> > >>
> > >> Could be, but I checked the current APIs, ONLY these 2 will be used
> > >> in Linux kernel, so I ONLY add these 2 APIs for now.
> > >
> > > Okay.
> > >
> > >> However, after rethink, maybe we should add another imx_sc_rpc API
> > >> for those special APIs? To avoid checking it for all the APIs called which
> > may impact some performance.
> > >> Still under discussion, if you have better idea, please advise, thanks!
> > 
> > My suggestion is to refactor the code and add a new API for the this "no
> > error value" convention. Internally they can call a common function with
> > flags.
> 
> If I understand your point correctly, that means the loop check of whether the API
> is with "no error value" for every API still NOT be skipped, it is just refactoring the code,
> right?

How makes this things easier?

> > > Adding a special api shouldn't be the right fix. Imagine if someone
> > > (not a nxp-developer) wants to add a new driver. How could he be
> > > expected to know which api he should use. The better abbroach would be
> > > to fix the scu-fw instead of adding quirks..
> 
> Yes, fixing SCU FW is the best solution, but we have talked to SCU FW owner, the SCU
> FW released has been finalized, so the API implementation can NOT be changed, but
> they will pay attention to this issue for new added APIs later. That means the number
> of APIs having this issue a very limited.

This means those APIs which already have this bug will not be fixed?
IMHO this sounds a bit weird since this is a changeable peace of code ;)

> > Right now developers who want to make SCFW calls in upstream need to
> > define the message struct in their driver based on protocol documentation.
> > This includes:
> > 
> > * Binary layout of the message (a packed struct)
> > * If the message has a response (already a bool flag)
> > * If an error code is returned (this patch adds support for it)

Why should I specify if a error code is returned?

Regards,
  Marco

> > Since callers are already exposed to the binary protocol exposing them to
> > minor quirks of the calling convention also seems reasonable. Having the
> > low-level IPC code peek at message IDs seems like a hack; this belong at a
> > slightly higher level.
> 
> A little confused, so what you suggested is to add make the imx_scu_call_rpc()
> becomes the "slightly higher level" API, then in this API, check the message IDs
> to decide whether to return error value, then calls a new API which will have
> the low-level IPC code, the this new API will have a flag passed from imx_scu_call_rpc()
> function, am I right?
> 
> Anson

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
