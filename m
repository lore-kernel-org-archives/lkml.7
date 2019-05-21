Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ECBC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D1121743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558425292;
	bh=SITPpVCwi11SHOs3XUanWu/wOsT6fGEWvQJoKRZQEKk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RXAYb4JgXCUXwqiPMbFYlzNdkygN00RHXTMXkfMoDKsOvXdXTA0Zjq6c/qwVw7DHS
	 zzZDotnTPu994m7rAqA4Uh8MBQCVl4h1ymQTIMQA9y/vZiCLf6NMD3gD5ltQwg8Z+0
	 0uwJ4mEtcwgkB3sVNjiRgyE4rvrT9JFYKt0SVqtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEUHyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUHyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:54:51 -0400
Received: from localhost.localdomain (unknown [115.193.166.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513242173C;
        Tue, 21 May 2019 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425290;
        bh=SITPpVCwi11SHOs3XUanWu/wOsT6fGEWvQJoKRZQEKk=;
        h=From:To:Cc:Subject:Date:From;
        b=u6K8ne0r7WvAQtC1DvFhLAl43XEbLlYnNmeooy0jvEtBScAamXSACMRg+q9XcF6sA
         BRRrEPGNBt4z4riYe6VYx6LoS2ZtVHr8IrZAX7DrhVok/L0cIaXX3uYQ0JIMZr86Nq
         Wle4cvpK50QxgLuZI0i5zNXTbd8JDTxxT7lHHtJM=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, ren_guo@c-sky.com, linux-csky@vger.kernel.org
Subject: [PATCH] irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus
Date:   Tue, 21 May 2019 15:54:05 +0800
Message-Id: <1558425245-20995-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
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
index 5bc0868..a3dbc6b 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -159,8 +159,19 @@ static int csky_irq_set_affinity(struct irq_data *d,
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

