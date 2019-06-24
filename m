Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1242220673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFXCZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:25:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:46345 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfFXCZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:25:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 19:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,410,1557212400"; 
   d="scan'208";a="171832130"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2019 19:25:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -mm] mm, swap: Fix THP swap out
Date:   Mon, 24 Jun 2019 10:23:36 +0800
Message-Id: <20190624022336.12465-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

0-Day test system reported some OOM regressions for several
THP (Transparent Huge Page) swap test cases.  These regressions are
bisected to 6861428921b5 ("block: always define BIO_MAX_PAGES as
256").  In the commit, BIO_MAX_PAGES is set to 256 even when THP swap
is enabled.  So the bio_alloc(gfp_flags, 512) in get_swap_bio() may
fail when swapping out THP.  That causes the OOM.

As in the patch description of 6861428921b5 ("block: always define
BIO_MAX_PAGES as 256"), THP swap should use multi-page bvec to write
THP to swap space.  So the issue is fixed via doing that in
get_swap_bio().

BTW: I remember I have checked the THP swap code when
6861428921b5 ("block: always define BIO_MAX_PAGES as 256") was merged,
and thought the THP swap code needn't to be changed.  But apparently,
I was wrong.  I should have done this at that time.

Fixes: 6861428921b5 ("block: always define BIO_MAX_PAGES as 256")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/page_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..4ab997f84061 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -29,10 +29,9 @@
 static struct bio *get_swap_bio(gfp_t gfp_flags,
 				struct page *page, bio_end_io_t end_io)
 {
-	int i, nr = hpage_nr_pages(page);
 	struct bio *bio;
 
-	bio = bio_alloc(gfp_flags, nr);
+	bio = bio_alloc(gfp_flags, 1);
 	if (bio) {
 		struct block_device *bdev;
 
@@ -41,9 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
-		for (i = 0; i < nr; i++)
-			bio_add_page(bio, page + i, PAGE_SIZE, 0);
-		VM_BUG_ON(bio->bi_iter.bi_size != PAGE_SIZE * nr);
+		__bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
 	}
 	return bio;
 }
-- 
2.20.1

