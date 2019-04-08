Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D905C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E57120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqXWXhcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDHIu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:50:26 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:40427 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:50:26 -0400
Received: by mail-oi1-f201.google.com with SMTP id q82so5376633oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y7S9KFvwD3SI2JYMueM0A4SKJSx0WkTCQJ8CcpYn5Kg=;
        b=RqXWXhcR2Y75mafYXNTn5qoRi6apbyTpTCqT8c5zrVG4+46ZoFHUYCScyunNOI+nP/
         jDFWd6R7zCBQlHGB2TGsg5movD72iMuIMLvfx4zqiI8RXxl2UJ8ugPHBDzYuXZB5MerG
         5yApR+49mf1hUytWlJ1uH9Nv0bbBu8hWuepSmOuZjEIYoeiD2WB4UlVoqfw6k6/C/8kq
         +iErTL6355qg+QAyL4iY90SR9b8yDVVU5c/t6bhjxwCWbo9KWovJvNlg9FaTGrjBYzD/
         ZNEPWin0XgwdPVDWip7L4orXzUi9GvlMrJXkIdUW9nPt4oB0We5+j8Qjx1cECt//IAup
         k2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y7S9KFvwD3SI2JYMueM0A4SKJSx0WkTCQJ8CcpYn5Kg=;
        b=n1WQz1qUvPQabTBwSWmuIMAPQdffhVUlGpOsmQ8BufBwv7DzPM/ujr9HPaXjJ9Zf/o
         waL8/mDAj2DQoDKRYh9jCpHC5oAeslE1qXkHrxe30ZZdgpuD8J8u1iV4Z5/sC+jjInJL
         vSASga0sLDGCAcIruE/9efX+xDyf1UP6aA9Jt3Of/YPH3li87VcDCNj7Xn38Aw1bmzdQ
         Q4i1bNA2v3ZexzX8T09fihg93n2RU668CytBcd7+LHNpOd8S12kK80LMkJT7YuFuo9C0
         ts7jC1Tsl0+t6zFjPcccd2WVGmBcqvV8jkuGdp21SiUoJBlFtwDKCr0mnqHFE/Pj2xMx
         lw3A==
X-Gm-Message-State: APjAAAU/n0FXooCjYxjKMs7ekoTZIZfRsIRB9SIZcBJEQoe8ipJTlOG3
        x/qSbrrXnJYZd+DFgFwFLdM4s/UQJ+Qqc6kRm+A=
X-Google-Smtp-Source: APXvYqykmZlVR4gPI6+41B5wJsAKNia6wzbN5CQv5lpdF6XNImJvkF7nMQgKAAMb2ZV106za6+jPX6TmR02wARHqZrY=
X-Received: by 2002:aca:b887:: with SMTP id i129mr2265515oif.47.1554713421813;
 Mon, 08 Apr 2019 01:50:21 -0700 (PDT)
Date:   Mon,  8 Apr 2019 16:50:16 +0800
Message-Id: <20190408085016.13042-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] f2fs: fix to avoid accessing xattr across the boundary
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
 fs/f2fs/xattr.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 848a785abe25..0531c1e38275 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -202,12 +202,17 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
 	return handler;
 }
 
-static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
-					size_t len, const char *name)
+static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
+				int base_addr_limit, int index,
+				size_t len, const char *name)
 {
 	struct f2fs_xattr_entry *entry;
+	void *max_addr = base_addr + ENTRY_SIZE(XATTR_ENTRY(base_addr)) +
+		base_addr_limit - 1;
 
 	list_for_each_xattr(entry, base_addr) {
+		if ((void *)entry + sizeof(__u32) > max_addr)
+			return NULL;
 		if (entry->e_name_index != index)
 			continue;
 		if (entry->e_name_len != len)
@@ -337,9 +342,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	else
 		cur_addr = txattr_addr;
 
-	*xe = __find_xattr(cur_addr, index, len, name);
+	*xe = __find_xattr(cur_addr, XATTR_PADDING_SIZE, index, len, name);
 check:
-	if (IS_XATTR_LAST_ENTRY(*xe)) {
+	if (!*xe || IS_XATTR_LAST_ENTRY(*xe)) {
 		err = -ENODATA;
 		goto out;
 	}
@@ -606,9 +611,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		return error;
 
 	/* find entry with wanted name. */
-	here = __find_xattr(base_addr, index, len, name);
+	here = __find_xattr(base_addr, inline_xattr_size(inode) +
+			VALID_XATTR_BLOCK_SIZE + XATTR_PADDING_SIZE,
+			index, len, name);
 
-	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
+	if (!here)
+		found = 0;
+	else
+		found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 
 	if (found) {
 		if ((flags & XATTR_CREATE)) {
-- 
2.21.0.392.gf8f6787159e-goog

