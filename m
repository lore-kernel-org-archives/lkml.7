Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E01FC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE928217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfKEUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:36:28 -0500
Received: from cynthia.allandria.com ([50.242.82.17]:51581 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKEUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:36:27 -0500
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1iS5Yr-0003WE-2t; Tue, 05 Nov 2019 12:36:21 -0800
Date:   Tue, 5 Nov 2019 12:36:21 -0800
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
Message-ID: <20191105203620.GA12862@allandria.com>
References: <20191001073539.4488-1-geert@linux-m68k.org>
 <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
 <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
 <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de>
 <20191105005318.GA29558@allandria.com>
 <alpine.LNX.2.21.1.1911051318590.160@nippy.intranet>
 <20191105031946.GA31507@allandria.com>
 <alpine.LNX.2.21.1.1911051444570.160@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1.1911051444570.160@nippy.intranet>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:13:31PM +1100, Finn Thain wrote:
> On Mon, 4 Nov 2019, Brad Boyer wrote:
> > I'll try the PB190 first anyway. It should be easier due to not needing 
> > to setup a monitor. 
> 
> I think you can put the 630 into a standard VESA video mode (with MacOS or 
> Linux) given the right adapter/cable. I have a pin-out somewhere.

I have an adapter. I also own several official Apple monitors of various
styles and capabilities. The problem is desk space. I need to clean before
I have enough room to setup anything bigger than a laptop.

> > I just took a look at the macide driver, and it appears to do basically
> > nothing other than pass a list of addresses into the core ide code. It's
> > one of the smallest drivers I've ever seen.
> > 
> 
> The fly in the ointment is interrupt handling. There is a theoretical bug. 
> (Though it doesn't seem to hurt in practice.)
> 
> AFAIK the hardware is publicly undocumented and so we need to do 
> experiments like this:
> https://github.com/fthain/linux/commit/01405199e8d05500bf458df690027655f526a7fd
> 
> My suspicion is that macide_clear_irq() does nothing useful. It's not 
> called on a Powerbook 190. Maybe it is needed on a PowerBook 150 and 
> Performa 630, maybe not...

My understanding has always been that Apple was really sloppy with how
the hardware handled interrupts. On many models, you can't actually
block interrupts in a sane fashion. Because of that, you usually have
to shut up the interrupts by talking to the actual device.

I would not be surprised in the slightest to see that register write
do absolutely nothing. It might be more interesting to just disable
the clear function for all models and see if it still works. I don't
have a PB 150 to test that style, but I do have the other two.

> > > But watch out for leaking capacitors and batteries...
> > 
> > I should pull out every machine in my collection and look for those 
> > sorts of issues. None of them have been checked in at least 5 or 6 
> > years.
> > 
> 
> None of the machines in my collection have any batteries now. Desoldering 
> the Ni-Cd PRAM battery from a Powerbook 14x/16x/170/180 is difficult but 
> necessary. Powerbook 150 and 190 are easier (no desoldering needed).

That makes sense. I need to do the same. It's just a pain since a few
models won't boot without a battery.

	Brad Boyer
	flar@allandria.com

