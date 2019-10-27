Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0449321850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187480;
	bh=6XNF8jWODx1Z4LypBV9fu+//iIbE0ymL/lgUUlP+q7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BeHcx6PTyvyg1PespsneXNs1XOgg0/rISjbGfl9AdbRqcMjE42ODsqJBZoqqJKqs8
	 5f5X1KqGGNtiZoo9xhOhT5qEB6J1JCOIB48EUbnAzgGS7is7S3+sNAwgGe7coWxzX1
	 IfebCVBJ4h+eVSZPBWLq7x3ILhQ4sePt94uUSKq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJ0Ooi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfJ0Ooi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:44:38 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E0421D7F;
        Sun, 27 Oct 2019 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187477;
        bh=6XNF8jWODx1Z4LypBV9fu+//iIbE0ymL/lgUUlP+q7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0s2KhOX59R1aURaXT2QO720WXrqrtXo2jVeMBGuPm9IgVbREMY5RwwmBH6WkaOhq
         /xYl19mKp5eOlN7UATrI5/fYzfyMJpq72+EVoIWIVes+pL8+WF7HWGEZ+08HsV85XL
         D5mm7gcsCTxMZyEaGOkNdHxSz2Nrda88uKrQG95o=
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
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 14/36] irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
Date:   Sun, 27 Oct 2019 14:42:12 +0000
Message-Id: <20191027144234.8395-15-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With GICv4.1, VMOVP is extended to allow a default doorbell to be
specified, as well as a validity bit for this doorbell. As an added
bonus, VMOPVP isn't required anymore of moving a VPE between
redistributors that share the same affinity.

Let's add this support to the VMOVP builder, and make sure we don't
issuer the command if we don't really need to.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 40 ++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 999e61a9b2c3..b5a122093a46 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -443,6 +443,17 @@ static void its_encode_vmapp_default_db(struct its_cmd_block *cmd,
 	its_mask_encode(&cmd->raw_cmd[1], vpe_db_lpi, 31, 0);
 }
 
+static void its_encode_vmovp_default_db(struct its_cmd_block *cmd,
+					u32 vpe_db_lpi)
+{
+	its_mask_encode(&cmd->raw_cmd[3], vpe_db_lpi, 31, 0);
+}
+
+static void its_encode_db(struct its_cmd_block *cmd, bool db)
+{
+	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -729,6 +740,11 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	its_encode_vpeid(cmd, desc->its_vmovp_cmd.vpe->vpe_id);
 	its_encode_target(cmd, target);
 
+	if (is_v4_1(its)) {
+		its_encode_db(cmd, true);
+		its_encode_vmovp_default_db(cmd, desc->its_vmovp_cmd.vpe->vpe_db_lpi);
+	}
+
 	its_fixup_cmd(cmd);
 
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
@@ -3182,7 +3198,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int cpu = cpumask_first(mask_val);
+	int from, cpu = cpumask_first(mask_val);
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3190,14 +3206,24 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * into the proxy device, we need to move the doorbell
 	 * interrupt to its new location.
 	 */
-	if (vpe->col_idx != cpu) {
-		int from = vpe->col_idx;
+	if (vpe->col_idx == cpu)
+		goto out;
 
-		vpe->col_idx = cpu;
-		its_send_vmovp(vpe);
-		its_vpe_db_proxy_move(vpe, from, cpu);
-	}
+	from = vpe->col_idx;
+	vpe->col_idx = cpu;
+
+	/*
+	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
+	 * is sharing its VPE table with the current one.
+	 */
+	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
+	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+		goto out;
 
+	its_send_vmovp(vpe);
+	its_vpe_db_proxy_move(vpe, from, cpu);
+
+out:
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK_DONE;
-- 
2.20.1

