Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A920656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfDVPDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:03:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbfDVPDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:03:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B53AC50CA159CD0BCAF;
        Mon, 22 Apr 2019 23:02:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Apr 2019
 23:02:29 +0800
Subject: Re: [PATCH] dcache: ensure d_flags & d_inode are consistent in
 lookup_fast()
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20190419084810.63732-1-houtao1@huawei.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <69981458-59dc-277d-c66d-2620cff7bb57@huawei.com>
Date:   Mon, 22 Apr 2019 23:02:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190419084810.63732-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On 2019/4/19 16:48, Hou Tao wrote:
> After extending the size of dentry from 192-bytes to 208-bytes
> under aarch64, we got oops during the running of xfstests generic/429:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000002
>   CPU: 3 PID: 2725 Comm: t_encrypted_d_r Tainted: G      D           5.1.0-rc4
>   pc : inode_permission+0x28/0x160
>   lr : link_path_walk.part.11+0x27c/0x528
>   ......
>   Call trace:
>    inode_permission+0x28/0x160
>    link_path_walk.part.11+0x27c/0x528
>    path_lookupat+0x64/0x208
>    filename_lookup+0xa0/0x178
>    user_path_at_empty+0x58/0x70
>    vfs_statx+0x94/0x118
>    __se_sys_newfstatat+0x58/0x98
>    __arm64_sys_newfstatat+0x24/0x30
>    el0_svc_common+0x7c/0x148
>    el0_svc_handler+0x38/0x88
>    el0_svc+0x8/0xc
> 
> If we revert the size extension of dentry, the oops will be gone.
> However if we just move the d_inode field from the begin of dentry
> struct to the end of dentry struct (poorly simulate the way how
> __randomize_layout works), the oops will reoccur.
> 
> The following scenario illustrates the problem:
> 
> precondition:
> * dentry A has just been unlinked and becomes a negative dentry
> * dentry A is encrypted, so it has d_revalidate hook: fscrypt_d_revalidate()
> * lookup process is looking A/file, and creation process is creating A
> 
> lookup process:                 creation process:
> 
> lookup_fast
>     __d_lookup_rcu returns dentry A
> 
>     d_revalidate returns -ECHILD
> 
>     d_revalidate again succeed
> 				__d_set_inode_and_type
> 				dentry->d_inode = inode
> 				WRITE_ONCE(dentry->d_flags, flags)
> 
>     d_is_negative(dentry) return false
>     follow_managed doesn't nothing
>     // inconsistent with d_flags
>     d_backing_inode() return NULL
>     nd->inode = NULL
> 
> may_lookup()
>     // oops occurs
>     inode_permission(nd->inode
> 
> The root cause is the inconsistency between d_flags & d_inode
> during the REF-walk in lookup_fast(): d_is_negative(dentry)
> returns false, but d_backing_inode() still returns a NULL pointer.
> 
> The RCU-walk path in lookup_fast() uses d_seq to ensure d_flags & d_inode
> are consistent, and lookup_slow() use inode lock to ensure that, so only
> the REF-walk path in lookup_fast() is problematic.
> 
> Fixing it by adding a paired smp_rmb/smp_wmb between the reading/writing
> of d_inode & d_flags to ensure the consistency.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/dcache.c | 2 ++
>  fs/namei.c  | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index aac41adf4743..1eb85f9fcb0f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -316,6 +316,8 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
>  	unsigned flags;
>  
>  	dentry->d_inode = inode;
> +	/* paired with smp_rmb() in lookup_fast() */
> +	smp_wmb();
>  	flags = READ_ONCE(dentry->d_flags);
>  	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>  	flags |= type_flags;
> diff --git a/fs/namei.c b/fs/namei.c
> index dede0147b3f6..833f760c70b2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1628,6 +1628,13 @@ static int lookup_fast(struct nameidata *nd,
>  		return -ENOENT;
>  	}
>  
> +	/*
> +	 * Paired with smp_wmb() in __d_set_inode_and_type() to ensure
> +	 * d_backing_inode is not NULL after the checking of d_flags
> +	 * in d_is_negative() completes.
> +	 */
> +	smp_rmb();
> +
>  	path->mnt = mnt;
>  	path->dentry = dentry;
>  	err = follow_managed(path, nd);
> 

