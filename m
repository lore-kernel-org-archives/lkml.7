Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9493C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C1221871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfC2NYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:24:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729626AbfC2NYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:24:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45325F1F2600378F1DE8;
        Fri, 29 Mar 2019 21:24:39 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 21:24:31 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <julien.thierry@arm.com>,
        <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <james.morse@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH] irqchip/gic-v3: Make gic_handle_irq() notrace
Date:   Fri, 29 Mar 2019 13:23:28 +0000
Message-ID: <1553865808-30604-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pseudo NMI together with function_graph tracer, will lead
the system to a hang. This is easy to reproduce,

  1) Set "irqchip.gicv3_pseudo_nmi=1" on the kernel command line
  2) echo function_graph > /sys/kernel/debug/tracing/current_tracer

This patch (RFC) set gic_handle_irq() as notrace and it seems works
fine now. But I have no idea about what the issue is exactly, and
you can regard this patch as a report then :)

Can someone give a look at it and provide some explanations ?

Thanks!

Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 15e55d3..8d0c25f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -487,7 +487,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 		gic_deactivate_unhandled(irqnr);
 }
 
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+static asmlinkage notrace void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
-- 
1.8.3.1


