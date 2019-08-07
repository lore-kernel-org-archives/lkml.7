Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ABC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFC921E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfHGKiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:38:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfHGKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:38:11 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hvJKa-0004A4-Tu
        for linux-kernel@vger.kernel.org; Wed, 07 Aug 2019 10:38:08 +0000
Received: by mail-wr1-f71.google.com with SMTP id r4so43643536wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 03:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1MaOoUz8Sub6S7B/2Xxx9w+89AfQ8vLonl+LvRHaxBI=;
        b=aKwDNCADldZhNF57s84QV1mIX+QpYn1O73V+sCVV5HtqwWk/fq2zmK6GjMXfw0EU2J
         NoJa8XNsuHR7vtfDfTQ6mO0AzvfHcELFBHnctjgex/cJvlPpE7/RnciC5DWI+dZkLFis
         M15NIVfE6112CMG0Aqp6Fnum1iJYC74OtTUvBRDrJz2fytOvVYI0IArHo0LErDJi/mCk
         pH3TN5zYThw2oN5ka8FPJbqFazZ75V/LAwKmyqDfHKOaFlOvLcwt7pvs6roUlw+6r85E
         sX8viJjQhBcWLsXiKArC9EYF0rvP86NuQQRYebtJhJv9yYDjoH+NwAbVv9S0aXduPPiC
         ElWg==
X-Gm-Message-State: APjAAAVmoFt57Aa/LYLXFhHE23tz1aiKxIhlsCPZHy5koQ9FPd4PjLRO
        ep1KJv5Q+yZ2kfSZJhfZ64ylBQVcSsDC1ClCEcnhcIIZviH4nBYqjP7ReLXBc2f23E3q1Dhvm1p
        jay1XHcC1Lg+27EenQSZ6UocM2EkCn8POZkKeXLKFZQ==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr10029122wrn.165.1565174288531;
        Wed, 07 Aug 2019 03:38:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMF/DriUFLo7x8tb7XrdEd7oNUhGRQE1SAtC4vzBqttGSCiO3sAs0oK+5V9WeLbXcQE0gclw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr10029082wrn.165.1565174288162;
        Wed, 07 Aug 2019 03:38:08 -0700 (PDT)
Received: from localhost (host21-131-dynamic.46-79-r.retail.telecomitalia.it. [79.46.131.21])
        by smtp.gmail.com with ESMTPSA id p18sm95807574wrm.16.2019.08.07.03.38.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:38:07 -0700 (PDT)
Date:   Wed, 7 Aug 2019 12:38:06 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] bcache: fix deadlock in bcache_allocator
Message-ID: <20190807103806.GA15450@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcache_allocator can call the following:

 bch_allocator_thread()
  -> bch_prio_write()
     -> bch_bucket_alloc()
        -> wait on &ca->set->bucket_wait

But the wake up event on bucket_wait is supposed to come from
bch_allocator_thread() itself => deadlock:

[ 1158.490744] INFO: task bcache_allocato:15861 blocked for more than 10 seconds.
[ 1158.495929]       Not tainted 5.3.0-050300rc3-generic #201908042232
[ 1158.500653] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1158.504413] bcache_allocato D    0 15861      2 0x80004000
[ 1158.504419] Call Trace:
[ 1158.504429]  __schedule+0x2a8/0x670
[ 1158.504432]  schedule+0x2d/0x90
[ 1158.504448]  bch_bucket_alloc+0xe5/0x370 [bcache]
[ 1158.504453]  ? wait_woken+0x80/0x80
[ 1158.504466]  bch_prio_write+0x1dc/0x390 [bcache]
[ 1158.504476]  bch_allocator_thread+0x233/0x490 [bcache]
[ 1158.504491]  kthread+0x121/0x140
[ 1158.504503]  ? invalidate_buckets+0x890/0x890 [bcache]
[ 1158.504506]  ? kthread_park+0xb0/0xb0
[ 1158.504510]  ret_from_fork+0x35/0x40

Fix by making the call to bch_prio_write() non-blocking, so that
bch_allocator_thread() never waits on itself.

Moreover, make sure to wake up the garbage collector thread when
bch_prio_write() is failing to allocate buckets.

BugLink: https://bugs.launchpad.net/bugs/1784665
BugLink: https://bugs.launchpad.net/bugs/1796292
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
Changes in v3:
 - prevent buckets leak in bch_prio_write()

 drivers/md/bcache/alloc.c  |  5 ++++-
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/super.c  | 27 +++++++++++++++++++++------
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 6f776823b9ba..a1df0d95151c 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -377,7 +377,10 @@ static int bch_allocator_thread(void *arg)
 			if (!fifo_full(&ca->free_inc))
 				goto retry_invalidate;
 
-			bch_prio_write(ca);
+			if (bch_prio_write(ca, false) < 0) {
+				ca->invalidate_needs_gc = 1;
+				wake_up_gc(ca->set);
+			}
 		}
 	}
 out:
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 013e35a9e317..deb924e1d790 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -977,7 +977,7 @@ bool bch_cached_dev_error(struct cached_dev *dc);
 __printf(2, 3)
 bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...);
 
-void bch_prio_write(struct cache *ca);
+int bch_prio_write(struct cache *ca, bool wait);
 void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent);
 
 extern struct workqueue_struct *bcache_wq;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 20ed838e9413..bd153234290d 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -529,12 +529,29 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 	closure_sync(cl);
 }
 
-void bch_prio_write(struct cache *ca)
+int bch_prio_write(struct cache *ca, bool wait)
 {
 	int i;
 	struct bucket *b;
 	struct closure cl;
 
+	pr_debug("free_prio=%zu, free_none=%zu, free_inc=%zu",
+		 fifo_used(&ca->free[RESERVE_PRIO]),
+		 fifo_used(&ca->free[RESERVE_NONE]),
+		 fifo_used(&ca->free_inc));
+
+	/*
+	 * Pre-check if there are enough free buckets. In the non-blocking
+	 * scenario it's better to fail early rather than starting to allocate
+	 * buckets and do a cleanup later in case of failure.
+	 */
+	if (!wait) {
+		size_t avail = fifo_used(&ca->free[RESERVE_PRIO]) +
+			       fifo_used(&ca->free[RESERVE_NONE]);
+		if (prio_buckets(ca) > avail)
+			return -ENOMEM;
+	}
+
 	closure_init_stack(&cl);
 
 	lockdep_assert_held(&ca->set->bucket_lock);
@@ -544,9 +561,6 @@ void bch_prio_write(struct cache *ca)
 	atomic_long_add(ca->sb.bucket_size * prio_buckets(ca),
 			&ca->meta_sectors_written);
 
-	//pr_debug("free %zu, free_inc %zu, unused %zu", fifo_used(&ca->free),
-	//	 fifo_used(&ca->free_inc), fifo_used(&ca->unused));
-
 	for (i = prio_buckets(ca) - 1; i >= 0; --i) {
 		long bucket;
 		struct prio_set *p = ca->disk_buckets;
@@ -564,7 +578,7 @@ void bch_prio_write(struct cache *ca)
 		p->magic	= pset_magic(&ca->sb);
 		p->csum		= bch_crc64(&p->magic, bucket_bytes(ca) - 8);
 
-		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, true);
+		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, wait);
 		BUG_ON(bucket == -1);
 
 		mutex_unlock(&ca->set->bucket_lock);
@@ -593,6 +607,7 @@ void bch_prio_write(struct cache *ca)
 
 		ca->prio_last_buckets[i] = ca->prio_buckets[i];
 	}
+	return 0;
 }
 
 static void prio_read(struct cache *ca, uint64_t bucket)
@@ -1954,7 +1969,7 @@ static int run_cache_set(struct cache_set *c)
 
 		mutex_lock(&c->bucket_lock);
 		for_each_cache(ca, c, i)
-			bch_prio_write(ca);
+			bch_prio_write(ca, true);
 		mutex_unlock(&c->bucket_lock);
 
 		err = "cannot allocate new UUID bucket";
-- 
2.20.1

