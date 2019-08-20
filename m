Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09044C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8E422DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qivyYH5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfHTPJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:09:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45952 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:09:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so3410721pgp.12;
        Tue, 20 Aug 2019 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTh0WpYoA5HGKRWZ/eXeav+8+rPTI45l+tq4J19/no0=;
        b=qivyYH5D+TXcAf1WCO9cWtJhBUfC70HfnAIy8OgMHDCHp5otJMvZWRWSkC/RdtSXAO
         cvK5CS1qAOvlKUebbITRt8kNjU1lKXpYq//jvRjshElS5wQlqSABqpfDPcZ2fUBbi0fU
         cJ/elk8TvZrmDeUsQQcAJSzOTNEt5CbC5fg9GfHBW3ywgEV/AzABGYASrp+2YwEenKzR
         f/YcT3AcCE5AW20WAU5yK/X4JrRac/GL8y23xbCbR/RMW5BKGXxwbdmpSkYw4CH0QPDz
         DM8HS6EfNr5GFzMOgCjchX6R+4rS6brL6EwaIFrkg/vX/a+35pD0UImBF0BVZhaBxbrY
         xz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTh0WpYoA5HGKRWZ/eXeav+8+rPTI45l+tq4J19/no0=;
        b=qQyn6wisDO67Sz5hVsONtvz2QH+71gZbW1zwSVWdvzOM7r5zp/DaLJ+MFZTaAEVJdd
         LmWu57h6Ww7KHhCQfMMYsYslj2iqI6eS0hfSvo3wEx+UK3sJMIEsseC2qGUIFnaYwLE7
         OSc6firjAv7MQfwPGvfHSdlm01zB23FQ/VWmcM6yenb91BGZSvPiPSXw14WDC5y4BvoX
         GAdruyjSZvIv7DtZp5NMVREDrdkT1vBdushAE6ddkrodtzi6zCatfRO78o8XDObTsVWa
         VRZeA1I5E5/V4lYFXiRAEUAFcIp0uK7guGEcG/q7yxyEhrKVG18v/CaRkWXe7lfxHMrq
         QY9A==
X-Gm-Message-State: APjAAAWQrn7B6bI9V2F7RvNKq75jrLq2Md4SXtGLMkjcK+jhi9Ock445
        Cep5tLvujlEMQYK+u3H3wQs=
X-Google-Smtp-Source: APXvYqzMHRQTEOZGZTkfAP4fm84PZtggdd6SrxUR7852PRorQMaXkNl+lQVUVH65MZx/29JFxvH1fg==
X-Received: by 2002:aa7:938d:: with SMTP id t13mr29384749pfe.180.1566313772102;
        Tue, 20 Aug 2019 08:09:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm196193pjs.31.2019.08.20.08.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:09:31 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:09:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Wang <wangzqbj@inspur.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, duanzhijia01@inspur.com,
        mine260309@gmail.com, joel@jms.id.au
Subject: Re: [PATCH v6 2/2] hwmon: pmbus: Add Inspur Power System power
 supply driver
Message-ID: <20190820150930.GA12866@roeck-us.net>
References: <20190819091509.29276-1-wangzqbj@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819091509.29276-1-wangzqbj@inspur.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:15:09PM +0800, John Wang wrote:
> Add the driver to monitor Inspur Power System power supplies
> with hwmon over pmbus.
> 
> This driver adds sysfs attributes for additional power supply data,
> including vendor, model, part_number, serial number,
> firmware revision, hardware revision, and psu mode(active/standby).
> 
> Signed-off-by: John Wang <wangzqbj@inspur.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v6:
>     - Name i2c device as ipsps1
>     - Use of_match_ptr to save a few bytes if CONFIG_OF
>       is not enabled :)
> v5:
>     - Align sysfs attrs description in inspur-ipsps1.rst
>       (Use tab instead of space to sperate names and values)
> v4:
>     - Remove the additional tabs in the Makefile
>     - Rebased on 5.3-rc4, not 5.2
> v3:
>     - Sort kconfig/makefile entries alphabetically
>     - Remove unnecessary initialization
>     - Use ATTRIBUTE_GROUPS instead of expanding directly
>     - Use memscan to avoid reimplementation
> v2:
>     - Fix typos in commit message
>     - Invert Christmas tree
>     - Configure device with sysfs attrs, not debugfs entries
>     - Fix errno in fw_version_read, ENODATA to EPROTO
>     - Change the print format of fw-version
>     - Use sysfs_streq instead of strcmp("xxx" "\n", "xxx")
>     - Document sysfs attributes
> ---
>  Documentation/hwmon/inspur-ipsps1.rst |  79 +++++++++
>  drivers/hwmon/pmbus/Kconfig           |   9 +
>  drivers/hwmon/pmbus/Makefile          |   1 +
>  drivers/hwmon/pmbus/inspur-ipsps.c    | 228 ++++++++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 Documentation/hwmon/inspur-ipsps1.rst
>  create mode 100644 drivers/hwmon/pmbus/inspur-ipsps.c
> 
> diff --git a/Documentation/hwmon/inspur-ipsps1.rst b/Documentation/hwmon/inspur-ipsps1.rst
> new file mode 100644
> index 000000000000..2b871ae3448f
> --- /dev/null
> +++ b/Documentation/hwmon/inspur-ipsps1.rst
> @@ -0,0 +1,79 @@
> +Kernel driver inspur-ipsps1
> +=======================
> +
> +Supported chips:
> +
> +  * Inspur Power System power supply unit
> +
> +Author: John Wang <wangzqbj@inspur.com>
> +
> +Description
> +-----------
> +
> +This driver supports Inspur Power System power supplies. This driver
> +is a client to the core PMBus driver.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices for
> +details.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported:
> +
> +======================= ======================================================
> +curr1_input		Measured input current
> +curr1_label		"iin"
> +curr1_max		Maximum current
> +curr1_max_alarm		Current high alarm
> +curr2_input		Measured output current in mA.
> +curr2_label		"iout1"
> +curr2_crit		Critical maximum current
> +curr2_crit_alarm	Current critical high alarm
> +curr2_max		Maximum current
> +curr2_max_alarm		Current high alarm
> +
> +fan1_alarm		Fan 1 warning.
> +fan1_fault		Fan 1 fault.
> +fan1_input		Fan 1 speed in RPM.
> +
> +in1_alarm		Input voltage under-voltage alarm.
> +in1_input		Measured input voltage in mV.
> +in1_label		"vin"
> +in2_input		Measured output voltage in mV.
> +in2_label		"vout1"
> +in2_lcrit		Critical minimum output voltage
> +in2_lcrit_alarm		Output voltage critical low alarm
> +in2_max			Maximum output voltage
> +in2_max_alarm		Output voltage high alarm
> +in2_min			Minimum output voltage
> +in2_min_alarm		Output voltage low alarm
> +
> +power1_alarm		Input fault or alarm.
> +power1_input		Measured input power in uW.
> +power1_label		"pin"
> +power1_max		Input power limit
> +power2_max_alarm	Output power high alarm
> +power2_max		Output power limit
> +power2_input		Measured output power in uW.
> +power2_label		"pout"
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-2]_max		Maximum temperature
> +temp[1-3]_max_alarm	Temperature high alarm
> +
> +vendor			Manufacturer name
> +model			Product model
> +part_number		Product part number
> +serial_number		Product serial number
> +fw_version		Firmware version
> +hw_version		Hardware version
> +mode			Work mode. Can be set to active or
> +			standby, when set to standby, PSU will
> +			automatically switch between standby
> +			and redundancy mode.
> +======================= ======================================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index b6588483fae1..d62d69bb7e49 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -46,6 +46,15 @@ config SENSORS_IBM_CFFPS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ibm-cffps.
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
>  config SENSORS_IR35221
>  	tristate "Infineon IR35221"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index c950ea9a5d00..03bacfcfd660 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> +obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>  obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
>  obj-$(CONFIG_SENSORS_IRPS5401)	+= irps5401.o
> diff --git a/drivers/hwmon/pmbus/inspur-ipsps.c b/drivers/hwmon/pmbus/inspur-ipsps.c
> new file mode 100644
> index 000000000000..42e01549184a
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/inspur-ipsps.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2019 Inspur Corp.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include "pmbus.h"
> +
> +#define IPSPS_REG_VENDOR_ID	0x99
> +#define IPSPS_REG_MODEL		0x9A
> +#define IPSPS_REG_FW_VERSION	0x9B
> +#define IPSPS_REG_PN		0x9C
> +#define IPSPS_REG_SN		0x9E
> +#define IPSPS_REG_HW_VERSION	0xB0
> +#define IPSPS_REG_MODE		0xFC
> +
> +#define MODE_ACTIVE		0x55
> +#define MODE_STANDBY		0x0E
> +#define MODE_REDUNDANCY		0x00
> +
> +#define MODE_ACTIVE_STRING		"active"
> +#define MODE_STANDBY_STRING		"standby"
> +#define MODE_REDUNDANCY_STRING		"redundancy"
> +
> +enum ipsps_index {
> +	vendor,
> +	model,
> +	fw_version,
> +	part_number,
> +	serial_number,
> +	hw_version,
> +	mode,
> +	num_regs,
> +};
> +
> +static const u8 ipsps_regs[num_regs] = {
> +	[vendor] = IPSPS_REG_VENDOR_ID,
> +	[model] = IPSPS_REG_MODEL,
> +	[fw_version] = IPSPS_REG_FW_VERSION,
> +	[part_number] = IPSPS_REG_PN,
> +	[serial_number] = IPSPS_REG_SN,
> +	[hw_version] = IPSPS_REG_HW_VERSION,
> +	[mode] = IPSPS_REG_MODE,
> +};
> +
> +static ssize_t ipsps_string_show(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	char *p;
> +	char data[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = ipsps_regs[attr->index];
> +	rc = i2c_smbus_read_block_data(client, reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* filled with printable characters, ending with # */
> +	p = memscan(data, '#', rc);
> +	*p = '\0';
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", data);
> +}
> +
> +static ssize_t ipsps_fw_version_show(struct device *dev,
> +				     struct device_attribute *devattr,
> +				     char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	u8 data[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = ipsps_regs[attr->index];
> +	rc = i2c_smbus_read_block_data(client, reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != 6)
> +		return -EPROTO;
> +
> +	return snprintf(buf, PAGE_SIZE, "%u.%02u%u-%u.%02u\n",
> +			data[1], data[2]/* < 100 */, data[3]/*< 10*/,
> +			data[4], data[5]/* < 100 */);
> +}
> +
> +static ssize_t ipsps_mode_show(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	u8 reg;
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = ipsps_regs[attr->index];
> +	rc = i2c_smbus_read_byte_data(client, reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	switch (rc) {
> +	case MODE_ACTIVE:
> +		return snprintf(buf, PAGE_SIZE, "[%s] %s %s\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +	case MODE_STANDBY:
> +		return snprintf(buf, PAGE_SIZE, "%s [%s] %s\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +	case MODE_REDUNDANCY:
> +		return snprintf(buf, PAGE_SIZE, "%s %s [%s]\n",
> +				MODE_ACTIVE_STRING,
> +				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +	default:
> +		return snprintf(buf, PAGE_SIZE, "unspecified\n");
> +	}
> +}
> +
> +static ssize_t ipsps_mode_store(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	u8 reg;
> +	int rc;
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	reg = ipsps_regs[attr->index];
> +	if (sysfs_streq(MODE_STANDBY_STRING, buf)) {
> +		rc = i2c_smbus_write_byte_data(client, reg,
> +					       MODE_STANDBY);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	} else if (sysfs_streq(MODE_ACTIVE_STRING, buf)) {
> +		rc = i2c_smbus_write_byte_data(client, reg,
> +					       MODE_ACTIVE);
> +		if (rc < 0)
> +			return rc;
> +		return count;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(vendor, ipsps_string, vendor);
> +static SENSOR_DEVICE_ATTR_RO(model, ipsps_string, model);
> +static SENSOR_DEVICE_ATTR_RO(part_number, ipsps_string, part_number);
> +static SENSOR_DEVICE_ATTR_RO(serial_number, ipsps_string, serial_number);
> +static SENSOR_DEVICE_ATTR_RO(hw_version, ipsps_string, hw_version);
> +static SENSOR_DEVICE_ATTR_RO(fw_version, ipsps_fw_version, fw_version);
> +static SENSOR_DEVICE_ATTR_RW(mode, ipsps_mode, mode);
> +
> +static struct attribute *ipsps_attrs[] = {
> +	&sensor_dev_attr_vendor.dev_attr.attr,
> +	&sensor_dev_attr_model.dev_attr.attr,
> +	&sensor_dev_attr_part_number.dev_attr.attr,
> +	&sensor_dev_attr_serial_number.dev_attr.attr,
> +	&sensor_dev_attr_hw_version.dev_attr.attr,
> +	&sensor_dev_attr_fw_version.dev_attr.attr,
> +	&sensor_dev_attr_mode.dev_attr.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(ipsps);
> +
> +static struct pmbus_driver_info ipsps_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_IIN | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +		PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
> +		PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
> +	.groups = ipsps_groups,
> +};
> +
> +static struct pmbus_platform_data ipsps_pdata = {
> +	.flags = PMBUS_SKIP_STATUS_CHECK,
> +};
> +
> +static int ipsps_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	client->dev.platform_data = &ipsps_pdata;
> +	return pmbus_do_probe(client, id, &ipsps_info);
> +}
> +
> +static const struct i2c_device_id ipsps_id[] = {
> +	{ "ipsps1", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ipsps_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ipsps_of_match[] = {
> +	{ .compatible = "inspur,ipsps1" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ipsps_of_match);
> +#endif
> +
> +static struct i2c_driver ipsps_driver = {
> +	.driver = {
> +		.name = "inspur-ipsps",
> +		.of_match_table = of_match_ptr(ipsps_of_match),
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
