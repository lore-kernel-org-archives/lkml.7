Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC482C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9DA205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250437;
	bh=K0X8GgFy435VOoeOHy/Q4mU8roopc8Fwgpx4Ke6leBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gOzeBuOl7wIDzZm/sMTuqbVP/k8PFxUVfWYc1zToyfH1/A2XTs2y55/kWPkq6q2mY
	 /RBqZtf0NKo2Tq6HKrouhop6tEoqOeH5V+sa9eDQrCQVSlCY3baB4cwyW9fAeexk/O
	 iZt9Xxbrg65hmn2EZTyjnWt8d4QLDw8nSYh/1IOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfEGRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:33:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36364 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfEGRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:33:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so9013370pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WzsYknyX0HYNLGGorgfE+0LgULW8QI8QKqAffKHkjUU=;
        b=GiKn40yEZO+Tyc5cu79oP/83N4dm3LTrsYKvipymsR2K0FDe9O3H+5sKDhtmAHAmo7
         UzjuVJ8Ih6C5dosaF92pH7ddYOD7YlV0KsWM1PWaJz7peP72Kmtbp52DB7duoiGiEw4h
         CPBOorjGXCFaWfW7S4f0wgE8yVh4XqoCFTlL9Pegdy7o1ZgLRX6ablP0HzU6k0zMyxu1
         m3OFYW0pZUzpvw21YUOAKTbyTHA0Oiw22/cDCERWp/lDH7He8fS6mlJvOuP/00PT+qll
         x6uu9gHn03kvutMlrG9UR8mG8psygyBtZGIK7wJXo5ztgkEIoeW67Nd31orokca9Ppx7
         kukg==
X-Gm-Message-State: APjAAAVxd7VO/nx9eYCvf5J0zNyxa8VDvvMiFxU1UWvjxlVNS+eozJaU
        G3xNPekDhiGLi9QG8r0tpS9oqQ==
X-Google-Smtp-Source: APXvYqyXIh3/eC7TeOP++dhK6gKiyxRXAEzvDnMIot33hzLH66e5kqD/yE5XNlj4INoZqxiov705vw==
X-Received: by 2002:a62:1a8b:: with SMTP id a133mr41450279pfa.87.1557250434984;
        Tue, 07 May 2019 10:33:54 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id u123sm8843407pfu.67.2019.05.07.10.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:33:54 -0700 (PDT)
Date:   Tue, 7 May 2019 10:33:53 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 06/18] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190507173353.GC26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-7-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-7-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:39PM +0800, Wu Hao wrote:
> In order to support virtualization usage via PCIe SRIOV, this patch
> adds two ioctls under FPGA Management Engine (FME) to release and
> assign back the port device. In order to safely turn Port from PF
> into VF and enable PCIe SRIOV, it requires user to invoke this
> PORT_RELEASE ioctl to release port firstly to remove userspace
> interfaces, and then configure the PF/VF access register in FME.
> After disable SRIOV, it requires user to invoke this PORT_ASSIGN
> ioctl to attach the port back to PF.
> 
>  Ioctl interfaces:
>  * DFL_FPGA_FME_PORT_RELEASE
>    Release platform device of given port, it deletes port platform
>    device to remove related userspace interfaces on PF, then
>    configures PF/VF access mode to VF.
> 
>  * DFL_FPGA_FME_PORT_ASSIGN
>    Assign platform device of given port back to PF, it configures
>    PF/VF access mode to PF, then adds port platform device back to
>    re-enable related userspace interfaces on PF.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-main.c   |  54 +++++++++++++++++++++
>  drivers/fpga/dfl.c            | 107 +++++++++++++++++++++++++++++++++++++-----
>  drivers/fpga/dfl.h            |  10 ++++
>  include/uapi/linux/fpga-dfl.h |  32 +++++++++++++
>  4 files changed, 191 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 076d74f..8b2a337 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
>  #include <linux/fpga-dfl.h>
>  
>  #include "dfl.h"
> @@ -105,9 +106,62 @@ static void fme_hdr_uinit(struct platform_device *pdev,
>  	sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
>  }
>  
> +static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
> +				       void __user *arg)
> +{
> +	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
> +	struct dfl_fpga_fme_port_release release;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct dfl_fpga_fme_port_release, port_id);
> +
> +	if (copy_from_user(&release, arg, minsz))
> +		return -EFAULT;
> +
> +	if (release.argsz < minsz || release.flags)
> +		return -EINVAL;
> +
> +	return dfl_fpga_cdev_config_port(cdev, release.port_id, true);
> +}
> +
> +static long fme_hdr_ioctl_assign_port(struct dfl_feature_platform_data *pdata,
> +				      void __user *arg)
> +{
> +	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
> +	struct dfl_fpga_fme_port_assign assign;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct dfl_fpga_fme_port_assign, port_id);
> +
> +	if (copy_from_user(&assign, arg, minsz))
> +		return -EFAULT;
> +
> +	if (assign.argsz < minsz || assign.flags)
> +		return -EINVAL;
> +
> +	return dfl_fpga_cdev_config_port(cdev, assign.port_id, false);
> +}
> +
> +static long fme_hdr_ioctl(struct platform_device *pdev,
> +			  struct dfl_feature *feature,
> +			  unsigned int cmd, unsigned long arg)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +	switch (cmd) {
> +	case DFL_FPGA_FME_PORT_RELEASE:
> +		return fme_hdr_ioctl_release_port(pdata, (void __user *)arg);
> +	case DFL_FPGA_FME_PORT_ASSIGN:
> +		return fme_hdr_ioctl_assign_port(pdata, (void __user *)arg);
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static const struct dfl_feature_ops fme_hdr_ops = {
>  	.init = fme_hdr_init,
>  	.uinit = fme_hdr_uinit,
> +	.ioctl = fme_hdr_ioctl,
>  };
>  
>  static struct dfl_feature_driver fme_feature_drvs[] = {
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 2c09e50..a6b6d38 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -224,16 +224,20 @@ void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops)
>   */
>  int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
>  {
> -	struct dfl_fpga_port_ops *port_ops = dfl_fpga_port_ops_get(pdev);
> -	int port_id;
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_fpga_port_ops *port_ops;
> +
> +	if (pdata->id != FEATURE_DEV_ID_UNUSED)
> +		return pdata->id == *(int *)pport_id;
>  
> +	port_ops = dfl_fpga_port_ops_get(pdev);
>  	if (!port_ops || !port_ops->get_id)
>  		return 0;
>  
> -	port_id = port_ops->get_id(pdev);
> +	pdata->id = port_ops->get_id(pdev);
>  	dfl_fpga_port_ops_put(port_ops);
>  
> -	return port_id == *(int *)pport_id;
> +	return pdata->id == *(int *)pport_id;
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>  
> @@ -462,6 +466,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	pdata->dev = fdev;
>  	pdata->num = binfo->feature_num;
>  	pdata->dfl_cdev = binfo->cdev;
> +	pdata->id = FEATURE_DEV_ID_UNUSED;
>  	mutex_init(&pdata->lock);
>  
>  	/*
> @@ -959,25 +964,27 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
>  {
>  	struct dfl_feature_platform_data *pdata, *ptmp;
>  
> -	remove_feature_devs(cdev);
> -
>  	mutex_lock(&cdev->lock);
> -	if (cdev->fme_dev) {
> -		/* the fme should be unregistered. */
> -		WARN_ON(device_is_registered(cdev->fme_dev));
> +	if (cdev->fme_dev)
>  		put_device(cdev->fme_dev);
> -	}
>  
>  	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
>  		struct platform_device *port_dev = pdata->dev;
>  
> -		/* the port should be unregistered. */
> -		WARN_ON(device_is_registered(&port_dev->dev));
> +		/* remove released ports */
> +		if (!device_is_registered(&port_dev->dev)) {
> +			dfl_id_free(feature_dev_id_type(port_dev),
> +				    port_dev->id);
> +			platform_device_put(port_dev);
> +		}
> +
>  		list_del(&pdata->node);
>  		put_device(&port_dev->dev);
>  	}
>  	mutex_unlock(&cdev->lock);
>  
> +	remove_feature_devs(cdev);
> +
>  	fpga_region_unregister(cdev->region);
>  	devm_kfree(cdev->parent, cdev);
>  }
> @@ -1015,6 +1022,82 @@ struct platform_device *
>  }
>  EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port);
>  
> +static int attach_port_dev(struct dfl_fpga_cdev *cdev, u32 port_id)
> +{
> +	struct platform_device *port_pdev;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&cdev->lock);
> +	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
> +					      dfl_fpga_check_port_id);
> +	if (!port_pdev)
> +		goto unlock_exit;
> +
> +	if (device_is_registered(&port_pdev->dev)) {
> +		ret = -EBUSY;
> +		goto put_dev_exit;
> +	}
> +
> +	ret = platform_device_add(port_pdev);
> +	if (ret)
> +		goto put_dev_exit;
> +
> +	dfl_feature_dev_use_end(dev_get_platdata(&port_pdev->dev));
> +	cdev->released_port_num--;
> +put_dev_exit:
> +	put_device(&port_pdev->dev);
> +unlock_exit:
> +	mutex_unlock(&cdev->lock);
> +	return ret;
> +}
> +
> +static int detach_port_dev(struct dfl_fpga_cdev *cdev, u32 port_id)
> +{
> +	struct platform_device *port_pdev;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&cdev->lock);
> +	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
> +					      dfl_fpga_check_port_id);
> +	if (!port_pdev)
> +		goto unlock_exit;
> +
> +	if (!device_is_registered(&port_pdev->dev)) {
> +		ret = -EBUSY;
> +		goto put_dev_exit;
> +	}
> +
> +	ret = dfl_feature_dev_use_begin(dev_get_platdata(&port_pdev->dev));
> +	if (ret)
> +		goto put_dev_exit;
> +
> +	platform_device_del(port_pdev);
> +	cdev->released_port_num++;
> +put_dev_exit:
> +	put_device(&port_pdev->dev);
> +unlock_exit:
> +	mutex_unlock(&cdev->lock);
> +	return ret;
> +}
> +
> +/**
> + * dfl_fpga_cdev_config_port - configure a port feature dev
> + * @cdev: parent container device.
> + * @port_id: id of the port feature device.
> + * @release: release port or assign port back.
> + *
> + * This function allows user to release port platform device or assign it back.
> + * e.g. to safely turn one port from PF into VF for PCI device SRIOV support,
> + * release port platform device is one necessary step.
> + */
> +int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
> +			      u32 port_id, bool release)
> +{
> +	return release ? detach_port_dev(cdev, port_id) :
> +			 attach_port_dev(cdev, port_id);
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
> +
>  static int __init dfl_fpga_init(void)
>  {
>  	int ret;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 8851c6c..63f39ab 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -183,6 +183,8 @@ struct dfl_feature {
>  
>  #define DEV_STATUS_IN_USE	0
>  
> +#define FEATURE_DEV_ID_UNUSED	(-1)
> +
>  /**
>   * struct dfl_feature_platform_data - platform data for feature devices
>   *
> @@ -191,6 +193,7 @@ struct dfl_feature {
>   * @cdev: cdev of feature dev.
>   * @dev: ptr to platform device linked with this platform data.
>   * @dfl_cdev: ptr to container device.
> + * @id: id used for this feature device.
>   * @disable_count: count for port disable.
>   * @num: number for sub features.
>   * @dev_status: dev status (e.g. DEV_STATUS_IN_USE).
> @@ -203,6 +206,7 @@ struct dfl_feature_platform_data {
>  	struct cdev cdev;
>  	struct platform_device *dev;
>  	struct dfl_fpga_cdev *dfl_cdev;
> +	int id;
>  	unsigned int disable_count;
>  	unsigned long dev_status;
>  	void *private;
> @@ -378,6 +382,7 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>   * @fme_dev: FME feature device under this container device.
>   * @lock: mutex lock to protect the port device list.
>   * @port_dev_list: list of all port feature devices under this container device.
> + * @released_port_num: released port number under this container device.
>   */
>  struct dfl_fpga_cdev {
>  	struct device *parent;
> @@ -385,6 +390,7 @@ struct dfl_fpga_cdev {
>  	struct device *fme_dev;
>  	struct mutex lock;
>  	struct list_head port_dev_list;
> +	int released_port_num;
>  };
>  
>  struct dfl_fpga_cdev *
> @@ -412,4 +418,8 @@ struct platform_device *
>  
>  	return pdev;
>  }
> +
> +int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
> +			      u32 port_id, bool release);
> +
>  #endif /* __FPGA_DFL_H */
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 2e324e5..e9a00e0 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -176,4 +176,36 @@ struct dfl_fpga_fme_port_pr {
>  
>  #define DFL_FPGA_FME_PORT_PR	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 0)
>  
> +/**
> + * DFL_FPGA_FME_PORT_RELEASE - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 1,
> + *					struct dfl_fpga_fme_port_release)
> + *
> + * Driver releases the port per Port ID provided by caller.
> + * Return: 0 on success, -errno on failure.
> + */
> +struct dfl_fpga_fme_port_release {
> +	/* Input */
> +	__u32 argsz;		/* Structure length */
> +	__u32 flags;		/* Zero for now */
> +	__u32 port_id;
> +};
> +
> +#define DFL_FPGA_FME_PORT_RELEASE	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 1)
> +
> +/**
> + * DFL_FPGA_FME_PORT_ASSIGN - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 2,
> + *					struct dfl_fpga_fme_port_assign)
> + *
> + * Driver assigns the port back per Port ID provided by caller.
> + * Return: 0 on success, -errno on failure.
> + */
> +struct dfl_fpga_fme_port_assign {
> +	/* Input */
> +	__u32 argsz;		/* Structure length */
> +	__u32 flags;		/* Zero for now */
> +	__u32 port_id;
> +};
> +
> +#define DFL_FPGA_FME_PORT_ASSIGN	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 2)
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> -- 
> 1.8.3.1
> 
