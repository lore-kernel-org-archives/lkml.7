Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A13AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0B20640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLZ8r+Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfJHMtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:49:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38006 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730737AbfJHMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:49:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so8410858plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CbQJLATT5wb2/W6NdgyosWQjZqh4rIHUE+AO/Jirx2w=;
        b=dLZ8r+GaYAhqVoJIHmKPZVUlkG+X+4KCbTJZ1A6TpyqcJp7SAhVQKj5iIBvAk4oKBW
         yJU3F2GGlQpAcMFcpYIgOhDIRGBvoaxAjp5NWsyUq83WeMveLMcMC2HhdnbA0ndZ+8cy
         avQe1Ky+lZsLvHkXmtBCRTI3XZ1GFS9Wzj8c1jrwIa/vS7jQvH4MV64DpKtl2Fod6T94
         WNcWJf+w/5rrGvtdmpepZaAyRdEjFsMvVcWCfFVL0/RdxEIkfxVsluf7Mw/iRZLjbe0m
         I1Cs27WAiBS1EC/BkyscS+6WZDwcWx3wDzTTLZYxAZv4mHwcUerSLqYO4yY7AW0myVhm
         ACxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CbQJLATT5wb2/W6NdgyosWQjZqh4rIHUE+AO/Jirx2w=;
        b=qoqIi5LFsama4hu2CV7z7EvDG1V2I0IkauB1z7XiX++BAL1mqs8ecfXUkgzDe3ItwP
         dYsgQVdEdPK5CDC0vUrvY6GsDN0zzlFCIiOgYbzgytdaIX7HCL3G8qshFy0LlaQ99PDI
         YaOqk4gRE77wsnC0IiWsAzqAL+JIauuwYyFzjsRD4nQrHjOmqxAmGLUsuOa+u4zGmj0t
         30p6OUbxh5lm2ucX2WiXxpOCByb04ssFQBEs4woDICKe27OgoSPeyw8kFKP4blGOxrt+
         YO4k3LOH0/47ApdnuMtgrBratwdzGHamdbHgxkOTcWcv+v5CZDDqDqYzkPfxuvgAGdrW
         +UPg==
X-Gm-Message-State: APjAAAWAGQY0czycKVRoyLXPRjxObSArKR3Yv5bv3znnX1eFl3DrWrnd
        8hb7xGhkJ/pHUNjIqsS92FdVv2V+Yr9h4rMlu+U=
X-Google-Smtp-Source: APXvYqwqSOJ7tzLQ4quv9+8s2+v7XbFTXNVsPhCoLu89qLE9d4xyt+ln++6mddDw7thcWzVn0aFGbFmfzGYyR626ACo=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr33430533pll.119.1570538959095;
 Tue, 08 Oct 2019 05:49:19 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zheng <goodmenzy@gmail.com>
Date:   Tue, 8 Oct 2019 20:47:40 +0800
Message-ID: <CAJPHfYMpX0wkxBL8TFg-sWTgmji6Ek+h35qM2Yc1f1JtXvx4xQ@mail.gmail.com>
Subject: Maybe a bug in kernel/irq/chip.c unmask_irq(), device irq is masked unexpectedly.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Zheng Yi <yzheng@techyauld.com>
Content-Type: multipart/mixed; boundary="000000000000c3ab1805946598f3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c3ab1805946598f3
Content-Type: text/plain; charset="UTF-8"

Hi,

     I found something wrong on my AM3352 SoC machine, the GPIO
triggered IRQ is masked
     unexpectedly.  That bug cause the devices using that GPIO-IRQ can
not work. Even the
     latest kernel version (v5.4-rc2-20-geda57a0e4299)!

     After a long time hacking, I guess the bug is in
kernel/irq/chip.c, the important
     base code for _ALL_ the Processor Platform! That is why this mail
is sent to you.

     Shortly speaking, the bug is about wrong interrupt iteration.
That cause the software
     flag "IRQD_IRQ_MASKED" not refect the real masking status
register in the interrupt
     controller (INTC, drivers/irqchip/irq-omap-intc.c).

     Here is my hw/sw settings:
     (1) FPGA implements some UART, using a GPIO pin as INT signal,

     (2) In the SoC, 481ac000.gpio is under the INTC controller,
irq=28, and hwirq=32
         It is an level triggered IRQ.

     (3) The ISR calling stack shows that handle_level_irq() is the
most important
         function for debugging.

     There is some defects on IRQ processing:

     (1) At the beginning of handle_level_irq(), the IRQ-28 is masked,
and ACK action is executed:
         On my machine, it runs the 'else' branch:
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

     (2) mask_irq()/unmask_irq() are not atomic actions:
         They check the IRQD_IRQ_MASKED flag firstly, and then
         mask/unmask the irq by calling the function ptrs which
installed by irq controller drv.
         Then, those 2 functions set/clear the IRQD_IRQ_MASKED flag.

         I think the sequence of the hw/sw action should be mirrored reversed:
         mask_irq():
            check IRQD_IRQ_MASKED;
            set hardware IRQ mask register;
            set software IRQD_IRQ_MASKED flag;

         unmask_irq():
            check IRQD_IRQ_MASKED;
            clear software IRQD_IRQ_MASKED flag; /* NOTE: should
before the hw unmask action!! */
            clear hardware IRQ mask register;

         The current unmask_irq(), hw-mask action runs before sw-mask
action, which gives an very small
         time window. That cause an unexpected iterated IRQ.

     Here is my the detail of my analyzing of handle_level_irq():

     (1) Let record the HW-IRQ-Controller Status and the SW-Flag
IRQD_IRQ_MASKED pair as following:
         (hw-mask, sw-mask).

     (2) In the 1st level of IRQ-28 ISR calling, in unmask_irq(),
after the HW unmask action, and
         before the sw-flag IRQD_IRQ_MASKED is cleared, there is a
VERY SMALL TIME WINDOW,
         in which, another IRQ-28 may triggered.

         In that time window, the mask status is (0, 1), which is no
an valid value.

     (3) In the 2nd level of the ISR(IRQ-28), The mask status is
IRQ-28(0, 1), so
         mask_irq() do nothing, because sw-flag is "1".  That is an
wrong status, the
         programmer thinks that IRQ-28 has been masked, but physically not!

     (4) Before the ACK func-ptr calling, there comes the 3rd level IRQ (28/32)!
         Although mask_irq() do not physically mask the IRQ, ACK acion
(omap_mask_ack_irq)
         of the omap-intc drv mask the IRQ physically. The 3rd ISR runs OK.

         When 3rd level ISR exist, the mask status is (0, 0), that is OK!

     (5) The 3rd level ISR finished, the 2nd level ISR continue.
         It run ACK function ptr -- omap_mask_ack_irq(). The
HW-IRQ-mask is set again!
         Now, the mask status is (1, 0), it is unreasonable value!

     (6) The 2nd level ISR run to cond_unmask_irq(). Due to the
ill-formed mask-status
         value(1, 0), the unmask_irq() will not be called.  Even in
unmask_irq(), another
         checking SW-Flag exists. The real unmask action will not run!

     (7) Now, the 2nd level ISR return, with the mask status (1, 0).
         The 1st level ISR continues, in unmask_irq(), it run
irq_state_clr_masked();
         And it repeatedly clear the IRQD_IRQ_MASKED. The final mask
status is (1, 0).

         What (1, 0) value means? The CPU call will not receive IRQ any more!
         That is my bug phenomenon. If I clean the hardware interrupt
controller's mask bit, my
         devices work again.


      NOTE:
         (1) My SoC is a single core ARM chip: TI-AM3352, so the raw spin-lock
             irq_desc->lock will be optimized to nothing.
handle_level_irq() has no
             spin-lock protection, right?

         (2) In AM3352, INTC driver ACK the IRQ by write 0x01 into INTC Control
             Register(offset 0x48).  The chip doc seems that bit[0] of
INTC-Control Reg is
             only an enable/disable flag.  The IRQ may generated even
if no ACK action
             done. Any one can give me an clarification?

         (3) My analysis is not verified on the real machine. After
some code change for
             debug(add counter to indicates the iteration level, save
the IRQ mask status
             etc.), the device IRQ wrongly masked problem vanished. In
fact, the original
             code can not re-produce the phenomena easily. In tens of
machine, only one
             can get the bug. I have try my best to hacking the code,
but the only
             verified result is here: when bug occur, the HW IRQ is
masked, but the
             IRQD_IRQ_MASKED flag is cleared.

      My fixup is in the attachment, which remove the unexpected time
window of IRQ iteration.

--000000000000c3ab1805946598f3
Content-Type: text/x-patch; charset="US-ASCII"; name="irq-chip-fixup.patch"
Content-Disposition: attachment; filename="irq-chip-fixup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1hu6qvv0>
X-Attachment-Id: f_k1hu6qvv0

LS0tIGtlcm5lbC9pcnEvY2hpcC5jCTIwMTktMDctMTMgMDk6Mjg6MjMuNjgzNzg3MzY3ICswODAw
CisrKyAvdG1wL2NoaXAuYwkyMDE5LTEwLTA4IDExOjMyOjM1LjA4MjI1ODU3MiArMDgwMApAQCAt
NDMyLDggKzQzMiw4IEBAIHZvaWQgdW5tYXNrX2lycShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpCiAJ
CXJldHVybjsKIAogCWlmIChkZXNjLT5pcnFfZGF0YS5jaGlwLT5pcnFfdW5tYXNrKSB7Ci0JCWRl
c2MtPmlycV9kYXRhLmNoaXAtPmlycV91bm1hc2soJmRlc2MtPmlycV9kYXRhKTsKIAkJaXJxX3N0
YXRlX2Nscl9tYXNrZWQoZGVzYyk7CisJCWRlc2MtPmlycV9kYXRhLmNoaXAtPmlycV91bm1hc2so
JmRlc2MtPmlycV9kYXRhKTsKIAl9CiB9CiAK
--000000000000c3ab1805946598f3--
