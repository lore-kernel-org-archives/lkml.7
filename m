Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51BEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924DA206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbeyV00V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfJHNGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:06:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41328 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:06:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so8427645plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ci09fnfelCPBJ8rSquMZeLtrWieTn6ENLjavp6JETfg=;
        b=cbeyV00VQP6m9LY7fewXB6fdP0BUUzxrt/0t1v7sNxZ1U1Qnci0P8mfegZMv4cqRPi
         oB7pRpdbVT2glSSWISp6qOJhjgV+0Cl3wsIVLYv85FAhCqExcxLERvuSmV9cNBwEutiJ
         iPTPhTgN/zOafD/4+GGr564WwUuFH9CWRF4puxHTYA/r3i/6wqhR/vZaztciJOI3THfV
         fPniDQgBqiye5h6RvjMIo7q19EM9XBhL2qW/n7MbONQU2g4461/cKygiytREKPot570H
         963FOMY61XQv5vW9SBbdwq/3nvjcP3jDUnPeIyZZuaGtw3Pc0Xr99JdtE3NMXdoTqKt8
         h74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ci09fnfelCPBJ8rSquMZeLtrWieTn6ENLjavp6JETfg=;
        b=PTtjjL1TZSM5bTn5sJFij7WGtdGAOOk1w20DppqVuO7uTW5mqUdQJn+tAlogwlxVgt
         knyYv0Cn3G1G0LROL0nPsY+745XPUFmHAYSko5G7glQ0g4bzt9HVEriM4RRfp1mERanu
         GUlzdKg2K1RHSDxgOizaAC/5PeXN0/UhQZfaBva9dyo4fkKZ4pB66vdITah2/kK5ojWa
         bq1V/KDgsYIokYwP/6OpBjLBx9LYQWWFbVWAbp74U980CG48IQxufydnRwLVW3+FpHJt
         nUM08JiXyORhw2nopLYQOdQW5n+tkBIEhuSKa+fpqYgTM2Xr64NBhvhKb25ytU7nEnqd
         QKXQ==
X-Gm-Message-State: APjAAAX0UjOmXSTXQISaq4RNcdhGQWx+pcC/L/yrO5gs7r10uqzexUHv
        8XokiZY9+oo0CjedBuiyRRRZspelQ7B8MbLdiv2jEZHha2vPbA==
X-Google-Smtp-Source: APXvYqzmzI5qKPDQ0lvXNRjwPDeVxIkRSJR6EmB+m0OmVxRRq3rciwIs7nFCePX89dIFzQmaFFnOCM7dFtd9GRj06jI=
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr35723006plr.64.1570539963596;
 Tue, 08 Oct 2019 06:06:03 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zheng <goodmenzy@gmail.com>
Date:   Tue, 8 Oct 2019 21:04:23 +0800
Message-ID: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
Subject: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Zheng Yi <yzheng@techyauld.com>
Content-Type: multipart/mixed; boundary="000000000000a3def3059465d425"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a3def3059465d425
Content-Type: text/plain; charset="UTF-8"

Hi,

     I found something wrong on my AM3352 SoC machine, the GPIO triggered IRQ is
     masked unexpectedly.  That bug cause the devices using that GPIO-IRQ can
     not work. Even the latest kernel version (v5.4-rc2-20-geda57a0e4299)!

     After a long time hacking, I guess the bug is in kernel/irq/chip.c, the
     important base code for _ALL_ the Processor Platform! That is why this mail
     is sent to you.

     Shortly speaking, the bug is about wrong interrupt iteration. That cause
     the software flag "IRQD_IRQ_MASKED" not refect the real masking status
     register in the interrupt controller (INTC,
     drivers/irqchip/irq-omap-intc.c).

     Here is my hw/sw settings:
     (1) FPGA implements some UART, using a GPIO pin as INT signal,

     (2) In the SoC, 481ac000.gpio is under the INTC controller, irq=28, and
         hwirq=32 It is an level triggered IRQ.

     (3) The ISR calling stack shows that handle_level_irq() is the most
         important function for debugging.

     There is some defects on IRQ processing:

     (1) At the beginning of handle_level_irq(), the IRQ-28 is masked, and ACK
         action is executed: On my machine, it runs the 'else' branch:

            static inline void mask_ack_irq(struct irq_desc *desc)
            {
                if (desc->irq_data.chip->irq_mask_ack) {
                        desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
                        irq_state_set_masked(desc);
                } else {
                        mask_irq(desc);
                        if (desc->irq_data.chip->irq_ack)
                                desc->irq_data.chip->irq_ack(&desc->irq_data);
                }
            }

         It is an 2-steps procedure:
         1. mask_irq()
         2. desc->irq_data.chip->irq_ack()

         the 2nd step, the function ptr is omap_mask_ack_irq(), which
         _MASK_ the hardware INTC-IRQ-32 and then do the real ACK action.

     (2) mask_irq()/unmask_irq() are not atomic actions: They check the
         IRQD_IRQ_MASKED flag firstly, and then mask/unmask the irq by calling
         the function ptrs which installed by irq controller drv.  Then, those 2
         functions set/clear the IRQD_IRQ_MASKED flag.

         I think the sequence of the hw/sw action should be mirrored reversed:
         mask_irq():
            check IRQD_IRQ_MASKED;
            set hardware IRQ mask register;
            set software IRQD_IRQ_MASKED flag;

         unmask_irq():
            check IRQD_IRQ_MASKED;
            /* NOTE: should before the hw unmask action!! */
            clear software IRQD_IRQ_MASKED flag;
            clear hardware IRQ mask register;

         The current unmask_irq(), hw-mask action runs before sw-mask action,
         which gives an very small time window. That cause an unexpected
         iterated IRQ.

     Here is my the detail of my analyzing of handle_level_irq():

     (1) Let record the HW-IRQ-Controller Status and the SW-Flag IRQD_IRQ_MASKED
         pair as following: (hw-mask, sw-mask).

     (2) In the 1st level of IRQ-28 ISR calling, in unmask_irq(), after the HW
         unmask action, and before the sw-flag IRQD_IRQ_MASKED is cleared, there
         is a VERY SMALL TIME WINDOW, in which, another IRQ-28 may triggered.

         In that time window, the mask status is (0, 1), which is no an valid
         value.

     (3) In the 2nd level of the ISR(IRQ-28), The mask status is IRQ-28(0, 1),
         so mask_irq() do nothing, because sw-flag is "1".  That is an wrong
         status, the programmer thinks that IRQ-28 has been masked, but
         physically not!

     (4) Before the ACK func-ptr calling, there comes the 3rd level IRQ (28/32)!
         Although mask_irq() do not physically mask the IRQ, ACK acion
         (omap_mask_ack_irq) of the omap-intc drv mask the IRQ physically. The
         3rd ISR runs OK.

         When 3rd level ISR exist, the mask status is (0, 0), that is OK!

     (5) The 3rd level ISR finished, the 2nd level ISR continue.  It run ACK
         function ptr -- omap_mask_ack_irq(). The HW-IRQ-mask is set again!
         Now, the mask status is (1, 0), it is unreasonable value!

     (6) The 2nd level ISR run to cond_unmask_irq(). Due to the ill-formed
         mask-status value(1, 0), the unmask_irq() will not be called.  Even in
         unmask_irq(), another checking SW-Flag exists. The real unmask action
         will not run!

     (7) Now, the 2nd level ISR return, with the mask status (1, 0).  The 1st
         level ISR continues, in unmask_irq(), it run irq_state_clr_masked();
         And it repeatedly clear the IRQD_IRQ_MASKED. The final mask status is
         (1, 0).

         What (1, 0) value means? The CPU call will not receive IRQ any more!
         That is my bug phenomenon. If I clean the hardware interrupt
         controller's mask bit, my devices work again.


      NOTE: (1) My SoC is a single core ARM chip: TI-AM3352, so the raw
         spin-lock irq_desc->lock will be optimized to
         nothing. handle_level_irq() has no spin-lock protection, right?

         (2) In AM3352, INTC driver ACK the IRQ by write 0x01 into INTC Control
             Register(offset 0x48).  The chip doc seems that bit[0] of
             INTC-Control Reg is only an enable/disable flag.  The IRQ may
             generated even if no ACK action done. Any one can give me an
             clarification?

         (3) My analysis is not verified on the real machine. After some code
             change for debug(add counter to indicates the iteration level, save
             the IRQ mask status etc.), the device IRQ wrongly masked problem
             vanished. In fact, the original code can not re-produce the
             phenomena easily. In tens of machine, only one can get the bug. I
             have try my best to hacking the code, but the only verified result
             is here: when bug occur, the HW IRQ is masked, but the
             IRQD_IRQ_MASKED flag is cleared.

      My fixup is in the attachment, which remove the unexpected time window of
      IRQ iteration.

--000000000000a3def3059465d425
Content-Type: text/x-patch; charset="US-ASCII"; name="irq-chip-fixup.patch"
Content-Disposition: attachment; filename="irq-chip-fixup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1huv2ml0>
X-Attachment-Id: f_k1huv2ml0

LS0tIGtlcm5lbC9pcnEvY2hpcC5jCTIwMTktMDctMTMgMDk6Mjg6MjMuNjgzNzg3MzY3ICswODAw
CisrKyAvdG1wL2NoaXAuYwkyMDE5LTEwLTA4IDExOjMyOjM1LjA4MjI1ODU3MiArMDgwMApAQCAt
NDMyLDggKzQzMiw4IEBAIHZvaWQgdW5tYXNrX2lycShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpCiAJ
CXJldHVybjsKIAogCWlmIChkZXNjLT5pcnFfZGF0YS5jaGlwLT5pcnFfdW5tYXNrKSB7Ci0JCWRl
c2MtPmlycV9kYXRhLmNoaXAtPmlycV91bm1hc2soJmRlc2MtPmlycV9kYXRhKTsKIAkJaXJxX3N0
YXRlX2Nscl9tYXNrZWQoZGVzYyk7CisJCWRlc2MtPmlycV9kYXRhLmNoaXAtPmlycV91bm1hc2so
JmRlc2MtPmlycV9kYXRhKTsKIAl9CiB9CiAK
--000000000000a3def3059465d425--
