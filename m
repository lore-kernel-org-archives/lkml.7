Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D9C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60DE21906
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263249;
	bh=9HgZ4b1uk8NqRnLSuC6fmeaXZRBBq4+NUKoeQvbsMqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGqPoj6cqbSMk5P/A5xJ970wJbzVKx/EfcLhFMETKZH+Py63ql9Egk+vwT0IEcaYP
	 kwxxrIbnMLwe/c3y7iRqgvGGtdzgmqw0m4IsPEOqD+Ee4r9MS2o9YROGiJO8VSiqSF
	 XoH5IWgqbWtAc1EnsmTYZgLF9R5H7EL5djErrMH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502353AbfIWS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfIWS11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B641B96;
        Mon, 23 Sep 2019 11:27:26 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87183F694;
        Mon, 23 Sep 2019 11:27:22 -0700 (PDT)
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
Subject: [PATCH 16/35] irqchip/gic-v4.1: Add VPE residency callback
Date:   Mon, 23 Sep 2019 19:25:47 +0100
Message-Id: <20190923182606.32100-17-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making a VPE resident on GICv4.1 is pretty simple, as it is just a
single write to the local redistributor. We just need extra information
about which groups to enable, which the KVM code will have to provide.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 17 +++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  9 +++++++++
 include/linux/irqchip/arm-gic-v4.h |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 36653db372bc..72d80daa7230 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3461,12 +3461,29 @@ static void its_vpe_4_1_unmask_irq(struct irq_data *d)
 	its_vpe_4_1_send_inv(d);
 }
 
+static void its_vpe_4_1_schedule(struct its_vpe *vpe,
+				 struct its_cmd_info *info)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val = 0;
+
+	/* Schedule the VPE */
+	val |= GICR_VPENDBASER_Valid;
+	val |= info->g0en ? GICR_VPENDBASER_4_1_VGRP0EN : 0;
+	val |= info->g1en ? GICR_VPENDBASER_4_1_VGRP1EN : 0;
+	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
+
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	struct its_cmd_info *info = vcpu_info;
 
 	switch (info->cmd_type) {
 	case SCHEDULE_VPE:
+		its_vpe_4_1_schedule(vpe, info);
 		return 0;
 
 	case DESCHEDULE_VPE:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8157737053e4..6fd89d77b2b2 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -327,6 +327,15 @@
 #define GICR_VPENDBASER_IDAI		(1ULL << 62)
 #define GICR_VPENDBASER_Valid		(1ULL << 63)
 
+/*
+ * GICv4.1 VPENDBASER, used for VPE residency. On top of these fields,
+ * also use the above Valid, PendingLast and Dirty.
+ */
+#define GICR_VPENDBASER_4_1_DB		(1ULL << 62)
+#define GICR_VPENDBASER_4_1_VGRP0EN	(1ULL << 59)
+#define GICR_VPENDBASER_4_1_VGRP1EN	(1ULL << 58)
+#define GICR_VPENDBASER_4_1_VPEID	GENMASK_ULL(15, 0)
+
 /*
  * ITS registers, offsets from ITS_base
  */
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 6213ced6f199..edbaa37fd3f1 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -98,6 +98,11 @@ struct its_cmd_info {
 	union {
 		struct its_vlpi_map	*map;
 		u8			config;
+		bool			req_db;
+		struct {
+			bool		g0en;
+			bool		g1en;
+		};
 	};
 };
 
-- 
2.20.1

