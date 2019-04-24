Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F4EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D3A2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126205;
	bh=vEGwWl8nNlp9LNF7Sh9GcTK0qgonCqsdrzKH3eaSm58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCUG9WRa26aEHSzupQZpGQqmKh0qBYt3zlLjwT1TBQk7dkaSg3ypdQGlKl8yol96e
	 DwKWuHM5UHtuL01dA8IfAQmMJuqznM61eJM8N/2K87x8m48u2CRx2af43RNAZCSt2H
	 eWkEEIt8CDAQ2BYqiHC23UPD0PzPn/hqEjb7JyxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfDXRQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387857AbfDXRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:41 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFECE21909;
        Wed, 24 Apr 2019 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126200;
        bh=vEGwWl8nNlp9LNF7Sh9GcTK0qgonCqsdrzKH3eaSm58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9FONgzQeQQgnSlk5Bx460mYv801dzDYpo73jc8y1TUF9CANP9tec5ymyS4HbCx4f
         UqYlj+0lqNBOz7MelTVYjfD2rGzYS5KYf5QG9U6ULDzf5qD0LA+7mOj3STVmY07hqJ
         v4oJmQDMc4XI+tebcRYgwiqqhH8v32SurE7YL47s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 026/168] fs: fix guard_bio_eod to check for real EOD errors
Date:   Wed, 24 Apr 2019 19:07:50 +0200
Message-Id: <20190424170925.213505835@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 6f7d519a093b..f278e27bd8c0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2985,6 +2985,13 @@ void guard_bio_eod(int rw, struct bio *bio)
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



