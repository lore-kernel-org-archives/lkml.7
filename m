Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4BDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DCD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOFYmPx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJ2X3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:29:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ2X3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:29:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TNSmr5010498;
        Tue, 29 Oct 2019 23:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=MoGT4nP4XOi5I3jpQOSqMUtg1Dh/ZOKH1DoO7Me+Jks=;
 b=oOFYmPx+AnOBWvTZdpTy8sKeHfKNYnWzurHYlt2U8aXkjanLbIxoSh0PpcG63a4E16pq
 LQtaSWgpcdPz2v0Ko4eTLpJpjuetRcWNEuXZXpQuvDWI47gSqFsXnp+R6Aq7uLdYd2+f
 i3QcEs8E05NmeGfOChWitDQ0AP7/y+IwhKtlJhwAh0XSUdu38Pa1y6XxiBWSqGsYKs/I
 RzLdmYtkqXebY9bm9DbnoEkkdPHZqm7uOYSfkw7XbquTISzh20VSXz4vKn007IK7iCri
 0EsoE76LIkzOfCSgALOubE8Onlnt4gm5pqMId7MPnKUBJpR5haV40l/WYrZWYliM4BTr 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhfgas5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 23:28:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TNS6aZ178625;
        Tue, 29 Oct 2019 23:28:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vxwj54tfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 23:28:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TNShQJ010348;
        Tue, 29 Oct 2019 23:28:43 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 16:28:43 -0700
Subject: Re: [PATCH] mm: huge_pte_offset() returns pte_t *, not integer
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191016095111.29163-1-ben.dooks@codethink.co.uk>
 <bd0ac181-7334-9970-b16a-ce7fd78d30ec@oracle.com>
 <20191029123557.GA6128@ziepe.ca>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9b689b27-0291-c8b2-95aa-d3a74eab6543@oracle.com>
Date:   Tue, 29 Oct 2019 16:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029123557.GA6128@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=970
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 5:35 AM, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 02:55:13PM -0700, Mike Kravetz wrote:
> 
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 53fc34f930d0..e42c76aa1577 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -185,7 +185,7 @@ static inline void hugetlb_show_meminfo(void)
>>>  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
>>>  #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
>>>  				src_addr, pagep)	({ BUG(); 0; })
>>> -#define huge_pte_offset(mm, address, sz)	0
>>> +#define huge_pte_offset(mm, address, sz)	(pte_t *)NULL
> 
> We have recently been converting functions like this to static
> inlines, maybe that is more appropriate for this block of 'functions'
> as well?

Yes.  And thanks again Jason for converting some of these in the past!

How about this?

From ad7415f59f144ca36cf0c3b27504a5ee76b5e9e6 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 29 Oct 2019 14:26:08 -0700
Subject: [PATCH] hugetlbfs: convert macros to static inline, fix sparse
 warning

huge_pte_offset() produced a sparse warning due to an improper
return type when the kernel was built with !CONFIG_HUGETLB_PAGE.
Fix the bad type and also convert all the macros in this block
to static inline wrappers.  Two existing wrappers in this block
had lines in excess of 80 columns so clean those up as well.

No functional change.

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

