Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8271217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEIQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:26:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfEIQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:26:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E0D6328159C
Subject: Re: [PATCH v4 2/2] platform/chrome: wilco_ec: Add telemetry char
 device interface
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        bartfab@chromium.org, lamzin@google.com, jchwong@google.com
References: <20190508213810.123200-1-ncrews@chromium.org>
 <20190508213810.123200-2-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f56ba6ab-c246-9243-562f-8eb5b60ea0b4@collabora.com>
Date:   Thu, 9 May 2019 18:26:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508213810.123200-2-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Many thanks for the patch, some few comments below.

On 8/5/19 23:38, Nick Crews wrote:
> The Wilco Embedded Controller is able to send telemetry data
> which is useful for enterprise applications. A daemon running on
> the OS sends a command to the EC via a write() to a char device,
> and can read the response with a read(). The write() request is
> verified by the driver to ensure that it is performing only one
> of the whitelisted commands, and that no extraneous data is
> being transmitted to the EC. The response is passed directly
> back to the reader with no modification.
> 
> The character device will appear as /dev/wilco_telemN, where N
> is some small non-negative integer, starting with 0. Only one
> process may have the file descriptor open at a time. The calling
> userspace program needs to keep the device file descriptor open
> between the calls to write() and read() in order to preserve the
> response. 32 bytes of data are expected for arguments, and 32
> bytes will be available for reading.
> 
> For testing purposes, try requesting the EC's firmware build
> date, by sending the WILCO_EC_TELEM_GET_VERSION command with
> argument index=3. i.e. write [0x38, 0x00, 0x03, ...(29 more 0s)]
> to the device node. An ASCII string of the build date is
> returned.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
> v3 changes:
> - Change WILCO_EC_CMD_* commands to WILCO_EC_TELEM_* in
>   order to differentiate from the 0xF0 commannds.
> - Use kernel-doc style for wilco_ec_telem_request.
> - Change "GPL v2" to "GPL" in MODULE_LICENSE.
> - Fix formatting in check_args_length().
> v2 changes:
> - Add verification of userspace requests, so that only
>   whitelisted commands and args can get sent to the EC
> - Use EC firmware build date request as example/test
> - Pass the wilco_ec_device to the child driver better,
>   instead of the child driver needing to access the parent
>   devices' data.
> 
>  drivers/platform/chrome/wilco_ec/Kconfig     |   7 +
>  drivers/platform/chrome/wilco_ec/Makefile    |   2 +
>  drivers/platform/chrome/wilco_ec/core.c      |  13 +
>  drivers/platform/chrome/wilco_ec/debugfs.c   |   2 +-
>  drivers/platform/chrome/wilco_ec/telemetry.c | 439 +++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h       |   2 +
>  6 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
> 
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index e09e4cebe9b4..2fc03aa624cf 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -18,3 +18,10 @@ config WILCO_EC_DEBUGFS
>  	  manipulation and allow for testing arbitrary commands.  This
>  	  interface is intended for debug only and will not be present
>  	  on production devices.
> +
> +config WILCO_EC_TELEMETRY
> +	tristate "Enable querying telemetry data from EC"
> +	depends on WILCO_EC
> +	help
> +	  If you say Y here, you get support to query EC telemetry data from
> +	  /dev/wilco_telem0 using write() and then read().
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 29b734137786..5a244da3b6c3 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o properties.o
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
>  wilco_ec_debugfs-objs			:= debugfs.o
>  obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
> +wilco_ec_telem-objs			:= telemetry.o
> +obj-$(CONFIG_WILCO_EC_TELEMETRY)	+= wilco_ec_telem.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index d060d3aa5bae..4cb05d80e5af 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -87,8 +87,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  		goto unregister_debugfs;
>  	}
>  
> +	/* Register child device that will be found by the telemetry driver. */
> +	ec->telem_pdev = platform_device_register_data(dev, "wilco_telem",
> +						       PLATFORM_DEVID_AUTO,
> +						       ec, sizeof(*ec));
> +	if (IS_ERR(ec->telem_pdev)) {
> +		dev_err(dev, "Failed to create telemetry platform device\n");
> +		ret = PTR_ERR(ec->telem_pdev);
> +		goto unregister_rtc;
> +	}
> +
>  	return 0;
>  
> +unregister_rtc:
> +	platform_device_unregister(ec->rtc_pdev);
>  unregister_debugfs:
>  	if (ec->debugfs_pdev)
>  		platform_device_unregister(ec->debugfs_pdev);
> @@ -100,6 +112,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
>  {
>  	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
>  
> +	platform_device_unregister(ec->telem_pdev);
>  	platform_device_unregister(ec->rtc_pdev);
>  	if (ec->debugfs_pdev)
>  		platform_device_unregister(ec->debugfs_pdev);
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index 281ec595e8e0..8d65a1e2f1a3 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -16,7 +16,7 @@
>  
>  #define DRV_NAME "wilco-ec-debugfs"
>  
> -/* The 256 raw bytes will take up more space when represented as a hex string */
> +/* The raw bytes will take up more space when represented as a hex string */
>  #define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE * 4)
>  
>  struct wilco_ec_debugfs {
> diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
> new file mode 100644
> index 000000000000..f9f9e11fea71
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/telemetry.c
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Telemetry communication for Wilco EC
> + *
> + * Copyright 2019 Google LLC
> + *
> + * The Wilco Embedded Controller is able to send telemetry data
> + * which is useful for enterprise applications. A daemon running on
> + * the OS sends a command to the EC via a write() to a char device,
> + * and can read the response with a read(). The write() request is
> + * verified by the driver to ensure that it is performing only one
> + * of the whitelisted commands, and that no extraneous data is
> + * being transmitted to the EC. The response is passed directly
> + * back to the reader with no modification.
> + *
> + * The character device will appear as /dev/wilco_telemN, where N
> + * is some small non-negative integer, starting with 0. Only one
> + * process may have the file descriptor open at a time. The calling
> + * userspace program needs to keep the device file descriptor open
> + * between the calls to write() and read() in order to preserve the
> + * response. 32 bytes of data are expected for arguments, and 32
> + * bytes will be available for reading.
> + *
> + * For testing purposes, try requesting the EC's firmware build
> + * date, by sending the WILCO_EC_TELEM_GET_VERSION command with
> + * argument index=3. i.e. write [0x38, 0x00, 0x03, ...(29 more 0s)]
> + * to the device node. An ASCII string of the build date is
> + * returned.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#define TELEM_DEV_NAME		"wilco_telem"
> +#define TELEM_CLASS_NAME	TELEM_DEV_NAME
> +#define DRV_NAME		TELEM_DEV_NAME
> +#define TELEM_DEV_NAME_FMT	(TELEM_DEV_NAME "%d")
> +static struct class telem_class = {
> +	.owner	= THIS_MODULE,
> +	.name	= TELEM_CLASS_NAME,
> +};
> +
> +/* Keep track of all the device numbers used. */
> +#define TELEM_MAX_DEV 128

Do you expect to have more than one telemetry character device handled by this
driver?

If the answer is no, I think that the driver could be simplified by using a
miscellaneous character device (drivers/char/misc.c) instead.

> +static int telem_major;
> +static DEFINE_IDA(telem_ida);
> +
> +/* EC telemetry command codes */
> +#define WILCO_EC_TELEM_GET_LOG			0x99
> +#define WILCO_EC_TELEM_GET_VERSION		0x38
> +#define WILCO_EC_TELEM_GET_FAN_INFO		0x2E
> +#define WILCO_EC_TELEM_GET_DIAG_INFO		0xFA
> +#define WILCO_EC_TELEM_GET_TEMP_INFO		0x95
> +#define WILCO_EC_TELEM_GET_TEMP_READ		0x2C
> +#define WILCO_EC_TELEM_GET_BATT_EXT_INFO	0x07
> +
> +#define TELEM_ARGS_SIZE_MAX	30
> +
> +/**
> + * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
> + * @command: One of WILCO_EC_TELEM_GET_* command codes.
> + * @reserved: Must be 0.
> + * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
> + */
> +struct wilco_ec_telem_request {
> +	u8 command;
> +	u8 reserved;
> +	u8 args[TELEM_ARGS_SIZE_MAX];
> +} __packed;
> +
> +/*
> + * The following telem_args_get_* structs are embedded within the |args| field
> + * of wilco_ec_telem_request.
> + */
> +
> +struct telem_args_get_log {
> +	u8 log_type;
> +	u8 log_index;
> +} __packed;
> +
> +/*
> + * Get a piece of info about the EC firmware version:
> + * 0 = label
> + * 1 = svn_rev
> + * 2 = model_no
> + * 3 = build_date
> + * 4 = frio_version
> + */
> +struct telem_args_get_version {
> +	u8 index;
> +} __packed;
> +
> +struct telem_args_get_fan_info {
> +	u8 command;
> +	u8 fan_number;
> +	u8 arg;
> +} __packed;
> +
> +struct telem_args_get_diag_info {
> +	u8 type;
> +} __packed;
> +
> +struct telem_args_get_temp_info {
> +	u8 command;
> +	u8 index;
> +	u8 field;
> +	u8 zone;
> +} __packed;
> +
> +struct telem_args_get_temp_read {
> +	u8 sensor_index;
> +} __packed;
> +
> +struct telem_args_get_batt_ext_info {
> +	u8 var_args[5];
> +} __packed;
> +
> +static const char TELEM_ARGS_ZERO[TELEM_ARGS_SIZE_MAX] = {0};
> +
> +/**
> + * check_args_length() - Ensure that un-needed argument bytes are 0.
> + * @rq:	Request to be validated.
> + * @arg_size: Number of bytes of rq->args that are allowed to be non-zero.
> + */
> +static int check_args_length(struct wilco_ec_telem_request *rq, size_t arg_size)
> +{
> +	if (memcmp(rq->args + arg_size, TELEM_ARGS_ZERO,
> +		   TELEM_ARGS_SIZE_MAX - arg_size) != 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * We do not want to allow userspace to send arbitrary telemetry commands to
> + * the EC. Therefore we check to ensure that
> + * 1. The request follows the format of struct wilco_ec_telem_request.
> + * 2. The supplied command code is one of the whitelisted commands.
> + * 3. The arguments only contain the necessary data. Each command takes a
> + *    different format of arguments, and only these arguments can be non-zero.
> + *    For instance, if the request uses command WILCO_EC_TELEM_GET_LOG, then
> + *    the command uses the argument format of telem_args_get_log, which
> + *    contains 2 bytes of arguments. Thus, everything in the args besides
> + *    these two bytes had better be zero.
> + */
> +static int check_telem_request(struct wilco_ec_telem_request *rq)
> +{
> +	if (rq->reserved)
> +		return -EINVAL;
> +
> +	switch (rq->command) {
> +	case WILCO_EC_TELEM_GET_LOG:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_log));
> +	case WILCO_EC_TELEM_GET_VERSION:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_version));
> +	case WILCO_EC_TELEM_GET_FAN_INFO:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_fan_info));
> +	case WILCO_EC_TELEM_GET_DIAG_INFO:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_diag_info));
> +	case WILCO_EC_TELEM_GET_TEMP_INFO:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_temp_info));
> +	case WILCO_EC_TELEM_GET_TEMP_READ:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_temp_read));
> +	case WILCO_EC_TELEM_GET_BATT_EXT_INFO:
> +		return check_args_length(rq,
> +				sizeof(struct telem_args_get_batt_ext_info));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * struct telem_device_data - Data for a Wilco EC device that queries telemetry.
> + * @cdev: Char dev that userspace reads and polls from.
> + * @dev: Device associated with the %cdev.
> + * @ec: Wilco EC that we will be communicating with using the mailbox interface.
> + * @available: Boolean of if the device can be opened.
> + */
> +struct telem_device_data {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct wilco_ec_device *ec;
> +	atomic_t available;
> +};
> +
> +#define TELEM_RESPONSE_SIZE	EC_MAILBOX_DATA_SIZE
> +
> +/**
> + * struct telem_session_data - Data that exists between open() and release().
> + * @dev_data: Pointer to get back to the device data and EC.
> + * @request: Command and arguments sent to EC.
> + * @response: Response buffer of data from EC.
> + * @has_msg: Is there data available to read from a previous write?
> + */
> +struct telem_session_data {
> +	struct telem_device_data *dev_data;
> +	struct wilco_ec_telem_request request;
> +	u8 response[TELEM_RESPONSE_SIZE];
> +	bool has_msg;
> +};
> +
> +/**
> + * telem_open() - Callback for when the device node is opened.
> + * @inode: inode for this char device node.
> + * @filp: file for this char device node.
> + *
> + * We need to ensure that after writing a command to the device,
> + * the same userspace process reads the corresponding result.
> + * Therefore, we increment a refcount on opening the device, so that
> + * only one process can communicate with the EC at a time.
> + *
> + * Return: 0 on success, or negative error code on failure.
> + */
> +static int telem_open(struct inode *inode, struct file *filp)
> +{
> +	struct telem_device_data *dev_data;
> +	struct telem_session_data *sess_data;
> +
> +	/* Ensure device isn't already open */
> +	dev_data = container_of(inode->i_cdev, struct telem_device_data, cdev);
> +	if (atomic_cmpxchg(&dev_data->available, 1, 0) == 0)
> +		return -EBUSY;
> +
> +	sess_data = kzalloc(sizeof(*sess_data), GFP_KERNEL);
> +	if (!sess_data) {
> +		atomic_set(&dev_data->available, 1);
> +		return -ENOMEM;
> +	}
> +	sess_data->dev_data = dev_data;
> +	sess_data->has_msg = false;
> +
> +	nonseekable_open(inode, filp);
> +	filp->private_data = sess_data;
> +
> +	return 0;
> +}
> +
> +static ssize_t telem_write(struct file *filp, const char __user *buf,
> +			   size_t count, loff_t *pos)
> +{
> +	struct telem_session_data *sess_data = filp->private_data;
> +	struct wilco_ec_message msg = {};
> +	int ret;
> +
> +	if (count != sizeof(sess_data->request))
> +		return -EINVAL;
> +	if (copy_from_user(&sess_data->request, buf, count))
> +		return -EFAULT;
> +	ret = check_telem_request(&sess_data->request);
> +	if (ret < 0)
> +		return ret;
> +
> +	msg.type = WILCO_EC_MSG_TELEMETRY;
> +	msg.request_data = &sess_data->request;
> +	msg.request_size = sizeof(sess_data->request);
> +	msg.response_data = sess_data->response;
> +	msg.response_size = sizeof(sess_data->response);
> +
> +	ret = wilco_ec_mailbox(sess_data->dev_data->ec, &msg);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(sess_data->response))
> +		return -EMSGSIZE;
> +
> +	sess_data->has_msg = true;
> +
> +	return count;
> +}
> +
> +static ssize_t telem_read(struct file *filp, char __user *buf, size_t count,
> +			  loff_t *pos)
> +{
> +	struct telem_session_data *sess_data = filp->private_data;
> +
> +	if (!sess_data->has_msg)
> +		return -ENODATA;
> +	if (count > sizeof(sess_data->response))
> +		return -EINVAL;
> +
> +	if (copy_to_user(buf, sess_data->response, count))
> +		return -EFAULT;
> +
> +	sess_data->has_msg = false;
> +
> +	return count;
> +}
> +
> +static int telem_release(struct inode *inode, struct file *filp)
> +{
> +	struct telem_session_data *sess_data = filp->private_data;
> +
> +	atomic_set(&sess_data->dev_data->available, 1);
> +	kfree(sess_data);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations telem_fops = {
> +	.open = telem_open,
> +	.write = telem_write,
> +	.read = telem_read,
> +	.release = telem_release,
> +	.llseek = no_llseek,
> +	.owner = THIS_MODULE,
> +};
> +
> +/**
> + * telem_device_probe() - Callback when creating a new device.
> + * @pdev: platform device that we will be receiving telems from.
> + *
> + * This finds a free minor number for the device, allocates and initializes
> + * some device data, and creates a new device and char dev node.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int telem_device_probe(struct platform_device *pdev)
> +{
> +	struct telem_device_data *dev_data;
> +	dev_t dev_num;
> +	int error, minor;
> +
> +	/* Get the next available device number */
> +	minor = ida_alloc_max(&telem_ida, TELEM_MAX_DEV-1, GFP_KERNEL);
> +	if (minor < 0) {
> +		error = minor;
> +		dev_err(&pdev->dev, "Failed to find minor number: %d", error);
> +		return error;
> +	}
> +
> +	dev_data = devm_kzalloc(&pdev->dev, sizeof(*dev_data), GFP_KERNEL);
> +	if (!dev_data) {
> +		ida_simple_remove(&telem_ida, minor);
> +		return -ENOMEM;
> +	}

You can move that to the top and you will get rid of the ida_simple_remove call.

I'm not sure is right use devm_kzalloc here. I think that you should allocate
the data here via kzalloc and free in class release callback. See
Documentation/kobject.txt

> +
> +	/* Initialize the device data */
> +	dev_data->ec = dev_get_platdata(&pdev->dev);
> +	atomic_set(&dev_data->available, 1);
> +	platform_set_drvdata(pdev, dev_data);
> +
> +	/* Initialize the device */
> +	dev_num = MKDEV(telem_major, minor);
> +	dev_data->dev.devt = dev_num;

dev_num is only used here, you can remove the local variable and do

dev_data.devt = MKDEV(telem_major, minor);

> +	dev_data->dev.class = &telem_class;
> +	dev_set_name(&dev_data->dev, TELEM_DEV_NAME_FMT, minor);
> +	device_initialize(&dev_data->dev);
> +
> +	/* Initialize the character device and add it to userspace */;
> +	cdev_init(&dev_data->cdev, &telem_fops);
> +	error = cdev_device_add(&dev_data->cdev, &dev_data->dev);
> +	if (error) {

I think that you should call

	put_device(&dev_data->dev);

to release the reference from device_initialize()?


> +		ida_simple_remove(&telem_ida, minor);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int telem_device_remove(struct platform_device *pdev)
> +{
> +	struct telem_device_data *dev_data = platform_get_drvdata(pdev);
> +
> +	cdev_device_del(&dev_data->cdev, &dev_data->dev);

Same here, put_device(&dev_data->dev);?

> +	ida_simple_remove(&telem_ida, MINOR(dev_data->dev.devt));
> +
> +	return 0;
> +}
> +
> +static struct platform_driver telem_driver = {
> +	.probe = telem_device_probe,
> +	.remove = telem_device_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +};
> +
> +static int __init telem_module_init(void)
> +{
> +	dev_t dev_num = 0;
> +	int ret;
> +
> +	ret = class_register(&telem_class);
> +	if (ret) {
> +		pr_warn(DRV_NAME ": Failed registering class: %d", ret);

pr_err?

> +		return ret;
> +	}
> +
> +	/* Request the kernel for device numbers, starting with minor=0 */
> +	ret = alloc_chrdev_region(&dev_num, 0, TELEM_MAX_DEV, TELEM_DEV_NAME);
> +	if (ret) {
> +		pr_warn(DRV_NAME ": Failed allocating dev numbers: %d", ret);

pr_err?

> +		goto destroy_class;
> +	}
> +	telem_major = MAJOR(dev_num);
> +
> +	ret = platform_driver_register(&telem_driver);
> +	if (ret < 0) {
> +		pr_warn(DRV_NAME ": Failed registering driver: %d\n", ret);

pr_err?

> +		goto unregister_region;
> +	}
> +
> +	return 0;
> +
> +unregister_region:
> +	unregister_chrdev_region(MKDEV(telem_major, 0), TELEM_MAX_DEV);
> +destroy_class:
> +	class_unregister(&telem_class);
> +	ida_destroy(&telem_ida);
> +	return ret;
> +}
> +
> +static void __exit telem_module_exit(void)
> +{
> +	platform_driver_unregister(&telem_driver);
> +	unregister_chrdev_region(MKDEV(telem_major, 0), TELEM_MAX_DEV);
> +	class_unregister(&telem_class);
> +	ida_destroy(&telem_ida);
> +}
> +
> +module_init(telem_module_init);
> +module_exit(telem_module_exit);
> +
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_DESCRIPTION("Wilco EC telemetry driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 33f137078737..67cceb7ba577 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -29,6 +29,7 @@
>   * @data_size: Size of the data buffer used for EC communication.
>   * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
>   * @rtc_pdev: The child platform_device used by the RTC sub-driver.
> + * @telem_pdev: The child platform_device used by the telemetry sub-driver.
>   */
>  struct wilco_ec_device {
>  	struct device *dev;
> @@ -40,6 +41,7 @@ struct wilco_ec_device {
>  	size_t data_size;
>  	struct platform_device *debugfs_pdev;
>  	struct platform_device *rtc_pdev;
> +	struct platform_device *telem_pdev;
>  };
>  
>  /**
> 
