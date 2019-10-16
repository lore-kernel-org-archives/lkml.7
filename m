Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4057FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9A21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230242;
	bh=wJYYhLx+KNviIY73v4OgzVaFxvuQHAwdNRyitIrkhU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UvrtQldMMqFK5csE3rwB6+rTPgtmc4428u2QO8UbaOwEyMlka2uCP/J/FOxG2gRz6
	 SPcs4/RxOXofTL6azmA4wDGJ2iw/hDZrRLKlXSefkTQ+WB4X/h+MaCGaRhfoNffK3t
	 6/OYjWL1MfZz70EVCWri70M14I4PaeM+Ashnb0KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405252AbfJPMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:50:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34497 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405232AbfJPMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:50:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so14694269pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7ahoJcenlQ9SILwTEeWbhExEsDQGMhHgD6Cz2Vzc6g=;
        b=VQvrb2enCvNYBWxo0VUsRupGYWBpe4FSiVv1uDW0euQHro+JPmY5WnyRX35nxSH9Id
         BE3IY/RvHjKJedsy8JewWWJGq9YyWMqrR8FO3n2w8AYzuDjUgf62PoS/1JwOcNPBBXQL
         oUrKWGxhUSEFunUQXdOSAOCuowK3ArzI6V0VAqfS8/2xv65RZgpDoU4DOsyX5mF4F0yp
         9B88jk3fygNy3s/Ax0i1AhOtSKcnslpC9VtperCDQylpSXHGb2aAJ+PesGW4KCLYtfWC
         lWfO1Wtp+2uUyVPU3Gsee+pGi/X5LWMzXgwWmPQbO4VoMLEq5exIiMVZtfdyNKFrUyFr
         aMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b7ahoJcenlQ9SILwTEeWbhExEsDQGMhHgD6Cz2Vzc6g=;
        b=KTB3l4Rq6vH2r2m/BbJOov2fluRvsFCxOcgCw/4tFHo6axteI1X+QulZiOMYK2ytYm
         f8ypUG/09uDopOk1PHFrwLXM7hLV8bBHT0MuOI5Q2LyTxd8q3TAVE+qnQp85wLQbSZk5
         s6aHcRFT4SG4Hc6L1qLRr/Fb5Gwoc5VFk1sAuNF/ivaexEc/t4pJlbgaBmYWKWXYlck6
         e+RxGEKT6hm+RnmJtjjmy0XpUxLoB3S18Q/NS2Ygkku2EjRvNLnQYlETMSWfGIMkhq3K
         /Jc5lN8S9DBmgcf5PjEKroS8QJbYUT+blajvs6i70EvsPoNbUVPuuLlm7nBdZew4IA0R
         P9RA==
X-Gm-Message-State: APjAAAUaa/GY11e40zNNWeE2vaZGfFrC+SWWS/ZirqoPWk92n9y9cBeh
        DXxWiVCU6bLLM5KJSdaVFrw=
X-Google-Smtp-Source: APXvYqxw3yCwlEDzhgpkysiKxRrThKNg7sdoxOnvqyrvrYufFRNwuEmDm0s/r4J9A3lwqi70XapyEA==
X-Received: by 2002:a65:5503:: with SMTP id f3mr44699250pgr.351.1571230237906;
        Wed, 16 Oct 2019 05:50:37 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id j17sm24010620pfr.70.2019.10.16.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:50:37 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/2] kernfs: Allow creation with external gen + ino numbers
Date:   Wed, 16 Oct 2019 21:50:19 +0900
Message-Id: <20191016125019.157144-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191016125019.157144-1-namhyung@kernel.org>
References: <20191016125019.157144-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend file and directory creation API to take external generation
number and inode number.  Passing 0 as inode number will keep original
behavior.

The cgroup id will be used as inode number from now on so allocate id
for each file as well.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
 fs/kernfs/dir.c                        | 63 ++++++++++++++++++++------
 fs/kernfs/file.c                       |  9 ++--
 fs/kernfs/kernfs-internal.h            |  5 ++
 fs/sysfs/file.c                        |  2 +-
 include/linux/kernfs.h                 | 25 +++++++---
 kernel/cgroup/cgroup.c                 | 12 ++++-
 7 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..a2fbcab3189e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -206,7 +206,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
 
 	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				  0, rft->kf_ops, rft, NULL, NULL);
+				  0, rft->kf_ops, rft, NULL, NULL, 0, 0);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
@@ -2294,7 +2294,7 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 
 	kn = __kernfs_create_file(parent_kn, name, 0444,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
-				  &kf_mondata_ops, priv, NULL, NULL);
+				  &kf_mondata_ops, priv, NULL, NULL, 0, 0);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6ebae6bbe6a5..f2e54532c110 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -618,10 +618,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
 					     kuid_t uid, kgid_t gid,
+					     u32 gen, int ino,
 					     unsigned flags)
 {
 	struct kernfs_node *kn;
-	u32 gen;
 	int cursor;
 	int ret;
 
@@ -635,11 +635,24 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&kernfs_idr_lock);
-	cursor = idr_get_cursor(&root->ino_idr);
-	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
-	if (ret >= 0 && ret < cursor)
-		root->next_generation++;
-	gen = root->next_generation;
+
+	if (ino == 0) {
+		cursor = idr_get_cursor(&root->ino_idr);
+		ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
+		if (ret >= 0 && ret < cursor)
+			root->next_generation++;
+		gen = root->next_generation;
+	} else {
+		ret = idr_alloc(&root->ino_idr, kn, ino, ino + 1, GFP_ATOMIC);
+		if (ret != ino) {
+			WARN_ONCE(1, "kernfs ino was used: %d", ino);
+			ret = -EINVAL;
+		} else {
+			WARN_ON(root->next_generation > gen);
+			root->next_generation = gen;
+		}
+	}
+
 	spin_unlock(&kernfs_idr_lock);
 	idr_preload_end();
 	if (ret < 0)
@@ -696,7 +709,24 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 	struct kernfs_node *kn;
 
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
-			       name, mode, uid, gid, flags);
+			       name, mode, uid, gid, 0, 0, flags);
+	if (kn) {
+		kernfs_get(parent);
+		kn->parent = parent;
+	}
+	return kn;
+}
+
+struct kernfs_node *kernfs_new_node_with_id(struct kernfs_node *parent,
+					    const char *name, umode_t mode,
+					    kuid_t uid, kgid_t gid,
+					    u32 gen, int ino,
+					    unsigned flags)
+{
+	struct kernfs_node *kn;
+
+	kn = __kernfs_new_node(kernfs_root(parent), parent,
+			       name, mode, uid, gid, gen, ino, flags);
 	if (kn) {
 		kernfs_get(parent);
 		kn->parent = parent;
@@ -965,7 +995,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	root->next_generation = 1;
 
 	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
-			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0, 0,
 			       KERNFS_DIR);
 	if (!kn) {
 		idr_destroy(&root->ino_idr);
@@ -1000,7 +1030,7 @@ void kernfs_destroy_root(struct kernfs_root *root)
 }
 
 /**
- * kernfs_create_dir_ns - create a directory
+ * __kernfs_create_dir - create a directory
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  * @mode: mode of the new directory
@@ -1008,20 +1038,23 @@ void kernfs_destroy_root(struct kernfs_root *root)
  * @gid: gid of the new directory
  * @priv: opaque data associated with the new directory
  * @ns: optional namespace tag of the directory
+ * @gen: optional inode generation number
+ * @ino: optional inode number
  *
  * Returns the created node on success, ERR_PTR() value on failure.
  */
-struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
-					 const char *name, umode_t mode,
-					 kuid_t uid, kgid_t gid,
-					 void *priv, const void *ns)
+struct kernfs_node *__kernfs_create_dir(struct kernfs_node *parent,
+					const char *name, umode_t mode,
+					kuid_t uid, kgid_t gid,
+					void *priv, const void *ns,
+					u32 gen, int ino)
 {
 	struct kernfs_node *kn;
 	int rc;
 
 	/* allocate */
-	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
-			     uid, gid, KERNFS_DIR);
+	kn = kernfs_new_node_with_id(parent, name, mode | S_IFDIR,
+				     uid, gid, gen, ino, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e8c792b49616..8280b750b733 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -981,6 +981,8 @@ const struct file_operations kernfs_file_fops = {
  * @priv: private data for the file
  * @ns: optional namespace tag of the file
  * @key: lockdep key for the file's active_ref, %NULL to disable lockdep
+ * @gen: optional inode generation number
+ * @ino: optional inode number
  *
  * Returns the created node on success, ERR_PTR() value on error.
  */
@@ -990,7 +992,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
-					 struct lock_class_key *key)
+					 struct lock_class_key *key,
+					 u32 gen, int ino)
 {
 	struct kernfs_node *kn;
 	unsigned flags;
@@ -998,8 +1001,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 
 	flags = KERNFS_FILE;
 
-	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
-			     uid, gid, flags);
+	kn = kernfs_new_node_with_id(parent, name, (mode & S_IALLUGO) | S_IFREG,
+				     uid, gid, gen, ino, flags);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 02ce570a9a3c..42c787720a1f 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -109,6 +109,11 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
+struct kernfs_node *kernfs_new_node_with_id(struct kernfs_node *parent,
+					    const char *name, umode_t mode,
+					    kuid_t uid, kgid_t gid,
+					    u32 gen, int ino,
+					    unsigned flags);
 struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 						    unsigned int ino);
 
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 130fc6fbcc03..a21aa1aa2106 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -303,7 +303,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  size, ops, (void *)attr, ns, key);
+				  size, ops, (void *)attr, ns, key, 0, 0);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 936b61bd504e..3764a870a279 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -340,10 +340,11 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 				       unsigned int flags, void *priv);
 void kernfs_destroy_root(struct kernfs_root *root);
 
-struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
+struct kernfs_node *__kernfs_create_dir(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
 					 kuid_t uid, kgid_t gid,
-					 void *priv, const void *ns);
+					 void *priv, const void *ns,
+					 u32 gen, int ino);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
@@ -352,7 +353,8 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
-					 struct lock_class_key *key);
+					 struct lock_class_key *key,
+					 u32 gen, int ino);
 struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
 				       struct kernfs_node *target);
@@ -438,16 +440,17 @@ kernfs_create_root(struct kernfs_syscall_ops *scops, unsigned int flags,
 static inline void kernfs_destroy_root(struct kernfs_root *root) { }
 
 static inline struct kernfs_node *
-kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
+__kernfs_create_dir(struct kernfs_node *parent, const char *name,
 		     umode_t mode, kuid_t uid, kgid_t gid,
-		     void *priv, const void *ns)
+		     void *priv, const void *ns, u32 gen, int ino)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
 		     umode_t mode, kuid_t uid, kgid_t gid,
 		     loff_t size, const struct kernfs_ops *ops,
-		     void *priv, const void *ns, struct lock_class_key *key)
+		     void *priv, const void *ns, struct lock_class_key *key,
+		     u32 gen, int ino)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
@@ -528,6 +531,14 @@ kernfs_walk_and_get(struct kernfs_node *kn, const char *path)
 	return kernfs_walk_and_get_ns(kn, path, NULL);
 }
 
+static inline struct kernfs_node *
+kernfs_create_dir_ns(struct kernfs_node *parent, const char *name, umode_t mode,
+		     kuid_t uid, kgid_t gid, void *priv, const void *ns)
+{
+	return __kernfs_create_dir(parent, name, mode,
+				   uid, gid, priv, ns, 0, 0);
+}
+
 static inline struct kernfs_node *
 kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 		  void *priv)
@@ -549,7 +560,7 @@ kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
 	key = (struct lock_class_key *)&ops->lockdep_key;
 #endif
 	return __kernfs_create_file(parent, name, mode, uid, gid,
-				    size, ops, priv, ns, key);
+				    size, ops, priv, ns, key, 0, 0);
 }
 
 static inline struct kernfs_node *
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 44c67d26c1fe..13d0d181a9f8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3916,16 +3916,22 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	char name[CGROUP_FILE_NAME_MAX];
 	struct kernfs_node *kn;
 	struct lock_class_key *key = NULL;
+	struct cgroup_root *root = cgrp->root;
+	int ino, gen;
 	int ret;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = &cft->lockdep_key;
 #endif
+
+	ino = cgroup_idr_alloc(&root->cgroup_idr, NULL, false, GFP_KERNEL);
+	gen = root->cgroup_idr.generation;
+
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
 				  cgroup_file_mode(cft),
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
-				  NULL, key);
+				  NULL, key, gen, ino);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
@@ -5426,7 +5432,9 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	}
 
 	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	kn = __kernfs_create_dir(parent->kn, name, mode,
+				 GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				 cgrp, NULL, cgrp->gen, cgrp->id);
 	if (IS_ERR(kn)) {
 		ret = PTR_ERR(kn);
 		goto out_destroy;
-- 
2.23.0.700.g56cf767bdb-goog

