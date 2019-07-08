Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A12C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082A5208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfGHMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:45:11 -0400
Received: from fieldses.org ([173.255.197.46]:37704 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGHMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:45:11 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 18F757CB; Mon,  8 Jul 2019 08:45:10 -0400 (EDT)
Date:   Mon, 8 Jul 2019 08:45:10 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the vfs tree with the nfsd tree
Message-ID: <20190708124510.GB7625@fieldses.org>
References: <20190708110633.6e491989@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708110633.6e491989@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:06:33AM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/nfsd/nfsctl.c
> 
> between commits:
> 
>   e8a79fb14f6b ("nfsd: add nfsd/clients directory")
> 
> from the nfsd tree and commit:
> 
>   96a374a35f82 ("vfs: Convert nfsctl to use the new mount API")

I did a fetch of

	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

and looked at the "master" branch and couldn't find that vfs commit.  Am
I looking in the wrong place?

(I'm sure your resolution is fine, I just thought to be careful it might
be nice to run some tests on the merge.)

--b.

> 
> from the vfs tree.
> 
> I fixed it up (Maybe? see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/nfsd/nfsctl.c
> index 4683ba5c69c7,bbff9c4ac49f..000000000000
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@@ -1149,201 -1148,8 +1150,201 @@@ static ssize_t write_v4_end_grace(struc
>    *	populating the filesystem.
>    */
>   
>  +/* Basically copying rpc_get_inode. */
>  +static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
>  +{
>  +	struct inode *inode = new_inode(sb);
>  +	if (!inode)
>  +		return NULL;
>  +	/* Following advice from simple_fill_super documentation: */
>  +	inode->i_ino = iunique(sb, NFSD_MaxReserved);
>  +	inode->i_mode = mode;
>  +	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>  +	switch (mode & S_IFMT) {
>  +	case S_IFDIR:
>  +		inode->i_fop = &simple_dir_operations;
>  +		inode->i_op = &simple_dir_inode_operations;
>  +		inc_nlink(inode);
>  +	default:
>  +		break;
>  +	}
>  +	return inode;
>  +}
>  +
>  +static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  +{
>  +	struct inode *inode;
>  +
>  +	inode = nfsd_get_inode(dir->i_sb, mode);
>  +	if (!inode)
>  +		return -ENOMEM;
>  +	d_add(dentry, inode);
>  +	inc_nlink(dir);
>  +	fsnotify_mkdir(dir, dentry);
>  +	return 0;
>  +}
>  +
>  +static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *ncl, char *name)
>  +{
>  +	struct inode *dir = parent->d_inode;
>  +	struct dentry *dentry;
>  +	int ret = -ENOMEM;
>  +
>  +	inode_lock(dir);
>  +	dentry = d_alloc_name(parent, name);
>  +	if (!dentry)
>  +		goto out_err;
>  +	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
>  +	if (ret)
>  +		goto out_err;
>  +	if (ncl) {
>  +		d_inode(dentry)->i_private = ncl;
>  +		kref_get(&ncl->cl_ref);
>  +	}
>  +out:
>  +	inode_unlock(dir);
>  +	return dentry;
>  +out_err:
>  +	dentry = ERR_PTR(ret);
>  +	goto out;
>  +}
>  +
>  +static void clear_ncl(struct inode *inode)
>  +{
>  +	struct nfsdfs_client *ncl = inode->i_private;
>  +
>  +	inode->i_private = NULL;
>  +	synchronize_rcu();
>  +	kref_put(&ncl->cl_ref, ncl->cl_release);
>  +}
>  +
>  +
>  +struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
>  +{
>  +	struct nfsdfs_client *nc = inode->i_private;
>  +
>  +	if (nc)
>  +		kref_get(&nc->cl_ref);
>  +	return nc;
>  +}
>  +
>  +struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
>  +{
>  +	struct nfsdfs_client *nc;
>  +
>  +	rcu_read_lock();
>  +	nc = __get_nfsdfs_client(inode);
>  +	rcu_read_unlock();
>  +	return nc;
>  +}
>  +/* from __rpc_unlink */
>  +static void nfsdfs_remove_file(struct inode *dir, struct dentry *dentry)
>  +{
>  +	int ret;
>  +
>  +	clear_ncl(d_inode(dentry));
>  +	dget(dentry);
>  +	ret = simple_unlink(dir, dentry);
>  +	d_delete(dentry);
>  +	dput(dentry);
>  +	WARN_ON_ONCE(ret);
>  +}
>  +
>  +static void nfsdfs_remove_files(struct dentry *root)
>  +{
>  +	struct dentry *dentry, *tmp;
>  +
>  +	list_for_each_entry_safe(dentry, tmp, &root->d_subdirs, d_child) {
>  +		if (!simple_positive(dentry)) {
>  +			WARN_ON_ONCE(1); /* I think this can't happen? */
>  +			continue;
>  +		}
>  +		nfsdfs_remove_file(d_inode(root), dentry);
>  +	}
>  +}
>  +
>  +/* XXX: cut'n'paste from simple_fill_super; figure out if we could share
>  + * code instead. */
>  +static  int nfsdfs_create_files(struct dentry *root,
>  +					const struct tree_descr *files)
>  +{
>  +	struct inode *dir = d_inode(root);
>  +	struct inode *inode;
>  +	struct dentry *dentry;
>  +	int i;
>  +
>  +	inode_lock(dir);
>  +	for (i = 0; files->name && files->name[0]; i++, files++) {
>  +		if (!files->name)
>  +			continue;
>  +		dentry = d_alloc_name(root, files->name);
>  +		if (!dentry)
>  +			goto out;
>  +		inode = nfsd_get_inode(d_inode(root)->i_sb,
>  +					S_IFREG | files->mode);
>  +		if (!inode) {
>  +			dput(dentry);
>  +			goto out;
>  +		}
>  +		inode->i_fop = files->ops;
>  +		inode->i_private = __get_nfsdfs_client(dir);
>  +		d_add(dentry, inode);
>  +		fsnotify_create(dir, dentry);
>  +	}
>  +	inode_unlock(dir);
>  +	return 0;
>  +out:
>  +	nfsdfs_remove_files(root);
>  +	inode_unlock(dir);
>  +	return -ENOMEM;
>  +}
>  +
>  +/* on success, returns positive number unique to that client. */
>  +struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
>  +		struct nfsdfs_client *ncl, u32 id,
>  +		const struct tree_descr *files)
>  +{
>  +	struct dentry *dentry;
>  +	char name[11];
>  +	int ret;
>  +
>  +	sprintf(name, "%u", id);
>  +
>  +	dentry = nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
>  +	if (IS_ERR(dentry)) /* XXX: tossing errors? */
>  +		return NULL;
>  +	ret = nfsdfs_create_files(dentry, files);
>  +	if (ret) {
>  +		nfsd_client_rmdir(dentry);
>  +		return NULL;
>  +	}
>  +	return dentry;
>  +}
>  +
>  +/* Taken from __rpc_rmdir: */
>  +void nfsd_client_rmdir(struct dentry *dentry)
>  +{
>  +	struct inode *dir = d_inode(dentry->d_parent);
>  +	struct inode *inode = d_inode(dentry);
>  +	int ret;
>  +
>  +	inode_lock(dir);
>  +	nfsdfs_remove_files(dentry);
>  +	clear_ncl(inode);
>  +	dget(dentry);
>  +	ret = simple_rmdir(dir, dentry);
>  +	WARN_ON_ONCE(ret);
>  +	d_delete(dentry);
>  +	inode_unlock(dir);
>  +}
>  +
> - static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
> + static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>  +	struct nfsd_net *nn = net_generic(current->nsproxy->net_ns,
>  +							nfsd_net_id);
>  +	struct dentry *dentry;
>  +	int ret;
>  +
>   	static const struct tree_descr nfsd_files[] = {
>   		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
>   		[NFSD_Export_features] = {"export_features",
> @@@ -1372,23 -1178,33 +1373,39 @@@
>   #endif
>   		/* last one */ {""}
>   	};
> - 	get_net(sb->s_fs_info);
>  -
>  -	return simple_fill_super(sb, 0x6e667364, nfsd_files);
>  +	ret = simple_fill_super(sb, 0x6e667364, nfsd_files);
>  +	if (ret)
>  +		return ret;
>  +	dentry = nfsd_mkdir(sb->s_root, NULL, "clients");
>  +	if (IS_ERR(dentry))
>  +		return PTR_ERR(dentry);
>  +	nn->nfsd_client_dir = dentry;
>  +	return 0;
> + }
> + 
> + static int nfsd_fs_get_tree(struct fs_context *fc)
> + {
> + 	fc->s_fs_info = get_net(fc->net_ns);
> + 	return vfs_get_super(fc, vfs_get_keyed_super, nfsd_fill_super);
> + }
>   
> + static void nfsd_fs_free_fc(struct fs_context *fc)
> + {
> + 	if (fc->s_fs_info)
> + 		put_net(fc->s_fs_info);
>   }
>   
> - static struct dentry *nfsd_mount(struct file_system_type *fs_type,
> - 	int flags, const char *dev_name, void *data)
> + static const struct fs_context_operations nfsd_fs_context_ops = {
> + 	.free		= nfsd_fs_free_fc,
> + 	.get_tree	= nfsd_fs_get_tree,
> + };
> + 
> + static int nfsd_init_fs_context(struct fs_context *fc)
>   {
> - 	struct net *net = current->nsproxy->net_ns;
> - 	return mount_ns(fs_type, flags, data, net, net->user_ns, nfsd_fill_super);
> + 	put_user_ns(fc->user_ns);
> + 	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
> + 	fc->ops = &nfsd_fs_context_ops;
> + 	return 0;
>   }
>   
>   static void nfsd_umount(struct super_block *sb)


