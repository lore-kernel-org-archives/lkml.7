Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712780;
	bh=yChwtWAW1xGyqZqsyQ5Exdv9dH+3dE1pv+0qtoBA+gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTiYRuDp7dT+MVi3BTOmLsB/NI9CKaZa4+tNOkFd2qXqx2Xl8xyhW8lLIU4C/KgJX
	 cUc6N+wfxedCt7goNgo2wTbqO/cYQETNSTU23ysUgPiOwXzd4cy1BtP3fdcstp8vAW
	 Q01O6fMrQGBmUo2Ue5bjficcI5jUbtxDk/a8C5c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfC0SR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390284AbfC0SRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 866CA20449;
        Wed, 27 Mar 2019 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710644;
        bh=yChwtWAW1xGyqZqsyQ5Exdv9dH+3dE1pv+0qtoBA+gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQiWMfFT32U/nzixAsJNwSbyKTXzME/ocRHlCLIgFApel8zsfwSIHtKItesq6f+FF
         c5isY6n0mHUf4AkjMp/Zui6D8M1i2JAVn2PGNpIdXOBQb3kLmVlPnCJakqkHV6DVHC
         Bn5snNKUYSnLst4mP54YzikBu6aW8V4gmYEJZz1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 030/123] fs: fix guard_bio_eod to check for real EOD errors
Date:   Wed, 27 Mar 2019 14:14:54 -0400
Message-Id: <20190327181628.15899-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Maiolino <cmaiolino@redhat.com>

[ Upstream commit dce30ca9e3b676fb288c33c1f4725a0621361185 ]

guard_bio_eod() can truncate a segment in bio to allow it to do IO on
odd last sectors of a device.

It already checks if the IO starts past EOD, but it does not consider
the possibility of an IO request starting within device boundaries can
contain more than one segment past EOD.

In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
underflow bvec->bv_len.

Fix this by checking if truncated_bytes is lower than PAGE_SIZE.

This situation has been found on filesystems such as isofs and vfat,
which doesn't check the device size before mount, if the device is
smaller than the filesystem itself, a readahead on such filesystem,
which spans EOD, can trigger this situation, leading a call to
zero_user() with a wrong size possibly corrupting memory.

I didn't see any crash, or didn't let the system run long enough to
check if memory corruption will be hit somewhere, but adding
instrumentation to guard_bio_end() to check truncated_bytes size, was
enough to see the error.

The following script can trigger the error.

MNT=/mnt
IMG=./DISK.img
DEV=/dev/loop0

mkfs.vfat $IMG
mount $IMG $MNT
cp -R /etc $MNT &> /dev/null
umount $MNT

losetup -D

losetup --find --show --sizelimit 16247280 $IMG
mount $DEV $MNT

find $MNT -type f -exec cat {} + >/dev/null

Kudos to Eric Sandeen for coming up with the reproducer above

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8086cc8ff0bc..bdca7b10e239 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3084,6 +3084,13 @@ void guard_bio_eod(int op, struct bio *bio)
 	/* Uhhuh. We've got a bio that straddles the device size! */
 	truncated_bytes = bio->bi_iter.bi_size - (maxsector << 9);
 
+	/*
+	 * The bio contains more than one segment which spans EOD, just return
+	 * and let IO layer turn it into an EIO
+	 */
+	if (truncated_bytes > bvec->bv_len)
+		return;
+
 	/* Truncate the bio.. */
 	bio->bi_iter.bi_size -= truncated_bytes;
 	bvec->bv_len -= truncated_bytes;
-- 
2.19.1

