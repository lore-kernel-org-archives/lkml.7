Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0621916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256327;
	bh=AX8C5EWBgznx8T2SolHXsGRoOKJV0cpm9FRgi22h1UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CeytQ/Rn2e6aYFuVEfHJCzx4oLHioTqhIxH+geheHbWu1/kz8nVTiP0svwWAgTHBH
	 TeiwTeXVjg8Sia8LM0CP2FKycElGrxq0sP/koOA01557my1bekogoprI3U+N9H9kqi
	 1r22e2ipWegWhGzcKvk4/hDMwH7Faduv65muUJmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfCVMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbfCVMFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751E821916;
        Fri, 22 Mar 2019 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256322;
        bh=AX8C5EWBgznx8T2SolHXsGRoOKJV0cpm9FRgi22h1UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fg8MR+R6N2vjUBVdrruLEd34DyA9/HZPWpxiq+AS2ruzNFlBcTQVdpPwRt+NI54d1
         a77cRadxUl+7pMfAkeLjiWZVT5yUgLx0fLaPhs3S+PaIB/4EEa2Lj8yGxA6G9Tz+bu
         Coe0NFjlaumaozJKHg56JdCeUKyz198B7BVBQe8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 175/280] irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt code
Date:   Fri, 22 Mar 2019 12:15:28 +0100
Message-Id: <20190322111325.438497383@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 33517881ede742107f416533b8c3e4abc56763da upstream.

Using the irq_gc_lock/irq_gc_unlock functions in the suspend and
resume functions creates the opportunity for a deadlock during
suspend, resume, and shutdown. Using the irq_gc_lock_irqsave/
irq_gc_unlock_irqrestore variants prevents this possible deadlock.

Cc: stable@vger.kernel.org
Fixes: 7f646e92766e2 ("irqchip: brcmstb-l2: Add Broadcom Set Top Box Level-2 interrupt controller")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
[maz: tidied up $SUBJECT]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-brcmstb-l2.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -129,8 +129,9 @@ static void brcmstb_l2_intc_suspend(stru
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
 	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
@@ -139,7 +140,7 @@ static void brcmstb_l2_intc_suspend(stru
 		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
 		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static void brcmstb_l2_intc_resume(struct irq_data *d)
@@ -147,8 +148,9 @@ static void brcmstb_l2_intc_resume(struc
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
@@ -158,7 +160,7 @@ static void brcmstb_l2_intc_resume(struc
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,


