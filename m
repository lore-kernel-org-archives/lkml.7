Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6647620693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="LhrPUX7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfDCHte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:49:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37811 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:49:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so18447151qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CyTp0jH5R8iYViYfK5C0rYf93g5xOkYSFCJjpX/hgJk=;
        b=LhrPUX7cE6EaipEqxdbS997sS5ZjwT1LnKDsY0lAEQdkS4JeXyWx2KcC+tmcYEjx9L
         jncWdjsCOn2vQTRbHHrOLm8FGrc1I3GjRRrbml7NyWKG0RjktbpoWPNKLmafLTV0CvYb
         C6AuOGsjWc+758qbPdNaJzjWGodFKBU/X7xHfej9mDbzUGHVnOsYhbb5XD0Upcprbvy+
         BtpZNA9LyFav8Rb8RDhhTguVd9vHy86wZw0PHn/bLtjuYcSfOnV+xUrfZKHAaT/Ts3kz
         1k2x1Klj1Kc/rF57SLMYqXyrMQAFn4PinYArL0XxkTTzU1nAnyKWSAlq8KDb52D1BvGf
         fPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CyTp0jH5R8iYViYfK5C0rYf93g5xOkYSFCJjpX/hgJk=;
        b=aZPMJ6/FH7yk2E45kvcqI5Ta/yEEdmDdTRQnkzKvr5VI+blrx2+rQVoXYVe0nhJOoO
         X2DQX+JIU/CuSRD5FR8W1168MnoA9RXPmyY75E7vpvK7PzkOPKg+pwmIWtJ/Zw7g57jW
         3lS5AmLXyP+1QulwbXzwl5/xH6UBbJr3mVrmQa/OvkuCPHkEby9S2JRA4PLIx9RuAIpI
         nRxw7qz6YyedMqgLLvH3oBi3OL/Z3JPEgbsa0HwGCtPnKmLdfPz61GD+EuSjiysPYQDn
         2LfguzvWleWjunxUsSJS7PYRLaDJGkffvb8JrSgjFBRu+0+r6pIApsrroiz27WyW1TeV
         jHGQ==
X-Gm-Message-State: APjAAAUUmeeaF8c3A8mAVTeFgEp7JYWDYJifj6nWDjTWSAsNCloore7N
        q84+5S1g65Ig7hrMnI3Qu/zyON9MGUXDVhfKl3d0987AJQw=
X-Google-Smtp-Source: APXvYqyiFQb6Rxb7EW+eCn7AAsPkGTpXvlOttnwgzAJMG39vCk+K6AwcswvRdvoSiCXqSo+26BRVfhBWacObKolaw74=
X-Received: by 2002:aed:3ffa:: with SMTP id w55mr60574140qth.142.1554277772763;
 Wed, 03 Apr 2019 00:49:32 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 3 Apr 2019 15:49:21 +0800
Message-ID: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com>
Subject: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de
Cc:     Hans de Goede <hdegoede@redhat.com>, david.e.box@linux.intel.com,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I already wrote about this problem in the thread "APIC timer checked
before it is set up, boot fails on Connex L1430"
https://lkml.org/lkml/2018/12/28/10
However my initial diagnosis was misguided, and I have some new
findings to share now, so I'm starting over in this new thread.

Also CCing Hans, who also often attracts this class of problem on low
cost hardware!

The problem is that on affected platforms, all Linux distros (and all
known kernel versions) fail to boot, hanging on a black screen. EFI
earlyprintk can be used to see the panic:

APIC: switch to symmetric I/O mode setup
x2apic: IRQ remapping doesn't support X2APIC mode
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...tryign to set up timer (IRQ0) through the 8259A ...
..... (found apic 0 pin 2) ...
....... failed.
...trying to set up timer as Virtual Wire IRQ...
..... failed.
...trying to set up timer as ExtINT IRQ...
do_IRQ: 0.55 No irq handler for vector
..... failed :(.
Kernel panic - not syncing: IO-APIC + timer doesn't work! Boot with
apic=debug and send a report.

After encountering this on Connex L1430 last time, we have now
encountered another affected product, from a different vendor (SCOPE
SN116PYA). They both have Intel Apollo Lake N3350 and AMI BIOS.

The code in question is making sure that the IRQ0 timer works, by
waiting for an interrupt. In this case there is no interrupt.

The x86 platform code in hpet_time_init() tries to enable the HPET
timer for this, however that is not available on these affected
platforms (no HPET ACPI table). So it then falls back on the 8253/8254
legacy PIT. The i8253.c driver is invoked to program the PIT
accordingly, however in this case it does not result in any IRQ0
interrupts being generated --> panic.

I found a relevant setting in the BIOS: Chipset -> South Cluster
Configuration -> Miscellaneous Configuration -> 8254 Clock Gating
This option is set to Enabled by default. Setting it to Disabled makes
the PIT tick and Linux boot finally works.

It's nice to have a workaround but I would hope we could do better -
especially because it seems like this problem is spreading. In
addition to the two products we found here, searching around finds
several other product manuals and discussions that tell you to go into
the BIOS and change this option if you want Linux to boot, some
examples:
https://blog.csdn.net/qhtsm/article/details/88600316
https://www.manualslib.com/manual/1316475/Ecs-Ed20pa2.html?page=23
https://tools.exone.de/live/shop/img/produkte/fs_112124_2.pdf page 11

As another data point, Windows 10 boots fine in this no-PIT no-HPET
configuation.

Going deeper, I found the clock_gate_8254 option in the coreboot
source code. This pointed me to the ITSSPRC register, which is
documented on page 1694 of
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf

"8254 Static Clock Gating Enable (CGE8254): When set, the 8254 timer
is disabled statically. This bit shall be set by BIOS if the 8254
feature is not needed in the system or before BIOS hands off the
system that supports C11. Normal operation of 8254 requires this bit
to 0."

(what's C11?)

I verified that the BIOS setting controls this specific bit value, and
I also created and verified a workaround that unsets this bit - now
Linux boots fine regardless of the BIOS setting:

#define INTEL_APL_PSR_BASE        0xd0000000
#define INTEL_APL_PID_ITSS        0xd0
#define INTEL_PCR_PORTID_SHIFT    16
#define INTEL_APL_PCR_ITSSPRC    0x3300
static void quirk_intel_apl_8254(void)
{
    u32 addr = INTEL_APL_PSR_BASE | \
        (INTEL_APL_PID_ITSS << INTEL_PCR_PORTID_SHIFT) | \
        INTEL_APL_PCR_ITSSPRC;
    u32 value;
    void __iomem *itssprc = ioremap_nocache(addr, 4);

    if (!itssprc)
        return;

    value = readl(itssprc);
    if (value & 4) {
        value &= ~4;
        writel(value, itssprc);
    }
    iounmap(itssprc);
}

I was hoping I could send a workaround patch here, but I'm not sure of
an appropriate way to detect that we are on an Intel Apollo Lake
platform. This timer stuff happens during early boot, the early quirks
in pci/quirks.c run too late for this. Suggestions appreciated.

Poking at other angles, I tried taking the HPET ACPI table from
another (working) Intel N3350 system and putting it in the initrd as
an override. This makes the HPET work fine, at which point Linux boots
OK without having to touch the (BIOS-crippled) PIT.

I also spotted that GRUB was previously affected by this BIOS-level
behaviour change.
http://git.savannah.gnu.org/cgit/grub.git/commit/?id=446794de8da4329ea532cbee4ca877bcafd0e534
Apparently GRUB used to rely on the 8254 PIT too, but it now uses the
pmtimer for TSC calibration instead. I guess the originally-affected
platforms only ran into GRUB freezing here (as opposed to both GRUB
and Linux freezing) because those platforms had a working HPET,
meaning that Linux was unaware/unaffected by the newly-gated PIT.

I'm at the limit of my current knowledge here, but there's an open
question of whether Linux could be made to work without a working PIT
and no HPET, in the same way that grub and Windows seem to manage.
Even though it is currently essential for boot, the PIT (or HPET) is
usually only needed to tick a few times before being replaced with the
APIC timer as a clocksource (when setup_APIC_timer() happens, the
clocksource layer disables the previous timer source). However, Thomas
Gleixner gave some hints at the importance of the PIT/HPET here:

> Well, [avoiding the PIT/HPET ticking requirement] would be trivial if we
> could rely on the APIC timer being functional on all CPUs and if we could
> figure out the APIC timer frequency without calibrating it against the
> PIT/HPET on older CPUs. Plus a gazillion of other issues (e.g. APIC stops
> in C states ....)
> [...]
> Under certain conditions we actually might avoid touching PIT/HPET and
> solely rely on the CPUID/MSR calibration values. Needs quite some thought
> though.

I'm not sure what is the best way forward on this issue, but hopefully
this investigation is useful somehow, and I'd be happy to act on any
suggestions.

Thanks
Daniel
