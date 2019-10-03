Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B0ECE58B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA8F20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122415;
	bh=RjH1GojXECxYBr6Mhu/WbuUw97Gtq5ZyNwyCJA+UG+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e3FhLk//WF6xPaJNfrcJaUKbEpX3P4atlrVkjuN4zPz5OKS9fEeQwqkov/lJr+GZv
	 DNFJRns7wx6WFN3bIAPjm0fo+6bFZ2qvbSjrXLuJ3lAUE8XP4CE9ai9qeCnXk0nORC
	 wRE+2u9bYhfo2yMoR3ZWcaeVTvBzYrKztFfq8epI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbfJCQhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404537AbfJCQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:37:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7556F215EA;
        Thu,  3 Oct 2019 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120643;
        bh=RjH1GojXECxYBr6Mhu/WbuUw97Gtq5ZyNwyCJA+UG+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljnnjxNTccTDa+4geN/WLBdrp3eZpck7e/Z/T435PTX0+PtrCURsAhXMUgLiShAOe
         gfmtp6Gto67vzRmHAulF9dpTu570Hg0+o3VvOrpSt9HEYe+C9CynSK4vPNM5oF0lat
         jqlYgGV3TXY3L4+kvgwwJjNw8gN0R+lu/Gq7B5YI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5.2 299/313] xfs: Fix stale data exposure when readahead races with hole punch
Date:   Thu,  3 Oct 2019 17:54:37 +0200
Message-Id: <20191003154602.612663707@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 40144e49ff84c3bd6bd091b58115257670be8803 upstream.

Hole puching currently evicts pages from page cache and then goes on to
remove blocks from the inode. This happens under both XFS_IOLOCK_EXCL
and XFS_MMAPLOCK_EXCL which provides appropriate serialization with
racing reads or page faults. However there is currently nothing that
prevents readahead triggered by fadvise() or madvise() from racing with
the hole punch and instantiating page cache page after hole punching has
evicted page cache in xfs_flush_unmap_range() but before it has removed
blocks from the inode. This page cache page will be mapping soon to be
freed block and that can lead to returning stale data to userspace or
even filesystem corruption.

Fix the problem by protecting handling of readahead requests by
XFS_IOLOCK_SHARED similarly as we protect reads.

CC: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_file.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -33,6 +33,7 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/mman.h>
+#include <linux/fadvise.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -939,6 +940,30 @@ out_unlock:
 	return error;
 }
 
+STATIC int
+xfs_file_fadvise(
+	struct file	*file,
+	loff_t		start,
+	loff_t		end,
+	int		advice)
+{
+	struct xfs_inode *ip = XFS_I(file_inode(file));
+	int ret;
+	int lockflags = 0;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (advice == POSIX_FADV_WILLNEED) {
+		lockflags = XFS_IOLOCK_SHARED;
+		xfs_ilock(ip, lockflags);
+	}
+	ret = generic_fadvise(file, start, end, advice);
+	if (lockflags)
+		xfs_iunlock(ip, lockflags);
+	return ret;
+}
 
 STATIC loff_t
 xfs_file_remap_range(
@@ -1235,6 +1260,7 @@ const struct file_operations xfs_file_op
 	.fsync		= xfs_file_fsync,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.fallocate	= xfs_file_fallocate,
+	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
 };
 


