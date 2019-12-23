Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC4C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6BC20684
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TgNTEqb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLWBlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:41:32 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:46524 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfLWBl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577065289; x=1608601289;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wKr/9yXKpnMZ0LLL0aLH8/g6Iv24/1LIBi7EblWcw/k=;
  b=TgNTEqb2bESEInE3pkAp3EeyhCRqb39amxgaQO/0Mf5H1s14JEgLul/e
   aF1V/m4GJKEtZl3bENrNSNPY6Bf6dt7XWblQLjqxNOUg8z2rNGtgzzqBB
   h9ndaeskTSEx3uuKbUpdthxnZh/4qLVE2cesJSxFhToS6IXrFv0LHZQg/
   s=;
IronPort-SDR: n71q9NroV3bOEIgKDK8Blv+rWlMYMqLTjJCg5LMBf37eccoympL9f8TkpiAQXjKZ4t9oAtsm7/
 k5ehTZknrP8w==
X-IronPort-AV: E=Sophos;i="5.69,345,1571702400"; 
   d="scan'208";a="6656913"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Dec 2019 01:41:18 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 74829A1DF2;
        Mon, 23 Dec 2019 01:41:15 +0000 (UTC)
Received: from EX13D11UWC002.ant.amazon.com (10.43.162.174) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC002.ant.amazon.com (10.43.162.174) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:14 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Dec 2019 01:41:13 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <=linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <mst@redhat.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <ssomesh@amazon.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Date:   Mon, 23 Dec 2019 01:40:52 +0000
Message-ID: <20191223014056.17318-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow block/genhd to notify user space (via udev) about disk size changes
using a new helper disk_set_capacity(), which is a wrapper on top
of set_capacity(). disk_set_capacity() will only notify via udev if
the current capacity or the target capacity is not zero.

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 block/genhd.c         | 19 +++++++++++++++++++
 include/linux/genhd.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..94faec98607b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+void disk_set_capacity(struct gendisk *disk, sector_t size)
+{
+	sector_t capacity = get_capacity(disk);
+
+	set_capacity(disk, size);
+	if (capacity != 0 && size != 0) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+EXPORT_SYMBOL_GPL(disk_set_capacity);
+
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a927829bb73a..f1a5ddcc781d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -449,6 +449,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
+extern void disk_set_capacity(struct gendisk *disk, sector_t size);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.16.5

