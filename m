Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD67C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CE220863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Iz5jlPC3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MVmqb9p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfCDD7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:59:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCDD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:59:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A58D8606CF; Mon,  4 Mar 2019 03:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551671955;
        bh=2TUrmt86MYLFFkvhslpp7nIdehyPFFbQTd4NMtx9JxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz5jlPC3NBxcdgR1I9yv/fUqVng8aFxNizTOuml0ByuRF9fZja62RaJFTWxuD8R8F
         CB/yBvfEFvLRt0yIQ7mHuv7HzswErWC82eBWaH+J8m4oX9va9us0ybuXM6EMeMHNgs
         gfk7jaZk0zN7k/qX7ROHT+Y1TK6hJJ0PRyYpe8Vg=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 046FD606CF;
        Mon,  4 Mar 2019 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551671954;
        bh=2TUrmt86MYLFFkvhslpp7nIdehyPFFbQTd4NMtx9JxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVmqb9p6C3gGLtdQ6omg8z2R3Hu+qVnI89gLEqRPBrFBEdXPUmCx5qzF9IFcb21ce
         OZWRjU4+oJwI2j6C6Aimtm2nRXyvIQrEdJw6f+RmuKCNm6DLCMgsAGfNkK7nXgilq2
         2C4JnDEsG0u77859qN3DXUZ9YG0TKsud5EAMcE/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 046FD606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 4 Mar 2019 09:29:09 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check with
 inode.i_inline_xattr_size
Message-ID: <20190304035909.GA8377@codeaurora.org>
References: <20190301073805.413-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301073805.413-1-yuchao0@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:38:05PM +0800, Chao Yu wrote:
> As Paul Bandha reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202709
> 
> When I run the poc on the mounted f2fs img I get a buffer overflow in
> read_inline_xattr due to there being no sanity check on the value of
> i_inline_xattr_size.
> 
> I created the img by just modifying the value of i_inline_xattr_size
> in the inode:
> 
> i_name                        		[test1.txt]
> i_ext: fofs:0 blkaddr:0 len:0
> i_extra_isize                 		[0x      18 : 24]
> i_inline_xattr_size           		[0x    ffff : 65535]
> i_addr[ofs]                   		[0x       0 : 0]
> 
> mkdir /mnt/f2fs
> mount ./f2fs1.img /mnt/f2fs
> gcc poc.c -o poc
> ./poc
> 
> int main() {
> 	int y = syscall(SYS_listxattr, "/mnt/f2fs/test1.txt", NULL, 0);
> 	printf("ret %d", y);
> 	printf("errno: %d\n", errno);
> 
> }
> 
>  BUG: KASAN: slab-out-of-bounds in read_inline_xattr+0x18f/0x260
>  Read of size 262140 at addr ffff88011035efd8 by task f2fs1poc/3263
> 
>  CPU: 0 PID: 3263 Comm: f2fs1poc Not tainted 4.18.0-custom #1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
>  Call Trace:
>   dump_stack+0x71/0xab
>   print_address_description+0x83/0x250
>   kasan_report+0x213/0x350
>   memcpy+0x1f/0x50
>   read_inline_xattr+0x18f/0x260
>   read_all_xattrs+0xba/0x190
>   f2fs_listxattr+0x9d/0x3f0
>   listxattr+0xb2/0xd0
>   path_listxattr+0x93/0xe0
>   do_syscall_64+0x9d/0x220
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Let's add sanity check for inode.i_inline_xattr_size during f2fs_iget()
> to avoid this issue.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 14 ++++++++++++++
>  fs/f2fs/super.c |  7 ++-----
>  fs/f2fs/xattr.h |  9 +++++++++
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bec52961630b..b132fe2ff779 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -14,6 +14,7 @@
>  #include "f2fs.h"
>  #include "node.h"
>  #include "segment.h"
> +#include "xattr.h"
>  
>  #include <trace/events/f2fs.h>
>  
> @@ -248,6 +249,19 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		return false;
>  	}
>  
> +	if (f2fs_has_extra_attr(inode) &&
> +		f2fs_sb_has_flexible_inline_xattr(sbi) &&
> +		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
> +		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"%s: inode (ino=%lx) has corrupted "
> +			"i_inline_xattr_size: %d, min: %zu, max: %zu",
> +			__func__, inode->i_ino, fi->i_inline_xattr_size,
> +			MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
> +		return false;
> +	}
> +
>  	if (F2FS_I(inode)->extent_tree) {
>  		struct extent_info *ei = &F2FS_I(inode)->extent_tree->largest;
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 42eb5c86330a..9184b7524c03 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -835,12 +835,9 @@ static int parse_options(struct super_block *sb, char *options)
>  			return -EINVAL;
>  		}
>  		if (F2FS_OPTION(sbi).inline_xattr_size <
> -			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
> +			MIN_INLINE_XATTR_SIZE ||
>  			F2FS_OPTION(sbi).inline_xattr_size >
> -			DEF_ADDRS_PER_INODE -
> -			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
> -			DEF_INLINE_RESERVED_SIZE -
> -			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
> +			MAX_INLINE_XATTR_SIZE) {
>  			f2fs_msg(sb, KERN_ERR,
>  					"inline xattr size is out of range");
>  			return -EINVAL;
> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> index 67db134da0f5..94e8a5eeaae1 100644
> --- a/fs/f2fs/xattr.h
> +++ b/fs/f2fs/xattr.h
> @@ -55,6 +55,8 @@ struct f2fs_xattr_entry {
>  #define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr) + 1))
>  #define XATTR_ROUND		(3)
>  
> +#define XATTR_HDR_SIZE		(sizeof(struct f2fs_xattr_header))
> +
>  #define XATTR_ALIGN(size)	(((size) + XATTR_ROUND) & ~XATTR_ROUND)
>  
>  #define ENTRY_SIZE(entry) (XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + \
> @@ -78,6 +80,13 @@ struct f2fs_xattr_entry {
>  				sizeof(struct f2fs_xattr_header) -	\
>  				sizeof(struct f2fs_xattr_entry))
>  
> +#define MAX_INLINE_XATTR_SIZE	(XATTR_HDR_SIZE / sizeof(__le32))

I think this should be MIN_INLINE_XATTR_SIZE.

> +#define MIN_INLINE_XATTR_SIZE						\
> +			(DEF_ADDRS_PER_INODE -				\
> +			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
> +			DEF_INLINE_RESERVED_SIZE -			\
> +			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
> +

And this should be MAX_INLINE_XATTR_SIZE.

Thanks,
Sahitya.

>  /*
>   * On-disk structure of f2fs_xattr
>   * We use inline xattrs space + 1 block for xattr.
> -- 
> 2.18.0.rc1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
