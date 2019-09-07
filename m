Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74845218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394652AbfIGOle convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 10:41:34 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57260 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727381AbfIGOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:41:34 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18409534-1500050 
        for multiple; Sat, 07 Sep 2019 15:41:21 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
Message-ID: <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.3-rc7
Date:   Sat, 07 Sep 2019 15:41:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-09-07 15:29:19)
> On Sat, 7 Sep 2019, Chris Wilson wrote:
> > Quoting Linus Torvalds (2019-09-02 18:28:26)
> > > Bandan Das:
> > >       x86/apic: Include the LDR when clearing out APIC registers
> > 
> > Apologies if this is known already, I'm way behind on email.
> > 
> > I've bisected
> > 
> > [   18.693846] smpboot: CPU 0 is now offline
> > [   19.707737] smpboot: Booting Node 0 Processor 0 APIC 0x0
> > [   29.707602] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> > 
> > https://intel-gfx-ci.01.org/tree/drm-tip/igt@perf_pmu@cpu-hotplug.html
> > 
> > to 558682b52919. (Reverts cleanly and fixes the problem.)
> > 
> > I'm guessing that this is also behind the suspend failures, missing
> > /dev/cpu/0/msr, and random perf_event_open() failures we have observed
> > in our CI since -rc7 across all generations of Intel cpus.
> 
> So is this on bare metal or in a VM?

Our single virtualised piece of kit doesn't support cpu hotplug, so this
test is not being run. We have failures on
icl (2019), glk (2017), kbl (2017), bxt (2016), skl (2015),
bsw (2016), hsw (2013), byt (2013), snb (2011), elk (2008),
bwr (2006), blb (2007)
-Chris
