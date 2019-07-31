Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCCC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44030206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6vwHvIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfGaIjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:39:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33541 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfGaIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:39:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so31464847pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dV/8PkSSFLhiHDgfOGlA7ghabtjd74EDlwCe3zPbIvk=;
        b=C6vwHvIx03VFTkjjaNYCoJp6ZOc1BpkGcZiyDSoDMuIJcQin8fZb3rB69QmEJzEEqw
         IIo+2VSYcJGi5wf8F1laV8Vhmflz9yLPCQT0uMR8QJMq1JdDQPhylz3l7sTJLzK2/JpG
         pRbwYe4z0oYj8L6dFL8l1aBY0EV6qc5w/6gwhxV63hukYZTEQawLLu80AuFfiOFcBDOF
         9EiTtY/FrQi0k9pvrRvR6YefDIVAzpL9IQZ06o2xywJ7JKe2xBhm0BbyWUvI6vh/9FYs
         UItwUBgScZWozsggIBM0Vx4LN+H0R7wMV4FKcSjtD52hzItYzp2eVbXgnFNQqQ9WsRl+
         SW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dV/8PkSSFLhiHDgfOGlA7ghabtjd74EDlwCe3zPbIvk=;
        b=so2tEsdnlYaVogg2wnjWFhe1lhIipab/0ttq2gokRXsNvmSuyDXKVUKHiEu86+328P
         N99b+fW2J/wshHDloSbPbRirN5XtZ8e02zaCiMod+rV/XH00mRcdPJRCNNuxiE0YC5KA
         w0V15NoeA9/t1aYNcYt8S9uEQyYFbeXHgfmXNwcwSAsg70aNAhQJ280m5TXHXBjcf0MW
         G+ibfAIZpDoUNk0XIMHibQlqJtyU/BveyUKf+d8/aFSoyG94hk7gXPYDsRXBrKhnV6Pl
         xdvboZ9y3aW/fCTwDrECscPaeWfGnaQLHRXR7aOz0cwysJW+2rQMuxhXsQhP+uMVrliy
         t/Lg==
X-Gm-Message-State: APjAAAVPRQFowW/m9YwUs/6nmi3pboe1UlPbwtG/IBDSXs0o7SPuzsHR
        OqzDlWWknBrhBjIFjjA4WR4=
X-Google-Smtp-Source: APXvYqz94AOqYOZvZ30tTSh0eTpa4jPriyb0VIxFqI42TdkNlsZTSQmGganVniu4KcgZBIPWYX89hw==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr46192506pfc.62.1564562343983;
        Wed, 31 Jul 2019 01:39:03 -0700 (PDT)
Received: from hayden-ubuntu18.cisco.com ([64.104.125.225])
        by smtp.gmail.com with ESMTPSA id q19sm72142463pfc.62.2019.07.31.01.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 01:39:03 -0700 (PDT)
From:   Haodong Wong <haydenw.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     akpm@linux-foundation.org, 21cnbao@gmail.com, haodwang@cisco.com,
        haydenw.kernel@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ramfs: add nfs-export support
Date:   Wed, 31 Jul 2019 16:37:36 +0800
Message-Id: <20190731083736.4554-1-haydenw.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to tmpfs use inode number and generation number to construct the filehandle for nfs-export

Without this patch, when run exportfs for nfs-kernel-server to export
ramfs, it will report "not support NFS export"

Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
---
 fs/ramfs/inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 733c6b4193dc..7a60dfefa6fd 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -36,6 +36,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/exportfs.h>
 #include "internal.h"
 
 struct ramfs_mount_opts {
@@ -66,6 +67,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode_init_owner(inode, dir, mode);
+		inode->i_generation = get_seconds();
 		inode->i_mapping->a_ops = &ramfs_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
@@ -217,6 +219,75 @@ static int ramfs_parse_options(char *data, struct ramfs_mount_opts *opts)
 	return 0;
 }
 
+static struct dentry *ramfs_get_parent(struct dentry *child)
+{
+	return ERR_PTR(-ESTALE);
+}
+
+static int ramfs_match(struct inode *ino, void *vfh)
+{
+	__u32 *fh = vfh;
+	__u64 inum = fh[2];
+
+	inum = (inum << 32) | fh[1];
+	return ino->i_ino == inum && fh[0] == ino->i_generation;
+}
+
+static struct dentry *ramfs_fh_to_dentry(struct super_block *sb,
+			   struct fid *fid, int fh_len, int fh_type)
+
+{
+	struct inode *inode;
+	struct dentry *dentry = NULL;
+	u64 inum;
+
+	if (fh_len < 3)
+		return NULL;
+
+	inum = fid->raw[2];
+	inum = (inum << 32) | fid->raw[1];
+	inode = ilookup5(sb, (unsigned long)(inum + fid->raw[0]),
+				ramfs_match, fid->raw);
+
+	if (inode) {
+		dentry = d_find_alias(inode);
+		iput(inode);
+	}
+
+	return dentry;
+}
+
+static int ramfs_encode_fh(struct inode *inode, __u32 *fh, int *len,
+			   struct inode *parent)
+{
+	if (*len < 3) {
+		*len = 3;
+		return FILEID_INVALID;
+	}
+
+	if (inode_unhashed(inode)) {
+		static DEFINE_SPINLOCK(lock);
+
+		spin_lock(&lock);
+		if (inode_unhashed(inode))
+			__insert_inode_hash(inode,
+				inode->i_ino + inode->i_generation);
+		spin_unlock(&lock);
+	}
+	fh[0] = inode->i_generation;
+	fh[1] = inode->i_ino;
+	fh[2] = ((__u64)inode->i_ino) >> 32;
+
+	*len = 3;
+	return 1;
+}
+
+static const struct export_operations ramfs_export_ops = {
+	.get_parent     = ramfs_get_parent,
+	.encode_fh      = ramfs_encode_fh,
+	.fh_to_dentry   = ramfs_fh_to_dentry,
+};
+
 int ramfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct ramfs_fs_info *fsi;
@@ -238,6 +309,7 @@ int ramfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic		= RAMFS_MAGIC;
 	sb->s_op		= &ramfs_ops;
 	sb->s_time_gran		= 1;
+	sb->s_export_op         = &ramfs_export_ops;
 
 	inode = ramfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
 	sb->s_root = d_make_root(inode);
-- 
2.17.1

