Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EF8CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAA222BE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfJ0Grq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:47:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40934 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfJ0Grq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:47:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iOcL2-0002pV-8d; Sun, 27 Oct 2019 07:47:44 +0100
Date:   Sun, 27 Oct 2019 06:46:26 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.4-rc5
Message-ID: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  1486b7b42bd7: Merge tag 'irqchip-fixes-5.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Two fixes for interrupt controller drivers:

 - Skip IRQ_M_EXT entries in the device tree when initializing the
   RISCV PLIC controller to avoid an double init attempt.

 - Use the correct ITS list when issuing the VMOVP synchronization
   command so the operation works only on the ITS instances which
   are associated to a VM.

Thanks,

	tglx

------------------>
Alan Mikhak (1):
      irqchip/sifive-plic: Skip contexts except supervisor in plic_init()

Zenghui Yu (1):
      irqchip/gic-v3-its: Use the exact ITSList for VMOVP


 drivers/irqchip/irq-gic-v3-its.c  | 21 ++++++++++++++++++---
 drivers/irqchip/irq-sifive-plic.c |  4 ++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 62e54f1a248b..787e8eec9a7f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -175,6 +175,22 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+static u16 get_its_list(struct its_vm *vm)
+{
+	struct its_node *its;
+	unsigned long its_list = 0;
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (!its->is_v4)
+			continue;
+
+		if (vm->vlpi_count[its->list_nr])
+			__set_bit(its->list_nr, &its_list);
+	}
+
+	return (u16)its_list;
+}
+
 static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 					       u32 event)
 {
@@ -976,17 +992,15 @@ static void its_send_vmapp(struct its_node *its,
 
 static void its_send_vmovp(struct its_vpe *vpe)
 {
-	struct its_cmd_desc desc;
+	struct its_cmd_desc desc = {};
 	struct its_node *its;
 	unsigned long flags;
 	int col_id = vpe->col_idx;
 
 	desc.its_vmovp_cmd.vpe = vpe;
-	desc.its_vmovp_cmd.its_list = (u16)its_list_map;
 
 	if (!its_list_map) {
 		its = list_first_entry(&its_nodes, struct its_node, entry);
-		desc.its_vmovp_cmd.seq_num = 0;
 		desc.its_vmovp_cmd.col = &its->collections[col_id];
 		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
 		return;
@@ -1003,6 +1017,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	raw_spin_lock_irqsave(&vmovp_lock, flags);
 
 	desc.its_vmovp_cmd.seq_num = vmovp_seq_num++;
+	desc.its_vmovp_cmd.its_list = get_its_list(vpe->its_vm);
 
 	/* Emit VMOVPs */
 	list_for_each_entry(its, &its_nodes, entry) {
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index daefc52b0ec5..7d0a12fe2714 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,8 +252,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* skip context holes */
-		if (parent.args[0] == -1)
+		/* skip contexts other than supervisor external interrupt */
+		if (parent.args[0] != IRQ_S_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);


