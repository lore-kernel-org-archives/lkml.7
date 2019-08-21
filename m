Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07892C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49632341D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfHUMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:34:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:58201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHUMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:34:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="330008751"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2019 05:34:54 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i0PpD-0007gv-J2; Wed, 21 Aug 2019 15:34:51 +0300
Date:   Wed, 21 Aug 2019 15:34:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        alan@linux.intel.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
Message-ID: <20190821123451.GY30120@smile.fi.intel.com>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
 <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
 <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
 <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:20:53PM +0200, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Tanwar, Rahul wrote:
> > On 21/8/2019 4:34 PM, Thomas Gleixner wrote:
> > 
> > > Secondly, this link is irrelevant. ioapic_dynirq_base has nothing to do
> > > with virtual IRQ number 0. It's a boundary for the dynamic allocation of
> > > virtual interrupt numbers so that the core allocator does not pick
> > > interrupts out of the IOAPIC's fixed interrupt number space.
> > > 
> > > This can be legitimately 0 when IOAPIC is not enabled at all.
> > > 
> > > Can you please explain what kind of problem you were seing and what this
> > > really fixes?
> >
> > The problem is that device tree infrastructure considers 0 IRQ value as
> > invalid/error value whereas for ACPI, 0 is a valid value.
> 
> Sure.
> 
> > Without this change, the problem that we see is that the first driver
> > using of_irq_get_xx() or its variants fails because of 0 IRQ number. With
> > this change, allocated IRQ number is never 0 so it works ok.
> 
> Well, this still is not a proper explanation. Just because it works does
> not make it correct in the first place.
> 
> ioapic_dynirq_base is pretty much irrelevant for a DT machine. The reason
> why it exists is that for regular BIOS the interrupt numbers are hard
> mapped to the IOAPIC pins. ioapic_dynirq_base is used to protect this hard
> mapped interrupt number space. The core allocator does not allocate from
> that space unless it is explicitely told to do so, which is the case for
> IOAPIC_DOMAIN_STRICT where the allocation tells the core to allocate the
> associated GSI number.
> 
> On DT the interrupt number is irrelevant as DT describes the irq controller
> and the pin to which a device is connected and does not make assumptions
> about the interrupt number. So the core can freely allocate any available
> interrupt number except 0. That's already prevented in the core code.
> 
> But x86 implements arch_dynirq_lower_bound() which overrides the core limit
> and because ioapic_dynirq_base is zero in the DT case it allows VIRQ 0 to
> be allocated which then causes of_irq*() to fail.
> 
> So your change prevents that by excluding the 'GSI' range from allocation,
> which means that the first irq number which is handed out is 24, assumed
> you have one IOAPIC with 24 pins.

I have tested this on the ACPI-based system where we have 55 lines of IOAPIC,
no PIC, and some GPIO lines. Overall I see that nr_irqs is 512 and shifting
by 55 freezes 10% of the space for nothing. Luckily we have SPARSE_IRQS
selected for any X86, so, it wouldn't waste memory.

I think we may do slightly better if we just limit the change to the certain
cases.

-- 
With Best Regards,
Andy Shevchenko


