Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F172C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717372184C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711145;
	bh=DkLn4vJ6H5LtbBn0cGvbvBez0/BUm+WsxBFs9oslgHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxThO2gx1UWKykoccs0VBmQBibE6d71MyWtTleRsk0gE0TiQ+cn4b2kzERf1mipjy
	 V0B+fYwEvwLDRKJLFApbpMOOy9mzSEe/GTGIpnaQvMHqo2a2Ts4BquMbAUbQG9IBsV
	 V6T7/uI5H1A30JQlr1c55y6yvbMJisJXkaAb1Dw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfC0SZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391626AbfC0SZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA6F2177E;
        Wed, 27 Mar 2019 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711140;
        bh=DkLn4vJ6H5LtbBn0cGvbvBez0/BUm+WsxBFs9oslgHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gI9gZ9NZ+jGVhFf5Ea8OVG2hulzxSvXKetZPYUF6JiR/O9p17Z0GQHIRl8TPi7Njn
         ElTXiGXEGO3VXTdnNzJFkIzt/kDyyCSMdc39epdHD/jbLxssEYX3Uscpex6hCtIeju
         ZnLNc9VgNCEvhZZlLIcqmUs65sLbsDATSCYBK3i0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 11/41] fs: fix guard_bio_eod to check for real EOD errors
Date:   Wed, 27 Mar 2019 14:24:48 -0400
Message-Id: <20190327182518.19394-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
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
index 20805db2c987..47b42e8ddca2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2986,6 +2986,13 @@ void guard_bio_eod(int rw, struct bio *bio)
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

