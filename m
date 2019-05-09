Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E416C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A26820656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GT0S++/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEIR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41808 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEIRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HKMNq163067;
        Thu, 9 May 2019 17:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=fE8Bp2MSKiL96GYLWx6ZDwxFcOoxxUljtd3qqTK15hw=;
 b=GT0S++/n0i8uxfZfkbroVV8WnK/yXwkmx3uwfOUMvpwJpBrFHj4QyU2GB0k/lfl8TkQb
 OZI1wAkIrhvaBTasrF4jS07iBvesMeuTM/FFxHBvnfZ24fJFgoGhcCKlSMakX5Jfi1BV
 HKASbp/uTDt20b2m74xUWZ/8n9uLoGiD/4o9oJMGk+Qw7i7UvddmkNDDXa/U6j7P+ExY
 r+sNPYXqBFAZZdqQUbyM/DvTNzb3SIMUHeRWZi0flKn1px2I1q2RTlw4UFNSsDErzxfu
 lZhJKEIl/1HSDS+hxLceAaPTCbFYwPhQ3SsnPm3q7A6i+bkcGlHlPOVCA1fSyvCv3P7P dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b6ceyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HO0Ln109706;
        Thu, 9 May 2019 17:25:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sagyvcg4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:40 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPdgR011020;
        Thu, 9 May 2019 17:25:39 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:38 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 05/16] x86/xen: add feature support in xenhost_t
Date:   Thu,  9 May 2019 10:25:29 -0700
Message-Id: <20190509172540.12398-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With nested xenhosts, both the xenhosts could have different supported
xen_features. Add support for probing both.

In addition, validate that features are compatible across xenhosts.

For runtime feature checking, the code uses xen_feature() with the
default xenhost. This should be good enough because we do feature
validation early which guarantees that the features of interest are
compatible. Features not of interest, are related to MMU, clock, pirq, etc where
the interface to L0-Xen should not matter.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/enlighten_hvm.c | 15 +++++++++++----
 arch/x86/xen/enlighten_pv.c  | 14 ++++++++++----
 drivers/xen/features.c       | 33 +++++++++++++++++++++++++++------
 include/xen/features.h       | 17 ++++++++++++++---
 include/xen/xenhost.h        | 10 ++++++++++
 5 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index f84941d6944e..a118b61a1a8a 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -119,17 +119,24 @@ static void __init init_hvm_pv_info(void)
 
 	xen_domain_type = XEN_HVM_DOMAIN;
 
-	/* PVH set up hypercall page in xen_prepare_pvh(). */
 	if (xen_pvh_domain())
 		pv_info.name = "Xen PVH";
-	else {
+	else
 		pv_info.name = "Xen HVM";
 
-		for_each_xenhost(xh)
+	for_each_xenhost(xh) {
+		/* PVH set up hypercall page in xen_prepare_pvh(). */
+		if (!xen_pvh_domain())
 			xenhost_setup_hypercall_page(*xh);
+		xen_setup_features(*xh);
 	}
 
-	xen_setup_features();
+	/*
+	 * Check if features are compatible across L1-Xen and L0-Xen;
+	 * If not, get rid of xenhost_r2.
+	 */
+	if (xen_validate_features() == false)
+		__xenhost_unregister(xenhost_r2);
 
 	cpuid(base + 4, &eax, &ebx, &ecx, &edx);
 	if (eax & XEN_HVM_CPUID_VCPU_ID_PRESENT)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index a2c07cc71498..484968ff16a4 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1236,13 +1236,19 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	if (xen_driver_domain() && xen_nested())
 		xenhost_register(xenhost_r2, &xh_pv_nested_ops);
 
-	for_each_xenhost(xh)
-		xenhost_setup_hypercall_page(*xh);
-
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
 
-	xen_setup_features();
+	for_each_xenhost(xh) {
+		xenhost_setup_hypercall_page(*xh);
+		xen_setup_features(*xh);
+	}
+	/*
+	 * Check if features are compatible across L1-Xen and L0-Xen;
+	 * If not, get rid of xenhost_r2.
+	 */
+	if (xen_validate_features() == false)
+		__xenhost_unregister(xenhost_r2);
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index d7d34fdfc993..b4fba808ebae 100644
--- a/drivers/xen/features.c
+++ b/drivers/xen/features.c
@@ -15,19 +15,40 @@
 #include <xen/interface/version.h>
 #include <xen/features.h>
 
-u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
-EXPORT_SYMBOL_GPL(xen_features);
-
-void xen_setup_features(void)
+void xen_setup_features(xenhost_t *xh)
 {
 	struct xen_feature_info fi;
 	int i, j;
 
 	for (i = 0; i < XENFEAT_NR_SUBMAPS; i++) {
 		fi.submap_idx = i;
-		if (HYPERVISOR_xen_version(XENVER_get_features, &fi) < 0)
+		if (hypervisor_xen_version(xh, XENVER_get_features, &fi) < 0)
 			break;
 		for (j = 0; j < 32; j++)
-			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
+			xh->features[i * 32 + j] = !!(fi.submap & 1<<j);
 	}
 }
+
+bool xen_validate_features(void)
+{
+	int fail = 0;
+
+	if (xh_default && xh_remote) {
+		/*
+		 * Check xh_default->features and xh_remote->features for
+		 * compatibility. Relevant features should be compatible
+		 * or we are asking for trouble.
+		 */
+		fail += __xen_feature(xh_default, XENFEAT_auto_translated_physmap) !=
+			__xen_feature(xh_remote, XENFEAT_auto_translated_physmap);
+
+		/* We would like callbacks via hvm_callback_vector. */
+		fail += __xen_feature(xh_default, XENFEAT_hvm_callback_vector) == 0;
+		fail += __xen_feature(xh_remote, XENFEAT_hvm_callback_vector) == 0;
+
+		if (fail)
+			return false;
+	}
+
+	return fail ? false : true;
+}
diff --git a/include/xen/features.h b/include/xen/features.h
index e4cb464386a9..63e6735ed6a3 100644
--- a/include/xen/features.h
+++ b/include/xen/features.h
@@ -11,14 +11,25 @@
 #define __XEN_FEATURES_H__
 
 #include <xen/interface/features.h>
+#include <xen/xenhost.h>
 
-void xen_setup_features(void);
+void xen_setup_features(xenhost_t *xh);
 
-extern u8 xen_features[XENFEAT_NR_SUBMAPS * 32];
+bool xen_validate_features(void);
 
+static inline int __xen_feature(xenhost_t *xh, int flag)
+{
+	return xh->features[flag];
+}
+
+/*
+ * We've validated the features that need to be common for both xenhost_r1 and
+ * xenhost_r2 (XENFEAT_hvm_callback_vector, XENFEAT_auto_translated_physmap.)
+ * Most of the other features should be only needed for the default xenhost.
+ */
 static inline int xen_feature(int flag)
 {
-	return xen_features[flag];
+	return __xen_feature(xh_default, flag);
 }
 
 #endif /* __ASM_XEN_FEATURES_H__ */
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index d9bc1fb6cce4..dd1e2b64f50d 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -4,6 +4,7 @@
 #include <xen/interface/features.h>
 #include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
+
 /*
  * Xenhost abstracts out the Xen interface. It co-exists with the PV/HVM/PVH
  * abstractions (x86_init, hypervisor_x86, pv_ops etc) and is meant to
@@ -72,6 +73,15 @@ typedef struct {
 	struct xenhost_ops *ops;
 
 	struct hypercall_entry *hypercall_page;
+
+	/*
+	 * Not clear if we need to draw features from two different
+	 * hypervisors. There is one feature that seems might be necessary:
+	 * XENFEAT_hvm_callback_vector.
+	 * Ensuring support in both L1-Xen and L0-Xen means that L0-Xen can
+	 * bounce callbacks via L1-Xen.
+	 */
+	u8 features[XENFEAT_NR_SUBMAPS * 32];
 } xenhost_t;
 
 typedef struct xenhost_ops {
-- 
2.20.1

