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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E8C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E4921882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvuqvOW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGDBQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:16:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGDBQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:16:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641ELVj123406;
        Thu, 4 Jul 2019 01:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7EONRTmmeGFvVCXtQC6IK+HBE0ZbOZS1TzpKDcuyVw0=;
 b=SvuqvOW0QMcbCnNoA3Hk6po54G1amoaC8/wol5laRpot5IEisw9rJSawyorwuRKKOVBQ
 1sGMgGp4RlO2NprxXph5PDQTTcdn+7g0AnFZrFkoHg8cGe8Yn59AaWE1TpW7Fdj7pLu7
 apeGBjgwDuhuiE6T4PHpW6TZdkr/4ficoYXOSlzGfNKZgx/9qWNnH/jCjxPGB4AcKx2t
 4YWu+922ulCF1jwXgAJLibGHgkaNueKkKgAz7amS2KPRAxKPgSA0+QWBXxjSQAHmbAcw
 Wu8lQF3JFAwx8ADEJJ8VHZmFw5pD8Dr4su5EvSxuhlClNoOOsn/ygFTCVWUyhI4Aw3jI CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbv6rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641Ca7m171107;
        Thu, 4 Jul 2019 01:16:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2th5qm18at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x641G5lu026874;
        Thu, 4 Jul 2019 01:16:05 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:16:04 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v5 3/4] xen: Map "xen_nopv" parameter to "nopv" and mark it obsolete
Date:   Wed,  3 Jul 2019 09:19:37 +0800
Message-Id: <1562116778-5846-4-git-send-email-zhenzhong.duan@oracle.com>
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

Clean up unnecessory code after that operation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
index 21e08af..8ab34a1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5254,6 +5254,8 @@
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

