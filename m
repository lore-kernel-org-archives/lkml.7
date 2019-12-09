Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED2FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E032077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HkKi1fDp";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="SFqRst7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:34:14 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:37846
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbfLIOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575902053;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=f7JHERY5BvwiGUAZjOpjE9hGv+kWsMrQsSxpzyMAiGw=;
        b=HkKi1fDp/ntmRm7pGR9CCnGXrhJkmYZIaLhhlJlajUv1ii1szjphiqWtbDhYv5dh
        nvh0jlRhUN+YV8s3Kz1bR91RQ1R6BqTPGFYKue1rVkAdXTulZQ8nILZbX0vpqylexr6
        kCIszkffSet0WI6m1wtJvmMTDGlP76Tj330JDChs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575902053;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=f7JHERY5BvwiGUAZjOpjE9hGv+kWsMrQsSxpzyMAiGw=;
        b=SFqRst7p5mn8amv+dN4Qc78QmitBVA7nT93zjApax9ngU2ArmwFNkNMvBjbbB+HU
        Lg+rTspe5BgG7bSdzWTsBShwKSCN06t5B6nyx8gqZa1uZZCD2s+MdKLeT1fk5QNiseh
        /D0HMsizCui6yycfo+2t2eZ0Bhzd12ekHfMCE9as=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB6B6C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] irq_work: Fix comment for irq_work_run()
Date:   Mon, 9 Dec 2019 14:34:12 +0000
Message-ID: <0101016eeb150204-57ce5f94-6b3c-4510-9542-90f578a47b1b-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.12.09-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hotplug_cfd() does not exist anymore, update the
comment for irq_work_run() with smpcfd_dying_cpu().

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/irq_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 828cc30..202a0d3 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -165,7 +165,7 @@ static void irq_work_run_list(struct llist_head *list)
 
 /*
  * hotplug calls this through:
- *  hotplug_cfd() -> flush_smp_call_function_queue()
+ *  smpcfd_dying_cpu() -> flush_smp_call_function_queue()
  */
 void irq_work_run(void)
 {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

