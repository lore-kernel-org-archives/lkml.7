Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C82C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0C321670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIbqhn+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGLMGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:06:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47398 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfGLMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:06:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC48vM008727;
        Fri, 12 Jul 2019 12:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=E14zOpdJ0upmAZGDNVryByKPU7mvCSiYeFkhZvpvH9w=;
 b=FIbqhn+OIc/U3TbGekk1kglxd3dkGTWFGJdCpcL1g3oBGHoGYJkXA6rDjY54xgo2y/dK
 X9luy9yF/lq/XVDZr37+fSwS08ukeu9t6SsM5o4LJvUFFEnnmJwIVQoy2Q7DkvGHrqlm
 eVWLCWmWuZI49RlSLSayIuTHVxPJC9wNhwpchfwkASiKHJsetWs98UWyTh/WgaYux566
 0kijlVfG+Wn0ts7S7dS1rPHXF37Un3NWB/Wh34D/uiJgFQKFBPByDk9gPWu/+PFEaJpy
 dIiwK7TJeQa9YaUYJsTPEBakRqkDTPmGpqTWtGKNiophhx6p/JKfiPNGnegJ/jTyXpbd JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9r57kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:06:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3RS1175143;
        Fri, 12 Jul 2019 12:04:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgyr39m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:08 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CC46oQ020742;
        Fri, 12 Jul 2019 12:04:06 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 04:58:37 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v7 3/5] xen: Map "xen_nopv" parameter to "nopv" and mark it obsolete
Date:   Thu, 11 Jul 2019 20:02:10 +0800
Message-Id: <1562846532-32152-4-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unnecessory code after that operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/xen/enlighten_hvm.c                    | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbfe9c2..c3f3e01 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5257,6 +5257,8 @@
 	xen_nopv	[X86]
 			Disables the PV optimizations forcing the HVM guest to
 			run as generic HVM guest with no PV drivers.
+			This option is obsoleted by the "nopv" option, which
+			has equivalent effect for XEN platform.
 
 	xen_scrub_pages=	[XEN]
 			Boolean option to control scrubbing pages before giving them back
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index ac4943c..1756cf7 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -210,18 +210,18 @@ static void __init xen_hvm_guest_init(void)
 #endif
 }
 
-static bool xen_nopv;
 static __init int xen_parse_nopv(char *arg)
 {
-       xen_nopv = true;
-       return 0;
+	pr_notice("\"xen_nopv\" is deprecated, please use \"nopv\" instead\n");
+
+	if (xen_cpuid_base())
+		nopv = true;
+	return 0;
 }
 early_param("xen_nopv", xen_parse_nopv);
 
 bool __init xen_hvm_need_lapic(void)
 {
-	if (xen_nopv)
-		return false;
 	if (xen_pv_domain())
 		return false;
 	if (!xen_hvm_domain())
@@ -233,7 +233,7 @@ bool __init xen_hvm_need_lapic(void)
 
 static uint32_t __init xen_platform_hvm(void)
 {
-	if (xen_pv_domain() || xen_nopv)
+	if (xen_pv_domain())
 		return 0;
 
 	return xen_cpuid_base();
-- 
1.8.3.1

