Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5742C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AC5218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfB1Ifq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:35:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbfB1Ifo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:35:44 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S8Y8UY078246
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:35:43 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qx8w0gefs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:35:42 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 28 Feb 2019 08:35:41 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 08:35:37 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1S8ZaHx23134358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 08:35:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 890977805C;
        Thu, 28 Feb 2019 08:35:36 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA3A7805F;
        Thu, 28 Feb 2019 08:35:33 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.233])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 08:35:33 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>, mpe@ellerman.id.au,
        Ross Zwisler <zwisler@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Date:   Thu, 28 Feb 2019 14:05:22 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022808-0004-0000-0000-000014E81B12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010678; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167493; UDB=6.00609930; IPR=6.00948106;
 MB=3.00025776; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 08:35:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022808-0005-0000-0000-00008ABEE271
Message-Id: <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to indicate the ability to do huge page dax mapping. On architecture
like ppc64, the hypervisor can disable huge page support in the guest. In
such a case, we should not enable huge page dax mapping. This patch adds
a flag which the architecture code will update to indicate huge page
dax mapping support.

Architectures mostly do transparent_hugepage_flag = 0; if they can't
do hugepages. That also takes care of disabling dax hugepage mapping
with this change.

Without this patch we get the below error with kvm on ppc64.

[  118.849975] lpar: Failed hash pte insert with error -4

NOTE: The patch also use

echo never > /sys/kernel/mm/transparent_hugepage/enabled
to disable dax huge page mapping.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
TODO:
* Add Fixes: tag

 include/linux/huge_mm.h | 4 +++-
 mm/huge_memory.c        | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 381e872bfde0..01ad5258545e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 			pud_t *pud, pfn_t pfn, bool write);
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_DAX_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
@@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
 
-	if (vma_is_dax(vma))
+	if (vma_is_dax(vma) &&
+	    (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
 		return true;
 
 	if (transparent_hugepage_flags &
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index faf357eaf0ce..43d742fe0341 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -53,6 +53,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
 	(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
 #endif
+	(1 << TRANSPARENT_HUGEPAGE_DAX_FLAG) |
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
@@ -475,6 +476,8 @@ static int __init setup_transparent_hugepage(char *str)
 			  &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DAX_FLAG,
+			  &transparent_hugepage_flags);
 		ret = 1;
 	}
 out:
@@ -753,6 +756,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
+	/* should we check for none here again? */
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
-- 
2.20.1

