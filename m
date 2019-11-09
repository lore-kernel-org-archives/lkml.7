Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B3C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9821848
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKIHu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 02:50:26 -0500
Received: from mx-out.tlen.pl ([193.222.135.158]:28267 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfKIHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 02:50:26 -0500
Received: (wp-smtpd smtp.tlen.pl 37743 invoked from network); 9 Nov 2019 08:50:22 +0100
Received: from unknown (HELO sarna-pc.localdomain) (p.sarna@o2.pl@[12.207.198.221])
          (envelope-sender <p.sarna@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mike.kravetz@oracle.com>; 9 Nov 2019 08:50:22 +0100
From:   Piotr Sarna <p.sarna@tlen.pl>
To:     mike.kravetz@oracle.com, linux-kernel@vger.kernel.org
Cc:     Piotr Sarna <p.sarna@tlen.pl>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        mhocko@kernel.org,
        syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com
Subject: [PATCH v2] hugetlbfs: add O_TMPFILE support
Date:   Sat,  9 Nov 2019 08:50:12 +0100
Message-Id: <bc9383eff6e1374d79f3a92257ae829ba1e6ae60.1573285189.git.p.sarna@tlen.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 939dbc952ae583a528cb1dffcdafb309
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EdON]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With hugetlbfs, a common pattern for mapping anonymous huge pages
is to create a temporary file first. Currently libraries like
libhugetlbfs and seastar create these with a standard mkstemp+unlink
trick, but it would be more robust to be able to simply pass
the O_TMPFILE flag to open(). O_TMPFILE is already supported by several
file systems like ext4 and xfs. The implementation simply uses the existing
d_tmpfile utility function to instantiate the dcache entry for the file.

Tested manually by successfully creating a temporary file by opening
it with (O_TMPFILE|O_RDWR) on mounted hugetlbfs and successfully
mapping 2M huge pages with it. Without the patch, trying to open
a file with O_TMPFILE results in -ENOSUP.

v2 changes:
 * syzkaller thankfully discovered a bug during unmount - tmpfile
erroneously called dget() on a dentry when creating a tmpfile,
and it was never countered by a dput(), because tmpfile is never
explicitly unlinked. In v2, dget() is simply not called for tmpfile.
Verified manually, and also with the reproducer provided by syzkaller.
Reported-by: syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com

Signed-off-by: Piotr Sarna <p.sarna@tlen.pl>
---
 fs/hugetlbfs/inode.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..a39d7a0a158e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -815,8 +815,11 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry, umode_t mode, dev_t dev)
+static int do_hugetlbfs_mknod(struct inode *dir,
+			struct dentry *dentry,
+			umode_t mode,
+			dev_t dev,
+			bool tmpfile)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -824,13 +827,23 @@ static int hugetlbfs_mknod(struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (inode) {
 		dir->i_ctime = dir->i_mtime = current_time(dir);
-		d_instantiate(dentry, inode);
-		dget(dentry);	/* Extra count - pin the dentry in core */
+		if (tmpfile) {
+			d_tmpfile(dentry, inode);
+		} else {
+			d_instantiate(dentry, inode);
+			dget(dentry);/* Extra count - pin the dentry in core */
+		}
 		error = 0;
 	}
 	return error;
 }
 
+static int hugetlbfs_mknod(struct inode *dir,
+			struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+}
+
 static int hugetlbfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
@@ -844,6 +857,12 @@ static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mo
 	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
 }
 
+static int hugetlbfs_tmpfile(struct inode *dir,
+			struct dentry *dentry, umode_t mode)
+{
+	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+}
+
 static int hugetlbfs_symlink(struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
@@ -1102,6 +1121,7 @@ static const struct inode_operations hugetlbfs_dir_inode_operations = {
 	.mknod		= hugetlbfs_mknod,
 	.rename		= simple_rename,
 	.setattr	= hugetlbfs_setattr,
+	.tmpfile	= hugetlbfs_tmpfile,
 };
 
 static const struct inode_operations hugetlbfs_inode_operations = {
-- 
2.23.0

