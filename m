Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16495C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FA62084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFTJNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:13:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32273 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725889AbfFTJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:13:09 -0400
X-UUID: f04cb5f347ec4fff93e6234c72477d7a-20190620
X-UUID: f04cb5f347ec4fff93e6234c72477d7a-20190620
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1172524557; Thu, 20 Jun 2019 17:12:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 17:12:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 17:12:51 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        YJ Chiang <yj.chiang@mediatek.com>
Subject: [PATCH] genirq: Remove warning on preemptible in prepare_percpu_nmi()
Date:   Thu, 20 Jun 2019 17:12:33 +0800
Message-ID: <20190620091233.22731-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_percpu_nmi() acquires lock first by irq_get_desc_lock(),
no matter whether preempt enabled or not, acquiring lock forces preempt off.

This simplifies the usage of prepare_percpu_nmi() and we don't need to
acquire extra lock or explicitly call preempt_[disable,enable]().

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 kernel/irq/manage.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 78f3ddeb7fe4..aa03640cd7fb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2509,9 +2509,6 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
  *	This call prepares an interrupt line to deliver NMI on the current CPU,
  *	before that interrupt line gets enabled with enable_percpu_nmi().
  *
- *	As a CPU local operation, this should be called from non-preemptible
- *	context.
- *
  *	If the interrupt line cannot be used to deliver NMIs, function
  *	will fail returning a negative value.
  */
@@ -2521,8 +2518,6 @@ int prepare_percpu_nmi(unsigned int irq)
 	struct irq_desc *desc;
 	int ret = 0;
 
-	WARN_ON(preemptible());
-
 	desc = irq_get_desc_lock(irq, &flags,
 				 IRQ_GET_DESC_CHECK_PERCPU);
 	if (!desc)
@@ -2554,17 +2549,12 @@ int prepare_percpu_nmi(unsigned int irq)
  *	This call undoes the setup done by prepare_percpu_nmi().
  *
  *	IRQ line should not be enabled for the current CPU.
- *
- *	As a CPU local operation, this should be called from non-preemptible
- *	context.
  */
 void teardown_percpu_nmi(unsigned int irq)
 {
 	unsigned long flags;
 	struct irq_desc *desc;
 
-	WARN_ON(preemptible());
-
 	desc = irq_get_desc_lock(irq, &flags,
 				 IRQ_GET_DESC_CHECK_PERCPU);
 	if (!desc)
-- 
2.18.0

