Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C209BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057E20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367557;
	bh=BPDmHPMQIa6sDO4bI9XpiWcpwI1jnVTDXSDb0FhOTXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpB7cwC818carp5p0EISe5ykS9PiuOW0egVI45SOwaJw4I+WdgCwSikbHv+Qr0d/1
	 dwTOj48hAWfEj0eKyHtpB4FpkqGDc3gd3cyBnu7mfPgHBfBcpPhIH0WLkVNx2+8slQ
	 J602hAqM9qWkR7TLhrMnQ+PKIKZBrywa0CiDxoMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfB1PLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbfB1PLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5526218D9;
        Thu, 28 Feb 2019 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366706;
        bh=BPDmHPMQIa6sDO4bI9XpiWcpwI1jnVTDXSDb0FhOTXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Ac+ZX/BX2LrBQDYXxZ6IoFJjSXywHL3ILVgb0JSSc3XSIIyJIUJ7N2JZMoQ9QypV
         3kF+zgl4dib22OI9Uc1ApHOxNC+Mex6eLdWYaEDmGz6jp8usuc1Tp0JkomwV1nEuTe
         +xEhyFBVdQ4qP87gyuVJnyzzCjr18+pXCueITYEE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/64] irqchip/gic-v4: Fix occasional VLPI drop
Date:   Thu, 28 Feb 2019 10:10:22 -0500
Message-Id: <20190228151105.11277-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heyi Guo <guoheyi@huawei.com>

[ Upstream commit 6479450f72c1391c03f08affe0d0110f41ae7ca0 ]

1. In current implementation, every VLPI will temporarily be mapped to
the first CPU in system (normally CPU0) and then moved to the real
scheduled CPU later.

2. So there is a time window and a VLPI may be sent to CPU0 instead of
the real scheduled vCPU, in a multi-CPU virtual machine.

3. However, CPU0 may have not been scheduled as a virtual CPU after
system boots up, so the value of its GICR_VPROPBASER is unknown at
that moment.

4. If the INTID of VLPI is larger than 2^(GICR_VPROPBASER.IDbits+1),
while IDbits is also in unknown state, GIC will behave as if the VLPI
is out of range and simply drop it, which results in interrupt missing
in Guest.

As no code will clear GICR_VPROPBASER at runtime, we can safely
initialize the IDbits field at boot time for each CPU to get rid of
this issue.

We also clear Valid bit of GICR_VPENDBASER in case any ancient
programming gets left in and causes memory corrupting. A new function
its_clear_vpend_valid() is added to reuse the code in
its_vpe_deschedule().

Fixes: e643d8034036 ("irqchip/gic-v3-its: Add VPE scheduling")
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 66 ++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4c2246fe5dbe9..d9a8801083156 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1951,6 +1951,29 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+{
+	u32 count = 1000000;	/* 1s! */
+	bool clean;
+	u64 val;
+
+	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val &= ~GICR_VPENDBASER_Valid;
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	do {
+		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		clean = !(val & GICR_VPENDBASER_Dirty);
+		if (!clean) {
+			count--;
+			cpu_relax();
+			udelay(1);
+		}
+	} while (!clean && count);
+
+	return val;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -2024,6 +2047,30 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+	if (gic_rdists->has_vlpis) {
+		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+
+		/*
+		 * It's possible for CPU to receive VLPIs before it is
+		 * sheduled as a vPE, especially for the first CPU, and the
+		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
+		 * as out of range and dropped by GIC.
+		 * So we initialize IDbits to known value to avoid VLPI drop.
+		 */
+		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
+		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
+			smp_processor_id(), val);
+		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+
+		/*
+		 * Also clear Valid bit of GICR_VPENDBASER, in case some
+		 * ancient programming gets left in and has possibility of
+		 * corrupting memory.
+		 */
+		val = its_clear_vpend_valid(vlpi_base);
+		WARN_ON(val & GICR_VPENDBASER_Dirty);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 }
@@ -2644,26 +2691,11 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
-	u32 count = 1000000;	/* 1s! */
-	bool clean;
 	u64 val;
 
-	/* We're being scheduled out */
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &= ~GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
-	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-		clean = !(val & GICR_VPENDBASER_Dirty);
-		if (!clean) {
-			count--;
-			cpu_relax();
-			udelay(1);
-		}
-	} while (!clean && count);
+	val = its_clear_vpend_valid(vlpi_base);
 
-	if (unlikely(!clean && !count)) {
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
 		vpe->idai = false;
 		vpe->pending_last = true;
-- 
2.19.1

