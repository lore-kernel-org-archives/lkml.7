Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F76C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3934B2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGDQDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfGDQDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F49481F0D;
        Thu,  4 Jul 2019 16:03:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id A2240BA7D;
        Thu,  4 Jul 2019 16:03:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 Jul 2019 18:03:05 +0200 (CEST)
Date:   Thu, 4 Jul 2019 18:03:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, axboe@kernel.dk, hch@lst.de,
        peterz@infradead.org, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] swap_readpage: avoid blk_wake_io_task() if !synchronous
Message-ID: <20190704160301.GA5956@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559161526-618-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Jul 2019 16:03:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_readpage() sets waiter = bio->bi_private even if synchronous = F,
this means that the caller can get the spurious wakeup after return. This
can be fatal if blk_wake_io_task() does set_current_state(TASK_RUNNING)
after the caller does set_special_state(), in the worst case the kernel
can crash in do_task_dead().

Reported-by: Qian Cai <cai@lca.pw>
Acked-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 mm/page_io.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d..3098895 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -140,8 +140,10 @@ static void end_swap_bio_read(struct bio *bio)
 	unlock_page(page);
 	WRITE_ONCE(bio->bi_private, NULL);
 	bio_put(bio);
-	blk_wake_io_task(waiter);
-	put_task_struct(waiter);
+	if (waiter) {
+		blk_wake_io_task(waiter);
+		put_task_struct(waiter);
+	}
 }
 
 int generic_swapfile_activate(struct swap_info_struct *sis,
@@ -398,11 +400,12 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * Keep this task valid during swap readpage because the oom killer may
 	 * attempt to access it in the page fault retry time check.
 	 */
-	get_task_struct(current);
-	bio->bi_private = current;
 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-	if (synchronous)
+	if (synchronous) {
 		bio->bi_opf |= REQ_HIPRI;
+		get_task_struct(current);
+		bio->bi_private = current;
+	}
 	count_vm_event(PSWPIN);
 	bio_get(bio);
 	qc = submit_bio(bio);
-- 
2.5.0


