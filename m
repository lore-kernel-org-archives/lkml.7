Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B61218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfCUM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfCUM6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:58:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C393C218E2;
        Thu, 21 Mar 2019 12:58:37 +0000 (UTC)
Date:   Thu, 21 Mar 2019 08:58:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] vfs: Convert tracefs to fs_context
Message-ID: <20190321085836.3579c2b4@gandalf.local.home>
In-Reply-To: <155316887777.29437.11898477863408246585.stgit@warthog.procyon.org.uk>
References: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
        <155316887777.29437.11898477863408246585.stgit@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 11:47:57 +0000
David Howells <dhowells@redhat.com> wrote:

Very weak change log (none!). What is this fs_context, and why does it
need to change? Each patch should hold its own as a stand alone, as git
history shows a patch not a series, and the cover letters will get lost
over time.

-- Steve


> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
>  fs/tracefs/inode.c |  180 ++++++++++++++++++++++++----------------------------
>  1 file changed, 83 insertions(+), 97 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7098c49f3693..7ba64f38931f 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -16,12 +16,13 @@
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/kobject.h>
>  #include <linux/namei.h>
>  #include <linux/tracefs.h>
>  #include <linux/fsnotify.h>
>  #include <linux/seq_file.h>
> -#include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
>  
> @@ -138,73 +139,62 @@ static struct inode *tracefs_get_inode(struct super_block *sb)
>  	return inode;
>  }
>  
> -struct tracefs_mount_opts {
> +struct tracefs_fs_info {
>  	kuid_t uid;
>  	kgid_t gid;
>  	umode_t mode;
>  };
>  
>  enum {
> -	Opt_uid,
>  	Opt_gid,
>  	Opt_mode,
> -	Opt_err
> +	Opt_uid,
>  };
>  
> -static const match_table_t tokens = {
> -	{Opt_uid, "uid=%u"},
> -	{Opt_gid, "gid=%u"},
> -	{Opt_mode, "mode=%o"},
> -	{Opt_err, NULL}
> +static const struct fs_parameter_spec tracefs_param_specs[] = {
> +	fsparam_u32	("gid",				Opt_gid),
> +	fsparam_u32oct	("mode",			Opt_mode),
> +	fsparam_u32	("uid",				Opt_uid),
> +	{}
>  };
>  
> -struct tracefs_fs_info {
> -	struct tracefs_mount_opts mount_opts;
> +static const struct fs_parameter_description tracefs_fs_parameters = {
> +	.name		= "tracefs",
> +	.specs		= tracefs_param_specs,
>  };
>  
> -static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
> +static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	int token;
> +	struct tracefs_fs_info *opts = fc->s_fs_info;
> +	struct fs_parse_result result;
>  	kuid_t uid;
>  	kgid_t gid;
> -	char *p;
> -
> -	opts->mode = TRACEFS_DEFAULT_MODE;
> -
> -	while ((p = strsep(&data, ",")) != NULL) {
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_uid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(uid))
> -				return -EINVAL;
> -			opts->uid = uid;
> -			break;
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(gid))
> -				return -EINVAL;
> -			opts->gid = gid;
> -			break;
> -		case Opt_mode:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->mode = option & S_IALLUGO;
> -			break;
> +	int opt;
> +
> +	opt = fs_parse(fc, &tracefs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_uid:
> +		uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(uid))
> +			return invalf(fc, "Unknown uid");
> +		opts->uid = uid;
> +		break;
> +	case Opt_gid:
> +		gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(gid))
> +			return invalf(fc, "Unknown gid");
> +		opts->gid = gid;
> +		break;
> +	case Opt_mode:
> +		opts->mode = result.uint_32 & S_IALLUGO;
> +		break;
>  		/*
>  		 * We might like to report bad mount options here;
>  		 * but traditionally tracefs has ignored all mount options
>  		 */
> -		}
>  	}
>  
>  	return 0;
> @@ -214,100 +204,96 @@ static int tracefs_apply_options(struct super_block *sb)
>  {
>  	struct tracefs_fs_info *fsi = sb->s_fs_info;
>  	struct inode *inode = sb->s_root->d_inode;
> -	struct tracefs_mount_opts *opts = &fsi->mount_opts;
>  
>  	inode->i_mode &= ~S_IALLUGO;
> -	inode->i_mode |= opts->mode;
> +	inode->i_mode |= fsi->mode;
>  
> -	inode->i_uid = opts->uid;
> -	inode->i_gid = opts->gid;
> +	inode->i_uid = fsi->uid;
> +	inode->i_gid = fsi->gid;
>  
>  	return 0;
>  }
>  
> -static int tracefs_remount(struct super_block *sb, int *flags, char *data)
> +static int tracefs_reconfigure(struct fs_context *fc)
>  {
> -	int err;
> -	struct tracefs_fs_info *fsi = sb->s_fs_info;
> +	struct super_block *sb = fc->root->d_sb;
>  
>  	sync_filesystem(sb);
> -	err = tracefs_parse_options(data, &fsi->mount_opts);
> -	if (err)
> -		goto fail;
> -
> -	tracefs_apply_options(sb);
> -
> -fail:
> -	return err;
> +	return tracefs_apply_options(sb);
>  }
>  
>  static int tracefs_show_options(struct seq_file *m, struct dentry *root)
>  {
>  	struct tracefs_fs_info *fsi = root->d_sb->s_fs_info;
> -	struct tracefs_mount_opts *opts = &fsi->mount_opts;
>  
> -	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
> +	if (!uid_eq(fsi->uid, GLOBAL_ROOT_UID))
>  		seq_printf(m, ",uid=%u",
> -			   from_kuid_munged(&init_user_ns, opts->uid));
> -	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
> +			   from_kuid_munged(&init_user_ns, fsi->uid));
> +	if (!gid_eq(fsi->gid, GLOBAL_ROOT_GID))
>  		seq_printf(m, ",gid=%u",
> -			   from_kgid_munged(&init_user_ns, opts->gid));
> -	if (opts->mode != TRACEFS_DEFAULT_MODE)
> -		seq_printf(m, ",mode=%o", opts->mode);
> +			   from_kgid_munged(&init_user_ns, fsi->gid));
> +	if (fsi->mode != TRACEFS_DEFAULT_MODE)
> +		seq_printf(m, ",mode=%o", fsi->mode);
>  
>  	return 0;
>  }
>  
>  static const struct super_operations tracefs_super_operations = {
>  	.statfs		= simple_statfs,
> -	.remount_fs	= tracefs_remount,
>  	.show_options	= tracefs_show_options,
>  };
>  
> -static int trace_fill_super(struct super_block *sb, void *data, int silent)
> +static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	static const struct tree_descr trace_files[] = {{""}};
> -	struct tracefs_fs_info *fsi;
>  	int err;
>  
> -	fsi = kzalloc(sizeof(struct tracefs_fs_info), GFP_KERNEL);
> -	sb->s_fs_info = fsi;
> -	if (!fsi) {
> -		err = -ENOMEM;
> -		goto fail;
> -	}
> -
> -	err = tracefs_parse_options(data, &fsi->mount_opts);
> +	err = simple_fill_super(sb, TRACEFS_MAGIC, trace_files);
>  	if (err)
> -		goto fail;
> -
> -	err  =  simple_fill_super(sb, TRACEFS_MAGIC, trace_files);
> -	if (err)
> -		goto fail;
> +		return err;
>  
>  	sb->s_op = &tracefs_super_operations;
> +	return tracefs_apply_options(sb);
> +}
>  
> -	tracefs_apply_options(sb);
> -
> -	return 0;
> +static int tracefs_get_tree(struct fs_context *fc)
> +{
> +	return vfs_get_super(fc, vfs_get_single_reconf_super,
> +			     tracefs_fill_super);
> +}
>  
> -fail:
> -	kfree(fsi);
> -	sb->s_fs_info = NULL;
> -	return err;
> +static void tracefs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->s_fs_info);
>  }
>  
> -static struct dentry *trace_mount(struct file_system_type *fs_type,
> -			int flags, const char *dev_name,
> -			void *data)
> +static const struct fs_context_operations tracefs_context_ops = {
> +	.free		= tracefs_free_fc,
> +	.parse_param	= tracefs_parse_param,
> +	.get_tree	= tracefs_get_tree,
> +	.reconfigure	= tracefs_reconfigure,
> +};
> +
> +static int tracefs_init_fs_context(struct fs_context *fc)
>  {
> -	return mount_single(fs_type, flags, data, trace_fill_super);
> +	struct tracefs_fs_info *fsi;
> +
> +	fsi = kzalloc(sizeof(struct tracefs_fs_info), GFP_KERNEL);
> +	if (!fsi)
> +		return -ENOMEM;
> +
> +	fsi->mode = TRACEFS_DEFAULT_MODE;
> +
> +	fc->s_fs_info = fsi;
> +	fc->ops = &tracefs_context_ops;
> +	return 0;
>  }
>  
>  static struct file_system_type trace_fs_type = {
>  	.owner =	THIS_MODULE,
>  	.name =		"tracefs",
> -	.mount =	trace_mount,
> +	.init_fs_context = tracefs_init_fs_context,
> +	.parameters	= &tracefs_fs_parameters,
>  	.kill_sb =	kill_litter_super,
>  };
>  MODULE_ALIAS_FS("tracefs");

