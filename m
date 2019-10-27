Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784CDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E509222BD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187497;
	bh=eJ5elfNt9kSk/t4uztnAcka0aHLuBmFWPvPCbMpqtMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=boMfUIwJtfA0nL92aLOzEUeIoOlSheSq3LsH7HP0bRPd392SN/A1Dlo4AJQvB+Ds/
	 70/Z+r+juHOIgeA3OnKDxEYXpVDDtWFa35mvZ47i4BOTAFE/yJ2BGumFt2dHaaL6uV
	 mxtLV16DzKp8bvnrFMXPtb34nRR3Ir0qapRAHuLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfJ0Oo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfJ0Ooz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:44:55 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D7521D7F;
        Sun, 27 Oct 2019 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187494;
        bh=eJ5elfNt9kSk/t4uztnAcka0aHLuBmFWPvPCbMpqtMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXov28peb4WjkjuX67J7eAIECXPKuSWa6p2Z4T8X+xiNtBc8FTdkoIIUu7cOJ+YLH
         4sThy+poCnLrhEkF9wVuN3odojl6p9P6MXRt5jwTpn8BlrJ25v6DwVbzS8uiVJRqnp
         MFuw9MMp1DQpE5RnnnBndCNnhNoSV1W8OgIf4IEw=
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
Subject: [PATCH v2 17/36] irqchip/gic-v4.1: Add VPE residency callback
Date:   Sun, 27 Oct 2019 14:42:15 +0000
Message-Id: <20191027144234.8395-18-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
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
index 3c34bef70bdd..d45e9b4e5622 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3466,12 +3466,29 @@ static void its_vpe_4_1_unmask_irq(struct irq_data *d)
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

