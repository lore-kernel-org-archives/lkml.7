Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C94C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044EA2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfFXKhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:37:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfFXKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:37:33 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfMLm-0006Yf-SY; Mon, 24 Jun 2019 12:37:27 +0200
Date:   Mon, 24 Jun 2019 12:37:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86: Spurious vectors not handled robustly
In-Reply-To: <1565f016-4e3b-fa89-62e5-fc77594ee5aa@siemens.com>
Message-ID: <alpine.DEB.2.21.1906241236390.32342@nanos.tec.linutronix.de>
References: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com> <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de> <1565f016-4e3b-fa89-62e5-fc77594ee5aa@siemens.com>
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

On Mon, 24 Jun 2019, Jan Kiszka wrote:
> On 24.06.19 12:09, Thomas Gleixner wrote:
> > If it is a vectored one it _IS_ acked.
> > 
> >          inc_irq_stat(irq_spurious_count);
> > 
> >   	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
> >          pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
> >                  "should never happen.\n", vector, smp_processor_id());
> > 
> > and the vector through which that comes is printed correctly, unless
> > regs->orig_ax is hosed.
> 
> ...which is exactly the case: Since that commit, all unused vectors share the
> same entry point, spurious_interrupt, see idt_setup_apic_and_irq_gates(). And
> that entry point sets orig_ax to ~0xff.

Bah. Of course I did not look at that ...

/me goes back to stare at the code.

Thanks,

	tglx
