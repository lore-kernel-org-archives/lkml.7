Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6479C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA381206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519946;
	bh=NrWdrWtn4VJKQ0e5Ra59uuBMOs9/sQETE74QJUDxaf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U3teE0su5WzJ9kd0JbG3XHX5fzV6gDjCEdlXqn8CsMXtYwMNlxECVGXkh6UzvR1Fc
	 qNdR5R0UN02HAEGsWFx10pKMTJOJXYpCfjV1Ngsf8a/ILRE6UlkeyUC34WRbPxW5rX
	 LHFbFcA9T7hICY4rThFokecBhxBRST0HDddQZurU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfLPSMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbfLPSMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:12:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8117206E0;
        Mon, 16 Dec 2019 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519942;
        bh=NrWdrWtn4VJKQ0e5Ra59uuBMOs9/sQETE74QJUDxaf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFkr3HZYK78dBD62csfuq/xQMD17PtOl95At+oUrtdtjD51ZHPxxzDA0uq9vDnXE2
         HZYSDDTWkcLaakuAvGpErpuJHHZaOVFmCRYhO8Wbtetf3JUCHdmp8DRQebERrBECYO
         ZqtT5gCfb0qFZiSTG3pdez8xMCyiMTWz2rS41q2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.3 133/180] ext4: Fix credit estimate for final inode freeing
Date:   Mon, 16 Dec 2019 18:49:33 +0100
Message-Id: <20191216174842.083844717@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
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


