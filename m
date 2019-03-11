Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C268BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB12087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCKWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:48:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfCKWsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:48:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F38F3A78;
        Mon, 11 Mar 2019 15:48:14 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7FBC3F59C;
        Mon, 11 Mar 2019 15:48:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 06/14] MIPS: entry: Remove unneeded need_resched() loop
Date:   Mon, 11 Mar 2019 22:47:44 +0000
Message-Id: <20190311224752.8337-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311224752.8337-1-valentin.schneider@arm.com>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Do note that commit a18815abcdfd ("Use preempt_schedule_irq.")
initially removed the existing loop, but commit cdaed73afb61 ("Fix
preemption bug.") reintroduced it. It is however not clear what the
issue was and why such a loop was reintroduced, so I'm probably
missing something.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index d7de8adcfcc8..2240faeda62a 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -58,7 +58,6 @@ resume_kernel:
 	local_irq_disable
 	lw	t0, TI_PRE_COUNT($28)
 	bnez	t0, restore_all
-need_resched:
 	LONG_L	t0, TI_FLAGS($28)
 	andi	t1, t0, _TIF_NEED_RESCHED
 	beqz	t1, restore_all
@@ -66,7 +65,7 @@ need_resched:
 	andi	t0, 1
 	beqz	t0, restore_all
 	jal	preempt_schedule_irq
-	b	need_resched
+	j	restore_all
 #endif
 
 FEXPORT(ret_from_kernel_thread)
-- 
2.20.1

