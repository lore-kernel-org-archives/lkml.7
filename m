Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2839C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA3A2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCHQ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:36474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbfCHQ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 417CDB053;
        Fri,  8 Mar 2019 16:28:00 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 1/2] ceph: factor out ceph_lookup_inode()
Date:   Fri,  8 Mar 2019 16:27:56 +0000
Message-Id: <20190308162757.9260-2-lhenriques@suse.com>
In-Reply-To: <20190308162757.9260-1-lhenriques@suse.com>
References: <20190308162757.9260-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will be used by __fh_to_dentry and by the quotas code, to find
quota realm inodes that are not visible in the mountpoint.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/export.c | 14 +++++++++++++-
 fs/ceph/super.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 3c59ad180ef0..0d8ead82c816 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -59,7 +59,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	return type;
 }
 
-static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
 	struct inode *inode;
@@ -92,12 +92,24 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 		ceph_mdsc_put_request(req);
 		if (!inode)
 			return ERR_PTR(-ESTALE);
+		if (err)
+			return ERR_PTR(err);
 		if (inode->i_nlink == 0) {
 			iput(inode);
 			return ERR_PTR(-ESTALE);
 		}
 	}
 
+	return inode;
+}
+
+static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+{
+	struct inode *inode = ceph_lookup_inode(sb, ino);
+
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
 	return d_obtain_alias(inode);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index dfb64a5211b6..ce51e98b08ec 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1061,6 +1061,7 @@ extern long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /* export.c */
 extern const struct export_operations ceph_export_ops;
+struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino);
 
 /* locks.c */
 extern __init void ceph_flock_init(void);
