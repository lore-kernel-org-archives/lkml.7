Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F71C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE122084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MO6t/uuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfFTUyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:54:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfFTUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:54:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KKr3CM022769
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=n2snFM7QmmPTPpShlBhEnsGKC2i2/uKCmCMTseCu52k=;
 b=MO6t/uuqWiOOomNBwU97YOg+TXttbjxehR5XUim4OqdKWGOalMKxrKcMTqcpsoFCSNTE
 v2Tyx+5GHTxXTSPAKkK7icdV+5yVIe0Ew+tP8foHoFHqdgSuCNXYJKLQy9typVFfpkod
 AIK/nAgzi7COfwqaGzTulaxsSRSMbugt65w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t8gch8935-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:54:07 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Jun 2019 13:54:05 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 06C3D62E2A35; Thu, 20 Jun 2019 13:54:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 4/6] khugepaged: rename collapse_shmem() and khugepaged_scan_shmem()
Date:   Thu, 20 Jun 2019 13:53:46 -0700
Message-ID: <20190620205348.3980213-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620205348.3980213-1-songliubraving@fb.com>
References: <20190620205348.3980213-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=570 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200150
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch will add khugepaged support of non-shmem files. This patch
renames these two functions to reflect the new functionality:

    collapse_shmem()        =>  collapse_file()
    khugepaged_scan_shmem() =>  khugepaged_scan_file()

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0f7419938008..dde8e45552b3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1287,7 +1287,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 }
 
 /**
- * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
+ * collapse_file - collapse small tmpfs/shmem pages into huge one.
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
@@ -1304,10 +1304,11 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  *    + restore gaps in the page cache;
  *    + unlock and free huge page;
  */
-static void collapse_shmem(struct mm_struct *mm,
+static void collapse_file(struct vm_area_struct *vma,
 		struct address_space *mapping, pgoff_t start,
 		struct page **hpage, int node)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	gfp_t gfp;
 	struct page *new_page;
 	struct mem_cgroup *memcg;
@@ -1563,7 +1564,7 @@ static void collapse_shmem(struct mm_struct *mm,
 	/* TODO: tracepoints */
 }
 
-static void khugepaged_scan_shmem(struct mm_struct *mm,
+static void khugepaged_scan_file(struct vm_area_struct *vma,
 		struct address_space *mapping,
 		pgoff_t start, struct page **hpage)
 {
@@ -1631,14 +1632,14 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
 			result = SCAN_EXCEED_NONE_PTE;
 		} else {
 			node = khugepaged_find_target_node();
-			collapse_shmem(mm, mapping, start, hpage, node);
+			collapse_file(vma, mapping, start, hpage, node);
 		}
 	}
 
 	/* TODO: tracepoints */
 }
 #else
-static void khugepaged_scan_shmem(struct mm_struct *mm,
+static void khugepaged_scan_file(struct vm_area_struct *vma,
 		struct address_space *mapping,
 		pgoff_t start, struct page **hpage)
 {
@@ -1722,7 +1723,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 				file = get_file(vma->vm_file);
 				up_read(&mm->mmap_sem);
 				ret = 1;
-				khugepaged_scan_shmem(mm, file->f_mapping,
+				khugepaged_scan_file(vma, file->f_mapping,
 						pgoff, hpage);
 				fput(file);
 			} else {
-- 
2.17.1

