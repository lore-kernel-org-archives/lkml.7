Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89301C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94120830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCMB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:01:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:01:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBea6-00051A-Qi; Wed, 03 Apr 2019 14:01:26 +0200
Date:   Wed, 3 Apr 2019 14:01:26 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904031359530.1967@nanos.tec.linutronix.de>
References: <CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com> <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Thomas Gleixner wrote:
> For newer CPUs we might assume that:
> 
>  1) The TSC and APIC timer are actually usable
> 
>  2) The frequencies can be retrieved from CPUID or MSRs
> 
> If #1 and #2 are reliable we can avoid the whole calibration and interrupt
> delivery mess.
> 
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
>      	 But that means that we need to chase PCH ids forever...
> 
>      2B) Shrug and just avoid the whole PIT/HPET magic all over the place:
> 
>      	 - Avoid the interrupt delivery check in the IOAPIC code as it's
>            uninteresting in that case. Trivial to do.
> 	 
> 	 - Prevent the TSC calibration code from touching PIT/HPET. It
>            should do that already when the TSC frequency can be retrieved
>            via CPUID or MSR. Should work, emphasis on should ...
> 
>     	   See the mess in: native_calibrate_tsc() and the magic tables in
> 	   tsc_msr.c how well that stuff works.
> 
> 	   The cpu_khz_from_cpuid() case at seems to not have these
> 	   issues. Knock on wood!
> 
>          - Prevent the APIC calibration code from touching PIT/HPET. That's
>            only happening right now when the TSC frequency comes from
> 	   the MSRs. No idea why the CPUID method does not provide that.
> 
> 	   CPUID leaf 0x16 provides the bus frequency, so we can deduce the
> 	   APIC timer frequency from there and spare the whole APIC timer
> 	   calibration mess:
> 
>   	       ECX Bits 15 - 00: Bus (Reference) Frequency (in MHz).
> 
> 	   It's usually not required on these newer CPUs because they
> 	   support TSC deadline timer, but you can disable that on the
> 	   kernel command line and some implementations of that were
> 	   broken. With that we are back to square one.
> 
> 	   So we need to make sure that these things work under all
> 	   circumstances.
> 
>    Rafael?

And we have to think hard about how we are going to provide that for
backporting in a digestable form. People are supposed to run recent stable
kernels (I'm not talking about dead kernels ...).

Thanks,

	tglx
