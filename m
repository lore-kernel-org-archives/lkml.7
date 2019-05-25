Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD8C28CBF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6262168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEYMX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:23:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfEYMX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:23:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4247E5C72E4B0C50A544;
        Sat, 25 May 2019 20:23:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:23:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ralf@linux-mips.org>, <paul.burton@mips.com>, <jhogan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] MIPS: uprobes: remove set but not used variable 'epc'
Date:   Sat, 25 May 2019 20:20:24 +0800
Message-ID: <20190525122024.4908-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/mips/kernel/uprobes.c: In function 'arch_uprobe_pre_xol':
arch/mips/kernel/uprobes.c:115:17: warning: variable 'epc' set but not used [-Wunused-but-set-variable]

It's never used since introduction in
commit 40e084a506eb ("MIPS: Add uprobes support.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/mips/kernel/uprobes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 4aaff3b3175c..6dbe4eab0a0e 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -112,9 +112,6 @@ int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
 	 */
 	aup->resume_epc = regs->cp0_epc + 4;
 	if (insn_has_delay_slot((union mips_instruction) aup->insn[0])) {
-		unsigned long epc;
-
-		epc = regs->cp0_epc;
 		__compute_return_epc_for_insn(regs,
 			(union mips_instruction) aup->insn[0]);
 		aup->resume_epc = regs->cp0_epc;
-- 
2.17.1


