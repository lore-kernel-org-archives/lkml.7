Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C12082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:06:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLMGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:06:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 236263508B3631F48BC1;
        Fri, 12 Apr 2019 20:06:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 20:06:20 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <wangxiongfeng2@huawei.com>, <huawei.libin@huawei.com>,
        <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/3] Revert "arm64: debug: remove unused local_dbg_{enable, disable} macros"
Date:   Fri, 12 Apr 2019 20:04:57 +0800
Message-ID: <1555070699-3685-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2572214170fb95370be21915c0397f4b6a27e7e3.

This is a preparation for the following patch. We need to enable debug
in _sdei_handler, so let's revert this patch.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/include/asm/irqflags.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 43d8366..0a54c45 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -140,5 +140,9 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 
 	return res;
 }
+
+#define local_dbg_enable()	asm("msr	daifclr, #8" : : : "memory")
+#define local_dbg_disable()	asm("msr	daifset, #8" : : : "memory")
+
 #endif
 #endif
-- 
1.7.12.4

