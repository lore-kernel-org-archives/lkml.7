Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F6C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63A23D13
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z04b3DzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfFDQvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:51:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44280 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727623AbfFDQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:51:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x54GYHh2010392
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 09:51:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=e4naQYLOgSB4W5gzyf2D9ya4eydHyxTdM1krXnD1/N4=;
 b=Z04b3DzWU4kO2rrzPtBVxVYW2ApReohxpsqDTZsr29EGlceJxjTx7Vc+eoXxo/oYcOd2
 17ZShpiE05PHl3mV+NVbk2380mTGhxoTNPm/5qXW/Wgg/uOJ6Ei2DMTmC9yYsFuVfshi
 BFajJji+x6CqhiPJHnudKzXS+F6qJgAP91A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2swun487rn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:51:49 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Jun 2019 09:51:48 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E527B62E1EE3; Tue,  4 Jun 2019 09:51:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH uprobe, thp v2 2/5] uprobe: use original page when all uprobes are removed
Date:   Tue, 4 Jun 2019 09:51:35 -0700
Message-ID: <20190604165138.1520916-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604165138.1520916-1-songliubraving@fb.com>
References: <20190604165138.1520916-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040106
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
on the page are already removed).

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 42 ++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 78f61bfc6b79..3fca7c55d370 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -160,16 +160,19 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	int err;
 	struct mmu_notifier_range range;
 	struct mem_cgroup *memcg;
+	bool orig = new_page->mapping != NULL;  /* new_page == orig_page */
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 
 	VM_BUG_ON_PAGE(PageTransHuge(old_page), old_page);
 
-	err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL, &memcg,
-			false);
-	if (err)
-		return err;
+	if (!orig) {
+		err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL,
+					    &memcg, false);
+		if (err)
+			return err;
+	}
 
 	/* For try_to_free_swap() and munlock_vma_page() below */
 	lock_page(old_page);
@@ -177,15 +180,22 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	mmu_notifier_invalidate_range_start(&range);
 	err = -EAGAIN;
 	if (!page_vma_mapped_walk(&pvmw)) {
-		mem_cgroup_cancel_charge(new_page, memcg, false);
+		if (!orig)
+			mem_cgroup_cancel_charge(new_page, memcg, false);
 		goto unlock;
 	}
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
 
 	get_page(new_page);
-	page_add_new_anon_rmap(new_page, vma, addr, false);
-	mem_cgroup_commit_charge(new_page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(new_page, vma);
+	if (orig) {
+		page_add_file_rmap(new_page, false);
+		inc_mm_counter(mm, mm_counter_file(new_page));
+		dec_mm_counter(mm, MM_ANONPAGES);
+	} else {
+		page_add_new_anon_rmap(new_page, vma, addr, false);
+		mem_cgroup_commit_charge(new_page, memcg, false, false);
+		lru_cache_add_active_or_unevictable(new_page, vma);
+	}
 
 	if (!PageAnon(old_page)) {
 		dec_mm_counter(mm, mm_counter_file(old_page));
@@ -461,9 +471,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode)
 {
 	struct uprobe *uprobe;
-	struct page *old_page, *new_page;
+	struct page *old_page, *new_page, *orig_page = NULL;
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
+	pgoff_t index;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
@@ -501,6 +512,19 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	copy_highpage(new_page, old_page);
 	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 
+	index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
+	orig_page = find_get_page(vma->vm_file->f_inode->i_mapping, index);
+	if (orig_page) {
+		if (pages_identical(new_page, orig_page)) {
+			/* if new_page matches orig_page, use orig_page */
+			put_page(new_page);
+			new_page = orig_page;
+		} else {
+			put_page(orig_page);
+			orig_page = NULL;
+		}
+	}
+
 	ret = __replace_page(vma, vaddr, old_page, new_page);
 	put_page(new_page);
 put_old:
-- 
2.17.1

