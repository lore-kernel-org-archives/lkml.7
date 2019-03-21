Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E6C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130EB218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfCUEGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:06:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbfCUEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:06:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2L3wXbB102929
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:06:32 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbxdh2ucm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:06:32 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 21 Mar 2019 04:06:30 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 04:06:27 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2L46SUL35717156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 04:06:29 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC326A058;
        Thu, 21 Mar 2019 04:06:28 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D343F6A04F;
        Thu, 21 Mar 2019 04:06:25 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.92.127])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 04:06:25 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] mm: page_mkclean vs MADV_DONTNEED race
Date:   Thu, 21 Mar 2019 09:36:10 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032104-0004-0000-0000-000014F14CA2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177373; UDB=6.00615904; IPR=6.00958070;
 MB=3.00026084; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 04:06:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032104-0005-0000-0000-00008AF91221
Message-Id: <20190321040610.14226-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED is handled with mmap_sem taken in read mode.
We call page_mkclean without holding mmap_sem.

MADV_DONTNEED implies that pages in the region are unmapped and subsequent
access to the pages in that range is handled as a new page fault.
This implies that if we don't have parallel access to the region when
MADV_DONTNEED is run we expect those range to be unallocated.

w.r.t page_mkclean we need to make sure that we don't break the MADV_DONTNEED
semantics. MADV_DONTNEED check for pmd_none without holding pmd_lock.
This implies we skip the pmd if we temporarily mark pmd none. Avoid doing
that while marking the page clean.

Keep the sequence same for dax too even though we don't support MADV_DONTNEED
for dax mapping

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 fs/dax.c  | 2 +-
 mm/rmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 01bfb2ac34f9..697bc2f59b90 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -814,7 +814,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 				goto unlock_pmd;
 
 			flush_cache_page(vma, address, pfn);
-			pmd = pmdp_huge_clear_flush(vma, address, pmdp);
+			pmd = pmdp_invalidate(vma, address, pmdp);
 			pmd = pmd_wrprotect(pmd);
 			pmd = pmd_mkclean(pmd);
 			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
diff --git a/mm/rmap.c b/mm/rmap.c
index b30c7c71d1d9..76c8dfd3ae1c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -928,7 +928,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 				continue;
 
 			flush_cache_page(vma, address, page_to_pfn(page));
-			entry = pmdp_huge_clear_flush(vma, address, pmd);
+			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
 			set_pmd_at(vma->vm_mm, address, pmd, entry);
-- 
2.20.1

