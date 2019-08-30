Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03102C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB20621874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfH3LeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:34:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50852 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfH3LeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:34:24 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i3fAb-00059e-KL; Fri, 30 Aug 2019 11:34:21 +0000
Date:   Fri, 30 Aug 2019 13:34:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 3/4] binder: Make transaction_log available in binderfs
Message-ID: <20190830113420.ikbjj37cn5qvlhmk@wittgenstein>
References: <20190829211812.32520-1-hridya@google.com>
 <20190829211812.32520-4-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829211812.32520-4-hridya@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 02:18:11PM -0700, Hridya Valsaraju wrote:
> Currently, the binder transaction log files 'transaction_log'
> and 'failed_transaction_log' live in debugfs at the following locations:
> 
> /sys/kernel/debug/binder/failed_transaction_log
> /sys/kernel/debug/binder/transaction_log
> 
> This patch makes these files also available in a binderfs instance
> mounted with the mount option "stats=global".
> It does not affect the presence of these files in debugfs.
> If a binderfs instance is mounted at path /dev/binderfs, the location of
> these files will be as follows:
> 
> /dev/binderfs/binder_logs/failed_transaction_log
> /dev/binderfs/binder_logs/transaction_log
> 
> This change provides an alternate option to access these files when
> debugfs is not mounted.
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

(If you don't change this patch in the next version, please just keep my:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

when sending it out. :)

> ---
> 
>  Changes in v2:
>  -Consistent variable naming accross functions as per Christian Brauner.
> 
>  drivers/android/binder.c          | 34 +++++--------------------------
>  drivers/android/binder_internal.h | 30 +++++++++++++++++++++++++++
>  drivers/android/binderfs.c        | 18 ++++++++++++++++
>  3 files changed, 53 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index de795bd229c4..bed217310197 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -197,30 +197,8 @@ static inline void binder_stats_created(enum binder_stat_types type)
>  	atomic_inc(&binder_stats.obj_created[type]);
>  }
>  
> -struct binder_transaction_log_entry {
> -	int debug_id;
> -	int debug_id_done;
> -	int call_type;
> -	int from_proc;
> -	int from_thread;
> -	int target_handle;
> -	int to_proc;
> -	int to_thread;
> -	int to_node;
> -	int data_size;
> -	int offsets_size;
> -	int return_error_line;
> -	uint32_t return_error;
> -	uint32_t return_error_param;
> -	const char *context_name;
> -};
> -struct binder_transaction_log {
> -	atomic_t cur;
> -	bool full;
> -	struct binder_transaction_log_entry entry[32];
> -};
> -static struct binder_transaction_log binder_transaction_log;
> -static struct binder_transaction_log binder_transaction_log_failed;
> +struct binder_transaction_log binder_transaction_log;
> +struct binder_transaction_log binder_transaction_log_failed;
>  
>  static struct binder_transaction_log_entry *binder_transaction_log_add(
>  	struct binder_transaction_log *log)
> @@ -6166,7 +6144,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
>  			"\n" : " (incomplete)\n");
>  }
>  
> -static int transaction_log_show(struct seq_file *m, void *unused)
> +int binder_transaction_log_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_transaction_log *log = m->private;
>  	unsigned int log_cur = atomic_read(&log->cur);
> @@ -6198,8 +6176,6 @@ const struct file_operations binder_fops = {
>  	.release = binder_release,
>  };
>  
> -DEFINE_SHOW_ATTRIBUTE(transaction_log);
> -
>  static int __init init_binder_device(const char *name)
>  {
>  	int ret;
> @@ -6268,12 +6244,12 @@ static int __init binder_init(void)
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    &binder_transaction_log,
> -				    &transaction_log_fops);
> +				    &binder_transaction_log_fops);
>  		debugfs_create_file("failed_transaction_log",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    &binder_transaction_log_failed,
> -				    &transaction_log_fops);
> +				    &binder_transaction_log_fops);
>  	}
>  
>  	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 12ef96f256c6..b9be42d9464c 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -65,4 +65,34 @@ DEFINE_SHOW_ATTRIBUTE(binder_state);
>  
>  int binder_transactions_show(struct seq_file *m, void *unused);
>  DEFINE_SHOW_ATTRIBUTE(binder_transactions);
> +
> +int binder_transaction_log_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(binder_transaction_log);
> +
> +struct binder_transaction_log_entry {
> +	int debug_id;
> +	int debug_id_done;
> +	int call_type;
> +	int from_proc;
> +	int from_thread;
> +	int target_handle;
> +	int to_proc;
> +	int to_thread;
> +	int to_node;
> +	int data_size;
> +	int offsets_size;
> +	int return_error_line;
> +	uint32_t return_error;
> +	uint32_t return_error_param;
> +	const char *context_name;
> +};
> +
> +struct binder_transaction_log {
> +	atomic_t cur;
> +	bool full;
> +	struct binder_transaction_log_entry entry[32];
> +};
> +
> +extern struct binder_transaction_log binder_transaction_log;
> +extern struct binder_transaction_log binder_transaction_log_failed;
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 0e1e7c87cd33..1715e72ce9c7 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -630,6 +630,24 @@ static int init_binder_logs(struct super_block *sb)
>  
>  	dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
>  				      &binder_transactions_fops, NULL);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	dentry = binderfs_create_file(binder_logs_root_dir,
> +				      "transaction_log",
> +				      &binder_transaction_log_fops,
> +				      &binder_transaction_log);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	dentry = binderfs_create_file(binder_logs_root_dir,
> +				      "failed_transaction_log",
> +				      &binder_transaction_log_fops,
> +				      &binder_transaction_log_failed);
>  	if (IS_ERR(dentry))
>  		ret = PTR_ERR(dentry);
>  
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
