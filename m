Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7041A22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHULVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:21:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfHULVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:21:12 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Off-0002N8-Dv; Wed, 21 Aug 2019 13:20:55 +0200
Date:   Wed, 21 Aug 2019 13:20:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        x86@kernel.org, andriy.shevchenko@intel.com, alan@linux.intel.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
In-Reply-To: <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com> <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de> <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
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

On Wed, 21 Aug 2019, Tanwar, Rahul wrote:
> On 21/8/2019 4:34 PM, Thomas Gleixner wrote:
> 
> > Secondly, this link is irrelevant. ioapic_dynirq_base has nothing to do
> > with virtual IRQ number 0. It's a boundary for the dynamic allocation of
> > virtual interrupt numbers so that the core allocator does not pick
> > interrupts out of the IOAPIC's fixed interrupt number space.
> > 
> > This can be legitimately 0 when IOAPIC is not enabled at all.
> > 
> > Can you please explain what kind of problem you were seing and what this
> > really fixes?
>
> The problem is that device tree infrastructure considers 0 IRQ value as
> invalid/error value whereas for ACPI, 0 is a valid value.

Sure.

> Without this change, the problem that we see is that the first driver
> using of_irq_get_xx() or its variants fails because of 0 IRQ number. With
> this change, allocated IRQ number is never 0 so it works ok.

Well, this still is not a proper explanation. Just because it works does
not make it correct in the first place.

ioapic_dynirq_base is pretty much irrelevant for a DT machine. The reason
why it exists is that for regular BIOS the interrupt numbers are hard
mapped to the IOAPIC pins. ioapic_dynirq_base is used to protect this hard
mapped interrupt number space. The core allocator does not allocate from
that space unless it is explicitely told to do so, which is the case for
IOAPIC_DOMAIN_STRICT where the allocation tells the core to allocate the
associated GSI number.

On DT the interrupt number is irrelevant as DT describes the irq controller
and the pin to which a device is connected and does not make assumptions
about the interrupt number. So the core can freely allocate any available
interrupt number except 0. That's already prevented in the core code.

But x86 implements arch_dynirq_lower_bound() which overrides the core limit
and because ioapic_dynirq_base is zero in the DT case it allows VIRQ 0 to
be allocated which then causes of_irq*() to fail.

So your change prevents that by excluding the 'GSI' range from allocation,
which means that the first irq number which is handed out is 24, assumed
you have one IOAPIC with 24 pins.

That's fine as the interrupt number space is big enough, but it needs

    - a coherent explanation in the changelog

    - proper comments to that effect in the code

Also this is presumably a stable candidate and needs a Fixes: ... tag.

Thanks,

	tglx










