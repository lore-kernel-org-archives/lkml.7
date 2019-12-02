Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391A1217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBLiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:38:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfLBLiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:38:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A52C3DFD4CBD2B31D9A7;
        Mon,  2 Dec 2019 19:38:13 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Dec 2019 19:38:06 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] arm64/kernel/entry: refine comment of stack overflow check
Date:   Mon, 2 Dec 2019 19:37:02 +0800
Message-ID: <20191202113702.34158-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stack overflow checking can be done by testing
sp & (1 << THREAD_SHIFT)
only for the stacks are aligned to (2 << THREAD_SHIFT) with size of
(1 << THREAD_SIZE), and this is the case when CONFIG_VMAP_STACK is
set.

Fix the code comment to avoid confusion.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/entry.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cf3bd2976e57..9e8ba507090f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -76,7 +76,8 @@ alternative_else_nop_endif
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * Test whether the SP has overflowed, without corrupting a GPR.
-	 * Task and IRQ stacks are aligned to (1 << THREAD_SHIFT).
+	 * Task and IRQ stacks are aligned to (2 << THREAD_SHIFT) with size of
+	 * (1 << THREAD_SHIFT).
 	 */
 	add	sp, sp, x0			// sp' = sp + x0
 	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
-- 
2.19.1

