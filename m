Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F131FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277220644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENTLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:11:06 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38872 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:11:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 15C951809AD8D;
        Tue, 14 May 2019 21:11:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] ubifs: Convert xattr inum  to host order
Date:   Tue, 14 May 2019 21:10:50 +0200
Message-Id: <20190514191050.13181-2-richard@nod.at>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190514191050.13181-1-richard@nod.at>
References: <20190514191050.13181-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBIFS stores inode numbers as LE64 integers.
We have to convert them to host oder, otherwise
BE hosts won't be able to use the integer correctly.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index acab3181ab35..bcfed27e8997 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -527,7 +527,7 @@ int ubifs_purge_xattrs(struct inode *host)
 		fname_name(&nm) = xent->name;
 		fname_len(&nm) = le16_to_cpu(xent->nlen);
 
-		xino = ubifs_iget(c->vfs_sb, xent->inum);
+		xino = ubifs_iget(c->vfs_sb, le64_to_cpu(xent->inum));
 		if (IS_ERR(xino)) {
 			err = PTR_ERR(xino);
 			ubifs_err(c, "dead directory entry '%s', error %d",
-- 
2.16.4

