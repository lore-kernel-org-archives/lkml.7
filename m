Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6828217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557420498;
	bh=kol39BephWYIHDzdaXrvumnDFI8vJt7AfTLmiFkdhCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ntq7NrPsmQMBRaEEYdPwQAL2PzAdRbvFMG9//BzrhHJ1J4hMgc8fG9gzBfE4fpXIR
	 piwcdlZoOt67c93Ljv84JJHBd2qROLqMsXEtnCwiGwWdN6ixvDR130LUPCmMmY5rLZ
	 qQ+Oq3m73TQOToHMmc7CI8gZQEUqZ4IjwTIk888g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEIQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfEIQsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:48:17 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38982177E;
        Thu,  9 May 2019 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557420495;
        bh=kol39BephWYIHDzdaXrvumnDFI8vJt7AfTLmiFkdhCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyoiZFRaABWrxW8LjQOdrsYbo/2yLzc26cJp0FY7SnFSbaquCK8BNIliPm64CIcp/
         fhQcQ5ydKk9kI0oXGIyzVozzFiqDIGT/avn3QVPT254RRB4OwwtkbkVn4gXmVZPef3
         TpTcLMRT8lHftvdnQJ7J5M+TKIFELZF53SS4CE7c=
Date:   Thu, 9 May 2019 09:48:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Randall Huang <huangrandall@google.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
Message-ID: <20190509164814.GA79912@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190411082646.169977-1-huangrandall@google.com>
 <20190509041535.GA62877@jaegeuk-macbookpro.roam.corp.google.com>
 <bdba5d01-4a31-d8f2-4805-81d167047c84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdba5d01-4a31-d8f2-4805-81d167047c84@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Chao Yu wrote:
> On 2019/5/9 12:15, Jaegeuk Kim wrote:
> > On 04/11, Randall Huang wrote:
> >> When we traverse xattr entries via __find_xattr(),
> >> if the raw filesystem content is faked or any hardware failure occurs,
> >> out-of-bound error can be detected by KASAN.
> >> Fix the issue by introducing boundary check.
> >>
> >> [   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
> >> [   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
> >> [   38.402935] c7   1827 Call trace:
> >> [   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
> >> [   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
> >> [   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
> >> [   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
> >> [   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
> >> [   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
> >> [   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
> >> [   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
> >> [   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
> >> [   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
> >> [   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
> >> [   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
> >> [   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
> >> [   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
> >> [   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
> >> [   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
> >> [   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
> >> [   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
> >> [   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
> >> [   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
> >> [   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
> >> [   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38
> >>
> >> Bug: 126558260
> >>
> >> Signed-off-by: Randall Huang <huangrandall@google.com>
> >> ---
> >> v2:
> >> * return EFAULT if OOB error is detected
> >>
> >> v3:
> >> * fix typo in setxattr()
> >>
> >> v4:
> >> * change boundry definition
> >>
> >> v5:
> >> * revise boundry definition
> >> ---
> >>  fs/f2fs/xattr.c | 32 +++++++++++++++++++++++++++-----
> >>  1 file changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> >> index 848a785abe25..587429e29a69 100644
> >> --- a/fs/f2fs/xattr.c
> >> +++ b/fs/f2fs/xattr.c
> >> @@ -202,12 +202,18 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
> >>  	return handler;
> >>  }
> >>  
> >> -static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
> >> -					size_t len, const char *name)
> >> +static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
> >> +				void *last_base_addr, int index,
> >> +				size_t len, const char *name)
> >>  {
> >>  	struct f2fs_xattr_entry *entry;
> >>  
> >>  	list_for_each_xattr(entry, base_addr) {
> >> +		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
> >> +			(void *)XATTR_NEXT_ENTRY(entry) +
> >> +			sizeof(__u32) > last_base_addr)
> >> +			return NULL;
> >> +
> >>  		if (entry->e_name_index != index)
> >>  			continue;
> >>  		if (entry->e_name_len != len)
> >> @@ -298,6 +304,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
> >>  				void **base_addr, int *base_size)
> >>  {
> >>  	void *cur_addr, *txattr_addr, *last_addr = NULL;
> >> +	void *last_txattr_addr = NULL;
> >>  	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> >>  	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
> >>  	unsigned int inline_size = inline_xattr_size(inode);
> >> @@ -311,6 +318,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
> >>  	if (!txattr_addr)
> >>  		return -ENOMEM;
> >>  
> >> +	last_txattr_addr = (void *)txattr_addr + inline_size + size;
> > 
> > I just found this should be + XATTR_PADDING_SIZE. Otherwise, generic/026 fails.
> > Let me know, if there is any other concern below.
> 
> We're trying to use [txattr_addr, last_txattr_addr] to indicate valid range of
> xattr datas, any valid entries across the boundary is not allowed, so I think
> it's correct to exclude padding space for last_txattr_addr.

Okay, how about this?

From 2777e654371dd4207a3a7f4fb5fa39550053a080 Mon Sep 17 00:00:00 2001
From: Randall Huang <huangrandall@google.com>
Date: Thu, 11 Apr 2019 16:26:46 +0800
Subject: [PATCH] f2fs: fix to avoid accessing xattr across the boundary

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

Signed-off-by: Randall Huang <huangrandall@google.com>
[Jaegeuk Kim: Fix wrong ending boundary]
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.c | 36 +++++++++++++++++++++++++++---------
 fs/f2fs/xattr.h |  2 ++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 848a785abe25..e791741d193b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -202,12 +202,17 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
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
+			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr)
+			return NULL;
+
 		if (entry->e_name_index != index)
 			continue;
 		if (entry->e_name_len != len)
@@ -297,20 +302,22 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				const char *name, struct f2fs_xattr_entry **xe,
 				void **base_addr, int *base_size)
 {
-	void *cur_addr, *txattr_addr, *last_addr = NULL;
+	void *cur_addr, *txattr_addr, *last_txattr_addr;
+	void *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
 	unsigned int inline_size = inline_xattr_size(inode);
 	int err = 0;
 
-	if (!size && !inline_size)
+	if (!xnid && !inline_size)
 		return -ENODATA;
 
-	*base_size = inline_size + size + XATTR_PADDING_SIZE;
+	*base_size = XATTR_SIZE(xnid, inode) + XATTR_PADDING_SIZE;
 	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
+	last_txattr_addr = (void *)txattr_addr + XATTR_SIZE(xnid, inode);
+
 	/* read from inline xattr */
 	if (inline_size) {
 		err = read_inline_xattr(inode, ipage, txattr_addr);
@@ -337,7 +344,11 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
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
@@ -581,7 +592,8 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			struct page *ipage, int flags)
 {
 	struct f2fs_xattr_entry *here, *last;
-	void *base_addr;
+	void *base_addr, *last_base_addr;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	int found, newsize;
 	size_t len;
 	__u32 new_hsize;
@@ -605,8 +617,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (error)
 		return error;
 
+	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+
 	/* find entry with wanted name. */
-	here = __find_xattr(base_addr, index, len, name);
+	here = __find_xattr(base_addr, last_base_addr, index, len, name);
+	if (!here) {
+		error = -EFAULT;
+		goto exit;
+	}
 
 	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 9172ee082ca8..a90920e2f949 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -71,6 +71,8 @@ struct f2fs_xattr_entry {
 				entry = XATTR_NEXT_ENTRY(entry))
 #define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
 #define XATTR_PADDING_SIZE	(sizeof(__u32))
+#define XATTR_SIZE(x,i)		(((x) ? VALID_XATTR_BLOCK_SIZE : 0) +	\
+						(inline_xattr_size(i)))
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
 						VALID_XATTR_BLOCK_SIZE)
 
-- 
2.19.0.605.g01d371f741-goog

