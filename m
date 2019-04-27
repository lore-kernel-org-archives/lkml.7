Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF42C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DE6208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfD0P1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:27:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33304 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbfD0PPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-0000z6-Mc; Sat, 27 Apr 2019 16:15:21 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004bw-PK; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Nikos Tsironis" <ntsironis@arrikto.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        "Joe Thornber" <ejt@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.508950300@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 159/202] dm thin: fix bug where bio that overwrites
 thin block ignores FUA
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nikos Tsironis <ntsironis@arrikto.com>

commit 4ae280b4ee3463fa57bbe6eede26b97daff8a0f1 upstream.

When provisioning a new data block for a virtual block, either because
the block was previously unallocated or because we are breaking sharing,
if the whole block of data is being overwritten the bio that triggered
the provisioning is issued immediately, skipping copying or zeroing of
the data block.

When this bio completes the new mapping is inserted in to the pool's
metadata by process_prepared_mapping(), where the bio completion is
signaled to the upper layers.

This completion is signaled without first committing the metadata.  If
the bio in question has the REQ_FUA flag set and the system crashes
right after its completion and before the next metadata commit, then the
write is lost despite the REQ_FUA flag requiring that I/O completion for
this request must only be signaled after the data has been committed to
non-volatile storage.

Fix this by deferring the completion of overwrite bios, with the REQ_FUA
flag set, until after the metadata has been committed.

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Acked-by: Joe Thornber <ejt@redhat.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[bwh: Backported to 3.16:
 - bio_endio() takes an error parameter
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-thin.c | 55 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -185,6 +185,7 @@ struct pool {
 
 	spinlock_t lock;
 	struct bio_list deferred_flush_bios;
+	struct bio_list deferred_flush_completions;
 	struct list_head prepared_mappings;
 	struct list_head prepared_discards;
 	struct list_head active_thins;
@@ -665,6 +666,39 @@ static void process_prepared_mapping_fai
 	mempool_free(m, m->tc->pool->mapping_pool);
 }
 
+static void complete_overwrite_bio(struct thin_c *tc, struct bio *bio)
+{
+	struct pool *pool = tc->pool;
+	unsigned long flags;
+
+	/*
+	 * If the bio has the REQ_FUA flag set we must commit the metadata
+	 * before signaling its completion.
+	 */
+	if (!bio_triggers_commit(tc, bio)) {
+		bio_endio(bio, 0);
+		return;
+	}
+
+	/*
+	 * Complete bio with an error if earlier I/O caused changes to the
+	 * metadata that can't be committed, e.g, due to I/O errors on the
+	 * metadata device.
+	 */
+	if (dm_thin_aborted_changes(tc->td)) {
+		bio_io_error(bio);
+		return;
+	}
+
+	/*
+	 * Batch together any bios that trigger commits and then issue a
+	 * single commit for them in process_deferred_bios().
+	 */
+	spin_lock_irqsave(&pool->lock, flags);
+	bio_list_add(&pool->deferred_flush_completions, bio);
+	spin_unlock_irqrestore(&pool->lock, flags);
+}
+
 static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 {
 	struct thin_c *tc = m->tc;
@@ -703,7 +737,7 @@ static void process_prepared_mapping(str
 	 */
 	if (bio) {
 		cell_defer_no_holder(tc, m->cell);
-		bio_endio(bio, 0);
+		complete_overwrite_bio(tc, bio);
 	} else
 		cell_defer(tc, m->cell);
 
@@ -1575,7 +1609,7 @@ static void process_deferred_bios(struct
 {
 	unsigned long flags;
 	struct bio *bio;
-	struct bio_list bios;
+	struct bio_list bios, bio_completions;
 	struct thin_c *tc;
 
 	tc = get_first_thin(pool);
@@ -1585,26 +1619,36 @@ static void process_deferred_bios(struct
 	}
 
 	/*
-	 * If there are any deferred flush bios, we must commit
-	 * the metadata before issuing them.
+	 * If there are any deferred flush bios, we must commit the metadata
+	 * before issuing them or signaling their completion.
 	 */
 	bio_list_init(&bios);
+	bio_list_init(&bio_completions);
+
 	spin_lock_irqsave(&pool->lock, flags);
 	bio_list_merge(&bios, &pool->deferred_flush_bios);
 	bio_list_init(&pool->deferred_flush_bios);
+
+	bio_list_merge(&bio_completions, &pool->deferred_flush_completions);
+	bio_list_init(&pool->deferred_flush_completions);
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	if (bio_list_empty(&bios) &&
+	if (bio_list_empty(&bios) && bio_list_empty(&bio_completions) &&
 	    !(dm_pool_changed_this_transaction(pool->pmd) && need_commit_due_to_time(pool)))
 		return;
 
 	if (commit(pool)) {
+		bio_list_merge(&bios, &bio_completions);
+
 		while ((bio = bio_list_pop(&bios)))
 			bio_io_error(bio);
 		return;
 	}
 	pool->last_commit_jiffies = jiffies;
 
+	while ((bio = bio_list_pop(&bio_completions)))
+		bio_endio(bio, 0);
+
 	while ((bio = bio_list_pop(&bios)))
 		generic_make_request(bio);
 }
@@ -2174,6 +2218,7 @@ static struct pool *pool_create(struct m
 	INIT_DELAYED_WORK(&pool->no_space_timeout, do_no_space_timeout);
 	spin_lock_init(&pool->lock);
 	bio_list_init(&pool->deferred_flush_bios);
+	bio_list_init(&pool->deferred_flush_completions);
 	INIT_LIST_HEAD(&pool->prepared_mappings);
 	INIT_LIST_HEAD(&pool->prepared_discards);
 	INIT_LIST_HEAD(&pool->active_thins);

