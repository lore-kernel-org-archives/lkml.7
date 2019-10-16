Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9209E20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392190AbfJPKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:08:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45316 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfJPKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:08:12 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKgDs-0002s6-TA; Wed, 16 Oct 2019 11:08:05 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKgDs-00084o-6a; Wed, 16 Oct 2019 11:08:04 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: possible missed le64_to_cpu() in journal
Date:   Wed, 16 Oct 2019 11:08:03 +0100
Message-Id: <20191016100803.31003-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ubifs_jnl_write_inode() functon, it calls ubifs_iget()
with xent->inum. The xent->inum is __le64, but the ubifs_iget()
takes native cpu endian.

I think that this should be changed to passing le64_to_cpu(xent->inum)
to fix the following sparse warning:

fs/ubifs/journal.c:902:58: warning: incorrect type in argument 2 (different base types)
fs/ubifs/journal.c:902:58:    expected unsigned long inum
fs/ubifs/journal.c:902:58:    got restricted __le64 [usertype] inum

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ubifs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index d6136f7c1cfc..388fe8f5dc51 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -899,7 +899,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 			fname_name(&nm) = xent->name;
 			fname_len(&nm) = le16_to_cpu(xent->nlen);
 
-			xino = ubifs_iget(c->vfs_sb, xent->inum);
+			xino = ubifs_iget(c->vfs_sb, le64_to_cpu(xent->inum));
 			if (IS_ERR(xino)) {
 				err = PTR_ERR(xino);
 				ubifs_err(c, "dead directory entry '%s', error %d",
-- 
2.23.0

