Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E295FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E3621D81
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187448;
	bh=Ni6NIHsMM/HWqSCNNX1TVuua4AhngVWRe0mb0ZXGDjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cHvEgNyuLiXhYHgIBIQkxKcuC92m0Ew+E6Aeqp8/mTB/LZOC+9uCmTT502PDXOnuy
	 ib4NzbQfy5PEbyLFXa2kFGccw7ZoIElCPNFv0MM+NyEVFco5DfF9XQzv6bijBO3n9y
	 rhOgU3CM3uj1gKhdFkAWqHQtDNZW648Ko0D3Mag8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfJ0OoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfJ0OoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:44:04 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991B521E6F;
        Sun, 27 Oct 2019 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187443;
        bh=Ni6NIHsMM/HWqSCNNX1TVuua4AhngVWRe0mb0ZXGDjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kn6A/UivDt4oNDEH6S8BSpk+Lk4ziwCkDgHX9qJHspn9GwDM2TdAaIyf2rRLQH+Xv
         BsDY7s6O0IpmYtRJhsbugIGIjm+MnHVDke7Fau7BhTrdrl9PevZsF7kRh2pi7beS0c
         l28gY0hwKhbMzLP/y8sdmedB3W4eXAYinq2aaHto=
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
Subject: [PATCH v2 09/36] irqchip/gic-v3: Add GICv4.1 VPEID size discovery
Date:   Sun, 27 Oct 2019 14:42:07 +0000
Message-Id: <20191027144234.8395-10-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While GICv4.0 mandates 16 bit worth of VPEIDs, GICv4.1 allows smaller
implementations to be built. Add the required glue to dynamically
compute the limit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 11 ++++++++++-
 drivers/irqchip/irq-gic-v3.c       |  3 +++
 include/linux/irqchip/arm-gic-v3.h |  5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 94c9c2e9f917..40912b3fb0e1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -121,7 +121,16 @@ struct its_node {
 #define ITS_ITT_ALIGN		SZ_256
 
 /* The maximum number of VPEID bits supported by VLPI commands */
-#define ITS_MAX_VPEID_BITS	(16)
+#define ITS_MAX_VPEID_BITS						\
+	({								\
+		int nvpeid = 16;					\
+		if (gic_rdists->has_rvpeid &&				\
+		    gic_rdists->gicd_typer2 & GICD_TYPER2_VIL)		\
+			nvpeid = 1 + (gic_rdists->gicd_typer2 &		\
+				      GICD_TYPER2_VID);			\
+									\
+		nvpeid;							\
+	})
 #define ITS_MAX_VPEID		(1 << (ITS_MAX_VPEID_BITS))
 
 /* Convert page order to size in bytes */
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4f20caf9bc88..50538709bd49 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1556,6 +1556,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
+
+	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
+
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c98f34296599..8c6be56da7e9 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -13,6 +13,7 @@
 #define GICD_CTLR			0x0000
 #define GICD_TYPER			0x0004
 #define GICD_IIDR			0x0008
+#define GICD_TYPER2			0x000C
 #define GICD_STATUSR			0x0010
 #define GICD_SETSPI_NSR			0x0040
 #define GICD_CLRSPI_NSR			0x0048
@@ -89,6 +90,9 @@
 #define GICD_TYPER_ESPIS(typer)						\
 	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
+#define GICD_TYPER2_VIL			(1U << 7)
+#define GICD_TYPER2_VID			GENMASK(4, 0)
+
 #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
 #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
 
@@ -613,6 +617,7 @@ struct rdists {
 	void			*prop_table_va;
 	u64			flags;
 	u32			gicd_typer;
+	u32			gicd_typer2;
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
-- 
2.20.1

