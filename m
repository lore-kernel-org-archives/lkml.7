Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60995C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705524AEC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3GVvJag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFDH0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:26:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45252 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:26:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id x7so6997654plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f6lqyr2BfengWxFqHdlTowTllezFlrs3heXkz9HMYTU=;
        b=Y3GVvJagUgHx3WtvpI5wZzCkScGOTP8c2Nerrvzl4t/n5Dz1P3nmPGl+PV7wJklq1c
         V1xA7pFvEErx/7xHdNbouUEUqqPV/hu3CVLHobmhxoaxGRn2AB9U7zCxGk9mJi79VdBx
         GfF5MhXPSXWHl8g6DQPQ+uOOFdqctuhJlefhLkETVKWtwZVe/0VF+mi6otJLc6bho2Mg
         aErjdSMnuBy1O2NzrVwlChx99ecc6xNXIKSucHlDawiL7t/+5cUlToaDeX9VQtbZmxHz
         4hxW97y7dPSenJJxJndkqHorMn/zL0v87NxXt/v0OyoU7S//2mdIhiRWIY9Tk00ganOt
         VosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6lqyr2BfengWxFqHdlTowTllezFlrs3heXkz9HMYTU=;
        b=BQivyi0hn/2wnbcTz/3MK8Lez4iQTuhez/0DjhCMB5UapZ1ZPnkGK3ltu7t8wjjxpa
         R29T4CepnrVCXMdKE46Ynn5fofLjH7ZsfPR/WSk1EgKkZJT+nziIMBRH9Agcuiit3P4A
         RJPKEi6WEeO4H7Kz/WaVRAZQww94pnV0RaZScqGgY7qigP3FAY682hcZYyB54QHC0hs+
         eP22I0ER8w3fx3s+jmfCi/DQiO2s17YsEzwBrtidisk32Qn78OVoOTLFdhra0cZ2Xf+1
         I3qecZP4ysBAThYXP3pr73meVkZ1xdHZ+nZPMFTSUVfq7CBUQClTtteIr/PV7yy94VLG
         X7NQ==
X-Gm-Message-State: APjAAAV4qYNxikkz27no4wfSPPAjX4BhnTnG0bhE7W7O4mr211ijWFQ7
        7yo4PzPfi8BWUV+d9pim9XIFPGM=
X-Google-Smtp-Source: APXvYqzqFwkFw17oWfgcJRnP/Byrcg8l33w6SlO+CnZNXQp16bR9IEbAVSoS/WbBu98ZS5c2itf2gA==
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr33612048plc.272.1559633182666;
        Tue, 04 Jun 2019 00:26:22 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q17sm25748582pfq.74.2019.06.04.00.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:26:22 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/gup: remove unnecessary check against CMA in __gup_longterm_locked()
Date:   Tue,  4 Jun 2019 15:26:00 +0800
Message-Id: <1559633160-14809-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PF_MEMALLOC_NOCMA is set by memalloc_nocma_save(), which is finally
cast to ~_GFP_MOVABLE.  So __get_user_pages_locked() will get pages from
non CMA area and pin them.  There is no need to
check_and_migrate_cma_pages().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 146 ---------------------------------------------------------------
 1 file changed, 146 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcb..9d931d1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1275,149 +1275,6 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 	return false;
 }
 
-#ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
-{
-	/*
-	 * We want to make sure we allocate the new page from the same node
-	 * as the source page.
-	 */
-	int nid = page_to_nid(page);
-	/*
-	 * Trying to allocate a page for migration. Ignore allocation
-	 * failure warnings. We don't force __GFP_THISNODE here because
-	 * this node here is the node where we have CMA reservation and
-	 * in some case these nodes will have really less non movable
-	 * allocation memory.
-	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
-
-	if (PageHighMem(page))
-		gfp_mask |= __GFP_HIGHMEM;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
-	}
-#endif
-	if (PageTransHuge(page)) {
-		struct page *thp;
-		/*
-		 * ignore allocation failure warnings
-		 */
-		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
-
-		/*
-		 * Remove the movable mask so that we don't allocate from
-		 * CMA area again.
-		 */
-		thp_gfpmask &= ~__GFP_MOVABLE;
-		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	}
-
-	return __alloc_pages_node(nid, gfp_mask, 0);
-}
-
-static long check_and_migrate_cma_pages(struct task_struct *tsk,
-					struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
-{
-	long i;
-	bool drain_allow = true;
-	bool migrate_allow = true;
-	LIST_HEAD(cma_page_list);
-
-check_again:
-	for (i = 0; i < nr_pages; i++) {
-		/*
-		 * If we get a page from the CMA zone, since we are going to
-		 * be pinning these entries, we might as well move them out
-		 * of the CMA zone if possible.
-		 */
-		if (is_migrate_cma_page(pages[i])) {
-
-			struct page *head = compound_head(pages[i]);
-
-			if (PageHuge(head)) {
-				isolate_huge_page(head, &cma_page_list);
-			} else {
-				if (!PageLRU(head) && drain_allow) {
-					lru_add_drain_all();
-					drain_allow = false;
-				}
-
-				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
-					mod_node_page_state(page_pgdat(head),
-							    NR_ISOLATED_ANON +
-							    page_is_file_cache(head),
-							    hpage_nr_pages(head));
-				}
-			}
-		}
-	}
-
-	if (!list_empty(&cma_page_list)) {
-		/*
-		 * drop the above get_user_pages reference.
-		 */
-		for (i = 0; i < nr_pages; i++)
-			put_page(pages[i]);
-
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
-			/*
-			 * some of the pages failed migration. Do get_user_pages
-			 * without migration.
-			 */
-			migrate_allow = false;
-
-			if (!list_empty(&cma_page_list))
-				putback_movable_pages(&cma_page_list);
-		}
-		/*
-		 * We did migrate all the pages, Try to get the page references
-		 * again migrating any new CMA pages which we failed to isolate
-		 * earlier.
-		 */
-		nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
-						   pages, vmas, NULL,
-						   gup_flags);
-
-		if ((nr_pages > 0) && migrate_allow) {
-			drain_allow = true;
-			goto check_again;
-		}
-	}
-
-	return nr_pages;
-}
-#else
-static long check_and_migrate_cma_pages(struct task_struct *tsk,
-					struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
-{
-	return nr_pages;
-}
-#endif
-
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
  * allows us to process the FOLL_LONGTERM flag.
@@ -1462,9 +1319,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
-
-		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
-						 vmas_tmp, gup_flags);
 	}
 
 out:
-- 
2.7.5

