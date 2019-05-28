Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2795208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE1Kt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:49:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfE1KtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:49:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B865341;
        Tue, 28 May 2019 03:49:23 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C66943F59C;
        Tue, 28 May 2019 03:49:22 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guo Ren <guoren@kernel.org>
Subject: [PATCH RESEND 2/7] csky: entry: Remove unneeded need_resched() loop
Date:   Tue, 28 May 2019 11:48:43 +0100
Message-Id: <20190528104848.13160-3-valentin.schneider@arm.com>
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
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/kernel/entry.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7e84ccccbd8..679afbcc2001 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -292,11 +292,7 @@ ENTRY(csky_irq)
 	ldw	r8, (r9, TINFO_FLAGS)
 	btsti	r8, TIF_NEED_RESCHED
 	bf	2f
-1:
 	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
-	ldw	r7, (r9, TINFO_FLAGS)	/* get new tasks TI_FLAGS */
-	btsti	r7, TIF_NEED_RESCHED
-	bt	1b			/* go again */
 #endif
 2:
 	jmpi	ret_from_exception
-- 
2.20.1

