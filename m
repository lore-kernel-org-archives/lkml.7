Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D6C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFB021743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQH6cNwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfHHOF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:05:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35095 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:05:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so44188768pfn.2;
        Thu, 08 Aug 2019 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHMBnctDRnXDSO29XMMETuXMrq1SVqcW4ppEF+Xo3DY=;
        b=WQH6cNwneZrR6sezbxY6d8CNWaF6yKtm+E5dqPZekRgugPs6kC5F91/jYs+moXcErs
         eHomMUxbZUpVRlW1RaS+i05AqG+c/pvG4TKDeNFotJWP6C7+wnyDZlOapY5JV/ImFdDm
         /4ymio93HID2HqkFvxHQa7KBaYVgruzfGtrK9ftY0Wp/zZlMW2MVV+DtK13OpUc0EBkh
         RR/pno6E4MHzoIQW6gSopV1Ta8gjbetDH5gD3avjwocFjXRdU8csbW4sQb2WfcOL7aAK
         H6EBGKZGeZSOZfcrMv75/FFt1DUjksiE39WTsVrfNKNW8iUJQxMrEEFlc0HIUySEvclC
         Cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHMBnctDRnXDSO29XMMETuXMrq1SVqcW4ppEF+Xo3DY=;
        b=ojAWdM6MyM0x/f/t2oFhnBNtkxpLxqOzu83C15tyMfLzI92hMFgIO+bOSlgcPD8pMp
         02b4hAGSSLqILCdtrNVpSxeYnl8kGgx/wxA3KELoLi9XG/nH2GJiuPNN8o7FprC29OTo
         2tQF71G0bZOPUJB0Vs5bpudPSyx0WMIUT5jz8E8gTgg/YiTfmVa/cnpfYVla95KUWzae
         VC22cIJ6CB8oKnxPzfl0OnDanheuN4PSwiMiI1E7gOiuDoV0RU5MKsclSd68401LK6D4
         vijnBymztXi8ad9AQHP2woN3eTX9mNT4up+ea/XqsU2YxkNwN/vg/uBwxp5zCeKvZLCA
         cudg==
X-Gm-Message-State: APjAAAWn6GVX5cP+ytvxym0BkbWZ9raECkCZE40Kb/QFeCgw0iH8gag/
        kKwhejdxJVeY4iH8lLMiVu4=
X-Google-Smtp-Source: APXvYqwY+kNV6cXUvrPO6lvrRUn22QvOvjuQW+w4HDQwlaJHbddjvA+Fg484IkdzB7MpE75a425qjw==
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr4290499pjs.73.1565273128155;
        Thu, 08 Aug 2019 07:05:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 33sm107236041pgy.22.2019.08.08.07.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:05:27 -0700 (PDT)
Date:   Thu, 8 Aug 2019 07:05:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Wang <wangzqbj@inspur.com>
Cc:     mine260309@gmail.com, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, openbmc@lists.ozlabs.org,
        duanzhijia01@inspur.com
Subject: Re: [PATCH] hwmon: pmbus: Add Inspur Power System power supply driver
Message-ID: <20190808140525.GA30738@roeck-us.net>
References: <20190808073636.18611-1-wangzqbj@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808073636.18611-1-wangzqbj@inspur.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:36:36PM +0800, John Wang wrote:
> Add the driver to monitor Inspur Power System power supplies
> with hwmon over pmbus.
> 
> This driver adds debugfs entries for addintional power supply data,

s/addintional/additional/

> including vendor,model,part_number,serial number,firmware revision,
> hardware revision,and psu mode(active/standby).

Spaces after "'", please.

> 

Please run checkpatch --strict and fix what it reports.
Mostly multi-line alignment, but also stray empty lines
and missing spaces.

> Signed-off-by: John Wang <wangzqbj@inspur.com>
> ---
>  drivers/hwmon/pmbus/Kconfig        |   9 +
>  drivers/hwmon/pmbus/Makefile       |   1 +
>  drivers/hwmon/pmbus/inspur-ipsps.c | 291 +++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/inspur-ipsps.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 30751eb9550a..c09357c26b10 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -203,4 +203,13 @@ config SENSORS_ZL6100
>  	  This driver can also be built as a module. If so, the module will
>  	  be called zl6100.
>  
> +config SENSORS_INSPUR_IPSPS
> +	tristate "INSPUR Power System Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the INSPUR
> +	  Power System power supply.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called inspur-ipsps.
> +
>  endif # PMBUS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 2219b9300316..fde2d10cd05c 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>  obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> +obj-$(CONFIG_SENSORS_INSPUR_IPSPS)	+= inspur-ipsps.o
> diff --git a/drivers/hwmon/pmbus/inspur-ipsps.c b/drivers/hwmon/pmbus/inspur-ipsps.c
> new file mode 100644
> index 000000000000..7dc2b00cb192
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/inspur-ipsps.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2019 Inspur Corp.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +
> +#include "pmbus.h"
> +
> +#define IPSPS_VENDOR_ID		0x99
> +#define IPSPS_MODEL		0x9A
> +#define IPSPS_FW_VERSION	0x9B
> +#define IPSPS_PN		0x9C
> +#define IPSPS_SN		0x9E
> +#define IPSPS_HW_VERSION	0xB0
> +#define IPSPS_MODE		0xFC
> +
> +#define MODE_ACTIVE		0x55
> +#define MODE_STANDBY		0x0E
> +#define MODE_REDUNDANCY		0x00
> +
> +#define MODE_ACTIVE_STRING		"active"
> +#define MODE_STANDBY_STRING		"standby"
> +#define MODE_REDUNDANCY_STRING		"redundancy"
> +
> +struct ipsps_attr {
> +	u8 reg;
> +	umode_t mode;
> +	const char *name;
> +	int mask;
> +	const struct file_operations *fops;
> +};
> +
> +struct ipsps_entry {
> +	struct i2c_client *client;
> +	u8 reg;
> +};
> +
> +static ssize_t ipsps_string_read(struct file *file, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct ipsps_entry *entry = file->private_data;
> +	char data[I2C_SMBUS_BLOCK_MAX + 1] = { 0 };
> +	int i, rc;
> +
> +	rc = i2c_smbus_read_block_data(entry->client, entry->reg, data);
> +	if (rc <= 0)
> +		return rc;

With this, an read size of 0 returns nothing (no newline)
and no error. Anything else returns a string with newline.
Is that intentional ?

> +
> +	for (i = 0; i < rc; i++) {
> +		if (data[i] == '#')
> +			break;

What if there is a '\0' in the buffer ?

> +	}
> +
> +	data[i] = '\n';
> +	i++;

	data[i++] = '\n';

> +	data[i] = '\0';
> +	i++;

	data[i++] = '0';

i2c_smbus_read_block_data() can return up to 32 bytes of data.
If it does, and the code does not include a '#', the above writes
after the end of the bufer.

> +
> +	return simple_read_from_buffer(buf, count, ppos, data, i);
> +
> +}
> +
> +static ssize_t ipsps_fw_version_read(struct file *file, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +	int rc;
> +	struct ipsps_entry *entry = file->private_data;
> +
> +	rc = i2c_smbus_read_block_data(entry->client, entry->reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != 6)
> +		return -ENODATA;

That seems inappropriate. There is data, after all, only it is unexpected.
-EPROTO, maybe.

> +
> +	rc = snprintf(data, sizeof(data), "%d.%02d.%02d\n",
> +			data[1], data[2], data[3]);

This will be reported as negative numbers if values are larger than 127.
Is this intentional ?

> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static ssize_t ipsps_mode_read(struct file *file,
> +					    char __user *buf, size_t count,
> +					    loff_t *ppos)
> +{
> +	int rc;
> +	char data[64] = { 0 };
> +	struct ipsps_entry *entry = file->private_data;

Please use reverse chrismas tree declarations where possible.

> +
> +	rc = i2c_smbus_read_byte_data(entry->client, entry->reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	switch (rc) {
> +	case MODE_ACTIVE:
> +		rc = snprintf(data, sizeof(data), "[%s] %s %s\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		break;
> +	case MODE_STANDBY:
> +		rc = snprintf(data, sizeof(data), "%s [%s] %s\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		break;
> +	case MODE_REDUNDANCY:
> +		rc = snprintf(data, sizeof(data), "%s %s [%s]\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		break;
> +	default:
> +		rc = snprintf(data, sizeof(data), "unspecified\n");
> +		break;
> +	}
> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static ssize_t ipsps_mode_write(struct file *file, const char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	char data[64] = { 0 };
> +	struct ipsps_entry *entry = file->private_data;
> +
> +	rc = simple_write_to_buffer(data, sizeof(data), ppos, buf, count);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (strcmp(MODE_STANDBY_STRING, data) == 0 ||
> +			strcmp(MODE_STANDBY_STRING"\n", data) == 0) {

Any reason for not using sysfs_streq() ?

> +		rc = i2c_smbus_write_byte_data(entry->client, entry->reg,
> +						MODE_STANDBY);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	} else if (strcmp(MODE_ACTIVE_STRING, data) == 0 ||
> +			strcmp(MODE_ACTIVE_STRING"\n", data) == 0) {
> +		rc = i2c_smbus_write_byte_data(entry->client, entry->reg,
> +						MODE_ACTIVE);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	}

So one can only set active and standby, but not "redundancy".
If that is intentional, it might make sense to document it somewhere.

Also, it is kind of unusual to configure a device with a debugfs entry.
Are you sure this is what you want, and not a sysfs attribute ?

> +
> +	return -EINVAL;
> +}
> +
> +static const struct file_operations ipsps_string_fops = {
> +	.llseek = noop_llseek,
> +	.open = simple_open,
> +	.read = ipsps_string_read,
> +};
> +
> +static const struct file_operations ipsps_fw_version_fops = {
> +	.llseek = noop_llseek,
> +	.open = simple_open,
> +	.read = ipsps_fw_version_read,
> +};
> +
> +static const struct file_operations ipsps_mode_fops = {
> +	.llseek = noop_llseek,
> +	.open = simple_open,
> +	.read = ipsps_mode_read,
> +	.write = ipsps_mode_write,
> +};
> +
> +struct ipsps_attr ipsps_attrs[] = {
> +	{
> +		.name = "vendor",
> +		.fops = &ipsps_string_fops,
> +		.reg = IPSPS_VENDOR_ID,
> +		.mode = 0444,
> +	}, {
> +		.name = "model",
> +		.fops = &ipsps_string_fops,
> +		.reg = IPSPS_MODEL,
> +		.mode = 0444,
> +	}, {
> +		.name = "fw_version",
> +		.fops = &ipsps_fw_version_fops,
> +		.reg = IPSPS_FW_VERSION,
> +		.mode = 0444,
> +	}, {
> +		.name = "part_number",
> +		.fops = &ipsps_string_fops,
> +		.reg = IPSPS_PN,
> +		.mode = 0444,
> +	}, {
> +		.name = "serial_number",
> +		.fops = &ipsps_string_fops,
> +		.reg = IPSPS_SN,
> +		.mode = 0444,
> +	}, {
> +		.name = "hw_version",
> +		.fops = &ipsps_string_fops,
> +		.reg = IPSPS_HW_VERSION,
> +		.mode = 0444,
> +	}, {
> +		.name = "mode",
> +		.fops = &ipsps_mode_fops,
> +		.reg = IPSPS_MODE,
> +		.mode = 0644,
> +	}
> +
> +};
> +
> +static struct pmbus_driver_info ipsps_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static struct pmbus_platform_data ipsps_pdata = {
> +	.flags = PMBUS_SKIP_STATUS_CHECK,
> +};
> +
> +static int ipsps_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	int i, rc;
> +	struct dentry *debugfs;
> +	struct dentry *ipsps_dir;
> +	struct ipsps_entry *entry;
> +
> +	client->dev.platform_data = &ipsps_pdata;
> +	rc = pmbus_do_probe(client, id, &ipsps_info);
> +	if (rc)
> +		return rc;
> +
> +	/* Don't fail the probe if we can't create debugfs */
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +
> +	ipsps_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!ipsps_dir)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(ipsps_attrs); ++i) {
> +		entry = devm_kzalloc(&client->dev, sizeof(*entry), GFP_KERNEL);
> +		if (!entry)
> +			return 0;
> +
> +		entry->client = client;
> +		entry->reg = ipsps_attrs[i].reg;
> +		debugfs_create_file(ipsps_attrs[i].name, ipsps_attrs[i].mode,
> +					ipsps_dir, entry, ipsps_attrs[i].fops);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ipsps_id[] = {
> +	{ "inspur_ipsps1", 1 },

What is the "1" for ? It isn't used, so 0 might be more appropriate.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ipsps_id);
> +
> +static const struct of_device_id ipsps_of_match[] = {
> +	{ .compatible = "inspur,ipsps1" },

Please make sure this is documented in
./Documentation/devicetree/bindings/trivial-devices.yaml.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ipsps_of_match);
> +
> +static struct i2c_driver ipsps_driver = {
> +	.driver = {
> +		.name = "inspur-ipsps",
> +		.of_match_table = ipsps_of_match,
> +	},
> +	.probe = ipsps_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = ipsps_id,
> +};
> +
> +module_i2c_driver(ipsps_driver);
> +
> +MODULE_AUTHOR("John Wang");
> +MODULE_DESCRIPTION("PMBus driver for Inspur Power System power supplies");
> +MODULE_LICENSE("GPL");
