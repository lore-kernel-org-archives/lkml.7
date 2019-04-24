Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EF0205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126940;
	bh=wKFla7yfuzeonqVhJY20KD/ieqPybzxw7oy6gpPOwLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G3EjsTYzxImzsNa6cPu7VkDIVkVlBj9NzV0PnswfrxCEAVFS8EWOm/06ZAM/oyzkm
	 RNUK3H5qQ1pY4jfktlkw39mwhc1VLyx5j6qOc8zy2WDHHoVPINupBHNV0kyqWHF968
	 NnMj4tQszux2tA653nNhB5KQ8tnbZv8LioREvBJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfDXR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390739AbfDXR2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:53 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9C42054F;
        Wed, 24 Apr 2019 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126932;
        bh=wKFla7yfuzeonqVhJY20KD/ieqPybzxw7oy6gpPOwLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3ZPB9rzXB1F7pOkWrzJ2g/82hJ5bV0kngSEP4+gI0InfuzTDwGbKEh2WuBQ1R9wY
         C7IHUu1fCtu18ZwbqC1xRJ1uMjqdC1L2niuEkeqOQ/0UvLugauoyzRZ5hikSk6ABk4
         EKp4uV2ExISiIniAEwylz7fGJTi1oVsW0d3wi35E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Liu Bo <bo.li.liu@oracle.com>, Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.14 67/70] iomap: report collisions between directio and buffered writes to userspace
Date:   Wed, 24 Apr 2019 19:10:27 +0200
Message-Id: <20190424170919.032089132@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 5a9d929d6e13278df62bd9e3d3ceae8c87ad1eea upstream.

If two programs simultaneously try to write to the same part of a file
via direct IO and buffered IO, there's a chance that the post-diowrite
pagecache invalidation will fail on the dirty page.  When this happens,
the dio write succeeded, which means that the page cache is no longer
coherent with the disk!

Programs are not supposed to mix IO types and this is a clear case of
data corruption, so store an EIO which will be reflected to userspace
during the next fsync.  Replace the WARN_ON with a ratelimited pr_crit
so that the developers have /some/ kind of breadcrumb to track down the
offending program(s) and file(s) involved.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zubin Mithra <zsm@chromium.org>


---
 fs/direct-io.c     |   24 +++++++++++++++++++++++-
 fs/iomap.c         |   12 ++++++++++--
 include/linux/fs.h |    1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -219,6 +219,27 @@ static inline struct page *dio_get_page(
 	return dio->pages[sdio->head];
 }
 
+/*
+ * Warn about a page cache invalidation failure during a direct io write.
+ */
+void dio_warn_stale_pagecache(struct file *filp)
+{
+	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
+	char pathname[128];
+	struct inode *inode = file_inode(filp);
+	char *path;
+
+	errseq_set(&inode->i_mapping->wb_err, -EIO);
+	if (__ratelimit(&_rs)) {
+		path = file_path(filp, pathname, sizeof(pathname));
+		if (IS_ERR(path))
+			path = "(unknown)";
+		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
+		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
+			current->comm);
+	}
+}
+
 /**
  * dio_complete() - called when all DIO BIO I/O has been completed
  * @offset: the byte offset in the file of the completed operation
@@ -290,7 +311,8 @@ static ssize_t dio_complete(struct dio *
 		err = invalidate_inode_pages2_range(dio->inode->i_mapping,
 					offset >> PAGE_SHIFT,
 					(offset + ret - 1) >> PAGE_SHIFT);
-		WARN_ON_ONCE(err);
+		if (err)
+			dio_warn_stale_pagecache(dio->iocb->ki_filp);
 	}
 
 	if (!(dio->flags & DIO_SKIP_DIO_COUNT))
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -753,7 +753,8 @@ static ssize_t iomap_dio_complete(struct
 		err = invalidate_inode_pages2_range(inode->i_mapping,
 				offset >> PAGE_SHIFT,
 				(offset + dio->size - 1) >> PAGE_SHIFT);
-		WARN_ON_ONCE(err);
+		if (err)
+			dio_warn_stale_pagecache(iocb->ki_filp);
 	}
 
 	inode_dio_end(file_inode(iocb->ki_filp));
@@ -1010,9 +1011,16 @@ iomap_dio_rw(struct kiocb *iocb, struct
 	if (ret)
 		goto out_free_dio;
 
+	/*
+	 * Try to invalidate cache pages for the range we're direct
+	 * writing.  If this invalidation fails, tough, the write will
+	 * still work, but racing two incompatible write paths is a
+	 * pretty crazy thing to do, so we don't support it 100%.
+	 */
 	ret = invalidate_inode_pages2_range(mapping,
 			start >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
 
 	if (iov_iter_rw(iter) == WRITE && !dio->wait_for_completion &&
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2965,6 +2965,7 @@ enum {
 };
 
 void dio_end_io(struct bio *bio);
+void dio_warn_stale_pagecache(struct file *filp);
 
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,


