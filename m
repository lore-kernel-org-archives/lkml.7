Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E72087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCQOlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:41:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726850AbfCQOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:41:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20EB82B4E8D95F57C411;
        Sun, 17 Mar 2019 22:41:42 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Sun, 17 Mar 2019 22:41:34 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <christoffer.dall@arm.com>,
        <eric.auger@redhat.com>, <andre.przywara@arm.com>
CC:     <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <mst@redhat.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
Date:   Sun, 17 Mar 2019 14:36:13 +0000
Message-ID: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, IRQFD on arm still uses the deferred workqueue mechanism
to inject interrupts into guest, which will likely lead to a busy
context-switching from/to the kworker thread. This overhead is for
no purpose (only in my view ...) and will result in an interrupt
performance degradation.

Implement kvm_arch_set_irq_inatomic() for arm/arm64 to support direct
irqfd MSI injection, by which we can get rid of the annoying latency.
As a result, irqfd MSI intensive scenarios (e.g., DPDK with high packet
processing workloads) will benefit from it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

It seems that only MSI will follow the IRQFD path, did I miss something?

This patch is still under test and sent out for early feedback. If I have
any mis-understanding, please fix me up and let me know. Thanks!

---
 virt/kvm/arm/vgic/trace.h      | 22 ++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic-irqfd.c | 21 +++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/virt/kvm/arm/vgic/trace.h b/virt/kvm/arm/vgic/trace.h
index 55fed77..bc1f4db 100644
--- a/virt/kvm/arm/vgic/trace.h
+++ b/virt/kvm/arm/vgic/trace.h
@@ -27,6 +27,28 @@
 		  __entry->vcpu_id, __entry->irq, __entry->level)
 );
 
+TRACE_EVENT(kvm_arch_set_irq_inatomic,
+	TP_PROTO(u32 gsi, u32 type, int level, int irq_source_id),
+	TP_ARGS(gsi, type, level, irq_source_id),
+
+	TP_STRUCT__entry(
+		__field(	u32,	gsi		)
+		__field(	u32,	type		)
+		__field(	int,	level		)
+		__field(	int,	irq_source_id	)
+	),
+
+	TP_fast_assign(
+		__entry->gsi		= gsi;
+		__entry->type		= type;
+		__entry->level		= level;
+		__entry->irq_source_id	= irq_source_id;
+	),
+
+	TP_printk("gsi %u type %u level %d source %d", __entry->gsi,
+		  __entry->type, __entry->level, __entry->irq_source_id)
+);
+
 #endif /* _TRACE_VGIC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
index 99e026d..4cfc3f4 100644
--- a/virt/kvm/arm/vgic/vgic-irqfd.c
+++ b/virt/kvm/arm/vgic/vgic-irqfd.c
@@ -19,6 +19,7 @@
 #include <trace/events/kvm.h>
 #include <kvm/arm_vgic.h>
 #include "vgic.h"
+#include "trace.h"
 
 /**
  * vgic_irqfd_set_irq: inject the IRQ corresponding to the
@@ -105,6 +106,26 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	return vgic_its_inject_msi(kvm, &msi);
 }
 
+/**
+ * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
+ *
+ * Currently only direct MSI injecton is supported.
+ */
+int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
+			      struct kvm *kvm, int irq_source_id, int level,
+			      bool line_status)
+{
+	int ret;
+
+	trace_kvm_arch_set_irq_inatomic(e->gsi, e->type, level, irq_source_id);
+
+	if (unlikely(e->type != KVM_IRQ_ROUTING_MSI))
+		return -EWOULDBLOCK;
+
+	ret = kvm_set_msi(e, kvm, irq_source_id, level, line_status);
+	return ret;
+}
+
 int kvm_vgic_setup_default_irq_routing(struct kvm *kvm)
 {
 	struct kvm_irq_routing_entry *entries;
-- 
1.8.3.1


