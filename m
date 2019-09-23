Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F71B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405953AbfIWDb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 23:31:57 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50394 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404054AbfIWDb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:31:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0Td5y2xK_1569209508;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Td5y2xK_1569209508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Sep 2019 11:31:52 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, akpm@linux-foundation.org,
        mhocko@suse.com, willy@infradead.org, chris@chris-wilson.co.uk,
        hannes@cmpxchg.org, ziqian.lzq@antfin.com, osandov@fb.com,
        ying.huang@intel.com, aryabinin@virtuozzo.com, vovoy@chromium.org,
        richard.weiyang@gmail.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, jglisse@redhat.com, b.zolnierkie@samsung.com,
        axboe@kernel.dk, dennis@kernel.org, josef@toxicpanda.com,
        tj@kernel.org, oleg@redhat.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC v3] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO issue
Date:   Mon, 23 Sep 2019 11:31:45 +0800
Message-Id: <1569209505-15801-1-git-send-email-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of this patch.  The first and second version
is in [1] and [2].
This verion is updated according to the comments from Randy Dunlap
in [3].

Currently, I use a VM that has 2 CPUs, 4G memory and 4G swap file.
I found that swap will affect the IO performance when it is running.
So I open zswap to handle it because it just use CPU cycles but not
disk IO.

It work OK but I found that zswap is slower than normal swap in this
VM.  zswap is about 300M/s and normal swap is about 500M/s. (The reason
is disk inside VM has fscache in host machine.)
So open zswap is make memory shrinker slower but good for IO performance
in this VM.
So I just want zswap work when the disk of the swap file is under high
IO load.

This commit is designed for this idea.
It add two parameters read_in_flight_limit and write_in_flight_limit to
zswap.
In zswap_frontswap_store, pages will be stored to zswap only when
the IO in flight number of swap device is bigger than
zswap_read_in_flight_limit or zswap_write_in_flight_limit
when zswap is enabled.
Then the zswap just work when the IO in flight number of swap device
is low.

[1] https://lkml.org/lkml/2019/9/11/935
[2] https://lkml.org/lkml/2019/9/20/90
[3] https://lkml.org/lkml/2019/9/20/1076

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 include/linux/swap.h |  3 +++
 mm/Kconfig           | 18 ++++++++++++++++
 mm/page_io.c         | 16 +++++++++++++++
 mm/zswap.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index de2c67a..82b621f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -389,6 +389,9 @@ extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
 extern int swap_set_page_dirty(struct page *page);
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+extern void swap_io_in_flight(struct page *page, unsigned int inflight[2]);
+#endif
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/mm/Kconfig b/mm/Kconfig
index 56cec63..387c3b5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -546,6 +546,24 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
+config ZSWAP_IO_SWITCH
+	bool "Compressed cache for swap pages according to the IO status"
+	depends on ZSWAP
+	help
+	  This function helps the system that normal swap speed is higher
+	  than zswap speed to handle the swap IO issue.
+	  For example, a VM where the disk device is not set cache config or
+	  set cache=writeback.
+
+	  This function makes zswap just work when the disk of the swap file
+	  is under high IO load.
+	  It add two parameters (read_in_flight_limit and
+	  write_in_flight_limit) to zswap.  When zswap is enabled, pages will
+	  be stored to zswap only when the IO in flight number of swap device
+	  is bigger than zswap_read_in_flight_limit or
+	  zswap_write_in_flight_limit.
+	  If unsure, say "n".
+
 config ZPOOL
 	tristate "Common API for compressed memory storage"
 	help
diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600..e66b050 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -434,3 +434,19 @@ int swap_set_page_dirty(struct page *page)
 		return __set_page_dirty_no_writeback(page);
 	}
 }
+
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+void swap_io_in_flight(struct page *page, unsigned int inflight[2])
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+
+	if (!sis->bdev) {
+		inflight[0] = 0;
+		inflight[1] = 0;
+		return;
+	}
+
+	part_in_flight_rw(bdev_get_queue(sis->bdev), sis->bdev->bd_part,
+					  inflight);
+}
+#endif
diff --git a/mm/zswap.c b/mm/zswap.c
index 0e22744..0190b2d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -62,6 +62,14 @@ static u64 zswap_reject_compress_poor;
 static u64 zswap_reject_alloc_fail;
 /* Store failed because the entry metadata could not be allocated (rare) */
 static u64 zswap_reject_kmemcache_fail;
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+/*
+ * Store failed because zswap_read_in_flight_limit or
+ * zswap_write_in_flight_limit is bigger than IO in flight number of
+ * swap device
+ */
+static u64 zswap_reject_io;
+#endif
 /* Duplicate store was encountered (rare) */
 static u64 zswap_duplicate_entry;
 
@@ -114,6 +122,24 @@ static bool zswap_same_filled_pages_enabled = true;
 module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
 		   bool, 0644);
 
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+/*
+ * zswap will not try to store the page if zswap_read_in_flight_limit is
+ * bigger than IO read in flight number of swap device
+ */
+static unsigned int zswap_read_in_flight_limit;
+module_param_named(read_in_flight_limit, zswap_read_in_flight_limit,
+		   uint, 0644);
+
+/*
+ * zswap will not try to store the page if zswap_write_in_flight_limit is
+ * bigger than IO write in flight number of swap device
+ */
+static unsigned int zswap_write_in_flight_limit;
+module_param_named(write_in_flight_limit, zswap_write_in_flight_limit,
+		   uint, 0644);
+#endif
+
 /*********************************
 * data structures
 **********************************/
@@ -1009,6 +1035,34 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+	if (zswap_read_in_flight_limit || zswap_write_in_flight_limit) {
+		unsigned int inflight[2];
+		bool should_swap = false;
+
+		swap_io_in_flight(page, inflight);
+
+		if (zswap_write_in_flight_limit &&
+			inflight[1] < zswap_write_in_flight_limit)
+			should_swap = true;
+
+		if (zswap_read_in_flight_limit &&
+			(should_swap ||
+			 (!should_swap && !zswap_write_in_flight_limit))) {
+			if (inflight[0] < zswap_read_in_flight_limit)
+				should_swap = true;
+			else
+				should_swap = false;
+		}
+
+		if (should_swap) {
+			zswap_reject_io++;
+			ret = -EIO;
+			goto reject;
+		}
+	}
+#endif
+
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
 		zswap_pool_limit_hit++;
@@ -1264,6 +1318,10 @@ static int __init zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_kmemcache_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+	debugfs_create_u64("reject_io", 0444,
+			   zswap_debugfs_root, &zswap_reject_io);
+#endif
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
 	debugfs_create_u64("duplicate_entry", 0444,
-- 
2.7.4

