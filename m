Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582187;
	bh=o65ex0aJQk5+MgzmZ2uVJYrJk3DGy1zFIQW2SrccRjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pbiNKB05im5MzRVZGaKSE24AjLtUmOMcD1hGnONXtrfU5VrLzuwR7PWYMJnI/LSrf
	 RP8lZHz+wR8Lyg8J6rRLaaNeuUE4QYw8Lh4nZ4vq3ETJsfEsddW6IU8CevAOvT18WT
	 aIQAw8ZKl23vpBDjDpEF5slratHxnt5eBjXpbe1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfCZGg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731875AbfCZGgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:23 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867352075E;
        Tue, 26 Mar 2019 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582183;
        bh=o65ex0aJQk5+MgzmZ2uVJYrJk3DGy1zFIQW2SrccRjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJbcOkCfIejV8OV4yKyGocVCyJbaG+sbPd3JcQGjv6nX3+7+G9eJHa/EtizvFG9mH
         suPJUHspFXwNOqBQBbd31jwJl8xFRy+iT9BX1mctatw0CSY7H7p3wDczBpyQKkZCdJ
         VcS8Lij7Vjv2tWDP4i0X25mwRJgftfQv3zzhpAmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Theodore Tso <tytso@mit.edu>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, stable@kernel.org
Subject: [PATCH 4.19 26/45] ext4: fix NULL pointer dereference while journal is aborted
Date:   Tue, 26 Mar 2019 15:30:09 +0900
Message-Id: <20190326042704.052635637@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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
@@ -384,7 +384,7 @@ static inline void ext4_update_inode_fsy
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	if (ext4_handle_valid(handle)) {
+	if (ext4_handle_valid(handle) && !is_handle_aborted(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
 		if (datasync)
 			ei->i_datasync_tid = handle->h_transaction->t_tid;


