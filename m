Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B4C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4820818
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557375467;
	bh=e/nF58KXEV4PV2cf9jYy/djGPemf2Y/3E5BDg03I7Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6U+3AI9UC6Q2JG1TgvTDmA41iJ2zZ/YYt3FAZ4DajVmGzL8mmSos1txeqBvTKiCW
	 Z8p0cHGvu//w//JNht7xh/7sSPVncvh7+NMbffcNSOBGAKr2ZwtqSfeM7qa3EOi3/C
	 /va8OeIWKMnivgTAiB28211Vmy/mQfwVj8T/voww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfEIEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfEIEPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:15:37 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1822C20818;
        Thu,  9 May 2019 04:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557375336;
        bh=e/nF58KXEV4PV2cf9jYy/djGPemf2Y/3E5BDg03I7Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcvhGvZTl1YsaI0lgCHKBQzPvzq0NS+UnVcy9djGx+rq79RzaQoYlk32wH4tj8sZ+
         +Ey5li/vdIWvOnspFYfYD5vzLoGmeQ51XIj587TgT6cK5TEYohelESVd+vPnODkzWA
         OikllE4ywuedNsn2ryA7UpbrkIUJrCOFKEbZjCVc=
Date:   Wed, 8 May 2019 21:15:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Randall Huang <huangrandall@google.com>
Cc:     yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
Message-ID: <20190509041535.GA62877@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190411082646.169977-1-huangrandall@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411082646.169977-1-huangrandall@google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Randall Huang wrote:
> When we traverse xattr entries via __find_xattr(),
> if the raw filesystem content is faked or any hardware failure occurs,
> out-of-bound error can be detected by KASAN.
> Fix the issue by introducing boundary check.
> 
> [   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
> [   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
> [   38.402935] c7   1827 Call trace:
> [   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
> [   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
> [   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
> [   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
> [   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
> [   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
> [   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
> [   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
> [   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
> [   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
> [   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
> [   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
> [   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
> [   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
> [   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
> [   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
> [   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
> [   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
> [   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
> [   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
> [   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
> [   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38
> 
> Bug: 126558260
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>
> ---
> v2:
> * return EFAULT if OOB error is detected
> 
> v3:
> * fix typo in setxattr()
> 
> v4:
> * change boundry definition
> 
> v5:
> * revise boundry definition
> ---
>  fs/f2fs/xattr.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 848a785abe25..587429e29a69 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -202,12 +202,18 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
>  	return handler;
>  }
>  
> -static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
> -					size_t len, const char *name)
> +static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
> +				void *last_base_addr, int index,
> +				size_t len, const char *name)
>  {
>  	struct f2fs_xattr_entry *entry;
>  
>  	list_for_each_xattr(entry, base_addr) {
> +		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
> +			(void *)XATTR_NEXT_ENTRY(entry) +
> +			sizeof(__u32) > last_base_addr)
> +			return NULL;
> +
>  		if (entry->e_name_index != index)
>  			continue;
>  		if (entry->e_name_len != len)
> @@ -298,6 +304,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  				void **base_addr, int *base_size)
>  {
>  	void *cur_addr, *txattr_addr, *last_addr = NULL;
> +	void *last_txattr_addr = NULL;
>  	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>  	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
>  	unsigned int inline_size = inline_xattr_size(inode);
> @@ -311,6 +318,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  	if (!txattr_addr)
>  		return -ENOMEM;
>  
> +	last_txattr_addr = (void *)txattr_addr + inline_size + size;

I just found this should be + XATTR_PADDING_SIZE. Otherwise, generic/026 fails.
Let me know, if there is any other concern below.

---
 fs/f2fs/xattr.c | 12 ++++--------
 fs/f2fs/xattr.h |  2 ++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 019778fb9a0d..cd199a09d436 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -306,19 +306,18 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	void *last_txattr_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
 	unsigned int inline_size = inline_xattr_size(inode);
 	int err = 0;
 
-	if (!size && !inline_size)
+	if (!xnid && !inline_size)
 		return -ENODATA;
 
-	*base_size = inline_size + size + XATTR_PADDING_SIZE;
+	*base_size = XATTR_SIZE(xnid, inode);
 	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
-	last_txattr_addr = (void *)txattr_addr + inline_size + size;
+	last_txattr_addr = (void *)txattr_addr + *base_size;
 
 	/* read from inline xattr */
 	if (inline_size) {
@@ -599,9 +598,6 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	size_t len;
 	__u32 new_hsize;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int xnode_size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
-	unsigned int inline_size = inline_xattr_size(inode);
-
 	int error = 0;
 
 	if (name == NULL)
@@ -621,7 +617,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	error = read_all_xattrs(inode, ipage, &base_addr);
 	if (error)
 		return error;
-	last_base_addr = (void *)base_addr + xnode_size + inline_size;
+	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
 
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, last_base_addr, index, len, name);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 9172ee082ca8..1eca1a2d996a 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -71,6 +71,8 @@ struct f2fs_xattr_entry {
 				entry = XATTR_NEXT_ENTRY(entry))
 #define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
 #define XATTR_PADDING_SIZE	(sizeof(__u32))
+#define XATTR_SIZE(x,i)		(((x) ? VALID_XATTR_BLOCK_SIZE : 0) +	\
+				(inline_xattr_size(i)) + XATTR_PADDING_SIZE)
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
 						VALID_XATTR_BLOCK_SIZE)
 
-- 
2.19.0.605.g01d371f741-goog

