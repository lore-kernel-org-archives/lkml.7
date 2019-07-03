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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A83C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B0C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rKZhRLv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGDBQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:16:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35286 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfGDBQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:16:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641EUdk123573;
        Thu, 4 Jul 2019 01:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=YuCOXIRb/dHuU0bztnXWfWAbrWp+ScSgOTP4KoY+oi4=;
 b=rKZhRLv86J9i1rvrZktSTTZCQ+BL1+OOD2Uqcglx6kQg6n9trrHvxI/Uf6doxbDZQhTr
 jYZtVLBHXUinpS8X23Frvp5m09GUPCxgYu8l0PRyJ+WmTVLQWrT7D7LE9XxWAFAr13lI
 R3fzCMbe3hobkdJ1hHcbNbq8vfJv0JKW3/S62JShkqz28p5rAKO46yuR5U9Ykgehrvjp
 +jLy5FvVnlH75VqnVh7lNngxWh/susHJr1LV6c54vUPtu08usCNmriIK1cTdl2zgTqNl
 0dPZLskmwLvOZvOb1eEvRcmSPaoSqfVMw3tUvy7KXkt0RJKucCSHFDhkxMrackcsm5uI Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbv6rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641ChlE039884;
        Thu, 4 Jul 2019 01:16:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2th5qks8k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x641FxHl017794;
        Thu, 4 Jul 2019 01:15:59 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:15:59 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v5 1/4] x86/xen: Mark xen_hvm_need_lapic() and xen_x2apic_para_available() as __init
Date:   Wed,  3 Jul 2019 09:19:35 +0800
Message-Id: <1562116778-5846-2-git-send-email-zhenzhong.duan@oracle.com>
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

.. as they are only called at early bootup stage. In fact, other
functions in x86_hyper_xen_hvm.init.* are all marked as __init.

Unexport xen_hvm_need_lapic as it's never used outside.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
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

