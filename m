Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68924C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371E620726
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+KEu5XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfLHPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:34:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41608 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfLHPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 10:34:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so5862794pfd.8;
        Sun, 08 Dec 2019 07:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWlLeHIge3OBYOfyrY2v05dlJphm/PnsbiA9JnrdXsI=;
        b=S+KEu5XQP5xk7EPHClV43g+Y3gQLvtfuvQwK4ERXWcY28uBDVmnIQoyISbwxjwpvX/
         7xCh9v4WvQ74t9M/kspCUGWN9mar4Qf7s+lQzFmV7bBUxp7TeFriKO/pmg956AE0f07i
         m0Q9URLMAf/ihBcFWLvEkz16B1Rkv/J4L1AdwwoSeV+0hqndXJGmVGTkRvsAaaXdjXrA
         JZmYU4RMMcDAiOLYIvTdV4sLGcuvJBhC9xYgzNv6hQGZ2toHqbS85t6gyGtaVZlOuXWW
         +x1Cjw3Wo8PvDP+VAhW8EQXYaNRLDxL4hPgsEjQ1tzw/r6MXm9Aji5PffNIQScUGrAQV
         fJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWlLeHIge3OBYOfyrY2v05dlJphm/PnsbiA9JnrdXsI=;
        b=hk9u84jbUTCam6tOfq4/W/dOoI/R5J0eWxWMzNnnVZuNPx1S0zMrTqLhVH7ryifDfk
         q8XvEL4pNENp2lPJIkClFYDLlZQwUdA8VJazYrk/RDHnf9oZp9ADuxJdCasFMbCpS5je
         XpACDrfAdRUNgzSpFLWJEJXr783PP0kMiaMJ2kMjggefQDG18rRGysMzE7b3+N+tRE/j
         BUl0nsSzvU6f+6JAXr3e4bZn/r/4bOhw9lzi3FkdiPTai2aGq2VZ8qh7N3LGzBhMNKOp
         LUibqdfHAoU0NTK5nLlQ++dVWJVxBqTKQagoyjzDz/X89CB4fhtMsTIFv4j6Lzny5Q8K
         ZYhg==
X-Gm-Message-State: APjAAAWlzVIHdsnEdBw8yeeMM0Db7W5KhrmLw6m0K038TAEWnnm8utTj
        GZy5GRkhDQK6w0sk+sWpsRk=
X-Google-Smtp-Source: APXvYqxTJjoGa9/Q89qY2qHufxzmgf+UGiipw98tPxBFm35+YnnbbPmXPcxozUAUjbV8Pd1O+w2FSA==
X-Received: by 2002:a63:e0c:: with SMTP id d12mr13699925pgl.3.1575819243819;
        Sun, 08 Dec 2019 07:34:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm24417102pfm.150.2019.12.08.07.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 07:34:03 -0800 (PST)
Subject: Re: [ v2] hwmon: (pmbus) Add Wistron power supply pmbus driver
To:     Ben Pai <Ben_Pai@wistron.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, corbet@lwn.net, wangat@tw.ibm.com,
        Andy_YF_Wang@wistron.com, Claire_Ku@wistron.com
References: <20191208134438.12925-1-Ben_Pai@wistron.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <21b2b959-3a3e-6cd4-44f9-1ea9edf77817@roeck-us.net>
Date:   Sun, 8 Dec 2019 07:34:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191208134438.12925-1-Ben_Pai@wistron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/19 5:44 AM, Ben Pai wrote:
> Add the driver to monitor Wisreon power supplies with hwmon over pmbus.
> 
s/Wisreon/Winston/, as per my comments to v1.

> Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
> ---

Change log goes here.

>   .../devicetree/bindings/hwmon/wistron-wps.txt |  30 +++
>   drivers/hwmon/pmbus/Kconfig                   |   9 +
>   drivers/hwmon/pmbus/Makefile                  |   1 +
>   drivers/hwmon/pmbus/wistron-wps.c             | 176 ++++++++++++++++++
>   4 files changed, 216 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/wistron-wps.txt
>   create mode 100644 drivers/hwmon/pmbus/wistron-wps.c
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/wistron-wps.txt b/Documentation/devicetree/bindings/hwmon/wistron-wps.txt
> new file mode 100644
> index 000000000000..aacb2e66736e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/wistron-wps.txt

This is not a bindings document. It needs to be moved to Documentation/hwmon/

Note that the "w" in -wps seems redundant. The expanded text would read
"Wistron Wistron Common Form Factor power supply".

> @@ -0,0 +1,30 @@
> +ver ibm-cffps
> +=======================
> +
> +Supported chips:
> +
> +  * Wistron Common Form Factor power supply(wps).
> +
> +Author: Ben Pai <Ben_Pai@wistron.com>
> +
> +Description
> +-----------
> +
> +Our company name is Wistron, so this driver is written to supports
> +Wistron Common Form Factor power supplies(wps). This driver

"This driver supports Wistron Common Form Factor power supplies"
is sufficient. "Our company name is" does not any value here;
the company name is implied in the context.

> +is a client to the core PMBus driver. Read information from psu,
> +and create debug-files and write information to them via driver.
> +
This is a documentation of the resulting functionality. As pmbus client
driver, it also provides a number of hardware monitoring sysfs entries.

> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices for
> +details.
> +
> +Information of the data read
> +---------------------
> +FRU : name of psu manufacturer.
> +PN : part_number of psu.
> +SN : serial_number of psu.
> +mfr_date : Date of psu's manufacture.

Please explain that this information is provided via debugfs. You should also
list the supported sysfs attributes.

> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index d62d69bb7e49..ebb7024e58ab 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -219,6 +219,15 @@ config SENSORS_UCD9200
>   	  This driver can also be built as a module. If so, the module will
>   	  be called ucd9200.
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
>   config SENSORS_ZL6100
>   	tristate "Intersil ZL6100 and compatibles"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 03bacfcfd660..cad38f99e8c5 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>   obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>   obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>   obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
> +obj-$(CONFIG_SENSORS_WISTRON_WPS) += wistron-wps.o
>   obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> diff --git a/drivers/hwmon/pmbus/wistron-wps.c b/drivers/hwmon/pmbus/wistron-wps.c
> new file mode 100644
> index 000000000000..4e2649e7b3f2
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/wistron-wps.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2019 Wistron Corp.
> + */
> +
> +#include <linux/bitops.h>

I don't see any bit operations used below.

> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +
> +#include "pmbus.h"
> +
> +#define WPS_FRU_CMD	   0x99
> +#define WPS_PN_CMD         0x9A
> +#define WPS_FW_CMD	   0x9B
> +#define WPS_DATE_CMD       0x9D
> +#define WPS_SN_CMD	   0x9E
> +
> +enum {
> +	WPS_DEBUGFS_FRU,
> +	WPS_DEBUGFS_PN,
> +	WPS_DEBUGFS_SN,
> +	WPS_DEBUGFS_FW,
> +	WPS_DEBUGFS_DATE,
> +	WPS_DEBUGFS_NUM_ENTRIES
> +};
> +
> +struct wistron_wps {
> +	struct i2c_client *client;
> +	int debugfs_entries[WPS_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of(x, struct wistron_wps, debugfs_entries[y])
> +
> +static ssize_t wistron_wps_debugfs_op(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	u8 cmd;
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct wistron_wps *psu = to_psu(idxp, idx);
> +	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +
> +	pmbus_set_page(psu->client, 0);

The chip has only one page. Why set page 0 ? If this is needed,
it needs to be explained in a comment.

> +	switch (idx) {
> +	case WPS_DEBUGFS_FRU:
> +		cmd = WPS_FRU_CMD;
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
> +	rc += 2;

The device can, per protocol, return up to I2C_SMBUS_BLOCK_MAX bytes. If it does,
the write into data[rc] will be beyond the end of the buffer, and the call
below will read data beyond the end of the buffer, You will need to increase
the buffer size by 2 for this to work. You can not rely on the assumption that
the device never returns that much data.

There is also still no explanation why the trailing '\0' is sent to userspace.

For the record, I did mention all that in my comments to v1.

> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static const struct file_operations wistron_wps_fops = {
> +
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
> +};

As already mentioned in my comments to v1, this needs a comment explaining
the reason.

> +
> +static int wistron_wps_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
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
> +			    &psu->debugfs_entries[WPS_DEBUGFS_FRU],
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
> +	{ .compatible = "wistron, wps" },
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
> 

