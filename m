Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084F620679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IGMsHrMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfFXM6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:58:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfFXM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:58:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCsHZP045489;
        Mon, 24 Jun 2019 12:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=NfIpW5m3VpvjUSio8dF11x/kBwlpwlo1ekYCD0h4Qk8=;
 b=IGMsHrMS2fAoEAx11Y9xAipulaGOKc79b9ufDIR0k6j3B/E5rJmLuNGtBn13kRGAxtjA
 HmjZpILCk5sQ7mowxzxWpoJXgL8hUb79oGyGQMagInkZTj1kwZQy2k1Cse3uQqtavHgD
 hzJFTqA/lL67i9AqYwhcgo4vbEbyySXKwwdUQKlEcNjdR8aDiZBkKe+jWK2yHU+p4vJz
 1QjSCSgfqWayprex7bOiaosLHSfj/fwzUGTyNIxG7htGCFpvH6mIIkZeW2zAHfajD6SZ
 rU6F7waII+nuwwWKcq7eSbqCxDxQ7ygtDJ6Sk6Ge1hcMOiG5fuAA/TkTJnM0YKKDUBHu 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9pe7ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCwCth042307;
        Mon, 24 Jun 2019 12:58:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acbg5qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OCwJp0010645;
        Mon, 24 Jun 2019 12:58:20 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:58:19 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 4/6] Revert "xen: Introduce 'xen_nopv' to disable PV extensions for HVM guests."
Date:   Sun, 23 Jun 2019 21:01:41 +0800
Message-Id: <1561294903-6166-4-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8d693b911bb9c57009c24cb1772d205b84c7985c.

Instead we use an unified parameter 'nopv' for all the hypervisor
platforms.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: xen-devel@lists.xenproject.org
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 arch/x86/xen/enlighten_hvm.c                    | 12 +-----------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b352f36..ebb75c1 100644
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

