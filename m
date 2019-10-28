Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ED721D80
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfJ1JJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:09:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727586AbfJ1JJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:09:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B82BAABADCF620220BB;
        Mon, 28 Oct 2019 17:09:14 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 17:09:05 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
Subject: [PATCH] arm64: print additional fault message when executing non-exec memory
Date:   Mon, 28 Oct 2019 17:08:37 +0800
Message-ID: <20191028090837.39652-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to executing non-executable memory, the fault message
shows:

  Unable to handle kernel read from unreadable memory at virtual address
  ffff802dac469000

This may confuse someone, so add a new fault message for instruction
abort.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 arch/arm64/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9fc6db0bcbad..68bf4ec376d0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -318,6 +318,8 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	if (is_el1_permission_fault(addr, esr, regs)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
+		else if (is_el1_instruction_abort(esr))
+			msg = "execute non-executable memory";
 		else
 			msg = "read from unreadable memory";
 	} else if (addr < PAGE_SIZE) {
-- 
2.19.1


