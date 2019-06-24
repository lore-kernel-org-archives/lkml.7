Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBF12063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfFXKJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:09:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfFXKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:09:36 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfLuj-0005CU-L6; Mon, 24 Jun 2019 12:09:29 +0200
Date:   Mon, 24 Jun 2019 12:09:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86: Spurious vectors not handled robustly
In-Reply-To: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com>
Message-ID: <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de>
References: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com>
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

Jan,

On Mon, 24 Jun 2019, Jan Kiszka wrote:
> probably since "x86: Avoid building unused IRQ entry stubs" (2414e021ac8d),
> the kernel can no longer tell spurious IRQs by the APIC apart from spuriously
> triggered unused vectors.

Err. It does.

> We've managed to trigger such a cause with the Jailhouse hypervisor
> (incorrectly injected MANAGED_IRQ_SHUTDOWN_VECTOR), and the result was
> not only a misreport of the vector number (0xff instead of 0xef - took me
> a while...), but also stalled interrupts of equal and lower priority
> because a spurious interrupt is not (and must not be) acknowledged.

That does not make sense.

__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
{
        u8 vector = ~regs->orig_ax;
        u32 v;

        entering_irq();
        trace_spurious_apic_entry(vector);
        /*
         * Check if this really is a spurious interrupt and ACK it
         * if it is a vectored one.  Just in case...
         */
        v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
        if (v & (1 << (vector & 0x1f)))
                ack_APIC_irq();

If it is a vectored one it _IS_ acked.

        inc_irq_stat(irq_spurious_count);

 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
        pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
                "should never happen.\n", vector, smp_processor_id());

and the vector through which that comes is printed correctly, unless
regs->orig_ax is hosed.

Thanks,

	tglx
