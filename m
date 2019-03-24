Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAE2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCXS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:59:37 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:44192 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCXS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:59:36 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id AFB6930034;
        Sun, 24 Mar 2019 20:59:32 +0200 (EET)
Date:   Sun, 24 Mar 2019 20:59:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition
 info
Message-ID: <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com>
 <20190320011630.GB7872@darkstar.musicnaut.iki.fi>
 <2631901.52Nzq63B5o@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2631901.52Nzq63B5o@z50>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
> Hi Aaro,
> 
> Thanks for your review.
> 
> On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> > On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> > > After recent modifications, only a hardcoded partition info makes
> > > the driver device specific.  Other than that, the driver uses GPIO
> > > exclusively and can be used on any hardware.
> > > 
> > > Drop the partition info and use MTD partition parser with default
> > > list of partition types instead.
> > > 
> > > Amstrad Delta users should append the followig partition info to their
> >                                         ^^^^^^^^
> > Should be "following".
> > 
> > > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> > > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> > > convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> > > Kconfig automatically if this NAND driver is also selected.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > 
> > Could we move the fixed partition setup to the board file
> > instead? Otherwise this kind of change is not really nice for the users,
> > as it will likely break existing setups. The default partition layout
> > should remain the same.
> 
> I'm wondering if it would be acceptable to pass partition info from a .dts 
> file.  I think that would be a better, more modern approach than adding a new 
> header under include/linux/platform_data.

Hmm, I thought there was some generic way to define partitions without
adding any new headers. But if that is not possible, then I guess your
CMDLINE proposal is the preferred one..

A.
