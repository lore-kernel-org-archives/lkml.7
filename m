Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F7C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888D620645
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE0I1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:27:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:56802 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfE0I1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:27:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 01:27:21 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2019 01:27:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH -mm] mm, swap: Simplify total_swapcache_pages() with get_swap_device()
Date:   Mon, 27 May 2019 16:27:14 +0800
Message-Id: <20190527082714.12151-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

total_swapcache_pages() may race with swapper_spaces[] allocation and
freeing.  Previously, this is protected with a swapper_spaces[]
specific RCU mechanism.  To simplify the logic/code complexity, it is
replaced with get/put_swap_device().  The code line number is reduced
too.  Although not so important, the swapoff() performance improves
too because one synchronize_rcu() call during swapoff() is deleted.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 mm/swap_state.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index f509cdaa81b1..b84c58b572ca 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -73,23 +73,19 @@ unsigned long total_swapcache_pages(void)
 	unsigned int i, j, nr;
 	unsigned long ret = 0;
 	struct address_space *spaces;
+	struct swap_info_struct *si;
 
-	rcu_read_lock();
 	for (i = 0; i < MAX_SWAPFILES; i++) {
-		/*
-		 * The corresponding entries in nr_swapper_spaces and
-		 * swapper_spaces will be reused only after at least
-		 * one grace period.  So it is impossible for them
-		 * belongs to different usage.
-		 */
-		nr = nr_swapper_spaces[i];
-		spaces = rcu_dereference(swapper_spaces[i]);
-		if (!nr || !spaces)
+		/* Prevent swapoff to free swapper_spaces */
+		si = get_swap_device(swp_entry(i, 1));
+		if (!si)
 			continue;
+		nr = nr_swapper_spaces[i];
+		spaces = swapper_spaces[i];
 		for (j = 0; j < nr; j++)
 			ret += spaces[j].nrpages;
+		put_swap_device(si);
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -611,20 +607,16 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		mapping_set_no_writeback_tags(space);
 	}
 	nr_swapper_spaces[type] = nr;
-	rcu_assign_pointer(swapper_spaces[type], spaces);
+	swapper_spaces[type] = spaces;
 
 	return 0;
 }
 
 void exit_swap_address_space(unsigned int type)
 {
-	struct address_space *spaces;
-
-	spaces = swapper_spaces[type];
+	kvfree(swapper_spaces[type]);
 	nr_swapper_spaces[type] = 0;
-	rcu_assign_pointer(swapper_spaces[type], NULL);
-	synchronize_rcu();
-	kvfree(spaces);
+	swapper_spaces[type] = NULL;
 }
 
 static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
-- 
2.20.1

