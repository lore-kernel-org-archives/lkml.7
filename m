Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D6C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4820850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfGMGBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:01:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbfGMGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:01:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6D5uLil140014
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 02:01:09 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tq8vhs3w5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 02:01:08 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Sat, 13 Jul 2019 07:01:08 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Jul 2019 07:01:04 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6D613J560752244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 06:01:03 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44012C6069;
        Sat, 13 Jul 2019 06:01:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20E52C6055;
        Sat, 13 Jul 2019 06:01:00 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.135.203])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 06:00:59 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 07/13] powerpc/pseries/svm: Use shared memory for Debug Trace Log (DTL)
Date:   Sat, 13 Jul 2019 03:00:17 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190713060023.8479-1-bauerman@linux.ibm.com>
References: <20190713060023.8479-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071306-0004-0000-0000-00001526F181
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011419; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231433; UDB=6.00648705; IPR=6.01012726;
 MB=3.00027699; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-13 06:01:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071306-0005-0000-0000-00008C6EF51C
Message-Id: <20190713060023.8479-8-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Secure guests need to share the DTL buffers with the hypervisor. To that
end, use a kmem_cache constructor which converts the underlying buddy
allocated SLUB cache pages into shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h          |  5 ++++
 arch/powerpc/platforms/pseries/Makefile |  1 +
 arch/powerpc/platforms/pseries/setup.c  |  5 +++-
 arch/powerpc/platforms/pseries/svm.c    | 40 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index fef3740f46a6..f253116c31fc 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -15,6 +15,9 @@ static inline bool is_secure_guest(void)
 	return mfmsr() & MSR_S;
 }
 
+void dtl_cache_ctor(void *addr);
+#define get_dtl_cache_ctor()	(is_secure_guest() ? dtl_cache_ctor : NULL)
+
 #else /* CONFIG_PPC_SVM */
 
 static inline bool is_secure_guest(void)
@@ -22,5 +25,7 @@ static inline bool is_secure_guest(void)
 	return false;
 }
 
+#define get_dtl_cache_ctor() NULL
+
 #endif /* CONFIG_PPC_SVM */
 #endif /* _ASM_POWERPC_SVM_H */
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index ab3d59aeacca..a420ef4c9d8e 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)		+= ibmebus.o
 obj-$(CONFIG_PAPR_SCM)		+= papr_scm.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
+obj-$(CONFIG_PPC_SVM)		+= svm.o
 
 ifdef CONFIG_PPC_PSERIES
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index cb418d2bb1ac..3009b5bd11d2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -73,6 +73,7 @@
 #include <asm/security_features.h>
 #include <asm/asm-const.h>
 #include <asm/swiotlb.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
@@ -301,8 +302,10 @@ static inline int alloc_dispatch_logs(void)
 
 static int alloc_dispatch_log_kmem_cache(void)
 {
+	void (*ctor)(void *) = get_dtl_cache_ctor();
+
 	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, NULL);
+						DISPATCH_LOG_BYTES, 0, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
new file mode 100644
index 000000000000..c508196f7c83
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Secure VM platform
+ *
+ * Copyright 2019 IBM Corporation
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <asm/ultravisor.h>
+
+/* There's one dispatch log per CPU. */
+#define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
+
+static struct page *dtl_page_store[NR_DTL_PAGE];
+static long dtl_nr_pages;
+
+static bool is_dtl_page_shared(struct page *page)
+{
+	long i;
+
+	for (i = 0; i < dtl_nr_pages; i++)
+		if (dtl_page_store[i] == page)
+			return true;
+
+	return false;
+}
+
+void dtl_cache_ctor(void *addr)
+{
+	unsigned long pfn = PHYS_PFN(__pa(addr));
+	struct page *page = pfn_to_page(pfn);
+
+	if (!is_dtl_page_shared(page)) {
+		dtl_page_store[dtl_nr_pages] = page;
+		dtl_nr_pages++;
+		WARN_ON(dtl_nr_pages >= NR_DTL_PAGE);
+		uv_share_page(pfn, 1);
+	}
+}

