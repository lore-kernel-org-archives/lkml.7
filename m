Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67BC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DBD2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MAPMHQPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfKEVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:14:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfKEVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:14:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5L97H1160963;
        Tue, 5 Nov 2019 21:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=RAMT8X/ZhbKCXlv6pzpE03FxqLdsUKptBWrFcSxhjN8=;
 b=MAPMHQPe2ztzYDmlZB+F2wZ72T+JwXa5RClacTpqiynSrwb6Wq/Re7ZGYmtokaK3hlih
 61MlpVXK69k7pR8CP/C2A6lfhE+d5HqhHC9KgpyeaMnmweTcVr2vxL17cykxp4uHWvqY
 OhRLxLtEZkknqnFQRJbFa7LAdXiwixs+06RjWnUpw/re3t4DrIfRJPUyis7J1Av/IiFl
 lggcoM5j/DYYOGBoxqexd5YY6iHFBsIQFEdgMnbP+aNPxI/viNU91aHMD8o9gio/1JBk
 yaKIwFuXZgm1s37uFIfj2UIKfftI++loNeL7WY/mmftiYcy6ISwPXJXySJJg9ttIHV39 bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w117u1h3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 21:14:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5L7vHj048641;
        Tue, 5 Nov 2019 21:14:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w35ppn60b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 21:14:37 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA5LEZPk012269;
        Tue, 5 Nov 2019 21:14:35 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 13:14:35 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     kbuild@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlbfs: convert macros to static inline, fix sparse warning
Date:   Tue,  5 Nov 2019 13:14:34 -0800
Message-Id: <20191105211434.15804-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=831 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

huge_pte_offset() produced a sparse warning due to an improper
return type when the kernel was built with !CONFIG_HUGETLB_PAGE.
Fix the bad type and also convert all the macros in this block
to static inline wrappers.  Two existing wrappers in this block
had lines in excess of 80 columns so clean those up as well.

No functional change.
(sent to kbuild@lists.01.org to identify potential issues in all arch/configs)

Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 137 +++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d0..ef412fe0be3d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -164,38 +164,130 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
-#define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
-#define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
-#define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
+static inline long follow_hugetlb_page(struct mm_struct *mm,
+			struct vm_area_struct *vma, struct page **pages,
+			struct vm_area_struct **vmas, unsigned long *position,
+			unsigned long *nr_pages, long i, unsigned int flags,
+			int *nonblocking)
+{
+	BUG();
+	return 0;
+}
+
+static inline struct page *follow_huge_addr(struct mm_struct *mm,
+					unsigned long address, int write)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline int copy_hugetlb_page_range(struct mm_struct *dst,
+			struct mm_struct *src, struct vm_area_struct *vma)
+{
+	BUG();
+	return 0;
+}
+
 static inline void hugetlb_report_meminfo(struct seq_file *m)
 {
 }
-#define hugetlb_report_node_meminfo(n, buf)	0
+
+static inline int hugetlb_report_node_meminfo(int nid, char *buf)
+{
+	return 0;
+}
+
 static inline void hugetlb_show_meminfo(void)
 {
 }
-#define follow_huge_pd(vma, addr, hpd, flags, pdshift) NULL
-#define follow_huge_pmd(mm, addr, pmd, flags)	NULL
-#define follow_huge_pud(mm, addr, pud, flags)	NULL
-#define follow_huge_pgd(mm, addr, pgd, flags)	NULL
-#define prepare_hugepage_range(file, addr, len)	(-EINVAL)
-#define pmd_huge(x)	0
-#define pud_huge(x)	0
-#define is_hugepage_only_range(mm, addr, len)	0
-#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
-#define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
-				src_addr, pagep)	({ BUG(); 0; })
-#define huge_pte_offset(mm, address, sz)	0
+
+static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
+				unsigned long address, hugepd_t hpd, int flags,
+				int pdshift)
+{
+	return NULL;
+}
+
+static inline struct page *follow_huge_pmd(struct mm_struct *mm,
+				unsigned long address, pmd_t *pmd, int flags)
+{
+	return NULL;
+}
+
+static inline struct page *follow_huge_pud(struct mm_struct *mm,
+				unsigned long address, pud_t *pud, int flags)
+{
+	return NULL;
+}
+
+static inline struct page *follow_huge_pgd(struct mm_struct *mm,
+				unsigned long address, pgd_t *pgd, int flags)
+{
+	return NULL;
+}
+
+static inline int prepare_hugepage_range(struct file *file,
+				unsigned long addr, unsigned long len)
+{
+	return -EINVAL;
+}
+
+static inline int pmd_huge(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	return 0;
+}
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					unsigned long addr, unsigned long len)
+{
+	return 0;
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
+{
+	BUG();
+}
+
+static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
+						pte_t *dst_pte,
+						struct vm_area_struct *dst_vma,
+						unsigned long dst_addr,
+						unsigned long src_addr,
+						struct page **pagep)
+{
+	BUG();
+	return 0;
+}
+
+static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
+					unsigned long sz)
+{
+	return NULL;
+}
 
 static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	return false;
 }
-#define putback_active_hugepage(p)	do {} while (0)
-#define move_hugetlb_state(old, new, reason)	do {} while (0)
 
-static inline unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+static inline void putback_active_hugepage(struct page *page)
+{
+}
+
+static inline void move_hugetlb_state(struct page *oldpage,
+					struct page *newpage, int reason)
+{
+}
+
+static inline unsigned long hugetlb_change_protection(
+			struct vm_area_struct *vma, unsigned long address,
+			unsigned long end, pgprot_t newprot)
 {
 	return 0;
 }
@@ -213,9 +305,10 @@ static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 {
 	BUG();
 }
+
 static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
-				struct vm_area_struct *vma, unsigned long address,
-				unsigned int flags)
+			struct vm_area_struct *vma, unsigned long address,
+			unsigned int flags)
 {
 	BUG();
 	return 0;
-- 
2.20.1

