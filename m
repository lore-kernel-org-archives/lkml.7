Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7733C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88803204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254993;
	bh=IdoQC2Ipy/CQOOVGVdEaPgdqbEpTXQ8MIxa1BCYlCRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZL+35O7B1lbudtSJbce3jJEAoNOBJVdVMapZOmCzI3FRLCEtahnvLxOnrlrkJDO58
	 eosqhpGyFl57X/fEbAXLy/uSSdj+FeNTl034NCuwKg/iAjQYPHcD9vhZUgQ/A6SyQ/
	 sf7GW3fX6WOrOvYAKw+rwZL4WextZHou2gH01nRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfCVLnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbfCVLnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE18C204FD;
        Fri, 22 Mar 2019 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254990;
        bh=IdoQC2Ipy/CQOOVGVdEaPgdqbEpTXQ8MIxa1BCYlCRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a21DhqzEQsqkwBnjlPa5mmqlaaAYXi91Z74wktIhGBG4Dzcb9nqxixkGcJIKMp6xH
         ys+1baBDYxubQcuntCKUYEjSZ0QCAypSnGrwH3WbFf9OzW/hUWRN/zlCRcP2bO4K0n
         Hr++T77IVytWUPE2+cTzsiEABdPsRSurTPDtDt08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 073/118] ext2: Fix underflow in ext2_max_size()
Date:   Fri, 22 Mar 2019 12:15:45 +0100
Message-Id: <20190322111221.802003683@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 1c2d14212b15a60300a2d4f6364753e87394c521 upstream.

When ext2 filesystem is created with 64k block size, ext2_max_size()
will return value less than 0. Also, we cannot write any file in this fs
since the sb->maxbytes is less than 0. The core of the problem is that
the size of block index tree for such large block size is more than
i_blocks can carry. So fix the computation to count with this
possibility.

File size limits computed with the new function for the full range of
possible block sizes look like:

bits file_size
10     17247252480
11    275415851008
12   2196873666560
13   2197948973056
14   2198486220800
15   2198754754560
16   2198888906752

CC: stable@vger.kernel.org
Reported-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/super.c |   41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -724,7 +724,8 @@ static loff_t ext2_max_size(int bits)
 {
 	loff_t res = EXT2_NDIR_BLOCKS;
 	int meta_blocks;
-	loff_t upper_limit;
+	unsigned int upper_limit;
+	unsigned int ppb = 1 << (bits-2);
 
 	/* This is calculated to be the largest file size for a
 	 * dense, file such that the total number of
@@ -738,24 +739,34 @@ static loff_t ext2_max_size(int bits)
 	/* total blocks in file system block size */
 	upper_limit >>= (bits - 9);
 
-
-	/* indirect blocks */
-	meta_blocks = 1;
-	/* double indirect blocks */
-	meta_blocks += 1 + (1LL << (bits-2));
-	/* tripple indirect blocks */
-	meta_blocks += 1 + (1LL << (bits-2)) + (1LL << (2*(bits-2)));
-
-	upper_limit -= meta_blocks;
-	upper_limit <<= bits;
-
+	/* Compute how many blocks we can address by block tree */
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
+	/* Does block tree limit file size? */
+	if (res < upper_limit)
+		goto check_lfs;
+
+	res = upper_limit;
+	/* How many metadata blocks are needed for addressing upper_limit? */
+	upper_limit -= EXT2_NDIR_BLOCKS;
+	/* indirect blocks */
+	meta_blocks = 1;
+	upper_limit -= ppb;
+	/* double indirect blocks */
+	if (upper_limit < ppb * ppb) {
+		meta_blocks += 1 + DIV_ROUND_UP(upper_limit, ppb);
+		res -= meta_blocks;
+		goto check_lfs;
+	}
+	meta_blocks += 1 + ppb;
+	upper_limit -= ppb * ppb;
+	/* tripple indirect blocks for the rest */
+	meta_blocks += 1 + DIV_ROUND_UP(upper_limit, ppb) +
+		DIV_ROUND_UP(upper_limit, ppb*ppb);
+	res -= meta_blocks;
+check_lfs:
 	res <<= bits;
-	if (res > upper_limit)
-		res = upper_limit;
-
 	if (res > MAX_LFS_FILESIZE)
 		res = MAX_LFS_FILESIZE;
 


