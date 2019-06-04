Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB93C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F096320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559663554;
	bh=QfvCKDJp8Es7MYRcaMIXsgUghIeWtwKUC27RbPRUb4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gq4YnWoWSP8/ISrRrMZrAl/AOnVsmA7w7nAIpEzPHRivoRZc1zupQNnm+/3w/Cu74
	 y2jDfq2TH14L2j4ZYhAQJBTNoqp1CfnO6vq0PTPsxCFDnNjTAw6G9YfCiZwLj39FPP
	 KebyvvIcNGV/pZLyCYhbpqEXAq8njWb53k7WaSXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfFDPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfFDPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:52:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4D42053B;
        Tue,  4 Jun 2019 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559663551;
        bh=QfvCKDJp8Es7MYRcaMIXsgUghIeWtwKUC27RbPRUb4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ul36q5bDJsxC6Yivv3gZtQVCJTzUKvrhMlsokJxZQJsPWcuTc6FqYHCUOtgFGgREt
         J0CZ+jpVtCDhM1MXss7PahI6QMhFqhSRIVdAKn/v/ygFvrX/a3zK/DPJhB99jJYo48
         oSnA7ZyD1ydo05Adflo7my89W5k75zPpijD3Kbgc=
Date:   Tue, 4 Jun 2019 17:52:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
Message-ID: <20190604155228.GB9981@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604152019.16100-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 05:20:12PM +0200, Enric Balletbo i Serra wrote:
> That's a driver to talk with the ChromeOS Embedded Controller via a
> miscellaneous character device, it creates an entry in /dev for every
> instance and implements basic file operations for communicating with the
> Embedded Controller with an userspace application. The API is moved to
> the uapi folder, which is supposed to contain the user space API of the
> kernel.
> 
> Note that this will replace current character device interface
> implemented in the cros-ec-dev driver in the MFD subsystem. The idea is
> to move all the functionality that extends the bounds of what MFD was
> designed to platform/chrome subsystem.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/ioctl/ioctl-number.txt          |   2 +-
>  drivers/mfd/cros_ec_dev.c                     |   2 +-
>  drivers/platform/chrome/Kconfig               |  11 +
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_chardev.c     | 279 ++++++++++++++++++
>  .../uapi/linux/cros_ec_chardev.h              |  18 +-
>  6 files changed, 302 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
>  rename drivers/mfd/cros_ec_dev.h => include/uapi/linux/cros_ec_chardev.h (70%)
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index c9558146ac58..8bd7907ee36d 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -340,7 +340,7 @@ Code  Seq#(hex)	Include File		Comments
>  0xDD	00-3F	ZFCP device driver	see drivers/s390/scsi/
>  					<mailto:aherrman@de.ibm.com>
>  0xE5	00-3F	linux/fuse.h
> -0xEC	00-01	drivers/platform/chrome/cros_ec_dev.h	ChromeOS EC driver
> +0xEC	00-01	include/uapi/linux/cros_ec_chardev.h	ChromeOS EC driver
>  0xF3	00-3F	drivers/usb/misc/sisusbvga/sisusb.h	sisfb (in development)
>  					<mailto:thomas@winischhofer.net>
>  0xF4	00-1F	video/mbxfb.h		mbxfb
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 607383b67cf1..11b791c28f84 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -15,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  
> -#include "cros_ec_dev.h"
> +#include <uapi/linux/cros_ec_chardev.h>
>  
>  #define DRV_NAME "cros-ec-dev"
>  
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 9417b982ad92..3a9ad001838a 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -147,6 +147,17 @@ config CROS_KBD_LED_BACKLIGHT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_kbd_led_backlight.
>  
> +config CROS_EC_CHARDEV
> +	tristate "ChromeOS EC miscdevice"
> +	depends on MFD_CROS_EC_CHARDEV
> +	default MFD_CROS_EC_CHARDEV
> +	help
> +	  This driver adds file operations support to talk with the
> +	  ChromeOS EC from userspace via a character device.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_chardev.
> +
>  config CROS_EC_LIGHTBAR
>  	tristate "Chromebook Pixel's lightbar support"
>  	depends on MFD_CROS_EC_CHARDEV
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index ebb57e21923b..d47a7e1097ee 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -16,6 +16,7 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
> +obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
> new file mode 100644
> index 000000000000..1a0a27080026
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Miscellaneous character driver for ChromeOS Embedded Controller
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include <uapi/linux/cros_ec_chardev.h>
> +
> +#define DRV_NAME	"cros-ec-chardev"
> +
> +static LIST_HEAD(chardev_devices);
> +static DEFINE_SPINLOCK(chardev_lock);
> +
> +struct chardev_data {
> +	struct list_head list;
> +	struct cros_ec_dev *ec_dev;
> +	struct miscdevice misc;
> +};
> +
> +static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
> +{
> +	static const char * const current_image_name[] = {
> +		"unknown", "read-only", "read-write", "invalid",
> +	};
> +	struct ec_response_get_version *resp;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
> +	msg->insize = sizeof(*resp);
> +
> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +	if (ret < 0) {
> +		snprintf(str, maxlen,
> +			 "Unknown EC version, returned error: %d\n",
> +			 msg->result);
> +		goto exit;
> +	}
> +
> +	resp = (struct ec_response_get_version *)msg->data;
> +	if (resp->current_image >= ARRAY_SIZE(current_image_name))
> +		resp->current_image = 3; /* invalid */
> +
> +	snprintf(str, maxlen, "%s\n%s\n%s\n",
> +		 resp->version_string_ro,
> +		 resp->version_string_rw,
> +		 current_image_name[resp->current_image]);
> +
> +	ret = 0;
> +exit:
> +	kfree(msg);
> +	return ret;
> +}
> +
> +/*
> + * Device file ops
> + */
> +static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
> +{
> +	struct miscdevice *mdev = filp->private_data;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(mdev->parent);
> +
> +	filp->private_data = ec_dev;
> +	nonseekable_open(inode, filp);
> +
> +	return 0;
> +}
> +
> +static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
> +				     size_t length, loff_t *offset)
> +{
> +	char msg[sizeof(struct ec_response_get_version) +
> +		 sizeof(CROS_EC_DEV_VERSION)];
> +	struct cros_ec_dev *ec = filp->private_data;
> +	size_t count;
> +	int ret;
> +
> +	if (*offset != 0)
> +		return 0;
> +
> +	ret = ec_get_version(ec, msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +
> +	count = min(length, strlen(msg));
> +
> +	if (copy_to_user(buffer, msg, count))
> +		return -EFAULT;
> +
> +	*offset = count;
> +	return count;
> +}
> +
> +/*
> + * Ioctls
> + */
> +static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
> +{
> +	struct cros_ec_command *s_cmd;
> +	struct cros_ec_command u_cmd;
> +	long ret;
> +
> +	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
> +		return -EFAULT;
> +
> +	if (u_cmd.outsize > EC_MAX_MSG_BYTES ||
> +	    u_cmd.insize > EC_MAX_MSG_BYTES)
> +		return -EINVAL;
> +
> +	s_cmd = kmalloc(sizeof(*s_cmd) + max(u_cmd.outsize, u_cmd.insize),
> +			GFP_KERNEL);
> +	if (!s_cmd)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(s_cmd, arg, sizeof(*s_cmd) + u_cmd.outsize)) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (u_cmd.outsize != s_cmd->outsize ||
> +	    u_cmd.insize != s_cmd->insize) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	s_cmd->command += ec->cmd_offset;
> +	ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
> +	/* Only copy data to userland if data was received. */
> +	if (ret < 0)
> +		goto exit;
> +
> +	if (copy_to_user(arg, s_cmd, sizeof(*s_cmd) + s_cmd->insize))
> +		ret = -EFAULT;
> +exit:
> +	kfree(s_cmd);
> +	return ret;
> +}
> +
> +static long cros_ec_chardev_ioctl_readmem(struct cros_ec_dev *ec,
> +					   void __user *arg)
> +{
> +	struct cros_ec_device *ec_dev = ec->ec_dev;
> +	struct cros_ec_readmem s_mem = { };
> +	long num;
> +
> +	/* Not every platform supports direct reads */
> +	if (!ec_dev->cmd_readmem)
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
> +		return -EFAULT;
> +
> +	num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
> +				  s_mem.buffer);
> +	if (num <= 0)
> +		return num;
> +
> +	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
> +		return -EFAULT;
> +
> +	return num;
> +}
> +
> +static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	struct cros_ec_dev *ec = filp->private_data;
> +
> +	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
> +		return -ENOTTY;
> +
> +	switch (cmd) {
> +	case CROS_EC_DEV_IOCXCMD:
> +		return cros_ec_chardev_ioctl_xcmd(ec, (void __user *)arg);
> +	case CROS_EC_DEV_IOCRDMEM:
> +		return cros_ec_chardev_ioctl_readmem(ec, (void __user *)arg);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static const struct file_operations chardev_fops = {
> +	.open		= cros_ec_chardev_open,
> +	.read		= cros_ec_chardev_read,
> +	.unlocked_ioctl	= cros_ec_chardev_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= cros_ec_chardev_ioctl,
> +#endif
> +};
> +
> +static int cros_ec_chardev_probe(struct platform_device *pdev)
> +{
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
> +	struct cros_ec_platform *ec_platform = dev_get_platdata(ec_dev->dev);
> +	struct chardev_data *data;
> +	int ret;
> +
> +	/* Create a char device: we want to create it anew */
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ec_dev = ec_dev;
> +	data->misc.minor = MISC_DYNAMIC_MINOR;
> +	data->misc.fops = &chardev_fops;
> +	data->misc.name = ec_platform->ec_name;
> +	data->misc.parent = pdev->dev.parent;
> +
> +	ret = misc_register(&data->misc);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock(&chardev_lock);
> +	list_add(&data->list, &chardev_devices);
> +	spin_unlock(&chardev_lock);
> +
> +	dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> +		 data->misc.name);

No need to be noisy, if all goes well, your code should be quiet.

> +
> +	return 0;
> +}
> +
> +static int cros_ec_chardev_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
> +	struct chardev_data *data;
> +
> +	list_for_each_entry(data, &chardev_devices, list)
> +		if (data->ec_dev == ec_dev)
> +			break;
> +
> +	if (data->ec_dev != ec_dev) {
> +		dev_err(&pdev->dev,
> +			"remove called but miscdevice %s not found\n",
> +			data->misc.name);
> +		return -ENODEV;
> +	}

Why do you have this separate list of devices?  You don't seem to need
it, you only iterate over it, why is it needed?

> +	spin_lock(&chardev_lock);
> +	list_del(&data->list);
> +	spin_unlock(&chardev_lock);
> +	misc_deregister(&data->misc);
> +
> +	return 0;
> +}

You also iterate over the list without the lock, so why even have the
lock?  Are you sure the list, and the lock, is even needed?

thanks,

greg k-h
