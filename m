Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6250208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="eLxc4P2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfIFHpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:45:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41747 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfIFHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:45:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id z9so5415449edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zo7pH214UHwzpcJKHz+DSAZKUS6UbKLfm3ouHEw9TdY=;
        b=eLxc4P2GE5OEYYrsrSZcd7X16YU1qq8WWoRTUyYnrHQ79ArSd+KEhoY0mtL39f86Tu
         fFTIvKEk3XMAV+o7x2d/e7HmfX5PO5Dol5+343Uh4m08cmCvzWDlPvHXuwaAQMVvcOdO
         klTXJp+3I35x9Thh+9gMsuP5swWQp1WD3J3lVSXrtXDN9qf5JnuI4bjeu+vyjy11I+aB
         Lm0r2sHfuNffvOQv3dENiIUPC9g4/MArMpNJNVRHKTBIwAcN+Hv5oX8g+tpMnS5va2OV
         PMei5Jfu5ry5XHGKlSC42w/5BK61LuSnXtxgpV72kuOHL+uTF5ZjAxtXol7gTV6K4ynD
         CY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zo7pH214UHwzpcJKHz+DSAZKUS6UbKLfm3ouHEw9TdY=;
        b=AFIMZxrSPNaIzUywQuGPGH9s8ecYISVDcpuyzXEBmMX+/DzWKUmTERwOpROR7xKAas
         F/5YrSj42S/WjKvlQhvUs6+qSC4Z6bcf9fX7ZEE8hzgS/FuJ4MwKmzfEdbeboEu4pk7c
         J+UD1KTZK1+5Qpuif4FAuWWABiGG/TJKcYEJpX3N+ruu4umI7yM1N3SABoX2J9ZmVymA
         yPirRsV8DHlXCotHrtM4HP+tETx3rPGsqO+QUIaaBX5hK3KPFe/WO0TmHLRfZCXcl9Pl
         KfJIw7YuVmxLLnVOkOs6CLiowq6CHx22IG6WEwBkLS/MqgLwhtAWq2vmHNznro0eH4zd
         C5+A==
X-Gm-Message-State: APjAAAUrA6MENaTu51VcMRi4luMa7N0a35cV1jAw+8IE4a2c67zPkvtf
        uUFM9NjKxpYl8JvSkZ/rKPVnGw==
X-Google-Smtp-Source: APXvYqz5t2n0Cz3SWMqp+PJxO+EEtSxd7CrrMRDClS4OArRgLQd502XG8mJBe7tqpVJIgjUGwvRQVg==
X-Received: by 2002:a17:906:1903:: with SMTP id a3mr6146192eje.112.1567755930993;
        Fri, 06 Sep 2019 00:45:30 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id z65sm799136ede.86.2019.09.06.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 00:45:30 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@android.com, narayan@google.com, dariofreni@google.com,
        ioffe@google.com, jiyong@google.com, maco@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] dm-bufio: Allow clients to specify an upper bound on cache size.
Date:   Fri,  6 Sep 2019 09:45:26 +0200
Message-Id: <20190906074526.169194-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper limit on the cache size of a client is currently determined by
dividing the total cache size by the number of clients. However, in some
cases it is beneficial to give one client a higher limit than others; an
example is a device with many dm-verity targets, where one target has a
very large hashtree, and all the others have a small hashtree. Giving
the target with the large hashtree a higher limit will be beneficial.
Another example is dm-verity-fec: FEC is only used in (rare) error
conditions, yet for every dm-verity target with FEC, we create two FEC
dm-bufio clients, which together have a higher cache limit than the
dm-verity target itself.

This patchset allows a client to indicate a maximum cache size for its
client; if that maximum is lower than the calculated per-client limit,
that maximum will be used instead, and the freed up cache size will be
allocated to other clients (that haven't set a maximum).

Note that this algorithm is not perfect; if we have 100MB with 3
clients, where the first set a max of 1MB, the second set a max of 40MB,
and the third set no maximumm, the ideal allocation would be 1:40:59,
respectively. However, because the initial per-client limit is 100 / 3
=~33MB, the requested max of 40MB is over the per-client limit, and
instead the allocation will end up being ~ 1:40:49. This is still better
than the original 33:33:33 allocation. An iterative algorithm could do
better, but it also complicates the code significantly.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/md/dm-bufio.c    | 60 +++++++++++++++++++++++++++++++++++++---
 include/linux/dm-bufio.h |  7 +++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index b6b5acc92ca2d..d116030107c54 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -25,9 +25,20 @@
  * Memory management policy:
  *	Limit the number of buffers to DM_BUFIO_MEMORY_PERCENT of main memory
  *	or DM_BUFIO_VMALLOC_PERCENT of vmalloc memory (whichever is lower).
- *	Always allocate at least DM_BUFIO_MIN_BUFFERS buffers.
- *	Start background writeback when there are DM_BUFIO_WRITEBACK_PERCENT
- *	dirty buffers.
+ *
+ *	By default, all clients have an equal memory limit, which is the total
+ *	cache size divided by the number of clients. On devices with few
+ *	clients, this can be quite a large amount, and clients that know an
+ *	upper bound on their desired cache size can call
+ *	dm_bufio_set_maximum_buffers() to indicate this, to allow more "needy"
+ *	clients to get higher limits. In that case, if the per-client memory
+ *	limit exceeds the requested maximum, we use the requested maximum
+ *	instead, and divide the freed up space evenly with other clients that
+ *	haven't requested a maximum.
+ *
+ *	Always allocate at least DM_BUFIO_MIN_BUFFERS buffers.  Start
+ *	background writeback when there are DM_BUFIO_WRITEBACK_PERCENT dirty
+ *	buffers.
  */
 #define DM_BUFIO_MIN_BUFFERS		8
 
@@ -98,6 +109,7 @@ struct dm_bufio_client {
 	unsigned need_reserved_buffers;
 
 	unsigned minimum_buffers;
+	unsigned maximum_buffers;
 
 	struct rb_root buffer_tree;
 	wait_queue_head_t free_buffer_wait;
@@ -310,6 +322,11 @@ static void adjust_total_allocated(unsigned char data_mode, long diff)
  */
 static void __cache_size_refresh(void)
 {
+	unsigned long max_cache_size_per_client;
+	unsigned long remaining_cache_size_to_divide;
+	struct dm_bufio_client *c;
+	unsigned int num_clients_to_divide = 0;
+
 	BUG_ON(!mutex_is_locked(&dm_bufio_clients_lock));
 	BUG_ON(dm_bufio_client_count < 0);
 
@@ -324,8 +341,22 @@ static void __cache_size_refresh(void)
 		dm_bufio_cache_size_latch = dm_bufio_default_cache_size;
 	}
 
-	dm_bufio_cache_size_per_client = dm_bufio_cache_size_latch /
+	remaining_cache_size_to_divide = dm_bufio_cache_size_latch;
+	max_cache_size_per_client = dm_bufio_cache_size_latch /
 					 (dm_bufio_client_count ? : 1);
+
+	list_for_each_entry(c, &dm_bufio_all_clients, client_list) {
+		unsigned long max = (unsigned long) c->maximum_buffers *
+			c->block_size;
+
+		if (max > 0 && max < max_cache_size_per_client)
+			remaining_cache_size_to_divide -= max;
+		else
+			num_clients_to_divide++;
+	}
+
+	dm_bufio_cache_size_per_client = remaining_cache_size_to_divide /
+					 (num_clients_to_divide ? : 1);
 }
 
 /*
@@ -928,6 +959,15 @@ static void __get_memory_limit(struct dm_bufio_client *c,
 	else
 		buffers /= c->block_size;
 
+	/*
+	 * Note that dm_bufio_cache_size_per_client already takes into account
+	 * clients requesting less than is available; but that means the
+	 * available cache size per client has increased, and if they were
+	 * below the per-client limit then, they will still be below the limit
+	 * now.
+	 */
+	if ((c->maximum_buffers > 0) && buffers > c->maximum_buffers)
+		buffers = c->maximum_buffers;
 	if (buffers < c->minimum_buffers)
 		buffers = c->minimum_buffers;
 
@@ -1450,6 +1490,17 @@ void dm_bufio_set_minimum_buffers(struct dm_bufio_client *c, unsigned n)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_set_minimum_buffers);
 
+void dm_bufio_set_maximum_buffers(struct dm_bufio_client *c, unsigned n)
+{
+	mutex_lock(&dm_bufio_clients_lock);
+
+	c->maximum_buffers = n;
+	__cache_size_refresh();
+
+	mutex_unlock(&dm_bufio_clients_lock);
+}
+EXPORT_SYMBOL(dm_bufio_set_maximum_buffers);
+
 unsigned dm_bufio_get_block_size(struct dm_bufio_client *c)
 {
 	return c->block_size;
@@ -1664,6 +1715,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	c->need_reserved_buffers = reserved_buffers;
 
 	dm_bufio_set_minimum_buffers(c, DM_BUFIO_MIN_BUFFERS);
+	c->maximum_buffers = 0;
 
 	init_waitqueue_head(&c->free_buffer_wait);
 	c->async_write_error = 0;
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 3c8b7d274bd9b..89f2f04c16ef2 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -136,6 +136,13 @@ void dm_bufio_forget(struct dm_bufio_client *c, sector_t block);
  */
 void dm_bufio_set_minimum_buffers(struct dm_bufio_client *c, unsigned n);
 
+/*
+ * Set the maximum number of buffers a client can hold. If called with a value
+ * of 0 (which is also the default), the maximum number of buffers is equal to
+ * the total cache size divided by the number of clients.
+ */
+void dm_bufio_set_maximum_buffers(struct dm_bufio_client *c, unsigned n);
+
 unsigned dm_bufio_get_block_size(struct dm_bufio_client *c);
 sector_t dm_bufio_get_device_size(struct dm_bufio_client *c);
 sector_t dm_bufio_get_block_number(struct dm_buffer *b);
-- 
2.23.0.162.g0b9fbb3734-goog

