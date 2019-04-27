Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B89212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfD0P3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:29:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32898 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbfD0PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:18 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2p-0000zB-Uq; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004cd-0i; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matej Kupljen" <matej.kupljen@gmail.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.782560896@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 167/202] tmpfs: fix link accounting when a tmpfile is
 linked in
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>

commit 1062af920c07f5b54cf5060fde3339da6df0cf6b upstream.

tmpfs has a peculiarity of accounting hard links as if they were
separate inodes: so that when the number of inodes is limited, as it is
by default, a user cannot soak up an unlimited amount of unreclaimable
dcache memory just by repeatedly linking a file.

But when v3.11 added O_TMPFILE, and the ability to use linkat() on the
fd, we missed accommodating this new case in tmpfs: "df -i" shows that
an extra "inode" remains accounted after the file is unlinked and the fd
closed and the actual inode evicted.  If a user repeatedly links
tmpfiles into a tmpfs, the limit will be hit (ENOSPC) even after they
are deleted.

Just skip the extra reservation from shmem_link() in this case: there's
a sense in which this first link of a tmpfile is then cheaper than a
hard link of another file, but the accounting works out, and there's
still good limiting, so no need to do anything more complicated.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1902182134370.7035@eggly.anvils
Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked to")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-by: Matej Kupljen <matej.kupljen@gmail.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/shmem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2013,10 +2013,14 @@ static int shmem_link(struct dentry *old
 	 * No ordinary (disk based) filesystem counts links as inodes;
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
+	 * But if an O_TMPFILE file is linked into the tmpfs, the
+	 * first link must skip that, to get the accounting right.
 	 */
-	ret = shmem_reserve_inode(inode->i_sb);
-	if (ret)
-		goto out;
+	if (inode->i_nlink) {
+		ret = shmem_reserve_inode(inode->i_sb);
+		if (ret)
+			goto out;
+	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;

