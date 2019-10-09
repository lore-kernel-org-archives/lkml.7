Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738B7ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A2206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfJIUQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:16:17 -0400
Received: from muru.com ([72.249.23.125]:36386 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIUQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:16:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 91A728140;
        Wed,  9 Oct 2019 20:16:49 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:16:12 -0700
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
Message-ID: <20191009201612.GQ5610@atomide.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
 <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
 <20191009173446.GL5610@atomide.com>
 <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191009 19:28]:
> On Wed, Oct 9, 2019 at 12:34 PM Tony Lindgren <tony@atomide.com> wrote:
> > From what I recall I tested that DMA on omap3 worked fine with runtime
> > PM for console. Certainly there are issues still remaining though.
> >
> > If you want to disable dma for a specific port, just delete the
> > add /delete-property/dma-names for the port in question in your
> > board specific dts file.
> >
> > See 8250_omap.c for of_property_count_strings(np, "dma-names").
> 
> Thank you.  That seems to have worked.  I'll check the AM3517 when I
> have some time to see if it needs the same patch.  For now, I pushed
> the patch to the omap mailing list for the Logic PD Torpedo board.
> 
> Should we consider removing the OMAP_SERIAL from omap2plus_defconfig
> in the 8250 is the preferred driver?  It seems odd to me that both
> drivers are enabled.

We have CONFIG_SERIAL_8250_OMAP=y and by default also we have
CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y. With those omap_serial
won't probe.. So yeah I guess for v5.5 we could drop the
option for CONFIG_SERIAL_OMAP for both omap2plus_defconfig and
multi_v7_defconfig.

Regards,

Tony
