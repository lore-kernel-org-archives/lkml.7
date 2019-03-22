Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7512082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256991;
	bh=P27Cx0S3UEZY+SSGVQn0Ze0F2UeM7CCb+qjgzdqGKkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJH3V+RmCHPiHiiA5+emeJsLXP0MOhmaaa3Nms0Hgnhc2jO/7TZqPKRGhsh4uMIQD
	 TeYnOLbTb7bVD3coVH/u2ciFXfZxeWHfbnGEmC2f+00KWu4xoBd2u+F0T2wcKJK2Ik
	 YnsTXHkq0Nd/38jzrPjsqKlbw0B2FLcGpvHx98K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfCVMQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390211AbfCVMQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A6A2083D;
        Fri, 22 Mar 2019 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256986;
        bh=P27Cx0S3UEZY+SSGVQn0Ze0F2UeM7CCb+qjgzdqGKkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWBzs3SM5MOBj3/dS9DaLcA3hGQ58MzUX492Vqju32Lk0ZpV1MRoLTM8wOxqYe2LG
         qUlywnc3iIbvpCukLcR1QTli0Ih9cGNW1DsMl74l6xpdy0uEIye8QkYH1r9cEk9GCi
         /c+v6SI8E2zKBmURxbkRL0W8xj1bQWcy+bjZG7nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 098/238] Btrfs: fix deadlock between clone/dedupe and rename
Date:   Fri, 22 Mar 2019 12:15:17 +0100
Message-Id: <20190322111304.345951751@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit 4ea748e1d2c9f8a27332b949e8210dbbf392987e upstream.

Reflinking (clone/dedupe) and rename are operations that operate on two
inodes and therefore need to lock them in the same order to avoid ABBA
deadlocks. It happens that Btrfs' reflink implementation always locked
them in a different order from VFS's lock_two_nondirectories() helper,
which is used by the rename code in VFS, resulting in ABBA type deadlocks.

Btrfs' locking order:

  static void btrfs_double_inode_lock(struct inode *inode1, struct inode *inode2)
  {
         if (inode1 < inode2)
                swap(inode1, inode2);

         inode_lock_nested(inode1, I_MUTEX_PARENT);
         inode_lock_nested(inode2, I_MUTEX_CHILD);
  }

VFS's locking order:

  void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
  {
        if (inode1 > inode2)
                swap(inode1, inode2);

        if (inode1 && !S_ISDIR(inode1->i_mode))
                inode_lock(inode1);
        if (inode2 && !S_ISDIR(inode2->i_mode) && inode2 != inode1)
                inode_lock_nested(inode2, I_MUTEX_NONDIR2);
}

Fix this by killing the btrfs helper function that does the double inode
locking and replace it with VFS's helper lock_two_nondirectories().

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: 416161db9b63e3 ("btrfs: offline dedupe")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3206,21 +3206,6 @@ out:
 	return ret;
 }
 
-static void btrfs_double_inode_unlock(struct inode *inode1, struct inode *inode2)
-{
-	inode_unlock(inode1);
-	inode_unlock(inode2);
-}
-
-static void btrfs_double_inode_lock(struct inode *inode1, struct inode *inode2)
-{
-	if (inode1 < inode2)
-		swap(inode1, inode2);
-
-	inode_lock_nested(inode1, I_MUTEX_PARENT);
-	inode_lock_nested(inode2, I_MUTEX_CHILD);
-}
-
 static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
 				       struct inode *inode2, u64 loff2, u64 len)
 {
@@ -3989,7 +3974,7 @@ static int btrfs_remap_file_range_prep(s
 	if (same_inode)
 		inode_lock(inode_in);
 	else
-		btrfs_double_inode_lock(inode_in, inode_out);
+		lock_two_nondirectories(inode_in, inode_out);
 
 	/*
 	 * Now that the inodes are locked, we need to start writeback ourselves
@@ -4039,7 +4024,7 @@ static int btrfs_remap_file_range_prep(s
 	if (same_inode)
 		inode_unlock(inode_in);
 	else
-		btrfs_double_inode_unlock(inode_in, inode_out);
+		unlock_two_nondirectories(inode_in, inode_out);
 
 	return ret;
 }
@@ -4069,7 +4054,7 @@ loff_t btrfs_remap_file_range(struct fil
 	if (same_inode)
 		inode_unlock(src_inode);
 	else
-		btrfs_double_inode_unlock(src_inode, dst_inode);
+		unlock_two_nondirectories(src_inode, dst_inode);
 
 	return ret < 0 ? ret : len;
 }


