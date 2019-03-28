Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7056C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CFE2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfC1IWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:22:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43483 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1IWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:22:37 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9QIy-0006T6-Tn; Thu, 28 Mar 2019 09:22:32 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9QIx-0007I8-8G; Thu, 28 Mar 2019 09:22:31 +0100
Date:   Thu, 28 Mar 2019 09:22:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Issues with i.MX SPI DMA transfers
Message-ID: <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:04:21AM +0300, Igor Plyatov wrote:
> Dear Uwe,
> 
> 
> > Hello Igor,
> > 
> > On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
> > > please, help to resolve two issues with SPI DMA transfers at i.MX6Q
> > > platform.
> > > 
> > > First issue is
> > >   [ 4465.008003] spi_master spi0: I/O Error in DMA RX
> > > 
> > > Second issue is duplication for one of received bytes.
> > > 
> > > Probably, these issues related to each one.
> > This is probably the same problem I hit some time ago. Check ERR009165
> > in the errata. You either need to disable DMA or need a fixed
> > sdma-Script.
> 
> disabling of DMA is not an option, because high throughput required for SPI
> bus to communicate with DSPs.

Is this a theoretical reasoning, or is that backed by testing? People
here on the list already said things like:

	The eCSPI appears to insert a 4 bit pause after each word in DMA
	mode, not done in PIO mode, which can make DMA transfers 50%
	slower than PIO.

You might want to read the thread
https://marc.info/?l=linux-spi&m=155191201208766&w=2
.

> I'm aware of ERR009165, but as I write some minutes earlier to list, spi0
> (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while spi4
> (alias for ecspi5) fails very fast.

As the issue is a timing race, it might depend on things like length of
the SPI lines, load on the data lines and other electrical properties.
So you might just be happy that spi0 and spi1 don't show the issue for
you. Or you didn't apply the "right" work load yet.

> Does same SDMA script used for all SPI interfaces or scripts are different?

As answered already before: The same script is used for all interfaces.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
