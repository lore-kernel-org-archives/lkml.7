Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B408C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7D12070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCMGyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:54:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbfCMGyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:54:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8999273102FC477C1EC5;
        Wed, 13 Mar 2019 14:53:49 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 13 Mar
 2019 14:53:42 +0800
Subject: Re: [PATCH] [PATCH 1/1] staging: erofs: Add function comment for
 erofs/super.c
To:     Arshad Hussain <arshad.super@gmail.com>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
References: <20190312210640.2175-1-arshad.super@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <dbe33412-b801-bb46-c51f-eaada4a0fb77@huawei.com>
Date:   Wed, 13 Mar 2019 14:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190312210640.2175-1-arshad.super@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arshad,

On 2019/3/13 5:06, Arshad Hussain wrote:
> This patch adds functions comment for file erofs/super.c in
> sphinx format.
> 
> Signed-off-by: Arshad Hussain <arshad.super@gmail.com>
> ---

I think this patch is good, and could you revise your patch
as I pointed out in the previous email?

BTW, no need to duplicate [PATCH] [PATCH 1/1], the subject line can just be 
[PATCH] staging: erofs: Add function comment for erofs/super.c

Thanks,
Gao Xiang

>  drivers/staging/erofs/super.c | 135 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 15c784fba879..60bfc3e8db7a 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -30,6 +30,11 @@ static void init_once(void *ptr)
>  	inode_init_once(&vi->vfs_inode);
>  }
>  
> +/**
> + * erofs_init_inode_cache(): Create & initialize inode cache
> + *
> + * Returns: 0 on Success. Errno Otherwise.
> + */
>  static int __init erofs_init_inode_cache(void)
>  {
>  	erofs_inode_cachep = kmem_cache_create("erofs_inode",
> @@ -39,11 +44,21 @@ static int __init erofs_init_inode_cache(void)
>  	return erofs_inode_cachep != NULL ? 0 : -ENOMEM;
>  }
>  
> +/**
> + * erofs_exit_inode_cache(): Destroy inode cache
> + */
>  static void erofs_exit_inode_cache(void)
>  {
>  	kmem_cache_destroy(erofs_inode_cachep);
>  }
>  
> +/**
> + * alloc_inode(): Allocate and initialize inode
> + *
> + * @sb: VFS superblock structure
> + *
> + * Returns: Pointer to inode structure
> + */
>  static struct inode *alloc_inode(struct super_block *sb)
>  {
>  	struct erofs_vnode *vi =
> @@ -57,6 +72,11 @@ static struct inode *alloc_inode(struct super_block *sb)
>  	return &vi->vfs_inode;
>  }
>  
> +/**
> + * i_callback(): Release slab Memory
> + *
> + * @head: RCU callback structure
> + */
>  static void i_callback(struct rcu_head *head)
>  {
>  	struct inode *inode = container_of(head, struct inode, i_rcu);
> @@ -71,11 +91,23 @@ static void i_callback(struct rcu_head *head)
>  	kmem_cache_free(erofs_inode_cachep, vi);
>  }
>  
> +/**
> + * destroy_inode(): Release Inode Resources allocated by alloc_inode()
> + *
> + * @inode: VFS Inode structure
> + */
>  static void destroy_inode(struct inode *inode)
>  {
>  	call_rcu(&inode->i_rcu, i_callback);
>  }
>  
> +/**
> + * superblock_read(): Read superblock into buffer
> + *
> + * @sb: VFS Superblock structure
> + *
> + * Returns: 0 on Success. Errno otherwise
> + */
>  static int superblock_read(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
> @@ -230,6 +262,14 @@ static match_table_t erofs_tokens = {
>  	{Opt_err, NULL}
>  };
>  
> +/**
> + * parse_options(): Parse and set additional mount option for erofs
> + *
> + * @sb: VFS superblock structure
> + * @options: Mount options
> + *
> + * Returns: 0 on Success. Errno otherwise
> + */
>  static int parse_options(struct super_block *sb, char *options)
>  {
>  	substring_t args[MAX_OPT_ARGS];
> @@ -351,6 +391,22 @@ static struct inode *erofs_init_managed_cache(struct super_block *sb)
>  
>  #endif
>  
> +/**
> + * erofs_read_super(): Helper function to erofs_fill_super()
> + *
> + * @sb: VFS superblock structure
> + * @dev_name: Name of device where erofs is mounted
> + * @data: Additional mount options
> + * @silent: if TRUE print message on error.
> + * 	    Silent/quite otherwise
> + *
> + * Helper function to actual callback function erofs_fill_super
> + * This function sets the blocksize. Reads the superblock into
> + * buffer. Parses and sets mount options. Populates root inode
> + * and creates root directory.
> + *
> + * Returns: 0 on Success. Errno otherwise
> + */
>  static int erofs_read_super(struct super_block *sb,
>  	const char *dev_name, void *data, int silent)
>  {
> @@ -472,8 +528,12 @@ static int erofs_read_super(struct super_block *sb,
>  	return err;
>  }
>  
> -/*
> - * could be triggered after deactivate_locked_super()
> +/**
> + * erofs_put_super(): Free superblock structure
> + *
> + * @sb: VFS superblock structure
> + *
> + * Could be triggered after deactivate_locked_super()
>   * is called, thus including umount and failed to initialize.
>   */
>  static void erofs_put_super(struct super_block *sb)
> @@ -513,7 +573,20 @@ struct erofs_mount_private {
>  	char *options;
>  };
>  
> -/* support mount_bdev() with options */
> +/**
> + * erofs_fill_super(): Fill erofs superblock
> + *
> + * @sb: VFS superblock structure
> + * @_priv: Additional Mount options
> + * @silent: if TRUE print message on error.
> + * 	    Silent/quite otherwise
> + *
> + * This function fills erofs superblock information into
> + * the VFS superblock stucture. Additionally it supports
> + * mount_bdev() with options
> + *
> + * Returns: 0 on Success
> + */
>  static int erofs_fill_super(struct super_block *sb,
>  	void *_priv, int silent)
>  {
> @@ -523,6 +596,17 @@ static int erofs_fill_super(struct super_block *sb,
>  		priv->options, silent);
>  }
>  
> +/**
> + * erofs_mount(): Function called when erofs is mounted
> + *
> + * @fs_type: Describes the erofs filesystem
> + * @flags: Mount flags/options
> + * @dev_name: Name of device where erofs is mounted
> + * @data: Mount options
> + *
> + * Returns: Pointer to VFS dentry structure.
> + * 	    The root dentry.
> + */
>  static struct dentry *erofs_mount(
>  	struct file_system_type *fs_type, int flags,
>  	const char *dev_name, void *data)
> @@ -532,10 +616,21 @@ static struct dentry *erofs_mount(
>  		.options = data
>  	};
>  
> +	/*
> +	 * Mount filesystem residing on a block device
> +	 * provide a callback (erofs_fill_super)  to
> +	 * populate superblock
> +	 */
>  	return mount_bdev(fs_type, flags, dev_name,
>  		&priv, erofs_fill_super);
>  }
>  
> +/**
> + * erofs_kill_sb(): Called when erofs is getting shutdown/killed 
> + *
> + * @sb: VFS superblock structure
> + *
> + */
>  static void erofs_kill_sb(struct super_block *sb)
>  {
>  	kill_block_super(sb);
> @@ -550,6 +645,11 @@ static struct file_system_type erofs_fs_type = {
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> +/**
> + * erofs_module_init(): Called when module is loaded
> + *
> + * returns: 0 on Success. Error Otherwise
> + */
>  static int __init erofs_module_init(void)
>  {
>  	int err;
> @@ -586,6 +686,9 @@ static int __init erofs_module_init(void)
>  	return err;
>  }
>  
> +/**
> + * erofs_module_exit(): Called when module is un-loaded
> + */
>  static void __exit erofs_module_exit(void)
>  {
>  	unregister_filesystem(&erofs_fs_type);
> @@ -595,7 +698,14 @@ static void __exit erofs_module_exit(void)
>  	infoln("successfully finalize erofs");
>  }
>  
> -/* get filesystem statistics */
> +/**
> + * erofs_statfs(): Get erofs statistics
> + *
> + * @dentry: Directory from where stats is collected
> + * @buf: Buffer where stats info is stored
> + *
> + * Returns: 0 on Success
> + */
>  static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
> @@ -617,6 +727,14 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> +/**
> + * erofs_show_options(): Show currently active mount options
> + *
> + * @seq: Sequence interface (iterator)
> + * @root: VFS dentry structure of mounted FS
> + *
> + * Returns: 0 on Success, < 0 on error
> + */
>  static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  {
>  	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
> @@ -639,6 +757,15 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  	return 0;
>  }
>  
> +/**
> + * erofs_remount(): Called when erofs is remounted
> + *
> + * @sb: VFS superblock structure
> + * @flags: Mount flags/options
> + * @data: Mount options
> + *
> + * Returns: 0 on Success. Errno otherwise
> + */
>  static int erofs_remount(struct super_block *sb, int *flags, char *data)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> 
