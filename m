Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EDAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DCB21902
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355602;
	bh=aRZ3aRMylXpBl/ZENBGU29JNC1NzKlwAAFnBA9GtQeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xJXtO0ImTjhvob4LK01YT27r9aCVr3mmz90u/sNsTCXYOLTPMwNbBFIh+T1/Ih1nR
	 euRvJSyzgacKUt+0p/fkm0WJ+nCgadI9tOlMVmdGtfempgRE2wkg3AhSKw+gJkw3Xu
	 WklpS5+X8EOREtik4FOkk6AkWNmJ/q5Lb57cbeFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfDOTNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfDOTNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44488218FE;
        Mon, 15 Apr 2019 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355596;
        bh=aRZ3aRMylXpBl/ZENBGU29JNC1NzKlwAAFnBA9GtQeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXYhAjaYcrYeH4uHW2XgWedlPKewAoAdY27JnNXACMvQBa37ZfvB4Yq3ghSgD+j9T
         BFyOx4ZHyvyFjL4qcR2RRccyLtcYSzwqhuWd+7E9fUslARniU0yKDSDHY7hOiJ5/0e
         WmO9oeOp6XqsSy121Cvnf4PHnk8PAhnzZJWT+M2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 5.0 081/117] genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
Date:   Mon, 15 Apr 2019 21:00:51 +0200
Message-Id: <20190415183749.064704556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

commit 325aa19598e410672175ed50982f902d4e3f31c5 upstream.

If a child irqchip calls irq_chip_set_wake_parent() but its parent irqchip
has the IRQCHIP_SKIP_SET_WAKE flag set an error is returned.

This is inconsistent behaviour vs. set_irq_wake_real() which returns 0 when
the irqchip has the IRQCHIP_SKIP_SET_WAKE flag set. It doesn't attempt to
walk the chain of parents and set irq wake on any chips that don't have the
flag set either. If the intent is to call the .irq_set_wake() callback of
the parent irqchip, then we expect irqchip implementations to omit the
IRQCHIP_SKIP_SET_WAKE flag and implement an .irq_set_wake() function that
calls irq_chip_set_wake_parent().

The problem has been observed on a Qualcomm sdm845 device where set wake
fails on any GPIO interrupts after applying work in progress wakeup irq
patches to the GPIO driver. The chain of chips looks like this:

     QCOM GPIO -> QCOM PDC (SKIP) -> ARM GIC (SKIP)

The GPIO controllers parent is the QCOM PDC irqchip which in turn has ARM
GIC as parent.  The QCOM PDC irqchip has the IRQCHIP_SKIP_SET_WAKE flag
set, and so does the grandparent ARM GIC.

The GPIO driver doesn't know if the parent needs to set wake or not, so it
unconditionally calls irq_chip_set_wake_parent() causing this function to
return a failure because the parent irqchip (PDC) doesn't have the
.irq_set_wake() callback set. Returning 0 instead makes everything work and
irqs from the GPIO controller can be configured for wakeup.

Make it consistent by returning 0 (success) from irq_chip_set_wake_parent()
when a parent chip has IRQCHIP_SKIP_SET_WAKE set.

[ tglx: Massaged changelog ]

Fixes: 08b55e2a9208e ("genirq: Add irqchip_set_wake_parent")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190325181026.247796-1-swboyd@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/chip.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1384,6 +1384,10 @@ int irq_chip_set_vcpu_affinity_parent(st
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
 	data = data->parent_data;
+
+	if (data->chip->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 


