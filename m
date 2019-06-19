Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BAC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfFSI0C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:26:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:57670 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731143AbfFSI0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:26:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 01:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="335124305"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga005.jf.intel.com with ESMTP; 19 Jun 2019 01:26:01 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Jun 2019 01:26:01 -0700
Received: from hasmsx105.ger.corp.intel.com (10.184.198.19) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Jun 2019 01:26:00 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.33]) by
 HASMSX105.ger.corp.intel.com ([169.254.1.210]) with mapi id 14.03.0439.000;
 Wed, 19 Jun 2019 11:25:58 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mei: no need to check return value of debugfs_create
 functions
Thread-Topic: [PATCH v2] mei: no need to check return value of
 debugfs_create functions
Thread-Index: AQHVIITgZhaqailFO0mEapB/rDMGv6airg1g
Date:   Wed, 19 Jun 2019 08:25:58 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DC4B6C4@hasmsx108.ger.corp.intel.com>
References: <20190611183357.GA32008@kroah.com>
 <20190611183816.GA952@kroah.com>
In-Reply-To: <20190611183816.GA952@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When calling debugfs functions, there is no need to ever check the return
> value.  The function can work or not, but the code logic should never do
> something different based on this.

Maybe need to mention that API has changed in patch ' ff9fb72bc07705c00795ca48631f7fffe24d2c6b' in 5.0 
and create_dir() doesn't return NULL but ERR_PTR() and proper checking is done inside the debugfs functions.
Not sure how critical is that but, but this should go probably to stable 5.0+ as well. 
Ack otherwise. 
> 
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: break the patch up properly
> 
>  drivers/misc/mei/debugfs.c | 47 +++++++++-----------------------------
>  drivers/misc/mei/main.c    |  8 +------
>  drivers/misc/mei/mei_dev.h |  7 ++----
>  3 files changed, 14 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c index
> 0970142bcace..df6bf8b81936 100644
> --- a/drivers/misc/mei/debugfs.c
> +++ b/drivers/misc/mei/debugfs.c
> @@ -233,47 +233,22 @@ void mei_dbgfs_deregister(struct mei_device *dev)
>   *
>   * @dev: the mei device structure
>   * @name: the mei device name
> - *
> - * Return: 0 on success, <0 on failure.
>   */
> -int mei_dbgfs_register(struct mei_device *dev, const char *name)
> +void mei_dbgfs_register(struct mei_device *dev, const char *name)
>  {
> -	struct dentry *dir, *f;
> +	struct dentry *dir;
> 
>  	dir = debugfs_create_dir(name, NULL);
> -	if (!dir)
> -		return -ENOMEM;
> -
>  	dev->dbgfs_dir = dir;
> 
> -	f = debugfs_create_file("meclients", S_IRUSR, dir,
> -				dev, &mei_dbgfs_fops_meclients);
> -	if (!f) {
> -		dev_err(dev->dev, "meclients: registration failed\n");
> -		goto err;
> -	}
> -	f = debugfs_create_file("active", S_IRUSR, dir,
> -				dev, &mei_dbgfs_fops_active);
> -	if (!f) {
> -		dev_err(dev->dev, "active: registration failed\n");
> -		goto err;
> -	}
> -	f = debugfs_create_file("devstate", S_IRUSR, dir,
> -				dev, &mei_dbgfs_fops_devstate);
> -	if (!f) {
> -		dev_err(dev->dev, "devstate: registration failed\n");
> -		goto err;
> -	}
> -	f = debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR,
> dir,
> -				&dev->allow_fixed_address,
> -				&mei_dbgfs_fops_allow_fa);
> -	if (!f) {
> -		dev_err(dev->dev, "allow_fixed_address: registration
> failed\n");
> -		goto err;
> -	}
> -	return 0;
> -err:
> -	mei_dbgfs_deregister(dev);
> -	return -ENODEV;
> +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
> +			    &mei_dbgfs_fops_meclients);
> +	debugfs_create_file("active", S_IRUSR, dir, dev,
> +			    &mei_dbgfs_fops_active);
> +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
> +			    &mei_dbgfs_fops_devstate);
> +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
> +			    &dev->allow_fixed_address,
> +			    &mei_dbgfs_fops_allow_fa);
>  }
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
> ad02097d7fee..f894d1f8a53e 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -984,16 +984,10 @@ int mei_register(struct mei_device *dev, struct
> device *parent)
>  		goto err_dev_create;
>  	}
> 
> -	ret = mei_dbgfs_register(dev, dev_name(clsdev));
> -	if (ret) {
> -		dev_err(clsdev, "cannot register debugfs ret = %d\n", ret);
> -		goto err_dev_dbgfs;
> -	}
> +	mei_dbgfs_register(dev, dev_name(clsdev));
> 
>  	return 0;
> 
> -err_dev_dbgfs:
> -	device_destroy(mei_class, devno);
>  err_dev_create:
>  	cdev_del(&dev->cdev);
>  err_dev_add:
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h index
> fca832fcac57..f71a023aed3c 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -718,13 +718,10 @@ bool mei_hbuf_acquire(struct mei_device *dev);
> bool mei_write_is_idle(struct mei_device *dev);
> 
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
> -int mei_dbgfs_register(struct mei_device *dev, const char *name);
> +void mei_dbgfs_register(struct mei_device *dev, const char *name);
>  void mei_dbgfs_deregister(struct mei_device *dev);  #else -static inline int
> mei_dbgfs_register(struct mei_device *dev, const char *name) -{
> -	return 0;
> -}
> +static inline void mei_dbgfs_register(struct mei_device *dev, const
> +char *name) {}
>  static inline void mei_dbgfs_deregister(struct mei_device *dev) {}  #endif /*
> CONFIG_DEBUG_FS */
> 
> --
> 2.22.0

