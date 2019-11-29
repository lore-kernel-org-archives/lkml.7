Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07132217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575037337;
	bh=L4aT/ZaY0JmSR279+1eodoce9+qGFKKJ/R7APk7tZdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ejzpZk+IQl29gbd0DKOp5nxnusi6DUIbYzeJIKXnb7T20EbeiWl2HM+feX+pQtOma
	 vhsVCZTRNRrQQ/7mHmJ67KtL52DuvcgUbKqztkrhjz7mCX1h6CTk9woN/a00egqJuq
	 RQW6u5Vq5nav6I3KU9SaixXiPgJSRdHI6t2SwOFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK2OWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfK2OWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:22:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4E621736;
        Fri, 29 Nov 2019 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575037334;
        bh=L4aT/ZaY0JmSR279+1eodoce9+qGFKKJ/R7APk7tZdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZENaUpz1Y+16ppaBK7AIpH/BkEow9xgNp1m/F7Z7jeEonKXwqxGzBGpUAiLoLieo
         MX4gfs6LUTQCuj5mfY1lPXEhCsdLyCFH5fZCBy3fB7bsOvS7oHgsPG7EVeR3sqDf5V
         ZX1Bjlmn3xbHgJNvYrbM5rPtjhiQwtTiNPoWJQmg=
Date:   Fri, 29 Nov 2019 15:22:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 3/3] debugfs: introduce debugfs_create_seq[,_data]
Message-ID: <20191129142212.GB3708031@kroah.com>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
 <20191129092752.169902-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129092752.169902-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 05:27:52PM +0800, Kefeng Wang wrote:
> Like proc_create_seq[,_data] in procfs, introduce a similar
> debugfs_create_seq[,_data] function, which could drastically
> reduces the boilerplate code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  fs/debugfs/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/debugfs.h | 16 +++++++++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 68f0c4b19bef..77522717c9fb 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1107,7 +1107,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_regset32);
>  #endif /* CONFIG_HAS_IOMEM */
>  
>  struct debugfs_entry {
> -	int (*read)(struct seq_file *seq, void *data);
> +	union {
> +		const struct seq_operations *seq_ops;
> +		int (*read)(struct seq_file *seq, void *data);
> +	};
>  	void *data;
>  };
>  
> @@ -1196,3 +1199,60 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
>  				   &debugfs_entry_ops);
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_single_data);
> +
> +static int debugfs_entry_seq_open(struct inode *inode, struct file *file)
> +{
> +	struct debugfs_entry *entry = inode->i_private;
> +	int ret;
> +
> +	entry = debugfs_clear_lowest_bit(entry);
> +
> +	ret = seq_open(file, entry->seq_ops);
> +	if (!ret && entry->data) {
> +		struct seq_file *seq = file->private_data;
> +		seq->private = entry->data;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations debugfs_seq_fops = {
> +	.open		= debugfs_entry_seq_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +/**
> + * debugfs_create_seq_data - create a file in the debugfs filesystem
> + * @name: a pointer to a string containing the name of the file to create.
> + * @mode: the permission that the file should have.
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is NULL, then the
> + *          file will be created in the root of the debugfs filesystem.
> + * @data: a pointer to something that the caller will want to get to later
> + *        on.  The inode.i_private pointer will point to this value on
> + *        the open() call.
> + * @seq_ops: seq_operations pointer of the seqfile.
> + *
> + * This function creates a file in debugfs with the extra data and a seq_ops.
> + */
> +struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
> +				       struct dentry *parent, void *data,
> +				       const struct seq_operations *seq_ops)
> +{
> +	struct debugfs_entry *entry;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return ERR_PTR(-ENOMEM);
> +
> +	entry->seq_ops = seq_ops;
> +	entry->data = data;
> +
> +	entry = debugfs_set_lowest_bit(entry);
> +
> +	return debugfs_create_file(name, mode, parent, entry,
> +				   &debugfs_seq_fops);
> +}
> +EXPORT_SYMBOL_GPL(debugfs_create_seq_data);
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index 82171f183e93..d32d49983547 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -147,6 +147,10 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
>  					  int (*read_fn)(struct seq_file *s,
>  							 void *data));
>  
> +struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
> +				       struct dentry *parent, void *data,
> +				       const struct seq_operations *seq_ops);
> +
>  bool debugfs_initialized(void);
>  
>  ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,

If you notice, I have been removing the return value of the
debugfs_create_* functions over the past few kernel versions (look at
5.5-rc1 for a lot more).  Please don't add any new functions that also
return a dentry that I then need to go and remove.

Just have these be void functions, no need to return anything.

thanks,

greg k-h
