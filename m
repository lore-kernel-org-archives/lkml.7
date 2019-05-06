Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E5C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FB02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEFIUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbfEFIUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C774E5F37D8C6047197F;
        Mon,  6 May 2019 16:20:43 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 16:20:42 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     <julien.thierry@arm.com>, <Suzuki.Poulose@arm.com>,
        <sudeep.holla@arm.com>, <steve.capper@arm.com>,
        <lorenzo.pieralisi@arm.com>, <daniel.thompson@linaro.org>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: Avoid entering NMI context improperly
Date:   Mon, 6 May 2019 16:25:42 +0800
Message-ID: <20190506082542.11357-4-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506082542.11357-1-liwei391@huawei.com>
References: <20190506082542.11357-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the pseudo NMI can be enabled/disabled by cmdline parameter, the
arch_trigger_cpumask_backtrace() may still work through a normal IPI.

In this patch, we export the gic_supports_nmi() and add a check in
IPI_CPU_BACKTRACE process to avoid entering NMI context when pseudo
NMI is disabled.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/arch_gicv3.h |  8 ++++++++
 arch/arm64/kernel/smp.c             | 14 ++++++++++++--
 drivers/irqchip/irq-gic-v3.c        |  8 +-------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 14b41ddc68ba..6655701ea7d4 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -156,6 +156,14 @@ static inline u32 gic_read_rpr(void)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
 
+extern struct static_key_false supports_pseudo_nmis;
+
+static inline bool gic_supports_nmi(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
+	       static_branch_likely(&supports_pseudo_nmis);
+}
+
 static inline bool gic_prio_masking_enabled(void)
 {
 	return system_uses_irq_prio_masking();
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7e862f9124f3..5550951527ea 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -950,9 +950,19 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 #endif
 
 	case IPI_CPU_BACKTRACE:
-		nmi_enter();
+		if (gic_supports_nmi()) {
+			nmi_enter();
+		} else {
+			printk_nmi_enter();
+			irq_enter();
+		}
 		nmi_cpu_backtrace(regs);
-		nmi_exit();
+		if (gic_supports_nmi()) {
+			nmi_exit();
+		} else {
+			irq_exit();
+			printk_nmi_exit();
+		}
 		break;
 
 	default:
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 394aa5668dd6..b701727258b0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -90,7 +90,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  * For now, we only support pseudo-NMIs if we have non-secure view of
  * priorities.
  */
-static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t ppi_nmi_refs[16];
@@ -261,12 +261,6 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
-static inline bool gic_supports_nmi(void)
-{
-	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
-	       static_branch_likely(&supports_pseudo_nmis);
-}
-
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
-- 
2.17.1

