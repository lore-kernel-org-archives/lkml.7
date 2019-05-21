Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D1C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C432183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JKN7A8M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfEUXbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:47 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1181 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfEUXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a480000>; Tue, 21 May 2019 16:31:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:18 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:18 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:18 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a460000>; Tue, 21 May 2019 16:31:18 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 08/12] soc/tegra: pmc: allow support for more tegra wake models
Date:   Tue, 21 May 2019 16:31:19 -0700
Message-ID: <1558481483-22254-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481480; bh=c1dzpghDfJrINtqPCN/Q1ALduC0CZWjMGWN5kwBCkvU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JKN7A8M2Nhd+oQQ7X3zS2dknIrEWz7nu0M5J2gXEQ7IZydfcGCEiCaex6SWPqidl+
         rAUSRO22DUYaOe+R0vrc5Q54WWEZBLk28spNW2vbQ5+EWy21Qbx90YA0F9wUB5xDSy
         SFSn7MQ0kFXWP38XLSwZlgyDfh0UXwZkgOL/+QOdj7A2EPCTK3dezoOvwUK1wxCw3W
         qZJoqh9M1SpXCTA01Dc+PcGDi6yAJGtjo/7vAqr65UrqGc9iOnMxTxferecREKAdfB
         o8czPOMgY17K7vejWWuVKE8f0nsT+X6hnjkTKKUj0qmtqTlHJWR4UstyBeByV/STBS
         2L2XcPlFddUjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to create separate irq_set_wake and irq_set_type
implementations for different tegra designs PMC that has different
wake models which require difference wake registers and different
programming sequence.

AOWAKE model support is available for Tegra186 and Tegra194 only
and it resides within PMC and supports tiered wake architecture.

Tegra210 and prior tegra designs uses PMC directly to receive wake
events and coordinate the wake sequence.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5648e5c09ef5..f77ce4b827e3 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -235,6 +235,8 @@ struct tegra_pmc_soc {
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
 				   struct device_node *np,
 				   bool invert);
+	int (*pmc_irq_set_wake)(struct irq_data *data, unsigned int on);
+	int (*pmc_irq_set_type)(struct irq_data *data, unsigned int type);
 
 	const char * const *reset_sources;
 	unsigned int num_reset_sources;
@@ -1915,12 +1917,15 @@ static const struct irq_domain_ops tegra_pmc_irq_domain_ops = {
 	.alloc = tegra_pmc_irq_alloc,
 };
 
-static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
+static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
 	unsigned int offset, bit;
 	u32 value;
 
+	if (data->hwirq < 0)
+		return 0;
+
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -1943,12 +1948,12 @@ static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static int tegra_pmc_irq_set_type(struct irq_data *data, unsigned int type)
+static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
 	u32 value;
 
-	if (data->hwirq == ULONG_MAX)
+	if (data->hwirq < 0)
 		return 0;
 
 	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
@@ -1996,8 +2001,10 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 	pmc->irq.irq_unmask = irq_chip_unmask_parent;
 	pmc->irq.irq_eoi = irq_chip_eoi_parent;
 	pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
-	pmc->irq.irq_set_type = tegra_pmc_irq_set_type;
-	pmc->irq.irq_set_wake = tegra_pmc_irq_set_wake;
+	if (pmc->soc->pmc_irq_set_type)
+		pmc->irq.irq_set_type = pmc->soc->pmc_irq_set_type;
+	if (pmc->soc->pmc_irq_set_wake)
+		pmc->irq.irq_set_wake = pmc->soc->pmc_irq_set_wake;
 
 	pmc->domain = irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_node,
 					       &tegra_pmc_irq_domain_ops, pmc);
@@ -2670,6 +2677,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.pmc_irq_set_wake = tegra186_pmc_irq_set_wake,
+	.pmc_irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra186_reset_sources,
 	.num_reset_sources = ARRAY_SIZE(tegra186_reset_sources),
 	.reset_levels = tegra186_reset_levels,
@@ -2748,6 +2757,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.pmc_irq_set_wake = tegra186_pmc_irq_set_wake,
+	.pmc_irq_set_type = tegra186_pmc_irq_set_type,
 	.num_wake_events = ARRAY_SIZE(tegra194_wake_events),
 	.wake_events = tegra194_wake_events,
 };
-- 
2.7.4

