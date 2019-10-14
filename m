Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA03ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A6B2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfJNMeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:34:49 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iJzYj-00080h-Eg; Mon, 14 Oct 2019 14:34:45 +0200
Date:   Mon, 14 Oct 2019 14:34:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Zheng <goodmenzy@gmail.com>
cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Zheng Yi <yzheng@techyauld.com>
Subject: Re: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
In-Reply-To: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910141430310.2531@nanos.tec.linutronix.de>
References: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019, Yi Zheng wrote:
>      There is some defects on IRQ processing:
> 
>      (1) At the beginning of handle_level_irq(), the IRQ-28 is masked, and ACK
>          action is executed: On my machine, it runs the 'else' branch:
> 
>             static inline void mask_ack_irq(struct irq_desc *desc)
>             {
>                 if (desc->irq_data.chip->irq_mask_ack) {
>                         desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
>                         irq_state_set_masked(desc);
>                 } else {
>                         mask_irq(desc);
>                         if (desc->irq_data.chip->irq_ack)
>                                 desc->irq_data.chip->irq_ack(&desc->irq_data);
>                 }
>             }
> 
>          It is an 2-steps procedure:
>          1. mask_irq()
>          2. desc->irq_data.chip->irq_ack()
> 
>          the 2nd step, the function ptr is omap_mask_ack_irq(), which
>          _MASK_ the hardware INTC-IRQ-32 and then do the real ACK action.

Sure. Where is the problem?

>      (2) mask_irq()/unmask_irq() are not atomic actions: They check the
>          IRQD_IRQ_MASKED flag firstly, and then mask/unmask the irq by calling
>          the function ptrs which installed by irq controller drv.  Then, those 2
>          functions set/clear the IRQD_IRQ_MASKED flag.
> 
>          I think the sequence of the hw/sw action should be mirrored reversed:
>          mask_irq():
>             check IRQD_IRQ_MASKED;
>             set hardware IRQ mask register;
>             set software IRQD_IRQ_MASKED flag;
> 
>          unmask_irq():
>             check IRQD_IRQ_MASKED;
>             /* NOTE: should before the hw unmask action!! */
>             clear software IRQD_IRQ_MASKED flag;
>             clear hardware IRQ mask register;
> 
>          The current unmask_irq(), hw-mask action runs before sw-mask action,
>          which gives an very small time window. That cause an unexpected
>          iterated IRQ.

It's completely irrelevant because _ALL_ those operations run with
irq_desc->lock held. So nothing can actually observe that state.

>      Here is my the detail of my analyzing of handle_level_irq():
> 
>      (1) Let record the HW-IRQ-Controller Status and the SW-Flag IRQD_IRQ_MASKED
>          pair as following: (hw-mask, sw-mask).
> 
>      (2) In the 1st level of IRQ-28 ISR calling, in unmask_irq(), after the HW
>          unmask action, and before the sw-flag IRQD_IRQ_MASKED is cleared, there
>          is a VERY SMALL TIME WINDOW, in which, another IRQ-28 may triggered.
> 
>          In that time window, the mask status is (0, 1), which is no an valid
>          value.

Again. Irrelevant because not observable.

>       My fixup is in the attachment, which remove the unexpected time window of
>       IRQ iteration.

Please don't send attachments. See Documentation/process/submitting-patches.rst

Thanks,

	tglx

