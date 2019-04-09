Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6505DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA420833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDcJB2Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfDIIhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:37:34 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:46996 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:37:34 -0400
Received: by mail-vs1-f73.google.com with SMTP id y138so2755632vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NWmuyWOAWbPWH9U7dkYKdVIZC9kxT49Hao9GlBVtRBc=;
        b=oDcJB2IqL/+fPwiFZ+xAodTkhbD2dmBmhj5Xep3GtfzDa4bqYzA1af1ORYF0/rWK+5
         U7Phh1ATwKqFqNfzsLkawpPi1uv3UN245thXNlf9WP+E1Q9p9eY0CJ+4VaOAY8RUVd6i
         Kh4dEMTS4YLBdVIlpUTHM9NvE3eDVMcSS/rQnO1M9ARI29nGWxTcZ//Bvxwrxh4xSnyC
         zB6ImhcAP6ArcvWEI/XrjPvPO8LZBMNvgBGONnCiVTmuSBNi2z+iRlU7e9xSUpN7j1Sb
         r7vsmMsoYg5Ah5+eVQdqR3R9bLbIB5L1rZtV2fWABLKUImYQoygEjcmhyp66dFgXr1N/
         GEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NWmuyWOAWbPWH9U7dkYKdVIZC9kxT49Hao9GlBVtRBc=;
        b=udSOTy7PkDLV5RCFd8xjzoO/sVBmoqS+X8FN1VrD6X5Iq2RA6k7ZZAYXps3Y+bxWhG
         ruJunsUbgreBvFGey3TMR9dpjsmB6kpS+gp9cGsIxP7KcjKxV9ejqoBfMlGL4j+lvnHQ
         V5+8nfJJjqk/J5WFnuCLt8jDx1/9jX+Woe/Av6KTo0pB4gUtUGxS29Azr6W6cVVMCCRm
         bF9rtQr67PqCVwEo0PYBVJYSDM1YeDM9oMsEbDt7iRH8nVKrShK9d7bh39P3Ux5fmaoE
         iJCJAYwe3maIcahnq66IDtd/uFKumH7CcALZKdw7nGnYVnwf8XdyDhk6mVbSJ+I1nYh2
         j2SQ==
X-Gm-Message-State: APjAAAVe0YtFvchV4UdWTM8HnEwCOvwqy64Ke62Z2+wyxhs/DeuJIWlP
        /aeAksZ1ejQTtGP+DJdtlzWZFeeNH+71KYR39+Y=
X-Google-Smtp-Source: APXvYqylRBsOslmn3JqBY1Ko0adAz3bfW0Odb1pMqn00feLWMmfVuBVXZE1916j16QWpfw1fLCX8S6xhhjrj8xhqDcY=
X-Received: by 2002:ab0:6039:: with SMTP id n25mr866623ual.25.1554799052890;
 Tue, 09 Apr 2019 01:37:32 -0700 (PDT)
Date:   Tue,  9 Apr 2019 16:37:26 +0800
Message-Id: <20190409083726.181522-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] f2fs: fix to avoid accessing xattr across the boundary
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
---
 fs/f2fs/xattr.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 848a785abe25..f60e40d95bbf 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -202,12 +202,17 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
 	return handler;
 }
 
-static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
-					size_t len, const char *name)
+static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
+				unsigned int max_size, int index,
+				size_t len, const char *name)
 {
 	struct f2fs_xattr_entry *entry;
+	void *max_addr = base_addr + ENTRY_SIZE(XATTR_ENTRY(base_addr)) +
+				max_size - 1;
 
 	list_for_each_xattr(entry, base_addr) {
+		if ((void *)entry + sizeof(__u32) > max_addr)
+			return NULL;
 		if (entry->e_name_index != index)
 			continue;
 		if (entry->e_name_len != len)
@@ -301,6 +306,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
 	unsigned int inline_size = inline_xattr_size(inode);
+	unsigned int max_size = inline_size + size + XATTR_PADDING_SIZE;
 	int err = 0;
 
 	if (!size && !inline_size)
@@ -323,6 +329,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 			*base_size = inline_size;
 			goto check;
 		}
+		max_size -= inline_size;
 	}
 
 	/* read from xattr node block */
@@ -330,6 +337,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 		err = read_xattr_block(inode, txattr_addr);
 		if (err)
 			goto out;
+
+		max_size -= size;
 	}
 
 	if (last_addr)
@@ -337,7 +346,12 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	else
 		cur_addr = txattr_addr;
 
-	*xe = __find_xattr(cur_addr, index, len, name);
+	*xe = __find_xattr(cur_addr, max_size, index, len, name);
+	if (!*xe) {
+		err = -EFAULT;
+		goto out;
+	}
+
 check:
 	if (IS_XATTR_LAST_ENTRY(*xe)) {
 		err = -ENODATA;
@@ -585,6 +599,10 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	int found, newsize;
 	size_t len;
 	__u32 new_hsize;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	unsigned int xattr_nid_size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
+	unsigned int inline_size = inline_xattr_size(inode);
+	unsigned int max_size = inline_size + size + XATTR_PADDING_SIZE;
 	int error = 0;
 
 	if (name == NULL)
@@ -606,7 +624,11 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		return error;
 
 	/* find entry with wanted name. */
-	here = __find_xattr(base_addr, index, len, name);
+	here = __find_xattr(base_addr, max_size, index, len, name);
+	if (!here) {
+		error = -EFAULT;
+		goto exit;
+	}
 
 	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 
-- 
2.21.0.392.gf8f6787159e-goog

