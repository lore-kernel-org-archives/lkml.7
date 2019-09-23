Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04556C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7E217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263205;
	bh=koHXnSQ/ffYHG+8C4SAhi8d08GLBDqZbfZNRMSjE+xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgIFHLPvxqrpbpf2dBj9aQDZhbVqGjRRzr37ZpDIzM8qHrn5l0x5LHjYrkk9Qxa0q
	 27aAmVKYetuim/pIe2lIQXtj8w0aibCV2ORqrC3Ola4RRhcgVbSC1ZRHIhPMgOHd9d
	 TSrOrBGrJAUXOcQo2K10bGrN0Da7qfXkLU4gfGeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440470AbfIWS0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:44 -0400
Received: from foss.arm.com ([217.140.110.172]:46682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438244AbfIWS0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E3DF15AB;
        Mon, 23 Sep 2019 11:26:43 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC8DD3F694;
        Mon, 23 Sep 2019 11:26:39 -0700 (PDT)
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
Subject: [PATCH 04/35] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
Date:   Mon, 23 Sep 2019 19:25:35 +0100
Message-Id: <20190923182606.32100-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
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
index 422664ac5f53..0b545e2c3498 100644
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
index 5cc10cf7cb3e..b34e0c113697 100644
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

