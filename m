Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A33CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BF020717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211106;
	bh=o26wSbnjLMKtaA6+kb9K34eD8ZNhmHxcIMRRe4UvVKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKVk6NSIWWscAVpeT3ZadfL06+g8fZ+QpMSh5c/FoEO8rS3qy70S4ab1yv3pZBBa6
	 mV7lJrymk1WilTjG65uZoJ5WbNk80+q3Uzpdkc1vuvsbKNJiRT/I2CZSZYu/30LFQI
	 78cCDim0LU5kjj4P6bNj+NcEde1129gXAstyas3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfJ0VSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfJ0VSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:18:23 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CC020717;
        Sun, 27 Oct 2019 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211103;
        bh=o26wSbnjLMKtaA6+kb9K34eD8ZNhmHxcIMRRe4UvVKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kb8G+yzrqlxfkUvGuhS2CsPITF7Wn83fHREMvXWlNnNNlfCw3UTWEhSzc47mTi66x
         GcYyLOQJ20FnEPFUjBTRpkMq279vYjajzAUJsBkdKTZBXXlwF+iaKGFnMdJ8tGoFpg
         PgSAfhfllJS9wOjuEkNYJIfLq59PwQRpy/8EPNLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martijn Coenen <maco@android.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 032/197] loop: change queue block size to match when using DIO
Date:   Sun, 27 Oct 2019 21:59:10 +0100
Message-Id: <20191027203353.471870904@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martijn Coenen <maco@android.com>

[ Upstream commit 85560117d00f5d528e928918b8f61cadcefff98b ]

The loop driver assumes that if the passed in fd is opened with
O_DIRECT, the caller wants to use direct I/O on the loop device.
However, if the underlying block device has a different block size than
the loop block queue, direct I/O can't be enabled. Instead of requiring
userspace to manually change the blocksize and re-enable direct I/O,
just change the queue block sizes to match, as well as the io_min size.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1410fa8936538..f6f77eaa7217e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -994,6 +994,16 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+		/* In case of direct I/O, match underlying block size */
+		unsigned short bsize = bdev_logical_block_size(
+			inode->i_sb->s_bdev);
+
+		blk_queue_logical_block_size(lo->lo_queue, bsize);
+		blk_queue_physical_block_size(lo->lo_queue, bsize);
+		blk_queue_io_min(lo->lo_queue, bsize);
+	}
+
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
-- 
2.20.1



