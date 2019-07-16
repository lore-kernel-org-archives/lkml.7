Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FD420651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m1YoS9AB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGQEXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 00:23:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQEXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:23:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H4Iv6n044565;
        Wed, 17 Jul 2019 04:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=eSrV5dBwkmZsMu4Ka82lD86iRkWsEW2KmhC9kjHylA0=;
 b=m1YoS9ABJu0MkSSMKND2HhentO2puo9i3adQ39MoHdTaPa8Uq3HOy93opOyiW7jBaImk
 TYp3BTPEfKgDntjYPUy38ygBTg8GHvmZE1neY2dMgJDrCWr2QcXFP34Pa8XybrH5M+g5
 IhIYCUscLxgVS8FiNytVlitipXERdMOb7qE85iNFCexuAcUEL9guXKb1ePOc98buv4pZ
 y7Uet2+XlDOFDP3kQmxEYCmDn8toGbhVSnPnIai4gZFe4Jbd1WX9s50FeIlR83CLSFrk
 yywxhJRRvfMhrsDxyzL8ixsTuupLIlKVW3GnPvho2RbFamr7wEDzyc4pXY/6OgneEymY eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tq78pr1c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 04:22:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H4IFZI096659;
        Wed, 17 Jul 2019 04:22:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tsctwqsjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 04:22:34 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H4MXWe014705;
        Wed, 17 Jul 2019 04:22:33 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 04:22:32 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v8 5/5] x86/xen: Add "nopv" support for HVM guest
Date:   Tue, 16 Jul 2019 12:26:09 +0800
Message-Id: <1563251169-30740-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVH guest needs PV extentions to work, so "nopv" parameter should be
ignored for PVH but not for HVM guest.

If PVH guest boots up via the Xen-PVH boot entry, xen_pvh is set early,
we know it's PVH guest and ignore "nopv" parameter directly.

If PVH guest boots up via the normal boot entry same as HVM guest, it's
hard to distinguish PVH and HVM guest at that time. In this case, we
have to panic early if PVH is detected and nopv is enabled to avoid a
worse situation later.

Remove static from bool_x86_init_noop/x86_op_int_noop so they could be
used globally. Move xen_platform_hvm() after xen_hvm_guest_late_init()
to avoid compile error.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/x86_init.c      |  4 ++--
 arch/x86/xen/enlighten_hvm.c    | 43 +++++++++++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b85a7c5..ac09341 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -301,6 +301,8 @@ struct x86_apic_ops {
 extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
+extern bool bool_x86_init_noop(void);
+extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
 
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 50a2b49..1bef687 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -29,8 +29,8 @@ void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
 static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
-static bool __init bool_x86_init_noop(void) { return false; }
-static void x86_op_int_noop(int cpu) { }
+bool __init bool_x86_init_noop(void) { return false; }
+void x86_op_int_noop(int cpu) { }
 
 /*
  * The platform setup functions are preset with the default functions
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index b671983..e138f7d 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -231,14 +231,6 @@ bool __init xen_hvm_need_lapic(void)
 	return true;
 }
 
-static uint32_t __init xen_platform_hvm(void)
-{
-	if (xen_pv_domain())
-		return 0;
-
-	return xen_cpuid_base();
-}
-
 static __init void xen_hvm_guest_late_init(void)
 {
 #ifdef CONFIG_XEN_PVH
@@ -250,6 +242,9 @@ static __init void xen_hvm_guest_late_init(void)
 	/* PVH detected. */
 	xen_pvh = true;
 
+	if (nopv)
+		panic("\"nopv\" and \"xen_nopv\" parameters are unsupported in PVH guest.");
+
 	/* Make sure we don't fall back to (default) ACPI_IRQ_MODEL_PIC. */
 	if (!nr_ioapics && acpi_irq_model == ACPI_IRQ_MODEL_PIC)
 		acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
@@ -259,6 +254,37 @@ static __init void xen_hvm_guest_late_init(void)
 #endif
 }
 
+static uint32_t __init xen_platform_hvm(void)
+{
+	uint32_t xen_domain = xen_cpuid_base();
+	struct x86_hyper_init *h = &x86_hyper_xen_hvm.init;
+
+	if (xen_pv_domain())
+		return 0;
+
+	if (xen_pvh_domain() && nopv) {
+		/* Guest booting via the Xen-PVH boot entry goes here */
+		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
+		nopv = false;
+	} else if (nopv && xen_domain) {
+		/*
+		 * Guest booting via normal boot entry (like via grub2) goes
+		 * here.
+		 *
+		 * Use interface functions for bare hardware if nopv,
+		 * xen_hvm_guest_late_init is an exception as we need to
+		 * detect PVH and panic there.
+		 */
+		h->init_platform = x86_init_noop;
+		h->x2apic_available = bool_x86_init_noop;
+		h->init_mem_mapping = x86_init_noop;
+		h->init_after_bootmem = x86_init_noop;
+		h->guest_late_init = xen_hvm_guest_late_init;
+		x86_hyper_xen_hvm.runtime.pin_vcpu = x86_op_int_noop;
+	}
+	return xen_domain;
+}
+
 struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
 	.name                   = "Xen HVM",
 	.detect                 = xen_platform_hvm,
@@ -268,4 +294,5 @@ struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv            = true,
 };
-- 
1.8.3.1

