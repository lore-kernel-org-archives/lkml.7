Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A128C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8B8217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="e8EumAn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDIFnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:43:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36518 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfDIFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:43:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so9527107qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 22:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7t34YS+soWSqp1oCFokkLGQCnku+YKid6LaQBHdnAn8=;
        b=e8EumAn5k5n3BauwtCyjzcbaYHB6vT/hW8Fvs5zyGPwxSFTdcaqumzDIenxeipl7EO
         lE6+Z832GzPZYyQ0gQGcF31+Ig3O/76dIuIUOgyCfRBvhvWKJmAfAGs6tVB5NRDDdzlc
         whz5G9bswJren1d0jONcX0cuqfNnn8Zkc3x4RJT1Y06Gr1spdJUAKYK6ccEtL9mcGAF0
         NMNrraIs8Fz4WXUJj11m4niLonjqrqt/TQq3lZAdbaAyhcmilj/2EjFlmGoER2tUdzSw
         jbnpD0QYQFQHsHymuUp2b9oJBHv5QCRHaYVQNJTMuftxI3Hek+LwP9qO7Gx94MdvrXjF
         vn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7t34YS+soWSqp1oCFokkLGQCnku+YKid6LaQBHdnAn8=;
        b=RXK0O9yQSymloEkuh2QwF1VPqDSm8dmnjfYynTtE6ew10o3c5QZtalxSuP3enQkLkE
         kcGp8dKg1MxWfksWxL+8fzewkThcRNHN5j1s0m/wiXG1Jj4PpSpfJvm1lfWkeE0N/DX2
         33HHSplCN7oQKgsWi6tcUW5dPUgeVxlpj1TGmjZA455eiMrPMh1OLyiv8PWQofUFKX9s
         BtemlJypipVcJjT83hBW4eB8bHHqBYfmH6fnYctcItuYaA9GING2U4a9PxPpp3lGxxEp
         Fc5Tkm2uRSP5XYUcRdtvdnFDBYAr1/tqF/Z6GTYrHZ4dF4jwHdUui2VsrrRBfomk/0gd
         /GQg==
X-Gm-Message-State: APjAAAVx78p1uJa1M337XxKyMuBU+DWUaiAllWIXfsZ92YsyVbnsI0wN
        n2tpx+jAn4kMj5n5KZilo0VnvrxNU52PRm+8xl03XA==
X-Google-Smtp-Source: APXvYqx2100Df8JfXVit5njNYEu8DbLnzIJG/dvj16vLcQa7rQ2f4QJCXssQYaIyNpKTWGJht3SPeaJ9k3p7LDbyi+s=
X-Received: by 2002:a37:e315:: with SMTP id y21mr26294832qki.233.1554788631817;
 Mon, 08 Apr 2019 22:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com>
 <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 9 Apr 2019 13:43:40 +0800
Message-ID: <CAD8Lp45nvFY=nj1q2wh4Y6w-8RVRfi3iJmC+xX1Vv7_VZOftdg@mail.gmail.com>
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        david.e.box@linux.intel.com,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Btw, one of those links you provided
>
>   https://www.manualslib.com/manual/1316475/Ecs-Ed20pa2.html?page=23
>
> claims that you have to disable MWAIT as well. No idea why. Is MWAIT
> disabled on your platform?

I don't have that option in the BIOS. However there's no mention of
"mwait" nor "mwaitx" in /proc/cpuinfo. Checking our more general
database of 202 x86_64 consumer products released over the last few
years, only 19 of them have mwait/mwaitx listed there and they tend to
be older platforms.

> We have early-quirks.c in arch/x86/kernel/ for that.

Nice, we should be able to work around the issue there, but I hope we
can find something better...

> For newer CPUs we might assume that:
>
>  1) The TSC and APIC timer are actually usable
>
>  2) The frequencies can be retrieved from CPUID or MSRs
>
> If #1 and #2 are reliable we can avoid the whole calibration and interrupt
> delivery mess.

Let's take a step back and re-examine the wider sequence of events
here (which I've now done thanks to your pointers).

1. In very early boot, we face the TSC calibration challenge, arriving
at determine_cpu_tsc_frequencies(). This function calculates CPU
frequency and TSC frequency separately.

For the CPU frequency, native_calibrate_cpu_early() tries to do it via
cpu_khz_from_cpuid() with CPUID leaf 0x16, but this is not available
on the platforms in question, which have max cpuid level 0x15.
cpu_khz_from_msr() is then tried, but that doesn't support this
platform either (looks like it only supports older SoC generations).
So now we arrive in quick_pit_calibrate(), which directly programs the
PIT and measures the TSC rate against the PIT ticks.

When the 8254 is ungated in the BIOS, this function fails early because:
    if (pit_expect_msb(0xff, &tsc, &d1)) {
/* returned at count=13, d1 is now 32118 */
        for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
            if (!pit_expect_msb(0xff-i, &delta, &d2))
/* returned at count=13, d2 is now 48595 */
                break;

            delta -= tsc;
/* delta is now 246741 */

            /*
             * Extrapolate the error and fail fast if the error will
             * never be below 500 ppm.
             */
            if (i == 1 &&
                d1 + d2 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11)
                return 0;
/* this return statement is hit, the calculation is:
32118 + 48595 >= (246741 * 233) >> 11
*/

so the error was too high (I'm not sure why) and
determine_cpu_tsc_frequencies() records the CPU frequency as 0.

Then, comparing to when the 8254 is gated via the BIOS option, the
behaviour is surprising too.
In that case, the quick_calibrate_pit() loop runs through up to i=128,
at which point the error level is low enough to be accepted,
calculating the CPU frequency as 4448MHz (4x higher than reality).
During each loop iteration, pit_expect_msb() returns when the value
changes at count=63 (compared to 13 in the PIT-ungated case). Does
this suggest the PIT is not actually fully gated, it's just ticking a
lot slower than otherwise?

Anyway, back in determine_cpu_tsc_frequencies() with the CPU frequency
calibration done, we now do TSC calibration. This one succeeds in all
cases via native_calibrate_tsc()  using CPUID leaf 0x15 to read the
correct value. The TSC is 1094MHz.

Then, in both cases (8254 gated or not), the CPU frequency calculation
is discarded here, because it's wildly different from the TSC rate:
    else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
        cpu_khz = tsc_khz;

So it seems that this code already behaves along the lines you
describe: it gives more trust to the TSC value read in the modern way,
and does not get upset if the CPU frequency calibration against the
PIT didn't produce a meaningful result.


2. Significantly later during boot, x86_late_time_init() calls
hpet_time_init() which sets up either the PIT or HPET. However, as far
as I can see, there is no checking that the selected clock is actually
ticking. In the case of these affected platforms with the 8254 gated,
we sail right pass this point without a working clock source.

3. x86_late_time_init() then calls apic_intr_mode_init() ->
apic_bsp_setup() -> setup_IO_APIC() and at this point we reach
check_timer(), which attempts to verify/fixup IRQ0 delivery via the
IO-APIC. At this point we check that jiffies increments, and if not,
panic.

4. Some time later, naive_smp_prepare_cpus() calls
setup_boot_APIC_clock() -> setup_APIC_timer() which registers the
local APIC clocksource, replacing the previous PIT/HPET clocksource.
There's no check to make sure that the new clocksource is ticking, as
far as I can see.

5. Some time later, start_secondary() calls
start_secondary_APIC_clock() -> setup_APIC_timer() registering the
APIC clocksource (again? or just for another CPU core?).


Hopefully that analysis helps refine/elaborate the plan a bit more...

> That means we need the following decision logic:
>
>   1) If HPET is available in ACPI, boot normal.
>
>   2) If HPET is not available, verify that the PIT actually counts. If it
>      does, boot normal.
>
>      If it does not either:
>
>      2A) Verify that this is a PCH 300/C240 and fiddle with that ISST bit.
>
>          But that means that we need to chase PCH ids forever...

(I found the ISST bit in the coreboot source code, which shows that
the register is shared over multiple Intel SoC generations. I then
searched for the register name online and found it documented in the
320/C240 public documentation, which I linked to. However that's not
actually the platform in question. In this case we are working with
Intel Apollo Lake N3350.)

Anyway, I agree that doing it with PCI IDs would be painful.

>      2B) Shrug and just avoid the whole PIT/HPET magic all over the place:
>
>          - Avoid the interrupt delivery check in the IOAPIC code as it's
>            uninteresting in that case. Trivial to do.

What do you mean by "in that case"? In the case of having an IOAPIC?

From my analysis above, this interrupt delivery check feels misplaced.
Other parts of the clock setup code (e.g. where PIC, HPET and APIC
timer are enabled) do not seem to check that the timers being set up
actually work. If I were to try a kernel with no APIC/LAPIC support
then Linux would boot with a broken PIT as the clock source without
checking it. So why do we check it here specifically in the IOAPIC
code? I see it does some tricks which are presumably needed on
historical platforms, but maybe it could let boot continue even if it
can't find a working IRQ0 setup? Or it could at least skip the check
if IRQ0 was not working before the IOAPIC gets set up?

If there is desire for some "check that the clocksource is actually
ticking" panic logic, maybe this could be done after the local APIC
timer is setup (which is ultimately the clock source selected and
used), maybe it should even be done in arch-independent code?

>          - Prevent the TSC calibration code from touching PIT/HPET. It
>            should do that already when the TSC frequency can be retrieved
>            via CPUID or MSR. Should work, emphasis on should ...

From above, this seems to be working acceptably already. It does touch
the PIT, but ultimately ignores the information that it provided.

>          - Prevent the APIC calibration code from touching PIT/HPET. That's
>            only happening right now when the TSC frequency comes from
>            the MSRs. No idea why the CPUID method does not provide that.

Where's the APIC calibration code?

>            CPUID leaf 0x16 provides the bus frequency, so we can deduce the
>            APIC timer frequency from there and spare the whole APIC timer
>            calibration mess:
>
>                ECX Bits 15 - 00: Bus (Reference) Frequency (in MHz).

That's not available on this platform, plus
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
page 1-21 says that the data returned is actually marketing stuff, and
shouldn't be treated as real. I think you mean CPUID leaf 0x15
instead.

Thanks for your input!

Daniel
