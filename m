Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB057C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DC821855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfDEPqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:46:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:46:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35FkGRF2814777
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 08:46:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35FkG2e2814774;
        Fri, 5 Apr 2019 08:46:16 -0700
Date:   Fri, 5 Apr 2019 08:46:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephen Boyd <tipbot@zytor.com>
Message-ID: <tip-325aa19598e410672175ed50982f902d4e3f31c5@git.kernel.org>
Cc:     tglx@linutronix.de, swboyd@chromium.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ilina@codeaurora.org,
        marc.zyngier@arm.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, swboyd@chromium.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          marc.zyngier@arm.com, ilina@codeaurora.org
In-Reply-To: <20190325181026.247796-1-swboyd@chromium.org>
References: <20190325181026.247796-1-swboyd@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Respect IRQCHIP_SKIP_SET_WAKE in
 irq_chip_set_wake_parent()
Git-Commit-ID: 325aa19598e410672175ed50982f902d4e3f31c5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  325aa19598e410672175ed50982f902d4e3f31c5
Gitweb:     https://git.kernel.org/tip/325aa19598e410672175ed50982f902d4e3f31c5
Author:     Stephen Boyd <swboyd@chromium.org>
AuthorDate: Mon, 25 Mar 2019 11:10:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 17:41:41 +0200

genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

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

---
 kernel/irq/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3faef4a77f71..51128bea3846 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1449,6 +1449,10 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
 	data = data->parent_data;
+
+	if (data->chip->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 
