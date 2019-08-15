Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF00020578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qtT/kgiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfHOQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:28:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfHOQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:28:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so1550973pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ako5fluBLDpfE1J18WjJkmrO4kyd01koUp3/srSLSio=;
        b=qtT/kgiqDdqZS87IpBnNlRkIc96pYOs3bsFznlNVDQXAV2IQZtGmds429Cbcj1BTeq
         ZRejWIcNM9GvygOmD8IxOlvXRvQOmdcgh6laGyvGysnw6JvUmmGthXwWmTlMNHdjNCF/
         6sQOAp7i1LGEOBBfLrB8gi3qFuSZ7/MNXiNFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ako5fluBLDpfE1J18WjJkmrO4kyd01koUp3/srSLSio=;
        b=hD5pLU31kY2/aWaVznxCm3aLz0E14DMY1zpzCh97oGwtoR0ePhzLguUKBP+TPaYMD8
         68M44fSee30tB6Rw60Et8Ro9idLQZ7qRGL+j57+UHcCfELl6OJxaDCV0QC7ay2BH+ghd
         IIyqeVGCfF4+uf3c8InNS1UGa9AUlWVmwaaFnFuHvLeJua9CDSma6Opd3EwrzSXN04fo
         u0f8QZ8TBLgXv8CC/1twsTudWtkuyPM28pChyk6zQZ5mNGUCh7HEzLrNhxvOzLfZy9KM
         6SYkUU9lKgFd1wvhv6S1sWrBlRjXlNg+3JTxn8U+a31nfFBcw1s1Tb+a7GXtutD8pYw1
         CCcA==
X-Gm-Message-State: APjAAAUdaizwer3HqKl9q8gLyOxSEjzWEG3ks3FLWjyU3iYo8nyg02fc
        lfy48gXvwF0PEvIIFg2SNANAoA==
X-Google-Smtp-Source: APXvYqyyibvRsNaV3CtcWbxkzfTVTQ58VnhGf9a0pKudGLIxAoscuok8Pnf8eybfSz3FnCIT24W3TQ==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr4073354pgn.182.1565886524798;
        Thu, 15 Aug 2019 09:28:44 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id 185sm3486276pfd.125.2019.08.15.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:28:43 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:28:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 1/2] binder: Add default binder devices through
 binderfs when configured
Message-ID: <20190815162827.GA75595@google.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-2-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-2-hridya@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:27:25PM -0700, Hridya Valsaraju wrote:
> Currently, since each binderfs instance needs its own
> private binder devices, every time a binderfs instance is
> mounted, all the default binder devices need to be created
> via the BINDER_CTL_ADD IOCTL. This patch aims to
> add a solution to automatically create the default binder
> devices for each binderfs instance that gets mounted.
> To achieve this goal, when CONFIG_ANDROID_BINDERFS is set,
> the default binder devices specified by CONFIG_ANDROID_BINDER_DEVICES
> are created in each binderfs instance instead of global devices
> being created by the binder driver.
> 
> Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
> 
> Changes in v2:
> - Updated commit message as per Greg Kroah-Hartman.
> - Removed new module parameter creation as per Greg
>   Kroah-Hartman/Christian Brauner.
> - Refactored device name length check into a new patch as per Greg Kroah-Hartman.
> 
> Changes in v3:
> -Removed unnecessary empty lines as per Dan Carpenter.
> 
>  drivers/android/binder.c          |  5 +++--
>  drivers/android/binder_internal.h |  2 ++
>  drivers/android/binderfs.c        | 23 ++++++++++++++++++++---
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 466b6a7f8ab7..ca6b21a53321 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -123,7 +123,7 @@ static uint32_t binder_debug_mask = BINDER_DEBUG_USER_ERROR |
>  	BINDER_DEBUG_FAILED_TRANSACTION | BINDER_DEBUG_DEAD_TRANSACTION;
>  module_param_named(debug_mask, binder_debug_mask, uint, 0644);
>  
> -static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> +char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
>  module_param_named(devices, binder_devices_param, charp, 0444);
>  
>  static DECLARE_WAIT_QUEUE_HEAD(binder_user_error_wait);
> @@ -6279,7 +6279,8 @@ static int __init binder_init(void)
>  				    &transaction_log_fops);
>  	}
>  
> -	if (strcmp(binder_devices_param, "") != 0) {
> +	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
> +	    strcmp(binder_devices_param, "") != 0) {
>  		/*
>  		* Copy the module_parameter string, because we don't want to
>  		* tokenize it in-place.
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 045b3e42d98b..fe8c745dc8e0 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -37,6 +37,8 @@ struct binder_device {
>  
>  extern const struct file_operations binder_fops;
>  
> +extern char *binder_devices_param;
> +
>  #ifdef CONFIG_ANDROID_BINDERFS
>  extern bool is_binderfs_device(const struct inode *inode);
>  #else
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index e773f45d19d9..aee46dd1be91 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -186,8 +186,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	req->major = MAJOR(binderfs_dev);
>  	req->minor = minor;
>  
> -	ret = copy_to_user(userp, req, sizeof(*req));
> -	if (ret) {
> +	if (userp && copy_to_user(userp, req, sizeof(*req))) {
>  		ret = -EFAULT;
>  		goto err;
>  	}
> @@ -467,6 +466,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	int ret;
>  	struct binderfs_info *info;
>  	struct inode *inode = NULL;
> +	struct binderfs_device device_info = { 0 };
> +	const char *name;
> +	size_t len;
>  
>  	sb->s_blocksize = PAGE_SIZE;
>  	sb->s_blocksize_bits = PAGE_SHIFT;
> @@ -521,7 +523,22 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!sb->s_root)
>  		return -ENOMEM;
>  
> -	return binderfs_binder_ctl_create(sb);
> +	ret = binderfs_binder_ctl_create(sb);
> +	if (ret)
> +		return ret;
> +
> +	name = binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		strscpy(device_info.name, name, len + 1);
> +		ret = binderfs_binder_device_create(inode, NULL, &device_info);
> +		if (ret)
> +			return ret;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 
