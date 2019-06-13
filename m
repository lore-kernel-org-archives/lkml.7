Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B708C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59A20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbfFMQdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:33:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbfFMIMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:12:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43A7C367;
        Thu, 13 Jun 2019 01:12:35 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A42093F557;
        Thu, 13 Jun 2019 01:12:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/vmalloc: Check absolute error return from vmap_[p4d|pud|pmd|pte]_range()
Date:   Thu, 13 Jun 2019 13:42:31 +0530
Message-Id: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap_pte_range() returns an -EBUSY when it encounters a non-empty PTE. But
currently vmap_pmd_range() unifies both -EBUSY and -ENOMEM return code as
-ENOMEM and send it up the call chain which is wrong. Interestingly enough
vmap_page_range_noflush() tests for the absolute error return value from
vmap_p4d_range() but it does not help because -EBUSY has been merged with
-ENOMEM. So all it can return is -ENOMEM. Fix this by testing for absolute
error return from vmap_pmd_range() all the way up to vmap_p4d_range().

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/vmalloc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7350a124524b..6c7dd8df23c3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -165,14 +165,16 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err = 0;
 
 	pmd = pmd_alloc(&init_mm, pud, addr);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr))
-			return -ENOMEM;
+		err = vmap_pte_range(pmd, addr, next, prot, pages, nr);
+		if (err)
+			return err;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -182,14 +184,16 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 {
 	pud_t *pud;
 	unsigned long next;
+	int err = 0;
 
 	pud = pud_alloc(&init_mm, p4d, addr);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr))
-			return -ENOMEM;
+		err = vmap_pmd_range(pud, addr, next, prot, pages, nr);
+		if (err)
+			return err;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
@@ -199,14 +203,16 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int err = 0;
 
 	p4d = p4d_alloc(&init_mm, pgd, addr);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr))
-			return -ENOMEM;
+		err = vmap_pud_range(p4d, addr, next, prot, pages, nr);
+		if (err)
+			return err;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
 }
-- 
2.20.1

