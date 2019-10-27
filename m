Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451F121E6F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187511;
	bh=G89DNts1Mk+ZkFZ1zrEi0DKxHIKypo53heYw+LgA7vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjIpz4cBhUTOt5Yf7694tPZsIIZCw4UMYoQDOLB4iJ8NK6Vxr5f+QX3HRj6qLPFd5
	 C0UAg0mrnw9SaDU78SlRu2swgWcdMIgroCgRkf6PwA/8kZfAAEwOFRIBydFyF589vo
	 mktU6yXEmUFfezjxMGcCn4BCEc/8ugkSKTD4YYwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfJ0OpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfJ0OpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:45:09 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A261E21850;
        Sun, 27 Oct 2019 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187509;
        bh=G89DNts1Mk+ZkFZ1zrEi0DKxHIKypo53heYw+LgA7vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjPTFRunxrGQwBJo0ZIv4wKHz2LQqkPC6bEOFh8gA2tyZ86uJIfSXkBNFpL8epMjw
         KI7kfgRp11gWDC+WwO77kgKtTtYKdAhSrLkYLh2N2nm6Uc1UoOAKGU6EQBhdZ6CGg9
         6377i9zzzw0TTqWGR95PwUm6I8XxnaeFwVW6na4o=
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
Subject: [PATCH v2 19/36] irqchip/gic-v4.1: Add VPE INVALL callback
Date:   Sun, 27 Oct 2019 14:42:17 +0000
Message-Id: <20191027144234.8395-20-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
We can now emulate a guest-requested INVALL without emiting a
VINVALL command.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f7effd453729..10bd156aa042 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3511,6 +3511,19 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 	}
 }
 
+static void its_vpe_4_1_invall(struct its_vpe *vpe)
+{
+	void __iomem *rdbase;
+	u64 val;
+
+	val  = GICR_INVLPIR_V;
+	val |= FIELD_PREP(GICR_INVLPIR_VPEID, vpe->vpe_id);
+
+	/* Target the redistributor this vPE is currently known on */
+	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVALLR);
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
@@ -3526,6 +3539,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 
 	case INVALL_VPE:
+		its_vpe_4_1_invall(vpe);
 		return 0;
 
 	default:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6fd89d77b2b2..b69f60792554 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -247,6 +247,9 @@
 #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
 #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
+#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
+#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
+
 #define GIC_V3_REDIST_SIZE		0x20000
 
 #define LPI_PROP_GROUP1			(1 << 1)
-- 
2.20.1

