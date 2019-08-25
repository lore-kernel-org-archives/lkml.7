Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0599521848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="pu/b7LyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfHYHZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:25:19 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25502 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566717910; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=SJpPVL1y/fFECRiorlnRKTcsvUGgqfPM0WCrlkRXq8+ksnLCjUjhcIUt5HbILFyAwN83keYNb1iiCZPha5JSnCw777qcvl0QGgkKThpwDmVYpZhQvTljG69SAy5OVPLKDPN8eO9KTK7SrPtB4VBKdknWrMNvTuMlxav37Bb1KgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566717910; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=JbPeKwL0y9K5o8QvWTYI+guOBqyfTVLeLMRqF8VDqWc=; 
        b=bEMCgOUh1pBeKMb/u7u3grM3ujaZVzGTOPRRROtLXOs3C3/3x7mZdsFrbsIq2pGe74AtMToDOtvkZuomTBAhmPmKfyWGqBWVcWtiwcn2hXIRFUzPEa2aJA681FW6sXyAzmOXXM6jmWXvqeHo7Z3cGHAzMDlRGQEqXVYPn84DaNI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=i7y2aEyOHh/la9dU3CPx42PbzlTdsTP9AIatWSaev26MhvxazXL9kgiLtuYSGKE0vaAVtr7CacPu
    UxeGSKrTnyEcL66hHrbYbIu4R8iV5qlMuOhCWOOUWmaib0WCiuuq  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566717910;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=3969; bh=JbPeKwL0y9K5o8QvWTYI+guOBqyfTVLeLMRqF8VDqWc=;
        b=pu/b7LyNmYvufL43cLjOm9uc6q7eI2PfNoaarhXUjd/qlCh2Hi2xduAPONT5OyO7
        rofiHB/FJvRmrIOJRH42WcnkP/TxtGQNeZNa4V/HbXxJi0nrMlKVBvj+1YqyZRu/bej
        1qq2aaLi8arB2HnAeusARLo0U0rhRbhoqewsZhnU=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.58.107 [123.120.58.107]) by mx.zohomail.com
        with SMTPS id 15667179088951020.9475134769934; Sun, 25 Aug 2019 00:25:08 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 3/3] dm writecache: optimize performance by sorting the blocks for writeback_all
Date:   Sun, 25 Aug 2019 15:24:33 +0800
Message-Id: <20190825072433.2628-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190825072433.2628-1-yehs2007@zoho.com>
References: <20190825072433.2628-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

During the process of writeback, the blocks, which have been placed in wbl.list
for writeback soon, are partially ordered for the contiguous ones.

When writeback_all has been set, for most cases, also by default, there will be
a lot of blocks in pmem need to writeback at the same time.
For this case, we could optimize the performance by sorting all blocks in
wbl.list. writecache_writeback doesn't need to get blocks from the tail of
wc->lru, whereas from the first rb_node from the rb_tree.

The benefit is that, writecache_writeback doesn't need to have any cost to sort
the blocks, because of all blocks are incremental originally in rb_tree.
There will be a writecache_flush when writeback_all begins to work, that will
eliminate duplicate blocks in cache by committed/uncommitted.

Testing platform: Thinksystem SR630 with persistent memory.
The cache comes from pmem, which has 1006MB size. The origin device is HDD, 2GB
of which for using.

Testing steps:
 1) dmsetup create mycache --table '0 4194304 writecache p /dev/sdb1 /dev/pmem4  4096 0'
 2) fio -filename=/dev/mapper/mycache -direct=1 -iodepth=20 -rw=randwrite
 -ioengine=libaio -bs=4k -loops=1  -size=2g -group_reporting -name=mytest1
 3) time dmsetup message /dev/mapper/mycache 0 flush

Here is the results below,
With the patch:
 # fio -filename=/dev/mapper/mycache -direct=1 -iodepth=20 -rw=randwrite
 -ioengine=libaio -bs=4k -loops=1  -size=2g -group_reporting -name=mytest1
   iops        : min= 1582, max=199470, avg=5305.94, stdev=21273.44, samples=197
 # time dmsetup message /dev/mapper/mycache 0 flush
real	0m44.020s
user	0m0.002s
sys	0m0.003s

Without the patch:
 # fio -filename=/dev/mapper/mycache -direct=1 -iodepth=20 -rw=randwrite
 -ioengine=libaio -bs=4k -loops=1  -size=2g -group_reporting -name=mytest1
   iops        : min= 1202, max=197650, avg=4968.67, stdev=20480.17, samples=211
 # time dmsetup message /dev/mapper/mycache 0 flush
real	1m39.221s
user	0m0.001s
sys	0m0.003s

I also have checked the data accuracy with this patch by making EXT4 filesystem
on mycache, then mount it for checking md5 of files on that.
The test result is positive, with this patch it could save more than half of time
when writeback_all.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 3643084..c481947 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1560,7 +1560,7 @@ static void writecache_writeback(struct work_struct *work)
 {
 	struct dm_writecache *wc = container_of(work, struct dm_writecache, writeback_work);
 	struct blk_plug plug;
-	struct wc_entry *e, *f, *g;
+	struct wc_entry *f, *g, *e = NULL;
 	struct rb_node *node, *next_node;
 	struct list_head skipped;
 	struct writeback_list wbl;
@@ -1597,7 +1597,14 @@ static void writecache_writeback(struct work_struct *work)
 			break;
 		}
 
-		e = container_of(wc->lru.prev, struct wc_entry, lru);
+		if (unlikely(wc->writeback_all)) {
+			if (unlikely(!e)) {
+				writecache_flush(wc);
+				e = container_of(rb_first(&wc->tree), struct wc_entry, rb_node);
+			} else
+				e = g;
+		} else
+			e = container_of(wc->lru.prev, struct wc_entry, lru);
 		BUG_ON(e->write_in_progress);
 		if (unlikely(!writecache_entry_is_committed(wc, e))) {
 			writecache_flush(wc);
@@ -1658,8 +1665,14 @@ static void writecache_writeback(struct work_struct *work)
 			g->wc_list_contiguous = BIO_MAX_PAGES;
 			f = g;
 			e->wc_list_contiguous++;
-			if (unlikely(e->wc_list_contiguous == BIO_MAX_PAGES))
+			if (unlikely(e->wc_list_contiguous == BIO_MAX_PAGES)) {
+				if (unlikely(wc->writeback_all)) {
+					next_node = rb_next(&f->rb_node);
+					if (likely(next_node))
+						g = container_of(next_node, struct wc_entry, rb_node);
+				}
 				break;
+			}
 		}
 		cond_resched();
 	}
-- 
1.8.3.1


