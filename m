Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D2C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF222173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbfC2I0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:26:36 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51854 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728972AbfC2I0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:26:36 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9mqJhMwfoUjKf9mqMhusax; Fri, 29 Mar 2019 09:26:31 +0100
Subject: Re: [PATCH v13 1/6] media: Media Device Allocator API
To:     Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1553814518.git.shuah@kernel.org>
 <b578708ff816196b9c7b286f3ae07278c1266290.1553814518.git.shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d6714023-9396-4db4-84db-92e87f2f81db@xs4all.nl>
Date:   Fri, 29 Mar 2019 09:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b578708ff816196b9c7b286f3ae07278c1266290.1553814518.git.shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGVcoA+cBhLvqxGEcFcQ3WlY+UOEy8ICbayeLr7ZmgvZFUiZH0ilcO92KRqHOJlRpfKe8+JlqQzLbeQsgVic3RD4CBe5OhcJA0i13tWI1ESuTjDDo4Cw
 Z4pbU4x+YTNtHOC5yJwRCrjbjk8vFuyl5X/hyCHTnxmaUMUZR13j6YGaXnEHceDNvMLCZPGcMFlU7r5QUx38ShI9fN1k0VRbndyDyYry6wXG9SE7puGbUf2k
 uhBDs/ir36hAOetw0ESCgovx0pjXqvR0KpWdK93u9W9LpNx8Nq8JFrhjdU6i7G/9k5cD+5FKLgsOpf4xsffTbQVGHkSXSvNG1vXy709wod96Co27nTYbcNHJ
 KS8ua6mxeic2t6VuwA/IW3+3RXXI2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Thanks! This looks much better.

I have a few remaining trivial comments:

On 3/29/19 1:04 AM, Shuah Khan wrote:
> Media Device Allocator API to allows multiple drivers share a media device.
> This API solves a very common use-case for media devices where one physical
> device (an USB stick) provides both audio and video. When such media device
> exposes a standard USB Audio class, a proprietary Video class, two or more
> independent drivers will share a single physical USB bridge. In such cases,
> it is necessary to coordinate access to the shared resource.
> 
> Using this API, drivers can allocate a media device with the shared struct
> device as the key. Once the media device is allocated by a driver, other
> drivers can get a reference to it. The media device is released when all
> the references are released.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  Documentation/media/kapi/mc-core.rst |  41 +++++++++
>  drivers/media/Makefile               |   6 ++
>  drivers/media/media-dev-allocator.c  | 133 +++++++++++++++++++++++++++
>  include/media/media-dev-allocator.h  |  63 +++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 drivers/media/media-dev-allocator.c
>  create mode 100644 include/media/media-dev-allocator.h
> 
> diff --git a/Documentation/media/kapi/mc-core.rst b/Documentation/media/kapi/mc-core.rst
> index f930725e0d6b..05bba0b61748 100644
> --- a/Documentation/media/kapi/mc-core.rst
> +++ b/Documentation/media/kapi/mc-core.rst
> @@ -259,6 +259,45 @@ Subsystems should facilitate link validation by providing subsystem specific
>  helper functions to provide easy access for commonly needed information, and
>  in the end provide a way to use driver-specific callbacks.
>  
> +Media Controller Device Allocator API
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +When the media device belongs to more than one driver, the shared media
> +device is allocated with the shared struct device as the key for look ups.
> +
> +The shared media device should stay in registered state until the last
> +driver unregisters it. In addition, the media device should be released when
> +all the references are released. Each driver gets a reference to the media
> +device during probe, when it allocates the media device. If media device is
> +already allocated, the allocate API bumps up the refcount and returns the
> +existing media device. The driver puts the reference back in its disconnect
> +routine when it calls :c:func:`media_device_delete()`.
> +
> +The media device is unregistered and cleaned up from the kref put handler to
> +ensure that the media device stays in registered state until the last driver
> +unregisters the media device.
> +
> +**Driver Usage**
> +
> +Drivers should use the appropriate media-core routines to manage the shared
> +media device life-time handling the two states:
> +1. allocate -> register -> delete
> +2. get reference to already registered device -> delete
> +
> +call :c:func:`media_device_delete()` routine to make sure the shared media
> +device delete is handled correctly.
> +
> +**driver probe:**
> +Call :c:func:`media_device_usb_allocate()` to allocate or get a reference
> +Call :c:func:`media_device_register()`, if media devnode isn't registered
> +
> +**driver disconnect:**
> +Call :c:func:`media_device_delete()` to free the media_device. Freeing is
> +handled by the kref put handler.
> +
> +API Definitions
> +^^^^^^^^^^^^^^^
> +
>  .. kernel-doc:: include/media/media-device.h
>  
>  .. kernel-doc:: include/media/media-devnode.h
> @@ -266,3 +305,5 @@ in the end provide a way to use driver-specific callbacks.
>  .. kernel-doc:: include/media/media-entity.h
>  
>  .. kernel-doc:: include/media/media-request.h
> +
> +.. kernel-doc:: include/media/media-dev-allocator.h
> diff --git a/drivers/media/Makefile b/drivers/media/Makefile
> index 985d35ec6b29..4a330d0e5e40 100644
> --- a/drivers/media/Makefile
> +++ b/drivers/media/Makefile
> @@ -6,6 +6,12 @@
>  media-objs	:= media-device.o media-devnode.o media-entity.o \
>  		   media-request.o
>  
> +ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
> +	ifeq ($(CONFIG_USB),y)
> +		media-objs += media-dev-allocator.o
> +	endif
> +endif
> +
>  #
>  # I2C drivers should come before other drivers, otherwise they'll fail
>  # when compiled as builtin drivers
> diff --git a/drivers/media/media-dev-allocator.c b/drivers/media/media-dev-allocator.c
> new file mode 100644
> index 000000000000..8f4ddc4d13f5
> --- /dev/null
> +++ b/drivers/media/media-dev-allocator.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * media-dev-allocator.c - Media Controller Device Allocator API
> + *
> + * Copyright (c) 2018 Shuah Khan <shuah@kernel.org>

Update copyright year to 2019? (check all sources for this)

> + *
> + * Credits: Suggested by Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> + */
> +
> +/*
> + * This file adds a global refcounted Media Controller Device Instance API.
> + * A system wide global media device list is managed and each media device
> + * includes a kref count. The last put on the media device releases the media
> + * device instance.
> + *
> + */
> +
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +
> +#include <media/media-device.h>
> +#include <media/media-dev-allocator.h>
> +
> +static LIST_HEAD(media_device_list);
> +static DEFINE_MUTEX(media_device_lock);
> +
> +struct media_device_instance {
> +	struct media_device mdev;
> +	struct module *owner;
> +	struct list_head list;
> +	struct kref refcount;
> +};
> +
> +static inline struct media_device_instance *
> +to_media_device_instance(struct media_device *mdev)
> +{
> +	return container_of(mdev, struct media_device_instance, mdev);
> +}
> +
> +static void media_device_instance_release(struct kref *kref)
> +{
> +	struct media_device_instance *mdi =
> +		container_of(kref, struct media_device_instance, refcount);
> +
> +	dev_dbg(mdi->mdev.dev, "%s: releasing Media Device\n", __func__);
> +
> +	mutex_lock(&media_device_lock);
> +
> +	media_device_unregister(&mdi->mdev);
> +	media_device_cleanup(&mdi->mdev);
> +
> +	list_del(&mdi->list);
> +	mutex_unlock(&media_device_lock);
> +
> +	kfree(mdi);
> +}
> +
> +/* Callers should hold media_device_lock when calling this function */
> +static struct media_device *__media_device_get(struct device *dev,
> +						const char *module_name,
> +						struct module *modp)

You use various names for the module argument: module, modp, modptr. Why not
always call it 'owner', since that's what it is, and that's what it is called
in struct media_device_instance?

> +{
> +	struct media_device_instance *mdi;
> +
> +	list_for_each_entry(mdi, &media_device_list, list) {
> +

Please drop this empty line.

> +		if (mdi->mdev.dev != dev)
> +			continue;
> +
> +		kref_get(&mdi->refcount);
> +
> +		/* get module reference for the media_device owner */
> +		if (modp != mdi->owner && !try_module_get(mdi->owner))
> +			dev_err(dev, "%s: try_module_get() error\n", __func__);

I recommend that you show module_name in the message, and add an 'else' after
dev_err, otherwise you get both the dev_err and dev_dbg on error.

> +		dev_dbg(dev, "%s: get module_name %s\n",
> +			__func__, module_name);

I think this can fit on one line. Also, perhaps the text of the message should be
a bit clearer?

> +		return &mdi->mdev;
> +	}
> +
> +	mdi = kzalloc(sizeof(*mdi), GFP_KERNEL);
> +	if (!mdi)
> +		return NULL;
> +
> +	mdi->owner = modp;
> +	kref_init(&mdi->refcount);
> +	list_add_tail(&mdi->list, &media_device_list);
> +
> +	dev_dbg(dev, "%s: alloc module_name %s\n", __func__, module_name);

This message can be a bit more clearer as well.

> +	return &mdi->mdev;
> +}
> +
> +struct media_device *media_device_usb_allocate(struct usb_device *udev,
> +					       const char *module_name,
> +					       struct module *modptr)
> +{
> +	struct media_device *mdev;
> +
> +	mutex_lock(&media_device_lock);
> +	mdev = __media_device_get(&udev->dev, module_name, modptr);
> +	if (!mdev) {
> +		mutex_unlock(&media_device_lock);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* check if media device is already initialized */
> +	if (!mdev->dev)
> +		__media_device_usb_init(mdev, udev, udev->product,
> +					module_name);
> +	mutex_unlock(&media_device_lock);
> +	return mdev;
> +}
> +EXPORT_SYMBOL_GPL(media_device_usb_allocate);
> +
> +void media_device_delete(struct media_device *mdev, const char *module_name,
> +			 struct module *modptr)
> +{
> +	struct media_device_instance *mdi = to_media_device_instance(mdev);
> +
> +	dev_dbg(mdi->mdev.dev, "%s: module_name %s\n", __func__, module_name);
> +
> +	mutex_lock(&media_device_lock);
> +	/* put module reference if media_device owner is not modptr */
> +	if (mdi->owner != modptr) {
> +		module_put(mdi->owner);
> +		dev_dbg(mdi->mdev.dev,
> +			"%s decremented owner module reference\n", __func__);
> +	}
> +	mutex_unlock(&media_device_lock);
> +	kref_put(&mdi->refcount, media_device_instance_release);
> +}
> +EXPORT_SYMBOL_GPL(media_device_delete);
> diff --git a/include/media/media-dev-allocator.h b/include/media/media-dev-allocator.h
> new file mode 100644
> index 000000000000..73d8013c8ab5
> --- /dev/null
> +++ b/include/media/media-dev-allocator.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * media-dev-allocator.h - Media Controller Device Allocator API
> + *
> + * Copyright (c) 2018 Shuah Khan <shuah@kernel.org>
> + *
> + * Credits: Suggested by Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> + */
> +
> +/*
> + * This file adds a global ref-counted Media Controller Device Instance API.
> + * A system wide global media device list is managed and each media device
> + * includes a kref count. The last put on the media device releases the media
> + * device instance.
> + */
> +
> +#ifndef _MEDIA_DEV_ALLOCTOR_H
> +#define _MEDIA_DEV_ALLOCTOR_H

ALLOCTOR -> ALLOCATOR

> +
> +struct usb_device;
> +
> +#if defined(CONFIG_MEDIA_CONTROLLER) && defined(CONFIG_USB)
> +/**
> + * media_device_usb_allocate() - Allocate and return struct &media device
> + *
> + * @udev:		struct &usb_device pointer
> + * @module_name:	should be filled with %KBUILD_MODNAME
> + * @module:		struct module pointer %THIS_MODULE for the driver.
> + *			%THIS_MODULE is null for a built-in driver.
> + *			It is safe even when %THIS_MODULE is null.
> + *
> + * This interface should be called to allocate a Media Device when multiple
> + * drivers share usb_device and the media device. This interface allocates
> + * &media_device structure and calls media_device_usb_init() to initialize
> + * it.
> + *
> + */
> +struct media_device *media_device_usb_allocate(struct usb_device *udev,
> +					       const char *module_name,
> +					       struct module *module);
> +/**
> + * media_device_delete() - Release media device. Calls kref_put().
> + *
> + * @mdev:		struct &media_device pointer
> + * @module_name:	should be filled with %KBUILD_MODNAME
> + * @module:		struct module pointer %THIS_MODULE for the driver.
> + *			%THIS_MODULE is null for a built-in driver.
> + *			It is safe even when %THIS_MODULE is null.
> + *
> + * This interface should be called to put Media Device Instance kref.
> + */
> +void media_device_delete(struct media_device *mdev, const char *module_name,
> +			 struct module *module);
> +#else
> +static inline struct media_device *media_device_usb_allocate(
> +			struct usb_device *udev, const char *module_name,
> +			struct module *module)
> +			{ return NULL; }
> +static inline void media_device_delete(
> +			struct media_device *mdev, const char *module_name,
> +			struct module *module) { }

In this header 'module' is used as the name for struct module *. Here too
I recommend changing it to 'owner'.

> +#endif /* CONFIG_MEDIA_CONTROLLER && CONFIG_USB */
> +#endif
> 

Regards,

	Hans
