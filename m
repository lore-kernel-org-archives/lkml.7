Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187BCECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DF721721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJII56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:57:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43833 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfJII56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:57:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iI7n8-0007JL-1z; Wed, 09 Oct 2019 10:57:54 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iI7n5-0007Mi-MT; Wed, 09 Oct 2019 10:57:51 +0200
Date:   Wed, 9 Oct 2019 10:57:51 +0200
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
Subject: Re: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Message-ID: <20191009085751.h3voimqz25kj6lh2@pengutronix.de>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
 <20191007080135.4e5ljhh6z2rbx5bw@pengutronix.de>
 <AM6PR0402MB39118DABDE62496539D7EE6DF59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <20191009082455.5hqhotkbozsr7mgo@pengutronix.de>
 <DB3PR0402MB3916CD3B5EC47C023F9D840DF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916CD3B5EC47C023F9D840DF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:56:52 up 144 days, 15:15, 97 users,  load average: 0.27, 0.09,
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

On 19-10-09 08:28, Anson Huang wrote:
> Hi, Marco
> 
> > On 19-10-08 00:48, Anson Huang wrote:
> > > Hi, Marco
> > >
> > > > On 19-10-07 09:15, Anson Huang wrote:
> > > > > The SCU firmware does NOT always have return value stored in
> > > > > message header's function element even the API has response data,
> > > > > those special APIs are defined as void function in SCU firmware,
> > > > > so they should be treated as return success always.
> > > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > ---
> > > > > Changes since V1:
> > > > > 	- Use direct API check instead of calling another function to check.
> > > > > 	- This patch is based on
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > patc
> > > > >
> > > >
> > hwork.kernel.org%2Fpatch%2F11129553%2F&amp;data=02%7C01%7Canson.
> > > > huang%
> > > > >
> > > >
> > 40nxp.com%7C2de0a6be69b74cc249ad08d74afc9730%7C686ea1d3bc2b4c6f
> > > > a92cd99
> > > > >
> > > >
> > c5c301635%7C0%7C0%7C637060321046247040&amp;sdata=RMFAdLKGKb6
> > > > mEdhycrzHX
> > > > > R03E6Qr5pWyRc8Zk6ErlBc%3D&amp;reserved=0
> > > >
> > > > Thanks for this v2. It would be good to change the callers within this
> > series.
> > >
> > > NOT quite understand your point, the callers does NOT need to be
> > > changed, those
> > > 2 special APIs callers are already following the right way of calling the APIs.
> > 
> > Ah okay. I searched the 5.4-rc2 tag and found the soc_uid_show() as only
> > user but this user sets the have_resp field to false. Is this intended?
> 
> I already fixed it and patch applied by Shawn, see below:
> 
> https://patchwork.kernel.org/patch/11129497/

I see :) So one last question, please check the other thread.

Regards,
  Marco

> 
> Anson
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
