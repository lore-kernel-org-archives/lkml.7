Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA1C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75146206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRkxabPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHPDNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:13:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfHPDNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:13:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id 129so2372549pfa.4;
        Thu, 15 Aug 2019 20:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WkoOCA/n7qkpq0LseUmb40YwE4OsrMK04BkgU8zVzh8=;
        b=gRkxabPWUigNcNDN/RFVwRXCChCuSRlMkupPiBtBNs3sx8GKxBnyWht7fM/LNsG++Z
         My/PJXuUzU8vqrwJC3T30JKHklWoESo+Ybm9zjXrBIk+ZIU1fdCfiSnZHQ6Gkxjt+wQU
         6v6kaZ/FWALphuhtqYZZairUHuRgQ173zXzX7Ff9NO7el5A5Ezc8K7jzDdIjIrhCNF4Q
         7AQ4q5VGZVlCmlmz1TjZAJ08zhVqBP6UsUOf3AsEeFoDnnXoK9SJmP2PoOTB6jk/SvIQ
         K6a08m4kaw4QOVp9nPR4fyIwdxBXhFWa3bNVD7LoHOxM1fdBlCkx3CPQc094gop9MvIw
         7XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WkoOCA/n7qkpq0LseUmb40YwE4OsrMK04BkgU8zVzh8=;
        b=VcvSTJEXkr4ZFjCEZct+Rcl3ip0uiOX87pwSk1mFcvpWvwH9y9awUSz3gYiQx9dEPh
         9Tps30rRWldXIKr8HeByANFh4H+uqfJR0ct1+LIWGOi5QNC7C6Owq9Gq5fqJVtymx5A6
         HN4jEnD2ysf8w8RkAinxMjrgrjJcymQFawrpOVDxRwZEGjpL53kn9g3sNl6qJa3c0qXj
         W/9QAEkvA35POe/2SkLNeDgaaUBq2YuSbNYaWlVrqe+Rg07LCwcHBfH2wfY8p5ClxK7f
         uZw+PXyftrG7+Y3JW0CJ4CcLgYZhl8C9RUY5GrSz6Ma9ViDq2eOIBa8FFmACzgolJ4VL
         nkHw==
X-Gm-Message-State: APjAAAWwtYSdZvPJMGZrzDmUXh+yJoINJqT/nH+0BJU5EhbCVnxqZm5s
        3N3UcK1RI5e/acatix/iUGBolMv8
X-Google-Smtp-Source: APXvYqybFIM4zT5OQ8q9MW80ajTzHCdzEgUvVsFVW5bY+DcUEt8+aWFrgN/vBqBmU/0MqJTjSx4D3g==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr5321033pjr.130.1565925185566;
        Thu, 15 Aug 2019 20:13:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm2641042pji.18.2019.08.15.20.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 20:13:04 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] hwmon: pmbus: Add Inspur Power System power supply
 driver
To:     John Wang <wangzqbj@inspur.com>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duanzhijia01@inspur.com" <duanzhijia01@inspur.com>
References: <20190813083412.8668-1-wangzqbj@inspur.com>
 <70B3A211-2F43-4712-9B92-D407AA3C3934@fb.com>
 <20190815194102.GA11916@roeck-us.net>
 <CAHkHK08ZkZDoVQ0qfLPcO=_=-OAmx+N5BGHRgZkoxLUNQzTp5g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b198c90-714a-01a8-a004-5f17adcc6dee@roeck-us.net>
Date:   Thu, 15 Aug 2019 20:13:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHkHK08ZkZDoVQ0qfLPcO=_=-OAmx+N5BGHRgZkoxLUNQzTp5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 7:44 PM, John Wang wrote:
> On Fri, Aug 16, 2019 at 3:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Aug 15, 2019 at 06:43:52PM +0000, Vijay Khemka wrote:
>>>
>>>
>>> ﻿On 8/13/19, 1:36 AM, "openbmc on behalf of John Wang" <openbmc-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of wangzqbj@inspur.com> wrote:
>>>
>>>      Add the driver to monitor Inspur Power System power supplies
>>>      with hwmon over pmbus.
>>>
>>>      This driver adds sysfs attributes for additional power supply data,
>>>      including vendor, model, part_number, serial number,
>>>      firmware revision, hardware revision, and psu mode(active/standby).
>>>
>>>      Signed-off-by: John Wang <wangzqbj@inspur.com>
>>>      ---
>>>      v4:
>>>          - Remove the additional tabs in the Makefile
>>>          - Rebased on 5.3-rc4, not 5.2
>>>      v3:
>>>          - Sort kconfig/makefile entries alphabetically
>>>          - Remove unnecessary initialization
>>>          - Use ATTRIBUTE_GROUPS instead of expanding directly
>>>          - Use memscan to avoid reimplementation
>>>      v2:
>>>          - Fix typos in commit message
>>>          - Invert Christmas tree
>>>          - Configure device with sysfs attrs, not debugfs entries
>>>          - Fix errno in fw_version_read, ENODATA to EPROTO
>>>          - Change the print format of fw-version
>>>          - Use sysfs_streq instead of strcmp("xxx" "\n", "xxx")
>>>          - Document sysfs attributes
>>>      ---
>>>       Documentation/hwmon/inspur-ipsps1.rst |  79 +++++++++
>>>       drivers/hwmon/pmbus/Kconfig           |   9 +
>>>       drivers/hwmon/pmbus/Makefile          |   1 +
>>>       drivers/hwmon/pmbus/inspur-ipsps.c    | 226 ++++++++++++++++++++++++++
>>>       4 files changed, 315 insertions(+)
>>>       create mode 100644 Documentation/hwmon/inspur-ipsps1.rst
>>>       create mode 100644 drivers/hwmon/pmbus/inspur-ipsps.c
>>>
>>>      diff --git a/Documentation/hwmon/inspur-ipsps1.rst b/Documentation/hwmon/inspur-ipsps1.rst
>>>      new file mode 100644
>>>      index 000000000000..aa19f0ccc8b0
>>>      --- /dev/null
>>>      +++ b/Documentation/hwmon/inspur-ipsps1.rst
>>>      @@ -0,0 +1,79 @@
>>>      +Kernel driver inspur-ipsps1
>>>      +=======================
>>>      +
>>>      +Supported chips:
>>>      +
>>>      +  * Inspur Power System power supply unit
>>>      +
>>>      +Author: John Wang <wangzqbj@inspur.com>
>>>      +
>>>      +Description
>>>      +-----------
>>>      +
>>>      +This driver supports Inspur Power System power supplies. This driver
>>>      +is a client to the core PMBus driver.
>>>      +
>>>      +Usage Notes
>>>      +-----------
>>>      +
>>>      +This driver does not auto-detect devices. You will have to instantiate the
>>>      +devices explicitly. Please see Documentation/i2c/instantiating-devices for
>>>      +details.
>>>      +
>>>      +Sysfs entries
>>>      +-------------
>>>      +
>>>      +The following attributes are supported:
>>>      +
>>>      +======================= ======================================================
>>>      +curr1_input             Measured input current
>>>      +curr1_label             "iin"
>>>      +curr1_max               Maximum current
>>>      +curr1_max_alarm         Current high alarm
>>>      +curr2_input              Measured output current in mA.
>>>      +curr2_label              "iout1"
>>>      +curr2_crit              Critical maximum current
>>>      +curr2_crit_alarm        Current critical high alarm
>>>      +curr2_max               Maximum current
>>>      +curr2_max_alarm         Current high alarm
>>>      +
>>> Please align above details.
> 
> Sorry for the mix of table and space
> 
>>>      +fan1_alarm               Fan 1 warning.
>>>      +fan1_fault               Fan 1 fault.
>>>      +fan1_input               Fan 1 speed in RPM.
>>>      +
>>>      +in1_alarm                Input voltage under-voltage alarm.
>>>      +in1_input                Measured input voltage in mV.
>>>      +in1_label                "vin"
>>>      +in2_input                Measured output voltage in mV.
>>>      +in2_label                "vout1"
>>>      +in2_lcrit               Critical minimum output voltage
>>>      +in2_lcrit_alarm         Output voltage critical low alarm
>>>      +in2_max                 Maximum output voltage
>>>      +in2_max_alarm           Output voltage high alarm
>>>      +in2_min                 Minimum output voltage
>>>      +in2_min_alarm           Output voltage low alarm
>>>      +
>>>      +power1_alarm             Input fault or alarm.
>>>      +power1_input             Measured input power in uW.
>>>      +power1_label             "pin"
>>>      +power1_max              Input power limit
>>>      +power2_max_alarm Output power high alarm
>>>      +power2_max              Output power limit
>>>      +power2_input             Measured output power in uW.
>>>      +power2_label             "pout"
>>>      +
>>> Same alignment issue in description.
> 
> will fix.
> 
>>>      +temp[1-3]_input          Measured temperature
>>>      +temp[1-2]_max            Maximum temperature
>>>      +temp[1-3]_max_alarm      Temperature high alarm
>>>      +
>>>      +vendor                  Manufacturer name
>>>      +model                   Product model
>>>      +part_number             Product part number
>>>      +serial_number           Product serial number
>>>      +fw_version              Firmware version
>>>      +hw_version              Hardware version
>>>      +mode                    Work mode. Can be set to active or
>>>      +                        standby, when set to standby, PSU will
>>>      +                        automatically switch between standby
>>>      +                        and redundancy mode.
>>>      +======================= ======================================================
>>>      diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>>      index b6588483fae1..d62d69bb7e49 100644
>>>      --- a/drivers/hwmon/pmbus/Kconfig
>>>      +++ b/drivers/hwmon/pmbus/Kconfig
>>>      @@ -46,6 +46,15 @@ config SENSORS_IBM_CFFPS
>>>          This driver can also be built as a module. If so, the module will
>>>          be called ibm-cffps.
>>>
>>>      +config SENSORS_INSPUR_IPSPS
>>>      + tristate "INSPUR Power System Power Supply"
>>>      + help
>>>      +   If you say yes here you get hardware monitoring support for the INSPUR
>>>      +   Power System power supply.
>>>      +
>>>      +   This driver can also be built as a module. If so, the module will
>>>      +   be called inspur-ipsps.
>>>      +
>>>       config SENSORS_IR35221
>>>        tristate "Infineon IR35221"
>>>        help
>>>      diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>>      index c950ea9a5d00..03bacfcfd660 100644
>>>      --- a/drivers/hwmon/pmbus/Makefile
>>>      +++ b/drivers/hwmon/pmbus/Makefile
>>>      @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)               += pmbus_core.o
>>>       obj-$(CONFIG_SENSORS_PMBUS)      += pmbus.o
>>>       obj-$(CONFIG_SENSORS_ADM1275)    += adm1275.o
>>>       obj-$(CONFIG_SENSORS_IBM_CFFPS)  += ibm-cffps.o
>>>      +obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>>>       obj-$(CONFIG_SENSORS_IR35221)    += ir35221.o
>>>       obj-$(CONFIG_SENSORS_IR38064)    += ir38064.o
>>>       obj-$(CONFIG_SENSORS_IRPS5401)   += irps5401.o
>>>      diff --git a/drivers/hwmon/pmbus/inspur-ipsps.c b/drivers/hwmon/pmbus/inspur-ipsps.c
>>>      new file mode 100644
>>>      index 000000000000..fa981b881a60
>>>      --- /dev/null
>>>      +++ b/drivers/hwmon/pmbus/inspur-ipsps.c
>>>      @@ -0,0 +1,226 @@
>>>      +// SPDX-License-Identifier: GPL-2.0-or-later
>>>      +/*
>>>      + * Copyright 2019 Inspur Corp.
>>>      + */
>>>      +
>>>      +#include <linux/debugfs.h>
>>>      +#include <linux/device.h>
>>>      +#include <linux/fs.h>
>>>      +#include <linux/i2c.h>
>>>      +#include <linux/module.h>
>>>      +#include <linux/pmbus.h>
>>>      +#include <linux/hwmon-sysfs.h>
>>>      +
>>>      +#include "pmbus.h"
>>>      +
>>>      +#define IPSPS_REG_VENDOR_ID      0x99
>>>      +#define IPSPS_REG_MODEL          0x9A
>>>      +#define IPSPS_REG_FW_VERSION     0x9B
>>>      +#define IPSPS_REG_PN             0x9C
>>>      +#define IPSPS_REG_SN             0x9E
>>>      +#define IPSPS_REG_HW_VERSION     0xB0
>>>      +#define IPSPS_REG_MODE           0xFC
>>>      +
>>>      +#define MODE_ACTIVE              0x55
>>>      +#define MODE_STANDBY             0x0E
>>>      +#define MODE_REDUNDANCY          0x00
>>>      +
>>>      +#define MODE_ACTIVE_STRING               "active"
>>>      +#define MODE_STANDBY_STRING              "standby"
>>>      +#define MODE_REDUNDANCY_STRING           "redundancy"
>>>      +
>>>      +enum ipsps_index {
>>>      + vendor,
>>>      + model,
>>>      + fw_version,
>>>      + part_number,
>>>      + serial_number,
>>>      + hw_version,
>>>      + mode,
>>>      + num_regs,
>>>      +};
>>>      +
>>>      +static const u8 ipsps_regs[num_regs] = {
>>>      + [vendor] = IPSPS_REG_VENDOR_ID,
>>>      + [model] = IPSPS_REG_MODEL,
>>>      + [fw_version] = IPSPS_REG_FW_VERSION,
>>>      + [part_number] = IPSPS_REG_PN,
>>>      + [serial_number] = IPSPS_REG_SN,
>>>      + [hw_version] = IPSPS_REG_HW_VERSION,
>>>      + [mode] = IPSPS_REG_MODE,
>>>      +};
>>>      +
>>>      +static ssize_t ipsps_string_show(struct device *dev,
>>>      +                          struct device_attribute *devattr,
>>>      +                          char *buf)
>>>      +{
>>>      + u8 reg;
>>>      + int rc;
>>>      + char *p;
>>>      + char data[I2C_SMBUS_BLOCK_MAX + 1];
>>>      + struct i2c_client *client = to_i2c_client(dev->parent);
>>>      + struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>>>      +
>>>      + reg = ipsps_regs[attr->index];
>>>      + rc = i2c_smbus_read_block_data(client, reg, data);
>>>      + if (rc < 0)
>>>      +         return rc;
>>>      +
>>>      + /* filled with printable characters, ending with # */
>>>      + p = memscan(data, '#', rc);
>>>      + *p = '\0';
>>>      +
>>>      + return snprintf(buf, PAGE_SIZE, "%s\n", data);
>>>      +}
>>>      +
>>>      +static ssize_t ipsps_fw_version_show(struct device *dev,
>>>      +                              struct device_attribute *devattr,
>>>      +                              char *buf)
>>>      +{
>>>      + u8 reg;
>>>      + int rc;
>>>      + u8 data[I2C_SMBUS_BLOCK_MAX] = { 0 };
>>>      + struct i2c_client *client = to_i2c_client(dev->parent);
>>>      + struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>>>      +
>>>      + reg = ipsps_regs[attr->index];
>>>      + rc = i2c_smbus_read_block_data(client, reg, data);
>>>      + if (rc < 0)
>>>      +         return rc;
>>>      +
>>>      + if (rc != 6)
>>>      +         return -EPROTO;
>>>      +
>>>      + return snprintf(buf, PAGE_SIZE, "%u.%02u%u-%u.%02u\n",
>>>      +                 data[1], data[2]/* < 100 */, data[3]/*< 10*/,
>>>      +                 data[4], data[5]/* < 100 */);
>>>      +}
>>>      +
>>>      +static ssize_t ipsps_mode_show(struct device *dev,
>>>      +                        struct device_attribute *devattr, char *buf)
>>>      +{
>>>      + u8 reg;
>>>      + int rc;
>>>      + struct i2c_client *client = to_i2c_client(dev->parent);
>>>      + struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>>>      +
>>>      + reg = ipsps_regs[attr->index];
>>>      + rc = i2c_smbus_read_byte_data(client, reg);
>>>      + if (rc < 0)
>>>      +         return rc;
>>>      +
>>>      + switch (rc) {
>>>      + case MODE_ACTIVE:
>>>      +         return snprintf(buf, PAGE_SIZE, "[%s] %s %s\n",
>>>      +                         MODE_ACTIVE_STRING,
>>>      +                         MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>>>      + case MODE_STANDBY:
>>>      +         return snprintf(buf, PAGE_SIZE, "%s [%s] %s\n",
>>>      +                         MODE_ACTIVE_STRING,
>>>      +                         MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>>>      + case MODE_REDUNDANCY:
>>>      +         return snprintf(buf, PAGE_SIZE, "%s %s [%s]\n",
>>>      +                         MODE_ACTIVE_STRING,
>>>      +                         MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>>>      + default:
>>>      +         return snprintf(buf, PAGE_SIZE, "unspecified\n");
>>>      + }
>>>      +}
>>>      +
>>>      +static ssize_t ipsps_mode_store(struct device *dev,
>>>      +                         struct device_attribute *devattr,
>>>      +                         const char *buf, size_t count)
>>>      +{
>>>      + u8 reg;
>>>      + int rc;
>>>      + struct i2c_client *client = to_i2c_client(dev->parent);
>>>      + struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>>>      +
>>>      + reg = ipsps_regs[attr->index];
>>>      + if (sysfs_streq(MODE_STANDBY_STRING, buf)) {
>>>      +         rc = i2c_smbus_write_byte_data(client, reg,
>>>      +                                        MODE_STANDBY);
>>>      +         if (rc < 0)
>>>      +                 return rc;
>>>      +         return count;
>>>      + } else if (sysfs_streq(MODE_ACTIVE_STRING, buf)) {
>>>      +         rc = i2c_smbus_write_byte_data(client, reg,
>>>      +                                        MODE_ACTIVE);
>>>      +         if (rc < 0)
>>>      +                 return rc;
>>>      +         return count;
>>>      + }
>>>      +
>>>      + return -EINVAL;
>>>      +}
>>>      +
>>>      +static SENSOR_DEVICE_ATTR_RO(vendor, ipsps_string, vendor);
>>>      +static SENSOR_DEVICE_ATTR_RO(model, ipsps_string, model);
>>>      +static SENSOR_DEVICE_ATTR_RO(part_number, ipsps_string, part_number);
>>>      +static SENSOR_DEVICE_ATTR_RO(serial_number, ipsps_string, serial_number);
>>>      +static SENSOR_DEVICE_ATTR_RO(hw_version, ipsps_string, hw_version);
>>>      +static SENSOR_DEVICE_ATTR_RO(fw_version, ipsps_fw_version, fw_version);
>>>      +static SENSOR_DEVICE_ATTR_RW(mode, ipsps_mode, mode);
>>>      +
>>>      +static struct attribute *ipsps_attrs[] = {
>>>      + &sensor_dev_attr_vendor.dev_attr.attr,
>>>      + &sensor_dev_attr_model.dev_attr.attr,
>>>      + &sensor_dev_attr_part_number.dev_attr.attr,
>>>      + &sensor_dev_attr_serial_number.dev_attr.attr,
>>>      + &sensor_dev_attr_hw_version.dev_attr.attr,
>>>      + &sensor_dev_attr_fw_version.dev_attr.attr,
>>>      + &sensor_dev_attr_mode.dev_attr.attr,
>>>      + NULL,
>>>      +};
>>>      +
>>>      +ATTRIBUTE_GROUPS(ipsps);
>>>      +
>>>      +static struct pmbus_driver_info ipsps_info = {
>>>      + .pages = 1,
>>>      + .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>>>      +         PMBUS_HAVE_IIN | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN |
>>>      +         PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
>>>      +         PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
>>>      +         PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
>>>      +         PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
>>> This can be dynamic read by chip identify function
>>
>> PMBUS_SKIP_STATUS_CHECK weakens auto-detetcion to some degree,
>> and auto-detection takes time since it needs to poll all registers
>> to determine if they exist. I don't mind if you insist, but I don't
>> immediately see the benefits.
> 
> ipsps does not specify that the vendor must support the status_cml
> register( some vendor do not support),
> so PMBUS_SKIP_STATUS_CHECK is used here.
> 

I did not question that. I did question the request to use auto-detection,
which is quite unusual since you have a dedicated driver for the chip anyway.

Asking more directly: What is the problem with specifying capabilities
directly, and what is the advantage of using auto-detection ?

Guenter

>>
>>>      + .groups = ipsps_groups,
>>>      +};
>>>      +
>>>      +static struct pmbus_platform_data ipsps_pdata = {
>>>      + .flags = PMBUS_SKIP_STATUS_CHECK,
>>>      +};
>>>      +
>>>      +static int ipsps_probe(struct i2c_client *client,
>>>      +                const struct i2c_device_id *id)
>>>      +{
>>>      + client->dev.platform_data = &ipsps_pdata;
>>> Allocate memory for this platform data inside tis function rather than having global variable.
>>
>> Does that have any value other than consuming more memory
>> if there are multiple instances of the driver ?
>>
>>>      + return pmbus_do_probe(client, id, &ipsps_info);
>>>      +}
>>>      +
>>>      +static const struct i2c_device_id ipsps_id[] = {
>>>      + { "inspur_ipsps1", 0 },
>>>      + {}
>>>      +};
>>>      +MODULE_DEVICE_TABLE(i2c, ipsps_id);
>>>      +
>>>      +static const struct of_device_id ipsps_of_match[] = {
>>>      + { .compatible = "inspur,ipsps1" },
>>>      + {}
>>>      +};
>>>      +MODULE_DEVICE_TABLE(of, ipsps_of_match);
>>>      +
>>>      +static struct i2c_driver ipsps_driver = {
>>>      + .driver = {
>>>      +         .name = "inspur-ipsps",
>>>      +         .of_match_table = ipsps_of_match,
>>>      + },
>>>      + .probe = ipsps_probe,
>>>      + .remove = pmbus_do_remove,
>>>      + .id_table = ipsps_id,
>>>      +};
>>>      +
>>>      +module_i2c_driver(ipsps_driver);
>>>      +
>>>      +MODULE_AUTHOR("John Wang");
>>>      +MODULE_DESCRIPTION("PMBus driver for Inspur Power System power supplies");
>>>      +MODULE_LICENSE("GPL");
>>>      --
>>>      2.17.1
>>>
>>>
>>>
> 

