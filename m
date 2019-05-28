Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0C8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9B0208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfE1Kt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:49:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfE1Kt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:49:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD330A78;
        Tue, 28 May 2019 03:49:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6DCE3F59C;
        Tue, 28 May 2019 03:49:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH RESEND 3/7] h8300: entry: Remove unneeded need_resched() loop
Date:   Tue, 28 May 2019 11:48:44 +0100
Message-Id: <20190528104848.13160-4-valentin.schneider@arm.com>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/h8300/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index 4ade5f8299ba..6bde028e7d4a 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -323,7 +323,6 @@ restore_all:
 resume_kernel:
 	mov.l	@(TI_PRE_COUNT:16,er4),er0
 	bne	restore_all:8
-need_resched:
 	mov.l	@(TI_FLAGS:16,er4),er0
 	btst	#TIF_NEED_RESCHED,r0l
 	beq	restore_all:8
@@ -332,7 +331,7 @@ need_resched:
 	mov.l	sp,er0
 	jsr	@set_esp0
 	jsr	@preempt_schedule_irq
-	bra	need_resched:8
+	bra	restore_all:8
 #endif
 
 ret_from_fork:
-- 
2.20.1

