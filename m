Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B1D21019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+PspFkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEIR0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41810 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfEIRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJdZJ162617;
        Thu, 9 May 2019 17:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=tvxEVQHSjGEEQ2j+NCO0wtnQzFGpPG5tooLTFGk+YKs=;
 b=R+PspFkmBGjY1zA4xTkjO91hNkxNSLURJi2IYBIEA+DiTzJbCFNuPj8rgEeWREDdZHqp
 b3rGtBzgCq0M6ZAoaTXu45YDfWuDn3qEtVXZDQZhoI1yjmmE2bRxtcmGBFvG+FFzvIDD
 GjpjzSnPkJVuab1x3F3ZVIz/HaVXjfgWZIR/zvlgHbRZzg8Gz5QdKln/p+VyQutjZX03
 B+omb60+0vmBZQlWviVbYEL6JGSSisD86BrqzzN7xcawuBvn9kjm6PZBxO1wBvfcZDUf
 iLnMzAFRJc9RrDkcWTFQ9xFoEUMqb/nuqCuBOFAfPwiuvNGijN2Rj2zJvYCG6XnDASQG jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b6ceys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HOMIN110350;
        Thu, 9 May 2019 17:25:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sagyvcg4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPewo011061;
        Thu, 9 May 2019 17:25:40 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:40 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 07/16] x86/xen: make vcpu_info part of xenhost_t
Date:   Thu,  9 May 2019 10:25:31 -0700
Message-Id: <20190509172540.12398-8-ankur.a.arora@oracle.com>
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

Abstract out xen_vcpu_id probing via (*probe_vcpu_id)(). Once that is
availab,e the vcpu_info registration happens via the VCPUOP hypercall.

Note that for the nested case, there are two vcpu_ids, and two vcpu_info
areas, one each for the default xenhost and the remote xenhost.
The vcpu_info is used via pv_irq_ops, and evtchn signaling.

The other VCPUOP hypercalls are used for management (and scheduling)
which is expected to be done purely in the default hypervisor.
However, scheduling of L1-guest does imply L0-Xen-vcpu_info switching,
which might mean that the remote hypervisor needs some visibility
into related events/hypercalls in the default hypervisor.

TODO:
  - percpu data structures for xen_vcpu

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/enlighten.c         | 93 +++++++++++++-------------------
 arch/x86/xen/enlighten_hvm.c     | 87 ++++++++++++++++++------------
 arch/x86/xen/enlighten_pv.c      | 60 ++++++++++++++-------
 arch/x86/xen/enlighten_pvh.c     |  3 +-
 arch/x86/xen/irq.c               | 10 ++--
 arch/x86/xen/mmu_pv.c            |  6 +--
 arch/x86/xen/pci-swiotlb-xen.c   |  1 +
 arch/x86/xen/setup.c             |  1 +
 arch/x86/xen/smp.c               |  9 +++-
 arch/x86/xen/smp_hvm.c           | 17 +++---
 arch/x86/xen/smp_pv.c            | 12 ++---
 arch/x86/xen/time.c              | 23 ++++----
 arch/x86/xen/xen-ops.h           |  5 +-
 drivers/xen/events/events_base.c | 14 ++---
 drivers/xen/events/events_fifo.c |  2 +-
 drivers/xen/evtchn.c             |  2 +-
 drivers/xen/time.c               |  2 +-
 include/xen/xen-ops.h            |  7 +--
 include/xen/xenhost.h            | 47 ++++++++++++++++
 19 files changed, 240 insertions(+), 161 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 20e0de844442..0dafbbc838ef 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -20,35 +20,6 @@
 #include "smp.h"
 #include "pmu.h"
 
-/*
- * Pointer to the xen_vcpu_info structure or
- * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
- * and xen_vcpu_setup for details. By default it points to share_info->vcpu_info
- * but if the hypervisor supports VCPUOP_register_vcpu_info then it can point
- * to xen_vcpu_info. The pointer is used in __xen_evtchn_do_upcall to
- * acknowledge pending events.
- * Also more subtly it is used by the patched version of irq enable/disable
- * e.g. xen_irq_enable_direct and xen_iret in PV mode.
- *
- * The desire to be able to do those mask/unmask operations as a single
- * instruction by using the per-cpu offset held in %gs is the real reason
- * vcpu info is in a per-cpu pointer and the original reason for this
- * hypercall.
- *
- */
-DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
-
-/*
- * Per CPU pages used if hypervisor supports VCPUOP_register_vcpu_info
- * hypercall. This can be used both in PV and PVHVM mode. The structure
- * overrides the default per_cpu(xen_vcpu, cpu) value.
- */
-DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
-
-/* Linux <-> Xen vCPU id mapping */
-DEFINE_PER_CPU(uint32_t, xen_vcpu_id);
-EXPORT_PER_CPU_SYMBOL(xen_vcpu_id);
-
 enum xen_domain_type xen_domain_type = XEN_NATIVE;
 EXPORT_SYMBOL_GPL(xen_domain_type);
 
@@ -112,12 +83,12 @@ int xen_cpuhp_setup(int (*cpu_up_prepare_cb)(unsigned int),
 	return rc >= 0 ? 0 : rc;
 }
 
-static int xen_vcpu_setup_restore(int cpu)
+static int xen_vcpu_setup_restore(xenhost_t *xh, int cpu)
 {
 	int rc = 0;
 
 	/* Any per_cpu(xen_vcpu) is stale, so reset it */
-	xen_vcpu_info_reset(cpu);
+	xen_vcpu_info_reset(xh, cpu);
 
 	/*
 	 * For PVH and PVHVM, setup online VCPUs only. The rest will
@@ -125,7 +96,7 @@ static int xen_vcpu_setup_restore(int cpu)
 	 */
 	if (xen_pv_domain() ||
 	    (xen_hvm_domain() && cpu_online(cpu))) {
-		rc = xen_vcpu_setup(cpu);
+		rc = xen_vcpu_setup(xh, cpu);
 	}
 
 	return rc;
@@ -138,30 +109,42 @@ static int xen_vcpu_setup_restore(int cpu)
  */
 void xen_vcpu_restore(void)
 {
-	int cpu, rc;
+	int cpu, rc = 0;
 
+	/*
+	 * VCPU management is primarily the responsibility of xh_default and
+	 * xh_remote only needs VCPUOP_register_vcpu_info.
+	 * So, we do VPUOP_down and VCPUOP_up only on xh_default.
+	 *
+	 * (Currently, however, VCPUOP_register_vcpu_info is allowed only
+	 * on VCPUs that are self or down, so we might need a new model
+	 * there.)
+	 */
 	for_each_possible_cpu(cpu) {
 		bool other_cpu = (cpu != smp_processor_id());
 		bool is_up;
+		xenhost_t **xh;
 
-		if (xen_vcpu_nr(cpu) == XEN_VCPU_ID_INVALID)
+		if (xen_vcpu_nr(xh_default, cpu) == XEN_VCPU_ID_INVALID)
 			continue;
 
 		/* Only Xen 4.5 and higher support this. */
 		is_up = HYPERVISOR_vcpu_op(VCPUOP_is_up,
-					   xen_vcpu_nr(cpu), NULL) > 0;
+					   xen_vcpu_nr(xh_default, cpu), NULL) > 0;
 
 		if (other_cpu && is_up &&
-		    HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(cpu), NULL))
+		    HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(xh_default, cpu), NULL))
 			BUG();
 
 		if (xen_pv_domain() || xen_feature(XENFEAT_hvm_safe_pvclock))
 			xen_setup_runstate_info(cpu);
 
-		rc = xen_vcpu_setup_restore(cpu);
-		if (rc)
-			pr_emerg_once("vcpu restore failed for cpu=%d err=%d. "
-					"System will hang.\n", cpu, rc);
+		for_each_xenhost(xh) {
+			rc = xen_vcpu_setup_restore(*xh, cpu);
+			if (rc)
+				pr_emerg_once("vcpu restore failed for cpu=%d err=%d. "
+						"System will hang.\n", cpu, rc);
+		}
 		/*
 		 * In case xen_vcpu_setup_restore() fails, do not bring up the
 		 * VCPU. This helps us avoid the resulting OOPS when the VCPU
@@ -172,29 +155,29 @@ void xen_vcpu_restore(void)
 		 * VCPUs to come up.
 		 */
 		if (other_cpu && is_up && (rc == 0) &&
-		    HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL))
+		    HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(xh_default, cpu), NULL))
 			BUG();
 	}
 }
 
-void xen_vcpu_info_reset(int cpu)
+void xen_vcpu_info_reset(xenhost_t *xh, int cpu)
 {
-	if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS) {
-		per_cpu(xen_vcpu, cpu) =
-			&xh_default->HYPERVISOR_shared_info->vcpu_info[xen_vcpu_nr(cpu)];
+	if (xen_vcpu_nr(xh, cpu) < MAX_VIRT_CPUS) {
+		xh->xen_vcpu[cpu] =
+			&xh->HYPERVISOR_shared_info->vcpu_info[xen_vcpu_nr(xh, cpu)];
 	} else {
 		/* Set to NULL so that if somebody accesses it we get an OOPS */
-		per_cpu(xen_vcpu, cpu) = NULL;
+		xh->xen_vcpu[cpu] = NULL;
 	}
 }
 
-int xen_vcpu_setup(int cpu)
+int xen_vcpu_setup(xenhost_t *xh, int cpu)
 {
 	struct vcpu_register_vcpu_info info;
 	int err;
 	struct vcpu_info *vcpup;
 
-	BUG_ON(xh_default->HYPERVISOR_shared_info == &xen_dummy_shared_info);
+	BUG_ON(xh->HYPERVISOR_shared_info == &xen_dummy_shared_info);
 
 	/*
 	 * This path is called on PVHVM at bootup (xen_hvm_smp_prepare_boot_cpu)
@@ -208,12 +191,12 @@ int xen_vcpu_setup(int cpu)
 	 * use this function.
 	 */
 	if (xen_hvm_domain()) {
-		if (per_cpu(xen_vcpu, cpu) == &per_cpu(xen_vcpu_info, cpu))
+		if (xh->xen_vcpu[cpu] == &xh->xen_vcpu_info[cpu])
 			return 0;
 	}
 
 	if (xen_have_vcpu_info_placement) {
-		vcpup = &per_cpu(xen_vcpu_info, cpu);
+		vcpup = &xh->xen_vcpu_info[cpu];
 		info.mfn = arbitrary_virt_to_mfn(vcpup);
 		info.offset = offset_in_page(vcpup);
 
@@ -227,8 +210,8 @@ int xen_vcpu_setup(int cpu)
 		 * hypercall does not allow to over-write info.mfn and
 		 * info.offset.
 		 */
-		err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info,
-					 xen_vcpu_nr(cpu), &info);
+		err = hypervisor_vcpu_op(xh, VCPUOP_register_vcpu_info,
+					 xen_vcpu_nr(xh, cpu), &info);
 
 		if (err) {
 			pr_warn_once("register_vcpu_info failed: cpu=%d err=%d\n",
@@ -239,14 +222,14 @@ int xen_vcpu_setup(int cpu)
 			 * This cpu is using the registered vcpu info, even if
 			 * later ones fail to.
 			 */
-			per_cpu(xen_vcpu, cpu) = vcpup;
+			xh->xen_vcpu[cpu] = vcpup;
 		}
 	}
 
 	if (!xen_have_vcpu_info_placement)
-		xen_vcpu_info_reset(cpu);
+		xen_vcpu_info_reset(xh, cpu);
 
-	return ((per_cpu(xen_vcpu, cpu) == NULL) ? -ENODEV : 0);
+	return ((xh->xen_vcpu[cpu] == NULL) ? -ENODEV : 0);
 }
 
 void xen_reboot(int reason)
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 0e53363f9d1f..c1981a3e4989 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -5,6 +5,7 @@
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 
+#include <xen/interface/xen.h>
 #include <xen/xenhost.h>
 #include <xen/features.h>
 #include <xen/events.h>
@@ -72,22 +73,22 @@ static void __init xen_hvm_init_mem_mapping(void)
 {
 	xenhost_t **xh;
 
-	for_each_xenhost(xh)
+	for_each_xenhost(xh) {
 		xenhost_reset_shared_info(*xh);
 
-	/*
-	 * The virtual address of the shared_info page has changed, so
-	 * the vcpu_info pointer for VCPU 0 is now stale.
-	 *
-	 * The prepare_boot_cpu callback will re-initialize it via
-	 * xen_vcpu_setup, but we can't rely on that to be called for
-	 * old Xen versions (xen_have_vector_callback == 0).
-	 *
-	 * It is, in any case, bad to have a stale vcpu_info pointer
-	 * so reset it now.
-	 * For now, this uses xh_default implictly.
-	 */
-	xen_vcpu_info_reset(0);
+		/*
+		 * The virtual address of the shared_info page has changed, so
+		 * the vcpu_info pointer for VCPU 0 is now stale.
+		 *
+		 * The prepare_boot_cpu callback will re-initialize it via
+		 * xen_vcpu_setup, but we can't rely on that to be called for
+		 * old Xen versions (xen_have_vector_callback == 0).
+		 *
+		 * It is, in any case, bad to have a stale vcpu_info pointer
+		 * so reset it now.
+		 */
+		xen_vcpu_info_reset(*xh, 0);
+	}
 }
 
 extern uint32_t xen_pv_cpuid_base(xenhost_t *xh);
@@ -103,11 +104,32 @@ void xen_hvm_setup_hypercall_page(xenhost_t *xh)
 	xh->hypercall_page = xen_hypercall_page;
 }
 
+static void xen_hvm_probe_vcpu_id(xenhost_t *xh, int cpu)
+{
+	uint32_t eax, ebx, ecx, edx, base;
+
+	base = xenhost_cpuid_base(xh);
+
+	if (cpu == 0) {
+		cpuid(base + 4, &eax, &ebx, &ecx, &edx);
+		if (eax & XEN_HVM_CPUID_VCPU_ID_PRESENT)
+			xh->xen_vcpu_id[cpu] = ebx;
+		else
+			xh->xen_vcpu_id[cpu] = smp_processor_id();
+	} else {
+		if (cpu_acpi_id(cpu) != U32_MAX)
+			xh->xen_vcpu_id[cpu] = cpu_acpi_id(cpu);
+		else
+			xh->xen_vcpu_id[cpu] = cpu;
+	}
+}
+
 xenhost_ops_t xh_hvm_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
 	.setup_hypercall_page = xen_hvm_setup_hypercall_page,
 	.setup_shared_info = xen_hvm_init_shared_info,
 	.reset_shared_info = xen_hvm_reset_shared_info,
+	.probe_vcpu_id = xen_hvm_probe_vcpu_id,
 };
 
 xenhost_ops_t xh_hvm_nested_ops = {
@@ -116,7 +138,7 @@ xenhost_ops_t xh_hvm_nested_ops = {
 static void __init init_hvm_pv_info(void)
 {
 	int major, minor;
-	uint32_t eax, ebx, ecx, edx, base;
+	uint32_t eax, base;
 	xenhost_t **xh;
 
 	base = xenhost_cpuid_base(xh_default);
@@ -147,11 +169,8 @@ static void __init init_hvm_pv_info(void)
 	if (xen_validate_features() == false)
 		__xenhost_unregister(xenhost_r2);
 
-	cpuid(base + 4, &eax, &ebx, &ecx, &edx);
-	if (eax & XEN_HVM_CPUID_VCPU_ID_PRESENT)
-		this_cpu_write(xen_vcpu_id, ebx);
-	else
-		this_cpu_write(xen_vcpu_id, smp_processor_id());
+	for_each_xenhost(xh)
+		xenhost_probe_vcpu_id(*xh, smp_processor_id());
 }
 
 #ifdef CONFIG_KEXEC_CORE
@@ -172,6 +191,7 @@ static void xen_hvm_crash_shutdown(struct pt_regs *regs)
 static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 {
 	int rc = 0;
+	xenhost_t **xh;
 
 	/*
 	 * This can happen if CPU was offlined earlier and
@@ -182,13 +202,12 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 		xen_uninit_lock_cpu(cpu);
 	}
 
-	if (cpu_acpi_id(cpu) != U32_MAX)
-		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
-	else
-		per_cpu(xen_vcpu_id, cpu) = cpu;
-	rc = xen_vcpu_setup(cpu);
-	if (rc)
-		return rc;
+	for_each_xenhost(xh) {
+		xenhost_probe_vcpu_id(*xh, cpu);
+		rc = xen_vcpu_setup(*xh, cpu);
+		if (rc)
+			return rc;
+	}
 
 	if (xen_have_vector_callback && xen_feature(XENFEAT_hvm_safe_pvclock))
 		xen_setup_timer(cpu);
@@ -229,15 +248,15 @@ static void __init xen_hvm_guest_init(void)
 	for_each_xenhost(xh) {
 		reserve_shared_info(*xh);
 		xenhost_setup_shared_info(*xh);
+
+		/*
+		 * xen_vcpu is a pointer to the vcpu_info struct in the
+		 * shared_info page, we use it in the event channel upcall
+		 * and in some pvclock related functions.
+		 */
+		xen_vcpu_info_reset(*xh, 0);
 	}
 
-	/*
-	 * xen_vcpu is a pointer to the vcpu_info struct in the shared_info
-	 * page, we use it in the event channel upcall and in some pvclock
-	 * related functions.
-	 * For now, this uses xh_default implictly.
-	 */
-	xen_vcpu_info_reset(0);
 
 	xen_panic_handler_init();
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 1a9eded4b76b..5f6a1475ec0c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -36,8 +36,8 @@
 
 #include <xen/xen.h>
 #include <xen/events.h>
-#include <xen/xenhost.h>
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <xen/interface/version.h>
 #include <xen/interface/physdev.h>
 #include <xen/interface/vcpu.h>
@@ -126,12 +126,12 @@ static void __init xen_pv_init_platform(void)
 
 	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
 
-	for_each_xenhost(xh)
+	for_each_xenhost(xh) {
 		xenhost_setup_shared_info(*xh);
 
-	/* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
-	/* For now this uses xh_default implicitly. */
-	xen_vcpu_info_reset(0);
+		/* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
+		xen_vcpu_info_reset(*xh, 0);
+	}
 
 	/* pvclock is in shared info area */
 	xen_init_time_ops();
@@ -973,28 +973,31 @@ static void xen_write_msr(unsigned int msr, unsigned low, unsigned high)
 /* This is called once we have the cpu_possible_mask */
 void __init xen_setup_vcpu_info_placement(void)
 {
+	xenhost_t **xh;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		/* Set up direct vCPU id mapping for PV guests. */
-		per_cpu(xen_vcpu_id, cpu) = cpu;
+		for_each_xenhost(xh) {
+			xenhost_probe_vcpu_id(*xh, cpu);
 
-		/*
-		 * xen_vcpu_setup(cpu) can fail  -- in which case it
-		 * falls back to the shared_info version for cpus
-		 * where xen_vcpu_nr(cpu) < MAX_VIRT_CPUS.
-		 *
-		 * xen_cpu_up_prepare_pv() handles the rest by failing
-		 * them in hotplug.
-		 */
-		(void) xen_vcpu_setup(cpu);
+			/*
+			 * xen_vcpu_setup(cpu) can fail  -- in which case it
+			 * falls back to the shared_info version for cpus
+			 * where xen_vcpu_nr(cpu) < MAX_VIRT_CPUS.
+			 *
+			 * xen_cpu_up_prepare_pv() handles the rest by failing
+			 * them in hotplug.
+			 */
+			(void) xen_vcpu_setup(*xh, cpu);
+		}
 	}
 
 	/*
 	 * xen_vcpu_setup managed to place the vcpu_info within the
 	 * percpu area for all cpus, so make use of it.
 	 */
-	if (xen_have_vcpu_info_placement) {
+	if (xen_have_vcpu_info_placement && false) {
+		/* Disable direct access until we have proper pcpu data structures. */
 		pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
 		pv_ops.irq.restore_fl =
 			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
@@ -1110,6 +1113,11 @@ static unsigned char xen_get_nmi_reason(void)
 {
 	unsigned char reason = 0;
 
+	/*
+	 * We could get this information from all the xenhosts and OR it.
+	 * But, the remote xenhost isn't really expected to send us NMIs.
+	 */
+
 	/* Construct a value which looks like it came from port 0x61. */
 	if (test_bit(_XEN_NMIREASON_io_error,
 		     &xh_default->HYPERVISOR_shared_info->arch.nmi_reason))
@@ -1222,6 +1230,12 @@ static void xen_pv_reset_shared_info(xenhost_t *xh)
 		BUG();
 }
 
+void xen_pv_probe_vcpu_id(xenhost_t *xh, int cpu)
+{
+	/* Set up direct vCPU id mapping for PV guests. */
+	xh->xen_vcpu_id[cpu] = cpu;
+}
+
 xenhost_ops_t xh_pv_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
 
@@ -1229,6 +1243,8 @@ xenhost_ops_t xh_pv_ops = {
 
 	.setup_shared_info = xen_pv_setup_shared_info,
 	.reset_shared_info = xen_pv_reset_shared_info,
+
+	.probe_vcpu_id = xen_pv_probe_vcpu_id,
 };
 
 xenhost_ops_t xh_pv_nested_ops = {
@@ -1283,7 +1299,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	 * Don't do the full vcpu_info placement stuff until we have
 	 * the cpu_possible_mask and a non-dummy shared_info.
 	 */
-	xen_vcpu_info_reset(0);
+	for_each_xenhost(xh) {
+		xen_vcpu_info_reset(*xh, 0);
+	}
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
@@ -1328,7 +1346,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	get_cpu_address_sizes(&boot_cpu_data);
 
 	/* Let's presume PV guests always boot on vCPU with id 0. */
-	per_cpu(xen_vcpu_id, 0) = 0;
+	/* Note: we should be doing this before xen_vcpu_info_reset above. */
+	for_each_xenhost(xh)
+		xenhost_probe_vcpu_id(*xh, 0);
 
 	idt_setup_early_handler();
 
@@ -1485,7 +1505,7 @@ static int xen_cpu_up_prepare_pv(unsigned int cpu)
 {
 	int rc;
 
-	if (per_cpu(xen_vcpu, cpu) == NULL)
+	if (xh_default->xen_vcpu[cpu] == NULL)
 		return -ENODEV;
 
 	xen_setup_timer(cpu);
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 50277dfbdf30..3f98526dd041 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -2,13 +2,14 @@
 #include <linux/acpi.h>
 
 #include <xen/hvc-console.h>
+#include <xen/interface/xen.h>
 
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
 
-#include <xen/xen.h>
 #include <xen/xenhost.h>
+#include <xen/xen.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 850c93f346c7..38ad1a1c4763 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -29,7 +29,7 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 	struct vcpu_info *vcpu;
 	unsigned long flags;
 
-	vcpu = this_cpu_read(xen_vcpu);
+	vcpu = xh_default->xen_vcpu[smp_processor_id()];
 
 	/* flag has opposite sense of mask */
 	flags = !vcpu->evtchn_upcall_mask;
@@ -51,7 +51,7 @@ __visible void xen_restore_fl(unsigned long flags)
 
 	/* See xen_irq_enable() for why preemption must be disabled. */
 	preempt_disable();
-	vcpu = this_cpu_read(xen_vcpu);
+	vcpu = xh_default->xen_vcpu[smp_processor_id()];
 	vcpu->evtchn_upcall_mask = flags;
 
 	if (flags == 0) {
@@ -70,7 +70,7 @@ asmlinkage __visible void xen_irq_disable(void)
 	   make sure we're don't switch CPUs between getting the vcpu
 	   pointer and updating the mask. */
 	preempt_disable();
-	this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1;
+	xh_default->xen_vcpu[smp_processor_id()]->evtchn_upcall_mask = 1;
 	preempt_enable_no_resched();
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
@@ -86,7 +86,7 @@ asmlinkage __visible void xen_irq_enable(void)
 	 */
 	preempt_disable();
 
-	vcpu = this_cpu_read(xen_vcpu);
+	vcpu = xh_default->xen_vcpu[smp_processor_id()];
 	vcpu->evtchn_upcall_mask = 0;
 
 	/* Doesn't matter if we get preempted here, because any
@@ -111,7 +111,7 @@ static void xen_halt(void)
 {
 	if (irqs_disabled())
 		HYPERVISOR_vcpu_op(VCPUOP_down,
-				   xen_vcpu_nr(smp_processor_id()), NULL);
+				   xen_vcpu_nr(xh_default, smp_processor_id()), NULL);
 	else
 		xen_safe_halt();
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 0f4fe206dcc2..e99af51ab481 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1304,17 +1304,17 @@ static void __init xen_pagetable_init(void)
 }
 static void xen_write_cr2(unsigned long cr2)
 {
-	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
+	xh_default->xen_vcpu[smp_processor_id()]->arch.cr2 = cr2;
 }
 
 static unsigned long xen_read_cr2(void)
 {
-	return this_cpu_read(xen_vcpu)->arch.cr2;
+	return xh_default->xen_vcpu[smp_processor_id()]->arch.cr2;
 }
 
 unsigned long xen_read_cr2_direct(void)
 {
-	return this_cpu_read(xen_vcpu_info.arch.cr2);
+	return xh_default->xen_vcpu_info[smp_processor_id()].arch.cr2;
 }
 
 static noinline void xen_flush_tlb(void)
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 33293ce01d8d..04f9b2e92f06 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -4,6 +4,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
+#include <xen/interface/xen.h>
 #include <xen/swiotlb-xen.h>
 
 #include <asm/xen/hypervisor.h>
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index d5f303c0e656..ec8f22a54f6e 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -19,6 +19,7 @@
 #include <asm/setup.h>
 #include <asm/acpi.h>
 #include <asm/numa.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7a43b2ae19f1..867524be0065 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -6,6 +6,7 @@
 #include <linux/percpu.h>
 
 #include <xen/events.h>
+#include <xen/xenhost.h>
 
 #include <xen/hvc-console.h>
 #include "xen-ops.h"
@@ -129,7 +130,10 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 		return;
 
 	for_each_online_cpu(cpu) {
-		if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS)
+		xenhost_t **xh;
+
+		if ((xen_vcpu_nr(xh_default, cpu) < MAX_VIRT_CPUS) &&
+			(!xh_remote || (xen_vcpu_nr(xh_remote, cpu) < MAX_VIRT_CPUS)))
 			continue;
 
 		rc = cpu_down(cpu);
@@ -138,7 +142,8 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 			/*
 			 * Reset vcpu_info so this cpu cannot be onlined again.
 			 */
-			xen_vcpu_info_reset(cpu);
+			for_each_xenhost(xh)
+				xen_vcpu_info_reset(*xh, cpu);
 			count++;
 		} else {
 			pr_warn("%s: failed to bring CPU %d down, error %d\n",
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index f8d39440b292..5e7f591bfdd9 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -9,6 +9,7 @@
 
 static void __init xen_hvm_smp_prepare_boot_cpu(void)
 {
+	xenhost_t **xh;
 	BUG_ON(smp_processor_id() != 0);
 	native_smp_prepare_boot_cpu();
 
@@ -16,7 +17,8 @@ static void __init xen_hvm_smp_prepare_boot_cpu(void)
 	 * Setup vcpu_info for boot CPU. Secondary CPUs get their vcpu_info
 	 * in xen_cpu_up_prepare_hvm().
 	 */
-	xen_vcpu_setup(0);
+	for_each_xenhost(xh)
+		xen_vcpu_setup(*xh, 0);
 
 	/*
 	 * The alternative logic (which patches the unlock/lock) runs before
@@ -29,6 +31,7 @@ static void __init xen_hvm_smp_prepare_boot_cpu(void)
 
 static void __init xen_hvm_smp_prepare_cpus(unsigned int max_cpus)
 {
+	xenhost_t **xh;
 	int cpu;
 
 	native_smp_prepare_cpus(max_cpus);
@@ -36,12 +39,14 @@ static void __init xen_hvm_smp_prepare_cpus(unsigned int max_cpus)
 
 	xen_init_lock_cpu(0);
 
-	for_each_possible_cpu(cpu) {
-		if (cpu == 0)
-			continue;
+	for_each_xenhost(xh) {
+		for_each_possible_cpu(cpu) {
+			if (cpu == 0)
+				continue;
 
-		/* Set default vcpu_id to make sure that we don't use cpu-0's */
-		per_cpu(xen_vcpu_id, cpu) = XEN_VCPU_ID_INVALID;
+			/* Set default vcpu_id to make sure that we don't use cpu-0's */
+			(*xh)->xen_vcpu_id[cpu] = XEN_VCPU_ID_INVALID;
+		}
 	}
 }
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 145506f9fdbe..6d9c3e6611ef 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -350,7 +350,7 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 	per_cpu(xen_cr3, cpu) = __pa(swapper_pg_dir);
 
 	ctxt->ctrlreg[3] = xen_pfn_to_cr3(virt_to_gfn(swapper_pg_dir));
-	if (HYPERVISOR_vcpu_op(VCPUOP_initialise, xen_vcpu_nr(cpu), ctxt))
+	if (HYPERVISOR_vcpu_op(VCPUOP_initialise, xen_vcpu_nr(xh_default, cpu), ctxt))
 		BUG();
 
 	kfree(ctxt);
@@ -374,7 +374,7 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 		return rc;
 
 	/* make sure interrupts start blocked */
-	per_cpu(xen_vcpu, cpu)->evtchn_upcall_mask = 1;
+	xh_default->xen_vcpu[cpu]->evtchn_upcall_mask = 1;
 
 	rc = cpu_initialize_context(cpu, idle);
 	if (rc)
@@ -382,7 +382,7 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 	xen_pmu_init(cpu);
 
-	rc = HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL);
+	rc = HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(xh_default, cpu), NULL);
 	BUG_ON(rc);
 
 	while (cpu_report_state(cpu) != CPU_ONLINE)
@@ -407,7 +407,7 @@ static int xen_pv_cpu_disable(void)
 static void xen_pv_cpu_die(unsigned int cpu)
 {
 	while (HYPERVISOR_vcpu_op(VCPUOP_is_up,
-				  xen_vcpu_nr(cpu), NULL)) {
+				  xen_vcpu_nr(xh_default, cpu), NULL)) {
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
@@ -423,7 +423,7 @@ static void xen_pv_cpu_die(unsigned int cpu)
 static void xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
 {
 	play_dead_common();
-	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(smp_processor_id()), NULL);
+	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(xh_default, smp_processor_id()), NULL);
 	cpu_bringup();
 	/*
 	 * commit 4b0c0f294 (tick: Cleanup NOHZ per cpu data on cpu down)
@@ -464,7 +464,7 @@ static void stop_self(void *v)
 
 	set_cpu_online(cpu, false);
 
-	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(cpu), NULL);
+	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(xh_default, cpu), NULL);
 	BUG();
 }
 
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index d4bb1f8b4f58..217bc4de07ee 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -18,12 +18,12 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/pvclock.h>
+#include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/events.h>
 #include <xen/features.h>
-#include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
 
 #include "xen-ops.h"
@@ -48,7 +48,7 @@ static u64 xen_clocksource_read(void)
 	u64 ret;
 
 	preempt_disable_notrace();
-	src = &__this_cpu_read(xen_vcpu)->time;
+	src = &xh_default->xen_vcpu[smp_processor_id()]->time;
 	ret = pvclock_clocksource_read(src);
 	preempt_enable_notrace();
 	return ret;
@@ -70,9 +70,10 @@ static void xen_read_wallclock(struct timespec64 *ts)
 	struct pvclock_wall_clock *wall_clock = &(s->wc);
         struct pvclock_vcpu_time_info *vcpu_time;
 
-	vcpu_time = &get_cpu_var(xen_vcpu)->time;
+	preempt_disable_notrace();
+	vcpu_time = &xh_default->xen_vcpu[smp_processor_id()]->time;
 	pvclock_read_wallclock(wall_clock, vcpu_time, ts);
-	put_cpu_var(xen_vcpu);
+	preempt_enable_notrace();
 }
 
 static void xen_get_wallclock(struct timespec64 *now)
@@ -233,9 +234,9 @@ static int xen_vcpuop_shutdown(struct clock_event_device *evt)
 {
 	int cpu = smp_processor_id();
 
-	if (HYPERVISOR_vcpu_op(VCPUOP_stop_singleshot_timer, xen_vcpu_nr(cpu),
+	if (HYPERVISOR_vcpu_op(VCPUOP_stop_singleshot_timer, xen_vcpu_nr(xh_default, cpu),
 			       NULL) ||
-	    HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(cpu),
+	    HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(xh_default, cpu),
 			       NULL))
 		BUG();
 
@@ -246,7 +247,7 @@ static int xen_vcpuop_set_oneshot(struct clock_event_device *evt)
 {
 	int cpu = smp_processor_id();
 
-	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(cpu),
+	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(xh_default, cpu),
 			       NULL))
 		BUG();
 
@@ -266,7 +267,7 @@ static int xen_vcpuop_set_next_event(unsigned long delta,
 	/* Get an event anyway, even if the timeout is already expired */
 	single.flags = 0;
 
-	ret = HYPERVISOR_vcpu_op(VCPUOP_set_singleshot_timer, xen_vcpu_nr(cpu),
+	ret = HYPERVISOR_vcpu_op(VCPUOP_set_singleshot_timer, xen_vcpu_nr(xh_default, cpu),
 				 &single);
 	BUG_ON(ret != 0);
 
@@ -366,7 +367,7 @@ void xen_timer_resume(void)
 
 	for_each_online_cpu(cpu) {
 		if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer,
-				       xen_vcpu_nr(cpu), NULL))
+				       xen_vcpu_nr(xh_default, cpu), NULL))
 			BUG();
 	}
 }
@@ -482,7 +483,7 @@ static void __init xen_time_init(void)
 
 	clocksource_register_hz(&xen_clocksource, NSEC_PER_SEC);
 
-	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(cpu),
+	if (HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, xen_vcpu_nr(xh_default, cpu),
 			       NULL) == 0) {
 		/* Successfully turned off 100Hz tick, so we have the
 		   vcpuop-based timer interface */
@@ -500,7 +501,7 @@ static void __init xen_time_init(void)
 	 * We check ahead on the primary time info if this
 	 * bit is supported hence speeding up Xen clocksource.
 	 */
-	pvti = &__this_cpu_read(xen_vcpu)->time;
+	pvti = &xh_default->xen_vcpu[smp_processor_id()]->time;
 	if (pvti->flags & PVCLOCK_TSC_STABLE_BIT) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 		xen_setup_vsyscall_time_info();
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 5085ce88a8d7..96fd7edea7e9 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -22,7 +22,6 @@ extern void *xen_initial_gdt;
 struct trap_info;
 void xen_copy_trap_info(struct trap_info *traps);
 
-DECLARE_PER_CPU(struct vcpu_info, xen_vcpu_info);
 DECLARE_PER_CPU(unsigned long, xen_cr3);
 DECLARE_PER_CPU(unsigned long, xen_current_cr3);
 
@@ -76,8 +75,8 @@ bool xen_vcpu_stolen(int vcpu);
 
 extern int xen_have_vcpu_info_placement;
 
-int xen_vcpu_setup(int cpu);
-void xen_vcpu_info_reset(int cpu);
+int xen_vcpu_setup(xenhost_t *xh, int cpu);
+void xen_vcpu_info_reset(xenhost_t *xh, int cpu);
 void xen_setup_vcpu_info_placement(void);
 
 #ifdef CONFIG_SMP
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 117e76b2f939..ae497876fe41 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -884,7 +884,7 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 		irq_set_chip_and_handler_name(irq, &xen_percpu_chip,
 					      handle_percpu_irq, "ipi");
 
-		bind_ipi.vcpu = xen_vcpu_nr(cpu);
+		bind_ipi.vcpu = xen_vcpu_nr(xh_default, cpu);
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
@@ -937,7 +937,7 @@ static int find_virq(unsigned int virq, unsigned int cpu)
 			continue;
 		if (status.status != EVTCHNSTAT_virq)
 			continue;
-		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
+		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(xh_default, cpu)) {
 			rc = port;
 			break;
 		}
@@ -980,7 +980,7 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 						      handle_edge_irq, "virq");
 
 		bind_virq.virq = virq;
-		bind_virq.vcpu = xen_vcpu_nr(cpu);
+		bind_virq.vcpu = xen_vcpu_nr(xh_default, cpu);
 		ret = HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
 						&bind_virq);
 		if (ret == 0)
@@ -1200,7 +1200,7 @@ void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
 
 #ifdef CONFIG_X86
 	if (unlikely(vector == XEN_NMI_VECTOR)) {
-		int rc =  HYPERVISOR_vcpu_op(VCPUOP_send_nmi, xen_vcpu_nr(cpu),
+		int rc =  HYPERVISOR_vcpu_op(VCPUOP_send_nmi, xen_vcpu_nr(xh_default, cpu),
 					     NULL);
 		if (rc < 0)
 			printk(KERN_WARNING "Sending nmi to CPU%d failed (rc:%d)\n", cpu, rc);
@@ -1306,7 +1306,7 @@ int xen_rebind_evtchn_to_cpu(int evtchn, unsigned tcpu)
 
 	/* Send future instances of this interrupt to other vcpu. */
 	bind_vcpu.port = evtchn;
-	bind_vcpu.vcpu = xen_vcpu_nr(tcpu);
+	bind_vcpu.vcpu = xen_vcpu_nr(xh_default, tcpu);
 
 	/*
 	 * Mask the event while changing the VCPU binding to prevent
@@ -1451,7 +1451,7 @@ static void restore_cpu_virqs(unsigned int cpu)
 
 		/* Get a new binding from Xen. */
 		bind_virq.virq = virq;
-		bind_virq.vcpu = xen_vcpu_nr(cpu);
+		bind_virq.vcpu = xen_vcpu_nr(xh_default, cpu);
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
 						&bind_virq) != 0)
 			BUG();
@@ -1475,7 +1475,7 @@ static void restore_cpu_ipis(unsigned int cpu)
 		BUG_ON(ipi_from_irq(irq) != ipi);
 
 		/* Get a new binding from Xen. */
-		bind_ipi.vcpu = xen_vcpu_nr(cpu);
+		bind_ipi.vcpu = xen_vcpu_nr(xh_default, cpu);
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 76b318e88382..eed766219dd0 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -113,7 +113,7 @@ static int init_control_block(int cpu,
 
 	init_control.control_gfn = virt_to_gfn(control_block);
 	init_control.offset      = 0;
-	init_control.vcpu        = xen_vcpu_nr(cpu);
+	init_control.vcpu        = xen_vcpu_nr(xh_default, cpu);
 
 	return HYPERVISOR_event_channel_op(EVTCHNOP_init_control, &init_control);
 }
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 6d1a5e58968f..66622109f2be 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -475,7 +475,7 @@ static long evtchn_ioctl(struct file *file,
 			break;
 
 		bind_virq.virq = bind.virq;
-		bind_virq.vcpu = xen_vcpu_nr(0);
+		bind_virq.vcpu = xen_vcpu_nr(xh_default, 0);
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
 						 &bind_virq);
 		if (rc != 0)
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859c29d0..feee74bbab0a 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -164,7 +164,7 @@ void xen_setup_runstate_info(int cpu)
 	area.addr.v = &per_cpu(xen_runstate, cpu);
 
 	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
-			       xen_vcpu_nr(cpu), &area))
+			       xen_vcpu_nr(xh_default, cpu), &area))
 		BUG();
 }
 
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 4969817124a8..75be9059893f 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -9,12 +9,9 @@
 #include <asm/xen/interface.h>
 #include <xen/interface/vcpu.h>
 
-DECLARE_PER_CPU(struct vcpu_info *, xen_vcpu);
-
-DECLARE_PER_CPU(uint32_t, xen_vcpu_id);
-static inline uint32_t xen_vcpu_nr(int cpu)
+static inline uint32_t xen_vcpu_nr(xenhost_t *xh, int cpu)
 {
-	return per_cpu(xen_vcpu_id, cpu);
+	return xh->xen_vcpu_id[cpu];
 }
 
 #define XEN_VCPU_ID_INVALID U32_MAX
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index 7c19c361d16e..f6092a8987f1 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -90,6 +90,28 @@ typedef struct {
 		struct shared_info *HYPERVISOR_shared_info;
 		unsigned long shared_info_pfn;
 	};
+
+	struct {
+		/*
+		 * Events on xen-evtchn ports show up in struct vcpu_info.
+		 * With multiple xenhosts, the evtchn-port numbering space that
+		 * was global so far is now attached to a xenhost.
+		 *
+		 * So, now we allocate vcpu_info for each processor (we had space
+		 * for only MAX_VIRT_CPUS in the shared_info above.)
+		 *
+		 * FIXME we statically allocate for NR_CPUS because alloc_percpu()
+		 * isn't available at PV boot time but this is slow.
+		 */
+		struct vcpu_info xen_vcpu_info[NR_CPUS];
+		struct vcpu_info *xen_vcpu[NR_CPUS];
+
+		/*
+		 * Different xenhosts might have different Linux <-> Xen vCPU-id
+		 * mapping.
+		 */
+		uint32_t xen_vcpu_id[NR_CPUS];
+	};
 } xenhost_t;
 
 typedef struct xenhost_ops {
@@ -139,6 +161,26 @@ typedef struct xenhost_ops {
 	 */
 	void (*setup_shared_info)(xenhost_t *xenhost);
 	void (*reset_shared_info)(xenhost_t *xenhost);
+
+	/*
+	 * vcpu_info, vcpu_id: needs to be setup early -- all IRQ code accesses
+	 * relevant bits.
+	 *
+	 * vcpu_id is probed on PVH/PVHVM via xen_cpuid(). For PV, its direct
+	 * mapped to smp_processor_id().
+	 *
+	 * This is part of xenhost_t because we might be registered with two
+	 * different xenhosts and both of those might have their own vcpu
+	 * numbering.
+	 *
+	 * After the vcpu numbering is identified, we can go ahead and register
+	 * vcpu_info with the xenhost; on the default xenhost this happens via
+	 * the register_vcpu_info hypercall.
+	 *
+	 * Once vcpu_info is setup (this or the shared_info version), it would
+	 * get accessed via pv_ops.irq.* and the evtchn logic.
+	 */
+	void (*probe_vcpu_id)(xenhost_t *xenhost, int cpu);
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
@@ -185,4 +227,9 @@ static inline void xenhost_reset_shared_info(xenhost_t *xh)
 	(xh->ops->reset_shared_info)(xh);
 }
 
+static inline void xenhost_probe_vcpu_id(xenhost_t *xh, int cpu)
+{
+	(xh->ops->probe_vcpu_id)(xh, cpu);
+}
+
 #endif /* __XENHOST_H */
-- 
2.20.1

