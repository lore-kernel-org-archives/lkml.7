Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB779C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEDB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140229;
	bh=k/D0NZ8CY8odIaq61C1ju3e48lWYFRqeEzJ/oKsGZgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GeDrEgWRHLOp7lxabEz/p1BLhmuBshLnMPXrT54NTtEddm22BRbz93V0e2l3mdZTu
	 GaRD7H1ckkw5t/2Ip9mr3HQphEuTLYhN8rI1D5rmiaaF+iqBjDHrgMLs0PXpavl+gt
	 7vtgxJASl1D4+wcFyBQfL+ztFVdsDBCjJKhXcnII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfDARhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbfDARhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13BC2070B;
        Mon,  1 Apr 2019 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140225;
        bh=k/D0NZ8CY8odIaq61C1ju3e48lWYFRqeEzJ/oKsGZgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnCYisgCTf3adG07+nkSLencbMFelaz5y6YPy451TtGyPFeh7fq9nccCvUeLmf3Ow
         VustsiJpJOeioX5Mu3TpreP2gaWRrxLYOQAODK0xrSmv7gbDTs8Y6i93EumF7dNu3E
         aw1H5jggRWafeVnwk5NTNijyT4dgD7XgQO/Wze20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Theodore Tso <tytso@mit.edu>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, stable@kernel.org
Subject: [PATCH 3.18 03/50] ext4: fix NULL pointer dereference while journal is aborted
Date:   Mon,  1 Apr 2019 19:02:46 +0200
Message-Id: <20190401170041.553807549@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

commit fa30dde38aa8628c73a6dded7cb0bba38c27b576 upstream.

We see the following NULL pointer dereference while running xfstests
generic/475:
BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
PGD 8000000c84bad067 P4D 8000000c84bad067 PUD c84e62067 PMD 0
Oops: 0000 [#1] SMP PTI
CPU: 7 PID: 9886 Comm: fsstress Kdump: loaded Not tainted 5.0.0-rc8 #10
RIP: 0010:ext4_do_update_inode+0x4ec/0x760
...
Call Trace:
? jbd2_journal_get_write_access+0x42/0x50
? __ext4_journal_get_write_access+0x2c/0x70
? ext4_truncate+0x186/0x3f0
ext4_mark_iloc_dirty+0x61/0x80
ext4_mark_inode_dirty+0x62/0x1b0
ext4_truncate+0x186/0x3f0
? unmap_mapping_pages+0x56/0x100
ext4_setattr+0x817/0x8b0
notify_change+0x1df/0x430
do_truncate+0x5e/0x90
? generic_permission+0x12b/0x1a0

This is triggered because the NULL pointer handle->h_transaction was
dereferenced in function ext4_update_inode_fsync_trans().
I found that the h_transaction was set to NULL in jbd2__journal_restart
but failed to attached to a new transaction while the journal is aborted.

Fix this by checking the handle before updating the inode.

Fixes: b436b9bef84d ("ext4: Wait for proper transaction commit on fsync")
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_jbd2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -374,7 +374,7 @@ static inline void ext4_update_inode_fsy
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	if (ext4_handle_valid(handle)) {
+	if (ext4_handle_valid(handle) && !is_handle_aborted(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
 		if (datasync)
 			ei->i_datasync_tid = handle->h_transaction->t_tid;


