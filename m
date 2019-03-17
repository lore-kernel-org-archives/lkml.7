Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38594C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71CB2184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="LaTAvkO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCQMXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:23:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:23:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so13998804wrh.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyqI+apM2JxxBmHnyL3ek6dv57ZYo4J43XloC+rdkpI=;
        b=LaTAvkO5F0dwQ8dJm5prlthxIXCp6/D/dPI//CSsneefbxnjYQDZYXDcLi3L+a2Ftj
         Tcnda1ebSSlHL0foItjzAJ0DDw8hjezi/cTkjNGuDlcXR1B4EH526GY2AWr3l2idDcTF
         gM4FxNoTFIu+JQ9MXeNjxFN2/ymvXRM6wFVRd2orMOKMb61ScYXHuQY4oGWIg/XqC7E/
         vMuXAPkOxLICszdNTJabO3m5Te8Mm3mcv/y1J8visuNb1T5k9tgDKKssJLwablnL/sXQ
         rJv66DIvyzRoYzdjWRWud+UP47CMcAX0dsWqnOBZGqsxvV+MVGDRlk0hAmiq3MAEkfft
         /5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyqI+apM2JxxBmHnyL3ek6dv57ZYo4J43XloC+rdkpI=;
        b=X3AZ+cEGUZ3EiJWwmRVS+r//9Y4Ko5KrHuZj9k4OcTekbztC77by2RbBcZGclMAIz1
         5Bqo2q/jSeEX1M3KR4v+gD1IS2yAD3rPhL8x5TVGeQfASyKMZRfVHM1846a8hHkuN9Wu
         3IjFoEDtS1M8PVsm9AXW09RtBlh/fNxs4EqzmlIz5UvdCOJ/V4Tk26wCM/XDcEFJ/n2H
         /Z02DDIskHbPksbx+QzCCeDhToKe6Y3iN9LnDE3tHs3YYMMhnzZL2nZno+pZs6+dyi0t
         PE/P53G8+sXOfjk8FTP7+1QHGYsEDx7YBFBaMvxWFoBz3NLnj5b6pmMpk7apxHRY4uS/
         AmKg==
X-Gm-Message-State: APjAAAWWpysnK1FLA3riw1amEicJF/pkiapw0Mp4c3O1txLpMbCjP0x7
        BYdUv81AV9SUQPsx2XXAprwrRxkyQ5I=
X-Google-Smtp-Source: APXvYqzWGxQ6ihh3n7IC1Vh3iqQL2H9hyHgBKEloemecYczSCrOfKd8SPUluTe8nUk2KEZPa9vS2Mg==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr9046026wrn.184.1552825384625;
        Sun, 17 Mar 2019 05:23:04 -0700 (PDT)
Received: from snf-864.vm.snf.arr ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id z10sm5453292wrs.11.2019.03.17.05.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:23:04 -0700 (PDT)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com
Cc:     mpatocka@redhat.com, paulmck@linux.ibm.com, hch@infradead.org,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] dm snapshot: Don't sleep holding the snapshot lock
Date:   Sun, 17 Mar 2019 14:22:55 +0200
Message-Id: <20190317122258.21760-4-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190317122258.21760-1-ntsironis@arrikto.com>
References: <20190317122258.21760-1-ntsironis@arrikto.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When completing a pending exception, pending_complete() waits for all
conflicting reads to drain, before inserting the final, completed
exception. Conflicting reads are snapshot reads redirected to the
origin, because the relevant chunk is not remapped to the COW device the
moment we receive the read.

The completed exception must be inserted into the exception table after
all conflicting reads drain to ensure snapshot reads don't return
corrupted data. This is required because inserting the completed
exception into the exception table signals that the relevant chunk is
remapped and both origin writes and snapshot merging will now overwrite
the chunk in origin.

This wait is done holding the snapshot lock to ensure that
pending_complete() doesn't starve if new snapshot reads keep coming for
this chunk.

In preparation for the next commit, where we use a spinlock instead of a
mutex to protect the exception tables, we remove the need for holding
the lock while waiting for conflicting reads to drain.

We achieve this in two steps:

1. pending_complete() inserts the completed exception before waiting for
   conflicting reads to drain and removes the pending exception after
   all conflicting reads drain.

   This ensures that new snapshot reads will be redirected to the COW
   device, instead of the origin, and thus pending_complete() will not
   starve. Moreover, we use the existence of both a completed and
   a pending exception to signify that the COW is done but there are
   conflicting reads in flight.

2. In __origin_write() we check first if there is a pending exception
   and then if there is a completed exception. If there is a pending
   exception any submitted BIO is delayed on the pe->origin_bios list and
   DM_MAPIO_SUBMITTED is returned. This ensures that neither writes to the
   origin nor snapshot merging can overwrite the origin chunk, until all
   conflicting reads drain, and thus snapshot reads will not return
   corrupted data.

Summarizing, we now have the following possible combinations of pending
and completed exceptions for a chunk, along with their meaning:

A. No exceptions exist: The chunk has not been remapped yet.
B. Only a pending exception exists: The chunk is currently being copied
   to the COW device.
C. Both a pending and a completed exception exist: COW for this chunk
   has completed but there are snapshot reads in flight which had been
   redirected to the origin before the chunk was remapped.
D. Only the completed exception exists: COW has been completed and there
   are no conflicting reads in flight.

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
---
 drivers/md/dm-snap.c | 102 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 36805b12661e..4b34bfa0900a 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1501,16 +1501,24 @@ static void pending_complete(void *context, int success)
 		goto out;
 	}
 
-	/* Check for conflicting reads */
-	__check_for_conflicting_io(s, pe->e.old_chunk);
-
 	/*
-	 * Add a proper exception, and remove the
-	 * in-flight exception from the list.
+	 * Add a proper exception. After inserting the completed exception all
+	 * subsequent snapshot reads to this chunk will be redirected to the
+	 * COW device.  This ensures that we do not starve. Moreover, as long
+	 * as the pending exception exists, neither origin writes nor snapshot
+	 * merging can overwrite the chunk in origin.
 	 */
 	dm_insert_exception(&s->complete, e);
 
+	/* Wait for conflicting reads to drain */
+	if (__chunk_is_tracked(s, pe->e.old_chunk)) {
+		mutex_unlock(&s->lock);
+		__check_for_conflicting_io(s, pe->e.old_chunk);
+		mutex_lock(&s->lock);
+	}
+
 out:
+	/* Remove the in-flight exception from the list */
 	dm_remove_exception(&pe->e);
 	snapshot_bios = bio_list_get(&pe->snapshot_bios);
 	origin_bios = bio_list_get(&pe->origin_bios);
@@ -1660,25 +1668,15 @@ __lookup_pending_exception(struct dm_snapshot *s, chunk_t chunk)
 }
 
 /*
- * Looks to see if this snapshot already has a pending exception
- * for this chunk, otherwise it allocates a new one and inserts
- * it into the pending table.
+ * Inserts a pending exception into the pending table.
  *
  * NOTE: a write lock must be held on snap->lock before calling
  * this.
  */
 static struct dm_snap_pending_exception *
-__find_pending_exception(struct dm_snapshot *s,
-			 struct dm_snap_pending_exception *pe, chunk_t chunk)
+__insert_pending_exception(struct dm_snapshot *s,
+			   struct dm_snap_pending_exception *pe, chunk_t chunk)
 {
-	struct dm_snap_pending_exception *pe2;
-
-	pe2 = __lookup_pending_exception(s, chunk);
-	if (pe2) {
-		free_pending_exception(pe);
-		return pe2;
-	}
-
 	pe->e.old_chunk = chunk;
 	bio_list_init(&pe->origin_bios);
 	bio_list_init(&pe->snapshot_bios);
@@ -1697,6 +1695,29 @@ __find_pending_exception(struct dm_snapshot *s,
 	return pe;
 }
 
+/*
+ * Looks to see if this snapshot already has a pending exception
+ * for this chunk, otherwise it allocates a new one and inserts
+ * it into the pending table.
+ *
+ * NOTE: a write lock must be held on snap->lock before calling
+ * this.
+ */
+static struct dm_snap_pending_exception *
+__find_pending_exception(struct dm_snapshot *s,
+			 struct dm_snap_pending_exception *pe, chunk_t chunk)
+{
+	struct dm_snap_pending_exception *pe2;
+
+	pe2 = __lookup_pending_exception(s, chunk);
+	if (pe2) {
+		free_pending_exception(pe);
+		return pe2;
+	}
+
+	return __insert_pending_exception(s, pe, chunk);
+}
+
 static void remap_exception(struct dm_snapshot *s, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
@@ -2107,7 +2128,7 @@ static int __origin_write(struct list_head *snapshots, sector_t sector,
 	int r = DM_MAPIO_REMAPPED;
 	struct dm_snapshot *snap;
 	struct dm_exception *e;
-	struct dm_snap_pending_exception *pe;
+	struct dm_snap_pending_exception *pe, *pe2;
 	struct dm_snap_pending_exception *pe_to_start_now = NULL;
 	struct dm_snap_pending_exception *pe_to_start_last = NULL;
 	chunk_t chunk;
@@ -2137,17 +2158,17 @@ static int __origin_write(struct list_head *snapshots, sector_t sector,
 		 */
 		chunk = sector_to_chunk(snap->store, sector);
 
-		/*
-		 * Check exception table to see if block
-		 * is already remapped in this snapshot
-		 * and trigger an exception if not.
-		 */
-		e = dm_lookup_exception(&snap->complete, chunk);
-		if (e)
-			goto next_snapshot;
-
 		pe = __lookup_pending_exception(snap, chunk);
 		if (!pe) {
+			/*
+			 * Check exception table to see if block is already
+			 * remapped in this snapshot and trigger an exception
+			 * if not.
+			 */
+			e = dm_lookup_exception(&snap->complete, chunk);
+			if (e)
+				goto next_snapshot;
+
 			mutex_unlock(&snap->lock);
 			pe = alloc_pending_exception(snap);
 			mutex_lock(&snap->lock);
@@ -2157,16 +2178,23 @@ static int __origin_write(struct list_head *snapshots, sector_t sector,
 				goto next_snapshot;
 			}
 
-			e = dm_lookup_exception(&snap->complete, chunk);
-			if (e) {
+			pe2 = __lookup_pending_exception(snap, chunk);
+
+			if (!pe2) {
+				e = dm_lookup_exception(&snap->complete, chunk);
+				if (e) {
+					free_pending_exception(pe);
+					goto next_snapshot;
+				}
+
+				pe = __insert_pending_exception(snap, pe, chunk);
+				if (!pe) {
+					__invalidate_snapshot(snap, -ENOMEM);
+					goto next_snapshot;
+				}
+			} else {
 				free_pending_exception(pe);
-				goto next_snapshot;
-			}
-
-			pe = __find_pending_exception(snap, pe, chunk);
-			if (!pe) {
-				__invalidate_snapshot(snap, -ENOMEM);
-				goto next_snapshot;
+				pe = pe2;
 			}
 		}
 
-- 
2.11.0

