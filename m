Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D44BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB4D217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552450269;
	bh=LxlrRriCUvWB0llhmtnNemrHhZkDDWhRuigcuu+oUBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dQnZ5sFVWfTEav1qvz3ojjrgkUXyrDZ8WkIQH9kPDi5qEggCtEyO2FnSYUNh4ia2W
	 WF2s37vSSqnczmKCy5btrT/TQa4mliddzalx1cO13hAdCJQHrxtzo5G3r9xtJqXAf2
	 PzO0ad6hJ5bRTCZhFOwAxIPLTD+eSp1DrY/Tt3Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCMELH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:11:07 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46879 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbfCMEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:10:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 36C7038BA;
        Wed, 13 Mar 2019 00:10:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 00:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=VarWHpv6u1eyq4j1v3y49MuABe9he+BxgXSBL3PSb4Q=; b=d8lLFjn0
        nMwh/kNc2+qBZIFWVCNrztCxsu071YOCXlhRj9fA7PbhBxiG99hCyx6vm4Z3R8rp
        dyyEub4a+Y7OYp5Vrz0iqgGluOEgstBFzqRspb+DsPF7phT85HaDBNTLEFBSQKmZ
        udZmOrs/vv2v+tH9Vd4Nygja1WgNI0Nhsins3af2sQIedmFeaKXtOB6rVNj1MRan
        zN/BDCvY/uRHAT9AUq5ADTP5fTl4wy7/tkjkLvjSCjRsxQWVvAogaoUems2NUDWo
        NMIDu4BSAG4gtN19cKY8iLGLesGpNXb2RgliP291hyYbEXg7Roscq6DWZKhZa3Y0
        EUseT1bdSIRjng==
X-ME-Sender: <xms:roKIXKgPqffisiE8uHg4C5ryF9GbmAYXhK4iXh7MxB74qVRCX7g4HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:roKIXC9R43mkDh5XvdB5c1p0lplPjJOmAzckoTPxzWQFalhK_QcXJw>
    <xmx:roKIXJTUs8_1fPpmx0gKqgnK68sr9jJz5QDBqXBzfgLiPJiKsRd0Tw>
    <xmx:roKIXJvY4WVJa1xGW4mW8odFZXBuPBPHrNU_RuPs8yo0d_LjK3op1Q>
    <xmx:roKIXNzhXbLrcYxvUOvkh2yX5qKKFTZ04KMm9_dTFsoTW3ofuNWlAQ>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D031E4583;
        Wed, 13 Mar 2019 00:10:20 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] docs: filesystems: vfs: Add code-block and txt->RST
Date:   Wed, 13 Mar 2019 15:09:15 +1100
Message-Id: <20190313040919.6937-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313040919.6937-1-tobin@kernel.org>
References: <20190313040919.6937-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use code-block for C source code.  With this in place we can rename the
.txt file to  .rst.  This introduces a few warnings that will be fixed
in proceeding patches.

Add '.. code-block:: c' to C source code snippets.  Rename the file to
use rst file suffix.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{vfs.txt => vfs.rst}          | 319 +++++++++---------
 2 files changed, 168 insertions(+), 152 deletions(-)
 rename Documentation/filesystems/{vfs.txt => vfs.rst} (86%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1131c34d77f6..35644840a690 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -16,6 +16,7 @@ algorithms work.
 .. toctree::
    :maxdepth: 2
 
+   vfs
    path-lookup.rst
    api-summary
    splice
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.rst
similarity index 86%
rename from Documentation/filesystems/vfs.txt
rename to Documentation/filesystems/vfs.rst
index f52c42fc2448..84c1dfef7838 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.rst
@@ -87,6 +87,8 @@ Registering and Mounting a Filesystem
 To register and unregister a filesystem, use the following API
 functions:
 
+.. code-block:: c
+
    #include <linux/fs.h>
 
    extern int register_filesystem(struct file_system_type *);
@@ -110,18 +112,19 @@ struct file_system_type
 This describes the filesystem.  As of kernel 2.6.39, the following
 members are defined:
 
-struct file_system_type {
-	const char *name;
-	int fs_flags;
-        struct dentry *(*mount) (struct file_system_type *, int,
-                       const char *, void *);
-        void (*kill_sb) (struct super_block *);
-        struct module *owner;
-        struct file_system_type * next;
-        struct list_head fs_supers;
-	struct lock_class_key s_lock_key;
-	struct lock_class_key s_umount_key;
-};
+.. code-block:: c
+
+   struct file_system_type {
+	   const char *name;
+	   int fs_flags;
+	   struct dentry *(*mount) (struct file_system_type *, int, const char *, void *);
+	   void (*kill_sb) (struct super_block *);
+	   struct module *owner;
+	   struct file_system_type * next;
+	   struct list_head fs_supers;
+	   struct lock_class_key s_lock_key;
+	   struct lock_class_key s_umount_key;
+   };
 
 - name: the name of the filesystem type, such as "ext2", "iso9660",
 	"msdos" and so on
@@ -206,30 +209,31 @@ struct super_operations
 This describes how the VFS can manipulate the superblock of your
 filesystem.  As of kernel 2.6.22, the following members are defined:
 
-struct super_operations {
-        struct inode *(*alloc_inode)(struct super_block *sb);
-        void (*destroy_inode)(struct inode *);
-
-        void (*dirty_inode) (struct inode *, int flags);
-        int (*write_inode) (struct inode *, int);
-        void (*drop_inode) (struct inode *);
-        void (*delete_inode) (struct inode *);
-        void (*put_super) (struct super_block *);
-        int (*sync_fs)(struct super_block *sb, int wait);
-        int (*freeze_fs) (struct super_block *);
-        int (*unfreeze_fs) (struct super_block *);
-        int (*statfs) (struct dentry *, struct kstatfs *);
-        int (*remount_fs) (struct super_block *, int *, char *);
-        void (*clear_inode) (struct inode *);
-        void (*umount_begin) (struct super_block *);
-
-        int (*show_options)(struct seq_file *, struct dentry *);
-
-        ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-        ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	int (*nr_cached_objects)(struct super_block *);
-	void (*free_cached_objects)(struct super_block *, int);
-};
+.. code-block:: c
+
+   struct super_operations {
+	   struct inode *(*alloc_inode)(struct super_block *sb);
+	   void (*destroy_inode)(struct inode *);
+	   void (*dirty_inode) (struct inode *, int flags);
+	   int (*write_inode) (struct inode *, int);
+	   void (*drop_inode) (struct inode *);
+	   void (*delete_inode) (struct inode *);
+	   void (*put_super) (struct super_block *);
+	   int (*sync_fs)(struct super_block *sb, int wait);
+	   int (*freeze_fs) (struct super_block *);
+	   int (*unfreeze_fs) (struct super_block *);
+	   int (*statfs) (struct dentry *, struct kstatfs *);
+	   int (*remount_fs) (struct super_block *, int *, char *);
+	   void (*clear_inode) (struct inode *);
+	   void (*umount_begin) (struct super_block *);
+
+	   int (*show_options)(struct seq_file *, struct dentry *);
+
+	   ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+	   ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
+	   int (*nr_cached_objects)(struct super_block *);
+	   void (*free_cached_objects)(struct super_block *, int);
+   };
 
 All methods are called without any locks being held, unless otherwise
 noted.  This means that most methods can block safely.  All methods are
@@ -365,30 +369,32 @@ struct inode_operations
 This describes how the VFS can manipulate an inode in your filesystem.
 As of kernel 2.6.22, the following members are defined:
 
-struct inode_operations {
-	int (*create) (struct inode *,struct dentry *, umode_t, bool);
-	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,umode_t);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
-	int (*rename) (struct inode *, struct dentry *,
-			struct inode *, struct dentry *, unsigned int);
-	int (*readlink) (struct dentry *, char __user *,int);
-	const char *(*get_link) (struct dentry *, struct inode *,
-				 struct delayed_call *);
-	int (*permission) (struct inode *, int);
-	int (*get_acl)(struct inode *, int);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
-	ssize_t (*listxattr) (struct dentry *, char *, size_t);
-	void (*update_time)(struct inode *, struct timespec *, int);
-	int (*atomic_open)(struct inode *, struct dentry *, struct file *,
-			unsigned open_flag, umode_t create_mode);
-	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
-};
+.. code-block:: c
+
+   struct inode_operations {
+	   int (*create) (struct inode *,struct dentry *, umode_t, bool);
+	   struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
+	   int (*link) (struct dentry *,struct inode *,struct dentry *);
+	   int (*unlink) (struct inode *,struct dentry *);
+	   int (*symlink) (struct inode *,struct dentry *,const char *);
+	   int (*mkdir) (struct inode *,struct dentry *,umode_t);
+	   int (*rmdir) (struct inode *,struct dentry *);
+	   int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
+	   int (*rename) (struct inode *, struct dentry *,
+			  struct inode *, struct dentry *, unsigned int);
+	   int (*readlink) (struct dentry *, char __user *,int);
+	   const char *(*get_link) (struct dentry *, struct inode *,
+				    struct delayed_call *);
+	   int (*permission) (struct inode *, int);
+	   int (*get_acl)(struct inode *, int);
+	   int (*setattr) (struct dentry *, struct iattr *);
+	   int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
+	   ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	   void (*update_time)(struct inode *, struct timespec *, int);
+	   int (*atomic_open)(struct inode *, struct dentry *, struct file *,
+			      unsigned open_flag, umode_t create_mode);
+	   int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+   };
 
 Again, all methods are called without any locks being held, unless
 otherwise noted.
@@ -624,39 +630,41 @@ struct address_space_operations
 This describes how the VFS can manipulate mapping of a file to page
 cache in your filesystem.  The following members are defined:
 
-struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
-	int (*writepages)(struct address_space *, struct writeback_control *);
-	int (*set_page_dirty)(struct page *page);
-	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
-	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
-	int (*write_end)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
-	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
-	int (*releasepage) (struct page *, int);
-	void (*freepage)(struct page *);
-	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
-	/* isolate a page for migration */
-	bool (*isolate_page) (struct page *, isolate_mode_t);
-	/* migrate the contents of a page to the specified target */
-	int (*migratepage) (struct page *, struct page *);
-	/* put migration-failed page back to right list */
-	void (*putback_page) (struct page *);
-	int (*launder_page) (struct page *);
-
-	int (*is_partially_uptodate) (struct page *, unsigned long,
-					unsigned long);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
-	int (*error_remove_page) (struct mapping *mapping, struct page *page);
-	int (*swap_activate)(struct file *);
-	int (*swap_deactivate)(struct file *);
-};
+.. code-block:: c
+
+   struct address_space_operations {
+	   int (*writepage)(struct page *page, struct writeback_control *wbc);
+	   int (*readpage)(struct file *, struct page *);
+	   int (*writepages)(struct address_space *, struct writeback_control *);
+	   int (*set_page_dirty)(struct page *page);
+	   int (*readpages)(struct file *filp, struct address_space *mapping,
+			    struct list_head *pages, unsigned nr_pages);
+	   int (*write_begin)(struct file *, struct address_space *mapping,
+			      loff_t pos, unsigned len, unsigned flags,
+			      struct page **pagep, void **fsdata);
+	   int (*write_end)(struct file *, struct address_space *mapping,
+			    loff_t pos, unsigned len, unsigned copied,
+			    struct page *page, void *fsdata);
+	   sector_t (*bmap)(struct address_space *, sector_t);
+	   void (*invalidatepage) (struct page *, unsigned int, unsigned int);
+	   int (*releasepage) (struct page *, int);
+	   void (*freepage)(struct page *);
+	   ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
+	   /* isolate a page for migration */
+	   bool (*isolate_page) (struct page *, isolate_mode_t);
+	   /* migrate the contents of a page to the specified target */
+	   int (*migratepage) (struct page *, struct page *);
+	   /* put migration-failed page back to right list */
+	   void (*putback_page) (struct page *);
+	   int (*launder_page) (struct page *);
+
+	   int (*is_partially_uptodate) (struct page *, unsigned long,
+					 unsigned long);
+	   void (*is_dirty_writeback) (struct page *, bool *, bool *);
+	   int (*error_remove_page) (struct mapping *mapping, struct page *page);
+	   int (*swap_activate)(struct file *);
+	   int (*swap_deactivate)(struct file *);
+   };
 
 - writepage: called by the VM to write a dirty page to backing store.
       This may happen for data integrity reasons (i.e. 'sync'), or
@@ -852,44 +860,49 @@ struct file_operations
 This describes how the VFS can manipulate an open file.  As of kernel
 4.18, the following members are defined:
 
-struct file_operations {
-	struct module *owner;
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
-	void (*show_fdinfo)(struct seq_file *m, struct file *f);
-#ifndef CONFIG_MMU
-	unsigned (*mmap_capabilities)(struct file *);
-#endif
-	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t, size_t, unsigned int);
-	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
-				   struct file *file_out, loff_t pos_out,
-				   loff_t len, unsigned int remap_flags);
-	int (*fadvise)(struct file *, loff_t, loff_t, int);
-};
+.. code-block:: c
+
+   struct file_operations {
+	   struct module *owner;
+	   loff_t (*llseek) (struct file *, loff_t, int);
+	   ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
+	   ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
+	   ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
+	   ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	   int (*iterate) (struct file *, struct dir_context *);
+	   int (*iterate_shared) (struct file *, struct dir_context *);
+	   __poll_t (*poll) (struct file *, struct poll_table_struct *);
+	   long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	   long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
+	   int (*mmap) (struct file *, struct vm_area_struct *);
+	   int (*open) (struct inode *, struct file *);
+	   int (*flush) (struct file *, fl_owner_t id);
+	   int (*release) (struct inode *, struct file *);
+	   int (*fsync) (struct file *, loff_t, loff_t, int datasync);
+	   int (*fasync) (int, struct file *, int);
+	   int (*lock) (struct file *, int, struct file_lock *);
+	   ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
+	   unsigned long (*get_unmapped_area)(struct file *, unsigned long,
+					      unsigned long, unsigned long, unsigned long);
+	   int (*check_flags)(int);
+	   int (*flock) (struct file *, int, struct file_lock *);
+	   ssize_t (*splice_write)(struct pipe_inode_info *, struct file *,
+				   loff_t *, size_t, unsigned int);
+	   ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *,
+				  size_t, unsigned int);
+	   int (*setlease)(struct file *, long, struct file_lock **, void **);
+	   long (*fallocate)(struct file *file, int mode, loff_t offset, loff_t len);
+	   void (*show_fdinfo)(struct seq_file *m, struct file *f);
+   #ifndef CONFIG_MMU
+	   unsigned (*mmap_capabilities)(struct file *);
+   #endif
+	   ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t,
+				      size_t, unsigned int);
+	   loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      loff_t len, unsigned int remap_flags);
+	   int (*fadvise)(struct file *, loff_t, loff_t, int);
+   };
 
 Again, all methods are called without any locks being held, unless
 otherwise noted.
@@ -1003,21 +1016,23 @@ here.  These methods may be set to NULL, as they are either optional or
 the VFS uses a default.  As of kernel 2.6.22, the following members are
 defined:
 
-struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, unsigned int);
-	int (*d_weak_revalidate)(struct dentry *, unsigned int);
-	int (*d_hash)(const struct dentry *, struct qstr *);
-	int (*d_compare)(const struct dentry *,
-			unsigned int, const char *, const struct qstr *);
-	int (*d_delete)(const struct dentry *);
-	int (*d_init)(struct dentry *);
-	void (*d_release)(struct dentry *);
-	void (*d_iput)(struct dentry *, struct inode *);
-	char *(*d_dname)(struct dentry *, char *, int);
-	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
-};
+.. code-block:: c
+
+   struct dentry_operations {
+	   int (*d_revalidate)(struct dentry *, unsigned int);
+	   int (*d_weak_revalidate)(struct dentry *, unsigned int);
+	   int (*d_hash)(const struct dentry *, struct qstr *);
+	   int (*d_compare)(const struct dentry *,
+			    unsigned int, const char *, const struct qstr *);
+	   int (*d_delete)(const struct dentry *);
+	   int (*d_init)(struct dentry *);
+	   void (*d_release)(struct dentry *);
+	   void (*d_iput)(struct dentry *, struct inode *);
+	   char *(*d_dname)(struct dentry *, char *, int);
+	   struct vfsmount *(*d_automount)(struct path *);
+	   int (*d_manage)(const struct path *, bool);
+	   struct dentry *(*d_real)(struct dentry *, const struct inode *);
+   };
 
 - d_revalidate: called when the VFS needs to revalidate a dentry.  This
 	is called whenever a name look-up finds a dentry in the
@@ -1103,13 +1118,13 @@ struct dentry_operations {
 	at the end of the buffer, and returns a pointer to the first char.
 	dynamic_dname() helper function is provided to take care of this.
 
-	Example :
+	.. code-block:: c
 
-	static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
-	{
-		return dynamic_dname(dentry, buffer, buflen, "pipe:[%lu]",
-				dentry->d_inode->i_ino);
-	}
+	   static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
+	   {
+		   return dynamic_dname(dentry, buffer, buflen, "pipe:[%lu]",
+					dentry->d_inode->i_ino);
+	   }
 
 - d_automount: called when an automount dentry is to be traversed (optional).
 	This should create a new VFS mount record and return the record to the
-- 
2.21.0

