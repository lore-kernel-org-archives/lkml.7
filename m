Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677FF20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfCYL7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbfCYL7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:59:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 824E53060487;
        Mon, 25 Mar 2019 11:59:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76E866EDB1;
        Mon, 25 Mar 2019 11:58:56 +0000 (UTC)
Message-ID: <2eb96074b91bb9b8cc2c46c6e1d0e20e790a8531.camel@redhat.com>
Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal
 if one fails
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Parav Pandit <parav@mellanox.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Date:   Mon, 25 Mar 2019 13:58:55 +0200
In-Reply-To: <1553296835-37522-8-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
         <1553296835-37522-8-git-send-email-parav@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 25 Mar 2019 11:59:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 18:20 -0500, Parav Pandit wrote:
> device_for_each_child() stops executing callback function for remaining
> child devices, if callback hits an error.
> Each child mdev device is independent of each other.
> While unregistering parent device, mdev core must remove all child mdev
> devices.
> Therefore, mdev_device_remove_cb() always returns success so that
> device_for_each_child doesn't abort if one child removal hits error.
> 
> While at it, improve remove and unregister functions for below simplicity.
> 
> There isn't need to pass forced flag pointer during mdev parent
> removal which invokes mdev_device_remove(). So simplify the flow.
> 
> mdev_device_remove() is called from two paths.
> 1. mdev_unregister_driver()
>      mdev_device_remove_cb()
>        mdev_device_remove()
> 2. remove_store()
>      mdev_device_remove()
> 
> When device is removed by user using remote_store(), device under
> removal is mdev device.
> When device is removed during parent device removal using generic child
> iterator, mdev check is already done using dev_is_mdev().
> 
> Hence, remove the unnecessary loop in mdev_device_remove().
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index ab05464..944a058 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -150,10 +150,10 @@ static int mdev_device_remove_ops(struct mdev_device
> *mdev, bool force_remove)
>  
>  static int mdev_device_remove_cb(struct device *dev, void *data)
>  {
> -	if (!dev_is_mdev(dev))
> -		return 0;
> +	if (dev_is_mdev(dev))
> +		mdev_device_remove(dev, true);
>  
> -	return mdev_device_remove(dev, data ? *(bool *)data : true);
> +	return 0;
>  }
>  
>  /*
> @@ -241,7 +241,6 @@ int mdev_register_device(struct device *dev, const struct
> mdev_parent_ops *ops)
>  void mdev_unregister_device(struct device *dev)
>  {
>  	struct mdev_parent *parent;
> -	bool force_remove = true;
>  
>  	mutex_lock(&parent_list_lock);
>  	parent = __find_parent_device(dev);
> @@ -255,8 +254,7 @@ void mdev_unregister_device(struct device *dev)
>  	list_del(&parent->next);
>  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
>  
> -	device_for_each_child(dev, (void *)&force_remove,
> -			      mdev_device_remove_cb);
> +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
>  
>  	parent_remove_sysfs_files(parent);
>  
> @@ -346,24 +344,12 @@ int mdev_device_create(struct kobject *kobj, struct
> device *dev, uuid_le uuid)
>  
>  int mdev_device_remove(struct device *dev, bool force_remove)
>  {
> -	struct mdev_device *mdev, *tmp;
> +	struct mdev_device *mdev;
>  	struct mdev_parent *parent;
>  	struct mdev_type *type;
>  	int ret;
>  
>  	mdev = to_mdev_device(dev);
> -
> -	mutex_lock(&mdev_list_lock);
> -	list_for_each_entry(tmp, &mdev_list, next) {
> -		if (tmp == mdev)
> -			break;
> -	}
> -
> -	if (tmp != mdev) {
> -		mutex_unlock(&mdev_list_lock);
> -		return -ENODEV;
> -	}
> -
>  	if (!mdev->active) {
>  		mutex_unlock(&mdev_list_lock);
>  		return -EAGAIN;

Very nice catch and good refactoring.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

