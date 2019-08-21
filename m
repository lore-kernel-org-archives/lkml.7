Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F059C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA732332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfHUQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:47:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:56846 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbfHUQro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 09:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196031589"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 09:47:41 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i0Tlq-0002mP-Dl; Wed, 21 Aug 2019 19:47:38 +0300
Date:   Wed, 21 Aug 2019 19:47:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        alan@linux.intel.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
Message-ID: <20190821164738.GA30120@smile.fi.intel.com>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
 <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
 <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
 <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
 <20190821123451.GY30120@smile.fi.intel.com>
 <alpine.DEB.2.21.1908211510390.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908211510390.2223@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 03:16:31PM +0200, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2019 at 01:20:53PM +0200, Thomas Gleixner wrote:
> > > But x86 implements arch_dynirq_lower_bound() which overrides the core limit
> > > and because ioapic_dynirq_base is zero in the DT case it allows VIRQ 0 to
> > > be allocated which then causes of_irq*() to fail.
> > > 
> > > So your change prevents that by excluding the 'GSI' range from allocation,
> > > which means that the first irq number which is handed out is 24, assumed
> > > you have one IOAPIC with 24 pins.
> > 
> > I have tested this on the ACPI-based system where we have 55 lines of IOAPIC,
> > no PIC, and some GPIO lines. Overall I see that nr_irqs is 512 and shifting
> > by 55 freezes 10% of the space for nothing. Luckily we have SPARSE_IRQS
> > selected for any X86, so, it wouldn't waste memory.
> >
> > I think we may do slightly better if we just limit the change to the certain
> > cases.
> 
> For DT we can actually avoid that completely. See below.
> 
> For ACPI not unfortunately as the stupid GSI mapping is hard coded.

The below works better for my case, so, if you are going with that
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2438,7 +2438,13 @@ unsigned int arch_dynirq_lower_bound(uns
>  	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
>  	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
>  	 */
> -	return ioapic_initialized ? ioapic_dynirq_base : gsi_top;
> +	if (!ioapic_initialized)
> +		return gsi_top;
> +	/*
> +	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
> +	 * updated. So simply return @from if ioapic_dynirq_base == 0.
> +	 */
> +	return ioapic_dynirq_base ? : from;
>  }
>  
>  #ifdef CONFIG_X86_32

-- 
With Best Regards,
Andy Shevchenko


