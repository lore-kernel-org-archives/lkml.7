Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B28C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AF62158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfK1Ipt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:45:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfK1Ips (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:45:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32A43B174;
        Thu, 28 Nov 2019 08:45:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2] xen/events: remove event handling recursion detection
Date:   Thu, 28 Nov 2019 09:45:45 +0100
Message-Id: <20191128084545.13831-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__xen_evtchn_do_upcall() contains guards against being called
recursively. This mechanism was introduced in the early pvops times
(kernel 2.6.26) when there were all the Xen backend drivers missing
from the upstream kernel, and some of those out-of-tree drivers were
enabling interrupts in their event handlers (which was explicitly
allowed in the initial XenoLinux).

Nowadays we don't need to support those old drivers any more and the
capability to allow recursive calls of __xen_evtchn_do_upcall() can
be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: adapt commit message (Jan Beulich)
---
 drivers/xen/events/events_base.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6c8843968a52..33212c494afd 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1213,31 +1213,21 @@ void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
 	notify_remote_via_irq(irq);
 }
 
-static DEFINE_PER_CPU(unsigned, xed_nesting_count);
-
 static void __xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
-	int cpu = get_cpu();
-	unsigned count;
+	int cpu = smp_processor_id();
 
 	do {
 		vcpu_info->evtchn_upcall_pending = 0;
 
-		if (__this_cpu_inc_return(xed_nesting_count) - 1)
-			goto out;
-
 		xen_evtchn_handle_events(cpu);
 
 		BUG_ON(!irqs_disabled());
 
-		count = __this_cpu_read(xed_nesting_count);
-		__this_cpu_write(xed_nesting_count, 0);
-	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
-
-out:
+		rmb(); /* Hypervisor can set upcall pending. */
 
-	put_cpu();
+	} while (vcpu_info->evtchn_upcall_pending);
 }
 
 void xen_evtchn_do_upcall(struct pt_regs *regs)
-- 
2.16.4

