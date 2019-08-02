Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282AC2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564726724;
	bh=S2K3wR2YDF5jGxl+ayK0HwksDCL5fZX4E5bkNRkkw6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oty3RKTkPE8fHxH7bfIpggDxATyivKzRwvB4V+Rkfgj1XOjfqw9OlfiK9ZQ1T7l5P
	 gzRQqSGcBaRT+8SsXqEP8/3DE+rU6L2khDWy8PLB7u49pyHS8fP7dRddQsYzd3Jdhq
	 6pAhwmc27hG0f/N31Whyh1jRbXJ7smxAsn8NbBL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfHBGSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfHBGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:18:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53C2206A3;
        Fri,  2 Aug 2019 06:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564726721;
        bh=S2K3wR2YDF5jGxl+ayK0HwksDCL5fZX4E5bkNRkkw6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wt2hZUnBBuDeU0ylH1gYzOMkO4yaW+uABg2cFnjUn+tsd/HWksAiDtDVZ0+/EUIgy
         JNYSiv1BEA8r9iewfHHSg3Z0lIBLnXlLOUVn9kFHtfthFrprIMCJEAnLgnw6TOeZ7j
         AwG0fVWgtT6LV87aqZ4NHRslk6GvazxhCpnFG+CQ=
Date:   Fri, 2 Aug 2019 08:18:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] Add default binder devices through binderfs when
 configured
Message-ID: <20190802061838.GA10844@kroah.com>
References: <20190801223556.209184-1-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801223556.209184-1-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:35:56PM -0700, Hridya Valsaraju wrote:
> If CONFIG_ANDROID_BINDERFS is set, the default binder devices
> specified by CONFIG_ANDROID_BINDER_DEVICES are created in each
> binderfs instance instead of global devices being created by
> the binder driver.
> 
> Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>  drivers/android/binder.c   |  3 ++-
>  drivers/android/binderfs.c | 46 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 466b6a7f8ab7..65a99ac26711 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
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
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index e773f45d19d9..9f5ed50ffd70 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -48,6 +48,10 @@ static dev_t binderfs_dev;
>  static DEFINE_MUTEX(binderfs_minors_mutex);
>  static DEFINE_IDA(binderfs_minors);
>  
> +static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> +module_param_named(devices, binder_devices_param, charp, 0444);
> +MODULE_PARM_DESC(devices, "Binder devices to be created by default");
> +

Why are you creating a module parameter?  That was not in your changelog
:(



>  /**
>   * binderfs_mount_opts - mount options for binderfs
>   * @max: maximum number of allocatable binderfs binder devices
> @@ -135,7 +139,6 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  #else
>  	bool use_reserve = true;
>  #endif
> -
>  	/* Reserve new minor number for the new device. */
>  	mutex_lock(&binderfs_minors_mutex);
>  	if (++info->device_count <= info->mount_opts.max)
> @@ -186,8 +189,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	req->major = MAJOR(binderfs_dev);
>  	req->minor = minor;
>  
> -	ret = copy_to_user(userp, req, sizeof(*req));
> -	if (ret) {
> +	if (userp && copy_to_user(userp, req, sizeof(*req))) {
>  		ret = -EFAULT;
>  		goto err;
>  	}
> @@ -467,6 +469,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	int ret;
>  	struct binderfs_info *info;
>  	struct inode *inode = NULL;
> +	struct binderfs_device device_info = { 0 };
> +	const char *name;
> +	size_t len;
>  
>  	sb->s_blocksize = PAGE_SIZE;
>  	sb->s_blocksize_bits = PAGE_SHIFT;
> @@ -521,7 +526,28 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
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
> +		/*
> +		 * init_binderfs() has already checked that the length of
> +		 * device_name_entry->name is not greater than device_info.name.
> +		 */
> +		strscpy(device_info.name, name, len + 1);
> +		ret = binderfs_binder_device_create(inode, NULL, &device_info);
> +		if (ret)
> +			return ret;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +
> +	}
> +
> +	return 0;
> +
>  }
>  
>  static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> @@ -553,6 +579,18 @@ static struct file_system_type binder_fs_type = {
>  int __init init_binderfs(void)
>  {
>  	int ret;
> +	const char *name;
> +	size_t len;
> +
> +	/* Verify that the default binderfs device names are valid. */
> +	name = binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		if (len > BINDERFS_MAX_NAME)
> +			return -E2BIG;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}

This verification should be a separate patch, right?

But the real issue here is I have no idea _why_ you are wanting this
patch.  The changelog text says _what_ you are doing only, which isn't
ok.

Please provide more information as to why this is needed, what problem
it is solving, and break this up into a patch series and resend.

thanks,

greg k-h
