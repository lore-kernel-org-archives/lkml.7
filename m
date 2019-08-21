Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7433122CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfHUNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:16:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:16:56 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0QTZ-0004mO-DE; Wed, 21 Aug 2019 15:16:33 +0200
Date:   Wed, 21 Aug 2019 15:16:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        alan@linux.intel.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
In-Reply-To: <20190821123451.GY30120@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1908211510390.2223@nanos.tec.linutronix.de>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com> <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de> <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com> <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
 <20190821123451.GY30120@smile.fi.intel.com>
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

On Wed, 21 Aug 2019, Andy Shevchenko wrote:
> On Wed, Aug 21, 2019 at 01:20:53PM +0200, Thomas Gleixner wrote:
> > But x86 implements arch_dynirq_lower_bound() which overrides the core limit
> > and because ioapic_dynirq_base is zero in the DT case it allows VIRQ 0 to
> > be allocated which then causes of_irq*() to fail.
> > 
> > So your change prevents that by excluding the 'GSI' range from allocation,
> > which means that the first irq number which is handed out is 24, assumed
> > you have one IOAPIC with 24 pins.
> 
> I have tested this on the ACPI-based system where we have 55 lines of IOAPIC,
> no PIC, and some GPIO lines. Overall I see that nr_irqs is 512 and shifting
> by 55 freezes 10% of the space for nothing. Luckily we have SPARSE_IRQS
> selected for any X86, so, it wouldn't waste memory.
>
> I think we may do slightly better if we just limit the change to the certain
> cases.

For DT we can actually avoid that completely. See below.

For ACPI not unfortunately as the stupid GSI mapping is hard coded.

Thanks,

	tglx

8<-------------
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2438,7 +2438,13 @@ unsigned int arch_dynirq_lower_bound(uns
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	return ioapic_initialized ? ioapic_dynirq_base : gsi_top;
+	if (!ioapic_initialized)
+		return gsi_top;
+	/*
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
+	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 */
+	return ioapic_dynirq_base ? : from;
 }
 
 #ifdef CONFIG_X86_32
