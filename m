Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DCE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDvelEto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfEUPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:25:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44188 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfEUPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:25:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so8582193pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdaJBF1a54+J7d5kWpb232plUcibzVQf3Uiz9BAkxgo=;
        b=BDvelEtoH1/0CmMhQfDSTTmAojKplI7qSU0Yip08dsE8u5MJlLR532L/5qa2zTkkI6
         cAgeYhvb0DWhPEs8LGInE6PTTX1W4R8YYbdxxptEwsJr11jVMCL7Q7kxOdMMFgKrwBU3
         qH78ZRxMHOXQc6znnBVR2hQew7ZKP0keoV49vNplGia5Xrvf9lBXnpi5eRVGv4X7naK0
         sJqOQI+rG7COsZXOr+Q2S45sS1j3VQ65xfAeKU15rPd4aZHX7U/J8nWcQWtBd8lXGM31
         R7A7FPUYkR542nq+vOrcF3PGyy0bK3L3BDFdQnXBbsk5zY42i/o9aXKeMor1iCbMl8N2
         c8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdaJBF1a54+J7d5kWpb232plUcibzVQf3Uiz9BAkxgo=;
        b=ENITzCiJkoFt6UiS+SJ3IHV6gzEoFXW0RsDgepUHx35BVTOGn9hxHv8Qw3gAPlLm7r
         6azSysqQ/kZ0+BsCu52cETXezFA1M8NKBE8R4gz9fym/Iro/4dxi/0F/w/aORbSLyvn4
         i8mkGOXQUUmEoDOhx5TJmv3eWh51awjL5h0fzAjkRly6zYTgTrITr9p+UU3vn8d4rl/v
         ZGomj1wrRu4d38DylWaQSNQYn3Gyu5TQZkoR3Pr/N0eQ0agVmvRCvDpML1l5e1Xh+w+t
         3TtGJAwji8aunSHEFH1KCpegfUHlqMTU3M6nmXU/Oo4AiBmpD6tphr9rg78TQ0KdG/9L
         N59g==
X-Gm-Message-State: APjAAAW3kGqHNb7F555NSGuWBzXPashEsZVClqx8tnLNpiwm3bLrEsy0
        25RY14vSjnlXo4FHwjuHxIU=
X-Google-Smtp-Source: APXvYqwQOEc5LaWd+CSZ846bvEs8KxhgqUjmIPX0xBUg3CLW+R/4LSDk3vhsS8yqTabxj8M4fPxCqw==
X-Received: by 2002:a17:902:714e:: with SMTP id u14mr77331822plm.218.1558452339355;
        Tue, 21 May 2019 08:25:39 -0700 (PDT)
Received: from hayden-ubuntu18.cisco.com ([64.104.125.234])
        by smtp.gmail.com with ESMTPSA id f186sm30805642pfb.5.2019.05.21.08.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 08:25:38 -0700 (PDT)
From:   Haodong Wong <haydenw.kernel@gmail.com>
To:     21cnbao@gmail.com
Cc:     haodwang@cisco.com, Haodong Wong <haydenw.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] knfsd: add nfs-export support to ramfs
Date:   Tue, 21 May 2019 23:25:25 +0800
Message-Id: <20190521152526.3071-1-haydenw.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <haodwang@cisco.com>
References: <haodwang@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to tmpfs, use inode number and generation number
to construct the filehandle for nfs-export

Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
---
 fs/ramfs/inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 11201b2d06b9..418b2551f6fd 100644
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

