Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB2C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D492085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfG0K3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:29:43 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2582 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfG0K3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:29:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d3c255ec16-4f2f5; Sat, 27 Jul 2019 18:20:14 +0800 (CST)
X-RM-TRANSID: 2ee35d3c255ec16-4f2f5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45d3c255db6c-ef1e5;
        Sat, 27 Jul 2019 18:20:14 +0800 (CST)
X-RM-TRANSID: 2ee45d3c255db6c-ef1e5
From:   Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To:     colyli@suse.de, kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        baiyaowei@cmss.chinamobile.com
Subject: [PATCH 1/3] bcache: drop obsolete comments
Date:   Sat, 27 Jul 2019 18:19:57 +0800
Message-Id: <1564222799-10603-1-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused list was killed by commit 2531d9ee61fa ("bcache: Kill unused freelist")
but left these comments, let's drop them.

This patch doesn't introduce functional change.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 drivers/md/bcache/alloc.c | 13 +++----------
 drivers/md/bcache/super.c |  3 ---
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 6f77682..c22c260 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -33,13 +33,6 @@
  * If we've got discards enabled, that happens when a bucket moves from the
  * free_inc list to the free list.
  *
- * There is another freelist, because sometimes we have buckets that we know
- * have nothing pointing into them - these we can reuse without waiting for
- * priorities to be rewritten. These come from freed btree nodes and buckets
- * that garbage collection discovered no longer had valid keys pointing into
- * them (because they were overwritten). That's the unused list - buckets on the
- * unused list move to the free list, optionally being discarded in the process.
- *
  * It's also important to ensure that gens don't wrap around - with respect to
  * either the oldest gen in the btree or the gen on disk. This is quite
  * difficult to do in practice, but we explicitly guard against it anyways - if
@@ -323,9 +316,9 @@ static int bch_allocator_thread(void *arg)
 
 	while (1) {
 		/*
-		 * First, we pull buckets off of the unused and free_inc lists,
-		 * possibly issue discards to them, then we add the bucket to
-		 * the free list:
+		 * First, we pull buckets off of the free_inc list, possibly
+		 * issue discards to them, then we add the bucket to the free
+		 * list:
 		 */
 		while (1) {
 			long bucket;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 26e374f..eba38aa 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -544,9 +544,6 @@ void bch_prio_write(struct cache *ca)
 	atomic_long_add(ca->sb.bucket_size * prio_buckets(ca),
 			&ca->meta_sectors_written);
 
-	//pr_debug("free %zu, free_inc %zu, unused %zu", fifo_used(&ca->free),
-	//	 fifo_used(&ca->free_inc), fifo_used(&ca->unused));
-
 	for (i = prio_buckets(ca) - 1; i >= 0; --i) {
 		long bucket;
 		struct prio_set *p = ca->disk_buckets;
-- 
1.8.3.1



