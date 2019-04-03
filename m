Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0BEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D920830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCLVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:21:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCLVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:21:51 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBdxf-0004Rj-8I; Wed, 03 Apr 2019 13:21:43 +0200
Date:   Wed, 3 Apr 2019 13:21:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
In-Reply-To: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
References: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Wed, 3 Apr 2019, Daniel Drake wrote:

> After encountering this on Connex L1430 last time, we have now
> encountered another affected product, from a different vendor (SCOPE
> SN116PYA). They both have Intel Apollo Lake N3350 and AMI BIOS.
> 
> The code in question is making sure that the IRQ0 timer works, by
> waiting for an interrupt. In this case there is no interrupt.

Right.

> The x86 platform code in hpet_time_init() tries to enable the HPET
> timer for this, however that is not available on these affected
> platforms (no HPET ACPI table). So it then falls back on the 8253/8254
> legacy PIT. The i8253.c driver is invoked to program the PIT
> accordingly, however in this case it does not result in any IRQ0
> interrupts being generated --> panic.

Correct.

> I found a relevant setting in the BIOS: Chipset -> South Cluster
> Configuration -> Miscellaneous Configuration -> 8254 Clock Gating
> This option is set to Enabled by default. Setting it to Disabled makes
> the PIT tick and Linux boot finally works.

Well, your BIOS at least has this switch ...

> As another data point, Windows 10 boots fine in this no-PIT no-HPET
> configuation.

We have support for HPET/PIT less systems already. We just need to figure
out how to switch to that mode automagically at early boot.

ACPI obviously does not switch to it with the ACPI_FADT_HW_REDUCED flag.

> Going deeper, I found the clock_gate_8254 option in the coreboot
> source code. This pointed me to the ITSSPRC register, which is
> documented on page 1694 of
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
> 
> "8254 Static Clock Gating Enable (CGE8254): When set, the 8254 timer
> is disabled statically. This bit shall be set by BIOS if the 8254
> feature is not needed in the system or before BIOS hands off the
> system that supports C11. Normal operation of 8254 requires this bit
> to 0."
> 
> (what's C11?)

Don't know. Some magic new C-State perhaps? Rafael?

Btw, one of those links you provided

  https://www.manualslib.com/manual/1316475/Ecs-Ed20pa2.html?page=23

claims that you have to disable MWAIT as well. No idea why. Is MWAIT
disabled on your platform?

> I verified that the BIOS setting controls this specific bit value, and
> I also created and verified a workaround that unsets this bit - now
> Linux boots fine regardless of the BIOS setting:
> 
> #define INTEL_APL_PSR_BASE        0xd0000000
> #define INTEL_APL_PID_ITSS        0xd0
> #define INTEL_PCR_PORTID_SHIFT    16
> #define INTEL_APL_PCR_ITSSPRC    0x3300
> static void quirk_intel_apl_8254(void)
> {
>     u32 addr = INTEL_APL_PSR_BASE | \
>         (INTEL_APL_PID_ITSS << INTEL_PCR_PORTID_SHIFT) | \
>         INTEL_APL_PCR_ITSSPRC;
>     u32 value;
>     void __iomem *itssprc = ioremap_nocache(addr, 4);
> 
>     if (!itssprc)
>         return;
> 
>     value = readl(itssprc);
>     if (value & 4) {
>         value &= ~4;
>         writel(value, itssprc);
>     }
>     iounmap(itssprc);
> }
>
> I was hoping I could send a workaround patch here, but I'm not sure of
> an appropriate way to detect that we are on an Intel Apollo Lake
> platform. This timer stuff happens during early boot, the early quirks
> in pci/quirks.c run too late for this. Suggestions appreciated.

We have early-quirks.c in arch/x86/kernel/ for that.

> Poking at other angles, I tried taking the HPET ACPI table from
> another (working) Intel N3350 system and putting it in the initrd as
> an override. This makes the HPET work fine, at which point Linux boots
> OK without having to touch the (BIOS-crippled) PIT.

We already have quirks for force enabling HPET, so that could be added.

> I'm at the limit of my current knowledge here, but there's an open
> question of whether Linux could be made to work without a working PIT
> and no HPET, in the same way that grub and Windows seem to manage.
> Even though it is currently essential for boot, the PIT (or HPET) is
> usually only needed to tick a few times before being replaced with the
> APIC timer as a clocksource (when setup_APIC_timer() happens, the
> clocksource layer disables the previous timer source). However, Thomas
> Gleixner gave some hints at the importance of the PIT/HPET here:
> 
> > Well, [avoiding the PIT/HPET ticking requirement] would be trivial if we
> > could rely on the APIC timer being functional on all CPUs and if we could
> > figure out the APIC timer frequency without calibrating it against the
> > PIT/HPET on older CPUs. Plus a gazillion of other issues (e.g. APIC stops
> > in C states ....)
> > [...]
> > Under certain conditions we actually might avoid touching PIT/HPET and
> > solely rely on the CPUID/MSR calibration values. Needs quite some thought
> > though.

For newer CPUs we might assume that:

 1) The TSC and APIC timer are actually usable

 2) The frequencies can be retrieved from CPUID or MSRs

If #1 and #2 are reliable we can avoid the whole calibration and interrupt
delivery mess.

That means we need the following decision logic:

  1) If HPET is available in ACPI, boot normal.

  2) If HPET is not available, verify that the PIT actually counts. If it
     does, boot normal.

     If it does not either:

     2A) Verify that this is a PCH 300/C240 and fiddle with that ISST bit.

     	 But that means that we need to chase PCH ids forever...

     2B) Shrug and just avoid the whole PIT/HPET magic all over the place:

     	 - Avoid the interrupt delivery check in the IOAPIC code as it's
           uninteresting in that case. Trivial to do.
	 
	 - Prevent the TSC calibration code from touching PIT/HPET. It
           should do that already when the TSC frequency can be retrieved
           via CPUID or MSR. Should work, emphasis on should ...

    	   See the mess in: native_calibrate_tsc() and the magic tables in
	   tsc_msr.c how well that stuff works.

	   The cpu_khz_from_cpuid() case at seems to not have these
	   issues. Knock on wood!

         - Prevent the APIC calibration code from touching PIT/HPET. That's
           only happening right now when the TSC frequency comes from
	   the MSRs. No idea why the CPUID method does not provide that.

	   CPUID leaf 0x16 provides the bus frequency, so we can deduce the
	   APIC timer frequency from there and spare the whole APIC timer
	   calibration mess:

  	       ECX Bits 15 - 00: Bus (Reference) Frequency (in MHz).

	   It's usually not required on these newer CPUs because they
	   support TSC deadline timer, but you can disable that on the
	   kernel command line and some implementations of that were
	   broken. With that we are back to square one.

	   So we need to make sure that these things work under all
	   circumstances.

   Rafael?

Thanks,

	tglx


