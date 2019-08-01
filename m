Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB0B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHAKN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:13:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:13:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ht85J-0002jZ-C1; Thu, 01 Aug 2019 12:13:21 +0200
Date:   Thu, 1 Aug 2019 12:13:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de> <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de> <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019, Li, Aubrey wrote:
> On 2019/8/1 16:13, Thomas Gleixner wrote:
> > The point is that it does not matter which vendor a CPU comes from. The
> > kernel does support legacyless boot when the frequencies are known. Whether
> > that's currently possible on that particular CPU is a different question.
> > 
> Yeah, I should specify, Daniel, your platform needs a global clock event, ;-)

Care to look at the manuals before making assumptions?

  2.1.9 Timers

   Each core includes the following timers. These timers do not vary in
   frequency regardless of the current P-state or C-state.

   * Core::X86::Msr::TSC; the TSC increments at the rate specified by the
     P0 Pstate. See Core::X86::Msr::PStateDef.

   * The APIC timer (Core::X86::Apic::TimerInitialCount and
     Core::X86::Apic::TimerCurrentCount), which increments at the rate of
     2xCLKIN; the APIC timer may increment in units of between 1 and 8.

The Ryzens use a 100MHz input clock for the APIC normally, but I'm not sure
whether this is subject to overclocking. If so then it should be possible
to figure that out somehow. Tom?

Thanks,

	tglx

