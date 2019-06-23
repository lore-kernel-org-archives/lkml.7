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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789012145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U17bqOBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFXM6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:58:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:58:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCt2vM135433;
        Mon, 24 Jun 2019 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=kGn74/hddQ3jiwC8Udn/ISBNEFh1bmGXUBKkLp6x5h8=;
 b=U17bqOBe5SuR9BvhJFsKv4UVniBZ1sKPJAqbmPY/7N3p2lj7KbKZYCDLPxRCOhNFccE5
 Deb1pqdkOFG6K4wN6ojWL668yPCtsY4HjubegrZzScyyjyARg8L/PAlbtRmuOtsA2EHg
 2NfqrqNeiH3d4FWGBelPd9PA432MAhL9mS+NZVdGYJx+OVCYQyfc3kHudSSWVbH7Z3mE
 JunV9VB9zobWi3xJJNYHBvozkouHaCvGsBfItDOrMwNbOt8mDGxKjHSw7GCh3fA6dUdC
 L1bewGCLVjOSwAAuOEnz1lIfe45Adr+7ikVv+5aXJPgLIbqbjzaVYeaPvRRM7n2qK3i7 bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brsx997-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCw9HI177777;
        Mon, 24 Jun 2019 12:58:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7bmd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OCw7rw024782;
        Mon, 24 Jun 2019 12:58:07 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:58:06 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 1/6] x86/xen: Mark xen_hvm_need_lapic() and xen_hvm_need_lapic() as __init
Date:   Sun, 23 Jun 2019 21:01:38 +0800
Message-Id: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. as they are only called at early bootup stage. In fact, other
functions in x86_hyper_xen_hvm.init.* are all marked as __init.

Unexport xen_hvm_need_lapic as it's never used outside.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 6 +++---
 arch/x86/xen/enlighten_hvm.c          | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 39171b3..42e1245 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -44,14 +44,14 @@ static inline uint32_t xen_cpuid_base(void)
 }
 
 #ifdef CONFIG_XEN
-extern bool xen_hvm_need_lapic(void);
+extern bool __init xen_hvm_need_lapic(void);
 
-static inline bool xen_x2apic_para_available(void)
+static inline bool __init xen_x2apic_para_available(void)
 {
 	return xen_hvm_need_lapic();
 }
 #else
-static inline bool xen_x2apic_para_available(void)
+static inline bool __init xen_x2apic_para_available(void)
 {
 	return (xen_cpuid_base() != 0);
 }
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 0e75642..ac4943c 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -218,7 +218,7 @@ static __init int xen_parse_nopv(char *arg)
 }
 early_param("xen_nopv", xen_parse_nopv);
 
-bool xen_hvm_need_lapic(void)
+bool __init xen_hvm_need_lapic(void)
 {
 	if (xen_nopv)
 		return false;
@@ -230,7 +230,6 @@ bool xen_hvm_need_lapic(void)
 		return false;
 	return true;
 }
-EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static uint32_t __init xen_platform_hvm(void)
 {
-- 
1.8.3.1

