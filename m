Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9802C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50102054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLKHco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:32:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfLKHcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:32:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 107B07834A358239494C;
        Wed, 11 Dec 2019 15:32:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Dec 2019 15:32:32 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] arm64: armv8_deprecated: update the comments of armv8_deprecated_init()
Date:   Wed, 11 Dec 2019 15:27:33 +0800
Message-ID: <1576049253-60950-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c0d8832e78cb ("arm64: Ensure the instruction emulation is
ready for userspace"), armv8_deprecated_init() was promoted to
core_initcall() but the comments were left unchanged, update it now.

Spotted by some random reading of the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index ca158be..3f6fcf2 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -618,7 +618,8 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
 };
 
 /*
- * Invoked as late_initcall, since not needed before init spawned.
+ * Invoked as core_initcall, which can guarantee that the instruction
+ * emulation is ready for userspace.
  */
 static int __init armv8_deprecated_init(void)
 {
-- 
1.7.12.4

