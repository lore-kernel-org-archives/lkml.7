Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160FCC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC15F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfDSUr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:47:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:2065 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfDSUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:47:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 13:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="225035585"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2019 13:47:57 -0700
Date:   Fri, 19 Apr 2019 13:50:37 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Drake <drake@endlessm.com>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, rjw@rjwysocki.net,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
Message-ID: <20190419135037.5bf5750e@jacob-builder>
In-Reply-To: <alpine.DEB.2.21.1904191042180.3174@nanos.tec.linutronix.de>
References: <20190419083533.32388-1-drake@endlessm.com>
        <alpine.DEB.2.21.1904191042180.3174@nanos.tec.linutronix.de>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 10:57:10 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 19 Apr 2019, Daniel Drake wrote:
> > On Fri, Apr 19, 2019 at 6:30 AM Thomas Gleixner
> > <tglx@linutronix.de> wrote:  
> > >    Time Stamp Counter/Core Crystal Clock Information (0x15):
> > >       TSC/clock ratio = 168/2
> > >       nominal core crystal clock = 0 Hz
> > >
> > >    Processor Frequency Information (0x16):
> > >       Core Base Frequency (MHz) = 0x834 (2100)
> > >       Core Maximum Frequency (MHz) = 0xed8 (3800)
> > >       Bus (Reference) Frequency (MHz) = 0x64 (100)
> > >
> > > Assuming that TSC and local APIC timer run from the same
> > > frequency on these modern machines.
> > >
> > >        2100MHz * 2 / 168 = 25MHz
> > >
> > > and disabling the tsc deadline timer tells me:
> > >
> > >   ..... calibration result: 24999
> > >
> > > Close enough.  
> > 
> > I tested all the Intel SoC generations we have on hand. The
> > assumption that the core crystal clock feeds the APIC seems to be
> > consistently true.
> > 
> > (Please note that all the following results are done with
> > CONFIG_HZ=250, which is why the "calibration result" is 4x higher
> > than HZ=1000 as used in previous mails)
> > 
> > In the easy case, the low cost platforms do not support CPUID.0x16
> > (so no CPU frequency reporting), but they do tell us the core
> > crystal clock, which is consistent with the APIC calibration
> > result:  
> 
> ...
> 
> > And the 4 higher-end SoCs that we have available for testing all
> > report crystal clock 0Hz from CPUID 0x15, but by combining the
> > CPUID.0x16 base frequency with the CPUID.0x15 TSC/clock ratio, the
> > crystal frequency can be calculated as you describe, and it
> > consistently matches the APIC timer calibration result.  
> 
> ...
> 
> > Is this data convincing enough or should we additionally wait for
> > some comments from Intel?  
> 
> For me it's pretty convincing, but having some confirmation from Intel
> wouldn't be a bad thing.
>  
> > I came up with the patch below. However, upon testing, I realised
> > that, at least for the platforms I have in hand, only the first
> > hunk is really needed. We don't need to use your magic calculation
> > to find the crystal frequency because Intel already told us!
> > native_calibrate_tsc() already hardcodes the crystal frequency for
> > Kabylake, and Amber/Whiskey/Coffee also report the 0x8e/0x9e
> > Kabylake model codes.  
> 
> I'd rather replace these model checks with math. These tables are
> horrible to maintain.
> 
> > Plus ApolloLake/GeminiLake do report the crystal frequency in
> > CPUID.0x15 so that is covered too.  
> 
> > While looking around this code I also spotted something curious.
> > In calibrate_APIC_clock() for the case where lapic_timer_frequency
> > has been externally provided, we have:
> > 		lapic_clockevent.max_delta_ns =
> > 			clockevent_delta2ns(0x7FFFFF,
> > &lapic_clockevent); lapic_clockevent.max_delta_ticks = 0x7FFFFF;
> > 
> > But in the case where we calibrate, we have:
> > 	lapic_clockevent.max_delta_ns =
> > 		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
> > 	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
> > 
> > 0x7FFFFF vs 0x7FFFFFFF, is that intentional?  
> 
> I don't think so. Looks like a failed copy and paste. Cc'ed Jacob, he
> might know.
> 
At the time of v2.6.35 both places use 0x7FFFFF. But later this patch
increased the latter to 0x7FFFFFFF but forgot the first part. So I
guess it is not exactly a failed copy and paste.

commit 4aed89d6b515b9185351706ca95cd712c9d8d6a3
Author: Pierre Tardy <pierre.tardy@intel.com>
Date:   Thu Jan 6 16:23:29 2011 +0100

    x86, lapic-timer: Increase the max_delta to 31 bits
    

> Thanks,
> 
> 	tglx

[Jacob Pan]
