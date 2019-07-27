Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4058DC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6620840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfG0KUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:20:34 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2117 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfG0KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:20:34 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5d3c255eb55-4f272; Sat, 27 Jul 2019 18:20:15 +0800 (CST)
X-RM-TRANSID: 2eec5d3c255eb55-4f272
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45d3c255db6c-ef1e9;
        Sat, 27 Jul 2019 18:20:15 +0800 (CST)
X-RM-TRANSID: 2ee45d3c255db6c-ef1e9
From:   Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To:     colyli@suse.de, kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        baiyaowei@cmss.chinamobile.com
Subject: [PATCH 3/3] bcache: count cache_available_percent accurately
Date:   Sat, 27 Jul 2019 18:19:59 +0800
Message-Id: <1564222799-10603-3-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564222799-10603-1-git-send-email-baiyaowei@cmss.chinamobile.com>
References: <1564222799-10603-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface cache_available_percent is used to indicate how
many buckets in percent are available to be used to cache data
at a specific moment. It should include the unused and clean
buckets which we get from bch_btree_gc_finish function:

	if (!GC_MARK(b) || GC_MARK(b) == GC_MARK_RECLAIMABLE)
		 c->avail_nbuckets++;

However currently in the allocation code we didn't distinguish
these available buckets with the metadata and dirty buckets, we
just decrease the c->avail_nbuckets everytime we allocate a bucket,
and correct it after a gc completes. With this, in a read-only
scenario, you can observe that cache_available_percent bounces,
it first go down to a number, like 95, and then bounces back to
100. It goes on and on, making users confused.

This patch fixes this problem by decreasing c->avail_nbuckets
only when allocate metadata and dirty buckets. With this patch,
cache_available_percent will always be accurate and avoid the
confusion.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 drivers/md/bcache/alloc.c   | 10 +++++-----
 drivers/md/bcache/request.c |  9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 609df38..dc7f6c2 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -443,17 +443,17 @@ long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait)
 		SET_GC_MARK(b, GC_MARK_METADATA);
 		SET_GC_MOVE(b, 0);
 		b->prio = BTREE_PRIO;
+
+		if (ca->set->avail_nbuckets > 0) {
+			ca->set->avail_nbuckets--;
+			bch_update_bucket_in_use(ca->set, &ca->set->gc_stats);
+		}
 	} else {
 		SET_GC_MARK(b, GC_MARK_RECLAIMABLE);
 		SET_GC_MOVE(b, 0);
 		b->prio = INITIAL_PRIO;
 	}
 
-	if (ca->set->avail_nbuckets > 0) {
-		ca->set->avail_nbuckets--;
-		bch_update_bucket_in_use(ca->set, &ca->set->gc_stats);
-	}
-
 	return r;
 }
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 41adcd1..b69bd8d 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -244,9 +244,16 @@ static void bch_data_insert_start(struct closure *cl)
 		if (op->writeback) {
 			SET_KEY_DIRTY(k, true);
 
-			for (i = 0; i < KEY_PTRS(k); i++)
+			for (i = 0; i < KEY_PTRS(k); i++) {
 				SET_GC_MARK(PTR_BUCKET(op->c, k, i),
 					    GC_MARK_DIRTY);
+
+				if (op->c->avail_nbuckets > 0) {
+					op->c->avail_nbuckets--;
+					bch_update_bucket_in_use(op->c,
+								 &op->c->gc_stats);
+				}
+			}
 		}
 
 		SET_KEY_CSUM(k, op->csum);
-- 
1.8.3.1



