Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5615EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216620869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfK2Mjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfK2Mjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCA62ACE0;
        Fri, 29 Nov 2019 12:39:43 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3] xen/events: remove event handling recursion detection
Date:   Fri, 29 Nov 2019 13:39:41 +0100
Message-Id: <20191129123941.11975-1-jgross@suse.com>
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
V3: rmb() -> virt_rmb() (Boris Ostrovsky)
---
 drivers/xen/events/events_base.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6c8843968a52..499eff7d3f65 100644
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
+		virt_rmb(); /* Hypervisor can set upcall pending. */
 
-	put_cpu();
+	} while (vcpu_info->evtchn_upcall_pending);
 }
 
 void xen_evtchn_do_upcall(struct pt_regs *regs)
-- 
2.16.4

