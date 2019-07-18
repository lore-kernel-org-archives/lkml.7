Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168FC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA3C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfGRJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:02:43 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:37261 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfGRJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:02:43 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id B85DA989D5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 10:02:40 +0100 (IST)
Received: (qmail 4427 invoked from network); 18 Jul 2019 09:02:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jul 2019 09:02:40 -0000
Date:   Thu, 18 Jul 2019 10:02:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm: migrate: Fix reference check race between
 __find_get_block() and migration
Message-ID: <20190718090238.GF24383@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

buffer_migrate_page_norefs() can race with bh users in the following way:

CPU1                                    CPU2
buffer_migrate_page_norefs()
  buffer_migrate_lock_buffers()
  checks bh refs
  spin_unlock(&mapping->private_lock)
                                        __find_get_block()
                                          spin_lock(&mapping->private_lock)
                                          grab bh ref
                                          spin_unlock(&mapping->private_lock)
  move page                               do bh work

This can result in various issues like lost updates to buffers (i.e.
metadata corruption) or use after free issues for the old page.

This patch closes the race by holding mapping->private_lock while the
mapping is being moved to a new page. Ordinarily, a reference can be taken
outside of the private_lock using the per-cpu BH LRU but the references
are checked and the LRU invalidated if necessary. The private_lock is held
once the references are known so the buffer lookup slow path will spin
on the private_lock. Between the page lock and private_lock, it should
be impossible for other references to be acquired and updates to happen
during the migration.

A user had reported data corruption issues on a distribution kernel with
a similar page migration implementation as mainline. The data corruption
could not be reproduced with this patch applied. A small number of
migration-intensive tests were run and no performance problems were noted.

[mgorman@techsingularity.net: Changelog, removed tracing]
Fixes: 89cb0888ca14 "mm: migrate: provide buffer_migrate_page_norefs()"
CC: stable@vger.kernel.org # v5.0+
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e9594bc0d406..a59e4aed6d2e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -771,12 +771,12 @@ static int __buffer_migrate_page(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
-		spin_unlock(&mapping->private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
+			spin_unlock(&mapping->private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -809,6 +809,8 @@ static int __buffer_migrate_page(struct address_space *mapping,
 
 	rc = MIGRATEPAGE_SUCCESS;
 unlock_buffers:
+	if (check_refs)
+		spin_unlock(&mapping->private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);

-- 
Mel Gorman
SUSE Labs
