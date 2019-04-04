Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DFCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D14214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDDNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDNjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:39:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F6220855;
        Thu,  4 Apr 2019 13:39:09 +0000 (UTC)
Date:   Thu, 4 Apr 2019 09:39:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V32 27/27] tracefs: Restrict tracefs when the kernel is
 locked down
Message-ID: <20190404093907.153f52a8@gandalf.local.home>
In-Reply-To: <20190404003249.14356-28-matthewgarrett@google.com>
References: <20190404003249.14356-1-matthewgarrett@google.com>
        <20190404003249.14356-28-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 17:32:49 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:


> +static void tracefs_destroy_inode(struct inode *inode)
> +{
> +	if S_ISREG(inode->i_mode)

Can we please put parenthesis around the condition. I know that the
macro has them, but no other place in the kernel plays such a trick.

	if (S_ISREG(inode->i_mode))

Other than that, the rest looks good.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +		kfree(inode->i_fop);
> +}
> +
>  static int tracefs_remount(struct super_block *sb, int *flags, char *data)
>  {
>  	int err;
> @@ -260,6 +288,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
>  
>  static const struct super_operations tracefs_super_operations = {
>  	.statfs		= simple_statfs,
> +	.destroy_inode  = tracefs_destroy_inode,
>  	.remount_fs	= tracefs_remount,
>  	.show_options	= tracefs_show_options,
>  };
> @@ -393,6 +422,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  {
>  	struct dentry *dentry;
>  	struct inode *inode;
> +	struct file_operations *proxy_fops;
>  
>  	if (!(mode & S_IFMT))
>  		mode |= S_IFREG;
> @@ -406,8 +436,16 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> +	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
> +	if (!proxy_fops)
> +		return failed_creating(dentry);
> +
> +	dentry->d_fsdata = fops ? (void *)fops :
> +		(void *)&tracefs_file_operations;
> +	memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
> +	proxy_fops->open = default_open_file;
>  	inode->i_mode = mode;
> -	inode->i_fop = fops ? fops : &tracefs_file_operations;
> +	inode->i_fop = proxy_fops;
>  	inode->i_private = data;
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);

