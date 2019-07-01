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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC040C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DD2206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IG2IvXNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBCRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:17:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBCRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:17:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622DRq3002531;
        Tue, 2 Jul 2019 02:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=EFSmZR+aQfjnbpTqhm/zuPPtTY2fNuao7fBCYCnO2FA=;
 b=IG2IvXNHu0JNFqMmbrz6Az0gikxXqkcIC9S4CvfpeVDfyYXV59dJ6SwUrcPYRBiQeHS+
 gS4cA8G1DLBtLQlZ1IrVpJTVq2gN1yvXKD8AwCL3uY2tANgsPPEYR/1NvZ6wtQYHsJ/g
 S9HoCCNPdp24J2fDpIqy+5vzAXh1XbTk/ywwhlZkk4kvVnezKTLjWy5dZJS17wdeFrYV
 oOhDdYFi4ie1NiW2GEGod8GnbXVoW09aTaAsmZ9igFBJmzQjg0rTkiYg1sq/tZo3DCtz
 spnmdfidz2WIpKW2OKIftelkLDKKqWMKsRn0hFdAXhQaCvYvINUfYhk9kvUIc1Ro4YsN DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61e0nyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:17:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622Cb7m123917;
        Tue, 2 Jul 2019 02:17:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tebku0881-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:17:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x622GwTH031712;
        Tue, 2 Jul 2019 02:16:59 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 19:16:58 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.co,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 3/4] Revert "xen: Introduce 'xen_nopv' to disable PV extensions for HVM guests."
Date:   Mon,  1 Jul 2019 10:20:27 +0800
Message-Id: <1561947628-1147-4-git-send-email-zhenzhong.duan@oracle.com>
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
 definitions=main-1907020021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8d693b911bb9c57009c24cb1772d205b84c7985c.

Instead we use an unified parameter 'nopv' for all the hypervisor
platforms.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 arch/x86/xen/enlighten_hvm.c                    | 12 +-----------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 21e08af..d5c3dcc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5251,10 +5251,6 @@
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
 
-	xen_nopv	[X86]
-			Disables the PV optimizations forcing the HVM guest to
-			run as generic HVM guest with no PV drivers.
-
 	xen_scrub_pages=	[XEN]
 			Boolean option to control scrubbing pages before giving them back
 			to Xen, for use by other domains. Can be also changed at runtime
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index ac4943c..7fcb4ea 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -210,18 +210,8 @@ static void __init xen_hvm_guest_init(void)
 #endif
 }
 
-static bool xen_nopv;
-static __init int xen_parse_nopv(char *arg)
-{
-       xen_nopv = true;
-       return 0;
-}
-early_param("xen_nopv", xen_parse_nopv);
-
 bool __init xen_hvm_need_lapic(void)
 {
-	if (xen_nopv)
-		return false;
 	if (xen_pv_domain())
 		return false;
 	if (!xen_hvm_domain())
@@ -233,7 +223,7 @@ bool __init xen_hvm_need_lapic(void)
 
 static uint32_t __init xen_platform_hvm(void)
 {
-	if (xen_pv_domain() || xen_nopv)
+	if (xen_pv_domain())
 		return 0;
 
 	return xen_cpuid_base();
-- 
1.8.3.1

