Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF915C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C51A218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258473;
	bh=iDR1ryXya401T/l7BdXu4RycfpAv+Y+r4w6xp6il0uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNK2mh6DdY5Jt/ClKOO+HbcKNKMC72KI8ChOkjjB9JKDIbfR/4pTzdHu8OU+ejk5o
	 xgdsO3gHpX8Y57WKVO+9q3+kLHBt29NAl9W6ufa0VgTQwGT3y5cW8pnrVPHQDtkEfC
	 s4khkkXEHoFMad2FiKh9TJ/lDzbuYpjsRn69FsXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbfCVMlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388743AbfCVMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4425206C0;
        Fri, 22 Mar 2019 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256350;
        bh=iDR1ryXya401T/l7BdXu4RycfpAv+Y+r4w6xp6il0uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEz33a+EpqSzYSECZUaL7x2ySH9SRYJzOyZHUGUFSpd6Ot/9JR0oirJAJb9mPe7GE
         VPrO+i9y1Gn0lCRdOTS5x/B/UjcYpstc7lJtbVwfr3x0HxqBkOe9OjU8JZ0ik2ZUKP
         w7SK285psnbHH4C9elc4zhk8v+i7/U7Xa2kPHCgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 183/280] ext4: add mask of ext4 flags to swap
Date:   Fri, 22 Mar 2019 12:15:36 +0100
Message-Id: <20190322111327.161442780@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: yangerkun <yangerkun@huawei.com>

commit abdc644e8cbac2e9b19763680e5a7cf9bab2bee7 upstream.

The reason is that while swapping two inode, we swap the flags too.
Some flags such as EXT4_JOURNAL_DATA_FL can really confuse the things
since we're not resetting the address operations structure.  The
simplest way to keep things sane is to restrict the flags that can be
swapped.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h  |    3 +++
 fs/ext4/ioctl.c |    6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -435,6 +435,9 @@ struct flex_groups {
 /* Flags that are appropriate for non-directories/regular files. */
 #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
 
+/* The only flags that should be swapped */
+#define EXT4_FL_SHOULD_SWAP (EXT4_HUGE_FILE_FL | EXT4_EXTENTS_FL)
+
 /* Mask out flags that are inappropriate for the given type of inode. */
 static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
 {
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -63,6 +63,7 @@ static void swap_inode_data(struct inode
 	loff_t isize;
 	struct ext4_inode_info *ei1;
 	struct ext4_inode_info *ei2;
+	unsigned long tmp;
 
 	ei1 = EXT4_I(inode1);
 	ei2 = EXT4_I(inode2);
@@ -72,7 +73,10 @@ static void swap_inode_data(struct inode
 	swap(inode1->i_mtime, inode2->i_mtime);
 
 	memswap(ei1->i_data, ei2->i_data, sizeof(ei1->i_data));
-	swap(ei1->i_flags, ei2->i_flags);
+	tmp = ei1->i_flags & EXT4_FL_SHOULD_SWAP;
+	ei1->i_flags = (ei2->i_flags & EXT4_FL_SHOULD_SWAP) |
+		(ei1->i_flags & ~EXT4_FL_SHOULD_SWAP);
+	ei2->i_flags = tmp | (ei2->i_flags & ~EXT4_FL_SHOULD_SWAP);
 	swap(ei1->i_disksize, ei2->i_disksize);
 	ext4_es_remove_extent(inode1, 0, EXT_MAX_BLOCKS);
 	ext4_es_remove_extent(inode2, 0, EXT_MAX_BLOCKS);


