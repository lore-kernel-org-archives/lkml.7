Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F1A204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PlvEKlqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfHBPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:06:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36107 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfHBPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:06:22 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so49255546iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWnA4ZjQO5d8NsMY1qHYaup11KljkJKpaTVStdPxcfQ=;
        b=PlvEKlqVLtTxj0dmXgdb1RKnAAib5uIf1KhVuXZY6IgV2gbV9NT2KbNh3HA8km79wu
         4c6OjMPbbT6CsIivG2dLmt2IuqP4Q4mnJsaves2s/wJ6TSpIiGe/Vsu7GcHzEkrJMYu7
         4bqdnZIX2bGn+mXtG7bG9HD4exvtz1p7L0pDTRdLGF7MBhegwI5uJ/f2hI6dlCGMr8PV
         GV89LNloxlFmC/JvxrPnuGEADGaArv6ahYVr6KRz0WHHi+NOnM6kKWaIU4bPo29pwEkM
         74F9nDK7SxQR19oW0jyh+G0QUHwh/94EJv80zE2Q+qhs/tIM39IL2csSrUjjh6uvpVtD
         DKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWnA4ZjQO5d8NsMY1qHYaup11KljkJKpaTVStdPxcfQ=;
        b=EAtvvhI7PvDMIVFZ15qrzKCDXzrnFerpHqskkkIAIsi1YbhVbMBec1ZJST3hOfoEEP
         vk1jujqKyJg/xj5y8vxyw9AluQFYCmjikLouw6WqH5GnBFmPj10C9Qh01ZXeNj0sdnkR
         2i7JpYtJlW2SWxaD323WAxhjeSMbsPkRYtUk3xFZEv+xYz9IIqx28Q6oGoRu+QLLp69d
         RStiR+U2xQu28V+IZ1KGx3s3pCO55getUyNNApWJlGop0/2wYaf7qo2HPoNYCVaUMavo
         CNWPmCDwC/AH+rnSnkYJevbzHj/UHG/GZLfID7urC/zkU10ls+/mEIXPX5IiD2Y3Sx4U
         7nGA==
X-Gm-Message-State: APjAAAUNW3Lnm6DBMzGrAlbzajLcRw+DqzUgbAVzhy1JsN+wpJUF6zpf
        Nw6AryuYlK+cSiAQAH1tjs0=
X-Google-Smtp-Source: APXvYqxI4PgiPSy0IaEO6+IpKjEFmUOCoPatgyhLg355kJMSWRwV6n3Re1cBSGIF9FeQzjA+L1VxQA==
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr7604951iop.168.1564758379632;
        Fri, 02 Aug 2019 08:06:19 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id z26sm76466529ioi.85.2019.08.02.08.06.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 08:06:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 2 Aug 2019 17:06:16 +0200
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] Add default binder devices through binderfs when
 configured
Message-ID: <20190802150612.eff7t42256pvxuja@brauner.io>
References: <20190801223556.209184-1-hridya@google.com>
 <20190802061838.GA10844@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802061838.GA10844@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:18:38AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2019 at 03:35:56PM -0700, Hridya Valsaraju wrote:
> > If CONFIG_ANDROID_BINDERFS is set, the default binder devices
> > specified by CONFIG_ANDROID_BINDER_DEVICES are created in each
> > binderfs instance instead of global devices being created by
> > the binder driver.
> > 
> > Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > ---
> >  drivers/android/binder.c   |  3 ++-
> >  drivers/android/binderfs.c | 46 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 44 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 466b6a7f8ab7..65a99ac26711 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -6279,7 +6279,8 @@ static int __init binder_init(void)
> >  				    &transaction_log_fops);
> >  	}
> >  
> > -	if (strcmp(binder_devices_param, "") != 0) {
> > +	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
> > +	    strcmp(binder_devices_param, "") != 0) {
> >  		/*
> >  		* Copy the module_parameter string, because we don't want to
> >  		* tokenize it in-place.
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index e773f45d19d9..9f5ed50ffd70 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -48,6 +48,10 @@ static dev_t binderfs_dev;
> >  static DEFINE_MUTEX(binderfs_minors_mutex);
> >  static DEFINE_IDA(binderfs_minors);
> >  
> > +static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> > +module_param_named(devices, binder_devices_param, charp, 0444);
> > +MODULE_PARM_DESC(devices, "Binder devices to be created by default");
> > +
> 
> Why are you creating a module parameter?  That was not in your changelog
> :(

Yeah, you don't need an additional module parameter. You can just move

static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
module_param_named(devices, binder_devices_param, charp, 0444);

from binder.c to binder_internal.h and expose it to binder.c and
binderfs.c this way. This will work just fine since binderfs.c doesn't
modify the parameter and binder.c makes a copy of it before doing so.

> 
> 
> 
> >  /**
> >   * binderfs_mount_opts - mount options for binderfs
> >   * @max: maximum number of allocatable binderfs binder devices
> > @@ -135,7 +139,6 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
> >  #else
> >  	bool use_reserve = true;
> >  #endif
> > -
> >  	/* Reserve new minor number for the new device. */
> >  	mutex_lock(&binderfs_minors_mutex);
> >  	if (++info->device_count <= info->mount_opts.max)
> > @@ -186,8 +189,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
> >  	req->major = MAJOR(binderfs_dev);
> >  	req->minor = minor;
> >  
> > -	ret = copy_to_user(userp, req, sizeof(*req));
> > -	if (ret) {
> > +	if (userp && copy_to_user(userp, req, sizeof(*req))) {
> >  		ret = -EFAULT;
> >  		goto err;
> >  	}
> > @@ -467,6 +469,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	int ret;
> >  	struct binderfs_info *info;
> >  	struct inode *inode = NULL;
> > +	struct binderfs_device device_info = { 0 };
> > +	const char *name;
> > +	size_t len;
> >  
> >  	sb->s_blocksize = PAGE_SIZE;
> >  	sb->s_blocksize_bits = PAGE_SHIFT;
> > @@ -521,7 +526,28 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	if (!sb->s_root)
> >  		return -ENOMEM;
> >  
> > -	return binderfs_binder_ctl_create(sb);
> > +	ret = binderfs_binder_ctl_create(sb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	name = binder_devices_param;
> > +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +		/*
> > +		 * init_binderfs() has already checked that the length of
> > +		 * device_name_entry->name is not greater than device_info.name.
> > +		 */
> > +		strscpy(device_info.name, name, len + 1);
> > +		ret = binderfs_binder_device_create(inode, NULL, &device_info);
> > +		if (ret)
> > +			return ret;
> > +		name += len;
> > +		if (*name == ',')
> > +			name++;
> > +
> > +	}
> > +
> > +	return 0;
> > +
> >  }
> >  
> >  static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> > @@ -553,6 +579,18 @@ static struct file_system_type binder_fs_type = {
> >  int __init init_binderfs(void)
> >  {
> >  	int ret;
> > +	const char *name;
> > +	size_t len;
> > +
> > +	/* Verify that the default binderfs device names are valid. */
> > +	name = binder_devices_param;
> > +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +		if (len > BINDERFS_MAX_NAME)
> > +			return -E2BIG;
> > +		name += len;
> > +		if (*name == ',')
> > +			name++;
> > +	}
> 
> This verification should be a separate patch, right?
> 
> But the real issue here is I have no idea _why_ you are wanting this
> patch.  The changelog text says _what_ you are doing only, which isn't
> ok.
> 
> Please provide more information as to why this is needed, what problem
> it is solving, and break this up into a patch series and resend.
> 
> thanks,
> 
> greg k-h
