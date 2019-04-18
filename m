Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BDBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24A32087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfDRWaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:30:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39380 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfDRWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:30:11 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHFXf-0008IB-Sq; Fri, 19 Apr 2019 00:30:04 +0200
Date:   Fri, 19 Apr 2019 00:30:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
In-Reply-To: <alpine.DEB.2.21.1904181511150.3174@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904182359360.3174@nanos.tec.linutronix.de>
References: <20190417052810.3052-1-drake@endlessm.com> <alpine.DEB.2.21.1904181511150.3174@nanos.tec.linutronix.de>
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

On Thu, 18 Apr 2019, Thomas Gleixner wrote:
> On Wed, 17 Apr 2019, Daniel Drake wrote:
> 
> > The CPUID.0x16 leaf provides "Bus (Reference) Frequency (in MHz)".
> > 
> > In the thread "No 8254 PIT & no HPET on new Intel N3350 platforms
> > causes kernel panic during early boot" we are exploring ways to have
> > the kernel avoid using the PIT/HPET IRQ0 timer in more cases, and
> > Thomas Gleixner suggested that we could use this CPUID data to set
> > lapic_timer_frequency, avoiding the need for calibrate_APIC_clock()
> > to measure the APIC clock against the IRQ0 timer.
> > 
> > I'm thinking of the the following code change, however I get
> > unexpected results on Intel i7-8565U (Whiskey Lake). When
> > booting without this change, and with apic=notscdeadline (so that
> > APIC clock gets calibrated and used), the bus speed is detected as
> > 23MHz:
> > 
> >  ... lapic delta = 149994
> >  ... PM-Timer delta = 357939
> >  ... PM-Timer result ok
> >  ..... delta 149994
> >  ..... mult: 6442193
> >  ..... calibration result: 23999

That's 24MHZ which is the nominal clock for these machines.

> >  ..... CPU clock speed is 1991.0916 MHz.
> >  ..... host bus clock speed is 23.0999 MHz.

I think that printout is wrong in two aspects. First it should be
23.9999Mhz, second it should be 100MHz. This stuff comes from old systems
which had completely different clock setups.

> > However the CPUID.0x16 ECX reports a 100MHz bus speed on this device,
> > so this code change would produce a significantly different calibration.

Yes.

> > Am I doing anything obviously wrong?
> 
> It's probably just my fault sending you down the wrong path. What's the
> content of CPUUD.0x15 on that box?

I bet that CPUID.0x15 ECX says 24Mhz or it just says 0 like on my
machine. But then interestingly enough on that box I see:

   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio = 168/2
      nominal core crystal clock = 0 Hz

   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) = 0x834 (2100)
      Core Maximum Frequency (MHz) = 0xed8 (3800)
      Bus (Reference) Frequency (MHz) = 0x64 (100)

Assuming that TSC and local APIC timer run from the same frequency on these
modern machines.

       2100MHz * 2 / 168 = 25MHz

and disabling the tsc deadline timer tells me:

  ..... calibration result: 24999

Close enough. Thinking about it - that makes a lot of sense. With TSC
deadline timer available it would be pretty silly if there is yet another
clock feeding into local APIC.

And the 0x15 -> 0x16 correlation is clear as well. The TSC runs at the
nominal CPU frequency, in this case 2100MHz. So the nominator/denominator
pair from 0x15 allows to deduce the nominal core crystal clock which seems
to be exactly the clock which is fed into the local APIC timer.

If someone from Intel could confirm that, then we could make that work for
any modern system.

Thanks,

	tglx
