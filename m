Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88372C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B11208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfFXKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:39:08 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:58913 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfFXKjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:39:07 -0400
X-Greylist: delayed 1024 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 06:39:06 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x5OALUnS029575
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:21:30 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x5OALSmM010254;
        Mon, 24 Jun 2019 12:21:28 +0200
Subject: Re: x86: Spurious vectors not handled robustly
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com>
 <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1565f016-4e3b-fa89-62e5-fc77594ee5aa@siemens.com>
Date:   Mon, 24 Jun 2019 12:21:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.19 12:09, Thomas Gleixner wrote:
> Jan,
> 
> On Mon, 24 Jun 2019, Jan Kiszka wrote:
>> probably since "x86: Avoid building unused IRQ entry stubs" (2414e021ac8d),
>> the kernel can no longer tell spurious IRQs by the APIC apart from spuriously
>> triggered unused vectors.
> 
> Err. It does.
> 
>> We've managed to trigger such a cause with the Jailhouse hypervisor
>> (incorrectly injected MANAGED_IRQ_SHUTDOWN_VECTOR), and the result was
>> not only a misreport of the vector number (0xff instead of 0xef - took me
>> a while...), but also stalled interrupts of equal and lower priority
>> because a spurious interrupt is not (and must not be) acknowledged.
> 
> That does not make sense.
> 
> __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
> {
>          u8 vector = ~regs->orig_ax;
>          u32 v;
> 
>          entering_irq();
>          trace_spurious_apic_entry(vector);
>          /*
>           * Check if this really is a spurious interrupt and ACK it
>           * if it is a vectored one.  Just in case...
>           */
>          v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
>          if (v & (1 << (vector & 0x1f)))
>                  ack_APIC_irq();
> 
> If it is a vectored one it _IS_ acked.
> 
>          inc_irq_stat(irq_spurious_count);
> 
>   	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
>          pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
>                  "should never happen.\n", vector, smp_processor_id());
> 
> and the vector through which that comes is printed correctly, unless
> regs->orig_ax is hosed.

...which is exactly the case: Since that commit, all unused vectors share the 
same entry point, spurious_interrupt, see idt_setup_apic_and_irq_gates(). And 
that entry point sets orig_ax to ~0xff.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
