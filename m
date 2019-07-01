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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30D5C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB384216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0Nh/qH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGBCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:19:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:19:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622IuNJ108174;
        Tue, 2 Jul 2019 02:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=PSXRRg+VqoghiPb6E2wfzVIl4GDaBdiY849ddx84T70=;
 b=D0Nh/qH7UFDDUkkw9JQM9H4ujFTZibgPEHu0CumMwxvwXhp2OjB/WL5pHj9RuRNEIygO
 VAebqgtrBKU7riVuMhiBPkJh3syjb/stlqc6qQe/z1TjRfVdjO+Dx0Ke/mPZMTb4vUnu
 NpeoEa9gNJHt/s0iVZL7twzERO8SsuKaia0DUWAviKxQPUW5s0ojTnrpRPKd1WV6s/BD
 jqJ1C7NaS5C5lIpObBUlVbUPru70XVXz5RODyKpSVUtcbLihK7bDq7QcMITcICCXnuDM
 gefbLLyVYMuceEoV6FOHyJRMuON7spbyN9Zr1o0XJ2ze6v6Td/M+j5j1hFVoQpmByl/k dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbgq5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:19:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622CTMl123668;
        Tue, 2 Jul 2019 02:17:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebku0886-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:17:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x622H1Ne028602;
        Tue, 2 Jul 2019 02:17:01 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 19:17:01 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.co,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 4/4] x86/xen: Add 'nopv' support for HVM guest
Date:   Mon,  1 Jul 2019 10:20:28 +0800
Message-Id: <1561947628-1147-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561947628-1147-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561947628-1147-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020022
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

