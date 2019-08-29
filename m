Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00360C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832D206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH2ViZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:38:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfH2ViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:38:24 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3S7Q-0007gp-9w; Thu, 29 Aug 2019 23:38:12 +0200
Date:   Thu, 29 Aug 2019 23:38:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, Pu Wen <puwen@hygon.cn>
Subject: [RFD] x86/tsc: Loosen the requirements for watchdog - (was x86/hpet:
 Disable HPET on Intel Coffe Lake)
In-Reply-To: <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908292225000.1938@nanos.tec.linutronix.de>
References: <20190829091232.15065-1-kai.heng.feng@canonical.com> <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de> <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com> <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1424968746-1567110808=:1938"
Content-ID: <alpine.DEB.2.21.1908292235200.1938@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1424968746-1567110808=:1938
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1908292235201.1938@nanos.tec.linutronix.de>

On Thu, 29 Aug 2019, Thomas Gleixner wrote:
> On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
> > I know we should find the root cause rather than stopping at "it’s a firmware
> > bug”, but users are already affected by this issue [1].
> > Is there any better short-term workaround?
> 
> Not really. And if Intel stays silent, I'm just going to apply it as is
> along with a stable tag.

Summary for those who are new on CC:

   Coffee Lake machines have a C10 state wrecked HPET which causes the TSC
   clocksource watchdog to misbehave which is not surprising as that's like
   trying to monitor an atomic clock with a sun-dial.

   So the intention is to disable HPET on those machines which affects also
   Kaby Lake CPUs as they share the model number and just differ in the
   stepping. Unless we get precise information from Intel which steppings
   are affected and that these are the only ones, we won't go down the
   stepping road as that is going to be an endless whack a mole game. Tried
   that before and got burned...

While disabling HPET sounds trivial, this can have side effects.

If the HPET is not available for whatever reason the kernel will use
ACPI_PMTIMER as fallback clocksource for monitoring the TSC if the affected
systems actually advertise it. If not that will effectively disable NOHZ
and high resolution timers. Disabling NOHZ is a pain for power consumption
and those machines are mostly laptops I assume.

Now there is something we can consider to do:

These CPUs have finally a working and usable TSC - knock on wood!

Just for the record: That's 20+ years after we started to asked for it!

The TSC has constant frequency and does not stop in deeper C-states. Aside
of that these CPUs have the TSC_ADJUST MSR which allows us to figure out
when the BIOS/SMM manages to wreckage the TSC on a CPU by writing to it for
completely wrong reasons.

So we could finally start to trust TSC at least on single socket systems.

Multi-socket is a different story as the sockets might drift apart for
reasons which I really don't want to discuss in this context for CoC's
sake. So we definitely want a watchdog there as TSC ADJUST is not able to
catch those issues.

So if we have to disable the HPET on Kaby Lake alltogether unless Intel
comes up with the clever fix, i.e. poking at the right registers, then I
think we should also lift the TSC watchdog restrictions on these machines
if they are single socket, which they are as the affected CPUs so far are
mobile and client types.

Also given the fact that we get more and more 'reduced' hardware exposed
via ACPI and we already dealt with quite some fallout with various related
issues due to that, I fear we need to bite this bullet anyway anytime soon.

But TBH, 20+ years exposure to subtly wrecked timer hardware has left quite
a few scars.

I put AMD/HYGON folks on CC as well as they will run into similar problems
sooner than later and their CPUs still do not have the TSC_ADJUST MSR which
is paramount to loosen the watchdog restrictions. Hint, hint, hint...

Thoughts?

Thanks,

	tglx
--8323329-1424968746-1567110808=:1938--
