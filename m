Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33081C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC4120652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfDLMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:06:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfDLMGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:06:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1927465C30D0C7DA98B0;
        Fri, 12 Apr 2019 20:06:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 20:06:21 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <wangxiongfeng2@huawei.com>, <huawei.libin@huawei.com>,
        <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/3] stop_machine: mask sdei before running the callback
Date:   Fri, 12 Apr 2019 20:04:59 +0800
Message-ID: <1555070699-3685-4-git-send-email-wangxiongfeng2@huawei.com>
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

Kprobes use 'stop_machine' to modify code which could be run in the
sdei event handler at the same time. This patch mask sdei before running
the stop_machine callback to avoid this race condition.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 kernel/stop_machine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 067cb83..7b95632 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -22,6 +22,9 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#ifdef CONFIG_ARM64
+#include <linux/arm_sdei.h>
+#endif
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -208,6 +211,9 @@ static int multi_cpu_stop(void *data)
 			case MULTI_STOP_DISABLE_IRQ:
 				local_irq_disable();
 				hard_irq_disable();
+#ifdef CONFIG_ARM64
+				sdei_mask_local_cpu();
+#endif
 				break;
 			case MULTI_STOP_RUN:
 				if (is_active)
@@ -227,6 +233,9 @@ static int multi_cpu_stop(void *data)
 		}
 	} while (curstate != MULTI_STOP_EXIT);
 
+#ifdef CONFIG_ARM64
+	sdei_unmask_local_cpu();
+#endif
 	local_irq_restore(flags);
 	return err;
 }
-- 
1.7.12.4

