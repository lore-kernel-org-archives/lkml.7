Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D13E2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfCEJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:55:09 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49110 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfCEJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:55:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4E16729D6F;
        Tue,  5 Mar 2019 04:55:05 -0500 (EST)
Date:   Tue, 5 Mar 2019 20:55:21 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kars de Jong <jongk@linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/14] m68k: Drop arch_gettimeoffset and adopt
 clocksource API
In-Reply-To: <CAMuHMdW60DhofaVqdts-TmJbgpwVD7NOY4Hp9bbXD5K6-gp5GA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1903052027020.147@nippy.intranet>
References: <cover.1543625590.git.fthain@telegraphics.com.au> <alpine.LNX.2.21.1903051706060.145@nippy.intranet> <CAMuHMdW60DhofaVqdts-TmJbgpwVD7NOY4Hp9bbXD5K6-gp5GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Geert Uytterhoeven wrote:

> On Tue, Mar 5, 2019 at 7:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Sat, 1 Dec 2018, Finn Thain wrote:
> > > This series removes "select ARCH_USES_GETTIMEOFFSET" from arch/m68k
> > > and converts users of arch_gettimeoffset to the clocksource API.
> > > Various bugs are fixed along the way.
> >
> > Are there any plans to merge this series, Geert?
> 
> Has this been tested on all/most platforms? Or do you think is it safe to
> apply regardless?
> 

The amiga, atari and mac patches have been tested.

The apollo, q40, sun3 and sun3x patches are safe though untested, AFAIK. I 
confirmed that, in qemu at least, the default jiffies clocksource will 
work, and the patch is trivial.

That leaves bvme6000, hp300, mvme147 and mvme16x. Those have not been 
tested. Here are some options for those platforms:

1) Apply the patches untested (gaining new clocksources and some API 
modernization for m68k, while fixing old bugs and potentially introducing 
new bugs).

2) Do nothing until someone tests the patch series on those 4 platforms.

3) Rewrite patches such that those 4 platforms get the same treatment as 
apollo, q40, sun3 and sun3x (this plan was already nak'd in the hp300 
case).

4) Keep using the gettimeoffset API. Redo the patch series to keep the bug 
fixes for the 3 platforms that can be readily tested. When the API change 
becomes unavoidable, remove difficult platforms.

Maybe there are other possibilities?

-- 

> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
