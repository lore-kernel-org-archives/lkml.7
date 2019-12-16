Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60478C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDBC2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520584;
	bh=NrWdrWtn4VJKQ0e5Ra59uuBMOs9/sQETE74QJUDxaf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lOo7h6lVq7SfzGxkQ73DRntIXH3uZsrNXYynRpJviwP9wGcsyWd823uahR/xAYh9F
	 f8Efq4GJafM5NXKzSvlJiMMe0ZDwcosKWaytaDsNTMCVC8EtuX+AOof9pELWUHTkkK
	 SmrCaOQissxPBIW2tUZmxuaLPYVzrbtU8smBWngY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfLPSUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732088AbfLPSUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:20:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905E4206EC;
        Mon, 16 Dec 2019 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520434;
        bh=NrWdrWtn4VJKQ0e5Ra59uuBMOs9/sQETE74QJUDxaf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGQ/qYAegpZO5QCGfMKgN7i1kNmOyhM+ekW9bq+2B0RGgvmSSPw4i1LCcaJCyIIq5
         kfz5YqQ87lNs9x2YGNiCa/YyOpBOGJ7igNemRU6gWPzVkO+bLF/qm6FIPqAx7o6PFj
         YBb+o3KMPe+BWK3LtlAJQLf4uPTDfJePS8mG1epE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 153/177] ext4: Fix credit estimate for final inode freeing
Date:   Mon, 16 Dec 2019 18:50:09 +0100
Message-Id: <20191216174848.241985515@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 65db869c754e7c271691dd5feabf884347e694f5 upstream.

Estimate for the number of credits needed for final freeing of inode in
ext4_evict_inode() was to small. We may modify 4 blocks (inode & sb for
orphan deletion, bitmap & group descriptor for inode freeing) and not
just 3.

[ Fixed minor whitespace nit. -- TYT ]

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20191105164437.32602-6-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -196,7 +196,12 @@ void ext4_evict_inode(struct inode *inod
 {
 	handle_t *handle;
 	int err;
-	int extra_credits = 3;
+	/*
+	 * Credits for final inode cleanup and freeing:
+	 * sb + inode (ext4_orphan_del()), block bitmap, group descriptor
+	 * (xattr block freeing), bitmap, group descriptor (inode freeing)
+	 */
+	int extra_credits = 6;
 	struct ext4_xattr_inode_array *ea_inode_array = NULL;
 
 	trace_ext4_evict_inode(inode);
@@ -252,8 +257,12 @@ void ext4_evict_inode(struct inode *inod
 	if (!IS_NOQUOTA(inode))
 		extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
 
+	/*
+	 * Block bitmap, group descriptor, and inode are accounted in both
+	 * ext4_blocks_for_truncate() and extra_credits. So subtract 3.
+	 */
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE,
-				 ext4_blocks_for_truncate(inode)+extra_credits);
+			 ext4_blocks_for_truncate(inode) + extra_credits - 3);
 	if (IS_ERR(handle)) {
 		ext4_std_error(inode->i_sb, PTR_ERR(handle));
 		/*


