Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66AAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEFA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfHHVJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:09:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHHVJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:09:12 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvpeg-0008E7-78; Thu, 08 Aug 2019 23:09:02 +0200
Date:   Thu, 8 Aug 2019 23:08:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
Message-ID: <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de> <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de> <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de> <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
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

Tom,

On Thu, 8 Aug 2019, Lendacky, Thomas wrote:
> On 8/8/19 3:36 PM, Thomas Gleixner wrote:
> > On Thu, 1 Aug 2019, Lendacky, Thomas wrote:
> >> On 8/1/19 5:13 AM, Thomas Gleixner wrote:
> >>>    2.1.9 Timers
> >>>
> >>>     Each core includes the following timers. These timers do not vary in
> >>>     frequency regardless of the current P-state or C-state.
> >>>
> >>>     * Core::X86::Msr::TSC; the TSC increments at the rate specified by the
> >>>       P0 Pstate. See Core::X86::Msr::PStateDef.
> >>>
> >>>     * The APIC timer (Core::X86::Apic::TimerInitialCount and
> >>>       Core::X86::Apic::TimerCurrentCount), which increments at the rate of
> >>>       2xCLKIN; the APIC timer may increment in units of between 1 and 8.
> >>>
> >>> The Ryzens use a 100MHz input clock for the APIC normally, but I'm not sure
> >>> whether this is subject to overclocking. If so then it should be possible
> >>> to figure that out somehow. Tom?
> >>
> >> Let me check with the hardware folks and I'll get back to you.
> > 
> > any update on this? The problem seems to come in from several sides now.
> 
> Yes, sort of. There are two ways to overclock and it all depends on which
> one was used. If the overclocking is done by changing the multipliers,
> then that 100MHz clock will still be 100MHz. But if the overclocking is
> done by increasing the input clock, then that 100MHz clock will also
> increase.
> 
> I was trying to get a bit more clarification on this before replying, but
> it can be detected in software. The base clock is 100MHz, so read the P0
> multiplier and the TSC should be counting at P0 * 100MHz. If you calibrate
> the speed of the TSC with the HPET you can see what speed the TSC is
> counting at. If you divide the TSC delta from the HPET calibration by the
> P0 multiplier you will either get 100MHz if there is no overclocking or if
> the multiplier method of overclocking was used, otherwise you'll get a
> higher value if the input clock method was used. Either way, that should
> give you the APIC clock speed based on a starting assumption of 100MHz.

The problem is that we have no HPET on those machines ....

I think I can get away without having HPET and PIT and do some smart stuff
with the pm timer for that stuff. I'll look at it tomorrow with brain
actually awake.

Thanks,

	tglx





