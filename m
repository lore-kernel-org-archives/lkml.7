Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D472C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B6A2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEEFMi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 01:12:38 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21317 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEEFMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 01:12:38 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 01:12:37 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1557032243; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=L5YsrAeijUcTg2v1of+l9lvBUz3RRoo13nNZ+jPEoNPVPec6i2zn4dpSKcIJNNwEMK92BDD1CTH304sF6iuEKgxOvMHPbny+CqwUgEtvpQ1DxbL46qqSWSJIWwfUXR6N/OjJ/7dKNIK3sKv+doMCzRcyFv2GQWW1ZU6iHGkC1OE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1557032243; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=KIjtZWVE4SRnLES/sk5ccLpeSnPzKXQWtQxZnXSkHWA=; 
        b=Lgtre0SyLZOV21/j5Swvi1o5F5UCIUUAgjitJmUn6fW+NnA2vU7Jnu9nlIbLgY/oZq/TAFkgzNJK8xFg1VB/HrCrIiyUKnz58rlBfvsoFhPtxEo0spRt4g4GEK/EWlh/fa1aQ8vkgI6FSpbjeXkwfLCZ9XABo6i35z+HocbyEO0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dimakrasner.com;
        spf=pass  smtp.mailfrom=dima@dimakrasner.com;
        dmarc=pass header.from=<dima@dimakrasner.com> header.from=<dima@dimakrasner.com>
Received: from hazak.localdomain (89.237.80.180 [89.237.80.180]) by mx.zohomail.com
        with SMTPS id 1557032241719266.2197311963272; Sat, 4 May 2019 21:57:21 -0700 (PDT)
From:   Dima Krasner <dima@dimakrasner.com>
To:     dima@dimakrasner.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>
Message-ID: <20190505045912.12311-1-dima@dimakrasner.com>
Subject: [PATCH v2] mm: do not grant +x by default in memfd_create()
Date:   Sun,  5 May 2019 07:59:12 +0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <201905050757.M2Q7kM1M%lkp@intel.com>
References: <201905050757.M2Q7kM1M%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This syscall allows easy fileless execution, without calling chmod() first.
Thus, some security-related restrictions (like seccomp filters that deny
chmod +x) can by bypassed using memfd_create() if the policy author is
unaware of this.

Signed-off-by: Dima Krasner <dima@dimakrasner.com>
Cc: linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>
---
 fs/hugetlbfs/inode.c    |  5 +++--
 include/linux/hugetlb.h |  4 ++--
 include/linux/stat.h    |  1 +
 ipc/shm.c               |  3 ++-
 mm/memfd.c              |  3 ++-
 mm/mmap.c               |  3 ++-
 mm/shmem.c              | 11 ++++++-----
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9285dd4f4b1c..512ac8a226ef 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1363,7 +1363,8 @@ static int get_hstate_idx(int page_size_log)
  */
 struct file *hugetlb_file_setup(const char *name, size_t size,
 				vm_flags_t acctflag, struct user_struct **user,
-				int creat_flags, int page_size_log)
+				int creat_flags, int page_size_log,
+				umode_t mode)
 {
 	struct inode *inode;
 	struct vfsmount *mnt;
@@ -1393,7 +1394,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	}
 
 	file = ERR_PTR(-ENOSPC);
-	inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0);
+	inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | mode, 0);
 	if (!inode)
 		goto out;
 	if (creat_flags == HUGETLB_SHMFS_INODE)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 11943b60f208..59486f5ea89f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -308,7 +308,7 @@ extern const struct file_operations hugetlbfs_file_operations;
 extern const struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 				struct user_struct **user, int creat_flags,
-				int page_size_log);
+				int page_size_log, umode_t mode);
 
 static inline bool is_file_hugepages(struct file *file)
 {
@@ -325,7 +325,7 @@ static inline bool is_file_hugepages(struct file *file)
 static inline struct file *
 hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
 		struct user_struct **user, int creat_flags,
-		int page_size_log)
+		int page_size_log, umode_t mode)
 {
 	return ERR_PTR(-ENOSYS);
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 765573dc17d6..efda7df06d6e 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -11,6 +11,7 @@
 #define S_IRUGO		(S_IRUSR|S_IRGRP|S_IROTH)
 #define S_IWUGO		(S_IWUSR|S_IWGRP|S_IWOTH)
 #define S_IXUGO		(S_IXUSR|S_IXGRP|S_IXOTH)
+#define S_IRWUGO	(S_IRUGO|S_IWUGO)
 
 #define UTIME_NOW	((1l << 30) - 1l)
 #define UTIME_OMIT	((1l << 30) - 2l)
diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..a64a52e4ccf1 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -651,7 +651,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			acctflag = VM_NORESERVE;
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				  &shp->mlock_user, HUGETLB_SHMFS_INODE,
-				(shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
+				(shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK,
+				S_IRWXUGO);
 	} else {
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
diff --git a/mm/memfd.c b/mm/memfd.c
index 650e65a46b9c..b680fae87240 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -300,7 +300,8 @@ SYSCALL_DEFINE2(memfd_create,
 		file = hugetlb_file_setup(name, 0, VM_NORESERVE, &user,
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
-					MFD_HUGE_MASK);
+					MFD_HUGE_MASK,
+					S_IRWUGO);
 	} else
 		file = shmem_file_setup(name, 0, VM_NORESERVE);
 	if (IS_ERR(file)) {
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..4494ce44ca5d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1600,7 +1600,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
 				VM_NORESERVE,
 				&user, HUGETLB_ANONHUGE_INODE,
-				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK,
+				S_IRWXUGO);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index 2275a0ff7c30..a903b9f783e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3968,7 +3968,8 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, loff_t size,
-				       unsigned long flags, unsigned int i_flags)
+				       unsigned long flags, unsigned int i_flags,
+				       umode_t mode)
 {
 	struct inode *inode;
 	struct file *res;
@@ -3982,7 +3983,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (shmem_acct_size(flags, size))
 		return ERR_PTR(-ENOMEM);
 
-	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
+	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | mode, 0,
 				flags);
 	if (unlikely(!inode)) {
 		shmem_unacct_size(flags, size);
@@ -4012,7 +4013,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
  */
 struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
 {
-	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
+	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE, S_IRWXUGO);
 }
 
 /**
@@ -4023,7 +4024,7 @@ struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned lon
  */
 struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
 {
-	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
+	return __shmem_file_setup(shm_mnt, name, size, flags, 0, S_IRWUGO);
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup);
 
@@ -4037,7 +4038,7 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
 struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
 				       loff_t size, unsigned long flags)
 {
-	return __shmem_file_setup(mnt, name, size, flags, 0);
+	return __shmem_file_setup(mnt, name, size, flags, 0, S_IRWUGO);
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-- 
2.21.0



