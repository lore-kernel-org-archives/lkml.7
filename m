Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E82C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF792147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfDDHrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:47:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24370 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDHrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:47:02 -0400
X-IronPort-AV: E=Sophos;i="5.60,306,1549954800"; 
   d="scan'208";a="29632751"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 00:47:01 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Thu, 4 Apr 2019
 00:47:00 -0700
Date:   Thu, 4 Apr 2019 09:47:00 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MIPS: generic: Add switchdev, pinctrl and fit
 to ocelot_defconfig
Message-ID: <20190404074658.d3lpobem2csl6xpd@soft-dev3.microsemi.net>
References: <1554305256-32702-1-git-send-email-horatiu.vultur@microchip.com>
 <20190403232334.7joxmw2a3qrhy2nf@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190403232334.7joxmw2a3qrhy2nf@pburton-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

The 04/03/2019 23:23, Paul Burton wrote:
> External E-Mail
> 
> 
> Hi Horatiu,
> 
> On Wed, Apr 03, 2019 at 05:27:36PM +0200, Horatiu Vultur wrote:
> > diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
> > index f607888..3215741 100644
> > --- a/arch/mips/configs/generic/board-ocelot.config
> > +++ b/arch/mips/configs/generic/board-ocelot.config
> >%
> > +# CONFIG_HID is not set
> > +# CONFIG_USB_SUPPORT is not set
> > +# CONFIG_VIRTIO_MENU is not set
> > +# CONFIG_SCSI is not set
> 
> Unfortunately this part won't work so well. If board-ocelot.config
> disables these things, then what should happen if another board that's
> also included in a generic kernel enables them?
> 
> eg. if you run 'make ARCH=mips 32r2el_defconfig' then we merge all of
> the following:
> 
>   board-boston.config enables USB
>   board-sead-3.config enables USB
>   board-ocelot.config disables USB

I didn't think about this scenario, because I didn't expect that
building a generic configuration will bring together all the board
configurations.

Anyway, I will send a new patch in which I will remove these
configurations.

> 
> These are mutually exclusive, and it seems that on my system we
> currently end up disabling USB due to board-ocelot.config. That will of
> course break USB support for Boston or SEAD-3 which are also supported
> by the same kernel binary. In practice which one 'wins' will depend on
> the order the files are listed by make's wildcard function - so far as
> I'm aware that doesn't guarantee any particular order so if it ends up
> depending on the order the filesystem lists the files or something like
> that then configurations might even differ when used on different
> machines.
> 
> So to avoid that the best we can do is leave these enabled and the
> general rule is that board-*.config files can only enable extra things,
> not disable them.
> 
> You might be tempted to disable the options in generic_defconfig &
> update any board configs that actually need them to enable them, but
> that doesn't work too well for things which are 'default y' because
> kconfig then warns about the conflict between generic_defconfig & the
> board config being merged with it. That applies to the first 3 of the
> entries you disable, leaving only CONFIG_SCSI that could potentially be
> dealt with that way...
> 
> Thanks,
>     Paul
> 

-- 
/Horatiu
