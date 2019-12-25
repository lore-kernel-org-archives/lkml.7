Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D1C2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CE32063A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLYCvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:51:08 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55169 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfLYCvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:51:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tlrvy-n_1577242264;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0Tlrvy-n_1577242264)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 10:51:04 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        zhabin@linux.alibaba.com, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
Date:   Wed, 25 Dec 2019 10:50:22 +0800
Message-Id: <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1577240905.git.zhabin@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
In-Reply-To: <cover.1577240905.git.zhabin@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jiang <gerry@linux.alibaba.com>

The x86 platform currently only supports specific MSI/MSI-x for PCI
devices. To enable MSI to the platform devices such as virtio-mmio
device, this patch enhances x86 with platform MSI by leveraging the
already built-in platform-msi driver (drivers/base/platform-msi.c)
and makes it as a configurable option.

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 arch/x86/Kconfig                 |  6 ++++
 arch/x86/include/asm/hw_irq.h    |  5 +++
 arch/x86/include/asm/irqdomain.h |  9 +++++
 arch/x86/kernel/apic/msi.c       | 74 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/platform-msi.c      |  4 +--
 include/linux/msi.h              |  1 +
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..c1178f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1074,6 +1074,12 @@ config X86_IO_APIC
 	def_bool y
 	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
 
+config X86_PLATFORM_MSI
+	def_bool y
+	depends on X86_LOCAL_APIC && X86_64
+	select GENERIC_MSI_IRQ
+	select GENERIC_MSI_IRQ_DOMAIN
+
 config X86_REROUTE_FOR_BROKEN_BOOT_IRQS
 	bool "Reroute for broken boot IRQs"
 	depends on X86_IO_APIC
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 4154bc5..5c96b49 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -113,6 +113,11 @@ struct irq_alloc_info {
 			struct msi_desc *desc;
 		};
 #endif
+#ifdef CONFIG_X86_PLATFORM_MSI
+		struct {
+			irq_hw_number_t	platform_msi_hwirq;
+		};
+#endif
 	};
 };
 
diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index c066ffa..b53f51f 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -56,4 +56,13 @@ extern void mp_irqdomain_deactivate(struct irq_domain *domain,
 static inline void arch_init_msi_domain(struct irq_domain *domain) { }
 #endif
 
+#ifdef CONFIG_X86_PLATFORM_MSI
+extern struct irq_domain *platform_msi_get_def_irq_domain(void);
+#else
+static inline struct irq_domain *platform_msi_get_def_irq_domain(void)
+{
+	return NULL;
+}
+#endif
+
 #endif
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7f75334..ef558c7 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -22,6 +22,10 @@
 #include <asm/irq_remapping.h>
 
 static struct irq_domain *msi_default_domain;
+#ifdef CONFIG_X86_PLATFORM_MSI
+static struct irq_domain *platform_msi_default_domain;
+static struct msi_domain_info platform_msi_domain_info;
+#endif
 
 static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
@@ -146,6 +150,17 @@ void __init arch_init_msi_domain(struct irq_domain *parent)
 	}
 	if (!msi_default_domain)
 		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+#ifdef CONFIG_X86_PLATFORM_MSI
+	fn = irq_domain_alloc_named_fwnode("PLATFORM-MSI");
+	if (fn) {
+		platform_msi_default_domain =
+			platform_msi_create_irq_domain(fn,
+				&platform_msi_domain_info, parent);
+		irq_domain_free_fwnode(fn);
+	}
+	if (!platform_msi_default_domain)
+		pr_warn("failed to initialize irqdomain for PLATFORM-MSI.\n");
+#endif
 }
 
 #ifdef CONFIG_IRQ_REMAP
@@ -384,3 +399,62 @@ int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
 #endif
+
+#ifdef CONFIG_X86_PLATFORM_MSI
+static void platform_msi_mask_irq(struct irq_data *data)
+{
+}
+
+static void platform_msi_unmask_irq(struct irq_data *data)
+{
+}
+
+static struct irq_chip platform_msi_controller = {
+	.name			= "PLATFORM-MSI",
+	.irq_mask		= platform_msi_mask_irq,
+	.irq_unmask		= platform_msi_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= irq_msi_compose_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int platform_msi_prepare(struct irq_domain *domain, struct device *dev,
+				int nvec, msi_alloc_info_t *arg)
+{
+	memset(arg, 0, sizeof(*arg));
+	return 0;
+}
+
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->platform_msi_hwirq = platform_msi_calc_hwirq(desc);
+}
+
+static irq_hw_number_t platform_msi_get_hwirq(struct msi_domain_info *info,
+					      msi_alloc_info_t *arg)
+{
+	return arg->platform_msi_hwirq;
+}
+
+static struct msi_domain_ops platform_msi_domain_ops = {
+	.msi_prepare	= platform_msi_prepare,
+	.set_desc	= platform_msi_set_desc,
+	.get_hwirq	= platform_msi_get_hwirq,
+};
+
+static struct msi_domain_info platform_msi_domain_info = {
+	.flags          = MSI_FLAG_USE_DEF_DOM_OPS |
+			  MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_ACTIVATE_EARLY,
+	.ops            = &platform_msi_domain_ops,
+	.chip           = &platform_msi_controller,
+	.handler        = handle_edge_irq,
+	.handler_name   = "edge",
+};
+
+struct irq_domain *platform_msi_get_def_irq_domain(void)
+{
+	return platform_msi_default_domain;
+}
+#endif
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8da314b..45752f1 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -31,12 +31,11 @@ struct platform_msi_priv_data {
 /* The devid allocator */
 static DEFINE_IDA(platform_msi_devid_ida);
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 /*
  * Convert an msi_desc to a globaly unique identifier (per-device
  * devid + msi_desc position in the msi_list).
  */
-static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
+irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
 	u32 devid;
 
@@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
 }
 
+#ifdef GENERIC_MSI_DOMAIN_OPS
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ad679e..ee5f566 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-- 
1.8.3.1

