Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E660C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5EF2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfDJKRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:17:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730063AbfDJKRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:17:10 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5EE0760D70C5F92D31B1;
        Wed, 10 Apr 2019 18:17:08 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 10 Apr 2019 18:17:08 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Apr 2019 18:17:07 +0800
Subject: Re: [PATCH v4] f2fs: fix to avoid accessing xattr across the boundary
To:     Randall Huang <huangrandall@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190410092730.72358-1-huangrandall@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <12f851b1-f85a-f874-2e71-e74688ae9a23@huawei.com>
Date:   Wed, 10 Apr 2019 18:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190410092730.72358-1-huangrandall@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/10 17:27, Randall Huang wrote:
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
> ---
>  fs/f2fs/xattr.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 848a785abe25..a1cf53c727b2 100644
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
> @@ -311,6 +318,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  	if (!txattr_addr)
>  		return -ENOMEM;
>  
> +	last_txattr_addr = (void *)txattr_addr + inline_size + size +
> +				XATTR_PADDING_SIZE - 1

The reserved 4 (XATTR_PADDING_SIZE) bytes space is not exist in on-disk layout, it only existS
in memory space. We keep this reserved space for the condition that all space of xattr are
valid, and in __find_xattr(), @entry will point to this space after entry =
XATTR_NEXT_ENTRY(entry), and since the reserved space is always zeroed, then the loop can end
up due to !IS_XATTR_LAST_ENTRY(entry) condition.

So any entry touches or crosses the reserved space, that's illegal.

You can check the layout in below commit. :)

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?id=22588f8773f687449ce6e97dce9f102553440d30

So, how about this?

last_txattr_addr = txattr_addr + inline_size + size;

if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
	(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr)
	return NULL;

Thanks,

> +
>  	/* read from inline xattr */
>  	if (inline_size) {
>  		err = read_inline_xattr(inode, ipage, txattr_addr);
> @@ -337,7 +347,11 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  	else
>  		cur_addr = txattr_addr;
>  
> -	*xe = __find_xattr(cur_addr, index, len, name);
> +	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
> +	if (!*xe) {
> +		err = -EFAULT;
> +		goto out;
> +	}
>  check:
>  	if (IS_XATTR_LAST_ENTRY(*xe)) {
>  		err = -ENODATA;
> @@ -581,10 +595,15 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  			struct page *ipage, int flags)
>  {
>  	struct f2fs_xattr_entry *here, *last;
> -	void *base_addr;
> +	void *base_addr, *last_base_addr = NULL;
>  	int found, newsize;
>  	size_t len;
>  	__u32 new_hsize;
> +	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> +	unsigned int xattr_nid_size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
> +	unsigned int inline_size = inline_xattr_size(inode);
> +	unsigned int max_size = inline_size + xattr_nid_size +
> +				 XATTR_PADDING_SIZE;
>  	int error = 0;
>  
>  	if (name == NULL)
> @@ -604,9 +623,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  	error = read_all_xattrs(inode, ipage, &base_addr);
>  	if (error)
>  		return error;
> +	last_base_addr = (void *)base_addr + max_size - 1;
>  
>  	/* find entry with wanted name. */
> -	here = __find_xattr(base_addr, index, len, name);
> +	here = __find_xattr(base_addr, last_base_addr, index, len, name);
> +	if (!here) {
> +		error = -EFAULT;
> +		goto exit;
> +	}
>  
>  	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
>  
> 
