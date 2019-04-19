Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88303C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C53F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfDSTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDSTDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:23 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHPKZ-0001fl-0i; Fri, 19 Apr 2019 10:57:11 +0200
Date:   Fri, 19 Apr 2019 10:57:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        rjw@rjwysocki.net, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
In-Reply-To: <20190419083533.32388-1-drake@endlessm.com>
Message-ID: <alpine.DEB.2.21.1904191042180.3174@nanos.tec.linutronix.de>
References:  <20190419083533.32388-1-drake@endlessm.com>
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

On Fri, 19 Apr 2019, Daniel Drake wrote:
> On Fri, Apr 19, 2019 at 6:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >    Time Stamp Counter/Core Crystal Clock Information (0x15):
> >       TSC/clock ratio = 168/2
> >       nominal core crystal clock = 0 Hz
> >
> >    Processor Frequency Information (0x16):
> >       Core Base Frequency (MHz) = 0x834 (2100)
> >       Core Maximum Frequency (MHz) = 0xed8 (3800)
> >       Bus (Reference) Frequency (MHz) = 0x64 (100)
> >
> > Assuming that TSC and local APIC timer run from the same frequency on these
> > modern machines.
> >
> >        2100MHz * 2 / 168 = 25MHz
> >
> > and disabling the tsc deadline timer tells me:
> >
> >   ..... calibration result: 24999
> >
> > Close enough.
> 
> I tested all the Intel SoC generations we have on hand. The assumption that
> the core crystal clock feeds the APIC seems to be consistently true.
> 
> (Please note that all the following results are done with CONFIG_HZ=250,
>  which is why the "calibration result" is 4x higher than HZ=1000 as used
>  in previous mails)
> 
> In the easy case, the low cost platforms do not support CPUID.0x16 (so no
> CPU frequency reporting), but they do tell us the core crystal clock, which
> is consistent with the APIC calibration result:

...

> And the 4 higher-end SoCs that we have available for testing all report
> crystal clock 0Hz from CPUID 0x15, but by combining the CPUID.0x16 base
> frequency with the CPUID.0x15 TSC/clock ratio, the crystal frequency can
> be calculated as you describe, and it consistently matches the APIC timer
> calibration result.

...

> Is this data convincing enough or should we additionally wait for some
> comments from Intel?

For me it's pretty convincing, but having some confirmation from Intel
wouldn't be a bad thing.
 
> I came up with the patch below. However, upon testing, I realised that, at
> least for the platforms I have in hand, only the first hunk is really needed.
> We don't need to use your magic calculation to find the crystal frequency
> because Intel already told us! native_calibrate_tsc() already hardcodes the
> crystal frequency for Kabylake, and Amber/Whiskey/Coffee also report the
> 0x8e/0x9e Kabylake model codes.

I'd rather replace these model checks with math. These tables are horrible
to maintain.

> Plus ApolloLake/GeminiLake do report the crystal frequency in CPUID.0x15
> so that is covered too.

> While looking around this code I also spotted something curious.
> In calibrate_APIC_clock() for the case where lapic_timer_frequency has been
> externally provided, we have:
> 		lapic_clockevent.max_delta_ns =
> 			clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
> 		lapic_clockevent.max_delta_ticks = 0x7FFFFF;
> 
> But in the case where we calibrate, we have:
> 	lapic_clockevent.max_delta_ns =
> 		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
> 	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
> 
> 0x7FFFFF vs 0x7FFFFFFF, is that intentional?

I don't think so. Looks like a failed copy and paste. Cc'ed Jacob, he might
know.

Thanks,

	tglx
