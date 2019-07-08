Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4045C48BDB
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B313220673
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SCXEbxnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfGHBGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:06:40 -0400
Received: from ozlabs.org ([203.11.71.1]:33095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfGHBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:06:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hnMv1PJGz9sN1;
        Mon,  8 Jul 2019 11:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562547995;
        bh=o1UU0dWrbTV6KJ1vslD6z0w0UNwyF4zMRWajqkCJtEk=;
        h=Date:From:To:Cc:Subject:From;
        b=SCXEbxnmuliZoiuoDOH2OrFwhrEnKs7AEUqJqKIpGdneihFtf3kVQ8jIXIjDPJFPc
         quffKC9LtgS7DbLqfxnElmm4PdGW8b0IDcAVXOoj9oDCj3tTLYMvusvRU+3Ng9acan
         0XKaaAwsN4rIdNyyGZBG6lkH9IJmR1PAhymGnTx7n2hgiW5kEJGlnlw3G6Kl1USbcS
         6Zyd7wYWurkeQUUhZQNm0swO5ouibXdHexjXd44uzH2/+4ujgX3IN/zE3OToKoz9nJ
         z3Oo+O5NfvliGa2gpta4b0wCEESAPIHxYNG2Q00FtmIOabyj3lb8VlXT56eImN2ger
         FxRD9Il3DrrRA==
Date:   Mon, 8 Jul 2019 11:06:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the nfsd tree
Message-ID: <20190708110633.6e491989@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zD=el8UlQpqb7j7BNKG3I0Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zD=el8UlQpqb7j7BNKG3I0Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/nfsd/nfsctl.c

between commits:

  e8a79fb14f6b ("nfsd: add nfsd/clients directory")

from the nfsd tree and commit:

  96a374a35f82 ("vfs: Convert nfsctl to use the new mount API")

from the vfs tree.

I fixed it up (Maybe? see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/nfsctl.c
index 4683ba5c69c7,bbff9c4ac49f..000000000000
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@@ -1149,201 -1148,8 +1150,201 @@@ static ssize_t write_v4_end_grace(struc
   *	populating the filesystem.
   */
 =20
 +/* Basically copying rpc_get_inode. */
 +static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 +{
 +	struct inode *inode =3D new_inode(sb);
 +	if (!inode)
 +		return NULL;
 +	/* Following advice from simple_fill_super documentation: */
 +	inode->i_ino =3D iunique(sb, NFSD_MaxReserved);
 +	inode->i_mode =3D mode;
 +	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(in=
ode);
 +	switch (mode & S_IFMT) {
 +	case S_IFDIR:
 +		inode->i_fop =3D &simple_dir_operations;
 +		inode->i_op =3D &simple_dir_inode_operations;
 +		inc_nlink(inode);
 +	default:
 +		break;
 +	}
 +	return inode;
 +}
 +
 +static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t=
 mode)
 +{
 +	struct inode *inode;
 +
 +	inode =3D nfsd_get_inode(dir->i_sb, mode);
 +	if (!inode)
 +		return -ENOMEM;
 +	d_add(dentry, inode);
 +	inc_nlink(dir);
 +	fsnotify_mkdir(dir, dentry);
 +	return 0;
 +}
 +
 +static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_cli=
ent *ncl, char *name)
 +{
 +	struct inode *dir =3D parent->d_inode;
 +	struct dentry *dentry;
 +	int ret =3D -ENOMEM;
 +
 +	inode_lock(dir);
 +	dentry =3D d_alloc_name(parent, name);
 +	if (!dentry)
 +		goto out_err;
 +	ret =3D __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
 +	if (ret)
 +		goto out_err;
 +	if (ncl) {
 +		d_inode(dentry)->i_private =3D ncl;
 +		kref_get(&ncl->cl_ref);
 +	}
 +out:
 +	inode_unlock(dir);
 +	return dentry;
 +out_err:
 +	dentry =3D ERR_PTR(ret);
 +	goto out;
 +}
 +
 +static void clear_ncl(struct inode *inode)
 +{
 +	struct nfsdfs_client *ncl =3D inode->i_private;
 +
 +	inode->i_private =3D NULL;
 +	synchronize_rcu();
 +	kref_put(&ncl->cl_ref, ncl->cl_release);
 +}
 +
 +
 +struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
 +{
 +	struct nfsdfs_client *nc =3D inode->i_private;
 +
 +	if (nc)
 +		kref_get(&nc->cl_ref);
 +	return nc;
 +}
 +
 +struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
 +{
 +	struct nfsdfs_client *nc;
 +
 +	rcu_read_lock();
 +	nc =3D __get_nfsdfs_client(inode);
 +	rcu_read_unlock();
 +	return nc;
 +}
 +/* from __rpc_unlink */
 +static void nfsdfs_remove_file(struct inode *dir, struct dentry *dentry)
 +{
 +	int ret;
 +
 +	clear_ncl(d_inode(dentry));
 +	dget(dentry);
 +	ret =3D simple_unlink(dir, dentry);
 +	d_delete(dentry);
 +	dput(dentry);
 +	WARN_ON_ONCE(ret);
 +}
 +
 +static void nfsdfs_remove_files(struct dentry *root)
 +{
 +	struct dentry *dentry, *tmp;
 +
 +	list_for_each_entry_safe(dentry, tmp, &root->d_subdirs, d_child) {
 +		if (!simple_positive(dentry)) {
 +			WARN_ON_ONCE(1); /* I think this can't happen? */
 +			continue;
 +		}
 +		nfsdfs_remove_file(d_inode(root), dentry);
 +	}
 +}
 +
 +/* XXX: cut'n'paste from simple_fill_super; figure out if we could share
 + * code instead. */
 +static  int nfsdfs_create_files(struct dentry *root,
 +					const struct tree_descr *files)
 +{
 +	struct inode *dir =3D d_inode(root);
 +	struct inode *inode;
 +	struct dentry *dentry;
 +	int i;
 +
 +	inode_lock(dir);
 +	for (i =3D 0; files->name && files->name[0]; i++, files++) {
 +		if (!files->name)
 +			continue;
 +		dentry =3D d_alloc_name(root, files->name);
 +		if (!dentry)
 +			goto out;
 +		inode =3D nfsd_get_inode(d_inode(root)->i_sb,
 +					S_IFREG | files->mode);
 +		if (!inode) {
 +			dput(dentry);
 +			goto out;
 +		}
 +		inode->i_fop =3D files->ops;
 +		inode->i_private =3D __get_nfsdfs_client(dir);
 +		d_add(dentry, inode);
 +		fsnotify_create(dir, dentry);
 +	}
 +	inode_unlock(dir);
 +	return 0;
 +out:
 +	nfsdfs_remove_files(root);
 +	inode_unlock(dir);
 +	return -ENOMEM;
 +}
 +
 +/* on success, returns positive number unique to that client. */
 +struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 +		struct nfsdfs_client *ncl, u32 id,
 +		const struct tree_descr *files)
 +{
 +	struct dentry *dentry;
 +	char name[11];
 +	int ret;
 +
 +	sprintf(name, "%u", id);
 +
 +	dentry =3D nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 +	if (IS_ERR(dentry)) /* XXX: tossing errors? */
 +		return NULL;
 +	ret =3D nfsdfs_create_files(dentry, files);
 +	if (ret) {
 +		nfsd_client_rmdir(dentry);
 +		return NULL;
 +	}
 +	return dentry;
 +}
 +
 +/* Taken from __rpc_rmdir: */
 +void nfsd_client_rmdir(struct dentry *dentry)
 +{
 +	struct inode *dir =3D d_inode(dentry->d_parent);
 +	struct inode *inode =3D d_inode(dentry);
 +	int ret;
 +
 +	inode_lock(dir);
 +	nfsdfs_remove_files(dentry);
 +	clear_ncl(inode);
 +	dget(dentry);
 +	ret =3D simple_rmdir(dir, dentry);
 +	WARN_ON_ONCE(ret);
 +	d_delete(dentry);
 +	inode_unlock(dir);
 +}
 +
- static int nfsd_fill_super(struct super_block * sb, void * data, int sile=
nt)
+ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
  {
 +	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
 +							nfsd_net_id);
 +	struct dentry *dentry;
 +	int ret;
 +
  	static const struct tree_descr nfsd_files[] =3D {
  		[NFSD_List] =3D {"exports", &exports_nfsd_operations, S_IRUGO},
  		[NFSD_Export_features] =3D {"export_features",
@@@ -1372,23 -1178,33 +1373,39 @@@
  #endif
  		/* last one */ {""}
  	};
- 	get_net(sb->s_fs_info);
 -
 -	return simple_fill_super(sb, 0x6e667364, nfsd_files);
 +	ret =3D simple_fill_super(sb, 0x6e667364, nfsd_files);
 +	if (ret)
 +		return ret;
 +	dentry =3D nfsd_mkdir(sb->s_root, NULL, "clients");
 +	if (IS_ERR(dentry))
 +		return PTR_ERR(dentry);
 +	nn->nfsd_client_dir =3D dentry;
 +	return 0;
+ }
+=20
+ static int nfsd_fs_get_tree(struct fs_context *fc)
+ {
+ 	fc->s_fs_info =3D get_net(fc->net_ns);
+ 	return vfs_get_super(fc, vfs_get_keyed_super, nfsd_fill_super);
+ }
 =20
+ static void nfsd_fs_free_fc(struct fs_context *fc)
+ {
+ 	if (fc->s_fs_info)
+ 		put_net(fc->s_fs_info);
  }
 =20
- static struct dentry *nfsd_mount(struct file_system_type *fs_type,
- 	int flags, const char *dev_name, void *data)
+ static const struct fs_context_operations nfsd_fs_context_ops =3D {
+ 	.free		=3D nfsd_fs_free_fc,
+ 	.get_tree	=3D nfsd_fs_get_tree,
+ };
+=20
+ static int nfsd_init_fs_context(struct fs_context *fc)
  {
- 	struct net *net =3D current->nsproxy->net_ns;
- 	return mount_ns(fs_type, flags, data, net, net->user_ns, nfsd_fill_super=
);
+ 	put_user_ns(fc->user_ns);
+ 	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
+ 	fc->ops =3D &nfsd_fs_context_ops;
+ 	return 0;
  }
 =20
  static void nfsd_umount(struct super_block *sb)

--Sig_/zD=el8UlQpqb7j7BNKG3I0Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ilxkACgkQAVBC80lX
0GxIogf/a7v3bwum2jP0y0QLG3c3te1aqFIsEOeXMS8cVEYDMfwJvf1v1OYl3XzI
EpGF31f/TeGWHRtWuh1+3I7AGcTgwuugg9ZgDSYWA1gLM5o6trk25TvWjvjmNQfS
TXjWkiFGo9jMExwj0wVxT/AAiRjaUqwERwWChivxu6nNx3emm8D3+nawB7+Ec326
4StW99fZ4rs/YcJksPXwadmIGDHXEwzgf+nmsqjFftK+V9oI4v3s3luqMKjhm/a3
Gs7Pm+aLzjnJdhCMwO4t/I5SU4Hm+B+4Lk4P43mLR32dmSnzxJAKsfi7YzxsP7s+
YQAPQilwEZsDCm/GZu7FMnfDpgncjw==
=DvX0
-----END PGP SIGNATURE-----

--Sig_/zD=el8UlQpqb7j7BNKG3I0Y--
