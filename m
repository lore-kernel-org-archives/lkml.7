Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9431ACA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7674321D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504440AbfJYMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:30:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37677 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436494AbfJYMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:30:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNyjP-00072X-DR; Fri, 25 Oct 2019 14:30:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 151DA1C03AB;
        Fri, 25 Oct 2019 14:30:15 +0200 (CEST)
Date:   Fri, 25 Oct 2019 12:30:14 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Use the exact ITSList for VMOVP
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571802386-2680-1-git-send-email-yuzenghui@huawei.com>
References: <1571802386-2680-1-git-send-email-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <157200661481.29376.15373625289556053248.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8424312516e5d9baeeb0a95d0e4523579b7aa395
Gitweb:        https://git.kernel.org/tip/8424312516e5d9baeeb0a95d0e4523579b7aa395
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 23 Oct 2019 03:46:26 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 24 Oct 2019 18:02:53 +01:00

irqchip/gic-v3-its: Use the exact ITSList for VMOVP

On a system without Single VMOVP support (say GITS_TYPER.VMOVP == 0),
we will map vPEs only on ITSs that will actually control interrupts
for the given VM.  And when moving a vPE, the VMOVP command will be
issued only for those ITSs.

But when issuing VMOVPs we seemed fail to present the exact ITSList
to ITSs who are actually included in the synchronization operation.
The its_list_map we're currently using includes all ITSs in the system,
even though some of them don't have the corresponding vPE mapping at all.

Introduce get_its_list() to get the per-VM its_list_map, to indicate
which ITSs have vPE mappings for the given VM, and use this map as
the expected ITSList when building VMOVP. This is hopefully a performance
gain not to do some synchronization with those unsuspecting ITSs.
And initialize the whole command descriptor to zero at beginning, since
the seq_num and its_list should be RES0 when GITS_TYPER.VMOVP == 1.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1571802386-2680-1-git-send-email-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 62e54f1..787e8ee 100644
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
