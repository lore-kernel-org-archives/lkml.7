Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE84C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C520882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394744AbfITGyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:54:50 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35720 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbfITGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:54:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 174ED18013A68;
        Fri, 20 Sep 2019 08:54:47 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0DMwfpTKi4jM; Fri, 20 Sep 2019 08:54:46 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 49ghSciSR6TN; Fri, 20 Sep 2019 08:54:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Christoph Hellwig <hch@lst.de>,
        Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] ubifs: Remove obsolete TODO from dfs_file_write()
Date:   Fri, 20 Sep 2019 08:54:29 +0200
Message-Id: <20190920065429.19709-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT this kind of problems are no longer possible since
debugfs gained file removal protection via
e9117a5a4bf6 ("debugfs: implement per-file removal protection").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index a5f10d79e0dd..d67f91752f83 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2737,18 +2737,6 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 	struct dentry *dent = file->f_path.dentry;
 	int val;
 
-	/*
-	 * TODO: this is racy - the file-system might have already been
-	 * unmounted and we'd oops in this case. The plan is to fix it with
-	 * help of 'iterate_supers_type()' which we should have in v3.0: when
-	 * a debugfs opened, we rember FS's UUID in file->private_data. Then
-	 * whenever we access the FS via a debugfs file, we iterate all UBIFS
-	 * superblocks and fine the one with the same UUID, and take the
-	 * locking right.
-	 *
-	 * The other way to go suggested by Al Viro is to create a separate
-	 * 'ubifs-debug' file-system instead.
-	 */
 	if (file->f_path.dentry == d->dfs_dump_lprops) {
 		ubifs_dump_lprops(c);
 		return count;
-- 
2.16.4

