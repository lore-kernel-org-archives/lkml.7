Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1368721850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfDRGVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:21:31 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42840 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfDRGVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:21:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07713075|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.423763-0.027105-0.549132;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.EMywanS_1555568487;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EMywanS_1555568487)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 18 Apr 2019 14:21:27 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, Mao Han <han_mao@c-sky.com>
Subject: [PATCH 1/1] csky: add page fault perf event support
Date:   Thu, 18 Apr 2019 14:20:40 +0800
Message-Id: <46349332f41f16896afde240973764c385d78cd3.1555568371.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for page fault count, major fault count
and minorfault count. Without this patch page faults are not
sampled for perf event.

 Performance counter stats for '/usr/lib/perf-test/callchain_test':
                 0      page-faults               #    0.000 K/sec

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 arch/csky/mm/fault.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index e1725f8..d07141d 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/vt_kern.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
@@ -106,6 +107,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		return;
 	}
 #endif
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -153,10 +156,15 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR)
+	if (fault & VM_FAULT_MAJOR) {
 		tsk->maj_flt++;
-	else
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
+			      address);
+	} else {
 		tsk->min_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
+			      address);
+	}
 
 	up_read(&mm->mmap_sem);
 	return;
-- 
2.7.4

