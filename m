Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB55C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16AF2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfFSQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:31:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfFSQb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:31:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C9DE10BDBC801D2AD92;
        Thu, 20 Jun 2019 00:31:24 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Jun 2019
 00:31:02 +0800
Date:   Tue, 18 Jun 2019 16:41:58 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 03/22] iommu: Introduce device fault report API
Message-ID: <20190618164158.0000489c@huawei.com>
In-Reply-To: <1560087862-57608-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-4-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019 06:44:03 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Traditionally, device specific faults are detected and handled within
> their own device drivers. When IOMMU is enabled, faults such as DMA
> related transactions are detected by IOMMU. There is no generic
> reporting mechanism to report faults back to the in-kernel device
> driver or the guest OS in case of assigned devices.
> 
> This patch introduces a registration API for device specific fault
> handlers. This differs from the existing iommu_set_fault_handler/
> report_iommu_fault infrastructures in several ways:
> - it allows to report more sophisticated fault events (both
>   unrecoverable faults and page request faults) due to the nature
>   of the iommu_fault struct
> - it is device specific and not domain specific.
> 
> The current iommu_report_device_fault() implementation only handles
> the "shoot and forget" unrecoverable fault case. Handling of page
> request faults or stalled faults will come later.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

A few nitpicks and minor suggestions inline.

> ---
>  drivers/iommu/iommu.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/iommu.h |  33 ++++++++++++-
>  2 files changed, 157 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 67ee662..7955184 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  		goto err_free_name;
>  	}
>  
> +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
> +	if (!dev->iommu_param) {
> +		ret = -ENOMEM;
> +		goto err_free_name;
> +	}
> +	mutex_init(&dev->iommu_param->lock);
> +
>  	kobject_get(group->devices_kobj);
>  
>  	dev->iommu_group = group;
> @@ -674,6 +681,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  	mutex_unlock(&group->mutex);
>  	dev->iommu_group = NULL;
>  	kobject_put(group->devices_kobj);
> +	kfree(dev->iommu_param);
>  err_free_name:
>  	kfree(device->name);
>  err_remove_link:
> @@ -720,7 +728,7 @@ void iommu_group_remove_device(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  
>  	trace_remove_device_from_group(group->id, dev);
> -
> +	kfree(dev->iommu_param);
>  	kfree(device->name);
>  	kfree(device);
>  	dev->iommu_group = NULL;
> @@ -855,6 +863,123 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>  
>  /**
> + * iommu_register_device_fault_handler() - Register a device fault handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the handler
> + *
> + * When an IOMMU fault event is received, this handler gets called with the
> + * fault event and data as argument.
> + *
> + * Return 0 if the fault handler was installed successfully, or an error.
> + */
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param) {
> +		ret = -EBUSY;
> +		goto done_unlock;
> +	}
> +
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		ret = -ENOMEM;
> +		goto done_unlock;
> +	}
> +	param->fault_param->handler = handler;
> +	param->fault_param->data = data;
> +
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +
> +	if (!param->fault_param)
> +		goto unlock;
> +
> +	kfree(param->fault_param);
> +	param->fault_param = NULL;
> +	put_device(dev);
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +

One blank line probably enough.. (my personal favourite
stylistic nitpick ;)

> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
> + * handler.

What constraints does that put on it?  We probably don't care about the
fact it is in a threaded irq as such, rather something that is true as
a result of that?

> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	struct iommu_fault_param *fparam;
> +	int ret = 0;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!param || !evt)
> +		return -EINVAL;
> +
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&param->lock);
> +	fparam = param->fault_param;
> +	if (!fparam || !fparam->handler) {
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	ret = fparam->handler(evt, fparam->data);
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> +
> +/**
>   * iommu_group_id - Return ID for a group
>   * @group: the group to ID
>   *
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7890a92..b87b74c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -322,9 +322,9 @@ struct iommu_fault_event {
>  
>  /**
>   * struct iommu_fault_param - per-device IOMMU fault data
> - * @dev_fault_handler: Callback function to handle IOMMU faults at device level
> - * @data: handler private data
>   *
> + * @handler: Callback function to handle IOMMU faults at device level

This should be in the previous patch, not this one.

> + * @data: handler private data
>   */
>  struct iommu_fault_param {
>  	iommu_dev_fault_handler_t handler;
> @@ -341,6 +341,7 @@ struct iommu_fault_param {
>   *	struct iommu_fwspec	*iommu_fwspec;
>   */
>  struct iommu_param {
> +	struct mutex lock;

Structure has kernel doc so this should be added to that.

>  	struct iommu_fault_param *fault_param;
>  };
>  
> @@ -433,6 +434,15 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
>  					 struct notifier_block *nb);
>  extern int iommu_group_unregister_notifier(struct iommu_group *group,
>  					   struct notifier_block *nb);
> +extern int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data);
> +
> +extern int iommu_unregister_device_fault_handler(struct device *dev);
> +
> +extern int iommu_report_device_fault(struct device *dev,
> +				     struct iommu_fault_event *evt);
> +
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
> @@ -741,6 +751,25 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
>  	return 0;
>  }
>  
> +static inline
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;


