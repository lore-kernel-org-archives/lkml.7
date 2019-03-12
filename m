Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92262C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECC42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410729;
	bh=GZzUkDJHEhqkjwKctnrrftjMWzbgG35xzNM8uFndx6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxkQcfTncyFxMJqVA5Uk/yLWA3vx0JQa6Wg5UvRnpyMeZwqF5lPrkGTGh1WMyPY2W
	 B+2t4XdaD8ZoIgk1AWssqs0ztNTWfIpK9iRA5ftLUMFjYZyvk6Y13Jo9YgiUqu+smv
	 R36zTiGt1TbCAZ+ew/YT128ynVS0G3g4OS7h+JPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfCLRMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfCLRLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:55 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35F7214AF;
        Tue, 12 Mar 2019 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410714;
        bh=GZzUkDJHEhqkjwKctnrrftjMWzbgG35xzNM8uFndx6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tONQavGcNCj+DJtpNH76i69RMnlJ+JTtjuFh4+INf/NJJ2IotHYf7busnIq0L423C
         a38f96JZXTQO1FCES3H/oGMvL6xDU2QvFD7CpqNHULiCx53fixwVsV6puVgmMLTO9a
         pD3aZG+bbP5pzJNKERSp3bwo5i8Of4d6gkSLKdGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chandan Rajendra <chandan@linux.ibm.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 029/171] iomap: fix a use after free in iomap_dio_rw
Date:   Tue, 12 Mar 2019 10:06:49 -0700
Message-Id: <20190312170350.500092622@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4ea899ead2786a30aaa8181fefa81a3df4ad28f6 ]

Introduce a local wait_for_completion variable to avoid an access to the
potentially freed dio struture after dropping the last reference count.

Also use the chance to document the completion behavior to make the
refcounting clear to the reader of the code.

Fixes: ff6a9292e6 ("iomap: implement direct I/O")
Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Chandan Rajendra <chandan@linux.ibm.com>
Tested-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 7793e9e42ad5..83d9a196fe3e 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1806,6 +1806,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos, start = pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
+	bool wait_for_completion = is_sync_kiocb(iocb);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
@@ -1825,7 +1826,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->end_io = end_io;
 	dio->error = 0;
 	dio->flags = 0;
-	dio->wait_for_completion = is_sync_kiocb(iocb);
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
@@ -1880,7 +1880,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
 
-	if (iov_iter_rw(iter) == WRITE && !dio->wait_for_completion &&
+	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
@@ -1896,7 +1896,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
-				dio->wait_for_completion = true;
+				wait_for_completion = true;
 				ret = 0;
 			}
 			break;
@@ -1918,8 +1918,24 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
+	/*
+	 * We are about to drop our additional submission reference, which
+	 * might be the last reference to the dio.  There are three three
+	 * different ways we can progress here:
+	 *
+	 *  (a) If this is the last reference we will always complete and free
+	 *	the dio ourselves.
+	 *  (b) If this is not the last reference, and we serve an asynchronous
+	 *	iocb, we must never touch the dio after the decrement, the
+	 *	I/O completion handler will complete and free it.
+	 *  (c) If this is not the last reference, but we serve a synchronous
+	 *	iocb, the I/O completion handler will wake us up on the drop
+	 *	of the final reference, and we will complete and free it here
+	 *	after we got woken by the I/O completion handler.
+	 */
+	dio->wait_for_completion = wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!dio->wait_for_completion)
+		if (!wait_for_completion)
 			return -EIOCBQUEUED;
 
 		for (;;) {
@@ -1936,9 +1952,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		__set_current_state(TASK_RUNNING);
 	}
 
-	ret = iomap_dio_complete(dio);
-
-	return ret;
+	return iomap_dio_complete(dio);
 
 out_free_dio:
 	kfree(dio);
-- 
2.19.1



