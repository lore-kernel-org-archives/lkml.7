Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F49C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3320862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 04:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEMESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 00:18:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfEMESf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 00:18:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E3DD6189E32D9974D90;
        Mon, 13 May 2019 12:18:33 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 May 2019 12:18:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <andre.przywara@arm.com>,
        <eric.auger@redhat.com>, <drjones@redhat.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH] irqchip/gic-v3: Correct the usage of GICD_CTLR's RWP field
Date:   Mon, 13 May 2019 04:15:54 +0000
Message-ID: <1557720954-6592-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per ARM IHI 0069D, GICD_CTLR's RWP field tracks updates to:

	GICD_CTLR's Group Enable bits, for transitions from 1 to 0 only
	GICD_CTLR's ARE bits, E1NWF bit and DS bit (if we have)
	GICD_ICENABLER<n>

We seemed use this field in an inappropriate way, somewhere in the
GIC-v3 driver. For some examples:

In gic_set_affinity(), if the interrupt was not enabled, we only need
to write GICD_IROUTER<n> with the appropriate mpidr value. Updates to
GICD_IROUTER will not be tracked by RWP field, and we can remove the
unnecessary RWP waiting.

In gic_dist_init(), we "Enable distributor with ARE, Group1" by writing
to GICD_CTLR, and we should use gic_dist_wait_for_rwp() here.

These two are obvious cases, and there are some other cases where we don't
need to do RWP waiting, such as in gic_configure_irq() and gic_poke_irq().
But too many modifications makes me not confident. It's hard for me to say
whether this patch is doing the right thing and how does the RWP waiting
affect the system, thus RFC.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 15e55d3..8d63950 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -600,6 +600,7 @@ static void __init gic_dist_init(void)
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
 		       base + GICD_CTLR);
+	gic_dist_wait_for_rwp();
 
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
@@ -986,14 +987,9 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 
 	gic_write_irouter(val, reg);
 
-	/*
-	 * If the interrupt was enabled, enabled it again. Otherwise,
-	 * just wait for the distributor to have digested our changes.
-	 */
+	/* If the interrupt was enabled, enabled it again. */
 	if (enabled)
 		gic_unmask_irq(d);
-	else
-		gic_dist_wait_for_rwp();
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
1.8.3.1


