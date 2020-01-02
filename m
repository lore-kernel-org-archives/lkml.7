Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6BC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D702253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004226;
	bh=p/VQ5XvFfXoxpzlYbitgprfWPKotHqsZENTAFtN7H3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZsIEHS3L5ZuuZDcsDhv5WWiquorJAd0aaCS88WH5WCcGwKHziGlQYWCBa2k7fC9FX
	 do8cKUI4Dp4ndCcUWP+ycySZxCMiih53ljz4pSbzmct8NMagFWRoVrZQ0vqzc5fEzj
	 f5z5YVy3CMy53Lhc6byF1YPKwdPDcP396r7xQSCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgABWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgABWaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:30:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9A92253D;
        Thu,  2 Jan 2020 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004222;
        bh=p/VQ5XvFfXoxpzlYbitgprfWPKotHqsZENTAFtN7H3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ye/nl9lOep10zxofr4r00Lr2mx3CSii1k3chEcY1jhNzQ+gOImrPVsjzo0jvL89E2
         wASTuzmH9ChV14/hY/mGlIIUsl7og5JCE7ysSFhWNh6IlNZ+v8/hAp65ToBtZKjU4f
         uDbVnvVPohqUOmivjEiA5WLCILrk704LKyZa0iXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 088/171] btrfs: dont double lock the subvol_sem for rename exchange
Date:   Thu,  2 Jan 2020 23:06:59 +0100
Message-Id: <20200102220559.262428738@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 943eb3bf25f4a7b745dd799e031be276aa104d82 ]

If we're rename exchanging two subvols we'll try to lock this lock
twice, which is bad.  Just lock once if either of the ino's are subvols.

Fixes: cdd1fedf8261 ("btrfs: add support for RENAME_EXCHANGE and RENAME_WHITEOUT")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80937c5ca477..bb8863958ac0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9597,9 +9597,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		return -EXDEV;
 
 	/* close the race window with snapshot create/destroy ioctl */
-	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
-		down_read(&root->fs_info->subvol_sem);
-	if (new_ino == BTRFS_FIRST_FREE_OBJECTID)
+	if (old_ino == BTRFS_FIRST_FREE_OBJECTID ||
+	    new_ino == BTRFS_FIRST_FREE_OBJECTID)
 		down_read(&dest->fs_info->subvol_sem);
 
 	/*
@@ -9785,9 +9784,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	ret2 = btrfs_end_transaction(trans, root);
 	ret = ret ? ret : ret2;
 out_notrans:
-	if (new_ino == BTRFS_FIRST_FREE_OBJECTID)
-		up_read(&dest->fs_info->subvol_sem);
-	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
+	if (new_ino == BTRFS_FIRST_FREE_OBJECTID ||
+	    old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&root->fs_info->subvol_sem);
 
 	return ret;
-- 
2.20.1



