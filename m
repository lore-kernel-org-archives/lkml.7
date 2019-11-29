Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093C7C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD71A21721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVqCrB/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK2SQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:16:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfK2SQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:16:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so19436088otd.9;
        Fri, 29 Nov 2019 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4xdyO3pbcjV7VFnEpdpI0eB5xd2aaOViAmddhCr718=;
        b=qVqCrB/NvIAkVnXmiZv6toj/plOAU3xcgXsaNRck03Neip+Xo+z3vb1VtvIiJYpYl4
         /H9cf1zpYUVGfLhxbcpJ+O3le/fnWQJOhLuWA13Oyp4+L7Tm1ZXTspg1QGH63wCnwwQH
         6zXvNmQdUr2Jr3CIYoJ9nUUIRFGNcqklGkUrSa2Iz5WfU64k3RxglXCenQlyduE7oRXD
         BXg3yoF8rLY/H+pRCtSc+EuDLwPp5/pPXahkDDtRYBCqrPSnEZxzf/9OMZaMekAwnRit
         ia5qeSlHdw/WSN0/M4As5Bs+/tDd99Bv2HVBtCRA4Kt4GQDlvl0eJtzfzDfqUe/jFsun
         2fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4xdyO3pbcjV7VFnEpdpI0eB5xd2aaOViAmddhCr718=;
        b=OLcALX7KatnWMLmzEXdrV+t/auC0uLMTaPCRDg9yjG+c41cJpERie8Ucj38tZkUNzT
         JMX7W/8UNpjYNEmvYziRwkJIFRbiQWyIdcawDxwG3OvJvpKRo/s0ETESZhCJZPD3CUf5
         pphH88lnV8T2mGq+Uv1kcFf8v9AFRzCJpp8CQZgO9/DCtIAOvn8QUb4C1ba70ALaLMul
         Keaf05046ufxqf2y6FC6oynkqGY9M0v6qy9bVWjcW9HkHlqQ9fmE1cyP35hoZEAI8Oz6
         ARxFmaL/c8wrsCZi4UU95KSYxCIBVMcvdMtBFEfjy6rJAcWh6wh4Pbko0SSt4k+fK/4x
         x2LQ==
X-Gm-Message-State: APjAAAUEYGq5QeHtNjdUFwCgV7Jc+ciiEuJM8uq8JBJGf4wjQetwZOt/
        oy+2bicUUXcSiAX+McGjNmg=
X-Google-Smtp-Source: APXvYqxbgJui5nzV2IrxEm8sjBHlPUE1XdAYEN6NBbbf2zSzqSOOoWfLftMFiVNUKkRG0lKRqkS9bg==
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr2628854otq.17.1575051404246;
        Fri, 29 Nov 2019 10:16:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l73sm3959987oib.0.2019.11.29.10.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Nov 2019 10:16:43 -0800 (PST)
Date:   Fri, 29 Nov 2019 10:16:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Pai <Ben_Pai@wistron.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, corbet@lwn.net, wangat@tw.ibm.com,
        Andy_YF_Wang@wistron.com, Claire_Ku@wistron.com
Subject: Re: [ v1] hwmon: (pmbus) Add Wistron power supply pmbus driver
Message-ID: <20191129181642.GA4062@roeck-us.net>
References: <20191129060230.14522-1-Ben_Pai@wistron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129060230.14522-1-Ben_Pai@wistron.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 02:02:30PM +0800, Ben Pai wrote:
> Add the driver to monitor Wisreon power supplies with hwmon over pmbus.

Wistron ?

> 
> Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
> ---
>  drivers/hwmon/pmbus/Kconfig       |   9 ++
>  drivers/hwmon/pmbus/Makefile      |   1 +
>  drivers/hwmon/pmbus/wistron-wps.c | 180 ++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/wistron-wps.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index d62d69bb7e49..ebb7024e58ab 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -219,6 +219,15 @@ config SENSORS_UCD9200
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ucd9200.
>  
> +config SENSORS_WISTRON_WPS
> +	tristate "Wistron Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the Wistron
> +	  power supply.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called wistron-wps.
> +
>  config SENSORS_ZL6100
>  	tristate "Intersil ZL6100 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 03bacfcfd660..cad38f99e8c5 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
> +obj-$(CONFIG_SENSORS_WISTRON_WPS) += wistron-wps.o
>  obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> diff --git a/drivers/hwmon/pmbus/wistron-wps.c b/drivers/hwmon/pmbus/wistron-wps.c
> new file mode 100644
> index 000000000000..764496aa9d4f
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/wistron-wps.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2019 Wistron Corp.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/jiffies.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pmbus.h>
> +
> +#include "pmbus.h"
> +
> +#define WPS_ID_CMD				0x99
> +#define WPS_PN_CMD				0x9A
> +#define WPS_FW_CMD				0x9B
> +#define WPS_DATE_CMD				0x9D
> +#define WPS_SN_CMD				0x9E
> +
> +enum {
> +	WPS_DEBUGFS_ID,
> +	WPS_DEBUGFS_PN,
> +	WPS_DEBUGFS_SN,
> +	WPS_DEBUGFS_FW,
> +	WPS_DEBUGFS_DATE,
> +	WPS_DEBUGFS_NUM_ENTRIES
> +};
> +
> +struct wistron_wps {
> +
> +	struct i2c_client *client;
> +
> +	int debugfs_entries[WPS_DEBUGFS_NUM_ENTRIES];
> +
> +};
> +
> +#define to_psu(x, y) container_of((x), struct wistron_wps, debugfs_entries[(y)])

container_of() doesn't really need the extra ().

> +
> +static ssize_t wistron_wps_debugfs_op(struct file *file, char __user *buf,
> +				    size_t count, loff_t *ppos)

Please align continuation lines with '('.

> +{
> +	u8 cmd;
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct wistron_wps *psu = to_psu(idxp, idx);
> +	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +
> +	switch (idx) {
> +	case WPS_DEBUGFS_ID:
> +		cmd = WPS_ID_CMD;
> +		break;
> +	case WPS_DEBUGFS_PN:
> +		cmd = WPS_PN_CMD;
> +		break;
> +	case WPS_DEBUGFS_SN:
> +		cmd = WPS_SN_CMD;
> +		break;
> +	case WPS_DEBUGFS_FW:
> +		cmd = WPS_FW_CMD;
> +		break;
> +	case WPS_DEBUGFS_DATE:
> +		cmd = WPS_DATE_CMD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
> +	if (rc < 0)
> +		return rc;
> +
> +done:
> +	data[rc] = '\n';

The block command can return up to 32 bytes. If it does, the above code
writes beyond the end of the buffer.

> +	rc += 2;

Why += 2 ? This will report the trailing '\0' to userspace (and require
an even larger buffer). Is that intentional ?

> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static const struct file_operations wistron_wps_fops = {
> +	.llseek = noop_llseek,
> +	.read = wistron_wps_debugfs_op,
> +	.open = simple_open,
> +};
> +
> +static struct pmbus_driver_info wistron_wps_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12 |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static struct pmbus_platform_data wistron_wps_pdata = {
> +	.flags = PMBUS_SKIP_STATUS_CHECK,

This should be explained if it is indeed needed.

> +};
> +
> +static int wistron_wps_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)

Please match ( in continuation lines.

> +{
> +	int i, rc;
> +	struct dentry *debugfs;
> +	struct dentry *wistron_wps_dir;
> +	struct wistron_wps *psu;
> +
> +	client->dev.platform_data = &wistron_wps_pdata;
> +	rc = pmbus_do_probe(client, id, &wistron_wps_info);
> +	if (rc)
> +		return rc;
> +
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;
> +
> +	psu->client = client;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +
> +	wistron_wps_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!wistron_wps_dir)
> +		return 0;
> +
> +	for (i = 0; i < WPS_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("fru", 0444, wistron_wps_dir,
> +			    &psu->debugfs_entries[WPS_DEBUGFS_ID],
> +			    &wistron_wps_fops);
> +	debugfs_create_file("part_number", 0444, wistron_wps_dir,
> +			    &psu->debugfs_entries[WPS_DEBUGFS_PN],
> +			    &wistron_wps_fops);
> +	debugfs_create_file("serial_number", 0444, wistron_wps_dir,
> +			    &psu->debugfs_entries[WPS_DEBUGFS_SN],
> +			    &wistron_wps_fops);
> +	debugfs_create_file("fw_version", 0444, wistron_wps_dir,
> +			    &psu->debugfs_entries[WPS_DEBUGFS_FW],
> +			    &wistron_wps_fops);
> +	debugfs_create_file("mfr_date", 0444, wistron_wps_dir,
> +			    &psu->debugfs_entries[WPS_DEBUGFS_DATE],
> +			    &wistron_wps_fops);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id wistron_wps_id[] = {
> +	{ "wistron_wps", 1 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, wistron_wps_id);
> +
> +static const struct of_device_id wistron_wps_of_match[] = {
> +	{ .compatible = "wistron,wps" },

This will need to be documented. It is also probably not the best name
for a devicetree property (what is "wps" ?), but that will be up to
a DT maintainer to decide.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, wistron_wps_of_match);
> +
> +static struct i2c_driver wistron_wps_driver = {
> +	.driver = {
> +		.name = "wistron-wps",
> +		.of_match_table = wistron_wps_of_match,
> +	},
> +	.probe = wistron_wps_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = wistron_wps_id,
> +};
> +
> +module_i2c_driver(wistron_wps_driver);
> +
> +MODULE_AUTHOR("Ben Pai");
> +MODULE_DESCRIPTION("PMBus driver for Wistron power supplies");
> +MODULE_LICENSE("GPL");
