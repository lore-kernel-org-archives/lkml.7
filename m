Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC61C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E8208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfE1Ktb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:49:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfE1Kt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:49:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77559341;
        Tue, 28 May 2019 03:49:28 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A55A53F59C;
        Tue, 28 May 2019 03:49:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>
Subject: [PATCH RESEND 4/7] microblaze: entry: Remove unneeded need_resched() loop
Date:   Tue, 28 May 2019 11:48:45 +0100
Message-Id: <20190528104848.13160-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528104848.13160-1-valentin.schneider@arm.com>
References: <20190528104848.13160-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/entry.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 4e1b567becd6..de7083bd1d24 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -738,14 +738,9 @@ no_intr_resched:
 	andi	r5, r5, _TIF_NEED_RESCHED;
 	beqi	r5, restore /* if zero jump over */
 
-preempt:
 	/* interrupts are off that's why I am calling preempt_chedule_irq */
 	bralid	r15, preempt_schedule_irq
 	nop
-	lwi	r11, CURRENT_TASK, TS_THREAD_INFO;	/* get thread info */
-	lwi	r5, r11, TI_FLAGS;		/* get flags in thread info */
-	andi	r5, r5, _TIF_NEED_RESCHED;
-	bnei	r5, preempt /* if non zero jump to resched */
 restore:
 #endif
 	VM_OFF /* MS: turn off MMU */
-- 
2.20.1

