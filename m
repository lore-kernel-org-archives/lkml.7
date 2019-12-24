Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA151C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5220409
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577185896;
	bh=vSSkuV3Fq0czstyhdYZ46KexTxIWvB2PSMc7rJ4OToA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZ7uNtUU3M4s/qkN6XOAIIBb94x+dJGPD6Ng9Amt+GAxCGtO8dsgQl/WmDWVJfET8
	 GGpWvx6JuUHxoYadjJNmpe1DstvJgpc3SDX5BjO5IfZZrirnIQPA5L+CQlVzAENezT
	 jVOdJJKi9tRQrfdZN6yvgKVhyyzmJkEkrdPPsI8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLXLLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:11:17 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39650 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfLXLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:11:14 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5o-000169-J4; Tue, 24 Dec 2019 12:11:12 +0100
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
Subject: [PATCH v3 04/32] irqchip/gic-v3: Use SGIs without active state if offered
Date:   Tue, 24 Dec 2019 11:10:27 +0000
Message-Id: <20191224111055.11836-5-maz@kernel.org>
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

If running under control of a hypervisor that implements GICv4.1
SGIs, allow the hypervisor to use them at the expense of loosing
the Active state (which we don't care about for SGIs).

This is trivially done by checking for GICD_TYPER2.nASSGIcap, and
setting GICD_CTLR.nASSGIreq when enabling Group-1 interrupts.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 10 ++++++++--
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 640d4db65b78..624f351c0362 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -724,6 +724,7 @@ static void __init gic_dist_init(void)
 	unsigned int i;
 	u64 affinity;
 	void __iomem *base = gic_data.dist_base;
+	u32 val;
 
 	/* Disable the distributor */
 	writel_relaxed(0, base + GICD_CTLR);
@@ -756,9 +757,14 @@ static void __init gic_dist_init(void)
 	/* Now do the common stuff, and wait for the distributor to drain */
 	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
 
+	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
+	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
+		pr_info("Enabling SGIs without active state\n");
+		val |= GICD_CTLR_nASSGIreq;
+	}
+
 	/* Enable distributor with ARE, Group1 */
-	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
-		       base + GICD_CTLR);
+	writel_relaxed(val, base + GICD_CTLR);
 
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9dfe64189d99..72b69f4e6c7b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -57,6 +57,7 @@
 #define GICD_SPENDSGIR			0x0F20
 
 #define GICD_CTLR_RWP			(1U << 31)
+#define GICD_CTLR_nASSGIreq		(1U << 8)
 #define GICD_CTLR_DS			(1U << 6)
 #define GICD_CTLR_ARE_NS		(1U << 4)
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
@@ -90,6 +91,7 @@
 #define GICD_TYPER_ESPIS(typer)						\
 	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
+#define GICD_TYPER2_nASSGIcap		(1U << 8)
 #define GICD_TYPER2_VIL			(1U << 7)
 #define GICD_TYPER2_VID			GENMASK(4, 0)
 
-- 
2.20.1

