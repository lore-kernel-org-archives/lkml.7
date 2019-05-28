Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73315C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B28208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE1Ktb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:49:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfE1Ktb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:49:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DCCF15AD;
        Tue, 28 May 2019 03:49:30 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 840293F59C;
        Tue, 28 May 2019 03:49:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH RESEND 5/7] RISC-V: entry: Remove unneeded need_resched() loop
Date:   Tue, 28 May 2019 11:48:46 +0100
Message-Id: <20190528104848.13160-6-valentin.schneider@arm.com>
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
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 1c1ecc238cfa..d0b1b9660283 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -258,12 +258,11 @@ restore_all:
 resume_kernel:
 	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
 	bnez s0, restore_all
-need_resched:
 	REG_L s0, TASK_TI_FLAGS(tp)
 	andi s0, s0, _TIF_NEED_RESCHED
 	beqz s0, restore_all
 	call preempt_schedule_irq
-	j need_resched
+	j restore_all
 #endif
 
 work_pending:
-- 
2.20.1

