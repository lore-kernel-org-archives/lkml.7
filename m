Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EDC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DDC20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmbeTjSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfGHJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:12:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGHJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:12:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6899hhK152103;
        Mon, 8 Jul 2019 09:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=v1DgpfRJEzDrZLeF1PWs/KsiDG71M25IhxSiMAC4Vfs=;
 b=cmbeTjSiQMRMkxnf6WA2LqN9YKkbh/M6hGNnNNaH4y5hYlEASTeBSNt81XfWA9kPDhKL
 ikk6DEr4O42Yk3HROf+P+OcDXrGFAdNVWhPN/ogqHKii+Ud2lOzfygZjYICKaXnO5eot
 PuQm/lZ4eK/gCP+SCCTOoFTJrWUs0IpHnrc6P3CnZZQi/kODaeriuGLBH3HrGJNgeJl9
 d0msqftOe2zVV8Aynno+o2AheSzWCVWh2hw2/DYNHWbjyp/x/Cmnm7U3TOi5Mw80jbpc
 fsp3HQbrzRD3Sdw8J9DmJ32yWHu9lEcrGhqWV+pGRxwv4Pb3BCHpNctIpw9i5DOgb2Rl yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tjm9qd70b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6897v8R131753;
        Mon, 8 Jul 2019 09:11:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tjjyk3snd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x689BdZL005130;
        Mon, 8 Jul 2019 09:11:39 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 02:11:39 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v6 4/4] x86/xen: Add "nopv" support for HVM guest
Date:   Sun,  7 Jul 2019 17:15:08 +0800
Message-Id: <1562490908-17882-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080121
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

Move xen_platform_hvm() after xen_hvm_guest_late_init() to avoid compile
error.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/xen/enlighten_hvm.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 1756cf7..7e1c75f 100644
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
@@ -259,6 +254,26 @@ static __init void xen_hvm_guest_late_init(void)
 #endif
 }
 
+static uint32_t __init xen_platform_hvm(void)
+{
+	if (xen_pv_domain())
+		return 0;
+
+	if (xen_pvh_domain() && nopv) {
+		/* Guest booting via the Xen-PVH boot entry goes here */
+		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
+		nopv = false;
+	} else if (nopv) {
+		/*
+		 * Guest booting via normal boot entry (like via grub2) goes
+		 * here.
+		 */
+		x86_init.hyper.guest_late_init = xen_hvm_guest_late_init;
+		return 0;
+	}
+	return xen_cpuid_base();
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
 	.name                   = "Xen HVM",
 	.detect                 = xen_platform_hvm,
@@ -268,4 +283,5 @@ static __init void xen_hvm_guest_late_init(void)
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv            = true,
 };
-- 
1.8.3.1

