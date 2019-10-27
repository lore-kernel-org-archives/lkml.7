Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF20CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A166421D81
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187445;
	bh=CA+V3kafszvCceUU78xM+0W20S+ptHDqrXrmDcJtEwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LrIXeEv1ZAVExFyNb0OurOJkshW/J33C4v5Df9q9G/6/agXEpHz8xd2Cj5Ty0rA0X
	 0ex0utmjpXAboZzUJ0jPYN4wYNCF1ow5NR4d5yc6APhVXO45sivxJQpI8cB4mIG0dz
	 GPMpflZN2RJWsJSR+rYfLbf6YO8oAP8L5+jRJx9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfJ0OoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfJ0On4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:43:56 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2F7214AF;
        Sun, 27 Oct 2019 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187435;
        bh=CA+V3kafszvCceUU78xM+0W20S+ptHDqrXrmDcJtEwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPW71MfwQJvuMjNgpQR+ACqb6XGn2ae4zV+y4YRW5iiAi5NX8kgmg4DYzwwTvZTx1
         1bW89oezeoNk0kPywF5wV8svGegI48vOyPU4LaGG+Mv3vbFrULE63CZdiO5EqQTFnt
         bSHTYSa8dy8DDhcl+pHDn6c9SiIjDYOgkZ0QFXYo=
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
Subject: [PATCH v2 08/36] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
Date:   Sun, 27 Oct 2019 14:42:06 +0000
Message-Id: <20191027144234.8395-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICv4.1 supports the RVPEID ("Residency per vPE ID"), which allows for
a much efficient way of making virtual CPUs resident (to allow direct
injection of interrupts).

The functionnality needs to be discovered on each and every redistributor
in the system, and disabled if the settings are inconsistent.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 21 ++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1edc99335a94..4f20caf9bc88 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -849,8 +849,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
-	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+
+	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
+	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
+	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   gic_data.rdists.has_rvpeid);
+
+	/* Detect non-sensical configurations */
+	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
+		gic_data.rdists.has_direct_lpi = false;
+		gic_data.rdists.has_vlpis = false;
+		gic_data.rdists.has_rvpeid = false;
+	}
+
 	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
 
 	return 1;
@@ -863,9 +876,10 @@ static void gic_update_rdist_properties(void)
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
 	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	pr_info("%sVLPI support, %sdirect LPI support\n",
+	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
 		!gic_data.rdists.has_vlpis ? "no " : "",
-		!gic_data.rdists.has_direct_lpi ? "no " : "");
+		!gic_data.rdists.has_direct_lpi ? "no " : "",
+		!gic_data.rdists.has_rvpeid ? "no " : "");
 }
 
 /* Check whether it's single security state view */
@@ -1546,6 +1560,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b6514e8893bf..c98f34296599 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -234,6 +234,7 @@
 #define GICR_TYPER_VLPIS		(1U << 1)
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
+#define GICR_TYPER_RVPEID		(1U << 7)
 
 #define GIC_V3_REDIST_SIZE		0x20000
 
@@ -613,6 +614,7 @@ struct rdists {
 	u64			flags;
 	u32			gicd_typer;
 	bool			has_vlpis;
+	bool			has_rvpeid;
 	bool			has_direct_lpi;
 };
 
-- 
2.20.1

