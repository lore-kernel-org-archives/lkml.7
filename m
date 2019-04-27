Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A79BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98A92087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfD0JST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:18:19 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:53606 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0JST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:18:19 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990717AbfD0JSPYKUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sat, 27 Apr 2019 11:18:15 +0200
Date:   Sat, 27 Apr 2019 11:18:06 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: Drop board specific
 partition info
Message-ID: <20190427091806.GA10143@lenoch>
References: <20190324223344.24590-1-jmkrzyszt@gmail.com>
 <20190424180212.10830-1-jmkrzyszt@gmail.com>
 <20190424221428.GA4172@lenoch>
 <3173726.PU223hZCOI@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3173726.PU223hZCOI@z50>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:42:22PM +0200, Janusz Krzysztofik wrote:
> Hi Ladislav,
> 
> On Thursday, April 25, 2019 12:14:28 AM CEST Ladislav Michl wrote:
> > Hi Janusz,
> > 
> > On Wed, Apr 24, 2019 at 08:02:12PM +0200, Janusz Krzysztofik wrote:
> > > After recent modifications, only a hardcoded partition info makes
> > > the driver device specific.  Other than that, the driver uses GPIO
> > > exclusively and can be used on any hardware.
> > > 
> > > Drop the partition info and use MTD partition parser with default list
> > > of parser names instead.  For the OF parser to work correctly, pass
> > > device of_node to mtd.
> > > 
> > > Amstrad Delta users should append the following partition info to their
> > > kernel command line, possibly embedding it in CONFIG_CMDLINE:
> > > 
> > > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> > > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)
> > 
> > now, when driver is no longer Amstrad Delta specific, why would you want
> > to have ams-delta-nand hardcoded on kernel cmdline? I'm assuming at some
> > point this driver will become gpio-nand [*] or something like that and
> > asking users to change their kernel cmdline twice is just unwise :)
> 
> Hmm, I have no idea of a good name for the driver if not "gpio-nand". Can you 
> suggest one?

gpio-nand is so good name that it should be worth merging gpio.c and
ams-delta.c into gpio_nand.c :)

> As a workaround, I can add a platform device id table to the driver with "ams-
> delta-nand" as a supported device name in hope that survives possible future 
> driver renaming.
> 
> > [*] btw, it is really shame gpio-nand name is already taken by driver
> > living in drivers/mtd/nand/raw/gpio.c which is more likely gpio-mem-nand
> > used by at least CompuLab CM-X255 and Picochip picoXcell.
> 
> I think the best approach would be to expose NAND data ports of those machines 
> as GPIO ports, possibly reusing the "gpio-nand" driver code while creating a 
> new GPIO driver for them if "basic-mmio-gpio" occurs inappropriate, and use 
> the pure GPIO NAND driver on top.

What about adding two fields into struct ams_delta_nand holding pointers to
either ams_delta_{read,write}_buf (renamed to gpio_nand_...) or mmio r/w
functions depending on driver configuration?

> > Otherwise your work on this driver is so amazing that I just spent
> > couple of hours finding that phone and compiling some decent userspace
> > for it :) Thank you!
> 
> I'm glad you like it :-)
> Janusz

Best regards,
	ladis
