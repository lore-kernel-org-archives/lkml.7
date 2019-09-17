Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C5AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBBD206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfIQX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1313 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfIQX2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DFA618C4266;
        Tue, 17 Sep 2019 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F248B19C6A;
        Tue, 17 Sep 2019 23:28:36 +0000 (UTC)
From:   xiubli@redhat.com
To:     mingo@redhat.com, peterz@infradead.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
Date:   Wed, 18 Sep 2019 04:58:20 +0530
Message-Id: <20190917232820.23504-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 17 Sep 2019 23:28:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The GFP_NOIO means all further allocations will implicitly drop
both __GFP_IO and __GFP_FS flags and so they are safe for both the
IO critical section and the the critical section from the allocation
recursion point of view. Not only the __GFP_IO, which a bit confusing
when reading the code or using the save/restore pair.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 include/linux/sched/mm.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4a7944078cc3..9bdc97e52de1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -211,10 +211,11 @@ static inline void fs_reclaim_release(gfp_t gfp_mask) { }
  * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
  *
  * This functions marks the beginning of the GFP_NOIO allocation scope.
- * All further allocations will implicitly drop __GFP_IO flag and so
- * they are safe for the IO critical section from the allocation recursion
- * point of view. Use memalloc_noio_restore to end the scope with flags
- * returned by this function.
+ * All further allocations will implicitly drop __GFP_IO and __GFP_FS
+ * flags and so they are safe for both the IO critical section and the
+ * the critical section from the allocation recursion point of view. Use
+ * memalloc_noio_restore to end the scope with flags returned by this
+ * function.
  *
  * This function is safe to be used from any context.
  */
-- 
2.21.0

