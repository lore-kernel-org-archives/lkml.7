Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0667C04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEAB204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEFHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:37:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53807 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEFHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:37:46 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hNYBt-0003eJ-FE; Mon, 06 May 2019 09:37:37 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hNYBr-00071K-1w; Mon, 06 May 2019 09:37:35 +0200
Date:   Mon, 6 May 2019 09:37:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "peda@axentia.se" <peda@axentia.se>,
        Sumit Batra <sumit.batra@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider
 I2C_IPGCLK_SEL RCW bit when using ls1046a SoC
Message-ID: <20190506073735.ctzybytamu44pbvv@pengutronix.de>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
 <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
 <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:13:06 up 48 days, 18:23, 78 users,  load average: 1.12, 1.24,
 1.24
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 09:28:48AM +0000, Chuanhua Han wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: 2019年4月30日 20:51
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> > mark.rutland@arm.com; linux-kernel@vger.kernel.org;
> > linux-i2c@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; wsa+renesas@sang-engineering.com;
> > u.kleine-koenig@pengutronix.de; eha@deif.com; linux@rempel-privat.de;
> > l.stach@pengutronix.de; peda@axentia.se; Sumit Batra
> > <sumit.batra@nxp.com>
> > Subject: [EXT] Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider
> > I2C_IPGCLK_SEL RCW bit when using ls1046a SoC
> > 
> > Caution: EXT Email
> > 
> > On Tue, Apr 30, 2019 at 12:47:18PM +0800, Chuanhua Han wrote:
> > > The current kernel driver does not consider I2C_IPGCLK_SEL (424 bit of
> > > RCW) in deciding  i2c_clk_rate in function i2c_imx_set_clk() { 0
> > > Platform clock/4, 1 Platform clock/2}.
> > >
> > > When using ls1046a SoC, this populates incorrect value in IBFD
> > > register if I2C_IPGCLK_SEL = 0, which generates half of the desired Clock.
> > >
> > > Therefore, if ls1046a SoC is used, we need to set the i2c clock
> > > according to the corresponding RCW.
> > 
> > So the clock driver reports the wrong clock. Please fix the clock driver then.
> No, this is a problem with the i2c driver. It is not a problem with
> the clock driver, so the i2c driver needs to be modified.

So how does this RCW bit get evaluated? According to the reference
manual only one clock goes to the i2c module (described as 1/2 Platform
Clock) and the i2c module only takes one clock. So it seems there must
be a /2 divider somewhere, either in each i2c module or somewhere
outside. Can your IC guys tell you where it is?

One reason I suggested the clock driver is that the clock driver
contains SoC specific code already, so it should be easier to integrate
there.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
