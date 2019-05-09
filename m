Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE3DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B40E216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODdi+BeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEIR0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfEIR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HK1tB169783;
        Thu, 9 May 2019 17:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=5+AicXrLgHpXctVt8cnc/EdJ5KuJS7IwnasckkiqbqI=;
 b=ODdi+BeCjUmOTqRFTQ20OkerBYSOw3szijBMBMkJEdwfVLvYNhh0aDMaLTVBaZfQRbe5
 gtx0vg55G24rR+MgEwDef/1Lm/h5drNye5oxe+xsVw19kWIVKAZzke889Lmc4PqMG3MN
 dYBAMRUBFtbnLCmuD7WnljTWsF35XAb77fgcAAT65B3V7OZTeEdl18MwZTKA0fTnifkM
 vnTqDL3lP8sx/g5jHeFAM9Cb2fEzQCaE6DuJGrzwi6IBC6Iw183ZUVaMQv8fTfOKmibe
 5uFHlDHWpkOq+vhp9veLn8+64hkEyS1eTVZI5919HwDLOoRDpqV+EfobwK9LBQWrsetF QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s94b14e31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HNxdO109630;
        Thu, 9 May 2019 17:25:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sagyvcg4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:42 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPfic011094;
        Thu, 9 May 2019 17:25:41 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:41 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 08/16] x86/xen: irq/upcall handling with multiple xenhosts
Date:   Thu,  9 May 2019 10:25:32 -0700
Message-Id: <20190509172540.12398-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configurations with multiple xenhosts, we need to handle events
generated from multiple xenhosts.

Having more than one upcall handler might be quite hairy, and it would
be simpler if the callback from L0-Xen could be bounced via L1-Xen.
This will also mean simpler pv_irq_ops code because now the IF flag
maps onto the xh_default->vcpu_info->evtchn_upcall_mask.

However, we still update the xh_remote->vcpu_info->evtchn_upcall_mask
on a best effort basis to minimize unnecessary work in remote xenhost.

TODO:
  - direct pv_ops.irq are disabled.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/Makefile       |  2 +-
 arch/x86/xen/enlighten_pv.c |  4 ++-
 arch/x86/xen/irq.c          | 69 +++++++++++++++++++++++++++++--------
 arch/x86/xen/smp_pv.c       | 11 ++++++
 4 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 564b4dddbc15..3c7056ad3520 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
 obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
 obj-$(CONFIG_XEN_PV)		+= irq.o
 obj-$(CONFIG_XEN_PV)		+= multicalls.o
-obj-$(CONFIG_XEN_PV)		+= xen-asm.o
+obj-n		+= xen-asm.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
 
 obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5f6a1475ec0c..77b1a0d4aef2 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -996,8 +996,9 @@ void __init xen_setup_vcpu_info_placement(void)
 	 * xen_vcpu_setup managed to place the vcpu_info within the
 	 * percpu area for all cpus, so make use of it.
 	 */
+#if 0
+	/* Disable direct access for now. */
 	if (xen_have_vcpu_info_placement && false) {
-		/* Disable direct access until we have proper pcpu data structures. */
 		pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
 		pv_ops.irq.restore_fl =
 			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
@@ -1007,6 +1008,7 @@ void __init xen_setup_vcpu_info_placement(void)
 			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
 		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
 	}
+#endif
 }
 
 static const struct pv_info xen_info __initconst = {
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 38ad1a1c4763..f760a6abfb1e 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -19,9 +19,9 @@
  * callback mask. We do this in a very simple manner, by making a call
  * down into Xen. The pending flag will be checked by Xen on return.
  */
-void xen_force_evtchn_callback(void)
+void xen_force_evtchn_callback(xenhost_t *xh)
 {
-	(void)HYPERVISOR_xen_version(0, NULL);
+	(void)hypervisor_xen_version(xh, 0, NULL);
 }
 
 asmlinkage __visible unsigned long xen_save_fl(void)
@@ -29,6 +29,21 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 	struct vcpu_info *vcpu;
 	unsigned long flags;
 
+	/*
+	 * In scenarios with more than one xenhost, the primary xenhost
+	 * is responsible for all the upcalls, with the remote xenhost
+	 * bouncing its upcalls through it (see comment in
+	 * cpu_initialize_context().)
+	 *
+	 * To minimize unnecessary upcalls, the remote xenhost still looks at
+	 * the value of vcpu_info->evtchn_upcall_mask, so we still set and reset
+	 * that.
+	 *
+	 * The fact that the upcall itself is gated by the default xenhost,
+	 * also helps in simplifying the logic here because we don't have to
+	 * worry about guaranteeing atomicity with updates to
+	 * xh_remote->vcpu_info->evtchn_upcall_mask.
+	 */
 	vcpu = xh_default->xen_vcpu[smp_processor_id()];
 
 	/* flag has opposite sense of mask */
@@ -38,26 +53,34 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 	   -0 -> 0x00000000
 	   -1 -> 0xffffffff
 	*/
-	return (-flags) & X86_EFLAGS_IF;
+	return ((-flags) & X86_EFLAGS_IF);
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
 
 __visible void xen_restore_fl(unsigned long flags)
 {
 	struct vcpu_info *vcpu;
+	xenhost_t **xh;
 
 	/* convert from IF type flag */
 	flags = !(flags & X86_EFLAGS_IF);
 
 	/* See xen_irq_enable() for why preemption must be disabled. */
 	preempt_disable();
-	vcpu = xh_default->xen_vcpu[smp_processor_id()];
-	vcpu->evtchn_upcall_mask = flags;
+	for_each_xenhost(xh) {
+		vcpu = (*xh)->xen_vcpu[smp_processor_id()];
+		vcpu->evtchn_upcall_mask = flags;
+	}
 
 	if (flags == 0) {
 		barrier(); /* unmask then check (avoid races) */
-		if (unlikely(vcpu->evtchn_upcall_pending))
-			xen_force_evtchn_callback();
+		for_each_xenhost(xh) {
+			/* Preemption is disabled so we should not have
+			 * gotten moved to a different VCPU. */
+			vcpu = (*xh)->xen_vcpu[smp_processor_id()];
+			if (unlikely(vcpu->evtchn_upcall_pending))
+				xen_force_evtchn_callback(*xh);
+		}
 		preempt_enable();
 	} else
 		preempt_enable_no_resched();
@@ -66,11 +89,19 @@ PV_CALLEE_SAVE_REGS_THUNK(xen_restore_fl);
 
 asmlinkage __visible void xen_irq_disable(void)
 {
+	xenhost_t **xh;
+
 	/* There's a one instruction preempt window here.  We need to
 	   make sure we're don't switch CPUs between getting the vcpu
 	   pointer and updating the mask. */
 	preempt_disable();
-	xh_default->xen_vcpu[smp_processor_id()]->evtchn_upcall_mask = 1;
+	for_each_xenhost(xh)
+		/*
+		 * Mask events on this CPU for both the xenhosts.  As the
+		 * comment above mentions, disabling preemption means we
+		 * can safely do that.
+		 */
+		(*xh)->xen_vcpu[smp_processor_id()]->evtchn_upcall_mask = 1;
 	preempt_enable_no_resched();
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
@@ -78,6 +109,7 @@ PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
 asmlinkage __visible void xen_irq_enable(void)
 {
 	struct vcpu_info *vcpu;
+	xenhost_t **xh;
 
 	/*
 	 * We may be preempted as soon as vcpu->evtchn_upcall_mask is
@@ -86,16 +118,25 @@ asmlinkage __visible void xen_irq_enable(void)
 	 */
 	preempt_disable();
 
-	vcpu = xh_default->xen_vcpu[smp_processor_id()];
-	vcpu->evtchn_upcall_mask = 0;
+	/* Given that the interrupts are generated from the default xenhost,
+	 * we should do this in reverse order.
+	 */
+	for_each_xenhost(xh) {
+		vcpu = (*xh)->xen_vcpu[smp_processor_id()];
+		vcpu->evtchn_upcall_mask = 0;
 
-	/* Doesn't matter if we get preempted here, because any
-	   pending event will get dealt with anyway. */
+		/* We could get preempted by an incoming interrupt here with a
+		 * half enabled irq (for the first xenhost.)
+		 */
+	}
 
 	barrier(); /* unmask then check (avoid races) */
-	if (unlikely(vcpu->evtchn_upcall_pending))
-		xen_force_evtchn_callback();
 
+	for_each_xenhost(xh) {
+		vcpu = (*xh)->xen_vcpu[smp_processor_id()];
+		if (unlikely(vcpu->evtchn_upcall_pending))
+			xen_force_evtchn_callback(*xh);
+	}
 	preempt_enable();
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6d9c3e6611ef..f4ea9eac8b6a 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -343,6 +343,17 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 #else
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
 #endif
+	/*
+	 * We setup an upcall handler only for the default xenhost. The remote
+	 * xenhost will generate evtchn events, but an additional callback would be
+	 * quite hairy, since we would have VCPU state initialised in multiple
+	 * hypervisors and issues like re-entrancy of upcalls.
+	 *
+	 * It would be simpler if the callback from L0-Xen could be bounced
+	 * bounced via L1-Xen. This also simplifies the pv_irq_ops code
+	 * because now the CPU's IF processing only needs to happen on
+	 * xh_default->vcpu_info.
+	 */
 	ctxt->event_callback_eip    =
 		(unsigned long)xen_hypervisor_callback;
 	ctxt->failsafe_callback_eip =
-- 
2.20.1

