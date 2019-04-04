Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A932CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7854221741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368456;
	bh=D1PGjOf+i9TWhdrmvMFVwl4I9WyIC+/SpoGlRTUZRMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbn/wBNokONEiu3XtyFSSo3fJW+K1+7cXpt4C9jAtPsx95pY+Z5LBUS94JGZXt1+P
	 OFDBHTOiCpte7CemK9UOBp+9i2/1y4s2riBQCs7YxMMx+W1iqEarsng2JQ2Z9ExJBu
	 pGWFQqE78DUWDeqcLzFnm0YIkRKxJz4U7bj+Y1ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfDDJAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfDDJAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:00:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6035121741;
        Thu,  4 Apr 2019 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368452;
        bh=D1PGjOf+i9TWhdrmvMFVwl4I9WyIC+/SpoGlRTUZRMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAglMzlRWxCmd/9OchUvSyUlCuIcz5mQPeoHAc4ca3Z931ybPbmsGenmaEbzzo5tL
         pgSCCHVni2nXiza83352qEcOOjwcCdmsG+zgWVIR8SnhQbmffWs7iXJ+bDbmVYOjU5
         RZLdM36wTd3ygeUUyce/BkZDpul8555E2cHCZDDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/187] fs: fix guard_bio_eod to check for real EOD errors
Date:   Thu,  4 Apr 2019 10:46:22 +0200
Message-Id: <20190404084605.201569065@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index c083c4b3c1e7..a550e0d8e965 100644
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



