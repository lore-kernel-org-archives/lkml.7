Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DDC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1C5217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005118;
	bh=QVQNXYhm774xEJ0esdujKP+OZHgv/yx5eUykMewmE/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYTmqieT73SP2B8M5gz46SNLXtwXsme+hPmYWfrVQErpdQH9K/1sftbVDGR/wrI/N
	 4EQ12EKPIwzNyhhpDuhadFVwvUNP9OM1Xe+NLdhAMH2LMl5oM0iY4UgdDkCc0nxoxC
	 oXso4a7i4z69REUpllSAD2y7GTROD73+L3I1duKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgABWpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbgABWcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:32:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59307222C3;
        Thu,  2 Jan 2020 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004344;
        bh=QVQNXYhm774xEJ0esdujKP+OZHgv/yx5eUykMewmE/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XD4QRki4isF9c9yxpr/3VIg1wWtQlzRggTGA2MaxEAAUT2B+PYSc0Ym2d06xecokS
         Kj5RFGTuLjCxe4cLQuxqEOaendq2tJGDaqx2IfQ/5kDW2O3HQY8ubj8G/mrCIMDPKb
         jTb3K6Nsk6EAmgM+R9axrlOE7BtoioIpEDNwjB6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 140/171] ext4: work around deleting a file with i_nlink == 0 safely
Date:   Thu,  2 Jan 2020 23:07:51 +0100
Message-Id: <20200102220606.559791102@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit c7df4a1ecb8579838ec8c56b2bb6a6716e974f37 ]

If the file system is corrupted such that a file's i_links_count is
too small, then it's possible that when unlinking that file, i_nlink
will already be zero.  Previously we were working around this kind of
corruption by forcing i_nlink to one; but we were doing this before
trying to delete the directory entry --- and if the file system is
corrupted enough that ext4_delete_entry() fails, then we exit with
i_nlink elevated, and this causes the orphan inode list handling to be
FUBAR'ed, such that when we unmount the file system, the orphan inode
list can get corrupted.

A better way to fix this is to simply skip trying to call drop_nlink()
if i_nlink is already zero, thus moving the check to the place where
it makes the most sense.

https://bugzilla.kernel.org/show_bug.cgi?id=205433

Link: https://lore.kernel.org/r/20191112032903.8828-1-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6608cc01a3db..f0ce535d514c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3082,18 +3082,17 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	if (inode->i_nlink == 0) {
-		ext4_warning_inode(inode, "Deleting file '%.*s' with no links",
-				   dentry->d_name.len, dentry->d_name.name);
-		set_nlink(inode, 1);
-	}
 	retval = ext4_delete_entry(handle, dir, de, bh);
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = ext4_current_time(dir);
 	ext4_update_dx_flag(dir);
 	ext4_mark_inode_dirty(handle, dir);
-	drop_nlink(inode);
+	if (inode->i_nlink == 0)
+		ext4_warning_inode(inode, "Deleting file '%.*s' with no links",
+				   dentry->d_name.len, dentry->d_name.name);
+	else
+		drop_nlink(inode);
 	if (!inode->i_nlink)
 		ext4_orphan_add(handle, inode);
 	inode->i_ctime = ext4_current_time(inode);
-- 
2.20.1



