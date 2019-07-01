Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C18C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC65E216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KCO74WUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGBFRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:17:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54222 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfGBFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 01:17:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x625E0KA027382;
        Tue, 2 Jul 2019 05:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=PSXRRg+VqoghiPb6E2wfzVIl4GDaBdiY849ddx84T70=;
 b=KCO74WUDMFNqwAhCHjMv+kB1KYRsNuITJY2cJrIb5/4foS0vepIgEuJsimbH8epQ+0cf
 /FlXpp6Ws79NJhwbGNIPTgw97i6eKZ1NexF/Sg7Sbki3tNX1g1RTntt42DvCWphalVtL
 4xmZKmgMbkGJ1oXZLZYGyv/XqPvFuchrydyQZrO3qfdseqSB6cFSRlnUkF5B7E9Py8GK
 4Ly7pm83E4KXS8i5zhRYZfmtqk3VLeqCJ5TMnxnXEcyeWNjlO3BbEPvB3mXb3u/HQ2ZM
 lsujjZimW/cNQOCaYB7tLvvER40QwZ3enznKTIoft0741+yhEmWPu8aW8y/gfcNECn86 tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbh4pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 05:16:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x625CTHN183960;
        Tue, 2 Jul 2019 05:16:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg9n0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 05:16:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x625Gleb006454;
        Tue, 2 Jul 2019 05:16:48 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 22:16:47 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v4 4/5] x86/xen: Add 'nopv' support for HVM guest
Date:   Mon,  1 Jul 2019 13:19:58 +0800
Message-Id: <1561958399-28906-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561958399-28906-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561958399-28906-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVH guest needs PV extentions to work, so 'nopv' parameter should be
ignored for PVH but not for HVM guest.

If PVH guest boots up via the Xen-PVH boot entry, xen_pvh is set early,
we know it's PVH guest and ignore 'nopv' parameter directly.

If PVH guest boots up via the normal boot entry same as HVM guest, it's
hard to distinguish PVH and HVM guest at that time.

To handle that case, add a new function xen_hvm_nopv_guest_late_init()
to detect PVH at a late time and panic itself if 'nopv' enabled for a
PVH guest.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/xen/enlighten_hvm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 7fcb4ea..340dff8 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -25,6 +25,7 @@
 #include "mmu.h"
 #include "smp.h"
 
+extern bool nopv;
 static unsigned long shared_info_pfn;
 
 void xen_hvm_init_shared_info(void)
@@ -221,11 +222,36 @@ bool __init xen_hvm_need_lapic(void)
 	return true;
 }
 
+static __init void xen_hvm_nopv_guest_late_init(void)
+{
+#ifdef CONFIG_XEN_PVH
+	if (x86_platform.legacy.rtc || !x86_platform.legacy.no_vga)
+		return;
+
+	/* PVH detected. */
+	xen_pvh = true;
+
+	panic("nopv parameter isn't supported in PVH guest.");
+#endif
+}
+
+
 static uint32_t __init xen_platform_hvm(void)
 {
 	if (xen_pv_domain())
 		return 0;
 
+	if (xen_pvh_domain() && nopv) {
+		/* Guest booting via the Xen-PVH boot entry goes here */
+		pr_info("nopv parameter is ignored in PVH guest\n");
+	} else if (nopv) {
+		/*
+		 * Guest booting via normal boot entry (like via grub2) goes
+		 * here.
+		 */
+		x86_init.hyper.guest_late_init = xen_hvm_nopv_guest_late_init;
+		return 0;
+	}
 	return xen_cpuid_base();
 }
 
@@ -258,4 +284,5 @@ static __init void xen_hvm_guest_late_init(void)
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv            = true,
 };
-- 
1.8.3.1

