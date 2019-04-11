Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F075C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D862070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/bNQpSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKI0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:26:53 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:54183 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:26:53 -0400
Received: by mail-io1-f73.google.com with SMTP id w11so4235619iom.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2TCmfnLPy94+Xy9NBdzK053gr69JBpzQeIDfSXoCA+w=;
        b=B/bNQpSpi5LNYXxm3BI2znlLgEcqqX3T9mk2DS9YQC8E+hwajL/37F11EVzT/STwn1
         xtLilBsa+H/dYm2IyjCWNURKti4CqR3ogHALhO84pgo+7bYOgTkHt9XWwoVZ9rNo0mXA
         xe1cRtvgt9zEayE0QdWzhSKcmyc5w2whSejIkwXe6+zEUlffI3xk6ShRi5LN8ec220+O
         IlAqDF/QDH8kipae7CbFD9Ej7pAVIgcus996i0LrKKXbfkLxu9UZ64KMak4MPy66wS+H
         7JE9Nh0CTv7EyOi6IiwpCQVYziGNJl3Q18HMZTCHOk+zObYp54+TIKFia+EKdQ45fnLM
         qYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2TCmfnLPy94+Xy9NBdzK053gr69JBpzQeIDfSXoCA+w=;
        b=BU+xOJRTqiUx93xU6NuWKrWDom+0i+rd+9P7YOoqQ82air2cHtkhd4cqr1IqCq0Wnh
         qnsSxh4+J4yB/FaWT3eoUT8QgQiM/1MIT8HoDLq7qoQHa4fxEyIFgBASG7JwcZdvbanJ
         PuVqtdEAsrpEaP53HzgpDjFOorQFVy9gOC4KapAhVr0sMkNpMLMRZKXzPA1vU4euvs6H
         PCGxhxJDOKlGDIvLUhGm5OjPxySpgDMD8oVklb596wKBPc3vvUMaZcig5lZ42fg1/7Hk
         H6VmGEtID1xlpULMtdjrM1pVGPe2lhVMIp7Ze9JpMB5q0IcznKI0ZYqyI4j5QyIQzYJX
         aO3A==
X-Gm-Message-State: APjAAAW0oyOWWvvmWdmpKvAjEGbuve5/PitjgtrlirArkX6IxGIzaNQy
        My8lXTGEpjr9M0iz0xxIzuLcIyP/cpNBRg/j/t8=
X-Google-Smtp-Source: APXvYqyM4cM7ssLbfFvFe9yqrXEG+TiwsFxoUIYkrV12VJGm8i+Z1+Plb7pNolb4shBqioIm47K9mWWXmIXN+NilCzY=
X-Received: by 2002:a24:97cf:: with SMTP id k198mr2302615ite.26.1554971211864;
 Thu, 11 Apr 2019 01:26:51 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:26:46 +0800
Message-Id: <20190411082646.169977-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
From:   Randall Huang <huangrandall@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we traverse xattr entries via __find_xattr(),
if the raw filesystem content is faked or any hardware failure occurs,
out-of-bound error can be detected by KASAN.
Fix the issue by introducing boundary check.

[   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
[   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
[   38.402935] c7   1827 Call trace:
[   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
[   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
[   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
[   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
[   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
[   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
[   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
[   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
[   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
[   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
[   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
[   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
[   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
[   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
[   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
[   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
[   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
[   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
[   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
[   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
[   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
[   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38

Bug: 126558260

Signed-off-by: Randall Huang <huangrandall@google.com>
---
v2:
* return EFAULT if OOB error is detected

v3:
* fix typo in setxattr()

v4:
* change boundry definition

v5:
* revise boundry definition
---
 fs/f2fs/xattr.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 848a785abe25..587429e29a69 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -202,12 +202,18 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
 	return handler;
 }
 
-static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
-					size_t len, const char *name)
+static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
+				void *last_base_addr, int index,
+				size_t len, const char *name)
 {
 	struct f2fs_xattr_entry *entry;
 
 	list_for_each_xattr(entry, base_addr) {
+		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) +
+			sizeof(__u32) > last_base_addr)
+			return NULL;
+
 		if (entry->e_name_index != index)
 			continue;
 		if (entry->e_name_len != len)
@@ -298,6 +304,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				void **base_addr, int *base_size)
 {
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
+	void *last_txattr_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
 	unsigned int inline_size = inline_xattr_size(inode);
@@ -311,6 +318,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!txattr_addr)
 		return -ENOMEM;
 
+	last_txattr_addr = (void *)txattr_addr + inline_size + size;
+
 	/* read from inline xattr */
 	if (inline_size) {
 		err = read_inline_xattr(inode, ipage, txattr_addr);
@@ -337,7 +346,11 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	else
 		cur_addr = txattr_addr;
 
-	*xe = __find_xattr(cur_addr, index, len, name);
+	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
+	if (!*xe) {
+		err = -EFAULT;
+		goto out;
+	}
 check:
 	if (IS_XATTR_LAST_ENTRY(*xe)) {
 		err = -ENODATA;
@@ -581,10 +594,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			struct page *ipage, int flags)
 {
 	struct f2fs_xattr_entry *here, *last;
-	void *base_addr;
+	void *base_addr, *last_base_addr = NULL;
 	int found, newsize;
 	size_t len;
 	__u32 new_hsize;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	unsigned int xattr_nid_size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
+	unsigned int inline_size = inline_xattr_size(inode);
+
 	int error = 0;
 
 	if (name == NULL)
@@ -604,9 +621,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	error = read_all_xattrs(inode, ipage, &base_addr);
 	if (error)
 		return error;
+	last_base_addr = (void *)base_addr + xattr_nid_size + inline_size;
 
 	/* find entry with wanted name. */
-	here = __find_xattr(base_addr, index, len, name);
+	here = __find_xattr(base_addr, last_base_addr, index, len, name);
+	if (!here) {
+		error = -EFAULT;
+		goto exit;
+	}
 
 	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 
-- 
2.21.0.392.gf8f6787159e-goog

