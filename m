Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED0C2BD09
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FE0217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLGBNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:13:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfLGBNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:13:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB71CRkG071042
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 20:13:11 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9g6seve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 20:13:11 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 7 Dec 2019 01:13:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 7 Dec 2019 01:13:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB71D2T747841386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 7 Dec 2019 01:13:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB42A4C046;
        Sat,  7 Dec 2019 01:13:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E4EF4C044;
        Sat,  7 Dec 2019 01:12:58 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.215.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  7 Dec 2019 01:12:58 +0000 (GMT)
From:   Ram Pai <linuxram@us.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, linuxram@us.ibm.com,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        leonardo@linux.ibm.com
Subject: [PATCH v5 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
Date:   Fri,  6 Dec 2019 17:12:38 -0800
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120701-0020-0000-0000-000003952446
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120701-0021-0000-0000-000021EC59A1
Message-Id: <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_08:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=945 suspectscore=3 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912070004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
its parameters.  On secure VMs, hypervisor cannot access the contents of
this page since it gets encrypted.  Hence share the page with the
hypervisor, and unshare when done.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6ba081d..67b5009 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -37,6 +37,7 @@
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/svm.h>
+#include <asm/ultravisor.h>
 
 #include "pseries.h"
 
@@ -179,6 +180,18 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
 
+static void pre_process_tce_page(__be64 *tcep)
+{
+	if (tcep && is_secure_guest())
+		uv_share_page(PHYS_PFN(__pa(tcep)), 1);
+}
+
+static void post_process_tce_page(__be64 *tcep)
+{
+	if (tcep && is_secure_guest())
+		uv_unshare_page(PHYS_PFN(__pa(tcep)), 1);
+}
+
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction,
@@ -187,7 +200,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	u64 rc = 0;
 	u64 proto_tce;
 	__be64 *tcep;
-	u64 rpn;
+	u64 rpn, tcep0;
 	long l, limit;
 	long tcenum_start = tcenum, npages_start = npages;
 	int ret = 0;
@@ -216,6 +229,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		__this_cpu_write(tce_page, tcep);
 	}
 
+	pre_process_tce_page(tcep);
+
 	rpn = __pa(uaddr) >> TCE_SHIFT;
 	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
@@ -243,6 +258,14 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
+	/*
+	 * if "tcep" is shared, post_process_tce_page() will unshare the page,
+	 * which will zero the page. Grab any interesting content, before it
+	 * disappears.
+	 */
+	tcep0 = tcep[0];
+	post_process_tce_page(tcep);
+
 	local_irq_restore(flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
@@ -256,7 +279,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
 		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 		printk("\tnpages  = 0x%llx\n", (u64)npages);
-		printk("\ttce[0] val = 0x%llx\n", tcep[0]);
+		printk("\ttce[0] val = 0x%llx\n", tcep0);
 		dump_stack();
 	}
 	return ret;
@@ -280,7 +303,6 @@ static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages
 	}
 }
 
-
 static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
@@ -413,6 +435,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 		__this_cpu_write(tce_page, tcep);
 	}
 
+	pre_process_tce_page(tcep);
+
 	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
 
 	liobn = (u64)be32_to_cpu(maprange->liobn);
@@ -451,6 +475,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 		num_tce -= limit;
 	} while (num_tce > 0 && !rc);
 
+	post_process_tce_page(tcep);
+
 	/* error cleanup: caller will clear whole range */
 
 	local_irq_enable();
-- 
1.8.3.1

