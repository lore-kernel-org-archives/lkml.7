Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7187AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C0206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfJIRpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:45:05 -0400
Received: from muru.com ([72.249.23.125]:36278 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbfJIRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:45:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CCC468140;
        Wed,  9 Oct 2019 17:45:36 +0000 (UTC)
Date:   Wed, 9 Oct 2019 10:45:00 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Yi Zheng <goodmenzy@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Sekhar Nori <nsekhar@ti.com>, Zheng Yi <yzheng@techyauld.com>
Subject: Re: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
Message-ID: <20191009174500.GM5610@atomide.com>
References: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Yi Zheng <goodmenzy@gmail.com> [191008 13:06]:
>       NOTE: (1) My SoC is a single core ARM chip: TI-AM3352, so the raw
>          spin-lock irq_desc->lock will be optimized to
>          nothing. handle_level_irq() has no spin-lock protection, right?

Well not always, With CONFIG_SMP we modify only some of the SMP code on boot,
see arch/arm/kernel/head.S for smp_on_up and then the related macro usage.

>          (2) In AM3352, INTC driver ACK the IRQ by write 0x01 into INTC Control
>              Register(offset 0x48).  The chip doc seems that bit[0] of
>              INTC-Control Reg is only an enable/disable flag.  The IRQ may
>              generated even if no ACK action done. Any one can give me an
>              clarification?

The TI INTC is probably better documented in dm3630 trm, it's the same
controller but with a different revision.

>          (3) My analysis is not verified on the real machine. After some code
>              change for debug(add counter to indicates the iteration level, save
>              the IRQ mask status etc.), the device IRQ wrongly masked problem
>              vanished. In fact, the original code can not re-produce the
>              phenomena easily. In tens of machine, only one can get the bug. I
>              have try my best to hacking the code, but the only verified result
>              is here: when bug occur, the HW IRQ is masked, but the
>              IRQD_IRQ_MASKED flag is cleared.
> 
>       My fixup is in the attachment, which remove the unexpected time window of
>       IRQ iteration.

Let's see what Thomas has to say for that. Meanwhile, please take a
look at Documentation/process/submitting-patches.rst for getting things
right for sending out patches that can be applied without manual
editing :)

Cheers,

Tony

> --- kernel/irq/chip.c	2019-07-13 09:28:23.683787367 +0800
> +++ /tmp/chip.c	2019-10-08 11:32:35.082258572 +0800
> @@ -432,8 +432,8 @@ void unmask_irq(struct irq_desc *desc)
>  		return;
>  
>  	if (desc->irq_data.chip->irq_unmask) {
> -		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  		irq_state_clr_masked(desc);
> +		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  	}
>  }
>  

