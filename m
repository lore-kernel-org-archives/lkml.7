Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A203B21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406122AbfIGUM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:12:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395252AbfIGUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:12:56 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6h4n-0001b8-OG; Sat, 07 Sep 2019 22:12:53 +0200
Date:   Sat, 7 Sep 2019 22:12:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Subject: Re: Linux 5.3-rc7
In-Reply-To: <156786988815.13300.14460569616117208043@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1909072109030.1902@nanos.tec.linutronix.de>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com> <156785100521.13300.14461504732265570003@skylake-alporthouse-com> <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de> <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de> <156786988815.13300.14460569616117208043@skylake-alporthouse-com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2019, Chris Wilson wrote:
> Quoting Thomas Gleixner (2019-09-07 16:00:17)
> > Does this only happen with that CPU0 hotplug stuff enabled or on CPUs other
> > than CPU0 as well? That hotplug CPU0 stuff is a bandaid so I wouldn't be
> > surprised if we broke that somehow.
> 
> If I ignore cpu0 in that test and so use
> 
> [  133.847187] smpboot: CPU 1 is now offline
> [  134.861861] x86: Booting SMP configuration:
> [  134.861875] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  134.880218] smpboot: CPU 2 is now offline
> [  135.893806] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [  135.935115] smpboot: CPU 3 is now offline
> [  136.949760] smpboot: Booting Node 0 Processor 3 APIC 0x3
> 
> that has run for 10 minutes without failure, so it seems confined to
> cpu0 hotplugging. All we are doing in the test to generate the hotplugs
> is:

Right, but you also have that config bit enabled which allows CPU0 hotplug
which usually is off even in testing and that's why nobody noticed so far.

So I looked at that code and I know why it's broken. I guess we'll end up
reverting that commit for now as fixing it proper will be not just a one
liner.

Thanks for providing all the information!


       tglx
