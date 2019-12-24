Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD11C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0747720706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577185905;
	bh=jcWGtZtPugurt89Pb/6YGPZeaM+9A2ohuE+B61VkvUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YsO9VXH6rkcGmuQ0dJ3KYtKZo+gW6Eb7B7zUgWVMzAKHZGaHKY0PRNH3iKEbRuOFQ
	 Pj5N/ApW0ZRMDI7M30tp1GnhERXynzSeCBOKwrcJ0b7URXVbRA9/sz6YCaibCAvOkl
	 UcuheHjYMGuQj4rDEAUgWY5bdcbH5FM2u15vPuSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLXLLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:11:44 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52742 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbfLXLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:11:16 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5p-000169-UR; Tue, 24 Dec 2019 12:11:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 06/32] irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP
Date:   Tue, 24 Dec 2019 11:10:29 +0000
Message-Id: <20191224111055.11836-7-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ITS VMAPP command gains some new fields with GICv4.1:
- a default doorbell, which allows a single doorbell to be used for
  all the VLPIs routed to a given VPE
- a pointer to the configuration table (instead of having it in a register
  that gets context switched)
- a flag indicating whether this is the first map or the last unmap for
  this particular VPE
- a flag indicating whether the pending table is known to be zeroed, or not

Plumb in the new fields in the VMAPP builder, and add the map/unmap
refcounting so that the ITS can do the right thing.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 60 +++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic-v4.h | 18 +++++++--
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 15dea531c34f..e3c7d9ae0bdb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -450,6 +450,27 @@ static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
 	its_mask_encode(&cmd->raw_cmd[3], vpt_size, 4, 0);
 }
 
+static void its_encode_vconf_addr(struct its_cmd_block *cmd, u64 vconf_pa)
+{
+	its_mask_encode(&cmd->raw_cmd[0], vconf_pa >> 16, 51, 16);
+}
+
+static void its_encode_alloc(struct its_cmd_block *cmd, bool alloc)
+{
+	its_mask_encode(&cmd->raw_cmd[0], alloc, 8, 8);
+}
+
+static void its_encode_ptz(struct its_cmd_block *cmd, bool ptz)
+{
+	its_mask_encode(&cmd->raw_cmd[0], ptz, 9, 9);
+}
+
+static void its_encode_vmapp_default_db(struct its_cmd_block *cmd,
+					u32 vpe_db_lpi)
+{
+	its_mask_encode(&cmd->raw_cmd[1], vpe_db_lpi, 31, 0);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -633,19 +654,45 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 					   struct its_cmd_block *cmd,
 					   struct its_cmd_desc *desc)
 {
-	unsigned long vpt_addr;
+	unsigned long vpt_addr, vconf_addr;
 	u64 target;
-
-	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
-	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
+	bool alloc;
 
 	its_encode_cmd(cmd, GITS_CMD_VMAPP);
 	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
 	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
+
+	if (!desc->its_vmapp_cmd.valid) {
+		if (is_v4_1(its)) {
+			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
+			its_encode_alloc(cmd, alloc);
+		}
+
+		goto out;
+	}
+
+	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
+	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
+
 	its_encode_target(cmd, target);
 	its_encode_vpt_addr(cmd, vpt_addr);
 	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
 
+	if (!is_v4_1(its))
+		goto out;
+
+	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
+
+	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
+
+	its_encode_alloc(cmd, alloc);
+
+	/* We can only signal PTZ when alloc==1. Why do we have two bits? */
+	its_encode_ptz(cmd, alloc);
+	its_encode_vconf_addr(cmd, vconf_addr);
+	its_encode_vmapp_default_db(cmd, desc->its_vmapp_cmd.vpe->vpe_db_lpi);
+
+out:
 	its_fixup_cmd(cmd);
 
 	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
@@ -3493,7 +3540,10 @@ static int its_vpe_init(struct its_vpe *vpe)
 
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
-	vpe->vpe_proxy_event = -1;
+	if (gic_rdists->has_rvpeid)
+		atomic_set(&vpe->vmapp_count, 0);
+	else
+		vpe->vpe_proxy_event = -1;
 
 	return 0;
 }
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 5dbcfc65f21e..498e523085a7 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -39,8 +39,20 @@ struct its_vpe {
 	irq_hw_number_t		vpe_db_lpi;
 	/* VPE resident */
 	bool			resident;
-	/* VPE proxy mapping */
-	int			vpe_proxy_event;
+	union {
+		/* GICv4.0 implementations */
+		struct {
+			/* VPE proxy mapping */
+			int	vpe_proxy_event;
+			/* Implementation Defined Area Invalid */
+			bool	idai;
+		};
+		/* GICv4.1 implementations */
+		struct {
+			atomic_t vmapp_count;
+		};
+	};
+
 	/*
 	 * This collection ID is used to indirect the target
 	 * redistributor for this VPE. The ID itself isn't involved in
@@ -49,8 +61,6 @@ struct its_vpe {
 	u16			col_idx;
 	/* Unique (system-wide) VPE identifier */
 	u16			vpe_id;
-	/* Implementation Defined Area Invalid */
-	bool			idai;
 	/* Pending VLPIs on schedule out? */
 	bool			pending_last;
 };
-- 
2.20.1

