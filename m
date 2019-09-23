Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A88C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B8620835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394225AbfIWOgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:36:44 -0400
Received: from foss.arm.com ([217.140.110.172]:43402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393411AbfIWOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:36:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4794D1576;
        Mon, 23 Sep 2019 07:36:41 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F1943F59C;
        Mon, 23 Sep 2019 07:36:39 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 1/9] sched/core: Fix preempt_schedule() interrupt return comment
Date:   Mon, 23 Sep 2019 15:36:12 +0100
Message-Id: <20190923143620.29334-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_schedule_irq() is the one that should be called on return from
interrupt, clean up the comment to avoid any ambiguity.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9a1346a5fa9..3f40ea9f1372 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4223,9 +4223,8 @@ static void __sched notrace preempt_schedule_common(void)
 
 #ifdef CONFIG_PREEMPTION
 /*
- * this is the entry point to schedule() from in-kernel preemption
- * off of preempt_enable. Kernel preemptions off return from interrupt
- * occur there and call schedule directly.
+ * This is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.
  */
 asmlinkage __visible void __sched notrace preempt_schedule(void)
 {
@@ -4296,7 +4295,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #endif /* CONFIG_PREEMPTION */
 
 /*
- * this is the entry point to schedule() from kernel preemption
+ * This is the entry point to schedule() from kernel preemption
  * off of irq context.
  * Note, that this is called and return with irqs disabled. This will
  * protect us against recursive calling from irq.
--
2.22.0

