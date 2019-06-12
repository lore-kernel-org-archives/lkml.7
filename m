Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D10C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfFLPPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:15:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:26297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbfFLPPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:15:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 08:15:37 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.10.37.186])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2019 08:15:37 -0700
Message-ID: <1560354087.22001.2.camel@intel.com>
Subject: Re: [PATCH] mic: no need to check return value of debugfs_create
 functions
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jun 2019 08:41:27 -0700
In-Reply-To: <20190611184323.GA2329@kroah.com>
References: <20190611184323.GA2329@kroah.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-11 at 20:43 +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 

Thanks Greg.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/mic/card/mic_debugfs.c  | 18 ++----------------
>  drivers/misc/mic/cosm/cosm_debugfs.c |  4 ----
>  drivers/misc/mic/host/mic_debugfs.c  |  4 ----
>  drivers/misc/mic/scif/scif_debugfs.c |  5 -----
>  drivers/misc/mic/vop/vop_debugfs.c   |  4 ----
>  5 files changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/misc/mic/card/mic_debugfs.c b/drivers/misc/mic/card/mic_debugfs.c
> index 7a4140874888..fa2b5fefb791 100644
> --- a/drivers/misc/mic/card/mic_debugfs.c
> +++ b/drivers/misc/mic/card/mic_debugfs.c
> @@ -63,25 +63,13 @@ DEFINE_SHOW_ATTRIBUTE(mic_intr);
>   */
>  void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
>  {
> -	struct dentry *d;
> -
>  	if (!mic_dbg)
>  		return;
>  
>  	mdrv->dbg_dir = debugfs_create_dir(mdrv->name, mic_dbg);
> -	if (!mdrv->dbg_dir) {
> -		dev_err(mdrv->dev, "Cant create dbg_dir %s\n", mdrv->name);
> -		return;
> -	}
> -
> -	d = debugfs_create_file("intr_test", 0444, mdrv->dbg_dir,
> -		mdrv, &mic_intr_fops);
>  
> -	if (!d) {
> -		dev_err(mdrv->dev,
> -			"Cant create dbg intr_test %s\n", mdrv->name);
> -		return;
> -	}
> +	debugfs_create_file("intr_test", 0444, mdrv->dbg_dir, mdrv,
> +			    &mic_intr_fops);
>  }
>  
>  /**
> @@ -101,8 +89,6 @@ void mic_delete_card_debug_dir(struct mic_driver *mdrv)
>  void __init mic_init_card_debugfs(void)
>  {
>  	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -	if (!mic_dbg)
> -		pr_err("can't create debugfs dir\n");
>  }
>  
>  /**
> diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
> index 71c216d0504d..340ea7171411 100644
> --- a/drivers/misc/mic/cosm/cosm_debugfs.c
> +++ b/drivers/misc/mic/cosm/cosm_debugfs.c
> @@ -105,8 +105,6 @@ void cosm_create_debug_dir(struct cosm_device *cdev)
>  
>  	scnprintf(name, sizeof(name), "mic%d", cdev->index);
>  	cdev->dbg_dir = debugfs_create_dir(name, cosm_dbg);
> -	if (!cdev->dbg_dir)
> -		return;
>  
>  	debugfs_create_file("log_buf", 0444, cdev->dbg_dir, cdev,
>  			    &log_buf_fops);
> @@ -125,8 +123,6 @@ void cosm_delete_debug_dir(struct cosm_device *cdev)
>  void cosm_init_debugfs(void)
>  {
>  	cosm_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -	if (!cosm_dbg)
> -		pr_err("can't create debugfs dir\n");
>  }
>  
>  void cosm_exit_debugfs(void)
> diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
> index c6e3c764699f..370f98c7b752 100644
> --- a/drivers/misc/mic/host/mic_debugfs.c
> +++ b/drivers/misc/mic/host/mic_debugfs.c
> @@ -125,8 +125,6 @@ void mic_create_debug_dir(struct mic_device *mdev)
>  
>  	scnprintf(name, sizeof(name), "mic%d", mdev->id);
>  	mdev->dbg_dir = debugfs_create_dir(name, mic_dbg);
> -	if (!mdev->dbg_dir)
> -		return;
>  
>  	debugfs_create_file("smpt", 0444, mdev->dbg_dir, mdev,
>  			    &mic_smpt_fops);
> @@ -155,8 +153,6 @@ void mic_delete_debug_dir(struct mic_device *mdev)
>  void __init mic_init_debugfs(void)
>  {
>  	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -	if (!mic_dbg)
> -		pr_err("can't create debugfs dir\n");
>  }
>  
>  /**
> diff --git a/drivers/misc/mic/scif/scif_debugfs.c b/drivers/misc/mic/scif/scif_debugfs.c
> index a6820480105a..8fe38e7ca6e6 100644
> --- a/drivers/misc/mic/scif/scif_debugfs.c
> +++ b/drivers/misc/mic/scif/scif_debugfs.c
> @@ -103,11 +103,6 @@ DEFINE_SHOW_ATTRIBUTE(scif_rma);
>  void __init scif_init_debugfs(void)
>  {
>  	scif_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -	if (!scif_dbg) {
> -		dev_err(scif_info.mdev.this_device,
> -			"can't create debugfs dir scif\n");
> -		return;
> -	}
>  
>  	debugfs_create_file("scif_dev", 0444, scif_dbg, NULL, &scif_dev_fops);
>  	debugfs_create_file("scif_rma", 0444, scif_dbg, NULL, &scif_rma_fops);
> diff --git a/drivers/misc/mic/vop/vop_debugfs.c b/drivers/misc/mic/vop/vop_debugfs.c
> index 2ccef52aca23..d4551d522188 100644
> --- a/drivers/misc/mic/vop/vop_debugfs.c
> +++ b/drivers/misc/mic/vop/vop_debugfs.c
> @@ -186,10 +186,6 @@ void vop_init_debugfs(struct vop_info *vi)
>  
>  	snprintf(name, sizeof(name), "%s%d", KBUILD_MODNAME, vi->vpdev->dnode);
>  	vi->dbg = debugfs_create_dir(name, NULL);
> -	if (!vi->dbg) {
> -		pr_err("can't create debugfs dir vop\n");
> -		return;
> -	}
>  	debugfs_create_file("dp", 0444, vi->dbg, vi, &vop_dp_fops);
>  	debugfs_create_file("vdev_info", 0444, vi->dbg, vi, &vop_vdev_info_fops);
>  }


