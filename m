Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9566C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B913C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370252;
	bh=F3/fTFECdWSUpLHBhH99MC/R4nGnko2CDEIVbz5aLPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RqYiHAHAxlMp9LrwiwBhZy8bVZJbblyljlHrLf0mlHSWNY3KSCsOp7Ld6JS6eDEBq
	 sV3Fwe+4ctiGLsvQVLnbDOtuzyKZUyNloYzz14axspOGM9Axc9n4brh7Zm9a94J7GQ
	 PEQa/kA6Pc3wUX1LeVetD0DXeYS92aap1SeRh5k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfDDJJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732877AbfDDJJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FE020652;
        Thu,  4 Apr 2019 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368985;
        bh=F3/fTFECdWSUpLHBhH99MC/R4nGnko2CDEIVbz5aLPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ba74eqmwWQzLN1d9PR0nb0db2q+QGgsooQkpr8ttCZoa1QOh8sHm1NHtPymKLD4az
         AtPrhDGjonexHQiYdISKvUKEkDGCojkFyHGipXTvcaPVyNvvY3M7dA6Yq0g1ULnFDd
         uqid8BrYZgOUwnt5DrXLBFf8wTMdifiziV6pLJ5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 055/246] fs: fix guard_bio_eod to check for real EOD errors
Date:   Thu,  4 Apr 2019 10:45:55 +0200
Message-Id: <20190404084620.942520655@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 48318fb74938..cab7a026876b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3027,6 +3027,13 @@ void guard_bio_eod(int op, struct bio *bio)
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



