Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A9C06511
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406A5218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wb7MTWSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGDBQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:16:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfGDBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:16:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641Efot123673;
        Thu, 4 Jul 2019 01:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HhKAAWVPipFLRo00kLa1NJDWOLc4M9riT3RNfy4Uozs=;
 b=wb7MTWSeBsklCUBYPP99Z2BcF022Vw3ID16E/qh0bdF7nB7k1tlNEWUtZO2/cS8lP0ZD
 yNCz1L07vjhGc0qoJRLasQyOaDbHgOCxOdEXyd54gcfMQIk7DUjJ3oOfVdOfV8Q8vQ5g
 i8oAQpk7tKiO5Ms8vco8jiuHzpem2VPS3mxsJ8bKszx6U4gRSOvfPaUZPpUoY5CD+HiG
 lWK79YzScafjJjT6ivE7ICnc8TpIky7TSX3WmnIewaloynLkKNq42lBpqed0havaSTxq
 fhQ8TDFt8aDTFi2RL3MIclgIj8jVEMcu8L4Bn73q+IsNVF5vPoKkE9TKh9lQsAxuvw0M GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbv6s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641Cceh089845;
        Thu, 4 Jul 2019 01:16:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tebkv5tdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:07 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x641G7tj010700;
        Thu, 4 Jul 2019 01:16:07 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:16:07 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v5 4/4] x86/xen: Add "nopv" support for HVM guest
Date:   Wed,  3 Jul 2019 09:19:38 +0800
Message-Id: <1562116778-5846-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVH guest needs PV extentions to work, so "nopv" parameter should be
ignored for PVH but not for HVM guest.

If PVH guest boots up via the Xen-PVH boot entry, xen_pvh is set early,
we know it's PVH guest and ignore "nopv" parameter directly.

If PVH guest boots up via the normal boot entry same as HVM guest, it's
hard to distinguish PVH and HVM guest at that time.

To handle that case, add a new function xen_hvm_nopv_guest_late_init()
to detect PVH at a late time and panic itself if nopv enabled for a
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
index 1756cf7..09a010a 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -231,11 +231,37 @@ bool __init xen_hvm_need_lapic(void)
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
+	panic("\"nopv\" and \"xen_nopv\" parameters are unsupported in PVH guest.");
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
+		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
+		nopv = false;
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
 
@@ -268,4 +294,5 @@ static __init void xen_hvm_guest_late_init(void)
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv            = true,
 };
-- 
1.8.3.1

