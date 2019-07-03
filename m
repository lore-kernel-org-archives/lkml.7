Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C811C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1F2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120125;
	bh=C8xCHjx7Onv/nUMr7qUYITBwriv4d3kV0pgWH2yt3bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DhDO3rVXuU1NRVZjCWK84AnGlLyjZUQvbJTA8t3WWX4882PabXLF/FN63MRWJ+TV9
	 d+ediscthULhfHySKHxy8CgW2i2CS6H0nq17bGNctsK0CjkKG3WTy2RAWC1yJeX5dj
	 qdUW4WQfRtVzskMRtahAE2YFiNhbYfeM5CVR2xA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfGCCPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfGCCPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFEC42187F;
        Wed,  3 Jul 2019 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120119;
        bh=C8xCHjx7Onv/nUMr7qUYITBwriv4d3kV0pgWH2yt3bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ssn5qfAALwS9po+K+CJRz6O1yz7fkqdu9oulOMY8pdzNO88blAcSJv1JFtJGauK2n
         INRbA62Fe/kUFznpIE7/08OfEPcks32NxZIwzNcUW4Yui2e61lkDGFO8I3C1hVt3EM
         LR3gfogymcGB0/AWgSrD1MKx9l/k4vGYhaO3I4dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 04/39] irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus
Date:   Tue,  2 Jul 2019 22:14:39 -0400
Message-Id: <20190703021514.17727-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit db56c5128e6625cb16efc4910b60627e46f608e3 ]

The csky,mpintc could deliver a external irq to one cpu or all cpus, but
it couldn't deliver a external irq to a group of cpus with cpu_mask. So
we only use auto deliver mode when affinity mask_val is equal to
cpu_present_mask.

There is no limitation for only two cpus in SMP system.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-csky-mpintc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961ab6cc..a4c1aacba1ff 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -89,8 +89,19 @@ static int csky_irq_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	/* Enable interrupt destination */
-	cpu |= BIT(31);
+	/*
+	 * The csky,mpintc could support auto irq deliver, but it only
+	 * could deliver external irq to one cpu or all cpus. So it
+	 * doesn't support deliver external irq to a group of cpus
+	 * with cpu_mask.
+	 * SO we only use auto deliver mode when affinity mask_val is
+	 * equal to cpu_present_mask.
+	 *
+	 */
+	if (cpumask_equal(mask_val, cpu_present_mask))
+		cpu = 0;
+	else
+		cpu |= BIT(31);
 
 	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + offset);
 
-- 
2.20.1

