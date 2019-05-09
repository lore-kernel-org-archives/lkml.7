Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6863020656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgaV2BVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfEIR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41856 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfEIRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJNDR162267;
        Thu, 9 May 2019 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=zCzFQDoK69hNVAh8gq852QANu8+0XDEc/eDcX80GMqk=;
 b=OgaV2BVA2iW8FAFJxgTjjlCJjgqKAbnyuKTgPt7MyPWTUZEcIShqzFMgSiFsYB178J4t
 WePWZgCCPzdZypVU20IPA2gHQxUIxry3uq5hYU9jJWDEjhZML6l5gcIO6YvJ2mEOrora
 9HEpRnMZ9X0NnHq8UYv7Q8teUybowuzcPDVy6vq0kUiZlZmZM5pPYr5GCpDCXG/qeIho
 g4VlX/CojoagSg9ND2/LOM0ezOpa/2RhMW3HLIs2GVZnoEWJaliFmdsgs5tSY1/142Ax
 zzRGYVeCzOxmfSHmUCV8+kwBWs5XisxVL7vLuuPsVIXpsIcAnWJTWkxpJN+R/4nVRWBy KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s94b6ceyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HPh5B086806;
        Thu, 9 May 2019 17:25:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s94agwu19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPadr013211;
        Thu, 9 May 2019 17:25:36 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:36 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 02/16] x86/xen: cpuid support in xenhost_t
Date:   Thu,  9 May 2019 10:25:26 -0700
Message-Id: <20190509172540.12398-3-ankur.a.arora@oracle.com>
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

xen_cpuid_base() is used to probe and setup features early in a
guest's lifetime.

We want this to behave differently depending on xenhost->type: for
instance, local xenhosts cannot intercept the cpuid instruction at all.

Add op (*cpuid_base)() in xenhost_ops_t.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/xen/hypervisor.h |  2 +-
 arch/x86/pci/xen.c                    |  2 +-
 arch/x86/xen/enlighten_hvm.c          |  7 +++++--
 arch/x86/xen/enlighten_pv.c           | 16 +++++++++++++++-
 arch/x86/xen/enlighten_pvh.c          |  4 ++++
 drivers/tty/hvc/hvc_xen.c             |  2 +-
 drivers/xen/grant-table.c             |  3 ++-
 drivers/xen/xenbus/xenbus_xs.c        |  3 ++-
 include/xen/xenhost.h                 | 21 +++++++++++++++++++++
 9 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 39171b3646bb..6c4cdcdf997d 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -53,7 +53,7 @@ static inline bool xen_x2apic_para_available(void)
 #else
 static inline bool xen_x2apic_para_available(void)
 {
-	return (xen_cpuid_base() != 0);
+	return (xen_cpuid_base(NULL) != 0);
 }
 #endif
 
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 9112d1cb397b..d1a3b9f08289 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -431,7 +431,7 @@ void __init xen_msi_init(void)
 		 * event channels for MSI handling and instead use regular
 		 * APIC processing
 		 */
-		uint32_t eax = cpuid_eax(xen_cpuid_base() + 4);
+		uint32_t eax = cpuid_eax(xenhost_cpuid_base(xh_default) + 4);
 
 		if (((eax & XEN_HVM_CPUID_X2APIC_VIRT) && x2apic_mode) ||
 		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && boot_cpu_has(X86_FEATURE_APIC)))
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 100452f4f44c..ffc5791675b2 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -83,7 +83,10 @@ static void __init xen_hvm_init_mem_mapping(void)
 	xen_vcpu_info_reset(0);
 }
 
+extern uint32_t xen_pv_cpuid_base(xenhost_t *xh);
+
 xenhost_ops_t xh_hvm_ops = {
+	.cpuid_base = xen_pv_cpuid_base,
 };
 
 xenhost_ops_t xh_hvm_nested_ops = {
@@ -94,7 +97,7 @@ static void __init init_hvm_pv_info(void)
 	int major, minor;
 	uint32_t eax, ebx, ecx, edx, base;
 
-	base = xen_cpuid_base();
+	base = xenhost_cpuid_base(xh_default);
 	eax = cpuid_eax(base + 1);
 
 	major = eax >> 16;
@@ -250,7 +253,7 @@ static uint32_t __init xen_platform_hvm(void)
 	if (xen_pv_domain() || xen_nopv)
 		return 0;
 
-	return xen_cpuid_base();
+	return xenhost_cpuid_base(xh_default);
 }
 
 static __init void xen_hvm_guest_late_init(void)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index bb6e811c1525..a4e04b0cc596 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1189,10 +1189,23 @@ static void __init xen_dom0_set_legacy_features(void)
 	x86_platform.legacy.rtc = 1;
 }
 
+uint32_t xen_pv_cpuid_base(xenhost_t *xh)
+{
+	return hypervisor_cpuid_base("XenVMMXenVMM", 2);
+}
+
+uint32_t xen_pv_nested_cpuid_base(xenhost_t *xh)
+{
+	return hypervisor_cpuid_base("XenVMMXenVMM",
+				2 /* nested specific leaf? */);
+}
+
 xenhost_ops_t xh_pv_ops = {
+	.cpuid_base = xen_pv_cpuid_base,
 };
 
 xenhost_ops_t xh_pv_nested_ops = {
+	.cpuid_base = xen_pv_nested_cpuid_base,
 };
 
 /* First C function to be called on Xen boot */
@@ -1469,7 +1482,8 @@ static int xen_cpu_dead_pv(unsigned int cpu)
 static uint32_t __init xen_platform_pv(void)
 {
 	if (xen_pv_domain())
-		return xen_cpuid_base();
+		/* xenhost is setup in xen_start_kernel. */
+		return xenhost_cpuid_base(xh_default);
 
 	return 0;
 }
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 826c296d27a3..c07eba169572 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -29,6 +29,10 @@ void __init xen_pvh_init(void)
 	u32 msr;
 	u64 pfn;
 
+	/*
+	 * Note: we have already called xen_cpuid_base() in
+	 * hypervisor_specific_init()
+	 */
 	xenhost_register(xenhost_r1, &xh_hvm_ops);
 
 	/*
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index dc43fa96c3de..5e5ca35d7187 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -595,7 +595,7 @@ console_initcall(xen_cons_init);
 #ifdef CONFIG_X86
 static void xen_hvm_early_write(uint32_t vtermno, const char *str, int len)
 {
-	if (xen_cpuid_base())
+	if (xen_cpuid_base(xh_default))
 		outsb(0xe9, str, len);
 }
 #else
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7ea6fb6a2e5d..98af259d0d4f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -50,6 +50,7 @@
 #endif
 
 #include <xen/xen.h>
+#include <xen/xenhost.h>
 #include <xen/interface/xen.h>
 #include <xen/page.h>
 #include <xen/grant_table.h>
@@ -1318,7 +1319,7 @@ static bool gnttab_need_v2(void)
 	uint32_t base, width;
 
 	if (xen_pv_domain()) {
-		base = xen_cpuid_base();
+		base = xenhost_cpuid_base(xh_default);
 		if (cpuid_eax(base) < 5)
 			return false;	/* Information not available, use V1. */
 		width = cpuid_ebx(base + 5) &
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 49a3874ae6bb..3236d1b1fa01 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -49,6 +49,7 @@
 #include <asm/xen/hypervisor.h>
 #include <xen/xenbus.h>
 #include <xen/xen.h>
+#include <xen/xenhost.h>
 #include "xenbus.h"
 
 /*
@@ -722,7 +723,7 @@ static bool xen_strict_xenbus_quirk(void)
 #ifdef CONFIG_X86
 	uint32_t eax, ebx, ecx, edx, base;
 
-	base = xen_cpuid_base();
+	base = xenhost_cpuid_base(xh_default);
 	cpuid(base + 1, &eax, &ebx, &ecx, &edx);
 
 	if ((eax >> 16) < 4)
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index a58e883f144e..13a70bdadfd2 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -1,6 +1,9 @@
 #ifndef __XENHOST_H
 #define __XENHOST_H
 
+#include <xen/interface/features.h>
+#include <xen/interface/xen.h>
+#include <asm/xen/hypervisor.h>
 /*
  * Xenhost abstracts out the Xen interface. It co-exists with the PV/HVM/PVH
  * abstractions (x86_init, hypervisor_x86, pv_ops etc) and is meant to
@@ -70,6 +73,16 @@ typedef struct {
 } xenhost_t;
 
 typedef struct xenhost_ops {
+	/*
+	 * xen_cpuid is used to probe features early.
+	 * xenhost_r0:
+	 *   Implementation could not use cpuid at all: it's difficult to
+	 *   intercept cpuid instruction locally.
+	 * xenhost_r1:
+	 * xenhost_r2:
+	 *   Separate cpuid-leafs?
+	 */
+	uint32_t (*cpuid_base)(xenhost_t *xenhost);
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
@@ -92,4 +105,12 @@ void __xenhost_unregister(enum xenhost_type type);
 	for ((xh) = (xenhost_t **) &xenhosts[0];	\
 		(((xh) - (xenhost_t **)&xenhosts) < 2) && (*xh)->type != xenhost_invalid; (xh)++)
 
+static inline uint32_t xenhost_cpuid_base(xenhost_t *xh)
+{
+	if (xh)
+		return (xh->ops->cpuid_base)(xh);
+	else
+		return xen_cpuid_base();
+}
+
 #endif /* __XENHOST_H */
-- 
2.20.1

