Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6C320B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904116;
	bh=AyFqGUoXh6s5I7sdo/tb/0ayBl0NfBQWuYu8UjpaQ80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sBwEM6luWnpFe7Qhb1WvdhVFfFqKvq7Olzb/FIwNkqKN9/vji138wlsJGiDbY9VDB
	 VgU3gvioiHPCMSlj5+L0hh9DZ1oHdMzRWJ+0vRJyT4dGoPNBnbSPz8BQlCqWU3f/K+
	 nOcztSX/oHlElOL3biVOwCvYII458wP/TXt6vN4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfKDVsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfKDVsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:31 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A6A20B7C;
        Mon,  4 Nov 2019 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904111;
        bh=AyFqGUoXh6s5I7sdo/tb/0ayBl0NfBQWuYu8UjpaQ80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgfhaczboml1arNycT4S4rBbqx5g0sn9XFnQZNnOXatrrPqv4fHd4Am6rZkXWUufG
         GUCFULmOFNvELe+zRZqopqupRZARZQQnoYwNRazi7eRk/GtNJPdNk6bjF8P9cSwgzC
         qUKiaZS/DdgBHBfh4z54Ok7lGFYQgFiYN4orovH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 26/46] fuse: truncate pending writes on O_TRUNC
Date:   Mon,  4 Nov 2019 22:44:57 +0100
Message-Id: <20191104211859.052628308@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit e4648309b85a78f8c787457832269a8712a8673e upstream.

Make sure cached writes are not reordered around open(..., O_TRUNC), with
the obvious wrong results.

Fixes: 4d99ff8f12eb ("fuse: Turn writeback cache on")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -201,7 +201,7 @@ int fuse_open_common(struct inode *inode
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err;
-	bool lock_inode = (file->f_flags & O_TRUNC) &&
+	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
 			  fc->writeback_cache;
 
@@ -209,16 +209,20 @@ int fuse_open_common(struct inode *inode
 	if (err)
 		return err;
 
-	if (lock_inode)
+	if (is_wb_truncate) {
 		mutex_lock(&inode->i_mutex);
+		fuse_set_nowrite(inode);
+	}
 
 	err = fuse_do_open(fc, get_node_id(inode), file, isdir);
 
 	if (!err)
 		fuse_finish_open(inode, file);
 
-	if (lock_inode)
+	if (is_wb_truncate) {
+		fuse_release_nowrite(inode);
 		mutex_unlock(&inode->i_mutex);
+	}
 
 	return err;
 }


