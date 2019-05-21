Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4681FC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148942183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QIhkn38d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfEUXcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:32:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1176 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEUXbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a460000>; Tue, 21 May 2019 16:31:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450003>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 01/12] irqchip: tegra: do not disable COP IRQ during suspend
Date:   Tue, 21 May 2019 16:31:12 -0700
Message-ID: <1558481483-22254-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481479; bh=vpItaAdCCfi7ntL6ByckdKbRZ/KSHdenIpT3xYHKDOM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QIhkn38dP1DrL0kVPaDgngZ6ffRasvlnPfN2k8FxXb+UWpZojml9YtyU3buUxCsrD
         wXiyBj1BxIOOD5ahyHTELGvKPnb+eBsrWXkTopzraYIagDRebRs32YM9U5saf+WpHC
         NNHiskGsrIXfN4ctu6tiolYkRmzrFAYbbMYvwRGcVonJAHzblD3SPYNLLNR5rLPkZT
         kiEOTbzL+EQYrR+kMgcdBHDvADx836O8+IeO/ZbaavBbfsV4W8h9G3s+5JrD1FMqo6
         e+wODMn5wayHU+HCJO7gP4mVYCTdDoBc6MpLrGJ/d3rVa5EmEmiF9S8OfFqeADC4Hc
         kU/QVevd22exA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPMP-lite still need IRQ function to finish SC7 suspend sequence for
Tegra210.

This patch has fix for leaving the COP IRQ enabled for Tegra210 during
interrupt controller suspend operation.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/irqchip/irq-tegra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 0abc0cd1c32e..1882373fa1fd 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -53,18 +53,24 @@ static unsigned int num_ictlrs;
 
 struct tegra_ictlr_soc {
 	unsigned int num_ictlrs;
+	bool has_bpmpl;
 };
 
+static const struct tegra_ictlr_soc *soc;
+
 static const struct tegra_ictlr_soc tegra20_ictlr_soc = {
 	.num_ictlrs = 4,
+	.has_bpmpl = false,
 };
 
 static const struct tegra_ictlr_soc tegra30_ictlr_soc = {
 	.num_ictlrs = 5,
+	.has_bpmpl = false,
 };
 
 static const struct tegra_ictlr_soc tegra210_ictlr_soc = {
 	.num_ictlrs = 6,
+	.has_bpmpl = true,
 };
 
 static const struct of_device_id ictlr_matches[] = {
@@ -157,7 +163,8 @@ static int tegra_ictlr_suspend(void)
 		lic->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
 
 		/* Disable COP interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		if (!soc->has_bpmpl)
+			writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
 
 		/* Disable CPU interrupts */
 		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
@@ -286,7 +293,6 @@ static int __init tegra_ictlr_init(struct device_node *node,
 {
 	struct irq_domain *parent_domain, *domain;
 	const struct of_device_id *match;
-	const struct tegra_ictlr_soc *soc;
 	unsigned int i;
 	int err;
 
-- 
2.7.4

