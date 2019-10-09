Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF6ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBC0206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfJIRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:34:51 -0400
Received: from muru.com ([72.249.23.125]:36254 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJIReu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:34:50 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E5E6E8140;
        Wed,  9 Oct 2019 17:35:22 +0000 (UTC)
Date:   Wed, 9 Oct 2019 10:34:46 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Message-ID: <20191009173446.GL5610@atomide.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
 <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191009 14:09]:
> On Wed, Oct 9, 2019 at 8:42 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >
> > Hi Adam,
> >
> > On 06/10/19 10:34 PM, Adam Ford wrote:
> > > Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> > >
> > > I can use the DMA on the legacy, omap-serial driver, but when I enable
> > > the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> > >
> > > The older driver seems to have an ISR that seems to address a variety
> > > of items compared to the very tiny ISR for 8250-omap.c.
> > >
> > > I am not exactly sure where to start, but if someone has any
> > > suggestions on how I can troubleshoot, please let me know.  As of now,
> > > I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> > > connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> > > appears to work just fine after some patches I just submitted for
> > > handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> > >
> >
> > Mainline omap-serial does not support DMA (evident from lack of
> > dmaengine API calls) and therefore is not a regression. So OMAP3 UART
> > DMA was never tested at least with 8250 driver.
> > I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
> > analyse of whether all erratas workarounds are implemented and see if
> > there any difference wrt DMA integration itself. Do we know if UART DMA
> > ever worked on OMAP3 previously?
> 
> Can we disable CONFIG_SERIAL_8250_DMA from omap2plus_defconfig?   As
> of right now, it's the only way I can use the Bluetooth.  There are
> #ifdef's in the 8250-omap driver, so it looks like some of the hooks
> are there, but if it's incomplete, it seems like we shouldn't enable
> this config option by default yet.

From what I recall I tested that DMA on omap3 worked fine with runtime
PM for console. Certainly there are issues still remaining though.

If you want to disable dma for a specific port, just delete the
add /delete-property/dma-names for the port in question in your
board specific dts file.

See 8250_omap.c for of_property_count_strings(np, "dma-names").

Regards,

Tony


