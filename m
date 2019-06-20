Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4CEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0272084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfFTCXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTCXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3594223880;
        Thu, 20 Jun 2019 02:23:42 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E968D1001E69;
        Thu, 20 Jun 2019 02:23:28 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 16/25] khugepaged: skip collapse if uffd-wp detected
Date:   Thu, 20 Jun 2019 10:19:59 +0800
Message-Id: <20190620022008.19172-17-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
References: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Jun 2019 02:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't collapse the huge PMD if there is any userfault write protected
small PTEs.  The problem is that the write protection is in small page
granularity and there's no way to keep all these write protection
information if the small pages are going to be merged into a huge PMD.

The same thing needs to be considered for swap entries and migration
entries.  So do the check as well disregarding khugepaged_max_ptes_swap.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index dd4db334bd63..2d7bad9cb976 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -13,6 +13,7 @@
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
+	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
 	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0f7419938008..fc40aa214be7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -29,6 +29,7 @@ enum scan_result {
 	SCAN_PMD_NULL,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_PTE_NON_PRESENT,
+	SCAN_PTE_UFFD_WP,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
@@ -1128,6 +1129,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
 			if (++unmapped <= khugepaged_max_ptes_swap) {
+				/*
+				 * Always be strict with uffd-wp
+				 * enabled swap entries.  Please see
+				 * comment below for pte_uffd_wp().
+				 */
+				if (pte_swp_uffd_wp(pteval)) {
+					result = SCAN_PTE_UFFD_WP;
+					goto out_unmap;
+				}
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
@@ -1147,6 +1157,19 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			result = SCAN_PTE_NON_PRESENT;
 			goto out_unmap;
 		}
+		if (pte_uffd_wp(pteval)) {
+			/*
+			 * Don't collapse the page if any of the small
+			 * PTEs are armed with uffd write protection.
+			 * Here we can also mark the new huge pmd as
+			 * write protected if any of the small ones is
+			 * marked but that could bring uknown
+			 * userfault messages that falls outside of
+			 * the registered range.  So, just be simple.
+			 */
+			result = SCAN_PTE_UFFD_WP;
+			goto out_unmap;
+		}
 		if (pte_write(pteval))
 			writable = true;
 
-- 
2.21.0

