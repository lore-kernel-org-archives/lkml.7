Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745FC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2014726162
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaClb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:41:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:37166 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfEaCla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:41:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 19:41:30 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2019 19:41:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH -mm] mm, swap: Fix bad swap file entry warning
Date:   Fri, 31 May 2019 10:41:02 +0800
Message-Id: <20190531024102.21723-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Mike reported the following warning messages

  get_swap_device: Bad swap file entry 1400000000000001

This is produced by

- total_swapcache_pages()
  - get_swap_device()

Where get_swap_device() is used to check whether the swap device is
valid and prevent it from being swapoff if so.  But get_swap_device()
may produce warning message as above for some invalid swap devices.
This is fixed via calling swp_swap_info() before get_swap_device() to
filter out the swap devices that may cause warning messages.

Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/swap_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index b84c58b572ca..62da25b7f2ed 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -76,8 +76,13 @@ unsigned long total_swapcache_pages(void)
 	struct swap_info_struct *si;
 
 	for (i = 0; i < MAX_SWAPFILES; i++) {
+		swp_entry_t entry = swp_entry(i, 1);
+
+		/* Avoid get_swap_device() to warn for bad swap entry */
+		if (!swp_swap_info(entry))
+			continue;
 		/* Prevent swapoff to free swapper_spaces */
-		si = get_swap_device(swp_entry(i, 1));
+		si = get_swap_device(entry);
 		if (!si)
 			continue;
 		nr = nr_swapper_spaces[i];
-- 
2.20.1

