Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B240C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0288220656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="spVuxRCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfEIRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:25:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41764 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEIRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJOuG162294;
        Thu, 9 May 2019 17:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=xKaWUTPxoAdRgRwrnAu0b/RxKcJyVaoRHJ5cOvwh/Bo=;
 b=spVuxRCIt6FBa+0E0VI7CYTUJpSoqEXh7t8i5ftOhVY7z0dGkqeDr3G54nGCco1X6h4z
 iKH8E8975z1S8UYyfIgx5SNQyvjBGPSZ+JIb1EVC1j0mg1Y8jhVPNVHmLWWYQxgyR7kX
 lOCDyjMZXoRfzyYdut/56U0I+9B1e0BEfjGoYLfi4QILMdN0EI1qhyKUmyc4aSZAulcp
 wB3ssIRmxZ84RGGBXkBuM5bGzx2s2kfLmzsRpM/isosTsKY/ilQ6msZCbRYfo3NwhoQV
 9ZEe1pMiS45WQxDrFoO4+MZ53sVtUjx81BIGnS0x9uJpN2VK2mraZGTjpR7njbBtkGw6 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6ceyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP7wF152264;
        Thu, 9 May 2019 17:25:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2schvyy7vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:40 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPdhC019240;
        Thu, 9 May 2019 17:25:39 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:39 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 06/16] x86/xen: add shared_info support to xenhost_t
Date:   Thu,  9 May 2019 10:25:30 -0700
Message-Id: <20190509172540.12398-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=553
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=585 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYPERVISOR_shared_info is used for irq/evtchn communication between the
guest and the host. Abstract out the setup/reset in xenhost_t such that
nested configurations can use both xenhosts simultaneously.

In addition to irq/evtchn communication, shared_info is also used for
pvclock and p2m related state. For both of those, remote xenhost is not
of interest so we only use the default xenhost.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/xen/hypervisor.h |  1 -
 arch/x86/xen/enlighten.c              | 10 ++-----
 arch/x86/xen/enlighten_hvm.c          | 38 +++++++++++++++++---------
 arch/x86/xen/enlighten_pv.c           | 28 ++++++++++++++++---
 arch/x86/xen/p2m.c                    | 24 ++++++++---------
 arch/x86/xen/suspend_hvm.c            |  6 ++++-
 arch/x86/xen/suspend_pv.c             | 14 +++++-----
 arch/x86/xen/time.c                   |  4 +--
 arch/x86/xen/xen-ops.h                |  2 --
 arch/x86/xen/xenhost.c                | 13 ++++++++-
 drivers/xen/events/events_2l.c        | 16 +++++------
 include/xen/xenhost.h                 | 39 +++++++++++++++++++++++++++
 12 files changed, 138 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 6c4cdcdf997d..3e6bd455fbd0 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -33,7 +33,6 @@
 #ifndef _ASM_X86_XEN_HYPERVISOR_H
 #define _ASM_X86_XEN_HYPERVISOR_H
 
-extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
 #include <asm/processor.h>
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index f88bb14da3f2..20e0de844442 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -72,12 +72,6 @@ EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 uint32_t xen_start_flags __attribute__((section(".data"))) = 0;
 EXPORT_SYMBOL(xen_start_flags);
 
-/*
- * Point at some empty memory to start with. We map the real shared_info
- * page as soon as fixmap is up and running.
- */
-struct shared_info *HYPERVISOR_shared_info = &xen_dummy_shared_info;
-
 /*
  * Flag to determine whether vcpu info placement is available on all
  * VCPUs.  We assume it is to start with, and then set it to zero on
@@ -187,7 +181,7 @@ void xen_vcpu_info_reset(int cpu)
 {
 	if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS) {
 		per_cpu(xen_vcpu, cpu) =
-			&HYPERVISOR_shared_info->vcpu_info[xen_vcpu_nr(cpu)];
+			&xh_default->HYPERVISOR_shared_info->vcpu_info[xen_vcpu_nr(cpu)];
 	} else {
 		/* Set to NULL so that if somebody accesses it we get an OOPS */
 		per_cpu(xen_vcpu, cpu) = NULL;
@@ -200,7 +194,7 @@ int xen_vcpu_setup(int cpu)
 	int err;
 	struct vcpu_info *vcpup;
 
-	BUG_ON(HYPERVISOR_shared_info == &xen_dummy_shared_info);
+	BUG_ON(xh_default->HYPERVISOR_shared_info == &xen_dummy_shared_info);
 
 	/*
 	 * This path is called on PVHVM at bootup (xen_hvm_smp_prepare_boot_cpu)
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index a118b61a1a8a..0e53363f9d1f 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -26,21 +26,25 @@
 #include "mmu.h"
 #include "smp.h"
 
-static unsigned long shared_info_pfn;
-
-void xen_hvm_init_shared_info(void)
+static void xen_hvm_init_shared_info(xenhost_t *xh)
 {
 	struct xen_add_to_physmap xatp;
 
 	xatp.domid = DOMID_SELF;
 	xatp.idx = 0;
 	xatp.space = XENMAPSPACE_shared_info;
-	xatp.gpfn = shared_info_pfn;
-	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
+	xatp.gpfn = xh->shared_info_pfn;
+	if (hypervisor_memory_op(xh, XENMEM_add_to_physmap, &xatp))
 		BUG();
 }
 
-static void __init reserve_shared_info(void)
+static void xen_hvm_reset_shared_info(xenhost_t *xh)
+{
+	early_memunmap(xh->HYPERVISOR_shared_info, PAGE_SIZE);
+	xh->HYPERVISOR_shared_info = __va(PFN_PHYS(xh->shared_info_pfn));
+}
+
+static void __init reserve_shared_info(xenhost_t *xh)
 {
 	u64 pa;
 
@@ -58,16 +62,18 @@ static void __init reserve_shared_info(void)
 	     pa += PAGE_SIZE)
 		;
 
-	shared_info_pfn = PHYS_PFN(pa);
+	xh->shared_info_pfn = PHYS_PFN(pa);
 
 	memblock_reserve(pa, PAGE_SIZE);
-	HYPERVISOR_shared_info = early_memremap(pa, PAGE_SIZE);
+	xh->HYPERVISOR_shared_info = early_memremap(pa, PAGE_SIZE);
 }
 
 static void __init xen_hvm_init_mem_mapping(void)
 {
-	early_memunmap(HYPERVISOR_shared_info, PAGE_SIZE);
-	HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
+	xenhost_t **xh;
+
+	for_each_xenhost(xh)
+		xenhost_reset_shared_info(*xh);
 
 	/*
 	 * The virtual address of the shared_info page has changed, so
@@ -79,6 +85,7 @@ static void __init xen_hvm_init_mem_mapping(void)
 	 *
 	 * It is, in any case, bad to have a stale vcpu_info pointer
 	 * so reset it now.
+	 * For now, this uses xh_default implictly.
 	 */
 	xen_vcpu_info_reset(0);
 }
@@ -99,6 +106,8 @@ void xen_hvm_setup_hypercall_page(xenhost_t *xh)
 xenhost_ops_t xh_hvm_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
 	.setup_hypercall_page = xen_hvm_setup_hypercall_page,
+	.setup_shared_info = xen_hvm_init_shared_info,
+	.reset_shared_info = xen_hvm_reset_shared_info,
 };
 
 xenhost_ops_t xh_hvm_nested_ops = {
@@ -204,6 +213,8 @@ static int xen_cpu_dead_hvm(unsigned int cpu)
 
 static void __init xen_hvm_guest_init(void)
 {
+	xenhost_t **xh;
+
 	if (xen_pv_domain())
 		return;
 	/*
@@ -215,13 +226,16 @@ static void __init xen_hvm_guest_init(void)
 
 	init_hvm_pv_info();
 
-	reserve_shared_info();
-	xen_hvm_init_shared_info();
+	for_each_xenhost(xh) {
+		reserve_shared_info(*xh);
+		xenhost_setup_shared_info(*xh);
+	}
 
 	/*
 	 * xen_vcpu is a pointer to the vcpu_info struct in the shared_info
 	 * page, we use it in the event channel upcall and in some pvclock
 	 * related functions.
+	 * For now, this uses xh_default implictly.
 	 */
 	xen_vcpu_info_reset(0);
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 484968ff16a4..1a9eded4b76b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -122,12 +122,15 @@ static void __init xen_banner(void)
 
 static void __init xen_pv_init_platform(void)
 {
+	xenhost_t **xh;
+
 	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
 
-	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
-	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
+	for_each_xenhost(xh)
+		xenhost_setup_shared_info(*xh);
 
 	/* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
+	/* For now this uses xh_default implicitly. */
 	xen_vcpu_info_reset(0);
 
 	/* pvclock is in shared info area */
@@ -1109,10 +1112,10 @@ static unsigned char xen_get_nmi_reason(void)
 
 	/* Construct a value which looks like it came from port 0x61. */
 	if (test_bit(_XEN_NMIREASON_io_error,
-		     &HYPERVISOR_shared_info->arch.nmi_reason))
+		     &xh_default->HYPERVISOR_shared_info->arch.nmi_reason))
 		reason |= NMI_REASON_IOCHK;
 	if (test_bit(_XEN_NMIREASON_pci_serr,
-		     &HYPERVISOR_shared_info->arch.nmi_reason))
+		     &xh_default->HYPERVISOR_shared_info->arch.nmi_reason))
 		reason |= NMI_REASON_SERR;
 
 	return reason;
@@ -1205,10 +1208,27 @@ static void xen_pv_setup_hypercall_page(xenhost_t *xh)
 	xh->hypercall_page = xen_hypercall_page;
 }
 
+static void xen_pv_setup_shared_info(xenhost_t *xh)
+{
+	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
+	xh->HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
+}
+
+static void xen_pv_reset_shared_info(xenhost_t *xh)
+{
+	xh->HYPERVISOR_shared_info = &xen_dummy_shared_info;
+	if (hypervisor_update_va_mapping(xh, fix_to_virt(FIX_PARAVIRT_BOOTMAP),
+						 __pte_ma(0), 0))
+		BUG();
+}
+
 xenhost_ops_t xh_pv_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
 
 	.setup_hypercall_page = xen_pv_setup_hypercall_page,
+
+	.setup_shared_info = xen_pv_setup_shared_info,
+	.reset_shared_info = xen_pv_reset_shared_info,
 };
 
 xenhost_ops_t xh_pv_nested_ops = {
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 055e37e43541..8200a9582246 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -270,17 +270,17 @@ void __ref xen_build_mfn_list_list(void)
 
 void xen_setup_mfn_list_list(void)
 {
-	BUG_ON(HYPERVISOR_shared_info == &xen_dummy_shared_info);
+	BUG_ON(xh_default->HYPERVISOR_shared_info == &xen_dummy_shared_info);
 
 	if (xen_start_info->flags & SIF_VIRT_P2M_4TOOLS)
-		HYPERVISOR_shared_info->arch.pfn_to_mfn_frame_list_list = ~0UL;
+		xh_default->HYPERVISOR_shared_info->arch.pfn_to_mfn_frame_list_list = ~0UL;
 	else
-		HYPERVISOR_shared_info->arch.pfn_to_mfn_frame_list_list =
+		xh_default->HYPERVISOR_shared_info->arch.pfn_to_mfn_frame_list_list =
 			virt_to_mfn(p2m_top_mfn);
-	HYPERVISOR_shared_info->arch.max_pfn = xen_p2m_last_pfn;
-	HYPERVISOR_shared_info->arch.p2m_generation = 0;
-	HYPERVISOR_shared_info->arch.p2m_vaddr = (unsigned long)xen_p2m_addr;
-	HYPERVISOR_shared_info->arch.p2m_cr3 =
+	xh_default->HYPERVISOR_shared_info->arch.max_pfn = xen_p2m_last_pfn;
+	xh_default->HYPERVISOR_shared_info->arch.p2m_generation = 0;
+	xh_default->HYPERVISOR_shared_info->arch.p2m_vaddr = (unsigned long)xen_p2m_addr;
+	xh_default->HYPERVISOR_shared_info->arch.p2m_cr3 =
 		xen_pfn_to_cr3(virt_to_mfn(swapper_pg_dir));
 }
 
@@ -496,12 +496,12 @@ static pte_t *alloc_p2m_pmd(unsigned long addr, pte_t *pte_pg)
 
 		ptechk = lookup_address(vaddr, &level);
 		if (ptechk == pte_pg) {
-			HYPERVISOR_shared_info->arch.p2m_generation++;
+			xh_default->HYPERVISOR_shared_info->arch.p2m_generation++;
 			wmb(); /* Tools are synchronizing via p2m_generation. */
 			set_pmd(pmdp,
 				__pmd(__pa(pte_newpg[i]) | _KERNPG_TABLE));
 			wmb(); /* Tools are synchronizing via p2m_generation. */
-			HYPERVISOR_shared_info->arch.p2m_generation++;
+			xh_default->HYPERVISOR_shared_info->arch.p2m_generation++;
 			pte_newpg[i] = NULL;
 		}
 
@@ -597,12 +597,12 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 		spin_lock_irqsave(&p2m_update_lock, flags);
 
 		if (pte_pfn(*ptep) == p2m_pfn) {
-			HYPERVISOR_shared_info->arch.p2m_generation++;
+			xh_default->HYPERVISOR_shared_info->arch.p2m_generation++;
 			wmb(); /* Tools are synchronizing via p2m_generation. */
 			set_pte(ptep,
 				pfn_pte(PFN_DOWN(__pa(p2m)), PAGE_KERNEL));
 			wmb(); /* Tools are synchronizing via p2m_generation. */
-			HYPERVISOR_shared_info->arch.p2m_generation++;
+			xh_default->HYPERVISOR_shared_info->arch.p2m_generation++;
 			if (mid_mfn)
 				mid_mfn[p2m_mid_index(pfn)] = virt_to_mfn(p2m);
 			p2m = NULL;
@@ -617,7 +617,7 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 	/* Expanded the p2m? */
 	if (pfn > xen_p2m_last_pfn) {
 		xen_p2m_last_pfn = pfn;
-		HYPERVISOR_shared_info->arch.max_pfn = xen_p2m_last_pfn;
+		xh_default->HYPERVISOR_shared_info->arch.max_pfn = xen_p2m_last_pfn;
 	}
 
 	return 0;
diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index e666b614cf6d..cc9a0163845c 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 
 #include <xen/xen.h>
+#include <xen/xenhost.h>
 #include <xen/features.h>
 #include <xen/interface/features.h>
 
@@ -10,7 +11,10 @@
 void xen_hvm_post_suspend(int suspend_cancelled)
 {
 	if (!suspend_cancelled) {
-		xen_hvm_init_shared_info();
+		xenhost_t **xh;
+
+		for_each_xenhost(xh)
+			xenhost_setup_shared_info(*xh);
 		xen_vcpu_restore();
 	}
 	xen_callback_vector();
diff --git a/arch/x86/xen/suspend_pv.c b/arch/x86/xen/suspend_pv.c
index 8303b58c79a9..87af0c0cc66f 100644
--- a/arch/x86/xen/suspend_pv.c
+++ b/arch/x86/xen/suspend_pv.c
@@ -10,6 +10,8 @@
 
 void xen_pv_pre_suspend(void)
 {
+	xenhost_t **xh;
+
 	xen_mm_pin_all();
 
 	xen_start_info->store_mfn = mfn_to_pfn(xen_start_info->store_mfn);
@@ -18,17 +20,17 @@ void xen_pv_pre_suspend(void)
 
 	BUG_ON(!irqs_disabled());
 
-	HYPERVISOR_shared_info = &xen_dummy_shared_info;
-	if (HYPERVISOR_update_va_mapping(fix_to_virt(FIX_PARAVIRT_BOOTMAP),
-					 __pte_ma(0), 0))
-		BUG();
+	for_each_xenhost(xh)
+		xenhost_reset_shared_info(*xh);
 }
 
 void xen_pv_post_suspend(int suspend_cancelled)
 {
+	xenhost_t **xh;
+
 	xen_build_mfn_list_list();
-	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
-	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
+	for_each_xenhost(xh)
+		xenhost_setup_shared_info(*xh);
 	xen_setup_mfn_list_list();
 
 	if (suspend_cancelled) {
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 6e29794573b7..d4bb1f8b4f58 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -37,7 +37,7 @@ static u64 xen_sched_clock_offset __read_mostly;
 static unsigned long xen_tsc_khz(void)
 {
 	struct pvclock_vcpu_time_info *info =
-		&HYPERVISOR_shared_info->vcpu_info[0].time;
+		&xh_default->HYPERVISOR_shared_info->vcpu_info[0].time;
 
 	return pvclock_tsc_khz(info);
 }
@@ -66,7 +66,7 @@ static u64 xen_sched_clock(void)
 
 static void xen_read_wallclock(struct timespec64 *ts)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	struct pvclock_wall_clock *wall_clock = &(s->wc);
         struct pvclock_vcpu_time_info *vcpu_time;
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0e60bd918695..5085ce88a8d7 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -28,7 +28,6 @@ DECLARE_PER_CPU(unsigned long, xen_current_cr3);
 
 extern struct start_info *xen_start_info;
 extern struct shared_info xen_dummy_shared_info;
-extern struct shared_info *HYPERVISOR_shared_info;
 
 void xen_setup_mfn_list_list(void);
 void xen_build_mfn_list_list(void);
@@ -56,7 +55,6 @@ void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
 
 void xen_callback_vector(void);
-void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
 
 void __init xen_build_dynamic_phys_to_machine(void);
diff --git a/arch/x86/xen/xenhost.c b/arch/x86/xen/xenhost.c
index ca90acd7687e..3d8ccef89dcd 100644
--- a/arch/x86/xen/xenhost.c
+++ b/arch/x86/xen/xenhost.c
@@ -2,8 +2,19 @@
 #include <linux/bug.h>
 #include <xen/xen.h>
 #include <xen/xenhost.h>
+#include "xen-ops.h"
 
-xenhost_t xenhosts[2];
+/*
+ * Point at some empty memory to start with. On PV, we map the real shared_info
+ * page as soon as fixmap is up and running and PVH* doesn't use this.
+ */
+xenhost_t xenhosts[2] = {
+	/*
+	 * We should probably have two separate dummy shared_info pages.
+	 */
+	[0].HYPERVISOR_shared_info = &xen_dummy_shared_info,
+	[1].HYPERVISOR_shared_info = &xen_dummy_shared_info,
+};
 /*
  * xh_default: interface to the regular hypervisor. xenhost_type is xenhost_r0
  * or xenhost_r1.
diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index 8edef51c92e5..f09dbe4e9c33 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -55,37 +55,37 @@ static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned cpu)
 
 static void evtchn_2l_clear_pending(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_clear_bit(port, BM(&s->evtchn_pending[0]));
 }
 
 static void evtchn_2l_set_pending(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_pending[0]));
 }
 
 static bool evtchn_2l_is_pending(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	return sync_test_bit(port, BM(&s->evtchn_pending[0]));
 }
 
 static bool evtchn_2l_test_and_set_mask(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	return sync_test_and_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
 static void evtchn_2l_mask(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
 static void evtchn_2l_unmask(unsigned port)
 {
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	unsigned int cpu = get_cpu();
 	int do_hypercall = 0, evtchn_pending = 0;
 
@@ -167,7 +167,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 	int start_word_idx, start_bit_idx;
 	int word_idx, bit_idx;
 	int i;
-	struct shared_info *s = HYPERVISOR_shared_info;
+	struct shared_info *s = xh_default->HYPERVISOR_shared_info;
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
 
 	/* Timer interrupt has highest priority. */
@@ -264,7 +264,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 
 irqreturn_t xen_debug_interrupt(int irq, void *dev_id)
 {
-	struct shared_info *sh = HYPERVISOR_shared_info;
+	struct shared_info *sh = xh_default->HYPERVISOR_shared_info;
 	int cpu = smp_processor_id();
 	xen_ulong_t *cpu_evtchn = per_cpu(cpu_evtchn_mask, cpu);
 	int i;
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index dd1e2b64f50d..7c19c361d16e 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -82,6 +82,14 @@ typedef struct {
 	 * bounce callbacks via L1-Xen.
 	 */
 	u8 features[XENFEAT_NR_SUBMAPS * 32];
+
+	/*
+	 * shared-info to communicate with this xenhost instance.
+	 */
+	struct {
+		struct shared_info *HYPERVISOR_shared_info;
+		unsigned long shared_info_pfn;
+	};
 } xenhost_t;
 
 typedef struct xenhost_ops {
@@ -111,6 +119,26 @@ typedef struct xenhost_ops {
 	 *    to decide which particular L1-guest was the caller.
 	 */
 	void (*setup_hypercall_page)(xenhost_t *xenhost);
+
+	/*
+	 * shared_info: needed before vcpu-info setup.
+	 *
+	 * Needed early because Xen needs it for irq_disable() and such.
+	 * On PV first a dummy_shared_info is setup which eventually gets
+	 * switched to the real one so this needs to support switching
+	 * xenhost.
+	 *
+	 * Reset for PV is done differently from HVM, so provide a
+	 * separate interface.
+	 *
+	 *  xenhost_r0: point xenhost->HYPERVISOR_shared_info to a
+	 *    newly allocated shared_info page.
+	 *  xenhost_r1: similar to what we do now.
+	 *  xenhost_r2: new remote hypercall to setup a shared_info page.
+	 *    This is where we would now handle L0-Xen irq/evtchns.
+	 */
+	void (*setup_shared_info)(xenhost_t *xenhost);
+	void (*reset_shared_info)(xenhost_t *xenhost);
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
@@ -146,4 +174,15 @@ static inline void xenhost_setup_hypercall_page(xenhost_t *xh)
 	(xh->ops->setup_hypercall_page)(xh);
 }
 
+
+static inline void xenhost_setup_shared_info(xenhost_t *xh)
+{
+	(xh->ops->setup_shared_info)(xh);
+}
+
+static inline void xenhost_reset_shared_info(xenhost_t *xh)
+{
+	(xh->ops->reset_shared_info)(xh);
+}
+
 #endif /* __XENHOST_H */
-- 
2.20.1

