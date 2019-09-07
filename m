Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1507BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42B62178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394712AbfIGPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:00:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49349 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391215AbfIGPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:00:21 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6cCI-0007dS-9H; Sat, 07 Sep 2019 17:00:18 +0200
Date:   Sat, 7 Sep 2019 17:00:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Subject: Re: Linux 5.3-rc7
In-Reply-To: <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com> <156785100521.13300.14461504732265570003@skylake-alporthouse-com> <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
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
> Quoting Thomas Gleixner (2019-09-07 15:29:19)
> > On Sat, 7 Sep 2019, Chris Wilson wrote:
> > > Quoting Linus Torvalds (2019-09-02 18:28:26)
> > > > Bandan Das:
> > > >       x86/apic: Include the LDR when clearing out APIC registers
> > > 
> > > Apologies if this is known already, I'm way behind on email.
> > > 
> > > I've bisected
> > > 
> > > [   18.693846] smpboot: CPU 0 is now offline
> > > [   19.707737] smpboot: Booting Node 0 Processor 0 APIC 0x0
> > > [   29.707602] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> > > 
> > > https://intel-gfx-ci.01.org/tree/drm-tip/igt@perf_pmu@cpu-hotplug.html
> > > 
> > > to 558682b52919. (Reverts cleanly and fixes the problem.)
> > > 
> > > I'm guessing that this is also behind the suspend failures, missing
> > > /dev/cpu/0/msr, and random perf_event_open() failures we have observed
> > > in our CI since -rc7 across all generations of Intel cpus.
> > 
> > So is this on bare metal or in a VM?
> 
> Our single virtualised piece of kit doesn't support cpu hotplug, so this
> test is not being run. We have failures on
> icl (2019), glk (2017), kbl (2017), bxt (2016), skl (2015),
> bsw (2016), hsw (2013), byt (2013), snb (2011), elk (2008),
> bwr (2006), blb (2007)

Ok let me find a testbox to figure out whats wrong there.

Does this only happen with that CPU0 hotplug stuff enabled or on CPUs other
than CPU0 as well? That hotplug CPU0 stuff is a bandaid so I wouldn't be
surprised if we broke that somehow.

Thanks,

	tglx
