Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890112087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfCKWsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:48:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCKWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:48:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8C24A78;
        Mon, 11 Mar 2019 15:48:22 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2DFF3F59C;
        Mon, 11 Mar 2019 15:48:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 12/14] sparc64: rtrap: Remove unneeded need_resched() loop
Date:   Mon, 11 Mar 2019 22:47:50 +0000
Message-Id: <20190311224752.8337-13-valentin.schneider@arm.com>
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

We seem to be looping back somewhere much higher than the usual
preempt/need_resched checks, but AFAICT we would just branch to
'rtrap_no_irq_enable' and then back to 'to_kernel', which is
a need_resched() loop with a few extra steps.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/rtrap_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 29aa34f11720..57fb75686957 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -322,7 +322,6 @@ to_kernel:
 		 nop
 		call			preempt_schedule_irq
 		 nop
-		ba,pt			%xcc, rtrap
 #endif
 kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH], %l5
 		brz,pt			%l5, rt_continue
-- 
2.20.1

