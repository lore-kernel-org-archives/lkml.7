Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A126824873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559646355;
	bh=4wJAWudpE4ep1kaTxjl+dxZpkZ4VQfAFbKRM2WEW4lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/dqMNrlPWw/UA/3Ze4NGafV35lGuxk26i8l2pA34LtzyNpmHxwDKxaAwB/rT/3T4
	 c4RLkZ/Pp2KGid6D1eYqqjV2/M++3uDuSRN0PSKU2p91rLkhlT18yrMq2Iu9li44t7
	 g7YNK/FsYrrFyCa0Mm9s7d713JMExdjT8FWheycs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfFDLFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfFDLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:05:53 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6B6247B8;
        Tue,  4 Jun 2019 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559646353;
        bh=4wJAWudpE4ep1kaTxjl+dxZpkZ4VQfAFbKRM2WEW4lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAl9EMAwwyUVIHqJWJ7OHDn8K9OFo2h/zvw4sA7k88rdbqeeTCWcxy6QetVZ4EktZ
         ggIPRNiohKx1c58/NYvuQceTilDUO8mKCbIlz2ZkJ8KnvvSF6bMmdyKuCttB0S98Yg
         eqRclJoFYTli2AYxSgreLc6fP1UFBIhgiz90MVmY=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 3/4] irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus
Date:   Tue,  4 Jun 2019 19:05:05 +0800
Message-Id: <1559646306-18860-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559646306-18860-1-git-send-email-guoren@kernel.org>
References: <1559646306-18860-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The csky,mpintc could deliver a external irq to one cpu or all cpus, but
it couldn't deliver a external irq to a group of cpus with cpu_mask. So
we only use auto deliver mode when affinity mask_val is equal to
cpu_present_mask.

There is no limitation for only two cpus in SMP system.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a451a07..2740dd5 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -143,8 +143,19 @@ static int csky_irq_set_affinity(struct irq_data *d,
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
2.7.4

