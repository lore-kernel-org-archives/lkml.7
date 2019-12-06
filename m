Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93424C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4FB20707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FrGs+dW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:33:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55473 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfLFCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575599622; x=1607135622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u4ns4F+dn++weka+UCIKzTDCJRd3kH78GNtaEz0nonc=;
  b=FrGs+dW1IUoAsg8fvkOqEqlhjJf5X2LfztUVhLTKJw/zRbiwbliycxwH
   D4Fm72ViJLUR5rku9aR2x7VdOEda9bCUkodAK/NAjtEx9cMG6MtyY53if
   l/DXdzNNXsyn3E6ZTSnVvCoyLsOcS8zmO9rAVvbpgrX7fw3Hhq6W035Zz
   em4hk4df532wt0R+56TNsg9brRKzlc6aUN7QddfeBw7MZ6tI4pfmC6NBP
   2tJ33T6JIUljBsFxIGOTNRK1V8Z+gXXZf2bICPlz/rbcBR907qdnOo6v+
   XJsPtNbHIACI1/b8+32pG4eMSRcweEsm329YfMVH2iC46C14GK7QtHqY8
   w==;
IronPort-SDR: qUMeXxNYY2kvVuOVBzO9yLwUe5WWjkR9N15B6YLYKB0jwLhxjKgIqPpVC11fahAZCcPpOkeFU6
 2BtiBKNMBtLWwKCHBs5NLFVVKImE5OMt8D2i3QIW4P+tjS9jAVpztxDIHyMXtFSjM1fh3FMuEF
 9aV12xFnl91cw+Q/ngsibGG3nwheEhex2QicKkaN3+MjuMNQ3i9QF/3v1HC8O3VPQNJ5nxUgmG
 IPp/IjKwBcdqdRka39Y12k3k14tQuDN9Wt5fR7rswwRW5XUEaecMPaBdZJCnuThqu09dvBBL4x
 F8M=
X-IronPort-AV: E=Sophos;i="5.69,282,1571673600"; 
   d="scan'208";a="232250438"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 10:33:42 +0800
IronPort-SDR: PTCRpE45Omx0z4M8QhERvD0clPXcN+ZqIATvlQ7VDETZ86iEKGlxeI1Wq+43q8uRJGunN0lePd
 K89zAmmeEdM2jvZuN9bjWFXdXpDeYmKTyFRHTC89WudrmzEs13WNGeGCAg3AWzJhcgsinlV0P+
 n1Y1FOZWEIL9eoTeNt5JkNr4UHC/Rie+jNODaL6wd5elcuvzy6PIMKT/h15By/q5heumIy/KDC
 soPptRPGlyjFwFNFKtPTa1ekkzdnCn006LaVDiDRsVreTABDGZ/KmGdKv2IVaNLyFdzU1q5NbY
 f/zAjNPYhKCQHqxQuDk5OF2x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 18:28:05 -0800
IronPort-SDR: 1uVywYMCYS8oZsoD9gY5Fk7u9lTc0Bm8vFKGK4oFld57RoPB6F5srL4xkmacLIDCXgewFOCKFI
 8ahUQZCBoPzGuFm7oUSZihFKeyX6OQznPE6KG7aLOnE4d+xIhInyfLhALT3cm8VJXn+jWdtsGF
 l9ZrIvcKVXDlJtxq41PFE+TnJbkK2skho/2GZ+zV0o7YODXQIJP8qM0TknN6ZuG9oGas6/GhLX
 chph+Qp4OHDh4hs5mfqTU5e7wnJAOTjFHn6bPidZ8fO+uWRpYrY0/2FIGnEMGlboMcblrSh+CX
 BWE=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Dec 2019 18:33:42 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/sifive-plic: Add support for multiple PLICs
Date:   Thu,  5 Dec 2019 18:31:56 -0800
Message-Id: <20191206023156.24732-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current, PLIC driver can support only 1 PLIC on the board. However,
there can be multiple PLICs present on a two socket systems in RISC-V.

Modify the driver so that each PLIC handler can have a information
about individual PLIC registers and an irqdomain associated with it.

Tested on two socket RISC-V system based on VCU118 FPGA connected via
OmniXtend protocol.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 81 +++++++++++++++++++------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c72c036aea76..aea1f2f0f0d5 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -55,7 +55,11 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
-static void __iomem *plic_regs;
+struct plic_hw {
+	struct cpumask lmask;
+	struct irq_domain *irqdomain;
+	void __iomem *regs;
+};
 
 struct plic_handler {
 	bool			present;
@@ -66,6 +70,7 @@ struct plic_handler {
 	 */
 	raw_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
+	struct plic_hw		*hw;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
@@ -84,31 +89,40 @@ static inline void plic_toggle(struct plic_handler *handler,
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
-				   int hwirq, int enable)
+				   struct irq_data *d, int enable)
 {
 	int cpu;
+	struct plic_hw *hw = d->domain->host_data;
 
-	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	writel(enable, hw->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
-		if (handler->present)
-			plic_toggle(handler, hwirq, enable);
+		if (handler->present &&
+		    cpumask_test_cpu(cpu, &handler->hw->lmask))
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   cpu_online_mask);
+	struct cpumask amask;
+	unsigned int cpu;
+	struct plic_hw *hw = d->domain->host_data;
+
+	cpumask_and(&amask, &hw->lmask, cpu_online_mask);
+	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
+					   &amask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
 		return;
-	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	plic_irq_toggle(cpumask_of(cpu), d, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+	struct plic_hw *hw = d->domain->host_data;
+
+	plic_irq_toggle(&hw->lmask, d, 0);
 }
 
 #ifdef CONFIG_SMP
@@ -116,18 +130,22 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
+	struct cpumask amask;
+	struct plic_hw *hw = d->domain->host_data;
+
+	cpumask_and(&amask, &hw->lmask, mask_val);
 
 	if (force)
-		cpu = cpumask_first(mask_val);
+		cpu = cpumask_first(&amask);
 	else
-		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+		cpu = cpumask_any_and(&amask, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
 	if (!irqd_irq_disabled(d)) {
-		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
-		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+		plic_irq_toggle(&hw->lmask, d, 0);
+		plic_irq_toggle(cpumask_of(cpu), d, 1);
 	}
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
@@ -163,8 +181,6 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.xlate		= irq_domain_xlate_onecell,
 };
 
-static struct irq_domain *plic_irqdomain;
-
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -181,7 +197,7 @@ static void plic_handle_irq(struct pt_regs *regs)
 
 	csr_clear(sie, SIE_SEIE);
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(plic_irqdomain, hwirq);
+		int irq = irq_find_mapping(handler->hw->irqdomain, hwirq);
 
 		if (unlikely(irq <= 0))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
@@ -212,15 +228,17 @@ static int __init plic_init(struct device_node *node,
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
+	struct plic_hw *hw;
 
-	if (plic_regs) {
-		pr_warn("PLIC already present.\n");
-		return -ENXIO;
-	}
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
 
-	plic_regs = of_iomap(node, 0);
-	if (WARN_ON(!plic_regs))
-		return -EIO;
+	hw->regs = of_iomap(node, 0);
+	if (WARN_ON(!hw->regs)) {
+		error = -EIO;
+		goto out_freehw;
+	}
 
 	error = -EINVAL;
 	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
@@ -234,9 +252,9 @@ static int __init plic_init(struct device_node *node,
 		goto out_iounmap;
 
 	error = -ENOMEM;
-	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, NULL);
-	if (WARN_ON(!plic_irqdomain))
+	hw->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
+			&plic_irqdomain_ops, hw);
+	if (WARN_ON(!hw->irqdomain))
 		goto out_iounmap;
 
 	for (i = 0; i < nr_contexts; i++) {
@@ -279,13 +297,14 @@ static int __init plic_init(struct device_node *node,
 			goto done;
 		}
 
+		cpumask_set_cpu(cpu, &hw->lmask);
 		handler->present = true;
 		handler->hart_base =
-			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+			hw->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base =
-			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
-
+			hw->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->hw = hw;
 done:
 		/* priority must be > threshold to trigger an interrupt */
 		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
@@ -300,7 +319,9 @@ static int __init plic_init(struct device_node *node,
 	return 0;
 
 out_iounmap:
-	iounmap(plic_regs);
+	iounmap(hw->regs);
+out_freehw:
+	kfree(hw);
 	return error;
 }
 
-- 
2.24.0

