Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E912082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257028;
	bh=GZQu+Z2dnPTRpW/0oKNzO0GGhIthDukXIWnhsxZmIFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tOpJLnsqR7orVK3uTI94R0IgRLWYe60/z2grcde94LN+H1WStTXFIDxksHCKkct/o
	 qaKEu0SmOSJ3JAyKKmYpcNUwE5UskfZY8oJ/uavuttVvTrdZLDBtxihsZGb9rogeCc
	 MhwqYyuOxTFSIjSCW8WlRpggMxO/pwKhlM5+3J4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbfCVMRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390309AbfCVMRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FF12082C;
        Fri, 22 Mar 2019 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257023;
        bh=GZQu+Z2dnPTRpW/0oKNzO0GGhIthDukXIWnhsxZmIFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhNBrFgRcvcyRUaZQgKVArCk5Xbnj97kyg5aRY2Q7KKX8qdESE/935bfd7wglaBbB
         2+p0eC4nQD73t8CWDZTFejDKkfj32O1WDY7cLmn3blhOBKQvhHPuJxqj3Ni2Fp6EAj
         LuUU2mQd0iZW254gUg5st5SYRq/u3QimRpJ8gOjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.0 108/238] ext4: cleanup pagecache before swap i_data
Date:   Fri, 22 Mar 2019 12:15:27 +0100
Message-Id: <20190322111304.900240883@linuxfoundation.org>
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

From: yangerkun <yangerkun@huawei.com>

commit a46c68a318b08f819047843abf349aeee5d10ac2 upstream.

While do swap, we should make sure there has no new dirty page since we
should swap i_data between two inode:
1.We should lock i_mmap_sem with write to avoid new pagecache from mmap
read/write;
2.Change filemap_flush to filemap_write_and_wait and move them to the
space protected by inode lock to avoid new pagecache from buffer read/write.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -121,9 +121,6 @@ static long swap_inode_boot_loader(struc
 		return PTR_ERR(inode_bl);
 	ei_bl = EXT4_I(inode_bl);
 
-	filemap_flush(inode->i_mapping);
-	filemap_flush(inode_bl->i_mapping);
-
 	/* Protect orig inodes against a truncate and make sure,
 	 * that only 1 swap_inode_boot_loader is running. */
 	lock_two_nondirectories(inode, inode_bl);
@@ -141,6 +138,15 @@ static long swap_inode_boot_loader(struc
 		goto journal_err_out;
 	}
 
+	down_write(&EXT4_I(inode)->i_mmap_sem);
+	err = filemap_write_and_wait(inode->i_mapping);
+	if (err)
+		goto err_out;
+
+	err = filemap_write_and_wait(inode_bl->i_mapping);
+	if (err)
+		goto err_out;
+
 	/* Wait for all existing dio workers */
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);
@@ -151,7 +157,7 @@ static long swap_inode_boot_loader(struc
 	handle = ext4_journal_start(inode_bl, EXT4_HT_MOVE_EXTENTS, 2);
 	if (IS_ERR(handle)) {
 		err = -EINVAL;
-		goto journal_err_out;
+		goto err_out;
 	}
 
 	/* Protect extent tree against block allocations via delalloc */
@@ -208,6 +214,8 @@ static long swap_inode_boot_loader(struc
 	ext4_journal_stop(handle);
 	ext4_double_up_write_data_sem(inode, inode_bl);
 
+err_out:
+	up_write(&EXT4_I(inode)->i_mmap_sem);
 journal_err_out:
 	unlock_two_nondirectories(inode, inode_bl);
 	iput(inode_bl);


