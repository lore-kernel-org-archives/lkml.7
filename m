Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A437520854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MO7pEY6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfCYTfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:35:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17713 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfCYTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:35:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c992d8f0000>; Mon, 25 Mar 2019 12:35:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 12:35:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Mar 2019 12:35:40 -0700
Received: from [10.24.70.95] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 19:35:37 +0000
Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
 one fails
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-8-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d3a9ba59-59dd-7924-72e0-09652dce8914@nvidia.com>
Date:   Tue, 26 Mar 2019 01:05:34 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-8-git-send-email-parav@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553542543; bh=Af8qLPfmOgXrjW++mAogPWXGaygjK/yWaXqDty1r2u0=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MO7pEY6qjht/ldei/W7eAVuMRnHdVkUmYAaKgWcLuIMOzZWWHVBk7BFiWylofrqQ7
         NvaZgUAcaCNtO/K9n5sduG3NwswngCQpcPPwAw1QQGCl8apsLmSxeQQHdDY1rbr+do
         6x4//vjx/SI6EKRpq+0ivbt6iz8uxB2uNv3C4dPECQg2pNezSAaxCxoxlFbX9s+6Ur
         29kPuufSA86YnFeXrgDeQUtYOg5jgaFtmFoYe+1duQ+UyVLqP1gVXz5TJY7E1j5iO2
         0w7mWEjS5XnJ/0eMZzWgKi7ubKgNiIv3NqW6G+m3Ydna2XJKNY0mKHDOjNitBO0459
         jjuMbasfOYhVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> device_for_each_child() stops executing callback function for remaining
> child devices, if callback hits an error.
> Each child mdev device is independent of each other.
> While unregistering parent device, mdev core must remove all child mdev
> devices.
> Therefore, mdev_device_remove_cb() always returns success so that
> device_for_each_child doesn't abort if one child removal hits error.
> 

When unregistering parent device, force_remove is set to true amd
mdev_device_remove_ops() always returns success.

> While at it, improve remove and unregister functions for below simplicity.
> 
> There isn't need to pass forced flag pointer during mdev parent
> removal which invokes mdev_device_remove().

There is a need to pass the flag, pasting here the comment above
mdev_device_remove_ops() which explains why the flag is needed:

/*
 * mdev_device_remove_ops gets called from sysfs's 'remove' and when parent
 * device is being unregistered from mdev device framework.
 * - 'force_remove' is set to 'false' when called from sysfs's 'remove'
which
 *   indicates that if the mdev device is active, used by VMM or userspace
 *   application, vendor driver could return error then don't remove the
device.
 * - 'force_remove' is set to 'true' when called from
mdev_unregister_device()
 *   which indicate that parent device is being removed from mdev device
 *   framework so remove mdev device forcefully.
 */

Thanks,
Kirti

 So simplify the flow.
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
> @@ -150,10 +150,10 @@ static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
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
> @@ -241,7 +241,6 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
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
> @@ -346,24 +344,12 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
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
> 
