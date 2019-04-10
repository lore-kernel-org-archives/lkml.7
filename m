Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE79C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C8420820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfDJMyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:54:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDJMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:54:36 -0400
Received: from [147.83.201.128] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hECkL-0008IU-Dg; Wed, 10 Apr 2019 14:54:33 +0200
Date:   Wed, 10 Apr 2019 14:54:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
In-Reply-To: <CAD8Lp45nvFY=nj1q2wh4Y6w-8RVRfi3iJmC+xX1Vv7_VZOftdg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904101442080.3479@nanos.tec.linutronix.de>
References: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com> <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de> <CAD8Lp45nvFY=nj1q2wh4Y6w-8RVRfi3iJmC+xX1Vv7_VZOftdg@mail.gmail.com>
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

On Tue, 9 Apr 2019, Daniel Drake wrote:
> On Wed, Apr 3, 2019 at 7:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > That means we need the following decision logic:
> >
> >   1) If HPET is available in ACPI, boot normal.
> >
> >   2) If HPET is not available, verify that the PIT actually counts. If it
> >      does, boot normal.
> >
> >      If it does not either:
> >
> >      2A) Verify that this is a PCH 300/C240 and fiddle with that ISST bit.
> >
> >          But that means that we need to chase PCH ids forever...
> 
> (I found the ISST bit in the coreboot source code, which shows that
> the register is shared over multiple Intel SoC generations. I then
> searched for the register name online and found it documented in the
> 320/C240 public documentation, which I linked to. However that's not
> actually the platform in question. In this case we are working with
> Intel Apollo Lake N3350.)
> 
> Anyway, I agree that doing it with PCI IDs would be painful.
> 
> >      2B) Shrug and just avoid the whole PIT/HPET magic all over the place:
> >
> >          - Avoid the interrupt delivery check in the IOAPIC code as it's
> >            uninteresting in that case. Trivial to do.
> 
> What do you mean by "in that case"? In the case of having an IOAPIC?

In the case that neither HPET nor PIT are available or required.

> From my analysis above, this interrupt delivery check feels misplaced.

Not really.

> Other parts of the clock setup code (e.g. where PIC, HPET and APIC
> timer are enabled) do not seem to check that the timers being set up
> actually work. If I were to try a kernel with no APIC/LAPIC support
> then Linux would boot with a broken PIT as the clock source without
> checking it. So why do we check it here specifically in the IOAPIC
> code? I see it does some tricks which are presumably needed on
> historical platforms, but maybe it could let boot continue even if it
> can't find a working IRQ0 setup? Or it could at least skip the check
> if IRQ0 was not working before the IOAPIC gets set up?

It's not only historical. The irq0 'wiring' is still screwed up on newer
systems and we cannot rely on the ACPI/BIOS information.
 
> If there is desire for some "check that the clocksource is actually
> ticking" panic logic, maybe this could be done after the local APIC
> timer is setup (which is ultimately the clock source selected and
> used), maybe it should even be done in arch-independent code?

Well. Most systems have working timers. Just x86 is an utter trainwreck in
that regard.

PIT/HPET used to work just fine forever (except for the actual interrupt
delivery) so this is new terretory.
 
> >          - Prevent the TSC calibration code from touching PIT/HPET. It
> >            should do that already when the TSC frequency can be retrieved
> >            via CPUID or MSR. Should work, emphasis on should ...
> 
> >From above, this seems to be working acceptably already. It does touch
> the PIT, but ultimately ignores the information that it provided.

Yes, but we might actually be smarter than that.

> >          - Prevent the APIC calibration code from touching PIT/HPET. That's
> >            only happening right now when the TSC frequency comes from
> >            the MSRs. No idea why the CPUID method does not provide that.
> 
> Where's the APIC calibration code?

calibrate_APIC_clock()
 
> >            CPUID leaf 0x16 provides the bus frequency, so we can deduce the
> >            APIC timer frequency from there and spare the whole APIC timer
> >            calibration mess:
> >
> >                ECX Bits 15 - 00: Bus (Reference) Frequency (in MHz).
> 
> That's not available on this platform, plus
> architecture-instruction-set-extensions-programming-reference.pdf

Please use the SDM as reference, but yes it tells the same.

> page 1-21 says that the data returned is actually marketing stuff, and
> shouldn't be treated as real. I think you mean CPUID leaf 0x15
> instead.

No, it's not marketing. It's the specification and there must be a reason
why Intel decided to actually use it in the kernel:

    Author: Len Brown <len.brown@intel.com>
    Date:   Fri Jun 17 01:22:51 2016 -0400

    x86/tsc: Enumerate SKL cpu_khz and tsc_khz via CPUID
    
    Skylake CPU base-frequency and TSC frequency may differ
    by up to 2%.
    
    Enumerate CPU and TSC frequencies separately, allowing
    cpu_khz and tsc_khz to differ.
    
    The existing CPU frequency calibration mechanism is unchanged.
    However, CPUID extensions are preferred, when available.
    
    CPUID.0x16 is preferred over MSR and timer calibration
    for CPU frequency discovery.
    
    CPUID.0x15 takes precedence over CPU-frequency
    for TSC frequency discovery.


Leaf 0x15 does not tell the bus/reference clock which is what we need for
using the local apic timer (not the TSC deadline timer).

Thanks,

	tglx

