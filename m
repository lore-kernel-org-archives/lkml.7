Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5DC28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995182175B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfE0JkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:40:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0JkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:40:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3ECA3419BF0B28FDFABB;
        Mon, 27 May 2019 17:40:16 +0800 (CST)
Received: from SZX1000472652.huawei.com (100.100.247.164) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 27 May 2019 17:40:05 +0800
From:   Yongliang Gao <gaoyongliang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rmk+kernel@armlinux.org.uk>,
        <linux@armlinux.org.uk>, <punitagrawal@gmail.com>,
        <rafael.j.wysocki@intel.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <chenjie6@huawei.com>, <nixiaoming@huawei.com>,
        <zengweilin@huawei.com>, <shiwenlu@huawei.com>
Subject: [PATCH] arm: fix using smp_processor_id() in preemptible context
Date:   Mon, 27 May 2019 17:39:39 +0800
Message-ID: <1558949979-129251-1-git-send-email-gaoyongliang@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.100.247.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

harden_branch_predictor() call smp_processor_id() in preemptible
context, this would cause a bug messages.

The bug messages is as follows:
BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor0/17992
caller is harden_branch_predictor arch/arm/include/asm/system_misc.h:27 [inline]
caller is __do_user_fault+0x34/0x114 arch/arm/mm/fault.c:200
CPU: 1 PID: 17992 Comm: syz-executor0 Tainted: G O 4.4.176 #1
Hardware name: Hisilicon A9
[<c0114ae4>] (unwind_backtrace) from [<c010e6fc>] (show_stack+0x18/0x1c)
[<c010e6fc>] (show_stack) from [<c0379514>] (dump_stack+0xc8/0x118)
[<c0379514>] (dump_stack) from [<c039b5a0>] (check_preemption_disabled+0xf4/0x138)
[<c039b5a0>] (check_preemption_disabled) from [<c011abe4>] (__do_user_fault+0x34/0x114)
[<c011abe4>] (__do_user_fault) from [<c053b0d0>] (do_page_fault+0x3b4/0x3d8)
[<c053b0d0>] (do_page_fault) from [<c01013dc>] (do_DataAbort+0x58/0xf8)
[<c01013dc>] (do_DataAbort) from [<c053a880>] (__dabt_usr+0x40/0x60)

Reported-by: Jingwen Qiu <qiujingwen@huawei.com>
Signed-off-by: Yongliang Gao <gaoyongliang@huawei.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm/include/asm/system_misc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 66f6a3a..4a55cfb 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -22,9 +22,10 @@
 static inline void harden_branch_predictor(void)
 {
 	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
-						  smp_processor_id());
+						  get_cpu());
 	if (fn)
 		fn();
+	put_cpu();
 }
 #else
 #define harden_branch_predictor() do { } while (0)
-- 
1.8.5.6

