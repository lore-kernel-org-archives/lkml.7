Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="R7IychEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCKQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:55:24 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:33877 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbfCKQzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:55:24 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id C3BA340BE71;
        Mon, 11 Mar 2019 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1552323323;
        bh=DHH5awB9zq/a7XOQJV5bZGpNQON+S7ff3QxSGApIlsI=;
        h=Date:To:Subject:From;
        b=R7IychEJ3PErsyDffX0liCOhGL3Kmfn7iqHyrnTnaVkt1lHdQ7k6oUK/ouQC8Mgf5
         DeHlckMZpB8kVlVPxd3HotKtqZGArw+D8ek665lsgTnSVmGKb87ZKe5yT54xirv0JG
         cYAcVhIwmVLgXqlH5j2pBvVJcaJeuge+hVfFvSqbsecet3rPfyURUAnOT5rMl2DBVU
         4khbgKpD9BsDjL3mDEltTzm3v0PM1LNnsU57+vQZ0XN2WRKOajMD1m5PKj/tCGaJ7a
         mdfi7XG8pDq+kZAz632u0ONXYDxsCjIIrTbW4nlGQgxg8aozFaT0+VmbH++KPrNd/r
         GBjl2MDyV/CAA==
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id C1A3140AC4F;
        Mon, 11 Mar 2019 09:55:23 -0700 (PDT)
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id AF79895C0449; Mon, 11 Mar 2019 09:55:23 -0700 (PDT)
Date:   Mon, 11 Mar 2019 09:55:23 -0700
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, dima@arista.com, fruggeri@arista.com
Subject: [PATCH resend] block: fix inconsistent page index
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20190311165523.AF79895C0449@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__find_get_block_slow() and grow_buffers() use different methods to compute
a page index for a given block: __find_get_block_slow() computes it from
bd_inode->i_blkbits, while grow_buffers() computes it from the block size
argument.
The two can get out of sync, for example if bd_inode->i_blkbits is modified
while a isofs_fill_super() (in mount) is between sb_min_blocksize() and
sb_read/__bread_gfp/__getblk_gfp/__getblk_slow.
When this happens this can result in an infinite loop in __getblk_slow(),
as grow_buffers() allocates a page but __find_get_block() keeps looking
for a different one.
I can often, but not consistently, reproduce this scenario with the
script below.
This patch changes __find_get_block_slow() to also use the block size.
It implicitly relies on size being a power of 2 in the 256..PAGE_SIZE
range.

FILE=/tmp/fsfile
MNT=/tmp/fsmnt
LOOP=`losetup -f`

rm -rf $FILE $MNT

mkdir $MNT
dd if=/dev/zero of=$FILE count=32 bs=1MiB
losetup $LOOP $FILE
mkfs -t ext4 $LOOP
while true; do losetup -D $LOOP; losetup $LOOP $FILE;done 2>&1 >/dev/null &
for ((i=0; i<100; i++)); do echo ================== $i; \
                            mount $LOOP $MNT; umount $MNT; done

Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 fs/buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 48318fb74938..447e8db2ff5f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -190,7 +190,8 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * succeeds, there is no need to take private_lock.
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct block_device *bdev, sector_t block,
+		      unsigned int size)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -202,7 +203,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
-	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	index = block >> (PAGE_SHIFT - blksize_bits(size));
 	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
 	if (!page)
 		goto out;
@@ -1292,7 +1293,7 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev, block, size);
 		if (bh)
 			bh_lru_install(bh);
 	} else
-- 
2.19.1

