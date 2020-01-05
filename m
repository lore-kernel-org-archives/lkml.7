Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911FCC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E9720866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="NxfpWGy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEMAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 07:00:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAEMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:00:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so46593541wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNZENrPCfYoBaHBME6z04+ddX8BsgyHZGAwNwJzbfqU=;
        b=NxfpWGy6labos7XDl84kHbgXxhCjfcLe0fdH3wyuztVZ7XE5olsY+HKAUauOtY75vR
         slOjJNOcbkrhEIOzHZ+DFGvUWBBCWNA6aVvKiRmXYMOg4UVhioK9HNyGmf9AXREo3W3n
         XZVk8O5n69hHZtuPKZy5adpZCHe3msF8YccsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNZENrPCfYoBaHBME6z04+ddX8BsgyHZGAwNwJzbfqU=;
        b=bkbmPZQHIEErXX9bja/L7mz4nfy4eL5pcITTIHr3I8qjI5OzGsLIL5Zb69rY4WcK55
         V/dkXTLGu5L/RVlRI8WaNEqX8f6nnPYyZ3UGHE0p9eNCeY0CzlZAHY9z6H+z4PkDkPCj
         UK5D5YhOGOGnpZ8BXYNgdz1ATlQAHhX9PHIlnx/qofgV/esUjfDXK34OGvvbMteHWUH8
         ahyNlnbAuhGX8FLXK9laEJbZOl+LFX9YWk6uuHpAE7V7vviLBVeQkWRUbLGPOTvGu9uU
         lkzj6ryuvKZid/8SanMi1IbEnvH6KK6O3CDXDRXN2OlLZi65AGJc+svOwp92N/10z1U+
         WBwA==
X-Gm-Message-State: APjAAAVpmPxWHmzwL+LwPnAmaHdNibUGAzL/+FERcUEgkvDmLXrcKt/7
        205D1jFdZlhs1o9VfkG/pF+4xw==
X-Google-Smtp-Source: APXvYqxRdwQv2HibsFgbFKstbyGPs2aCGM8BJZ/E5eDJGBbY7QIQQOvO9i5Mjak6XmoQ6m1+VvTWyQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr101122891wrs.213.1578225632521;
        Sun, 05 Jan 2020 04:00:32 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id 60sm71252134wrn.86.2020.01.05.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:00:32 -0800 (PST)
Date:   Sun, 5 Jan 2020 12:00:31 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-mm@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578224757.git.chris@chrisdown.name>
References: <cover.1578224757.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578224757.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_next_ino has a number of problems:

- It uses and returns a uint, which is susceptible to become overflowed
  if a lot of volatile inodes that use get_next_ino are created.
- It's global, with no specificity per-sb or even per-filesystem. This
  means it's not that difficult to cause inode number wraparounds on a
  single device, which can result in having multiple distinct inodes
  with the same inode number.

This patch adds a per-superblock counter that mitigates the second case.
This design also allows us to later have a specific i_ino size
per-device, for example, allowing users to choose whether to use 32- or
64-bit inodes for each tmpfs mount. This is implemented in the next
commit.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index de8e4b71e3ba..7fac91f490dc 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -35,6 +35,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	ino_t next_ino;		    /* The next per-sb inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
diff --git a/mm/shmem.c b/mm/shmem.c
index 8793e8cc1a48..9e97ba972225 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2236,6 +2236,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * shmem_get_inode - reserve, allocate, and initialise a new inode
+ *
+ * If this tmpfs is from kern_mount we use get_next_ino, which is global, since
+ * inum churn there is low and this avoids taking locks.
+ */
 static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
 {
@@ -2248,7 +2254,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		if (sb->s_flags & SB_KERNMOUNT) {
+			/*
+			 * __shmem_file_setup, one of our callers, is lock-free:
+			 * it doesn't hold stat_lock in shmem_reserve_inode
+			 * since max_inodes is always 0, and is called from
+			 * potentially unknown contexts. As such, use the global
+			 * allocator which doesn't require the per-sb stat_lock.
+			 */
+			inode->i_ino = get_next_ino();
+		} else {
+			spin_lock(&sbinfo->stat_lock);
+			if (unlikely(sbinfo->next_ino > UINT_MAX)) {
+				/*
+				 * Emulate get_next_ino uint wraparound for
+				 * compatibility
+				 */
+				sbinfo->next_ino = 1;
+			}
+			inode->i_ino = sbinfo->next_ino++;
+			spin_unlock(&sbinfo->stat_lock);
+		}
+
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -3662,6 +3689,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
+	sbinfo->next_ino = 1;
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
 	sbinfo->uid = ctx->uid;
-- 
2.24.1

