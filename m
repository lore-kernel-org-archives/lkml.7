Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF33BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89432175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCTA1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:27:52 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42483 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfCTA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:27:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TN9thOz_1553041659;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TN9thOz_1553041659)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Mar 2019 08:27:45 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
Date:   Wed, 20 Mar 2019 08:27:39 +0800
Message-Id: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPOL_MF_LAZY was added by commit b24f53a0bea3 ("mm: mempolicy: Add
MPOL_MF_LAZY"), then it was disabled by commit a720094ded8c ("mm:
mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
right away in 2012.  So, it is never ever exported to userspace.

And, it looks nobody is interested in revisiting it since it was
disabled 7 years ago.  So, it sounds pointless to still keep it around.

Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
Hi folks,
I'm not sure if you still would like to revisit it later. And, I may be
not the first one to try to remvoe it. IMHO, it sounds pointless to still
keep it around if nobody is interested in it.

 include/uapi/linux/mempolicy.h |  3 +--
 mm/mempolicy.c                 | 13 -------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774..eb52a7a 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -45,8 +45,7 @@ enum {
 #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
 				   to policy */
 #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
-#define MPOL_MF_LAZY	 (1<<3)	/* Modifies '_MOVE:  lazy migrate on fault */
-#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
+#define MPOL_MF_INTERNAL (1<<3)	/* Internal flags start here */
 
 #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
 			 MPOL_MF_MOVE     | 	\
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171cc..67886f4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -593,15 +593,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 	qp->prev = vma;
 
-	if (flags & MPOL_MF_LAZY) {
-		/* Similar to task_numa_work, skip inaccessible VMAs */
-		if (!is_vm_hugetlb_page(vma) &&
-			(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)) &&
-			!(vma->vm_flags & VM_MIXEDMAP))
-			change_prot_numa(vma, start, endvma);
-		return 1;
-	}
-
 	/* queue pages from current vma */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		return 0;
@@ -1181,9 +1172,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	if (flags & MPOL_MF_LAZY)
-		new->flags |= MPOL_F_MOF;
-
 	/*
 	 * If we are using the default policy then operation
 	 * on discontinuous address spaces is okay after all
@@ -1226,7 +1214,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 		int nr_failed = 0;
 
 		if (!list_empty(&pagelist)) {
-			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
 				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
 			if (nr_failed)
-- 
1.8.3.1

