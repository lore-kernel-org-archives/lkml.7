Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C942087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCKWsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:48:13 -0400
Received: from foss.arm.com ([217.140.101.70]:33900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfCKWsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:48:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A3151993;
        Mon, 11 Mar 2019 15:48:10 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 116413F59C;
        Mon, 11 Mar 2019 15:48:08 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH 02/14] c6x: entry: Remove unneeded need_resched() loop
Date:   Mon, 11 Mar 2019 22:47:40 +0000
Message-Id: <20190311224752.8337-3-valentin.schneider@arm.com>
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

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
---
 arch/c6x/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
index 2721c90b0121..17926e942edb 100644
--- a/arch/c6x/kernel/entry.S
+++ b/arch/c6x/kernel/entry.S
@@ -567,7 +567,6 @@ resume_kernel:
 	NOP	4
  [A1]	BNOP	.S2	restore_all,5
 
-preempt_schedule:
 	GET_THREAD_INFO A2
 	LDW	.D1T1	*+A2(THREAD_INFO_FLAGS),A1
 #ifdef CONFIG_C6X_BIG_KERNEL
@@ -584,7 +583,7 @@ preempt_schedule:
 #else
 	B	.S2	preempt_schedule_irq
 #endif
-	ADDKPC	.S2	preempt_schedule,B3,4
+	ADDKPC	.S2	restore_all,B3,4
 #endif /* CONFIG_PREEMPT */
 
 ENTRY(enable_exception)
-- 
2.20.1

