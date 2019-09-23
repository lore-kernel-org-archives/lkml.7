Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F5C4CED0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263283;
	bh=kvcvpFCUDWTshYA+W9fJga2/rXqXR4bNeiddqyyXppg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=redHOXJSX4e2XSZ9hFjUp1JE1xpa5MIv2YtvhGroiqaQ2jQ8lBrvcT/qZ2dziV+Z2
	 ZCawhLY1c/fr9Nhq2TeEUH90x2QV9VtmLyVXo8yPk/LpdPVfNfhEPU3MmkbIVGAjC6
	 Hz1+ofN0mf+Eixe+ZoWub0ClcNed13R/JPIkBZ88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502412AbfIWS2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:28:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbfIWS16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF7422C8;
        Mon, 23 Sep 2019 11:27:57 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A8643F694;
        Mon, 23 Sep 2019 11:27:55 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 24/35] irqchip/gic-v4.1: Add initial SGI configuration
Date:   Mon, 23 Sep 2019 19:25:55 +0100
Message-Id: <20190923182606.32100-25-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv4.1 ITS has yet another new command (VSGI) which allows
a VPE-targeted SGI to be configured (or have its pending state
cleared). Add support for this command and plumb it into the
activate irqdomain callback so that it is ready to be used.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 88 ++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  3 +-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69c26be709be..5234b9eef8ad 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -314,6 +314,15 @@ struct its_cmd_desc {
 		struct {
 			struct its_vpe *vpe;
 		} its_invdb_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+			u8 sgi;
+			u8 priority;
+			bool enable;
+			bool group;
+			bool clear;
+		} its_vsgi_cmd;
 	};
 };
 
@@ -459,6 +468,31 @@ static void its_encode_db(struct its_cmd_block *cmd, bool db)
 	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
 }
 
+static void its_encode_sgi_intid(struct its_cmd_block *cmd, u8 sgi)
+{
+	its_mask_encode(&cmd->raw_cmd[0], sgi, 35, 32);
+}
+
+static void its_encode_sgi_priority(struct its_cmd_block *cmd, u8 prio)
+{
+	its_mask_encode(&cmd->raw_cmd[0], prio >> 4, 23, 20);
+}
+
+static void its_encode_sgi_group(struct its_cmd_block *cmd, bool grp)
+{
+	its_mask_encode(&cmd->raw_cmd[0], grp, 10, 10);
+}
+
+static void its_encode_sgi_clear(struct its_cmd_block *cmd, bool clr)
+{
+	its_mask_encode(&cmd->raw_cmd[0], clr, 9, 9);
+}
+
+static void its_encode_sgi_enable(struct its_cmd_block *cmd, bool en)
+{
+	its_mask_encode(&cmd->raw_cmd[0], en, 8, 8);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -770,6 +804,26 @@ static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_invdb_cmd.vpe);
 }
 
+static struct its_vpe *its_build_vsgi_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_VSGI);
+	its_encode_vpeid(cmd, desc->its_vsgi_cmd.vpe->vpe_id);
+	its_encode_sgi_intid(cmd, desc->its_vsgi_cmd.sgi);
+	its_encode_sgi_priority(cmd, desc->its_vsgi_cmd.priority);
+	its_encode_sgi_group(cmd, desc->its_vsgi_cmd.group);
+	its_encode_sgi_clear(cmd, desc->its_vsgi_cmd.clear);
+	its_encode_sgi_enable(cmd, desc->its_vsgi_cmd.enable);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_vsgi_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -3574,6 +3628,38 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
 };
 
+static struct its_node *find_4_1_its(void)
+{
+	static struct its_node *its = NULL;
+
+	if (!its) {
+		list_for_each_entry(its, &its_nodes, entry) {
+			if (is_v4_1(its))
+				return its;
+		}
+
+		/* Oops? */
+		its = NULL;
+	}
+
+	return its;
+}
+
+static void its_configure_sgi(struct irq_data *d, bool clear)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_desc desc;
+
+	desc.its_vsgi_cmd.vpe = vpe;
+	desc.its_vsgi_cmd.sgi = d->hwirq;
+	desc.its_vsgi_cmd.priority = vpe->sgi_config[d->hwirq].priority;
+	desc.its_vsgi_cmd.enable = vpe->sgi_config[d->hwirq].enabled;
+	desc.its_vsgi_cmd.group = vpe->sgi_config[d->hwirq].group;
+	desc.its_vsgi_cmd.clear = clear;
+
+	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3619,6 +3705,8 @@ static void its_sgi_irq_domain_free(struct irq_domain *domain,
 static int its_sgi_irq_domain_activate(struct irq_domain *domain,
 				       struct irq_data *d, bool reserve)
 {
+	/* Write out the initial SGI configuration */
+	its_configure_sgi(d, false);
 	return 0;
 }
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 5f3278cbf247..c73176d3ab2b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -497,8 +497,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
+/* VMOVP, VSGI and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_VSGI			GITS_CMD_GICv4(3)
 #define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
-- 
2.20.1

