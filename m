Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD317C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8CE20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663915;
	bh=qYPWTHCM6x0VyzWhalgS+QKo8ck1T+Nh56l1jRrFqhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZkLjrvlhRqAndxn7HbtLyd82ENII3EJNFcaEShFecpK7JG39hGXnHm0zLi/FgAJn
	 9469veqv8H8psUbbZogGqC+4MuioshfH0Pb6Jbc9JFn3ZskMYdrNQAmxatn12WgxVO
	 gmC4rrknmnq/cBrUcJM1YXKc0b+OjV5Vtw8LOXb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfC0FSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53297 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfC0FSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D8A5E21EF6;
        Wed, 27 Mar 2019 01:18:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GelJCVBorRkFif4XzyC1nfJRqbMDtixq0L53mQXCkok=; b=Sl1STTZy
        TF3Qy4D46EPwhATwVXuViHwgjbXR6+xonbds/F3XSjV5GmqHr7cTdm3DR0YqFjBx
        LEmYl2lvBH/Tdy/WJg0NBrXP6AE1ysm5sUGV4uk64L7pC4nhGlKl6WncKJNZqHTA
        qmBkCrb3HWCJcn6/INH1EoDD7hGC4RlK7lQJWX36azHTUV8pe71W1FrguJKXkpJH
        Zk1mQ/l5riCL/f3U8JTl5Dw38cYVtyVg2BqNWDV8eS2fQsxw9TRqZtz2hjNvFVAo
        QRIgNdVLWHtB5/I4Y093CGZ5f+9xKSjZlueVprnB4qusWMZgulG3hpvefyVFBELT
        Pt7JngeSqoFcAQ==
X-ME-Sender: <xms:pwebXAMvLuXqy9WrjkhaRAWJy2eHcvjgm1FlvqbRSI2mE9LXJ3t4rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pwebXAbs67DomaIUQVChrZY4enznqWe5cmmRz5SzlcsTliPFkkobeg>
    <xmx:pwebXG0wn2IN07XVXKgEhuCWjnIFiOUbJ96zfKSRfiPmdPMBFtsIgg>
    <xmx:pwebXOefsLV8ksXUUGmvF71o6cvc1_gxbQ213Zs1S8MGZa29Lus5PA>
    <xmx:pwebXKUC7txRaz76WcthEGjP0uihvfa8QoKrHhTEnkEkz_bMXTGuGA>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10C3FE44D7;
        Wed, 27 Mar 2019 01:18:27 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/24] vfs: Clean up VFS data structure declarations
Date:   Wed, 27 Mar 2019 16:16:55 +1100
Message-Id: <20190327051717.23225-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFS core data structure declarations are included in the documentation
as is.  In preparation for updating the VFS documentation we can tidy
them up a wee bit.  Many have no named parameters, for types such as
'char *' and 'int' this is not descriptive.  We can do better by
including parameter names for such data types.  Adding names to
parameters that are obvious (such as `struct dentry *`) does not add any
extra clarity to the code so increases the line length unnecessarily,
leave these un-named.

The only other issues are whitespace.  Some methods use whitespace
before the parameters and some don't, whichever we use we should be
uniform, follow checkpatch suggestion and do not use whitespace between
function pointer identifier and the parameter list, for example:

	int (*foo)(int arg)

Clean up structs by adding parameter names when useful and fixing
whitespace usage within struct definitions to be uniform across the
file.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/fs.h | 181 ++++++++++++++++++++++++---------------------
 1 file changed, 97 insertions(+), 84 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f9d2e6b9ac3..a8af48d3bd4f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -356,38 +356,40 @@ struct address_space_operations {
 	 * PURELY used for read-ahead!.
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
+			 struct list_head *pages, unsigned nr_pages);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
+			   loff_t pos, unsigned len, unsigned flags,
+			   struct page **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
+			 loff_t pos, unsigned len, unsigned copied,
+			 struct page *page, void *fsdata);
 
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
-	int (*releasepage) (struct page *, gfp_t);
+	void (*invalidatepage)(struct page *, unsigned int offset,
+			       unsigned int length);
+	int (*releasepage)(struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a page to the specified target. If
 	 * migrate_mode is MIGRATE_ASYNC, it must not block.
 	 */
-	int (*migratepage) (struct address_space *,
-			struct page *, struct page *, enum migrate_mode);
+	int (*migratepage)(struct address_space *mapping,
+			   struct page *newpage, struct page *page,
+			   enum migrate_mode mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct page *);
-	int (*launder_page) (struct page *);
-	int (*is_partially_uptodate) (struct page *, unsigned long,
-					unsigned long);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
+	int (*launder_page)(struct page *);
+	int (*is_partially_uptodate)(struct page *, unsigned long from,
+				     unsigned long count);
+	void (*is_dirty_writeback)(struct page *, bool *dirty, bool *writeback);
 	int (*error_remove_page)(struct address_space *, struct page *);
 
 	/* swapfile support */
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
-				sector_t *span);
+			     sector_t *span);
 	void (*swap_deactivate)(struct file *file);
 };
 
@@ -1784,73 +1786,82 @@ struct iov_iter;
 
 struct file_operations {
 	struct module *owner;
-	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
-	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iterate) (struct file *, struct dir_context *);
-	int (*iterate_shared) (struct file *, struct dir_context *);
-	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
-	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
-	int (*mmap) (struct file *, struct vm_area_struct *);
+	loff_t (*llseek)(struct file *, loff_t, int whence);
+	ssize_t (*read)(struct file *, char __user *buf, size_t bufsz,
+			loff_t *ppos);
+	ssize_t (*write)(struct file *, const char __user *buf, size_t bufsz,
+			 loff_t *ppos);
+	ssize_t (*read_iter)(struct kiocb *, struct iov_iter *);
+	ssize_t (*write_iter)(struct kiocb *, struct iov_iter *);
+	int (*iterate)(struct file *, struct dir_context *);
+	int (*iterate_shared)(struct file *, struct dir_context *);
+	__poll_t (*poll)(struct file *, struct poll_table_struct *);
+	long (*unlocked_ioctl)(struct file *, unsigned int cmd, unsigned long arg);
+	long (*compat_ioctl)(struct file *, unsigned int cmd, unsigned long arg);
+	int (*mmap)(struct file *, struct vm_area_struct *);
 	unsigned long mmap_supported_flags;
-	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *, fl_owner_t id);
-	int (*release) (struct inode *, struct file *);
-	int (*fsync) (struct file *, loff_t, loff_t, int datasync);
-	int (*fasync) (int, struct file *, int);
-	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
-	int (*check_flags)(int);
-	int (*flock) (struct file *, int, struct file_lock *);
-	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
-	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
-	long (*fallocate)(struct file *file, int mode, loff_t offset,
-			  loff_t len);
+	int (*open)(struct inode *, struct file *);
+	int (*flush)(struct file *, fl_owner_t id);
+	int (*release)(struct inode *, struct file *);
+	int (*fsync)(struct file *, loff_t start, loff_t end, int datasync);
+	int (*fasync)(int fd, struct file *, int flags);
+	int (*lock)(struct file *, int cmd, struct file_lock *);
+	ssize_t (*sendpage)(struct file *, struct page *, int, size_t, loff_t *, int);
+	unsigned long (*get_unmapped_area)(struct file *, unsigned long addr,
+					   unsigned long len, unsigned long pgoff,
+					   unsigned long flags);
+	int (*check_flags)(int flags);
+	int (*flock)(struct file *, int cmd, struct file_lock *);
+	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *,
+				size_t len, unsigned int flags);
+	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *,
+			       size_t len, unsigned int flags);
+	int (*setlease)(struct file *, long arg, struct file_lock **, void **priv);
+	long (*fallocate)(struct file *, int mode, loff_t offset, loff_t len);
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
 #ifndef CONFIG_MMU
 	unsigned (*mmap_capabilities)(struct file *);
 #endif
-	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
-			loff_t, size_t, unsigned int);
+	ssize_t (*copy_file_range)(struct file *file_in, loff_t pos_in,
+				   struct file *file_out, loff_t pos_out,
+				   size_t len, unsigned int copy_flags);
 	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
-	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*fadvise)(struct file *, loff_t offset, loff_t len, int advice);
 } __randomize_layout;
 
 struct inode_operations {
-	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
-	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
-	int (*permission) (struct inode *, int);
-	struct posix_acl * (*get_acl)(struct inode *, int);
-
-	int (*readlink) (struct dentry *, char __user *,int);
-
-	int (*create) (struct inode *,struct dentry *, umode_t, bool);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,umode_t);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
-	int (*rename) (struct inode *, struct dentry *,
-			struct inode *, struct dentry *, unsigned int);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
-	ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	struct dentry * (*lookup)(struct inode *dir, struct dentry *dentry,
+				  unsigned int flags);
+	const char * (*get_link)(struct dentry *, struct inode *, struct delayed_call *);
+	int (*permission)(struct inode *, int mask);
+	struct posix_acl * (*get_acl)(struct inode *inode, int type);
+
+	int (*readlink)(struct dentry *, char __user *buf, int bufsz);
+
+	int (*create)(struct inode *, struct dentry *, umode_t, bool);
+	int (*link)(struct dentry *, struct inode *, struct dentry *);
+	int (*unlink)(struct inode *, struct dentry *);
+	int (*symlink)(struct inode *, struct dentry *, const char *symname);
+	int (*mkdir)(struct inode *, struct dentry *, umode_t);
+	int (*rmdir)(struct inode *, struct dentry *);
+	int (*mknod)(struct inode *, struct dentry *, umode_t, dev_t);
+	int (*rename)(struct inode *old_inode, struct dentry *old_dentry,
+		      struct inode *new_inode, struct dentry *new_dentry,
+		      unsigned int flags);
+	int (*setattr)(struct dentry *, struct iattr *);
+	int (*getattr)(const struct path *, struct kstat *,
+		       u32 request_mask, unsigned int flags);
+	ssize_t (*listxattr)(struct dentry *, char *buf, size_t bufsz);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
-	int (*update_time)(struct inode *, struct timespec64 *, int);
+	int (*update_time)(struct inode *, struct timespec64 *, int flags);
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
-	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
-	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	int (*tmpfile)(struct inode *, struct dentry *, umode_t);
+	int (*set_acl)(struct inode *, struct posix_acl *, int type);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -1900,30 +1911,32 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 
 
 struct super_operations {
-   	struct inode *(*alloc_inode)(struct super_block *sb);
+	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
 
-   	void (*dirty_inode) (struct inode *, int flags);
-	int (*write_inode) (struct inode *, struct writeback_control *wbc);
-	int (*drop_inode) (struct inode *);
-	void (*evict_inode) (struct inode *);
-	void (*put_super) (struct super_block *);
+	void (*dirty_inode)(struct inode *, int flags);
+	int (*write_inode)(struct inode *, struct writeback_control *wbc);
+	int (*drop_inode)(struct inode *);
+	void (*evict_inode)(struct inode *);
+	void (*put_super)(struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
-	int (*freeze_super) (struct super_block *);
-	int (*freeze_fs) (struct super_block *);
-	int (*thaw_super) (struct super_block *);
-	int (*unfreeze_fs) (struct super_block *);
-	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*remount_fs) (struct super_block *, int *, char *);
-	void (*umount_begin) (struct super_block *);
+	int (*freeze_super)(struct super_block *);
+	int (*freeze_fs)(struct super_block *);
+	int (*thaw_super)(struct super_block *);
+	int (*unfreeze_fs)(struct super_block *);
+	int (*statfs)(struct dentry *, struct kstatfs *);
+	int (*remount_fs)(struct super_block *, int *flags, char *options);
+	void (*umount_begin)(struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct dentry *);
 	int (*show_devname)(struct seq_file *, struct dentry *);
 	int (*show_path)(struct seq_file *, struct dentry *);
 	int (*show_stats)(struct seq_file *, struct dentry *);
 #ifdef CONFIG_QUOTA
-	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
+	ssize_t (*quota_read)(struct super_block *sb, int type, char *data,
+			      size_t len, loff_t off);
+	ssize_t (*quota_write)(struct super_block *sb, int type,
+			       const char *data, size_t len, loff_t off);
 	struct dquot **(*get_dquots)(struct inode *);
 #endif
 	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
@@ -2177,11 +2190,11 @@ struct file_system_type {
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_description *parameters;
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
-	void (*kill_sb) (struct super_block *);
+	struct dentry *(*mount)(struct file_system_type *fs_type, int flags,
+				const char *dev_name, void *data);
+	void (*kill_sb)(struct super_block *);
 	struct module *owner;
-	struct file_system_type * next;
+	struct file_system_type *next;
 	struct hlist_head fs_supers;
 
 	struct lock_class_key s_lock_key;
-- 
2.21.0

