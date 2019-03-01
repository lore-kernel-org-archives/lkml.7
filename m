Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C6EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE745218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551424652;
	bh=wiZAzWmLskZy5+PQ7b3ociPnBJSCYq2ehso9NEGlhHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jh4awtGnPPcvetNuHtyOvrx322rHa5fni7PhHA6VrcAvh8W7oISB5HMv6wOTvcZM
	 YxpOdwOg5WQpXabhivLxbe3Apmxbtm3/Meqw2d6mkp2/gT11dyuCfOQC3K5ECougIk
	 7OubFTh71D8eagaHe1L8kF8KFwoJGkbbovb22blw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfCAHRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCAHRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:17:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007C620830;
        Fri,  1 Mar 2019 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551424649;
        bh=wiZAzWmLskZy5+PQ7b3ociPnBJSCYq2ehso9NEGlhHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTyWzqBXBJ+G7H1fXutYA8CM1RyBvBkUyjLn1jYLoCJq+Q8PKctfJ4O/MkGmuXo5A
         gLfgPfgxj19c6XLfsxVKC3V/+WqXBQAiGKXq40BLiyyHjZEiv+WyJvcHEVCQAgc4zW
         dLBxjaP2UfbEfFPkJvsEHOl3Z7GznBXlwSdYdL+8=
Date:   Fri, 1 Mar 2019 08:17:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net, jiri@mellanox.com
Subject: Re: [RFC net-next 1/8] subdev: Introducing subdev bus
Message-ID: <20190301071727.GA8975@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-2-git-send-email-parav@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551418672-12822-2-git-send-email-parav@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:37:45PM -0600, Parav Pandit wrote:
> Introduce a new subdev bus which holds sub devices created from a
> primary device. These devices are named as 'subdev'.
> A subdev is identified similarly to pci device using 16-bit vendor id
> and device id.
> Unlike PCI devices, scope of subdev is limited to Linux kernel.

But these are limited to only PCI devices, right?

This sounds a lot like that ARM proposal a week or so ago that asked for
something like this, are you working with them to make sure your
proposal works for them as well?  (sorry, can't find where that was
announced, it was online somewhere...)

> A central entry that assigns unique subdev vendor and device id is:
> include/linux/subdev_ids.h enums. Enum are chosen over define macro so
> that two vendors do not end up with vendor id in kernel development
> process.

Why not just make it dynamic with on static ids?

> subdev bus holds subdevices of multiple devices. A typical created
> subdev for a PCI device in sysfs tree appears under their parent's
> device as using core's default device naming scheme:
> 
> subdev<instance_id>.
> i.e.
> subdev0
> subdev1
> 
> $ ls -l /sys/bus/pci/devices/0000:05:00.0
> [..]
> drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev0
> drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev1
> 
> Device model view:
> ------------------
>                +------+    +------+       +------+
>                |subdev|    |subdev|       |subdev|
>           -----|  1   |----|  2   |-------|  3   |----------
>           |    +--|---+    +-|----+       +--|---+         |
>           --------|----------|---subdev bus--|--------------
>                   |          |               |
>                +--+----+-----+           +---+---+
>                |pcidev |                 |pcidev |
>           -----|   A   |-----------------|   B   |----------
>           |    +-------+                 +-------+         |
>           -------------------pci bus------------------------

To be clear, "subdev bus" is just a logical grouping, there is no
physical backing "bus" here at all, right?

What is going to "bind" to subdev devices?  PCI drivers?  Or new types
of drivers?

> subdev are allocated and freed using subdev_alloc(), subdev_free() APIs.
> A driver which wants to create actual class driver such as
> net/block/infiniband need to use subdev_register_driver(),
> subdev_unregister_driver() APIs.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/subdev/Kconfig          |  12 ++++
>  drivers/subdev/Makefile         |   8 +++
>  drivers/subdev/subdev_main.c    | 153 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mod_devicetable.h |  12 ++++
>  include/linux/subdev_bus.h      |  63 +++++++++++++++++
>  include/linux/subdev_ids.h      |  17 +++++
>  8 files changed, 268 insertions(+)
>  create mode 100644 drivers/subdev/Kconfig
>  create mode 100644 drivers/subdev/Makefile
>  create mode 100644 drivers/subdev/subdev_main.c
>  create mode 100644 include/linux/subdev_bus.h
>  create mode 100644 include/linux/subdev_ids.h
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4f9f990..1818796 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
>  
>  source "drivers/slimbus/Kconfig"
>  
> +source "drivers/subdev/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index e1ce029..a040e96 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
>  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
>  obj-$(CONFIG_SIOX)		+= siox/
>  obj-$(CONFIG_GNSS)		+= gnss/
> +obj-$(CONFIG_SUBDEV)		+= subdev/
> diff --git a/drivers/subdev/Kconfig b/drivers/subdev/Kconfig
> new file mode 100644
> index 0000000..8ce3acc
> --- /dev/null
> +++ b/drivers/subdev/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# subdev configuration
> +#
> +
> +config SUBDEV
> +	tristate "subdev bus driver"
> +	help
> +	The subdev bus driver allows creating hardware based sub devices
> +	from a parent device. The subdev bus driver is required to create,
> +	discover devices and to attach device drivers to this subdev
> +	devices. These subdev devices are created using devlink tool by
> +	user.


Your definition of the bus uses the name of the bus in the definition :)

> diff --git a/drivers/subdev/Makefile b/drivers/subdev/Makefile
> new file mode 100644
> index 0000000..405b74a
> --- /dev/null
> +++ b/drivers/subdev/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for subdev bus driver
> +#
> +
> +obj-$(CONFIG_SUBDEV)	+= subdev.o
> +
> +subdev-y := subdev_main.o
> diff --git a/drivers/subdev/subdev_main.c b/drivers/subdev/subdev_main.c
> new file mode 100644
> index 0000000..4aabcaa
> --- /dev/null
> +++ b/drivers/subdev/subdev_main.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/subdev_bus.h>
> +
> +static DEFINE_XARRAY_FLAGS(subdev_ids, XA_FLAGS_ALLOC);

Why not an idr?

> +
> +static int subdev_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct subdev_driver *subdev_drv = to_subdev_driver(drv);
> +	const struct subdev_id *ids = subdev_drv->id_table;
> +	const struct subdev *subdev = to_subdev_device(dev);
> +
> +	while (ids) {
> +		if (ids->vendor_id == subdev->dev_id.vendor_id &&
> +		    ids->device_id == subdev->dev_id.device_id)
> +			return 1;
> +
> +		ids++;
> +	}
> +	return 0;
> +}
> +
> +static struct bus_type subdev_bus_type = {
> +	.dev_name = "subdev",
> +	.name = "subdev",
> +	.match = subdev_bus_match,
> +};
> +
> +int __subdev_register_driver(struct subdev_driver *drv, struct module *owner,
> +			     const char *mod_name)
> +{
> +	drv->driver.name = mod_name;
> +	drv->driver.bus = &subdev_bus_type;
> +	drv->driver.owner = owner;
> +	drv->driver.mod_name = mod_name;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL(__subdev_register_driver);

EXPORT_SYMBOL_GPL() for this and the other ones as you are just wrapping
the driver core logic loosely.

> +
> +void subdev_unregister_driver(struct subdev_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL(subdev_unregister_driver);
> +
> +static void subdev_release(struct device *dev)
> +{
> +	struct subdev *subdev = to_subdev_device(dev);
> +
> +	kfree(subdev);
> +}
> +
> +/**
> + * _subdev_alloc_subdev - Allocate a subdev device.
> + * @size:	Size of the device that to allocate that contains subdev
> + *		device as the first element.
> + * Returns pointer to a valid subdev structure or returns ERR_PTR.
> + *
> + */
> +struct subdev *_subdev_alloc_dev(size_t size)
> +{
> +	struct subdev *subdev;
> +
> +	subdev = kzalloc(size, GFP_KERNEL);
> +	if (!subdev)
> +		return ERR_PTR(-ENOMEM);
> +	subdev->dev.release = subdev_release;
> +	device_initialize(&subdev->dev);
> +	return subdev;
> +}
> +EXPORT_SYMBOL(_subdev_alloc_dev);
> +
> +/**
> + * subdev_free_dev - Free allocated subdev device.
> + * @subdev:	Pointer to subdev
> + *
> + */
> +void subdev_free_dev(struct subdev *subdev)
> +{
> +	put_device(&subdev->dev);
> +}
> +EXPORT_SYMBOL(subdev_free_dev);
> +
> +/**
> + * subdev_add_dev - Add a sub device to bus.
> + * @subdev:	subdev devie to be placed on the bus
> + * @parent_dev:	Parent device of the subdev
> + * @vid:	Vendor ID of the device
> + * @did:	Device ID of the device
> + *
> + * Returns 0 on successfully adding subdev to bus or error code on failure.
> + * Once the device is added, it can be probed by the device driver who
> + * wish to match it.
> + *
> + */
> +int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
> +		   enum subdev_vendor_id vid, enum subdev_device_id did)
> +{
> +	u32 id = 0;
> +	int ret;
> +
> +	if (!parent_dev)
> +		return -EINVAL;

No root devices?

> +
> +	ret = xa_alloc(&subdev_ids, &id, UINT_MAX, NULL, GFP_KERNEL);

No locking needed?

> +	if (ret < 0)
> +		return ret;
> +
> +	subdev->dev.id = id;
> +	subdev->dev_id.vendor_id = vid;
> +	subdev->dev_id.device_id = did;
> +	subdev->dev.parent = parent_dev;
> +	subdev->dev.bus = &subdev_bus_type;
> +	subdev->dev.dma_mask = parent_dev->dma_mask;
> +	subdev->dev.dma_parms = parent_dev->dma_parms;
> +	subdev->dev.coherent_dma_mask = parent_dev->coherent_dma_mask;
> +	ret = device_add(&subdev->dev);
> +	if (ret)
> +		xa_erase(&subdev_ids, id);
> +	return ret;
> +}
> +EXPORT_SYMBOL(subdev_add_dev);
> +
> +/**
> + * subdev_delete_dev - Delete previously added subdev device
> + *
> + * @subdev:	Pointer to subdev device to delete
> + */
> +void subdev_delete_dev(struct subdev *subdev)
> +{
> +	device_del(&subdev->dev);
> +	xa_erase(&subdev_ids, subdev->dev.id);
> +}
> +EXPORT_SYMBOL(subdev_delete_dev);
> +
> +static int __init subdev_init(void)
> +{
> +	return bus_register(&subdev_bus_type);
> +}
> +
> +static void __exit subdev_exit(void)
> +{
> +	bus_unregister(&subdev_bus_type);
> +}
> +
> +module_init(subdev_init);
> +module_exit(subdev_exit);
> +
> +MODULE_LICENSE("GPL");

Nit, for a few more weeks, this needs to be "GPL v2".

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index f9bd2f3..f271dab 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -779,4 +779,16 @@ struct typec_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +/**
> + * struct subdev_id - subdev device identifiers defined in
> + *		      include/linux/subdev_ids.h
> + *
> + * @vendor_id: Vendor ID
> + * @device_id: Device ID
> + */
> +struct subdev_id {
> +	__u16 vendor_id;
> +	__u16 device_id;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
> diff --git a/include/linux/subdev_bus.h b/include/linux/subdev_bus.h
> new file mode 100644
> index 0000000..c6410e3
> --- /dev/null
> +++ b/include/linux/subdev_bus.h
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef SUBDEV_BUS_H
> +#define SUBDEV_BUS_H
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/device.h>
> +#include <linux/subdev_ids.h>
> +
> +struct subdev_driver {
> +	const struct subdev_id *id_table;
> +	struct device_driver driver;
> +	struct list_head list;
> +};
> +
> +#define to_subdev_driver(x) container_of(x, struct subdev_driver, driver)
> +
> +int __subdev_register_driver(struct subdev_driver *drv, struct module *owner,
> +			     const char *mod_name);
> +#define subdev_register_driver(driver)		\
> +	__subdev_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> +
> +void subdev_unregister_driver(struct subdev_driver *dev);
> +
> +/**
> + * subdev - A subdev device representation
> + *
> + * @dev:	device struct that represent subdev device in core device model
> + * @dev_id:	Unique vendor id, device id that subdev device drivers match
> + *		against. A unique id that defines this subdev assigned in
> + *		include/linux/subdev_ids.h
> + */
> +struct subdev {
> +	struct device dev;
> +	struct subdev_id dev_id;
> +};
> +
> +#define to_subdev_device(x) container_of(x, struct subdev, dev)
> +
> +struct subdev *_subdev_alloc_dev(size_t size);
> +
> +/**
> + * subdev_alloc_dev -	allocate memory for driver structure which holds
> + *			subdev structure and other driver's device specific
> + *			fields.
> + * @drv_struct:		Driver's device structure which defines subdev device
> + *			as the first member in the structure.
> + * @member:		Name of the subdev instance name in drivers device
> + *			structure.
> + */
> +#define subdev_alloc_dev(drv_struct, member)                                \
> +	container_of(_subdev_alloc_dev(sizeof(struct drv_struct) +          \
> +				      BUILD_BUG_ON_ZERO(offsetof(           \
> +					      struct drv_struct, member))), \
> +		     struct drv_struct, member)
> +
> +void subdev_free_dev(struct subdev *subdev);
> +
> +int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
> +		   enum subdev_vendor_id vid, enum subdev_device_id did);
> +void subdev_delete_dev(struct subdev *subdev);
> +
> +#endif
> diff --git a/include/linux/subdev_ids.h b/include/linux/subdev_ids.h
> new file mode 100644
> index 0000000..361faa3
> --- /dev/null
> +++ b/include/linux/subdev_ids.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef SUBDEV_IDS_H
> +#define SUBDEV_IDS_H
> +
> +enum subdev_vendor_id {
> +	SUBDEV_VENDOR_ID_MELLANOX,
> +
> +	/* new device id must be added above at the end */

Again, why ids at all?

So far, this is just a very loose wrapping of the driver core bus
functionality, which is fine, but I really don't see the goal here...

thanks,

greg k-h
