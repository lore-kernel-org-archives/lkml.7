Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5924C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A232082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551717082;
	bh=VdwxNfcuV21nc1D0FGer1/LK/x/aa74mq3t4qb2R6mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fcreu2OK7PEpcTaVOIadQkNMr6vG11Ruib3jBAtn2HW3NMbNUqPbJYWsQzKDNXfqJ
	 Kedb9lHxmibqWrUmelxTsl1RN7aSt6tQT6wXbh6CGeFOy1UAqVv0iG6WWOAMRCj641
	 LhDBGogkTKHv2VJvRMm7+Og7s2U6p2DzX+bI2goI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCDQbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfCDQbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:31:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4546206B8;
        Mon,  4 Mar 2019 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551717079;
        bh=VdwxNfcuV21nc1D0FGer1/LK/x/aa74mq3t4qb2R6mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fygITPh8jPqKGBKYYz5ZE0QNLkqecS7zHw/dPtLmlgVv89q/uFuFF5ehzIs79baow
         4iym4f0LrDdQmEqqD25ij0apjZlUGhKfGENO+DUWonKlN1EvjQKjJbiZB8PJ1vzA2n
         20pv1MSraS9Lf6OpUqJvD/tcKDYDi8JkAO99I7G0=
Date:   Mon, 4 Mar 2019 17:31:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 2/2] drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190304163116.GC2301@kroah.com>
References: <20190228015223.34563-1-venture@google.com>
 <19097a78-7066-4fcd-aa79-aca4a8c3cb0c@www.fastmail.com>
 <CAO=notwGb2_HpcaMNRnaJfcjqoqWj1fws8A_OEH=kzH7PxJy0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=notwGb2_HpcaMNRnaJfcjqoqWj1fws8A_OEH=kzH7PxJy0w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:45:31AM -0800, Patrick Venture wrote:
> On Sun, Mar 3, 2019 at 4:04 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hi Patrick.
> >
> > I've got some minor comments, otherwise it looks reasonable to me.
> >
> > On Thu, 28 Feb 2019, at 12:22, Patrick Venture wrote:
> > > The ASPEED AST2400, and AST2500 in some configurations include a
> > > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > > in the BMC's physical address space.  This feature is especially useful
> > > when using this bridge to send large files to the BMC.
> > >
> > > The host may use this to send down a firmware image by staging data at a
> > > specific memory address, and in a coordinated effort with the BMC's
> > > software stack and kernel, transmit the bytes.
> > >
> > > This driver enables the BMC to unlock the PCI bridge on demand, and
> > > configure it via ioctl to allow the host to write bytes to an agreed
> > > upon location.  In the primary use-case, the region to use is known
> > > apriori on the BMC, and the host requests this information.  Once this
> > > request is received, the BMC's software stack will enable the bridge and
> > > the region and then using some software flow control (possibly via IPMI
> > > packets), copy the bytes down.  Once the process is complete, the BMC
> > > will disable the bridge and unset any region involved.
> > >
> > > The default behavior of this bridge when present is: enabled and all
> > > regions marked read-write.  This driver will fix the regions to be
> > > read-only and then disable the bridge entirely.
> > >
> > > The memory regions protected are:
> > >  * BMC flash MMIO window
> > >  * System flash MMIO windows
> > >  * SOC IO (peripheral MMIO)
> > >  * DRAM
> > >
> > > The DRAM region itself is all of DRAM and cannot be further specified.
> > > Once the PCI bridge is enabled, the host can read all of DRAM, and if
> > > the DRAM section is write-enabled, then it can write to all of it.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> > > ---
> > > Changes for v5:
> > > - Fixup missing exit condition and remove extra jump.
> > > Changes for v4:
> > > - Added ioctl for reading back the memory-region configuration.
> > > - Cleaned up some unused variables.
> > > Changes for v3:
> > > - Deleted unused read and write methods.
> > > Changes for v2:
> > > - Dropped unused reads.
> > > - Moved call to disable bridge to before registering device.
> > > - Switch from using regs to using a syscon regmap. <<< IN PROGRESS
> > > - Updated the commit message. <<< TODO
> > > - Updated the bit flipped for SCU180_ENP2A
> > > - Dropped boolean region_specified variable.
> > > - Renamed p2a_ctrl in _probe to misc_ctrl per suggestion.
> > > - Renamed aspeed_p2a_region_search to aspeed_p2a_region_acquire
> > > - Updated commit message.
> > > ---
> > >  drivers/misc/Kconfig                 |   8 +
> > >  drivers/misc/Makefile                |   1 +
> > >  drivers/misc/aspeed-p2a-ctrl.c       | 456 +++++++++++++++++++++++++++
> > >  include/uapi/linux/aspeed-p2a-ctrl.h |  59 ++++
> > >  4 files changed, 524 insertions(+)
> > >  create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
> > >  create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index f417b06e11c5..9de1bafe5606 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -485,6 +485,14 @@ config VEXPRESS_SYSCFG
> > >         bus. System Configuration interface is one of the possible means
> > >         of generating transactions on this bus.
> > >
> > > +config ASPEED_P2A_CTRL
> > > +     depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > > +     tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> > > +     help
> > > +       Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings
> > > through
> > > +       ioctl()s, the driver also provides an interface for userspace
> > > mappings to
> > > +       a pre-defined region.
> > > +
> > >  config ASPEED_LPC_CTRL
> > >       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > >       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index e39ccbbc1b3a..57577aee354f 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)       += vexpress-syscfg.o
> > >  obj-$(CONFIG_CXL_BASE)               += cxl/
> > >  obj-$(CONFIG_ASPEED_LPC_CTRL)        += aspeed-lpc-ctrl.o
> > >  obj-$(CONFIG_ASPEED_LPC_SNOOP)       += aspeed-lpc-snoop.o
> > > +obj-$(CONFIG_ASPEED_P2A_CTRL)        += aspeed-p2a-ctrl.o
> > >  obj-$(CONFIG_PCI_ENDPOINT_TEST)      += pci_endpoint_test.o
> > >  obj-$(CONFIG_OCXL)           += ocxl/
> > >  obj-y                                += cardreader/
> > > diff --git a/drivers/misc/aspeed-p2a-ctrl.c
> > > b/drivers/misc/aspeed-p2a-ctrl.c
> > > new file mode 100644
> > > index 000000000000..6bde4f64632d
> > > --- /dev/null
> > > +++ b/drivers/misc/aspeed-p2a-ctrl.c
> > > @@ -0,0 +1,456 @@
> > > +/*
> > > + * Copyright 2019 Google Inc
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License
> > > + * as published by the Free Software Foundation; either version
> > > + * 2 of the License, or (at your option) any later version.
> >
> > Should be a SPDX header instead.
> 
> Ok, so delete the above and drop in:
> 
> """
> /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> """

No no no no no no!

> Or just add that to the top above the Google GNU copyright line?  (I'm
> not a lawyer).

Please go read Documentation/process/license-rules.txt, it should
explain everything.  And if not, go talk to your legal council, they
know all about this and what is needed.

thanks,

greg k-h
