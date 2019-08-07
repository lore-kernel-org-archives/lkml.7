Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F57C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9A20880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bpp63PKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbfHGXhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:37:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35198 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389185AbfHGXhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:37:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77Nbc1n015319
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 16:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=i6y9YuM25PmZvfyze3uwWL3WudRVKnCnrUVAiWkqwhw=;
 b=bpp63PKWsG2+WIjAGLPTp20V2vkMPg1W0rHosWw7cWWyRbR7K2CIjvInurtiSWuPSOBz
 UYflakVwnggiwLhplauukSIm7Cc1Ar5vmU1wdsc5M2KSJWHsj+++YlBq1Mq3dE7Puwpr
 +yG3PKVTReooHvg4Q5S18V19vVsNzsAntHI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u87ugr3y2-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:37:40 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 16:37:37 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1AA3862E2D9E; Wed,  7 Aug 2019 16:37:37 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <oleg@redhat.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <srikar@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v12 2/6] uprobe: use original page when all uprobes are removed
Date:   Wed, 7 Aug 2019 16:37:25 -0700
Message-ID: <20190807233729.3899352-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807233729.3899352-1-songliubraving@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=952 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070209
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, uprobe swaps the target page with a anonymous page in both
install_breakpoint() and remove_breakpoint(). When all uprobes on a page
are removed, the given mm is still using an anonymous page (not the
original page).

This patch allows uprobe to use original page when possible (all uprobes
on the page are already removed, and the original page is in page cache
and uptodate).

As suggested by Oleg, we unmap the old_page and let the original page
fault in.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 66 +++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 84fa00497c49..648f47553bff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -143,10 +143,12 @@ static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
  *
  * @vma:      vma that holds the pte pointing to page
  * @addr:     address the old @page is mapped at
- * @page:     the cowed page we are replacing by kpage
- * @kpage:    the modified page we replace page by
+ * @old_page: the page we are replacing by new_page
+ * @new_page: the modified page we replace page by
  *
- * Returns 0 on success, -EFAULT on failure.
+ * If @new_page is NULL, only unmap @old_page.
+ *
+ * Returns 0 on success, negative error code otherwise.
  */
 static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 				struct page *old_page, struct page *new_page)
@@ -166,10 +168,12 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	VM_BUG_ON_PAGE(PageTransHuge(old_page), old_page);
 
-	err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL, &memcg,
-			false);
-	if (err)
-		return err;
+	if (new_page) {
+		err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL,
+					    &memcg, false);
+		if (err)
+			return err;
+	}
 
 	/* For try_to_free_swap() and munlock_vma_page() below */
 	lock_page(old_page);
@@ -177,15 +181,20 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	mmu_notifier_invalidate_range_start(&range);
 	err = -EAGAIN;
 	if (!page_vma_mapped_walk(&pvmw)) {
-		mem_cgroup_cancel_charge(new_page, memcg, false);
+		if (new_page)
+			mem_cgroup_cancel_charge(new_page, memcg, false);
 		goto unlock;
 	}
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
 
-	get_page(new_page);
-	page_add_new_anon_rmap(new_page, vma, addr, false);
-	mem_cgroup_commit_charge(new_page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(new_page, vma);
+	if (new_page) {
+		get_page(new_page);
+		page_add_new_anon_rmap(new_page, vma, addr, false);
+		mem_cgroup_commit_charge(new_page, memcg, false, false);
+		lru_cache_add_active_or_unevictable(new_page, vma);
+	} else
+		/* no new page, just dec_mm_counter for old_page */
+		dec_mm_counter(mm, MM_ANONPAGES);
 
 	if (!PageAnon(old_page)) {
 		dec_mm_counter(mm, mm_counter_file(old_page));
@@ -194,8 +203,9 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
 	ptep_clear_flush_notify(vma, addr, pvmw.pte);
-	set_pte_at_notify(mm, addr, pvmw.pte,
-			mk_pte(new_page, vma->vm_page_prot));
+	if (new_page)
+		set_pte_at_notify(mm, addr, pvmw.pte,
+				  mk_pte(new_page, vma->vm_page_prot));
 
 	page_remove_rmap(old_page, false);
 	if (!page_mapped(old_page))
@@ -488,6 +498,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		ref_ctr_updated = 1;
 	}
 
+	ret = 0;
+	if (!is_register && !PageAnon(old_page))
+		goto put_old;
+
 	ret = anon_vma_prepare(vma);
 	if (ret)
 		goto put_old;
@@ -501,8 +515,30 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	copy_highpage(new_page, old_page);
 	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 
+	if (!is_register) {
+		struct page *orig_page;
+		pgoff_t index;
+
+		VM_BUG_ON_PAGE(!PageAnon(old_page), old_page);
+
+		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
+		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
+					  index);
+
+		if (orig_page) {
+			if (PageUptodate(orig_page) &&
+			    pages_identical(new_page, orig_page)) {
+				/* let go new_page */
+				put_page(new_page);
+				new_page = NULL;
+			}
+			put_page(orig_page);
+		}
+	}
+
 	ret = __replace_page(vma, vaddr, old_page, new_page);
-	put_page(new_page);
+	if (new_page)
+		put_page(new_page);
 put_old:
 	put_page(old_page);
 
-- 
2.17.1

