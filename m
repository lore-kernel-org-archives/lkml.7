Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A6CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F225222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Fi5/cg9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438808AbfJRP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:28:33 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:60590 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410508AbfJRP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:28:32 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 11:28:12 EDT
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 31B4C820B5;
        Fri, 18 Oct 2019 18:18:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1571411920;
        bh=bTcacOJ8hRJZz9JskUSTjlH9uU9dz8HqDL+gogkufPI=;
        h=From:To:Subject:Date;
        b=Fi5/cg9uqm+UrNnrH//c3l7ObWo2Jb2K4H1eYr3xoXrEGfVSuXhfEVJ+wyVHtjKRS
         Zr6hD9rWHaRgZB/YjS6PW1GaeD4h1VY7JjVFaV412r5k9q2cFoMnSbF0TYj4VQgUNC
         YoPQkqmQtI5E6VZe2CkwWTg1bzfKD39NR82Q36YM=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Fri, 18 Oct 2019 18:18:39 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1591.008; Fri, 18 Oct 2019 18:18:39 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Thread-Index: AQHVhcdRcSNAPtJsQk6FKzDkwjWK3A==
Date:   Fri, 18 Oct 2019 15:18:39 +0000
Message-ID: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.4]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18DDC9DECA4FC94ABE45315E85D5F732@paragon-software.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently exFAT filesystem specification has been made public by Microsoft (=
https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification).
Having decades of expertise in commercial file systems development, we at P=
aragon Software GmbH are very excited by Microsoft's decision and now want =
to make our contribution to the Open Source Community by providing our impl=
ementation of exFAT Read-Only (yet!) fs implementation for the Linux Kernel=
.
We are about to prepare the Read-Write support patch as well.
'fs/exfat' is implemented accordingly to standard Linux fs development appr=
oach with no use/addition of any custom API's.
To divide our contribution from 'drivers/staging' submit of Aug'2019, our K=
config key is "EXFAT_RO_FS"

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
MAINTAINERS         |    6 +
fs/Kconfig          |    3 +-
fs/exfat/Kconfig    |   31 ++
fs/exfat/Makefile   |    9 +
fs/exfat/bitmap.c   |  117 +++++
fs/exfat/cache.c    |  483 ++++++++++++++++++
fs/exfat/debug.h    |   69 +++
fs/exfat/dir.c      |  610 +++++++++++++++++++++++
fs/exfat/exfat.h    |  248 ++++++++++
fs/exfat/exfat_fs.h |  388 +++++++++++++++
fs/exfat/fatent.c   |   79 +++
fs/exfat/file.c     |   93 ++++
fs/exfat/inode.c    |  317 ++++++++++++
fs/exfat/namei.c    |  154 ++++++
fs/exfat/super.c    | 1145 +++++++++++++++++++++++++++++++++++++++++++
fs/exfat/upcase.c   |  344 +++++++++++++
16 files changed, 4095 insertions(+), 1 deletion(-)
create mode 100644 fs/exfat/Kconfig
create mode 100644 fs/exfat/Makefile
create mode 100644 fs/exfat/bitmap.c
create mode 100644 fs/exfat/cache.c
create mode 100644 fs/exfat/debug.h
create mode 100644 fs/exfat/dir.c
create mode 100644 fs/exfat/exfat.h
create mode 100644 fs/exfat/exfat_fs.h
create mode 100644 fs/exfat/fatent.c
create mode 100644 fs/exfat/file.c
create mode 100644 fs/exfat/inode.c
create mode 100644 fs/exfat/namei.c
create mode 100644 fs/exfat/super.c
create mode 100644 fs/exfat/upcase.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 62b61b4fe30a..f1299dabe58e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6162,6 +6162,12 @@ M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
S:	Maintained
F:	drivers/staging/exfat/

+EXFAT READ-ONLY FILESYSTEM
+M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
+W:	http://www.paragon-software.com/
+S:	Maintained
+F:	fs/exfat/
+
EXT2 FILE SYSTEM
M:	Jan Kara <jack@suse.com>
L:	linux-ext4@vger.kernel.org
diff --git a/fs/Kconfig b/fs/Kconfig
index 2501e6f1f965..e0693092f331 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -139,10 +139,11 @@ endmenu
endif # BLOCK

if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/exFAT/NT Filesystems"

source "fs/fat/Kconfig"
source "fs/ntfs/Kconfig"
+source "fs/exfat/Kconfig"

endmenu
endif # BLOCK
diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..da360dc15357
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config EXFAT_RO_FS
+	tristate "exFAT fs support read only"
+	default n
+	select NLS
+	help
+	  exFAT file system implementation based on the specification
+	  <https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specificat=
ion>
+	  If you say Y here, you will be able to mount exFAT volumes.
+	  Currently Read-Only support is available. Write support will be added s=
oon.
+
+config EXFAT_RO_FS_DEFAULT_CODEPAGE
+	int "Default codepage for exFAT"
+	depends on EXFAT_RO_FS
+	default 437
+	help
+	  This option should be set to the codepage of your exFAT filesystems.
+	  It can be overridden with the "codepage" mount option.
+
+config EXFAT_RO_FS_DEFAULT_UTF8
+	bool "Enable exFAT UTF-8 option by default"
+	depends on EXFAT_RO_FS
+	default n
+	help
+	  Set this if you would like to have "utf8" mount option set
+	  by default when mounting exFAT filesystems.
+
+	  Even if you say Y here can always disable UTF-8 for
+	  particular mount by adding "utf8=3D0" to mount options.
+
+	  Say Y if you use UTF-8 encoding for file names, N otherwise.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..39f0f75e790e
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux exfat filesystem support.
+#
+
+obj-$(CONFIG_EXFAT_RO_FS) +=3D exfat.o
+
+exfat-objs :=3D super.o bitmap.o upcase.o file.o fatent.o inode.o \
+		namei.o cache.o dir.o
diff --git a/fs/exfat/bitmap.c b/fs/exfat/bitmap.c
new file mode 100644
index 000000000000..67b0dd499eb2
--- /dev/null
+++ b/fs/exfat/bitmap.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/bitmap.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+#define BITS_IN_SIZE_T (sizeof(size_t) * 8)
+#define MINUS_ONE_T ((size_t)(-1))
+
+/* scan bitmap pages, lcn - zero based */
+static int exfat_scan_bitmap(struct super_block *sb, u32 lcn, u32 len,
+			     int (*func)(struct super_block *sb,
+					 struct page *page, u32 bit0, u32 bits,
+					 void *arg),
+			     void *arg)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *inode =3D sbi->bitmap_inode;
+	u32 end =3D lcn + len;
+	u32 index_end =3D (((lcn + len) >> 3) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int err =3D 0;
+	u32 index;
+
+	for (index =3D lcn >> (3 + PAGE_SHIFT); index < index_end; index++) {
+		u32 next =3D (index + 1) << PAGE_SHIFT;
+		struct page *page =3D
+			read_mapping_page(inode->i_mapping, index, NULL);
+		if (IS_ERR(page)) {
+			err =3D PTR_ERR(page);
+			goto out;
+		}
+		kmap(page);
+		if (PageError(page)) {
+			kunmap(page);
+			put_page(page);
+			err =3D -EIO;
+			goto out;
+		}
+
+		if (next > end)
+			next =3D end;
+
+		err =3D (*func)(sb, page, lcn, next - lcn, arg);
+
+		flush_dcache_page(page);
+		kunmap(page);
+		put_page(page);
+
+		if (err =3D=3D 1) {
+			err =3D 0; /* 1 means stop scanning */
+			goto out;
+		}
+
+		if (err)
+			goto out;
+
+		if (next >=3D end)
+			goto out;
+
+		lcn =3D next;
+	}
+
+out:
+	return err;
+}
+
+static int exfat_on_get_used(struct super_block *sb, struct page *page,
+			     u32 bit0, u32 bits, void *arg)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	const unsigned long *wnd =3D page_address(page);
+	u32 used =3D __bitmap_weight(wnd, bits);
+
+	if (sbi->first_free_cluster =3D=3D ~0u && used < bits) {
+		u32 i, bit =3D bit0 & (PAGE_SIZE * 8 - 1);
+
+		bit0 &=3D ~(PAGE_SIZE * 8 - 1);
+		for (i =3D 0; i < bits; i++, bit++) {
+			if (!test_bit(bit, wnd)) {
+				sbi->first_free_cluster =3D bit + bit0;
+				break;
+			}
+		}
+	}
+
+	(*(u32 *)arg) +=3D used;
+	return 0;
+}
+
+int exfat_count_free_clusters(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	int err =3D 0;
+	u32 used =3D 0;
+
+	lock_exfat(sbi);
+
+	if (~0 =3D=3D sbi->free_clusters) {
+		err =3D exfat_scan_bitmap(sb, 0, sbi->clusters,
+					&exfat_on_get_used, &used);
+		if (!err)
+			sbi->free_clusters =3D sbi->clusters - used;
+	}
+
+	unlock_exfat(sbi);
+	return err;
+}
diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
new file mode 100644
index 000000000000..05b3f718c1fa
--- /dev/null
+++ b/fs/exfat/cache.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/cache.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/fs.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+struct exfat_run_rb {
+	struct rb_node rb_node;
+	u32 vcn; /* virtual cluster number */
+	u32 len; /* length of extent in clusters */
+	u32 lcn; /* logical cluster number */
+};
+
+static struct kmem_cache *exfat_run_cachep;
+
+int __init exfat_run_cache_init(void)
+{
+	exfat_run_cachep =3D kmem_cache_create("exfat_run_cache",
+					     sizeof(struct exfat_run_rb), 0,
+					     SLAB_RECLAIM_ACCOUNT, NULL);
+	return exfat_run_cachep ? 0 : -ENOMEM;
+}
+
+void exfat_run_cache_exit(void)
+{
+	kmem_cache_destroy(exfat_run_cachep);
+}
+
+static inline struct exfat_run_rb *run_tree_search(struct rb_root *root,
+						   u32 vcn)
+{
+	struct rb_node *node =3D root->rb_node;
+	struct exfat_run_rb *er =3D NULL;
+
+	while (node) {
+		er =3D rb_entry(node, struct exfat_run_rb, rb_node);
+		if (vcn < er->vcn)
+			node =3D node->rb_left;
+		else if (vcn > (er->vcn + er->len - 1))
+			node =3D node->rb_right;
+		else
+			return er;
+	}
+
+	if (er && vcn < er->vcn)
+		return er;
+
+	if (er && vcn > (er->vcn + er->len - 1)) {
+		node =3D rb_next(&er->rb_node);
+		if (node)
+			return rb_entry(node, struct exfat_run_rb, rb_node);
+	}
+
+	return NULL;
+}
+
+static inline int can_be_merged(const struct exfat_run_rb *left,
+				const struct exfat_run_rb *right)
+{
+	return left->vcn + left->len =3D=3D right->vcn &&
+	       left->lcn + left->len =3D=3D right->lcn;
+}
+
+static inline struct exfat_run_rb *try_left(struct exfat_runs_tree *tree,
+					    struct exfat_run_rb *er)
+{
+	struct exfat_run_rb *left;
+	struct rb_node *node;
+
+	node =3D rb_prev(&er->rb_node);
+	if (!node)
+		return er;
+
+	left =3D rb_entry(node, struct exfat_run_rb, rb_node);
+	if (can_be_merged(left, er)) {
+		left->len +=3D er->len;
+		rb_erase(&er->rb_node, &tree->root);
+		kmem_cache_free(exfat_run_cachep, er);
+		er =3D left;
+	}
+
+	return er;
+}
+
+static struct exfat_run_rb *try_right(struct exfat_runs_tree *tree,
+				      struct exfat_run_rb *er)
+{
+	struct exfat_run_rb *right;
+	struct rb_node *node;
+
+	node =3D rb_next(&er->rb_node);
+	if (!node)
+		return er;
+
+	right =3D rb_entry(node, struct exfat_run_rb, rb_node);
+	if (can_be_merged(er, right)) {
+		er->len +=3D right->len;
+		rb_erase(node, &tree->root);
+		kmem_cache_free(exfat_run_cachep, right);
+	}
+
+	return er;
+}
+
+static int run_insert(struct exfat_runs_tree *tree,
+		      const struct exfat_run_rb *run)
+{
+	struct rb_node **p =3D &tree->root.rb_node;
+	struct rb_node *parent =3D NULL;
+	struct exfat_run_rb *er;
+
+	while (*p) {
+		parent =3D *p;
+		er =3D rb_entry(parent, struct exfat_run_rb, rb_node);
+
+		if (run->vcn < er->vcn) {
+			if (can_be_merged(run, er)) {
+				/* Run merged as left. */
+				er->vcn =3D run->vcn;
+				er->len +=3D run->len;
+				er->lcn =3D run->lcn;
+				er =3D try_left(tree, er);
+				goto out;
+			}
+
+			p =3D &(*p)->rb_left;
+		} else if (run->vcn > (er->vcn + er->len - 1)) {
+			if (can_be_merged(er, run)) {
+				/* Run merged as right.*/
+				er->len +=3D run->len;
+				er =3D try_right(tree, er);
+				goto out;
+			}
+			p =3D &(*p)->rb_right;
+		} else {
+			WARN_ON(1);
+			return -ENOENT;
+		}
+	}
+
+	er =3D kmem_cache_alloc(exfat_run_cachep, GFP_ATOMIC);
+	if (!er)
+		return -ENOMEM;
+
+	er->vcn =3D run->vcn;
+	er->len =3D run->len;
+	er->lcn =3D run->lcn;
+
+	rb_link_node(&er->rb_node, parent, p);
+	rb_insert_color(&er->rb_node, &tree->root);
+
+out:
+	tree->cache_er =3D er;
+	return 0;
+}
+
+/* remove range [vcn end] */
+static int run_remove_from_to(struct exfat_runs_tree *tree, u32 vcn, u32 e=
nd)
+{
+	struct rb_node *node;
+	struct exfat_run_rb *er;
+	struct exfat_run_rb orig_er;
+	u32 len1, len2;
+	int err;
+
+	er =3D run_tree_search(&tree->root, vcn);
+	if (!er)
+		return 0;
+
+	if (er->vcn > end)
+		return 0;
+
+	tree->cache_er =3D NULL;
+
+	orig_er.vcn =3D er->vcn;
+	orig_er.len =3D er->len;
+	orig_er.lcn =3D er->lcn;
+
+	len1 =3D vcn > er->vcn ? vcn - er->vcn : 0;
+	len2 =3D (er->vcn + er->len - 1) > end ? (er->vcn + er->len - 1) - end :
+					       0;
+	if (len1 > 0)
+		er->len =3D len1;
+	if (len2 > 0) {
+		if (len1 > 0) {
+			struct exfat_run_rb run;
+
+			run.vcn =3D end + 1;
+			run.len =3D len2;
+			run.lcn =3D orig_er.lcn + orig_er.len - len2;
+			err =3D run_insert(tree, &run);
+			if (err) {
+				er->vcn =3D orig_er.vcn;
+				er->len =3D orig_er.len;
+			}
+			return err;
+
+		} else {
+			er->vcn =3D end + 1;
+			er->len =3D len2;
+			er->lcn =3D orig_er.lcn + orig_er.len - len2;
+			return 0;
+		}
+	}
+
+	err =3D 0;
+	if (len1 > 0) {
+		node =3D rb_next(&er->rb_node);
+		if (node)
+			er =3D rb_entry(node, struct exfat_run_rb, rb_node);
+		else
+			er =3D NULL;
+	}
+
+	while (er && (er->vcn + er->len - 1) <=3D end) {
+		node =3D rb_next(&er->rb_node);
+		rb_erase(&er->rb_node, &tree->root);
+		kmem_cache_free(exfat_run_cachep, er);
+		if (!node) {
+			er =3D NULL;
+			break;
+		}
+		er =3D rb_entry(node, struct exfat_run_rb, rb_node);
+	}
+	if (er && er->vcn < end + 1) {
+		u32 orig_len =3D er->len;
+
+		len1 =3D (er->vcn + er->len - 1) - end;
+		er->vcn =3D end + 1;
+		er->len =3D len1;
+		er->lcn =3D er->lcn + orig_len - len1;
+	}
+
+	return err;
+}
+
+static int exfat_tree_insert_run(struct exfat_runs_tree *tree, u32 vcn, u3=
2 lcn,
+				 u32 len)
+{
+	u32 end;
+	int err;
+	struct exfat_run_rb run;
+
+	WARN_ON(!len);
+	if (!len)
+		return 0;
+
+	end =3D vcn + len - 1;
+	WARN_ON(end < vcn);
+	run.vcn =3D vcn;
+	run.len =3D len;
+	run.lcn =3D lcn;
+
+	err =3D run_remove_from_to(tree, vcn, end);
+	if (!err)
+		err =3D run_insert(tree, &run);
+
+	return err;
+}
+
+/* adds run to an inode's run's tree.*/
+int exfat_insert_run(struct inode *inode, u32 vcn, u32 lcn, u32 len)
+{
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	struct exfat_runs_tree *tree =3D &ei->i_runs_tree;
+	int err;
+
+	write_lock(&ei->i_run_lock);
+
+	err =3D exfat_tree_insert_run(tree, vcn, lcn, len);
+
+	write_unlock(&ei->i_run_lock);
+
+	return err;
+}
+
+/* remove a run from a run tree */
+int exfat_remove_run(struct inode *inode, u32 vcn)
+{
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	int err;
+
+	write_lock(&ei->i_run_lock);
+	err =3D run_remove_from_to(&ei->i_runs_tree, vcn, ~0u);
+	write_unlock(&ei->i_run_lock);
+
+	return err;
+}
+
+static bool lookup_run(struct inode *inode, u32 vcn, struct exfat_run_rb *=
er)
+{
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	struct exfat_runs_tree *tree =3D &ei->i_runs_tree;
+	struct exfat_run_rb *er1 =3D NULL;
+	struct rb_node *node;
+	bool found =3D false;
+
+	read_lock(&ei->i_run_lock);
+
+	/* check cache */
+	if (tree->cache_er) {
+		er1 =3D tree->cache_er;
+		if (vcn >=3D er1->vcn && vcn <=3D er1->vcn + er1->len - 1) {
+			found =3D true;
+			goto out;
+		}
+	}
+
+	node =3D tree->root.rb_node;
+	while (node) {
+		er1 =3D rb_entry(node, struct exfat_run_rb, rb_node);
+		if (vcn < er1->vcn)
+			node =3D node->rb_left;
+		else if (vcn > (er1->vcn + er1->len - 1))
+			node =3D node->rb_right;
+		else {
+			found =3D true;
+			break;
+		}
+	}
+
+out:
+	if (found) {
+		er->vcn =3D er1->vcn;
+		er->len =3D er1->len;
+		er->lcn =3D er1->lcn;
+	}
+
+	read_unlock(&ei->i_run_lock);
+
+	return found;
+}
+
+/* Translate virtual cluster number into logical cluster number */
+int exfat_vcn_to_lcn(struct inode *inode, u32 vcn, u32 *len, u32 *lcn)
+{
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	struct exfat_run_rb er;
+	u32 dlen;
+	int err;
+
+	read_lock(&ei->i_run_lock);
+	err =3D !ei->i_runs_tree.root.rb_node && inode->i_blocks;
+	read_unlock(&ei->i_run_lock);
+
+	if (err) {
+		/* tree is not loaded yet */
+		err =3D exfat_load_runs(inode, NULL);
+		if (err)
+			return err;
+	}
+
+	if (!lookup_run(inode, vcn, &er))
+		return -ENOENT;
+
+	dlen =3D vcn - er.vcn;
+	WARN_ON(vcn < er.vcn);
+	*lcn =3D er.lcn + dlen;
+	*len =3D er.len - dlen;
+	return 0;
+}
+
+/* translates virtual byte offset into physical byte offset */
+int exfat_vbo_to_pbo(struct inode *inode, u64 vbo, u64 *pbo, u64 *bytes)
+{
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	u32 vcn =3D vbo >> sbi->cluster_bits;
+	u32 offset =3D vbo & sbi->cluster_mask;
+	u32 len, lcn;
+	int err;
+
+	err =3D exfat_vcn_to_lcn(inode, vcn, &len, &lcn);
+	if (err)
+		return err;
+
+	if (lcn =3D=3D EXFAT_CLUSTER_EOF) {
+		exfat_fs_error(sb, "r=3D%lx: vcn=3D%x beyond EOF", inode->i_ino,
+			       vcn);
+		return -ENOENT;
+	}
+
+	*pbo =3D exfat_lcn_to_pbo(sbi, lcn) + offset;
+	*bytes =3D ((u64)len << sbi->cluster_bits) - offset;
+
+	return 0;
+}
+
+/*fills run's tree*/
+int exfat_load_runs(struct inode *inode, u32 *len)
+{
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	u32 vcn, next_lcn, tmp;
+	u32 uninitialized_var(flcn), uninitialized_var(fvcn), flen =3D 0;
+	u32 lcn =3D ei->i_lcn0;
+	int err;
+	struct exfat_entry exfat_entry;
+	u32 alen =3D inode->i_blocks >> (sbi->cluster_bits - 9);
+
+	if (!len)
+		len =3D &tmp;
+
+	if (ei->i_runs_tree.root.rb_node) {
+		*len =3D alen;
+		return 0;
+	}
+
+	if (FlagOn(ei->i_stream_flags, ENTRY_FLAG_CONTINUES)) {
+		WARN_ON(inode->i_ino =3D=3D EXFAT_ROOT_INO);
+		err =3D exfat_insert_run(inode, 0, lcn, alen);
+		if (err)
+			return err;
+
+		*len =3D alen;
+		return 0;
+	}
+
+	exfat_entry_init(&exfat_entry);
+
+	for (vcn =3D 0;; vcn++, lcn =3D next_lcn) {
+		if (lcn =3D=3D EXFAT_CLUSTER_EOF) {
+			*len =3D vcn;
+			err =3D 0;
+			break;
+		}
+
+		if (vcn > sbi->clusters) {
+			exfat_fs_error_ratelimit(
+				sb, "detected the cluster chain loop, pos %llx",
+				ei->i_pos[0]);
+			err =3D -ENOENT;
+			break;
+		}
+
+		err =3D exfat_fat_get(sb, &exfat_entry, lcn, &next_lcn);
+		if (err)
+			break;
+
+		if (next_lcn =3D=3D EXFAT_CLUSTER_FREE) {
+			exfat_fs_error_ratelimit(
+				sb, "invalid cluster chain, pos %llx",
+				ei->i_pos[0]);
+			err =3D -ENOENT;
+			break;
+		}
+
+		if (!flen) {
+			fvcn =3D vcn;
+			flen =3D 1;
+			flcn =3D lcn;
+		} else if (lcn =3D=3D flcn + flen) {
+			flen +=3D 1;
+		} else {
+			err =3D exfat_insert_run(inode, fvcn, flcn, flen);
+			if (err) {
+				flen =3D 0;
+				WARN_ON(-ENOENT !=3D err && -ENOMEM !=3D err);
+				break;
+			}
+			fvcn =3D vcn;
+			flen =3D 1;
+			flcn =3D lcn;
+		}
+	}
+
+	/* last fragment */
+	if (flen)
+		err =3D exfat_insert_run(inode, fvcn, flcn, flen);
+
+	exfat_entry_end(&exfat_entry);
+
+	return err;
+}
diff --git a/fs/exfat/debug.h b/fs/exfat/debug.h
new file mode 100644
index 000000000000..87ce3d210a70
--- /dev/null
+++ b/fs/exfat/debug.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/exfat/debug.h
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ * useful functions for debuging
+ */
+
+#include <linux/slab.h>
+
+#define SetFlag(flags, single_flag) (flags |=3D (single_flag))
+#define ClearFlag(flags, single_flag) (flags &=3D ~(single_flag))
+#define FlagOn(flags, single_flag) (0 !=3D ((flags) & (single_flag)))
+
+#ifndef Add2Ptr
+#define Add2Ptr(P, I) ((u8 *)(P) + (I))
+#define PtrOffset(B, O) ((size_t)((size_t)(O) - (size_t)(B)))
+#endif
+
+#ifndef QuadAlign
+#define QuadAlign(n) (((n) + 7u) & (~7u))
+#define IsQuadAligned(n) (0 =3D=3D ((size_t)(n)&7u))
+#define Quad2Align(n) (((n) + 15u) & (~15u))
+#define IsQuad2Aligned(n) (0 =3D=3D ((size_t)(n)&15u))
+#define Quad4Align(n) (((n) + 31u) & (~31u))
+#define IsSizeTAligned(n) (0 =3D=3D ((size_t)(n) & (sizeof(size_t) - 1)))
+#define DwordAlign(n) (((n) + 3u) & (~3u))
+#define IsDwordAligned(n) (0 =3D=3D ((size_t)(n)&3u))
+#define WordAlign(n) (((n) + 1u) & (~1u))
+#define IsWordAligned(n) (0 =3D=3D ((size_t)(n)&1u))
+#endif
+
+#define exfat_trace(sb, fmt, args...)                                     =
     \
+	__exfat_trace(sb, KERN_NOTICE, fmt, ##args)
+__printf(3, 4) void __exfat_trace(const struct super_block *sb,
+				  const char *level, const char *fmt, ...);
+#define exfat_warning(sb, fmt, args...)                                   =
     \
+	__exfat_trace(sb, KERN_WARNING, fmt, ##args)
+
+void exfat_dump_mem(const void *Mem, size_t nBytes);
+
+#define exfat_fs_error(sb, fmt, args...) __exfat_fs_error(sb, 1, fmt, ##ar=
gs)
+void __exfat_fs_error(struct super_block *sb, int report, const char *fmt,=
 ...);
+
+#define exfat_trace_ratelimit(sb, level, fmt, args...)                    =
     \
+	do {                                                                   \
+		if (__ratelimit(&exfat_sb(sb)->ratelimit))                     \
+			__exfat_trace(sb, level, fmt, ##args);                 \
+	} while (0)
+
+#define exfat_fs_error_ratelimit(sb, fmt, args...)                        =
     \
+	__exfat_fs_error(sb, __ratelimit(&exfat_sb(sb)->ratelimit), fmt, ##args)
+
+static inline void *exfat_heap_alloc(unsigned long size, int zero)
+{
+	void *ptr =3D kmalloc(size, zero ? (GFP_NOFS | __GFP_ZERO) : GFP_NOFS);
+
+	WARN_ON(!ptr);
+	return ptr;
+}
+
+static inline void exfat_heap_free(void *p)
+{
+	if (!p)
+		return;
+	WARN_ON((size_t)p >=3D VMALLOC_START && (size_t)p < VMALLOC_END);
+	kfree(p);
+}
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
new file mode 100644
index 000000000000..2ce093a8ccc1
--- /dev/null
+++ b/fs/exfat/dir.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/dir.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ *  directory handling functions for exfat-based filesystems
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/iversion.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+static inline u64 exfat_make_i_pos(struct super_block *sb,
+				   struct buffer_head *bh,
+				   const union exfat_direntry *de)
+{
+	return ((u64)bh->b_blocknr << sb->s_blocksize_bits) +
+	       PtrOffset(bh->b_data, de);
+}
+
+static inline int exfat_get_entry(struct inode *dir, u32 *vbo,
+				  struct buffer_head **bh,
+				  union exfat_direntry **de)
+{
+	struct super_block *sb =3D dir->i_sb;
+	struct buffer_head *b =3D *bh;
+	union exfat_direntry *d =3D *de;
+	struct blk_plug plug;
+	u64 pbo, bytes;
+	int err;
+	sector_t i, pbn, pbn_end;
+
+	if (b && d) {
+		size_t off =3D PtrOffset(b->b_data, d);
+
+		if (off + sizeof(union exfat_direntry) < sb->s_blocksize) {
+			*vbo +=3D sizeof(union exfat_direntry);
+			*de =3D d + 1;
+			return 0;
+		}
+		WARN_ON(*vbo & (sb->s_blocksize - 1));
+	}
+
+	brelse(b);
+	*bh =3D NULL;
+
+	if (*vbo >=3D exfat_i(dir)->i_valid)
+		return -ENOENT;
+
+	err =3D exfat_vbo_to_pbo(dir, *vbo, &pbo, &bytes);
+	if (err)
+		return err;
+
+	pbn =3D pbo >> sb->s_blocksize_bits;
+	pbn_end =3D (pbo + bytes) >> sb->s_blocksize_bits;
+
+	blk_start_plug(&plug);
+	for (i =3D pbn; i < pbn_end; i++)
+		sb_breadahead(sb, i);
+	blk_finish_plug(&plug);
+
+	b =3D exfat_bread(sb, pbn);
+	if (!b)
+		return -EIO;
+
+	*de =3D (union exfat_direntry *)(b->b_data +
+				       (*vbo & (sb->s_blocksize - 1)));
+	*vbo +=3D sizeof(union exfat_direntry);
+	*bh =3D b;
+
+	return 0;
+}
+
+/*
+ * Convert little endian Unicode 16 to UTF-8.
+ */
+static inline int exfat_uni_to_x8(struct super_block *sb, const __le16 *un=
i,
+				  u8 *buf, int len)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	const __le16 *ip;
+	u8 *op;
+	struct nls_table *nls;
+
+	if (sbi->options.utf8)
+		return utf16s_to_utf8s(uni, MAX_EXFAT_FILENAME,
+				       UTF16_LITTLE_ENDIAN, buf, len);
+
+	ip =3D uni;
+	op =3D buf;
+	nls =3D sbi->nls;
+
+	while (*ip && ((len - NLS_MAX_CHARSET_SIZE) > 0)) {
+		u16 ec =3D le16_to_cpu(*ip++);
+		int charlen =3D nls->uni2char(ec, op, NLS_MAX_CHARSET_SIZE);
+
+		if (charlen > 0) {
+			op +=3D charlen;
+			len -=3D charlen;
+		} else {
+			if (sbi->options.unicode_xlate) {
+				*op++ =3D ':';
+				op =3D hex_byte_pack(op, ec >> 8);
+				op =3D hex_byte_pack(op, ec);
+				len -=3D 5;
+			} else {
+				*op++ =3D '?';
+				len--;
+			}
+		}
+	}
+
+	if (unlikely(*ip))
+		exfat_warning(sb, "filename was truncated while converting.");
+
+	*op =3D 0;
+	return op - buf;
+}
+
+static int exfat_get_name(struct inode *dir, u32 *vbo, struct buffer_head =
**bh,
+			  union exfat_direntry **de, __le16 **unicode,
+			  u8 name_len, struct exfat_slot_info *sinfo)
+{
+	__le16 *p =3D *unicode;
+	u32 len;
+	union exfat_direntry *n;
+
+	if (!p) {
+		*unicode =3D p =3D __getname();
+		if (!p) {
+			brelse(*bh);
+			*bh =3D NULL;
+			return -ENOMEM;
+		}
+	}
+	for (;;) {
+		int err =3D exfat_get_entry(dir, vbo, bh, de);
+
+		if (err)
+			return err;
+
+		n =3D *de;
+
+		if (n->type !=3D ENTRY_TYPE_NAME)
+			return -ENOENT;
+
+		if (sinfo) {
+			struct buffer_head **sbh =3D &sinfo->bh[sinfo->nbh];
+
+			WARN_ON(sinfo->nbh < 1);
+			if (sbh[-1] !=3D *bh) {
+				WARN_ON(sinfo->nbh >=3D ARRAY_SIZE(sinfo->bh));
+				sinfo->pos[sinfo->nbh] =3D
+					exfat_make_i_pos(dir->i_sb, *bh, *de);
+				brelse(*sbh);
+				*sbh =3D *bh;
+				get_bh(*bh);
+				sinfo->nbh +=3D 1;
+			}
+		}
+
+		// little endian unicode string
+		len =3D min_t(unsigned int, name_len, ARRAY_SIZE(n->name.name));
+		memcpy(p, n->name.name, len * sizeof(*p));
+		p +=3D len;
+
+		name_len -=3D len;
+		if (!name_len)
+			break;
+	}
+
+	*p =3D 0;
+	return 0;
+}
+
+/* Converts the specified Unicode character to uppercase*/
+/* It uses the uncompressed form of upcase_tbl */
+static inline u16 upcase_unicode_char(const u16 *upcase_tbl, u16 chr)
+{
+	if (chr < 'a')
+		return chr;
+
+	if (chr <=3D 'z')
+		return (u16)(chr - ('a' - 'A'));
+
+	return upcase_tbl[chr];
+}
+
+/* Calculates hame hash */
+u16 exfat_name_hash(const __le16 *name, u32 len, const u16 *upcase_tbl)
+{
+	u16 hash =3D 0;
+
+	while (len--) {
+		u16 upc =3D upcase_unicode_char(upcase_tbl, le16_to_cpu(*name++));
+
+		hash =3D exfat_check_sum_16(exfat_check_sum_16(hash, (u8)upc),
+					  (u8)(upc >> 8));
+	}
+
+	return hash;
+}
+
+/* helper function */
+int exfat_search(struct inode *dir, const struct qstr *name,
+		 struct exfat_slot_info *sinfo)
+{
+	struct super_block *sb =3D dir->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(dir);
+	struct buffer_head *bh =3D NULL;
+	union exfat_direntry *de =3D NULL;
+	u32 vbo =3D 0;
+	__le16 *ondisk_name =3D __getname();
+	__le16 *uname =3D ondisk_name + MAX_EXFAT_FILENAME + 1;
+	u8 ondisk_len;
+	int err, ulen;
+	__le16 hash;
+
+	memset(sinfo, 0, sizeof(*sinfo)); /* TODO: reduce initialization*/
+
+	if (!ondisk_name)
+		return -ENOMEM;
+
+	/* Convert input string to little endian unicode */
+	err =3D xlate_to_uni(name->name, name->len, uname, 1, sbi->options.utf8,
+			   sbi->nls);
+	if (err < 0)
+		goto out;
+	ulen =3D err;
+
+	hash =3D cpu_to_le16(exfat_name_hash(uname, ulen, sbi->upcase_tbl));
+
+	for (;;) {
+		err =3D exfat_get_entry(dir, &vbo, &bh, &de);
+		if (err)
+			break;
+
+		if (de->type =3D=3D ENTRY_TYPE_NEVER_USED) {
+			err =3D -ENOENT;
+			break;
+		}
+
+		if (de->type !=3D ENTRY_TYPE_NORMAL)
+			continue;
+
+		if (de->norm.subentries < 1 ||
+		    de->norm.subentries > MAX_SUBENTRIES_PER_NAME) {
+			exfat_fs_error_ratelimit(
+				sb,
+				"incorrect number of subentries %u in dir %llx",
+				ei->i_pos[0]);
+			continue;
+		}
+
+		/* save position of normal entry*/
+		sinfo->vbo =3D vbo - sizeof(union exfat_direntry);
+		sinfo->pos[0] =3D exfat_make_i_pos(sb, bh, de);
+		sinfo->de_norm =3D de;
+		sinfo->nr_slots =3D de->norm.subentries + 1;
+		sinfo->slots_norm =3D
+			(sb->s_blocksize - PtrOffset(bh->b_data, de)) >>
+			EXFAT_LOG2_ENTRY;
+		brelse(sinfo->bh[0]);
+		sinfo->bh[0] =3D bh;
+		get_bh(bh);
+		sinfo->nbh =3D 1;
+
+		err =3D exfat_get_entry(dir, &vbo, &bh, &de);
+		if (err)
+			break;
+
+		if (de->type !=3D ENTRY_TYPE_STREAM) {
+			exfat_fs_error_ratelimit(
+				sb, "there is no expected stream in dir %llx",
+				ei->i_pos[0]);
+			continue;
+		}
+
+		if (de->stream.namehash !=3D hash)
+			continue;
+
+		ondisk_len =3D de->stream.namelen;
+		if (ondisk_len !=3D ulen)
+			continue;
+
+		/* save position*/
+		if (bh !=3D sinfo->bh[0]) {
+			sinfo->pos[1] =3D exfat_make_i_pos(sb, bh, de);
+			brelse(sinfo->bh[1]);
+			sinfo->bh[1] =3D bh;
+			get_bh(bh);
+			sinfo->nbh =3D 2;
+		}
+
+		err =3D exfat_get_name(dir, &vbo, &bh, &de, &ondisk_name,
+				     ondisk_len, sinfo);
+		if (err)
+			continue; /*or break?*/
+
+		/*Both 'ondisk_name' and 'uname' are little endian unicode*/
+		if (!memcmp(ondisk_name, uname, ondisk_len * sizeof(*uname)))
+			break;
+	}
+
+out:
+	if (ondisk_name)
+		__putname(ondisk_name);
+
+	if (err) {
+		brelse(sinfo->bh[0]);
+		brelse(sinfo->bh[1]);
+		brelse(sinfo->bh[2]);
+		sinfo->bh[0] =3D sinfo->bh[1] =3D sinfo->bh[2] =3D NULL;
+	}
+
+	return err;
+}
+
+/*file_operations::iterate_shared*/
+static int exfat_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct inode *dir =3D file_inode(file);
+	struct exfat_inode_info *ei =3D exfat_i(dir);
+	struct super_block *sb =3D dir->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct buffer_head *bh =3D NULL;
+	u32 vbo =3D ctx->pos;
+	__le16 *unicode =3D NULL;
+	u8 name_len =3D 0;
+	int err =3D 0;
+	u32 name_vbo;
+	union exfat_direntry *de =3D NULL;
+	u32 dtype;
+	u64 i_pos;
+	unsigned long inum;
+	char *a_name;
+	int a_name_len;
+	struct inode *tmp;
+
+	mutex_lock(&sbi->s_lock);
+
+	if (!vbo) {
+		if (!dir_emit_dots(file, ctx))
+			goto out;
+		vbo =3D 1;
+	}
+
+	if (vbo =3D=3D 1) {
+		if (!dir_emit_dots(file, ctx))
+			goto out;
+		vbo =3D 0;
+	}
+
+	if (vbo & (sizeof(union exfat_direntry) - 1)) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	for (;;) {
+		err =3D exfat_get_entry(dir, &vbo, &bh, &de);
+		if (err)
+			break;
+
+		if (de->type =3D=3D ENTRY_TYPE_NEVER_USED) {
+			err =3D -ENOENT;
+			break;
+		}
+
+		if (de->type !=3D ENTRY_TYPE_NORMAL)
+			continue;
+
+		if (de->norm.subentries < 1 ||
+		    de->norm.subentries > MAX_SUBENTRIES_PER_NAME) {
+			exfat_fs_error_ratelimit(
+				sb,
+				"incorrect number of subentries %u in dir %llx",
+				ei->i_pos[0]);
+			continue;
+		}
+
+		dtype =3D de_is_directory(de) ? DT_DIR : DT_REG;
+		name_vbo =3D vbo - sizeof(union exfat_direntry);
+		i_pos =3D exfat_make_i_pos(sb, bh, de);
+
+		err =3D exfat_get_entry(dir, &vbo, &bh, &de);
+		if (err)
+			break;
+
+		if (de->type !=3D ENTRY_TYPE_STREAM) {
+			exfat_fs_error_ratelimit(
+				sb, "there is no expected stream in dir %llx",
+				ei->i_pos[0]);
+			continue;
+		}
+
+		name_len =3D de->stream.namelen;
+
+		err =3D exfat_get_name(dir, &vbo, &bh, &de, &unicode, name_len,
+				     NULL);
+		if (err)
+			break;
+
+		if (!unicode[0]) {
+			exfat_fs_error_ratelimit(sb,
+						 "empty name in directory %llx",
+						 ei->i_pos[0]);
+			continue;
+		}
+
+		/*unicode contains little endian name*/
+		a_name =3D (char *)(unicode + MAX_EXFAT_FILENAME + 1);
+		a_name_len =3D exfat_uni_to_x8(sb, unicode, a_name,
+					     PATH_MAX - MAX_EXFAT_FILENAME);
+		if (!a_name_len) {
+			exfat_warning(sb, "Failed to convert unicode string");
+			continue;
+		}
+		tmp =3D exfat_iget(sb, i_pos);
+		if (tmp) {
+			inum =3D tmp->i_ino;
+			iput(tmp);
+		} else {
+			inum =3D iunique(sb, EXFAT_MAX_RESERVED_INO);
+		}
+
+		if (!dir_emit(ctx, a_name, a_name_len, inum, dtype)) {
+			vbo =3D name_vbo; /*next readdir starts from this name*/
+			break;
+		}
+	}
+
+	brelse(bh);
+	if (unicode)
+		__putname(unicode);
+out:
+	mutex_unlock(&sbi->s_lock);
+
+	ctx->pos =3D vbo;
+	if (-ENOENT =3D=3D err)
+		err =3D 0;
+
+	return err;
+}
+
+/* Counts the number of sub-directories of dir. */
+u32 exfat_subdirs(struct inode *dir)
+{
+	struct buffer_head *bh =3D NULL;
+	union exfat_direntry *de =3D NULL;
+	u32 vbo =3D 0;
+	u32 subdirs =3D 0;
+
+	while (!exfat_get_entry(dir, &vbo, &bh, &de) &&
+	       de->type !=3D ENTRY_TYPE_NEVER_USED) {
+		if (de->type =3D=3D ENTRY_TYPE_NORMAL && de_is_directory(de))
+			subdirs +=3D 1;
+	}
+
+	brelse(bh);
+
+	return subdirs;
+}
+
+static void exfat_load_label(struct super_block *sb, union exfat_direntry =
*de)
+{
+}
+
+static int exfat_load_bitmap(struct super_block *sb, union exfat_direntry =
*de,
+			     u64 bytes_per_bitmap)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *inode =3D sbi->bitmap_inode;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	u64 pbo, bytes;
+	int err;
+
+	inode->i_size =3D bytes_per_bitmap;
+	ei->i_valid =3D exfat_align_up(sbi, bytes_per_bitmap);
+
+	inode_set_bytes(inode, ei->i_valid);
+	ei->i_lcn0 =3D le32_to_cpu(de->bitmap.start_lcn);
+
+	err =3D exfat_load_runs(inode, NULL);
+	if (err)
+		return err;
+
+	err =3D exfat_vbo_to_pbo(inode, 0, &pbo, &bytes);
+	if (err)
+		return err;
+
+	/*readahead first fragment*/
+	exfat_page_cache_readahead(inode->i_mapping, pbo >> PAGE_SHIFT,
+				   bytes >> PAGE_SHIFT);
+	return 0;
+}
+
+/*Scans root directory and initialize necessary metafiles*/
+/*It is a part of exfat_fill_super*/
+int exfat_scan_root(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *root_inode =3D sb->s_root->d_inode;
+	struct buffer_head *bh =3D NULL;
+	union exfat_direntry *de =3D NULL;
+	u32 vbo =3D 0;
+	u32 sub_dirs_count =3D 0;
+	int err =3D 0;
+	u64 bytes_per_bitmap =3D 0;
+
+	static_assert(BOOT_FLAG_SECFAT =3D=3D ENTRY_FLAG_SECBITMAP);
+
+	sbi->label_off =3D ~0u;
+	for (;;) {
+		err =3D exfat_get_entry(root_inode, &vbo, &bh, &de);
+		if (err)
+			break;
+
+		if (de->type =3D=3D ENTRY_TYPE_NEVER_USED)
+			break;
+
+		switch (de->type) {
+		case ENTRY_TYPE_BITMAP:
+			if (FlagOn(de->bitmap.flags, ENTRY_FLAG_SECBITMAP)) {
+				exfat_trace(sb, "Only one bitmap supported");
+				err =3D -EINVAL;
+				goto out;
+			} else if (bytes_per_bitmap) {
+				exfat_trace(sb, "Two or more Bitmaps");
+				err =3D -EINVAL;
+				goto out;
+			}
+
+			bytes_per_bitmap =3D le64_to_cpu(de->bitmap.size);
+			if (bytes_per_bitmap * 8 < sbi->clusters) {
+				exfat_trace(
+					sb,
+					"Bitmap size %llx is too small to keep all clusters",
+					bytes_per_bitmap);
+				err =3D -EINVAL;
+				goto out;
+			}
+			err =3D exfat_load_bitmap(sb, de, bytes_per_bitmap);
+			if (err)
+				goto out;
+			break;
+
+		case ENTRY_TYPE_UPCASE:
+			if (sbi->upcase_tbl) {
+				exfat_trace(sb, "Two or more Upcases");
+				err =3D -EINVAL;
+				goto out;
+			}
+
+			err =3D exfat_load_upcase(sb, de, true);
+			if (err)
+				goto out;
+			WARN_ON(!sbi->upcase_tbl);
+			break;
+
+		case ENTRY_TYPE_LABEL:
+			if (~0u !=3D sbi->label_off) {
+				exfat_trace(sb, "Two or more Labels");
+				err =3D -EINVAL;
+				goto out;
+			}
+			exfat_load_label(sb, de);
+			/* Save current entry */
+			sbi->label_off =3D vbo - sizeof(union exfat_direntry);
+			break;
+
+		case ENTRY_TYPE_NORMAL:
+			if (de_is_directory(de))
+				sub_dirs_count +=3D 1;
+			break;
+		}
+	}
+	brelse(bh);
+
+	set_nlink(root_inode, sub_dirs_count + 2);
+
+	if (!sbi->upcase_tbl) {
+		exfat_trace(sb, "No upcase found in root");
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!bytes_per_bitmap) {
+		exfat_trace(sb, "No bitmap found in root");
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D exfat_count_free_clusters(sb);
+
+out:
+	return err;
+}
+
+const struct file_operations exfat_dir_operations =3D {
+	.llseek =3D generic_file_llseek,
+	.read =3D generic_read_dir,
+	.iterate_shared =3D exfat_readdir,
+};
diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
new file mode 100644
index 000000000000..395ba3b42533
--- /dev/null
+++ b/fs/exfat/exfat.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/exfat/exfat.h
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ * on-disk exfat structs
+ */
+
+#define MAIN_BOOT_SECTOR 0
+#define MAIN_EXBOOT_SECTOR 1
+#define MAIN_OEM_SECTOR 9
+#define MAIN_CHKSUM_SECTOR 11
+
+#define BACKUP_BOOT_SECTOR 12
+#define BACKUP_EXBOOT_SECTOR 13
+#define BACKUP_OEM_SECTOR 21
+#define BACKUP_CHKSUM_SECTOR 23
+
+#define SECTORS_PER_BOOT (BACKUP_CHKSUM_SECTOR + 1)
+
+/* exfat_boot.ex_flags_lo bits */
+#define BOOT_FLAG_SECFAT 0x01
+#define BOOT_FLAG_DIRTY 0x02
+#define BOOT_FLAG_BAD_BLOCKS 0x04
+
+#define ENTRY_TYPE_VALUE_MASK 0x1F
+#define ENTRY_TYPE_BENING_MASK 0x20
+#define ENTRY_TYPE_SECONDARY_MASK 0x40
+#define ENTRY_TYPE_USED_MASK 0x80
+
+#define ENTRY_TYPE_NEVER_USED 0x00
+
+#define ENTRY_TYPE_TEXPAD 0x21
+
+/* Critical primary entries */
+#define ENTRY_TYPE_BITMAP 0x81
+#define ENTRY_TYPE_UPCASE 0x82
+#define ENTRY_TYPE_LABEL 0x83
+#define ENTRY_TYPE_KEY 0x84
+#define ENTRY_TYPE_NORMAL 0x85
+#define ENTRY_TYPE_UNK_CRIT 0x86
+#define ENTRY_TYPE_MAX_CRIT 0x9f
+
+/* Benign primary entries */
+#define ENTRY_TYPE_GUID 0xA0
+#define ENTRY_TYPE_DUMMY 0xA1
+#define ENTRY_TYPE_WINCE 0xA2
+
+/* Critical secondary entries */
+#define ENTRY_TYPE_STREAM 0xC0
+#define ENTRY_TYPE_NAME 0xC1
+#define ENTRY_TYPE_WINMOB 0xC2
+#define ENTRY_TYPE_MAX_CRIT2 0xDF
+
+#define ENTRY_FLAG_ALLOCATION 1
+#define ENTRY_FLAG_CONTINUES 2
+#define ENTRY_FLAG_SECBITMAP 1
+
+/* Possible values for exfat_direntry.norm.Attributes */
+#define ENTRY_ATTR_RO 0x0001
+#define ENTRY_ATTR_HIDDEN 0x0002
+#define ENTRY_ATTR_SYS 0x0004
+#define ENTRY_ATTR_RESERVED 0x0008
+#define ENTRY_ATTR_DIR 0x0010
+#define ENTRY_ATTR_ARCH 0x0020
+
+/* exFAT boot sector (512 bytes) */
+struct exfat_boot {
+	u8 jump_code[3]; /* 0x00: Jump to boot code */
+	u8 oemid[8]; /* 0x03: "EXFAT   " */
+	u8 zero[0x35]; /* 0x0B: Must be zero */
+	__le64 partition_offset; /* 0x40: In sectors */
+	__le64 sectors_per_volume; /* 0x48: */
+	__le32 fat_lsn; /* 0x50: First FAT sector */
+	__le32 fat_len; /* 0x54: Length in sectors of FAT */
+	__le32 cluster_heap_lsn; /* 0x58: Cluster heap offset*/
+	__le32 clusters; /* 0x5c: Number of clusters in heap */
+	__le32 root_lcn; /* 0x60: First cluster of the root */
+	__le32 serial_num; /* 0x64 */
+	u8 minor; /* 0x68: */
+	u8 major; /* 0x69: */
+	u8 ex_flags_lo; /* 0x6A: BOOT_FLAG_SECFAT... */
+	u8 ex_flags_hi; /* 0x6B: always 0 */
+	u8 sector_bits; /* 0x6C: 9-12 */
+	u8 sct_per_clst_bits; /* 0x6D: 0-25 */
+	u8 fats; /* 0x6E: 1-2 */
+	u8 drive_select; /* 0x6F: 0x80 */
+	u8 percent_in_use; /* 0x70: */
+	u8 res[7]; /* 0x71: */
+	u8 code[0x186]; /* 0x78 */
+	u8 signature[2]; /* 0x1FE: Boot signature  =3D0xAA55 */
+};
+
+static_assert(sizeof(struct exfat_boot) =3D=3D 0x200);
+
+union exfat_zone {
+	u8 all;
+
+	struct {
+		signed char bias : 7; /* signed value in 15 minutes.*/
+		signed char valid : 1;
+	} zone;
+};
+
+static_assert(sizeof(union exfat_zone) =3D=3D 1);
+
+/* exFAT directory entry (32 bytes) */
+union exfat_direntry {
+	u8 type; /* 0x00:  valid if > 0x80 */
+
+	struct {
+		u8 type; /* 0x00:  85 =3D=3D ENTRY_TYPE_NORMAL */
+		u8 subentries; /* 0x01:  number of secondary entries */
+		__le16 checksum; /* 0x02:Checksum of primary+secondary entries*/
+		__le16 attributes; /* 0x04: */
+		u8 res[2]; /* 0x06: */
+		__le32 cr_time; /* 0x08:  Create time */
+		__le32 mod_time; /* 0x0C:  Modification time */
+		__le32 acc_time; /* 0x10:  Last access time */
+		/*  0-200, milliseconds over the time (in 10's of ms) */
+		u8 inc_cr_time; /* 0x14:  */
+		u8 inc_mod_time; /* 0x15:  */
+		s8 cr_time_zone; /* 0x16:  time zone */
+		s8 mod_time_zone; /* 0x17:  time zone */
+		s8 acc_time_zone; /* 0x18:  time zone */
+		u8 res2[7]; /* 0x19 */
+	} norm;
+
+	struct {
+		u8 type; /* 0x00:  C0 =3D=3D ENTRY_TYPE_STREAM */
+		u8 flags; /* 0x01: ENTRY_FLAG_ALLOCATION/ENTRY_FLAG_CONTINUES*/
+		u8 res; /* 0x02: */
+		u8 namelen; /* 0x03:  Number of unicode symbols */
+		__le16 namehash; /* 0x04:  Hash of up-cased name */
+		__le16 res2; /* 0x06: */
+		__le64 valid; /* 0x08:  Valid data length */
+		__le32 res3; /* 0x10: */
+		__le32 start_lcn; /* 0x14: */
+		__le64 size; /* 0x18: */
+	} stream;
+
+	struct {
+		u8 type; /* 0x00:  C1 =3D=3D ENTRY_TYPE_NAME */
+		u8 flags; /* 0x01: */
+		__le16 name[0xf]; /* 0x02:  Unicode name */
+	} name;
+
+	struct {
+		u8 type; /* 0x00:  81 =3D=3D ENTRY_TYPE_BITMAP */
+		u8 flags; /* 0x01:  ENTRY_FLAG_SECBITMAP */
+		u8 res[18]; /* 0x02: */
+		__le32 start_lcn; /* 0x14: */
+		__le64 size; /* 0x18: */
+	} bitmap;
+
+	struct {
+		u8 type; /* 0x00:  82 =3D=3D ENTRY_TYPE_UPCASE */
+		u8 res[3]; /* 0x01: */
+		__le32 checksum; /* 0x04: 4-byte checksum of the up-case table*/
+		u8 res2[12]; /* 0x08: */
+		__le32 start_lcn; /* 0x14: */
+		__le64 size; /* 0x18: */
+	} upcase;
+
+	struct {
+		u8 type; /* 0x00:  83 =3D=3D ENTRY_TYPE_LABEL */
+		u8 length; /* 0x01:  number of characters <=3D 15 */
+		__le16 label[0xf]; /* 0x02:  Unicode label */
+	} label;
+};
+
+static_assert(sizeof(union exfat_direntry) =3D=3D 0x20);
+#define EXFAT_LOG2_ENTRY 5
+
+static inline bool de_is_directory(const union exfat_direntry *de)
+{
+	return FlagOn(de->norm.attributes, cpu_to_le32(ENTRY_ATTR_DIR));
+}
+
+static inline bool de_is_known_critical(const union exfat_direntry *de)
+{
+	return (de->type &
+		(ENTRY_TYPE_SECONDARY_MASK | ENTRY_TYPE_BENING_MASK)) ||
+	       de->type <=3D ENTRY_TYPE_NORMAL;
+}
+
+#define EXFAT_DEFAULT_ERASE_BLOCK_SIZE (64 * 1024)
+
+/* The size in bytes of the all the directory entries in a given directory=
 */
+/* should not exceed 256 megabytes */
+#define MAX_BYTES_PER_DIRECTORY (256 * 1024 * 1024)
+#define MAX_EXFAT_FILENAME 255
+
+/* 255 unicode symbols require 17 slots ENTRY_TYPE_NAME plus*/
+/* one ENTRY_TYPE_STREAM*/
+#define MAX_SUBENTRIES_PER_NAME                                           =
     \
+	(1 + (MAX_EXFAT_FILENAME +                                             \
+	      ARRAY_SIZE(((union exfat_direntry *)NULL)->name.name) - 1) /     \
+		     ARRAY_SIZE(((union exfat_direntry *)NULL)->name.name))
+static_assert(MAX_SUBENTRIES_PER_NAME =3D=3D 18);
+
+#define EXFAT_CLUSTER_FREE 0x00000000u
+#define EXFAT_CLUSTER_MIN 0x00000002u
+#define EXFAT_CLUSTER_MAX 0xFFFFFFF6u /* Maximum number of fat entries */
+#define EXFAT_CLUSTER_BAD 0xFFFFFFF7u
+#define EXFAT_CLUSTER_EOF 0xFFFFFFFFu
+
+#define EXFAT_CLUSTER_FIRST 2
+
+static inline u32 exfat_check_sum_32(u32 sum, u8 val)
+{
+	return (u32)(((sum << (8 * sizeof(u32) - 1)) | (sum >> 1)) + val);
+}
+
+static inline u16 exfat_check_sum_16(u16 sum, u8 val)
+{
+	return (u16)(((sum << (8 * sizeof(u16) - 1)) | (sum >> 1)) + val);
+}
+
+/* special variant for normal entries, exclude field 'checksum'*/
+static inline u16 exfat_checksum_norm_entry(const union exfat_direntry *e)
+{
+	const u8 *p =3D (u8 *)e;
+	const u8 *end =3D (u8 *)(e + 1);
+	u16 checksum =3D exfat_check_sum_16(exfat_check_sum_16(0, p[0]), p[1]);
+
+	p +=3D 4; /* Skip 'checksum' */
+
+	do
+		checksum =3D exfat_check_sum_16(checksum, *p++);
+	while (p < end);
+
+	return checksum;
+}
+
+static inline u16 exfat_checksum_entry(const union exfat_direntry *e,
+				       u16 checksum)
+{
+	const u8 *p =3D (u8 *)e;
+	const u8 *end =3D (u8 *)(e + 1);
+
+	do
+		checksum =3D exfat_check_sum_16(checksum, *p++);
+	while (p < end);
+
+	return checksum;
+}
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
new file mode 100644
index 000000000000..5f8713fe1b0c
--- /dev/null
+++ b/fs/exfat/exfat_fs.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/exfat/super.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/hash.h>
+#include <linux/nls.h>
+#include <linux/ratelimit.h>
+
+struct exfat_mount_options {
+	kuid_t fs_uid;
+	kgid_t fs_gid;
+	u16 fs_fmask;
+	u16 fs_dmask;
+	u16 codepage; /* Codepage for shortname conversions */
+	/* minutes bias=3D UTC - local time. Eastern time zone: +300, */
+	/*Paris,Berlin: -60, Moscow: -180*/
+	int bias;
+	u16 allow_utime; /* permission for setting the [am]time */
+	unsigned quiet : 1, /* set =3D fake successful chmods and chowns */
+		showexec : 1, /* set =3D only set x bit for com/exe/bat */
+		sys_immutable : 1, /* set =3D system files are immutable */
+		utf8 : 1, /* Use of UTF-8 character set (Default) */
+		/* create escape sequences for unhandled Unicode */
+		unicode_xlate : 1, flush : 1, /* write things quickly */
+		tz_set : 1, /* Filesystem timestamps' offset set */
+		discard : 1 /* Issue discard requests on deletions */
+		;
+};
+
+#define EXFAT_ROOT_INO 2
+#define EXFAT_FAT_INO (EXFAT_ROOT_INO + 1)
+#define EXFAT_BITMAP_INO (EXFAT_ROOT_INO + 2)
+#define EXFAT_MAX_RESERVED_INO (EXFAT_ROOT_INO + 3)
+
+#define EXFAT_HASH_BITS 8
+#define EXFAT_HASH_SIZE (1UL << EXFAT_HASH_BITS)
+
+//
+// Possible values for exfat_sb_info::Flags
+//
+#define EXFAT_FLAGS_BOOT1_VALID 0x00000010
+#define EXFAT_FLAGS_BOOT2_VALID 0x00000020
+
+/*
+ * EXFAT file system in-core superblock data
+ */
+
+struct exfat_sb_info {
+	struct super_block *sb;
+
+	u64 blocks_per_volume;
+
+	u32 cluster_size; // bytes per cluster
+	u32 cluster_mask; // =3D=3D cluster_size - 1
+	u32 blocksize_mask; // sb->s_blocksize - 1
+	u32 blocks_per_cluster; // cluster_size / sb->s_blocksize
+	u8 cluster_bits; // =3D=3D cluster_size =3D=3D 1 << cluster_bits
+	u32 clusters; /* Number of clusters in heap */
+	u32 serial_num;
+	u8 ex_flags;
+
+	u32 flags; /* EXFAT_FLAGS_XXX */
+
+	u64 fat0_pbo;
+	u64 bytes_per_fat;
+	u64 cluster_heap;
+	u32 label_off;
+	u16 *upcase_tbl; /* Uncompressed upcase table */
+	u32 free_clusters;
+	u32 next_cluster_to_allocate_from; /* 0 based */
+	u32 first_free_cluster; /* 0 based */
+
+	struct mutex exfat_lock;
+	struct mutex s_lock;
+	struct exfat_mount_options options;
+	struct nls_table *nls; /* Codepage used on disk */
+	struct inode *fat_inode;
+	struct inode *bitmap_inode;
+
+	struct ratelimit_state ratelimit;
+
+	spinlock_t inode_hash_lock;
+	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
+
+	u32 dirty; /* fs state before mount */
+	struct rcu_head rcu;
+};
+
+/* Translates logical cluster number to physical byte offset */
+static inline u64 exfat_lcn_to_pbo(const struct exfat_sb_info *sbi, u32 lc=
n)
+{
+	return sbi->cluster_heap + ((u64)lcn << sbi->cluster_bits);
+}
+
+/* Align up on cluster boundary */
+static inline u64 exfat_align_up(const struct exfat_sb_info *sbi, u64 size=
)
+{
+	return (size + sbi->cluster_mask) & ~((loff_t)sbi->cluster_mask);
+}
+
+static inline u32 exfat_bytes_to_cluster(const struct exfat_sb_info *sbi,
+					 u64 size)
+{
+	return (size + sbi->cluster_mask) >> sbi->cluster_bits;
+}
+
+struct exfat_run {
+	u32 vcn; /* virtual cluster number */
+	u32 len; /* length of extent in clusters */
+	u32 lcn; /* logical cluster number */
+};
+
+struct exfat_runs_tree {
+	struct rb_root root;
+	struct exfat_run_rb *cache_er; /* recently accessed extent */
+};
+
+struct dir_shared {
+	u32 unused_pos; /* first unused entry */
+};
+
+struct file_shared {
+};
+
+typedef u64 exfat_pos[3];
+
+/*
+ * EXFAT file system inode data in memory
+ */
+struct exfat_inode_info {
+	/* physical byte offset of directory entries normal + stream + names*/
+	exfat_pos i_pos;
+	loff_t i_valid; /* valid size */
+
+	u32 i_lcn0; /* first cluster or 0 */
+	u8 i_attrs; /* unused attribute bits */
+	u8 i_stream_flags; /* ENTRY_FLAG_ALLOCATION/ENTRY_FLAG_CONTINUES */
+
+	union {
+		struct dir_shared dir;
+		struct file_shared file;
+	} shared;
+
+	struct hlist_node i_exfat_hash; /* hash by i_pos */
+	struct rw_semaphore truncate_lock; /* protect bmap against truncate */
+	struct timespec64 i_crtime;
+	rwlock_t i_run_lock;
+	struct exfat_runs_tree i_runs_tree; /* i_run_lock protected */
+
+	struct inode vfs_inode;
+};
+
+struct exfat_slot_info {
+	/* physical byte offset of directory entries normal + stream + names*/
+	exfat_pos pos;
+	union exfat_direntry *de_norm;
+	struct buffer_head *bh[3];
+	u32 nbh; /* filled bh*/
+	u32 vbo;
+	/* maximum number of slots =3D=3D 19 (0x260 bytes). 3 clusters */
+	/*(512 bytes each) per normal+stream+names always store full info*/
+	u32 nr_slots; /* number of slots */
+	u32 slots_norm; /* number of slots in de_norm */
+};
+
+static inline struct exfat_sb_info *exfat_sb(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline struct exfat_inode_info *exfat_i(struct inode *inode)
+{
+	return container_of(inode, struct exfat_inode_info, vfs_inode);
+}
+
+/*
+ * If ->i_mode can't hold S_IWUGO (i.e. ENTRY_ATTR_RO), we use ->i_attrs t=
o
+ * save ENTRY_ATTR_RO instead of ->i_mode.
+ *
+ * If it's directory and !sbi->options.rodir, ENTRY_ATTR_RO isn't read-onl=
y
+ * bit, it's just used as flag for app.
+ */
+static inline int exfat_mode_can_hold_ro(struct inode *inode)
+{
+	struct exfat_sb_info *sbi =3D inode->i_sb->s_fs_info;
+	umode_t mask;
+
+	if (S_ISDIR(inode->i_mode))
+		return 0;
+
+	mask =3D ~sbi->options.fs_fmask;
+	if (!(mask & 0222))
+		return 0;
+	return 1;
+}
+
+/* Convert attribute bits and a mask to the UNIX mode. */
+static inline umode_t exfat_make_mode(struct exfat_sb_info *sbi, u8 attrs,
+				      umode_t mode)
+{
+	mode &=3D ~0222;
+
+	if (attrs & ENTRY_ATTR_DIR)
+		return (mode & ~sbi->options.fs_dmask) | S_IFDIR;
+	else
+		return (mode & ~sbi->options.fs_fmask) | S_IFREG;
+}
+
+/* Return the FAT attribute byte for this inode */
+static inline u8 exfat_make_attrs(struct inode *inode)
+{
+	u8 attrs =3D exfat_i(inode)->i_attrs;
+
+	if (S_ISDIR(inode->i_mode))
+		attrs |=3D ENTRY_ATTR_DIR;
+	if (exfat_mode_can_hold_ro(inode) && !(inode->i_mode & 0222))
+		attrs |=3D ENTRY_ATTR_RO;
+	return attrs;
+}
+
+static inline void exfat_save_attrs(struct inode *inode, u8 attrs)
+{
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+
+	if (exfat_mode_can_hold_ro(inode))
+		ei->i_attrs =3D attrs; // & ATTR_UNUSED;
+	else
+		ei->i_attrs =3D attrs & (ENTRY_ATTR_RO); // | ATTR_UNUSED
+}
+
+static inline bool exfat_valid_lcn(const struct exfat_sb_info *sbi, u32 lc=
n)
+{
+	return lcn >=3D EXFAT_CLUSTER_FIRST &&
+	       lcn < sbi->clusters + EXFAT_CLUSTER_FIRST;
+}
+
+static inline void lock_exfat(struct exfat_sb_info *sbi)
+{
+	mutex_lock(&sbi->exfat_lock);
+}
+
+static inline void unlock_exfat(struct exfat_sb_info *sbi)
+{
+	mutex_unlock(&sbi->exfat_lock);
+}
+
+static inline struct buffer_head *exfat_bread(struct super_block *sb,
+					      sector_t block)
+{
+	struct buffer_head *bh;
+
+	WARN_ON(block >=3D exfat_sb(sb)->blocks_per_volume);
+
+	bh =3D sb_bread(sb, block);
+	if (bh)
+		return bh;
+	__exfat_trace(sb, KERN_ERR, "failed to read volume at offset 0x%llx",
+		      (u64)block << sb->s_blocksize_bits);
+	return NULL;
+}
+
+/* globals from dir.c */
+u16 exfat_name_hash(const u16 *Name, u32 Len, const u16 *upcase_tbl);
+u32 exfat_subdirs(struct inode *dir);
+bool exfat_dir_empty(struct inode *dir);
+int exfat_scan_root(struct super_block *sb);
+int exfat_remove_entries(struct inode *dir,
+			 const struct exfat_slot_info *sinfo);
+int exfat_add_entries(struct inode *dir, const union exfat_direntry *slots=
,
+		      u32 nr_slots, struct exfat_slot_info *sinfo);
+
+u16 exfat_name_hash(const __le16 *name, u32 len, const u16 *upcase_tbl);
+extern const struct file_operations exfat_dir_operations;
+
+/* globals from inode.c */
+int exfat_add_clusters(struct inode *inode, u32 len_to_alloc,
+		       struct exfat_run *run, u32 nr_runs);
+int exfat_free_clusters(struct inode *inode, u32 len, bool do_trim);
+int exfat_block_truncate_page(struct inode *inode, loff_t from);
+void exfat_attach(struct inode *inode, const exfat_pos i_pos);
+void exfat_detach(struct inode *inode);
+struct inode *exfat_iget(struct super_block *sb, const u64 pos);
+extern const struct address_space_operations exfat_aops;
+struct inode *exfat_build_inode(struct super_block *sb,
+				const struct exfat_slot_info *sinfo);
+void exfat_evict_inode(struct inode *inode);
+int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
+int exfat_sync_inode(struct inode *inode);
+int exfat_flush_inodes(struct super_block *sb, struct inode *i1,
+		       struct inode *i2);
+
+/* globals from cache.c*/
+int __init exfat_run_cache_init(void);
+void exfat_run_cache_exit(void);
+int exfat_insert_run(struct inode *inode, u32 vcn, u32 lcn, u32 len);
+int exfat_truncate_run(struct inode *inode, u32 vcn, bool do_trim);
+int exfat_remove_run(struct inode *inode, u32 vcn);
+/* translates virtual cluster into logical cluster*/
+int exfat_vcn_to_lcn(struct inode *inode, u32 vcn, u32 *len, u32 *lcn);
+/* translates virtual byte offset into physical byte offset */
+int exfat_vbo_to_pbo(struct inode *inode, u64 vbo, u64 *pbo, u64 *bytes);
+int exfat_load_runs(struct inode *inode, u32 *len);
+bool is_run_one_fragment(struct inode *inode);
+
+/* globals from fatent.c */
+struct exfat_entry {
+	struct page *page;
+};
+
+static inline void exfat_entry_init(struct exfat_entry *fatent)
+{
+	fatent->page =3D NULL;
+}
+
+static inline void exfat_entry_end(struct exfat_entry *fatent)
+{
+	struct page *page =3D fatent->page;
+
+	if (!page)
+		return;
+	flush_dcache_page(page);
+	kunmap(page);
+	put_page(page);
+	fatent->page =3D NULL;
+}
+
+int exfat_fat_get(struct super_block *sb, struct exfat_entry *exfat_entry,
+		  u32 lcn, u32 *next);
+int exfat_fat_set(struct super_block *sb, struct exfat_entry *exfat_entry,
+		  u32 lcn, u32 next, int wait);
+int exfat_chain_add(struct inode *inode, u32 vcn, u32 lcn, u32 len);
+
+/* globals from file.c*/
+int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int data=
sync);
+int exfat_truncate_vcn(struct inode *inode, u32 vcn);
+void exfat_truncate_blocks(struct inode *inode, loff_t offset);
+int exfat_getattr(const struct path *path, struct kstat *stat, u32 request=
_mask,
+		  u32 flags);
+int exfat_setattr(struct dentry *dentry, struct iattr *attr);
+extern const struct inode_operations exfat_file_inode_operations;
+extern const struct file_operations exfat_file_operations;
+
+/* globals from name_i.c*/
+/* Convert input string to little endian unicode */
+int xlate_to_uni(const u8 *name, u32 name_len, __le16 *unicode, bool escap=
e,
+		 bool utf8, struct nls_table *nls);
+int exfat_search(struct inode *inode, const struct qstr *name,
+		 struct exfat_slot_info *sinfo);
+extern const struct inode_operations exfat_dir_inode_operations;
+
+/* globals from super.c */
+int exfat_page_cache_readahead(struct address_space *mapping, pgoff_t offs=
et,
+			       unsigned long nr_to_read);
+int exfat_tz_bias(struct exfat_sb_info *sbi);
+void exfat_time_2unix(struct timespec64 *ts, __le32 tm, u8 inc, s8 zone,
+		      int bias_minutes);
+int exfat_tz_bias(struct exfat_sb_info *sbi);
+int exfat_update_time(struct inode *inode, struct timespec64 *now, int fla=
gs);
+int exfat_sync_bhs(struct buffer_head **bhs, u32 nr_bhs);
+void exfat_time_2unix(struct timespec64 *ts, __le32 tm, u8 inc, s8 zone,
+		      int bias_minutes);
+u32 exfat_time_to_disk(u8 *inc, const struct timespec64 *ts);
+void exfat_set_state(struct super_block *sb, u32 set, bool force);
+void exfat_truncate_time(struct inode *inode, struct timespec64 *now,
+			 u32 flags);
+
+/* globals from bitmap.c */
+int exfat_count_free_clusters(struct super_block *sb);
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
+/*lcn - 2 based*/
+int exfat_bitmap_alloc_clusters(struct super_block *sb, u32 lcn_from,
+				u32 len_to_alloc, u32 *allocated_lcn,
+				u32 *allocated_len, bool exactly);
+/*lcn - 2 based*/
+int exfat_bitmap_free_clusters(struct super_block *sb, u32 lcn, u32 len,
+			       bool do_trim);
+
+/* globals from upcase.c */
+int exfat_load_upcase(struct super_block *sb, const union exfat_direntry *=
de,
+		      bool usedefault_if_error);
+
+/* This variable is used to get the bias */
+extern struct timezone sys_tz;
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
new file mode 100644
index 000000000000..df0a7b77efe9
--- /dev/null
+++ b/fs/exfat/fatent.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/fatent.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/fs.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+static __le32 *exfat_fat_init(struct super_block *sb,
+			      struct exfat_entry *exfat_entry, u32 lcn)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	u32 index;
+	struct page *page;
+	u32 vbo;
+
+	if (!exfat_valid_lcn(sbi, lcn)) {
+		exfat_entry_end(exfat_entry);
+		exfat_fs_error(sb, "invalid access to fat table, lcn 0x%x\n)",
+			       lcn);
+		return ERR_PTR(-ENOENT);
+	}
+
+	vbo =3D lcn * sizeof(u32);
+	index =3D vbo >> PAGE_SHIFT;
+	page =3D exfat_entry->page;
+
+	if (page && page->index !=3D index) {
+		flush_dcache_page(page);
+		kunmap(page);
+		put_page(page);
+		page =3D NULL;
+	}
+
+	if (!page) {
+		page =3D read_mapping_page(sbi->fat_inode->i_mapping, index,
+					 NULL);
+
+		if (!IS_ERR(page)) {
+			kmap(page);
+			if (PageError(page)) {
+				kunmap(page);
+				put_page(page);
+				page =3D ERR_PTR(-EIO);
+			}
+		}
+
+		if (IS_ERR(page)) {
+			__exfat_trace(sb, KERN_ERR,
+				      "failed to read fat at 0x%x)", index);
+
+			return (__le32 *)page;
+		}
+
+		exfat_entry->page =3D page;
+	}
+
+	return (__le32 *)Add2Ptr(page_address(page), vbo & (PAGE_SIZE - 1));
+}
+
+int exfat_fat_get(struct super_block *sb, struct exfat_entry *exfat_entry,
+		  u32 lcn, u32 *next)
+{
+	__le32 *ptr =3D exfat_fat_init(sb, exfat_entry, lcn);
+
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+
+	*next =3D le32_to_cpu(*ptr);
+	if (*next >=3D EXFAT_CLUSTER_BAD)
+		*next =3D EXFAT_CLUSTER_EOF;
+	return 0;
+}
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
new file mode 100644
index 000000000000..d18ff563627f
--- /dev/null
+++ b/fs/exfat/file.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/file.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ *  regular file handling primitives for exfat-based filesystems
+ */
+
+#include <linux/backing-dev.h>
+#include <linux/compat.h>
+#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
+#include <linux/falloc.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+static int exfat_ioctl_get_attributes(struct inode *inode,
+				      u32 __user *user_attr)
+{
+	u32 attr;
+
+	inode_lock(inode);
+	attr =3D exfat_make_attrs(inode);
+	inode_unlock(inode);
+
+	return put_user(attr, user_attr);
+}
+
+static int exfat_ioctl_get_volume_id(struct inode *inode, u32 __user *user=
_attr)
+{
+	struct exfat_sb_info *sbi =3D inode->i_sb->s_fs_info;
+
+	return put_user(sbi->serial_num, user_attr);
+}
+
+long exfat_generic_ioctl(struct file *filp, u32 cmd, unsigned long arg)
+{
+	struct inode *inode =3D file_inode(filp);
+	u32 __user *user_attr =3D (u32 __user *)arg;
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+		return exfat_ioctl_get_attributes(inode, user_attr);
+	case FAT_IOCTL_GET_VOLUME_ID:
+		return exfat_ioctl_get_volume_id(inode, user_attr);
+	}
+	return -ENOTTY; /* Inappropriate ioctl for device */
+}
+
+#ifdef CONFIG_COMPAT
+static long exfat_generic_compat_ioctl(struct file *filp, u32 cmd,
+				       unsigned long arg)
+
+{
+	return exfat_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+// inode_operations::getattr
+int exfat_getattr(const struct path *path, struct kstat *stat, u32 request=
_mask,
+		  u32 flags)
+{
+	struct inode *inode =3D d_inode(path->dentry);
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+
+	generic_fillattr(inode, stat);
+
+	stat->result_mask |=3D STATX_BTIME;
+	stat->btime.tv_sec =3D ei->i_crtime.tv_sec;
+	stat->btime.tv_nsec =3D ei->i_crtime.tv_nsec;
+	stat->blksize =3D sbi->cluster_size;
+
+	return 0;
+}
+
+const struct inode_operations exfat_file_inode_operations =3D {
+	.getattr =3D exfat_getattr,
+};
+
+const struct file_operations exfat_file_operations =3D {
+	.llseek =3D generic_file_llseek,
+	.read_iter =3D generic_file_read_iter,
+	.mmap =3D generic_file_mmap,
+	.unlocked_ioctl =3D exfat_generic_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =3D exfat_generic_compat_ioctl,
+#endif
+	.splice_read =3D generic_file_splice_read,
+};
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
new file mode 100644
index 000000000000..949d3a1f35b4
--- /dev/null
+++ b/fs/exfat/inode.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/inode.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/mpage.h>
+#include <linux/uio.h>
+#include <linux/writeback.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+/*
+ * New exfat inode stuff. We do the following:
+ *	a) i_ino is constant and has nothing with on-disk location.
+ *	b) exfat manages its own cache of directory entries.
+ *	c) *This* cache is indexed by on-disk location.
+ *	d) inode has an associated directory entry, all right, but
+ *		it may be unhashed.
+ *	e) currently entries are stored within struct inode. That should
+ *		change.
+ *	f) we deal with races in the following way:
+ *		1. readdir() and lookup() do exfat-dir-cache lookup.
+ *		2. rename() unhashes the F-d-c entry and rehashes it in
+ *			a new place.
+ *		3. unlink() and rmdir() unhash F-d-c entry.
+ *		4. exfat_write_inode() checks whether the thing is unhashed.
+ *			If it is we silently return. If it isn't we do bread(),
+ *			check if the location is still valid and retry if it
+ *			isn't. Otherwise we do changes.
+ *		5. Spinlock is used to protect hash/unhash/location check/lookup
+ *		6. exfat_evict_inode() unhashes the F-d-c entry.
+ *		7. lookup() and readdir() do igrab() if they find a F-d-c entry
+ *			and consider negative result as cache miss.
+ */
+
+static inline unsigned long exfat_hash(const u64 pos)
+{
+#ifdef hash_64
+	return hash_64(pos >> EXFAT_LOG2_ENTRY, EXFAT_HASH_BITS);
+#else
+	return hash_32(pos >> EXFAT_LOG2_ENTRY, EXFAT_HASH_BITS);
+#endif
+}
+
+void exfat_attach(struct inode *inode, const exfat_pos i_pos)
+{
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+
+	if (inode->i_ino !=3D EXFAT_ROOT_INO) {
+		struct hlist_head *head =3D
+			sbi->inode_hashtable + exfat_hash(i_pos[0]);
+		spin_lock(&sbi->inode_hash_lock);
+		memcpy(ei->i_pos, i_pos, sizeof(exfat_pos));
+		hlist_add_head(&ei->i_exfat_hash, head);
+		spin_unlock(&sbi->inode_hash_lock);
+	}
+}
+
+void exfat_detach(struct inode *inode)
+{
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+
+	spin_lock(&sbi->inode_hash_lock);
+	memset(&ei->i_pos, 0, sizeof(ei->i_pos));
+	hlist_del_init(&ei->i_exfat_hash);
+	spin_unlock(&sbi->inode_hash_lock);
+}
+
+struct inode *exfat_iget(struct super_block *sb, const u64 pos)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct hlist_head *head =3D sbi->inode_hashtable + exfat_hash(pos);
+	struct exfat_inode_info *ei;
+	struct inode *inode =3D NULL;
+
+	spin_lock(&sbi->inode_hash_lock);
+	hlist_for_each_entry(ei, head, i_exfat_hash) {
+		WARN_ON(ei->vfs_inode.i_sb !=3D sb);
+		if (ei->i_pos[0] !=3D pos)
+			continue;
+		inode =3D igrab(&ei->vfs_inode);
+		if (inode)
+			break;
+	}
+	spin_unlock(&sbi->inode_hash_lock);
+
+	return inode;
+}
+
+static int exfat_get_block_vbo(struct inode *inode, u64 vbo,
+			       struct buffer_head *bh, int create)
+{
+	const struct super_block *sb =3D inode->i_sb;
+	const struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	u64 bytes, pbo;
+	int err;
+
+	if (create)
+		return -EROFS;
+
+	if (inode->i_ino =3D=3D EXFAT_FAT_INO) {
+		if (vbo >=3D sbi->bytes_per_fat)
+			return -EINVAL;
+		set_buffer_mapped(bh);
+		bh->b_bdev =3D sb->s_bdev;
+		bh->b_blocknr =3D (sbi->fat0_pbo + vbo) >> sb->s_blocksize_bits;
+		return 0;
+	}
+
+	if (vbo >=3D ei->i_valid)
+		return 0;
+
+	err =3D exfat_vbo_to_pbo(inode, vbo, &pbo, &bytes);
+	if (err)
+		return err;
+
+	WARN_ON(ei->i_valid & (sb->s_blocksize - 1));
+
+	if (vbo + bytes > ei->i_valid)
+		bytes =3D ei->i_valid - vbo;
+
+	set_buffer_mapped(bh);
+	bh->b_bdev =3D sb->s_bdev;
+	bh->b_blocknr =3D pbo >> sb->s_blocksize_bits;
+	if (bh->b_size > bytes)
+		bh->b_size =3D bytes;
+
+	return 0;
+}
+
+static int exfat_get_block(struct inode *inode, sector_t vbn,
+			   struct buffer_head *bh_result, int create)
+{
+	return exfat_get_block_vbo(inode, (u64)vbn << inode->i_blkbits,
+				   bh_result, create);
+}
+
+static int exfat_get_block_bmap(struct inode *inode, sector_t vsn,
+				struct buffer_head *bh_result, int create)
+{
+	return exfat_get_block_vbo(inode, (u64)vsn << 9, bh_result, create);
+}
+
+static sector_t exfat_bmap(struct address_space *mapping, sector_t block)
+{
+	sector_t blocknr;
+	struct inode *inode =3D mapping->host;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+
+	down_read(&ei->truncate_lock);
+	blocknr =3D generic_block_bmap(mapping, block, exfat_get_block_bmap);
+	up_read(&ei->truncate_lock);
+
+	return blocknr;
+}
+
+static int exfat_readpage(struct file *file, struct page *page)
+{
+	return mpage_readpage(page, exfat_get_block);
+}
+
+static int exfat_readpages(struct file *file, struct address_space *mappin=
g,
+			   struct list_head *pages, unsigned int nr_pages)
+{
+	return mpage_readpages(mapping, pages, nr_pages, exfat_get_block);
+}
+
+static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file =3D iocb->ki_filp;
+	struct address_space *mapping =3D file->f_mapping;
+	struct inode *inode =3D mapping->host;
+	ssize_t ret;
+
+	ret =3D blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
+
+	return ret;
+}
+
+/* doesn't deal with root inode */
+static int exfat_fill_inode(struct inode *inode,
+			    const struct exfat_slot_info *sinfo)
+{
+	struct super_block *sb =3D inode->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_inode_info *ei =3D exfat_i(inode);
+	int bias =3D exfat_tz_bias(sbi);
+	union exfat_direntry *de_norm =3D sinfo->de_norm;
+	u16 attr =3D le16_to_cpu(de_norm->norm.attributes);
+	u32 avail =3D sb->s_blocksize - PtrOffset(sinfo->bh[0], de_norm);
+	u64 valid;
+	union exfat_direntry *de_strm =3D
+		avail >=3D sizeof(union exfat_direntry) ?
+			(de_norm + 1) :
+			(union exfat_direntry *)sinfo->bh[1]->b_data;
+
+	memcpy(&ei->i_pos, &sinfo->pos, sizeof(ei->i_pos));
+	inode->i_uid =3D sbi->options.fs_uid;
+	inode->i_gid =3D sbi->options.fs_gid;
+	inode_inc_iversion(inode);
+	inode->i_generation =3D get_seconds();
+
+	ei->i_lcn0 =3D le32_to_cpu(de_strm->stream.start_lcn);
+	inode->i_size =3D le64_to_cpu(de_strm->stream.size);
+	inode->i_blocks =3D exfat_align_up(sbi, inode->i_size) >> 9;
+
+	ei->i_valid =3D le64_to_cpu(de_strm->stream.valid);
+	valid =3D (ei->i_valid + sb->s_blocksize - 1) & ~(sb->s_blocksize - 1);
+
+	if (ei->i_valid < inode->i_size && ei->i_valid !=3D valid) {
+		/*workaround for not aligned valid size*/
+		exfat_warning(
+			sb,
+			"You will get a garbage in file %llx in range [%llx %llx)",
+			ei->i_pos[0], ei->i_valid, valid);
+	}
+	ei->i_valid =3D valid;
+
+	ei->i_stream_flags =3D de_strm->stream.flags;
+
+	WARN_ON(inode->i_nlink !=3D 1);
+
+	if (FlagOn(attr, ENTRY_ATTR_DIR)) {
+		if (inode->i_size > MAX_BYTES_PER_DIRECTORY) {
+			exfat_fs_error(sb, "directory is to
o large %llx",
+				       inode->i_size);
+			return -EINVAL;
+		}
+		inode->i_generation &=3D ~1;
+		inode->i_mode =3D exfat_make_mode(sbi, attr, 0777);
+		inode->i_op =3D &exfat_dir_inode_operations;
+		inode->i_fop =3D &exfat_dir_operations;
+		set_nlink(inode, 2 + exfat_subdirs(inode));
+	} else {
+		inode->i_generation |=3D 1;
+		inode->i_mode =3D exfat_make_mode(sbi, attr, 0666);
+		inode->i_op =3D &exfat_file_inode_operations;
+		inode->i_fop =3D &exfat_file_operations;
+		inode->i_mapping->a_ops =3D &exfat_aops;
+	}
+
+	if (FlagOn(attr, ENTRY_ATTR_SYS) && sbi->options.sys_immutable)
+		inode->i_flags |=3D S_IMMUTABLE;
+
+	exfat_save_attrs(inode, attr);
+
+	exfat_time_2unix(&inode->i_mtime, le32_to_cpu(de_norm->norm.mod_time),
+			 de_norm->norm.inc_mod_time,
+			 de_norm->norm.mod_time_zone, bias);
+
+	inode->i_ctime =3D inode->i_mtime;
+
+	exfat_time_2unix(&inode->i_atime, le32_to_cpu(de_norm->norm.acc_time),
+			 0, de_norm->norm.acc_time_zone, bias);
+	WARN_ON(inode->i_atime.tv_nsec);
+
+	exfat_time_2unix(&ei->i_crtime, le32_to_cpu(de_norm->norm.cr_time),
+			 de_norm->norm.inc_cr_time, de_norm->norm.cr_time_zone,
+			 bias);
+	return 0;
+}
+
+struct inode *exfat_build_inode(struct super_block *sb,
+				const struct exfat_slot_info *sinfo)
+{
+	int err;
+	struct inode *inode =3D exfat_iget(sb, sinfo->pos[0]);
+
+	if (inode)
+		return inode;
+
+	inode =3D new_inode(sb);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_ino =3D iunique(sb, EXFAT_MAX_RESERVED_INO);
+	inode_set_iversion(inode, 1);
+	err =3D exfat_fill_inode(inode, sinfo);
+	if (err) {
+		iput(inode);
+		return ERR_PTR(err);
+	}
+
+	exfat_attach(inode, sinfo->pos);
+	insert_inode_hash(inode);
+
+	return inode;
+}
+
+void exfat_evict_inode(struct inode *inode)
+{
+	truncate_inode_pages_final(&inode->i_data);
+	invalidate_inode_buffers(inode);
+	clear_inode(inode);
+	exfat_remove_run(inode, 0);
+	exfat_detach(inode);
+}
+
+const struct address_space_operations exfat_aops =3D { .readpage =3D exfat=
_readpage,
+						     .readpages =3D
+							     exfat_readpages,
+						     .direct_IO =3D
+							     exfat_direct_IO,
+						     .bmap =3D exfat_bmap };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
new file mode 100644
index 000000000000..6a6a5d26bdfc
--- /dev/null
+++ b/fs/exfat/namei.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/namei.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/iversion.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+static inline unsigned long exfat_d_version(struct dentry *dentry)
+{
+	return (unsigned long)dentry->d_fsdata;
+}
+
+static inline void exfat_d_version_set(struct dentry *dentry,
+				       unsigned long version)
+{
+	dentry->d_fsdata =3D (void *)version;
+}
+
+/* returns 0 if string can be used in exFAT names */
+static inline int is_bad_uni(const __le16 *s, size_t len, bool bext)
+{
+	while (len--) {
+		u16 uc =3D le16_to_cpu(*s++);
+
+		if (uc >=3D 0x80)
+			continue;
+
+		if (!uc)
+			return -1; // 0 means 'ok'
+
+		if (uc < 0x20)
+			return uc;
+
+		switch (uc) {
+		case 0x22: // '"'
+		case 0x2A: // '*'
+		case 0x2f: // '/'
+		case 0x3a: // ':'
+		case 0x3c: // '<'
+		case 0x3e: // '>'
+		case 0x3f: // '?'
+		case 0x5c: // '\\'
+		case 0x7c: // '|'
+			return uc;
+		}
+
+		if (bext) {
+			switch (uc) {
+			case 0x2b: // '+'
+			case 0x2c: // ','
+			case 0x2e: // '.'
+			case 0x3b: // ';'
+			case 0x3d: // '=3D'
+			case 0x5b: // '['
+			case 0x5d: // ']'
+				return uc;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* Convert input string to little endian unicode */
+int xlate_to_uni(const u8 *name, u32 name_len, __le16 *unicode, bool escap=
e,
+		 bool utf8, struct nls_table *nls)
+{
+	int ret;
+	int clen;
+	const u8 *end;
+	u32 name_tail;
+
+	if (utf8) {
+		ret =3D utf8s_to_utf16s(name, name_len, UTF16_LITTLE_ENDIAN,
+				      unicode, MAX_EXFAT_FILENAME + 2);
+		if (ret < 0) {
+			WARN_ON(1);
+			return ret;
+		} else if (ret > MAX_EXFAT_FILENAME) {
+			return -ENAMETOOLONG;
+		}
+		return ret;
+	}
+
+	end =3D name + name_len;
+	for (ret =3D 0; name < end; ret +=3D 1, unicode +=3D 1, name +=3D clen) {
+		if (ret >=3D MAX_EXFAT_FILENAME)
+			return -ENAMETOOLONG;
+		name_tail =3D end - name;
+		if (escape && (*name =3D=3D ':')) {
+			u8 uc[2];
+
+			if (name_tail < 5)
+				return -EINVAL;
+
+			if (hex2bin(uc, name + 1, 2) < 0)
+				return -EINVAL;
+			*unicode =3D uc[0] << 8 | uc[1];
+			clen =3D 5;
+		} else {
+			clen =3D nls->char2uni(name, name_tail, unicode);
+			if (clen < 0)
+				return -EINVAL;
+		}
+	}
+	return ret;
+}
+
+// inode_operations::lookup
+static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentr=
y,
+				   u32 flags)
+{
+	struct super_block *sb =3D dir->i_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct exfat_slot_info sinfo;
+	struct inode *inode;
+	struct dentry *alias;
+	int err;
+
+	mutex_lock(&sbi->s_lock);
+
+	err =3D exfat_search(dir, &dentry->d_name, &sinfo);
+
+	if (err) {
+		alias =3D -ENOENT =3D=3D err ? d_splice_alias(NULL, dentry) :
+					 ERR_PTR(err);
+	} else {
+		inode =3D exfat_build_inode(sb, &sinfo);
+		brelse(sinfo.bh[0]);
+		brelse(sinfo.bh[1]);
+		brelse(sinfo.bh[2]);
+
+		alias =3D IS_ERR(inode) ? (struct dentry *)inode :
+					d_splice_alias(inode, dentry);
+	}
+
+	mutex_unlock(&sbi->s_lock);
+
+	return alias;
+}
+
+const struct inode_operations exfat_dir_inode_operations =3D {
+	.lookup =3D exfat_lookup,
+	.getattr =3D exfat_getattr,
+};
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
new file mode 100644
index 000000000000..0705dab3c3fc
--- /dev/null
+++ b/fs/exfat/super.c
@@ -0,0 +1,1145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/super.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ * TODO: prealloc, bitmap of used entries
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/module.h>
+#include <linux/parser.h> // match_table_t
+#include <linux/seq_file.h>
+#include <linux/exportfs.h>
+#include <linux/statfs.h>
+#include <linux/backing-dev.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+/**
+ * exfat_trace() - print preformated exfat specific messages. Every thing =
what
+ * is not exfat_fs_error() should be __exfat_trace().
+ */
+void __exfat_trace(const struct super_block *sb, const char *level,
+		   const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt =3D fmt;
+	vaf.va =3D &args;
+	if (!sb)
+		printk("%sexfat: %pV", level, &vaf);
+	else
+		printk("%sexfat: %s: %pV", level, sb->s_id, &vaf);
+	va_end(args);
+}
+
+void __exfat_fs_error(struct super_block *sb, int report, const char *fmt,=
 ...)
+{
+	va_list args;
+	struct va_format vaf;
+
+	if (report) {
+		va_start(args, fmt);
+		vaf.fmt =3D fmt;
+		vaf.va =3D &args;
+		__exfat_trace(sb, KERN_ERR, "error, %pV", &vaf);
+		va_end(args);
+	}
+	sb->s_flags |=3D SB_RDONLY;
+	__exfat_trace(sb, KERN_ERR, "Filesystem has been set read-only");
+}
+
+int exfat_tz_bias(struct exfat_sb_info *sbi)
+{
+	return sbi->options.tz_set ? -sbi->options.bias : sys_tz.tz_minuteswest;
+}
+
+/* Convert a exfat time/date pair to a UNIX date (seconds since 1 1 70). *=
/
+void exfat_time_2unix(struct timespec64 *ts, __le32 tm, u8 inc, s8 zone,
+		      int bias_minutes)
+{
+	ts->tv_sec =3D
+		mktime64(1980 + (tm >> 25), (tm >> 21) & 0xF, (tm >> 16) & 0x1F,
+			 (tm >> 11) & 0x1F, (tm >> 5) & 0x3F, 2 * (tm & 0x1F));
+
+	if (zone >=3D 0)
+		ts->tv_sec +=3D bias_minutes * 60; // local -> UTC
+	else if (zone & 0x7f) {
+		int zbias =3D (int)zone << 1;
+
+		zbias >>=3D 1;
+		ts->tv_sec -=3D zbias * (15 * 60);
+	} else {
+		WARN_ON((zone & 0x7f));
+	}
+
+	if (inc >=3D 100) {
+		ts->tv_sec +=3D 1;
+		inc -=3D 100;
+		WARN_ON(inc >=3D 100);
+		if (inc >=3D 100)
+			inc =3D 0;
+	}
+
+	ts->tv_nsec =3D inc * 10000000;
+}
+
+static int read_pages(struct address_space *mapping, struct list_head *pag=
es,
+		      unsigned int nr_pages, gfp_t gfp)
+{
+	struct blk_plug plug;
+	unsigned int page_idx;
+	int ret;
+
+	blk_start_plug(&plug);
+
+	if (mapping->a_ops->readpages) {
+		ret =3D mapping->a_ops->readpages(NULL, mapping, pages, nr_pages);
+		/* Clean up the remaining pages */
+		put_pages_list(pages);
+		goto out;
+	}
+
+	for (page_idx =3D 0; page_idx < nr_pages; page_idx++) {
+		struct page *page =3D lru_to_page(pages);
+
+		list_del(&page->lru);
+		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
+			mapping->a_ops->readpage(NULL, page);
+		put_page(page);
+	}
+	ret =3D 0;
+
+out:
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+/* mm/readahead.c */
+static unsigned int __exfat_page_cache_readahead(struct address_space *map=
ping,
+						 pgoff_t offset,
+						 unsigned long nr_to_read)
+{
+	struct inode *inode =3D mapping->host;
+	struct page *page;
+	unsigned long end_index; /* The last page we want to read */
+	LIST_HEAD(page_pool);
+	unsigned long page_idx;
+	unsigned int nr_pages =3D 0;
+	loff_t isize =3D i_size_read(inode);
+	gfp_t gfp_mask =3D readahead_gfp_mask(mapping);
+
+	if (!isize)
+		goto out;
+
+	end_index =3D ((isize - 1) >> PAGE_SHIFT);
+
+	/*
+	 * Preallocate as many pages as we will need.
+	 */
+	for (page_idx =3D 0; page_idx < nr_to_read; page_idx++) {
+		pgoff_t page_offset =3D offset + page_idx;
+
+		if (page_offset > end_index)
+			break;
+
+		page =3D xa_load(&mapping->i_pages, page_offset);
+		if (page && !xa_is_value(page)) {
+			/*
+			 * Page already present?  Kick off the current batch of
+			 * contiguous pages before continuing with the next
+			 * batch.
+			 */
+			if (nr_pages)
+				read_pages(mapping, &page_pool, nr_pages,
+					   gfp_mask);
+			nr_pages =3D 0;
+			continue;
+		}
+
+		page =3D __page_cache_alloc(gfp_mask);
+		if (!page)
+			break;
+		page->index =3D page_offset;
+		list_add(&page->lru, &page_pool);
+		if (page_idx =3D=3D nr_to_read)
+			SetPageReadahead(page);
+		nr_pages++;
+	}
+
+	/*
+	 * Now start the IO.  We ignore I/O errors - if the page is not
+	 * uptodate then the caller will launch readpage again, and
+	 * will then handle the error.
+	 */
+	if (nr_pages)
+		read_pages(mapping, &page_pool, nr_pages, gfp_mask);
+	WARN_ON(!list_empty(&page_pool));
+out:
+	return nr_pages;
+}
+
+int exfat_page_cache_readahead(struct address_space *mapping, pgoff_t offs=
et,
+			       unsigned long nr_to_read)
+{
+	struct inode *inode =3D mapping->host;
+	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
+	unsigned long max_pages;
+
+	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages))
+		return -EINVAL;
+
+	/*
+	 * If the request exceeds the readahead window, allow the read to
+	 * be up to the optimal hardware IO size
+	 */
+	max_pages =3D max_t(unsigned long, bdi->io_pages, 0x200);
+	nr_to_read =3D min(nr_to_read, max_pages);
+	while (nr_to_read) {
+		unsigned long this_chunk =3D (2 * 1024 * 1024) / PAGE_SIZE;
+
+		if (this_chunk > nr_to_read)
+			this_chunk =3D nr_to_read;
+		__exfat_page_cache_readahead(mapping, offset, this_chunk);
+
+		offset +=3D this_chunk;
+		nr_to_read -=3D this_chunk;
+	}
+	return 0;
+}
+
+static struct kmem_cache *exfat_inode_cachep;
+
+static struct inode *exfat_alloc_inode(struct super_block *sb)
+{
+	struct exfat_inode_info *ei =3D
+		kmem_cache_alloc(exfat_inode_cachep, GFP_NOFS);
+	if (!ei)
+		return NULL;
+
+	init_rwsem(&ei->truncate_lock);
+
+	ei->i_runs_tree.root =3D RB_ROOT;
+	ei->i_runs_tree.cache_er =3D NULL;
+
+	rwlock_init(&ei->i_run_lock);
+
+	return &ei->vfs_inode;
+}
+
+static void exfat_i_callback(struct rcu_head *head)
+{
+	struct inode *inode =3D container_of(head, struct inode, i_rcu);
+
+	kmem_cache_free(exfat_inode_cachep, exfat_i(inode));
+}
+
+static void exfat_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, exfat_i_callback);
+}
+
+static void init_once(void *foo)
+{
+	struct exfat_inode_info *ei =3D (struct exfat_inode_info *)foo;
+
+	INIT_HLIST_NODE(&ei->i_exfat_hash);
+	inode_init_once(&ei->vfs_inode);
+}
+
+static void sbi_delayed_free(struct rcu_head *p)
+{
+	struct exfat_sb_info *sbi =3D container_of(p, struct exfat_sb_info, rcu);
+
+	unload_nls(sbi->nls);
+	exfat_heap_free(sbi);
+}
+
+static void exfat_put_super(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+
+	exfat_heap_free(sbi->upcase_tbl);
+	iput(sbi->fat_inode);
+	iput(sbi->bitmap_inode);
+
+	call_rcu(&sbi->rcu, sbi_delayed_free);
+}
+
+static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb =3D dentry->d_sb;
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	u64 id =3D huge_encode_dev(sb->s_bdev->bd_dev);
+
+	/* If the count of free cluster is still unknown, counts it here. */
+	if (~0u =3D=3D sbi->free_clusters) {
+		int err =3D exfat_count_free_clusters(sb);
+
+		if (err)
+			return err;
+	}
+
+	buf->f_type =3D sb->s_magic;
+	buf->f_bsize =3D sbi->cluster_size;
+	buf->f_blocks =3D sbi->clusters;
+	buf->f_bfree =3D sbi->free_clusters;
+	buf->f_bavail =3D sbi->free_clusters;
+	buf->f_fsid.val[0] =3D (u32)id;
+	buf->f_fsid.val[1] =3D (u32)(id >> 32);
+	buf->f_namelen =3D MAX_EXFAT_FILENAME;
+
+	return 0;
+}
+
+static int exfat_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct exfat_sb_info *sbi =3D exfat_sb(root->d_sb);
+	struct exfat_mount_options *opts =3D &sbi->options;
+
+	if (!uid_eq(opts->fs_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=3D%u",
+			   from_kuid_munged(&init_user_ns, opts->fs_uid));
+	if (!gid_eq(opts->fs_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=3D%u",
+			   from_kgid_munged(&init_user_ns, opts->fs_gid));
+	seq_printf(m, ",fmask=3D%04o", opts->fs_fmask);
+	seq_printf(m, ",dmask=3D%04o", opts->fs_dmask);
+	if (opts->allow_utime)
+		seq_printf(m, ",allow_utime=3D%04o", opts->allow_utime);
+	if (sbi->nls)
+		/* strip "cp" prefix from displayed option */
+		seq_printf(m, ",codepage=3D%s", &sbi->nls->charset[2]);
+	if (opts->quiet)
+		seq_puts(m, ",quiet");
+	if (opts->showexec)
+		seq_puts(m, ",showexec");
+	if (opts->sys_immutable)
+		seq_puts(m, ",sys_immutable");
+	if (opts->flush)
+		seq_puts(m, ",flush");
+	if (opts->tz_set) {
+		if (opts->bias)
+			seq_printf(m, ",bias=3D%d", opts->bias);
+		else
+			seq_puts(m, ",tz=3DUTC");
+	}
+	if (opts->discard)
+		seq_puts(m, ",discard");
+	return 0;
+}
+
+static const struct super_operations exfat_sops =3D {
+	.alloc_inode =3D exfat_alloc_inode,
+	.destroy_inode =3D exfat_destroy_inode,
+	.evict_inode =3D exfat_evict_inode,
+	.put_super =3D exfat_put_super,
+	.statfs =3D exfat_statfs,
+	.show_options =3D exfat_show_options,
+};
+
+static struct inode *exfat_export_get_inode(struct super_block *sb, u64 in=
o,
+					    u32 generation)
+{
+	struct inode *inode =3D NULL;
+
+	if (ino < EXFAT_MAX_RESERVED_INO)
+		return inode;
+	inode =3D ilookup(sb, ino);
+
+	if (inode && generation && inode->i_generation !=3D generation) {
+		iput(inode);
+		inode =3D NULL;
+	}
+
+	return inode;
+}
+
+static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
+					 struct fid *fid, int fh_len,
+					 int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    exfat_export_get_inode);
+}
+
+static struct dentry *exfat_fh_to_parent(struct super_block *sb,
+					 struct fid *fid, int fh_len,
+					 int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    exfat_export_get_inode);
+}
+
+static const struct export_operations exfat_export_ops =3D {
+	.fh_to_dentry =3D exfat_fh_to_dentry,
+	.fh_to_parent =3D exfat_fh_to_parent,
+};
+
+/* Returns Gb,Mb to print with "%u.%02u Gb" */
+static u32 format_size_gb(const u64 Bytes, u32 *Mb)
+{
+	// Do simple right 30 bit shift of 64 bit value
+	u64 kBytes =3D Bytes >> 10;
+	u32 kBytes32 =3D (u32)kBytes;
+
+	*Mb =3D (100 * (kBytes32 & 0xfffff) + 0x7ffff) >> 20;
+	WARN_ON(*Mb > 100);
+	if (*Mb >=3D 100)
+		*Mb =3D 99;
+
+	return (kBytes32 >> 20) | (((u32)(kBytes >> 32)) << 12);
+}
+
+static const u8 s_OemGuid[] =3D {
+	0x46, 0x7e, 0x0c, 0x0a, 0x99, 0x33, 0x21, 0x40,
+	0x90, 0xc8, 0xfa, 0x6d, 0x38, 0x9c, 0x4b, 0xa2 };
+
+/* returns oem_erase_block */
+static u32 get_oem_erase_block(const void *OEMSector)
+{
+	if (!memcmp(OEMSector, s_OemGuid, 16))
+		return le32_to_cpu(*(u32 *)Add2Ptr(OEMSector, 16));
+
+	return 0;
+}
+
+/* checks boot checksum*/
+static int exfat_check_boot(struct super_block *sb, u32 bootLsn, u8 sector=
_bits,
+			    u32 *boot_check_sum, u32 *erase_block)
+{
+	u32 boot_off =3D bootLsn << sector_bits;
+	u32 bytes_per_boot =3D MAIN_CHKSUM_SECTOR << sector_bits;
+	u32 oem_off =3D (MAIN_OEM_SECTOR - MAIN_BOOT_SECTOR) << sector_bits;
+	u32 off =3D 0;
+	u32 sum =3D 0x25d7e;
+	u32 cnt =3D (bytes_per_boot + (1u << sector_bits)) >> 9;
+	u32 i;
+
+	for (; cnt; cnt -=3D 1, off +=3D 512) {
+		struct buffer_head *bh =3D
+			exfat_bread(sb, (boot_off + off) >> sector_bits);
+		if (!bh)
+			return -EIO;
+
+		if (erase_block && off =3D=3D oem_off)
+			*erase_block =3D get_oem_erase_block(bh->b_data);
+
+		if (off < bytes_per_boot) {
+			const u8 *p =3D (u8 *)bh->b_data;
+
+			i =3D 0;
+			if (!off) {
+				/* First 0x40 bytes always the same */
+				p +=3D 0x40;
+				i =3D 0x40;
+			}
+
+			for (; i < 512; i++, p++) {
+				// Skip 'ex_flags' and 'percent_in_use'
+				if (!off
+				     && (i =3D=3D 0x6a || i =3D=3D 0x6b || i =3D=3D 0x70))
+					continue;
+				sum =3D exfat_check_sum_32(sum, *p);
+			}
+		} else {
+			const __le32 *p =3D (__le32 *)bh->b_data;
+
+			if (off =3D=3D bytes_per_boot) {
+				*boot_check_sum =3D sum;
+				sum =3D cpu_to_le32(sum);
+			}
+
+			for (i =3D 0; i < 512 / sizeof(int); i++) {
+				if (sum !=3D *p++) {
+					exfat_warning(sb,
+						      "boot check sum failed");
+					brelse(bh);
+					return -EINVAL;
+				}
+			}
+		}
+
+		brelse(bh);
+	}
+
+	return 0;
+}
+
+/* inits internal info from on-disk boot sector*/
+static int exfat_init_from_boot(struct super_block *sb, struct exfat_boot =
*boot,
+				u64 bytes_per_volume, u32 *root_lcn)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct buffer_head *backup_bh =3D NULL;
+	const char *hint =3D NULL;
+	int err;
+	u8 sector_bits;
+	u32 mb, gb;
+	u32 boot_checksum1 =3D 0, boot_checksum2 =3D 0;
+	u32 erase_block1 =3D 0, erase_block2 =3D 0;
+	u64 heap64;
+	u32 sb_blocksize;
+	u64 last_lsn;
+	u32 i;
+	u32 sector_size;
+	u64 boot_bytes_per_volume;
+	u64 partition_offset;
+	u32 fat_lsn;
+	u32 fat_len;
+	u32 cluster_heap;
+	u32 clusters;
+	u64 sectors_per_volume;
+
+check_boot:
+	err =3D -EINVAL;
+
+	if (boot->jump_code[0] !=3D 0xeb || boot->jump_code[1] !=3D 0x76 ||
+	    boot->jump_code[2] !=3D 0x90) {
+		hint =3D "invalid jump code";
+		goto out;
+	}
+
+	if (boot->oemid[0] !=3D 'E' || boot->oemid[1] !=3D 'X' ||
+	    boot->oemid[2] !=3D 'F' || boot->oemid[3] !=3D 'A' ||
+	    boot->oemid[4] !=3D 'T' || boot->oemid[5] !=3D ' ' ||
+	    boot->oemid[6] !=3D ' ' || boot->oemid[7] !=3D ' ') {
+		hint =3D "invalid oem signature";
+		goto out;
+	}
+
+	for (i =3D 0; i < sizeof(boot->zero); i++) {
+		if (boot->zero[i]) {
+			hint =3D "invalid zero zone";
+			goto out;
+		}
+	}
+
+	sector_bits =3D boot->sector_bits;
+	sector_size =3D 1u << sector_bits;
+	if (sector_bits < 9 || sector_bits > 12) {
+		hint =3D "invalid sector size";
+		goto out;
+	}
+
+	if (boot->sct_per_clst_bits > 16) {
+		hint =3D "invalid cluster size";
+		goto out;
+	}
+
+	if (boot->fats !=3D 1) {
+		hint =3D "This version of exfat driver does not support TexFat";
+		goto out;
+	}
+
+	fat_lsn =3D le32_to_cpu(boot->fat_lsn);
+	if (fat_lsn < 24) {
+		hint =3D "invalid fat offset";
+		goto out;
+	}
+
+	fat_len =3D le32_to_cpu(boot->fat_len);
+	cluster_heap =3D le32_to_cpu(boot->cluster_heap_lsn);
+	if (fat_lsn + fat_len > cluster_heap) {
+		hint =3D "invalid fat length";
+		goto out;
+	}
+
+	clusters =3D le32_to_cpu(boot->clusters);
+	if (!clusters ||
+	    (fat_len << (sector_bits - 2)) < clusters + EXFAT_CLUSTER_MIN) {
+		hint =3D "invalid clusters count";
+		goto out;
+	}
+
+	sectors_per_volume =3D le64_to_cpu(boot->sectors_per_volume);
+	last_lsn =3D cluster_heap + ((u64)clusters << boot->sct_per_clst_bits);
+	boot_bytes_per_volume =3D sectors_per_volume << sector_bits;
+
+	if (last_lsn > sectors_per_volume) {
+		hint =3D "invalid cluster_heap";
+		goto out;
+	}
+
+	*root_lcn =3D le32_to_cpu(boot->root_lcn);
+	if (*root_lcn < EXFAT_CLUSTER_FIRST ||
+	    *root_lcn - EXFAT_CLUSTER_FIRST >=3D clusters) {
+		hint =3D "invalid root_lcn";
+		goto out;
+	}
+
+	if (boot->major > 1) {
+		hint =3D "unsupported major version";
+		goto out;
+	}
+
+	if (0x55 !=3D boot->signature[0] || 0xAA !=3D boot->signature[1]) {
+		hint =3D "invalid boot signature";
+		goto out;
+	}
+
+	ClearFlag(sbi->flags,
+		  EXFAT_FLAGS_BOOT1_VALID | EXFAT_FLAGS_BOOT2_VALID);
+
+	err =3D exfat_check_boot(sb, MAIN_BOOT_SECTOR, sector_bits,
+			       &boot_checksum1, &erase_block1);
+	if (!err)
+		SetFlag(sbi->flags, EXFAT_FLAGS_BOOT1_VALID);
+
+	err =3D exfat_check_boot(sb, BACKUP_BOOT_SECTOR, sector_bits,
+			       &boot_checksum2, &erase_block2);
+	if (!err)
+		SetFlag(sbi->flags, EXFAT_FLAGS_BOOT2_VALID);
+
+	if (erase_block1)
+		exfat_trace(sb, "Found OEM erase block info: %x at master boot",
+			    erase_block1);
+	if (erase_block2)
+		exfat_trace(sb, "Found OEM erase block info: %x at backup boot",
+			    erase_block2);
+
+	if ((EXFAT_FLAGS_BOOT1_VALID | EXFAT_FLAGS_BOOT2_VALID) =3D=3D
+	    (sbi->flags &
+	     (EXFAT_FLAGS_BOOT1_VALID | EXFAT_FLAGS_BOOT2_VALID))) {
+		// Both boot are valid
+		WARN_ON(boot_checksum1 !=3D boot_checksum2);
+		WARN_ON(erase_block1 !=3D erase_block2);
+		if (boot_checksum1 !=3D boot_checksum2) {
+			exfat_trace(sb,
+				    "Primary and Backup boot does not match");
+			ClearFlag(sbi->flags, EXFAT_FLAGS_BOOT2_VALID);
+		}
+	} else if (0 =3D=3D (sbi->flags &
+			 (EXFAT_FLAGS_BOOT1_VALID | EXFAT_FLAGS_BOOT2_VALID))) {
+		// Both boot are invalid
+		hint =3D "primary and backup boots both inconsistent";
+		err =3D -EINVAL;
+		goto out;
+	} else if (backup_bh) {
+	} else if (!FlagOn(sbi->flags, EXFAT_FLAGS_BOOT1_VALID)) {
+		exfat_trace(sb, "use backup boot instead of primary");
+
+		backup_bh =3D exfat_bread(sb, BACKUP_BOOT_SECTOR);
+		if (!backup_bh) {
+			err =3D -EIO;
+			goto out;
+		}
+
+		boot =3D (struct exfat_boot *)backup_bh->b_data;
+		goto check_boot;
+	} else {
+		exfat_trace(sb,
+			    "use primary boot, backup boot is not consistent");
+	}
+
+	partition_offset =3D le64_to_cpu(boot->partition_offset);
+	sbi->cluster_bits =3D boot->sct_per_clst_bits + sector_bits;
+	sbi->cluster_size =3D 1u << sbi->cluster_bits;
+	sbi->cluster_mask =3D sbi->cluster_size - 1;
+	fat_lsn =3D le32_to_cpu(boot->fat_lsn);
+	fat_len =3D le32_to_cpu(boot->fat_len);
+	sbi->clusters =3D clusters;
+	sbi->serial_num =3D le32_to_cpu(boot->serial_num);
+	sbi->ex_flags =3D boot->ex_flags_lo;
+	sbi->bytes_per_fat =3D (u64)fat_len << sector_bits;
+	sbi->fat0_pbo =3D (u64)fat_lsn << sector_bits;
+	heap64 =3D (u64)cluster_heap << sector_bits;
+	sbi->cluster_heap =3D heap64 - (EXFAT_CLUSTER_FIRST * sbi->cluster_size);
+	if (FlagOn(boot->ex_flags_lo, BOOT_FLAG_DIRTY))
+		sbi->dirty =3D true;
+
+	/* Select block size to operate */
+	sb_blocksize =3D sbi->cluster_size;
+	if (sb_blocksize > PAGE_SIZE)
+		sb_blocksize =3D PAGE_SIZE;
+
+	while (sb_blocksize > sbi->fat0_pbo)
+		sb_blocksize >>=3D 1;
+
+	while (0 !=3D (sbi->fat0_pbo & (sb_blocksize - 1)))
+		sb_blocksize >>=3D 1;
+
+	while (0 !=3D (heap64 & (sb_blocksize - 1)))
+		sb_blocksize >>=3D 1;
+
+	sb_set_blocksize(sb, sb_blocksize);
+	WARN_ON(sb->s_blocksize !=3D sb_blocksize);
+
+	sbi->blocksize_mask =3D sb_blocksize - 1;
+	sbi->blocks_per_cluster =3D 1u
+				  << (sbi->cluster_bits - sb->s_blocksize_bits);
+	sbi->blocks_per_volume =3D bytes_per_volume >> sb->s_blocksize_bits;
+
+	gb =3D format_size_gb(boot_bytes_per_volume, &mb);
+
+	/* Check fs size and volume size */
+	if (bytes_per_volume < boot_bytes_per_volume) {
+		u32 mb0, gb0;
+
+		gb0 =3D format_size_gb(bytes_per_volume, &mb0);
+
+		exfat_trace(
+			sb,
+			"RAW ExFat volume: filesystem size %u.%02u Gb > volume size %u.%02u Gb.=
 Mount in read-only",
+			gb, mb, gb0, mb0);
+		sb->s_flags |=3D SB_RDONLY;
+	}
+
+	exfat_trace(
+		sb,
+		"Volume %04X-%04X is initiated as exFAT of size %u.%02u Gb%s",
+		sbi->serial_num >> 16, sbi->serial_num & 0xFFFF, gb, mb,
+		sbi->dirty ? ", dirty" : "");
+
+out:
+	brelse(backup_bh);
+	return err;
+}
+
+/* create root inode */
+static int exfat_create_root(struct super_block *sb, u32 root_lcn)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *root_inode;
+	struct exfat_inode_info *ei;
+	u32 len;
+	int err;
+
+	root_inode =3D new_inode(sb);
+	if (!root_inode)
+		return -ENOMEM;
+
+	root_inode->i_ino =3D EXFAT_ROOT_INO;
+	inode_set_iversion(root_inode, 1);
+
+	ei =3D exfat_i(root_inode);
+	ei->i_stream_flags =3D 0; /* use fat to load chain. see exfat_load_runs*/
+	root_inode->i_uid =3D sbi->options.fs_uid;
+	root_inode->i_gid =3D sbi->options.fs_gid;
+	inode_inc_iversion(root_inode);
+	root_inode->i_generation =3D 0;
+	root_inode->i_mode =3D exfat_make_mode(sbi, ENTRY_ATTR_DIR, 0777);
+	root_inode->i_op =3D &exfat_dir_inode_operations;
+	root_inode->i_fop =3D &exfat_dir_operations;
+	ei->i_lcn0 =3D root_lcn;
+
+	err =3D exfat_load_runs(root_inode, &len);
+	if (err)
+		goto out;
+
+	root_inode->i_size =3D ei->i_valid =3D (loff_t)len << sbi->cluster_bits;
+	if (root_inode->i_size > MAX_BYTES_PER_DIRECTORY) {
+		exfat_fs_error(sb, "root directory is too large",
+			       root_inode->i_size);
+		err =3D -EINVAL;
+		goto out;
+	}
+	root_inode->i_blocks =3D root_inode->i_size >> 9;
+	exfat_save_attrs(root_inode, ENTRY_ATTR_DIR);
+	root_inode->i_mtime.tv_sec =3D root_inode->i_atime.tv_sec =3D
+		root_inode->i_ctime.tv_sec =3D 0;
+	root_inode->i_mtime.tv_nsec =3D root_inode->i_atime.tv_nsec =3D
+		root_inode->i_ctime.tv_nsec =3D 0;
+	set_nlink(root_inode, 2); // will be filled in exfat_scan_root
+
+	insert_inode_hash(root_inode);
+	//  exfat_attach(root_inode, 0);
+
+	sb->s_root =3D d_make_root(root_inode);
+	if (!sb->s_root) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	return 0;
+
+out:
+	iput(root_inode);
+	return err;
+}
+
+enum {
+	Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask, Opt_allow_utime,
+	Opt_codepage, Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
+	Opt_utf8_no, Opt_utf8_yes, Opt_uni_xl_no, Opt_uni_xl_yes, Opt_flush,
+	Opt_tz_utc, Opt_discard, Opt_nfs, Opt_bias, Opt_err,
+};
+
+static const match_table_t fat_tokens =3D {
+	{ Opt_uid, "uid=3D%u" },
+	{ Opt_gid, "gid=3D%u" },
+	{ Opt_umask, "umask=3D%o" },
+	{ Opt_dmask, "dmask=3D%o" },
+	{ Opt_fmask, "fmask=3D%o" },
+	{ Opt_allow_utime, "allow_utime=3D%o" },
+	{ Opt_codepage, "codepage=3D%u" },
+	{ Opt_quiet, "quiet" },
+	{ Opt_showexec, "showexec" },
+	{ Opt_debug, "debug" },
+	{ Opt_immutable, "sys_immutable" },
+	{ Opt_flush, "flush" },
+	{ Opt_tz_utc, "tz=3DUTC" },
+	{ Opt_bias, "bias=3D%d" },
+	{ Opt_discard, "discard" },
+	{ Opt_utf8_no, "utf8=3D0" }, /* 0 or no or false */
+	{ Opt_utf8_no, "utf8=3Dno" },
+	{ Opt_utf8_no, "utf8=3Dfalse" },
+	{ Opt_utf8_yes, "utf8=3D1" }, /* empty or 1 or yes or true */
+	{ Opt_utf8_yes, "utf8=3Dyes" },
+	{ Opt_utf8_yes, "utf8=3Dtrue" },
+	{ Opt_utf8_yes, "utf8" },
+	{ Opt_uni_xl_no, "uni_xlate=3D0" }, /* 0 or no or false */
+	{ Opt_uni_xl_no, "uni_xlate=3Dno" },
+	{ Opt_uni_xl_no, "uni_xlate=3Dfalse" },
+	{ Opt_uni_xl_yes, "uni_xlate=3D1" }, /* empty or 1 or yes or true */
+	{ Opt_uni_xl_yes, "uni_xlate=3Dyes" },
+	{ Opt_uni_xl_yes, "uni_xlate=3Dtrue" },
+	{ Opt_uni_xl_yes, "uni_xlate" },
+	{ Opt_err, NULL }
+};
+
+static int exfat_parse_options(struct super_block *sb, char *options,
+			       int silent, int *debug,
+			       struct exfat_mount_options *opts)
+{
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+
+	opts->fs_uid =3D current_uid();
+	opts->fs_gid =3D current_gid();
+	opts->fs_fmask =3D opts->fs_dmask =3D current_umask();
+	opts->allow_utime =3D -1;
+	opts->quiet =3D opts->showexec =3D opts->sys_immutable =3D 0;
+	opts->unicode_xlate =3D 0;
+	opts->tz_set =3D 0;
+
+	*debug =3D 0;
+
+#ifdef CONFIG_EXFAT_RO_FS_DEFAULT_CODEPAGE
+	opts->codepage =3D CONFIG_EXFAT_RO_FS_DEFAULT_CODEPAGE;
+#endif
+
+#ifdef EXFAT_RO_FS_DEFAULT_UTF8
+	opts->utf8 =3D 1;
+#endif
+
+	if (!options)
+		goto out;
+
+	while ((p =3D strsep(&options, ","))) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		token =3D match_token(p, fat_tokens, args);
+		switch (token) {
+		case Opt_quiet:
+			opts->quiet =3D 1;
+			break;
+		case Opt_showexec:
+			opts->showexec =3D 1;
+			break;
+		case Opt_debug:
+			*debug =3D 1;
+			break;
+		case Opt_immutable:
+			opts->sys_immutable =3D 1;
+			break;
+		case Opt_uid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			opts->fs_uid =3D make_kuid(current_user_ns(), option);
+			if (!uid_valid(opts->fs_uid))
+				return -EINVAL;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			opts->fs_gid =3D make_kgid(current_user_ns(), option);
+			if (!gid_valid(opts->fs_gid))
+				return -EINVAL;
+			break;
+		case Opt_umask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_fmask =3D opts->fs_dmask =3D option;
+			break;
+		case Opt_dmask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_dmask =3D option;
+			break;
+		case Opt_fmask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_fmask =3D option;
+			break;
+		case Opt_allow_utime:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->allow_utime =3D option & 0022;
+			break;
+		case Opt_codepage:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			opts->codepage =3D option;
+			break;
+		case Opt_flush:
+			opts->flush =3D 1;
+			break;
+		case Opt_bias:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			/* GMT+-12 zones may have DST corrections so at least*/
+			/* 13 hours difference is needed. Make the limit 24*/
+			/* just in case someone invents something unusual.*/
+			if (option < -24 * 60 || option > 24 * 60)
+				return -EINVAL;
+			opts->tz_set =3D 1;
+			opts->bias =3D option;
+			break;
+		case Opt_tz_utc:
+			opts->tz_set =3D 1;
+			opts->bias =3D 0;
+			break;
+		case Opt_utf8_no: /* 0 or no or false */
+			opts->utf8 =3D 0;
+			break;
+		case Opt_utf8_yes: /* empty or 1 or yes or true */
+			opts->utf8 =3D 1;
+			break;
+		case Opt_uni_xl_no: /* 0 or no or false */
+			opts->unicode_xlate =3D 0;
+			break;
+		case Opt_uni_xl_yes: /* empty or 1 or yes or true */
+			opts->unicode_xlate =3D 1;
+			break;
+		case Opt_discard:
+			opts->discard =3D 1;
+			break;
+
+		/* unknown option */
+		default:
+			if (!silent)
+				__exfat_trace(
+					sb, KERN_ERR,
+					"Unrecognized mount option \"%s\" or missing value",
+					p);
+			return -EINVAL;
+		}
+	}
+
+out:
+	/* If user doesn't specify allow_utime, it's initialized from dmask. */
+	if (opts->allow_utime =3D=3D (u16)-1)
+		opts->allow_utime =3D ~opts->fs_dmask & 0022;
+	if (opts->unicode_xlate)
+		opts->utf8 =3D 0;
+
+	return 0;
+}
+
+static struct inode *exfat_new_dummy(struct super_block *sb, u32 ino)
+{
+	struct exfat_inode_info *ei;
+	struct inode *inode =3D new_inode(sb);
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino =3D ino;
+	WARN_ON(inode->i_sb !=3D sb);
+
+	ei =3D exfat_i(inode);
+	ei->i_valid =3D 0;
+	ei->i_lcn0 =3D 0;
+	ei->i_attrs =3D 0;
+	memset(ei->i_pos, 0, sizeof(ei->i_pos));
+
+	inode->i_mapping->a_ops =3D &exfat_aops;
+	return inode;
+}
+
+static const char s_magic[] =3D "EXFAT";
+
+/* try to mount*/
+static int exfat_fill_super(struct super_block *sb, void *data, int silent=
)
+{
+	int err;
+	struct buffer_head *bh =3D NULL;
+	struct exfat_sb_info *sbi;
+	struct block_device *bdev =3D sb->s_bdev;
+	int debug;
+	u32 i, root_lcn;
+
+	sbi =3D exfat_heap_alloc(sizeof(struct exfat_sb_info), true);
+	if (!sbi)
+		return -ENOMEM;
+
+	sb->s_fs_info =3D sbi;
+	sbi->sb =3D sb;
+	sb->s_flags |=3D SB_RDONLY | SB_NODIRATIME;
+	sb->s_magic =3D *(unsigned long *)s_magic; // TODO
+	sb->s_op =3D &exfat_sops;
+	sb->s_export_op =3D &exfat_export_ops;
+	sb->s_time_gran =3D 10000000;
+
+	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
+
+	mutex_init(&sbi->s_lock);
+
+	/* set up enough so that it can read an inode */
+	spin_lock_init(&sbi->inode_hash_lock);
+	for (i =3D 0; i < EXFAT_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
+
+	mutex_init(&sbi->exfat_lock);
+
+	err =3D exfat_parse_options(sb, data, silent, &debug, &sbi->options);
+	if (err)
+		goto out;
+
+	sbi->nls =3D load_nls_default();
+	if (!sbi->nls) {
+		__exfat_trace(sb, KERN_ERR, "failed to load default nls");
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	sb_min_blocksize(sb, 512);
+	sbi->blocks_per_volume =3D bdev->bd_inode->i_size >> sb->s_blocksize_bits=
;
+	bh =3D exfat_bread(sb, 0);
+	if (!bh) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	err =3D exfat_init_from_boot(sb, (struct exfat_boot *)bh->b_data,
+				   bdev->bd_inode->i_size, &root_lcn);
+	if (err)
+		goto out;
+
+	sb->s_maxbytes =3D (u64)sbi->clusters << sbi->cluster_bits;
+	sbi->free_clusters =3D ~0u;
+	sbi->first_free_cluster =3D ~0u;
+
+	sbi->fat_inode =3D exfat_new_dummy(sb, EXFAT_FAT_INO);
+	if (!sbi->fat_inode) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	sbi->fat_inode->i_size =3D sbi->bytes_per_fat;
+
+	sbi->bitmap_inode =3D exfat_new_dummy(sb, EXFAT_BITMAP_INO);
+	if (!sbi->bitmap_inode) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	err =3D exfat_create_root(sb, root_lcn);
+	if (err)
+		goto out;
+
+	err =3D exfat_scan_root(sb);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	brelse(bh);
+	iput(sbi->fat_inode);
+	iput(sbi->bitmap_inode);
+	if (sb->s_root) {
+		iput(sb->s_root->d_inode);
+		d_drop(sb->s_root);
+		sb->s_root =3D NULL;
+	}
+
+	unload_nls(sbi->nls);
+	sb->s_fs_info =3D NULL;
+	exfat_heap_free(sbi);
+
+	return err;
+}
+
+static struct dentry *exfat_mount(struct file_system_type *fs_type, int fl=
ags,
+				  const char *dev_name, void *data)
+{
+	return mount_bdev(fs_type, flags, dev_name, data, exfat_fill_super);
+}
+
+static struct file_system_type exfat_fs_type =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "exfat",
+	.mount =3D exfat_mount,
+	.kill_sb =3D kill_block_super,
+	.fs_flags =3D FS_REQUIRES_DEV,
+};
+MODULE_ALIAS_FS("exfat");
+
+// How many seconds since 1970 till 1980
+#define Seconds1970To1980 0x12CEA600
+
+static int __init init_exfat_fs(void)
+{
+	int err;
+	struct timespec64 ts;
+
+	/* exfat stores dates relative 1980.*/
+	ktime_get_coarse_real_ts64(&ts);
+	if (ts.tv_sec < Seconds1970To1980)
+		pr_notice(
+			"exfat can't store dates before Jan 1, 1980. Please update current date=
\n");
+
+	err =3D exfat_run_cache_init();
+	if (err)
+		return err;
+
+	exfat_inode_cachep =3D kmem_cache_create(
+		"exfat_inode_cache", sizeof(struct exfat_inode_info), 0,
+		(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+		init_once);
+	if (!exfat_inode_cachep) {
+		err =3D -ENOMEM;
+		goto failed;
+	}
+
+	err =3D register_filesystem(&exfat_fs_type);
+	if (!err)
+		return 0;
+
+failed:
+	exfat_run_cache_exit();
+	return err;
+}
+
+static void __exit exit_exfat_fs(void)
+{
+	exfat_run_cache_exit();
+	if (exfat_inode_cachep) {
+		rcu_barrier();
+		kmem_cache_destroy(exfat_inode_cachep);
+	}
+
+	unregister_filesystem(&exfat_fs_type);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("exfat filesystem");
+MODULE_AUTHOR("Konstantin Komarov");
+
+module_init(init_exfat_fs) module_exit(exit_exfat_fs)
diff --git a/fs/exfat/upcase.c b/fs/exfat/upcase.c
new file mode 100644
index 000000000000..c3b9ede6cbbb
--- /dev/null
+++ b/fs/exfat/upcase.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/exfat/upcase.c
+ *
+ * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/module.h>
+
+#include "debug.h"
+#include "exfat.h"
+#include "exfat_fs.h"
+
+/* Used in RtlUpcaseUnicodeChar */
+static const u16 s_Upcase[] =3D {
+	0x0140, 0x01b0, 0x01a0, 0x0130, 0x0180, 0x0190, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0120, 0x01c0, 0x01d0, 0x0100, 0x0150, 0x0100, 0x0100,
+	0x0110, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0170,
+	0x01e0, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100, 0x0100,
+	0x0100, 0x0100, 0x0100, 0x0160, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x0530, 0x0520, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x0210, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x0240, 0x01f0, 0x01f0, 0x0220,
+	0x0350, 0x0510, 0x0250, 0x03e0, 0x02d0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x0350, 0x04f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x0500, 0x04e0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x0200, 0x01f0,
+	0x01f0, 0x0540, 0x0280, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x0350, 0x04f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x04d0, 0x04d0, 0x04c0, 0x0370, 0x0270, 0x03e0, 0x03e0,
+	0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x0380, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x0500, 0x0500, 0x04a0, 0x03e0, 0x03e0, 0x0360, 0x03e0, 0x03e0, 0x03e0,
+	0x0320, 0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x0380, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x0340, 0x04d0, 0x04b0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x03e0, 0x03e0, 0x02c0, 0x0390, 0x0300, 0x0290, 0x0490,
+	0x02f0, 0x0480, 0x02e0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x03e0, 0x03e0, 0x03e0, 0x02b0, 0x0560, 0x03e0, 0x03e0, 0x03c0, 0x0450,
+	0x0310, 0x03b0, 0x0550, 0x0260, 0x0570, 0x03e0, 0x02a0, 0x03e0, 0x03e0,
+	0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x03a0, 0x03e0,
+	0x03e0, 0x03e0, 0x03e0, 0x03e0, 0x03d0, 0x0430, 0x0420, 0x0430, 0x0430,
+	0x0420, 0x0330, 0x0430, 0x0440, 0x0430, 0x0430, 0x0430, 0x0410, 0x0230,
+	0x03f0, 0x0400, 0x0230, 0x0470, 0x0470, 0x0460, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0, 0x01f0,
+	0x01f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0xffe4, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0ee6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffda, 0xffdb,
+	0xffdb, 0xffdb, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xfff7, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0082, 0x0082, 0x0082, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0xfffe, 0x0000, 0x0000, 0xfffe, 0x0000, 0x0000, 0xfffe,
+	0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0xff2e, 0xff32, 0x0000, 0xff33, 0xff33, 0x0000, 0xff36,
+	0x0000, 0xff35, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0xfffe, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0000, 0x0000, 0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff,
+	0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0xff25, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xff2b, 0x0000,
+	0x0000, 0xff2a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x29e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0061, 0x0000, 0x0000,
+	0x0000, 0xffff, 0x00a3, 0x0000, 0x0000, 0x0000, 0x0082, 0x0000, 0x0000,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0xfff1, 0x0000, 0x0008, 0x0000,
+	0x0008, 0x0000, 0x0008, 0x0000, 0x0008, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffd0, 0xffd0, 0xffd0, 0xffd0,
+	0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0,
+	0xffd0, 0xffd0, 0x0000, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x2a2b, 0x0000, 0xffff, 0x0000, 0x2a28,
+	0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0xffff, 0x0000,
+	0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff,
+	0x0008, 0x0008, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0008, 0x0008,
+	0x0000, 0x0000, 0x0000, 0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0008, 0x0008, 0x0000, 0x0009,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x004a,
+	0x004a, 0x0056, 0x0056, 0x0056, 0x0056, 0x0064, 0x0064, 0x0080, 0x0080,
+	0x0070, 0x0070, 0x007e, 0x007e, 0x0000, 0x0000, 0x00c3, 0x0000, 0x0000,
+	0xffff, 0x0000, 0xffff, 0x0000, 0x0000, 0xffff, 0x0000, 0x0000, 0x0000,
+	0xffff, 0x0000, 0x0000, 0x0000, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0,
+	0xe3a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0,
+	0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0, 0xe3a0,
+	0xff26, 0x0000, 0x0000, 0xff26, 0x0000, 0x0000, 0x0000, 0x0000, 0xff26,
+	0xffbb, 0xff27, 0xff27, 0xffb9, 0x0000, 0x0000, 0x0000, 0xff33, 0x0000,
+	0x0000, 0xff31, 0x0000, 0x0000, 0x0000, 0x0000, 0xff2f, 0xff2d, 0x0000,
+	0x29f7, 0x0000, 0x0000, 0x0000, 0xff2d, 0xffb0, 0xffb0, 0xffb0, 0xffb0,
+	0xffb0, 0xffb0, 0xffb0, 0xffb0, 0xffb0, 0xffb0, 0xffb0, 0xffb0, 0xffb0,
+	0xffb0, 0xffb0, 0xffb0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0,
+	0xffd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0,
+	0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0x0000, 0xffd0,
+	0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0,
+	0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffd0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0xffe0, 0x0000, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0x0079, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe1, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0, 0xffe0,
+	0xffe0, 0xffe0, 0xffe0, 0xffc0, 0xffc1, 0xffc1, 0x0000, 0xffe6, 0xffe6,
+	0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xffe6, 0xffe6, 0xffe6, 0xffe6,
+	0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6, 0xffe6,
+	0xffe6, 0xffe6, 0xffe6, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0,
+	0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0, 0xfff0,
+	0xfff0, 0xffff, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0xffff, 0x0000, 0x0038, 0xffff,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0xffff, 0x0000, 0xffff,
+	0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000, 0xffff, 0x0000,
+	0xffff, 0xffb1, 0x0000, 0xffff,
+};
+
+/* This function converts the specified Unicode character to uppercase */
+static inline u16 upcase_unicode_char_ex(const u16 *upcase, u16 chr)
+{
+	if (chr < 'a')
+		return chr;
+
+	if (chr <=3D 'z')
+		return chr - ('a' - 'A');
+
+	return chr + upcase[upcase[upcase[chr >> 8] + ((chr >> 4) & 0xF)] +
+			    (chr & 0xF)];
+}
+
+/* This function creates upcase table for ExFat */
+void create_up_case(u16 *Buffer)
+{
+	u16 i;
+	// Fill the default values
+	for (i =3D 0; i < ARRAY_SIZE(s_Upcase); i++)
+		Buffer[i] =3D upcase_unicode_char_ex(s_Upcase, i);
+}
+
+/* UnPacks packed upcase */
+static bool unpack_upcase(struct super_block *sb, const __le16 *packed,
+			  u32 bytes_per_packed, bool *hole, u16 *unpacked,
+			  u32 *pos)
+{
+	u16 *up =3D unpacked + *pos;
+	//
+	// Analyze compressed 'upcase' cluster
+	//
+	while (bytes_per_packed >=3D sizeof(short)) {
+		u16 uc =3D le16_to_cpu(*packed++);
+
+		if (*hole) {
+			if (*pos + uc > 0x10000) {
+				exfat_trace(sb, "Invalid upcase_tbl table (1)");
+				return false;
+			}
+
+			while (uc--) {
+				*up++ =3D (u16)*pos;
+				*pos +=3D 1;
+			}
+
+			*hole =3D false;
+		} else if (uc =3D=3D 0xFFFF)
+			*hole =3D true;
+		else {
+			if (*pos >=3D 0x10000) {
+				exfat_trace(sb, "Invalid upcase_tbl table (2)");
+				return false;
+			}
+			*up++ =3D uc;
+			*pos +=3D 1;
+		}
+
+		bytes_per_packed -=3D sizeof(short);
+	}
+
+	WARN_ON(bytes_per_packed);
+	return true;
+}
+
+/* Loads upcase from roots exfat_direntry::upcase */
+int exfat_load_upcase(struct super_block *sb, const union exfat_direntry *=
de,
+		      bool usedefault_if_error)
+{
+	struct exfat_sb_info *sbi =3D sb->s_fs_info;
+	bool hole =3D false;
+	int err =3D 0;
+	u32 pos =3D 0;
+	u32 checksum =3D 0;
+	u32 lcn =3D le32_to_cpu(de->upcase.start_lcn);
+	u64 bytes_per_file64 =3D le64_to_cpu(de->upcase.size);
+	u32 bytes_per_file =3D bytes_per_file64;
+	u32 vbo, next_lcn;
+	struct exfat_entry exfat_entry;
+
+	static_assert(0x10000 =3D=3D (1u << (8 * sizeof(short))));
+	WARN_ON(de->type !=3D ENTRY_TYPE_UPCASE);
+
+	// Check the size of upcase_tbl file
+	if (bytes_per_file !=3D bytes_per_file64 || !exfat_valid_lcn(sbi, lcn)) {
+		exfat_trace(sb, "Invalid upcase_tbl fat chain");
+		return -EINVAL;
+	}
+
+	WARN_ON(sbi->upcase_tbl);
+	sbi->upcase_tbl =3D (u16 *)exfat_heap_alloc(0x10000 * sizeof(u16), true);
+	if (!sbi->upcase_tbl)
+		return -ENOMEM;
+
+	memset(&exfat_entry, 0, sizeof(exfat_entry));
+
+	for (vbo =3D 0; vbo < bytes_per_file;
+	     vbo +=3D sbi->cluster_size, lcn =3D next_lcn) {
+		u32 off;
+		u64 pbo =3D exfat_lcn_to_pbo(sbi, lcn);
+
+		for (off =3D 0;
+		     off < sbi->cluster_size && vbo + off < bytes_per_file;
+		     off +=3D sb->s_blocksize, pbo +=3D sb->s_blocksize) {
+			bool bOk;
+			u32 bytes;
+			sector_t pbn =3D pbo >> sb->s_blocksize_bits;
+			struct buffer_head *bh =3D exfat_bread(sb, pbn);
+
+			if (!bh) {
+				err =3D -EIO;
+				goto out;
+			}
+
+			bytes =3D bytes_per_file - (vbo + off);
+			if (bytes > sb->s_blocksize)
+				bytes =3D sb->s_blocksize;
+
+			bOk =3D unpack_upcase(sb, (__le16 *)bh->b_data, bytes,
+					    &hole, sbi->upcase_tbl, &pos);
+
+			if (bOk) {
+				const u8 *p;
+
+				for (p =3D bh->b_data; bytes--;)
+					checksum =3D exfat_check_sum_32(checksum,
+								      *p++);
+			}
+
+			brelse(bh);
+
+			if (!bOk) {
+				exfat_trace(sb, "Invalid upcase_tbl table (1)");
+				err =3D -EINVAL;
+				goto out;
+			}
+		}
+
+		err =3D exfat_fat_get(sb, &exfat_entry, lcn, &next_lcn);
+		if (err)
+			goto out;
+	}
+
+	if (le32_to_cpu(de->upcase.checksum) !=3D checksum) {
+		exfat_trace(sb, "checksum failed for upcase_tbl table");
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (hole) {
+		u16 *p =3D sbi->upcase_tbl + pos;
+
+		for (; pos < 0x10000; pos++)
+			*p++ =3D pos;
+	}
+
+	return 0;
+
+out:
+	if (usedefault_if_error) {
+		/* Generate default upcase_tbl file */
+		exfat_fs_error(
+			sb,
+			"Failed to read upcase_tbl file: use the default one, mount in read-onl=
y");
+		create_up_case(sbi->upcase_tbl);
+		err =3D 0;
+	}
+
+	return err;
+}
--=20
2.23.0


