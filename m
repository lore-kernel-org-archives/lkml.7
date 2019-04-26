Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8BAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3E52077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDZJGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:06:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:06:22 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hJwo9-0008Rc-6C; Fri, 26 Apr 2019 11:06:13 +0200
Message-ID: <1556269571.2584.21.camel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc
 family
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Apr 2019 11:06:11 +0200
In-Reply-To: <1556268048.9298.11.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556266779.2584.15.camel@pengutronix.de>
         <1556268048.9298.11.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 26.04.2019, 08:47 +0000 schrieb Robin Gong:
> On 2019-04-26 at 08:19 +0000, Lucas Stach wrote:
> > Caution: EXT Email
> > 
> > Hi Robin,
> > 
> > Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
> > > 
> > >   There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > > transfer to be send twice in DMA mode. Please get more information
> > > from:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> > > ww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cy
> > > ibin.gong%40nxp.com%7C0078694b231443d1cb7d08d6ca1feecf%7C686ea1d3bc
> > > 2b4c6fa92cd99c5c301635%7C0%7C1%7C636918635828489049&amp;sdata=IcPzg
> > > uHTS81rdHGMzU2wQdDYJn9bE1UDCsc0BUO5In8%3D&amp;reserved=0. The
> > > workaround is adding
> > > new sdma ram script which works in XCH  mode as PIO inside sdma
> > > instead
> > > of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0.
> > 
> > I would like to have a more in-depth explanation about how this new
> > RAM
> > script differs from the existing ROM script and the changes to the
> > state transitions.
> 
> The new ecspi ram script just follow errata to enable ecspi XCH bit
> after every time txfifo filled just as PIO, please check spi_imx_push()
> in spi-imx.c.
> > 
> > > 
> > >   The issue should be exist on all legacy i.mx6/7 soc family before
> > > i.mx6ul,
> > > NXP fix this design issue from i.mx6ul, so newer chips such as
> > > i.mx6ull/
> > > i.mx8mq/i.mx8mm, don't need this workaroud anymore. This patch set
> > > add new 'fsl,imx6ul-ecspi' for ecspi driver and 'ecspi_fixed' in
> > > sdma
> > > driver to choose if need errata or not.
> > >   The first two reverted patches should be the same issue, though,
> > > it
> > > seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> > > could
> > > have the chance to test this patch set if could fix their issues.
> > >   Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not
> > > work
> > > on i.mx8mm because the event id is zero.
> > > 
> > > PS:
> > >  Please get sdma firmware from below linux-firmware and copy it to
> > > your
> > > local rootfs /lib/firmware/imx/sdma.
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fg
> > > it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux
> > > -firmware.git%2Ftree%2Fimx%2Fsdma&amp;data=02%7C01%7Cyibin.gong%40n
> > > xp.com%7C0078694b231443d1cb7d08d6ca1feecf%7C686ea1d3bc2b4c6fa92cd99
> > > c5c301635%7C0%7C1%7C636918635828489049&amp;sdata=SMoonJ9HQpUj3TzPmi
> > > 7CcCSAwaR44%2BGPi%2BSBj%2FXceqo%3D&amp;reserved=0
> > 
> > This is not an option as long as the SDMA RAM firmware breaks the
> > mainline serial DMA support. Please provide a fixed SDMA RAM firmware
> > that doesn't replace the ROM serial script, as that one is totally
> > fine.
> 
> Yes, I have another patch to fix such uart function broken with SDMA
> RAM firmware, including new sdma firmware updated and kernel patch.
> Should I add that patch into this patch set?

Why would we need a kernel patch for this? Just drop the SDMA serial
RAM script, it does not add any value as the ROM script is totally
fine.

Regards,
Lucas
