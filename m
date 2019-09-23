Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C5C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D820A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263237;
	bh=17VNQLR4oCo28FHeLecTVSRCwYV4/56X+yMpbZxKO5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+8ikzg73VSMj0Wf0DbqKvO+fp8w/qs3KD9d+WlrwnSBKK7guutiYlXe3Yu+v9EnP
	 QaQVF/RcC8tEWtucgYysTlpN2EZEmyIXllPYCRFDUqIWeNKa/yZmMChEyG7ov3hmPq
	 rwfis0hpUmQRNG/TF5nbU6U+kDKPwtLJ1Ca+K3vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502322AbfIWS1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:17 -0400
Received: from foss.arm.com ([217.140.110.172]:46864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502300AbfIWS1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28BF619BF;
        Mon, 23 Sep 2019 11:27:15 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7400A3F694;
        Mon, 23 Sep 2019 11:27:11 -0700 (PDT)
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
Subject: [PATCH 13/35] irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
Date:   Mon, 23 Sep 2019 19:25:44 +0100
Message-Id: <20190923182606.32100-14-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
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
index a9976bc81d9a..c71aa0046bf0 100644
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
@@ -3178,7 +3194,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int cpu = cpumask_first(mask_val);
+	int from, cpu = cpumask_first(mask_val);
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3186,14 +3202,24 @@ static int its_vpe_set_affinity(struct irq_data *d,
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

