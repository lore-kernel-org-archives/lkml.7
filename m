Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C6C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8EC2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187685;
	bh=Qn4kBNjQ0fNCUPS0AaeuIqmPAPhub5F1N9gYFFF9zZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugNRb1w31xSNixbfW+7q1Ev2oMCeaHrUgj41hWhq/bOb+c3UI+Py1lz+PDyFmB4uR
	 koxxDCHm12+Bry/MYoC7LuCtsyepUsRudvySU4sr9jAjlh1UvTA1YHmgpp8bDppISC
	 oWuKoMVWxSf9Rj7ZdnrL5cx7vvwqr0YSfvg4Dco0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLXLlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:41:24 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35881 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbfLXLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:41:23 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5x-000169-CB; Tue, 24 Dec 2019 12:11:21 +0100
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
Subject: [PATCH v3 13/32] irqchip/gic-v4.1: Add VPE INVALL callback
Date:   Tue, 24 Dec 2019 11:10:36 +0000
Message-Id: <20191224111055.11836-14-maz@kernel.org>
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

GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
We can now emulate a guest-requested INVALL without emiting a
VINVALL command.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a5567d099a3e..403f5753e1ed 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3670,6 +3670,19 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 	}
 }
 
+static void its_vpe_4_1_invall(struct its_vpe *vpe)
+{
+	void __iomem *rdbase;
+	u64 val;
+
+	val  = GICR_INVALLR_V;
+	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
+
+	/* Target the redistributor this vPE is currently known on */
+	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVALLR);
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
@@ -3685,6 +3698,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 
 	case INVALL_VPE:
+		its_vpe_4_1_invall(vpe);
 		return 0;
 
 	default:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 1c91dede7663..37b14fb82773 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -249,6 +249,12 @@
 #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
 #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
+#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
+#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
+
+#define GICR_INVALLR_VPEID		GICR_INVLPIR_VPEID
+#define GICR_INVALLR_V			GICR_INVLPIR_V
+
 #define GIC_V3_REDIST_SIZE		0x20000
 
 #define LPI_PROP_GROUP1			(1 << 1)
-- 
2.20.1

