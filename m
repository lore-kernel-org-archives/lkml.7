Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE90C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E820578
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU1P3S9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbfIRVK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:10:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727784AbfIRVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568841057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmF40WKoTDy0aoAiOOto43DEtfi/3wB5zjK4rlI+fNE=;
        b=BU1P3S9xtEF94HYV4zkzZQAEWsl5nCyBRK8ArQj6ui1JdLqBQtgfGHeGD94dp4GaK5osx3
        3eWfw+Dd4Q+zfFBLy6YOSuqeZog7tqmtNvDklEXMsOg1BwvpmSnZRD2iyP/KeZXcfC0ilk
        CH7Fx6P1U0SeVbhJxUo2CU4sNaZsBlc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-K8jCo6rOMI2BBHy_OHP6CA-1; Wed, 18 Sep 2019 17:10:55 -0400
Received: by mail-ed1-f69.google.com with SMTP id d7so546997edp.23
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/LE+65917dpbc+FgVkF4PF6RUTUOxrXymHnbxTd+hU=;
        b=RsSHNsHOC71WBeXpVTj75qxUN/YakmscaBMbz1zM5soYdrgcBvMVQ/hCrE3O4sGnXS
         fUsleABMwBEJraNji2TgMIS015DMpWz1trLoPRKOwg7aXwv2OJhFrbOjg3zHAeNi0esb
         5McBMHYDjtEgT2ekhEdFRtCaaKS1QCV48mCLmMtVKk6JuOc9MApYzEVxN6cRbcnd0VUM
         0vi7UMlAhe1duPNqiuDYewotHo7YBrjeT5Z67EIydC6LtslGkDxlsN8xsLZehNusz1N/
         icsXn3yHbL6jg4JaZjXDNTUSzamyAE6c3L1tbyJ9ShQL+zmkMCiC4CgVYZfN8jrRWcOo
         Iq+w==
X-Gm-Message-State: APjAAAUlpSz6a4FAOF+MtMWPlcELgw4GTZ6060lia3Do7GJ5SI8XQl8l
        cBjIuUCfgskBt6O9PbKyKqyQJZo/RjAyQfrnZW6/kY6FxYbkS5p30fT6Bp0h927gHB6+Blb826n
        MKF65szm0gP8HBhYal2Unkz27
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr12705777eds.290.1568841054207;
        Wed, 18 Sep 2019 14:10:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzib7ArFIrRgB3UNLp9mi6sxO8xt/PR+zHX6C9oYOySKo4oxBAzaqU9FlJoBY1A+iparGs4+g==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr12705759eds.290.1568841053929;
        Wed, 18 Sep 2019 14:10:53 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 60sm1240599edg.10.2019.09.18.14.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:10:53 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
References: <20190918152705.3267-1-jekhor@gmail.com>
 <20190918152705.3267-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad2f6b1e-ae61-e935-bf08-3d2dcdeb4c64@redhat.com>
Date:   Wed, 18 Sep 2019 23:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918152705.3267-2-jekhor@gmail.com>
Content-Language: en-US
X-MC-Unique: K8jCo6rOMI2BBHy_OHP6CA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-09-2019 17:27, Yauhen Kharuzhy wrote:
> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> hardware has Type-C connector and register related devices described as
> I2C connections in the _CRS resource.
>=20
> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with Micro-B
> USB connector exists. It has INT33FE device in the DSDT table but
> there are only two I2C connection described: PMIC and BQ27452 battery
> fuel gauge.
>=20
> Splitting existing INT33FE driver allow to maintain code for USB Micro-B
> (AB) connector variant separately and make it simpler.
>=20
> Split driver to intel_cht_int33fe_common.c and
> intel_cht_int33fe_{typeb,typec}.c. Compile all this sources to one .ko
> module to make user experience easier.
>=20
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

As promised I've given this a test-run on a typec device, this works
for me:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/platform/x86/Kconfig                  |  12 +-
>   drivers/platform/x86/Makefile                 |   4 +
>   .../platform/x86/intel_cht_int33fe_common.c   | 147 ++++++++++++++++++
>   .../platform/x86/intel_cht_int33fe_common.h   |  41 +++++
>   .../platform/x86/intel_cht_int33fe_microb.c   |  63 ++++++++
>   ...ht_int33fe.c =3D> intel_cht_int33fe_typec.c} |  78 +---------
>   6 files changed, 272 insertions(+), 73 deletions(-)
>   create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
>   create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
>   create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
>   rename drivers/platform/x86/{intel_cht_int33fe.c =3D> intel_cht_int33fe=
_typec.c} (82%)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 1b67bb578f9f..2537885c933f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -926,18 +926,24 @@ config INTEL_CHT_INT33FE
>   =09depends on CHARGER_BQ24190=3Dy || (CHARGER_BQ24190=3Dm && m)
>   =09depends on USB_ROLES_INTEL_XHCI=3Dy || (USB_ROLES_INTEL_XHCI=3Dm && =
m)
>   =09depends on TYPEC_MUX_PI3USB30532=3Dy || (TYPEC_MUX_PI3USB30532=3Dm &=
& m)
> -=09---help---
> +=09help
>   =09  This driver add support for the INT33FE ACPI device found on
>   =09  some Intel Cherry Trail devices.
>  =20
> +=09  There are two kinds of INT33FE ACPI device possible: for hardware
> +=09  with USB Type-C and Micro-B connectors. This driver supports both.
> +
>   =09  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
> -=09  resources for 3 devices: Maxim MAX17047 Fuel Gauge Controller,
> +=09  resources for Fuel Gauge Controller and (in the Type-C variant)
>   =09  FUSB302 USB Type-C Controller and PI3USB30532 USB switch.
>   =09  This driver instantiates i2c-clients for these, so that standard
>   =09  i2c drivers for these chips can bind to the them.
>  =20
>   =09  If you enable this driver it is advised to also select
> -=09  CONFIG_TYPEC_FUSB302=3Dm and CONFIG_BATTERY_MAX17042=3Dm.
> +=09  CONFIG_BATTERY_BQ27XXX=3Dm and CONFIG_BATTERY_BQ27XXX_I2C=3Dm for M=
icro-B
> +=09  device and CONFIG_TYPEC_FUSB302=3Dm and CONFIG_BATTERY_MAX17042=3Dm
> +=09  for Type-C device.
> +
>  =20
>   config INTEL_INT0002_VGPIO
>   =09tristate "Intel ACPI INT0002 Virtual GPIO driver"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 415104033060..216d3b6fd6a7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -61,6 +61,10 @@ obj-$(CONFIG_TOSHIBA_BT_RFKILL)=09+=3D toshiba_bluetoo=
th.o
>   obj-$(CONFIG_TOSHIBA_HAPS)=09+=3D toshiba_haps.o
>   obj-$(CONFIG_TOSHIBA_WMI)=09+=3D toshiba-wmi.o
>   obj-$(CONFIG_INTEL_CHT_INT33FE)=09+=3D intel_cht_int33fe.o
> +intel_cht_int33fe-objs=09=09:=3D intel_cht_int33fe_common.o \
> +=09=09=09=09   intel_cht_int33fe_typec.o \
> +=09=09=09=09   intel_cht_int33fe_microb.o
> +
>   obj-$(CONFIG_INTEL_INT0002_VGPIO) +=3D intel_int0002_vgpio.o
>   obj-$(CONFIG_INTEL_HID_EVENT)=09+=3D intel-hid.o
>   obj-$(CONFIG_INTEL_VBTN)=09+=3D intel-vbtn.o
> diff --git a/drivers/platform/x86/intel_cht_int33fe_common.c b/drivers/pl=
atform/x86/intel_cht_int33fe_common.c
> new file mode 100644
> index 000000000000..42dd11623f56
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_common.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common code for Intel Cherry Trail ACPI INT33FE pseudo device drivers
> + * (USB Micro-B and Type-C connector variants).
> + *
> + * Copyright (c) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "intel_cht_int33fe_common.h"
> +
> +#define EXPECTED_PTYPE=09=094
> +
> +static int cht_int33fe_i2c_res_filter(struct acpi_resource *ares, void *=
data)
> +{
> +=09struct acpi_resource_i2c_serialbus *sb;
> +=09int *count =3D data;
> +
> +=09if (i2c_acpi_get_i2c_resource(ares, &sb))
> +=09=09(*count)++;
> +
> +=09return 1;
> +}
> +
> +static int cht_int33fe_count_i2c_clients(struct device *dev)
> +{
> +=09struct acpi_device *adev;
> +=09LIST_HEAD(resource_list);
> +=09int count =3D 0;
> +
> +=09adev =3D ACPI_COMPANION(dev);
> +=09if (!adev)
> +=09=09return -EINVAL;
> +
> +=09acpi_dev_get_resources(adev, &resource_list,
> +=09=09=09       cht_int33fe_i2c_res_filter, &count);
> +
> +=09acpi_dev_free_resource_list(&resource_list);
> +
> +=09return count;
> +}
> +
> +static int cht_int33fe_check_hw_type(struct device *dev)
> +{
> +=09unsigned long long ptyp;
> +=09acpi_status status;
> +=09int ret;
> +
> +=09status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &pty=
p);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(dev, "Error getting PTYPE\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09/*
> +=09 * The same ACPI HID is used for different configurations check PTYP
> +=09 * to ensure that we are dealing with the expected config.
> +=09 */
> +=09if (ptyp !=3D EXPECTED_PTYPE)
> +=09=09return -ENODEV;
> +
> +=09/* Check presence of INT34D3 (hardware-rev 3) expected for ptype =3D=
=3D 4 */
> +=09if (!acpi_dev_present("INT34D3", "1", 3)) {
> +=09=09dev_err(dev, "Error PTYPE =3D=3D %d, but no INT34D3 device\n",
> +=09=09=09EXPECTED_PTYPE);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09ret =3D cht_int33fe_count_i2c_clients(dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09switch (ret) {
> +=09case 2:
> +=09=09return INT33FE_HW_MICROB;
> +=09case 4:
> +=09=09return INT33FE_HW_TYPEC;
> +=09default:
> +=09=09return -ENODEV;
> +=09}
> +}
> +
> +static int cht_int33fe_probe(struct platform_device *pdev)
> +{
> +=09struct cht_int33fe_data *data;
> +=09struct device *dev =3D &pdev->dev;
> +=09int ret;
> +
> +=09ret =3D cht_int33fe_check_hw_type(dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +=09if (!data)
> +=09=09return -ENOMEM;
> +
> +=09data->dev =3D dev;
> +
> +=09switch (ret) {
> +=09case INT33FE_HW_MICROB:
> +=09=09data->probe =3D cht_int33fe_microb_probe;
> +=09=09data->remove =3D cht_int33fe_microb_remove;
> +=09=09break;
> +
> +=09case INT33FE_HW_TYPEC:
> +=09=09data->probe =3D cht_int33fe_typec_probe;
> +=09=09data->remove =3D cht_int33fe_typec_remove;
> +=09=09break;
> +=09}
> +
> +=09platform_set_drvdata(pdev, data);
> +
> +=09return data->probe(data);
> +}
> +
> +static int cht_int33fe_remove(struct platform_device *pdev)
> +{
> +=09struct cht_int33fe_data *data =3D platform_get_drvdata(pdev);
> +
> +=09return data->remove(data);
> +}
> +
> +static const struct acpi_device_id cht_int33fe_acpi_ids[] =3D {
> +=09{ "INT33FE", },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
> +
> +static struct platform_driver cht_int33fe_driver =3D {
> +=09.driver=09=3D {
> +=09=09.name =3D "Intel Cherry Trail ACPI INT33FE driver",
> +=09=09.acpi_match_table =3D ACPI_PTR(cht_int33fe_acpi_ids),
> +=09},
> +=09.probe =3D cht_int33fe_probe,
> +=09.remove =3D cht_int33fe_remove,
> +};
> +
> +module_platform_driver(cht_int33fe_driver);
> +
> +MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver=
");
> +MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/intel_cht_int33fe_common.h b/drivers/pl=
atform/x86/intel_cht_int33fe_common.h
> new file mode 100644
> index 000000000000..03cd45f4e8cb
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_common.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Common code for Intel Cherry Trail ACPI INT33FE pseudo device drivers
> + * (USB Micro-B and Type-C connector variants), header file
> + *
> + * Copyright (c) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> + */
> +
> +#ifndef _INTEL_CHT_INT33FE_COMMON_H
> +#define _INTEL_CHT_INT33FE_COMMON_H
> +
> +#include <linux/device.h>
> +#include <linux/fwnode.h>
> +#include <linux/i2c.h>
> +
> +enum int33fe_hw_type {
> +=09INT33FE_HW_MICROB,
> +=09INT33FE_HW_TYPEC,
> +};
> +
> +struct cht_int33fe_data {
> +=09struct device *dev;
> +
> +=09int (*probe)(struct cht_int33fe_data *data);
> +=09int (*remove)(struct cht_int33fe_data *data);
> +
> +=09struct i2c_client *battery_fg;
> +
> +=09/* Type-C only */
> +=09struct i2c_client *fusb302;
> +=09struct i2c_client *pi3usb30532;
> +
> +=09struct fwnode_handle *dp;
> +};
> +
> +int cht_int33fe_microb_probe(struct cht_int33fe_data *data);
> +int cht_int33fe_microb_remove(struct cht_int33fe_data *data);
> +int cht_int33fe_typec_probe(struct cht_int33fe_data *data);
> +int cht_int33fe_typec_remove(struct cht_int33fe_data *data);
> +
> +#endif /* _INTEL_CHT_INT33FE_COMMON_H */
> diff --git a/drivers/platform/x86/intel_cht_int33fe_microb.c b/drivers/pl=
atform/x86/intel_cht_int33fe_microb.c
> new file mode 100644
> index 000000000000..6b3f66065d5c
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_microb.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Cherry Trail ACPI INT33FE pseudo device driver for devices with
> + * USB Micro-B connector (e.g. without of FUSB302 USB Type-C controller)
> + *
> + * Copyright (C) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> + *
> + * At least one Intel Cherry Trail based device which ship with Windows =
10
> + * (Lenovo YogaBook YB1-X91L/F tablet), have this weird INT33FE ACPI dev=
ice
> + * with a CRS table with 2 I2cSerialBusV2 resources, for 2 different chi=
ps
> + * attached to various i2c busses:
> + * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI=
 device
> + * 2. TI BQ27542 Fuel Gauge Controller
> + *
> + * So this driver is a stub / pseudo driver whose only purpose is to
> + * instantiate i2c-client for battery fuel gauge, so that standard i2c d=
river
> + * for these chip can bind to the it.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/usb/pd.h>
> +
> +#include "intel_cht_int33fe_common.h"
> +
> +static const char * const bq27xxx_suppliers[] =3D { "bq25890-charger" };
> +
> +static const struct property_entry bq27xxx_props[] =3D {
> +=09PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq27xxx_suppliers),
> +=09{ }
> +};
> +
> +int cht_int33fe_microb_probe(struct cht_int33fe_data *data)
> +{
> +=09struct device *dev =3D data->dev;
> +=09struct i2c_board_info board_info;
> +
> +=09memset(&board_info, 0, sizeof(board_info));
> +=09strscpy(board_info.type, "bq27542", ARRAY_SIZE(board_info.type));
> +=09board_info.dev_name =3D "bq27542";
> +=09board_info.properties =3D bq27xxx_props;
> +=09data->battery_fg =3D i2c_acpi_new_device(dev, 1, &board_info);
> +
> +=09if (IS_ERR(data->battery_fg)) {
> +=09=09dev_err(dev, "Failed to register battery fuel gauge: %ld\n",
> +=09=09=09PTR_ERR(data->battery_fg));
> +=09=09return PTR_ERR(data->battery_fg);
> +=09}
> +
> +=09return 0;
> +}
> +
> +int cht_int33fe_microb_remove(struct cht_int33fe_data *data)
> +{
> +=09i2c_unregister_device(data->battery_fg);
> +
> +=09return 0;
> +}
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/=
x86/intel_cht_int33fe_typec.c
> similarity index 82%
> rename from drivers/platform/x86/intel_cht_int33fe.c
> rename to drivers/platform/x86/intel_cht_int33fe_typec.c
> index 1d5d877b9582..2d097fc2dd46 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
> @@ -17,17 +17,15 @@
>    * for these chips can bind to the them.
>    */
>  =20
> -#include <linux/acpi.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
> -#include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/usb/pd.h>
>  =20
> -#define EXPECTED_PTYPE=09=094
> +#include "intel_cht_int33fe_common.h"
>  =20
>   enum {
>   =09INT33FE_NODE_FUSB302,
> @@ -38,14 +36,6 @@ enum {
>   =09INT33FE_NODE_MAX,
>   };
>  =20
> -struct cht_int33fe_data {
> -=09struct i2c_client *max17047;
> -=09struct i2c_client *fusb302;
> -=09struct i2c_client *pi3usb30532;
> -
> -=09struct fwnode_handle *dp;
> -};
> -
>   static const struct software_node nodes[];
>  =20
>   static const struct software_node_ref_args pi3usb30532_ref =3D {
> @@ -251,43 +241,20 @@ cht_int33fe_register_max17047(struct device *dev, s=
truct cht_int33fe_data *data)
>   =09strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
>   =09board_info.dev_name =3D "max17047";
>   =09board_info.fwnode =3D fwnode;
> -=09data->max17047 =3D i2c_acpi_new_device(dev, 1, &board_info);
> +=09data->battery_fg =3D i2c_acpi_new_device(dev, 1, &board_info);
>  =20
> -=09return PTR_ERR_OR_ZERO(data->max17047);
> +=09return PTR_ERR_OR_ZERO(data->battery_fg);
>   }
>  =20
> -static int cht_int33fe_probe(struct platform_device *pdev)
> +int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
>   {
> -=09struct device *dev =3D &pdev->dev;
> +=09struct device *dev =3D data->dev;
>   =09struct i2c_board_info board_info;
> -=09struct cht_int33fe_data *data;
>   =09struct fwnode_handle *fwnode;
>   =09struct regulator *regulator;
> -=09unsigned long long ptyp;
> -=09acpi_status status;
>   =09int fusb302_irq;
>   =09int ret;
>  =20
> -=09status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &pty=
p);
> -=09if (ACPI_FAILURE(status)) {
> -=09=09dev_err(dev, "Error getting PTYPE\n");
> -=09=09return -ENODEV;
> -=09}
> -
> -=09/*
> -=09 * The same ACPI HID is used for different configurations check PTYP
> -=09 * to ensure that we are dealing with the expected config.
> -=09 */
> -=09if (ptyp !=3D EXPECTED_PTYPE)
> -=09=09return -ENODEV;
> -
> -=09/* Check presence of INT34D3 (hardware-rev 3) expected for ptype =3D=
=3D 4 */
> -=09if (!acpi_dev_present("INT34D3", "1", 3)) {
> -=09=09dev_err(dev, "Error PTYPE =3D=3D %d, but no INT34D3 device\n",
> -=09=09=09EXPECTED_PTYPE);
> -=09=09return -ENODEV;
> -=09}
> -
>   =09/*
>   =09 * We expect the WC PMIC to be paired with a TI bq24292i charger-IC.
>   =09 * We check for the bq24292i vbus regulator here, this has 2 purpose=
s:
> @@ -317,10 +284,6 @@ static int cht_int33fe_probe(struct platform_device =
*pdev)
>   =09=09return fusb302_irq;
>   =09}
>  =20
> -=09data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -=09if (!data)
> -=09=09return -ENOMEM;
> -
>   =09ret =3D cht_int33fe_add_nodes(data);
>   =09if (ret)
>   =09=09return ret;
> @@ -365,15 +328,13 @@ static int cht_int33fe_probe(struct platform_device=
 *pdev)
>   =09=09goto out_unregister_fusb302;
>   =09}
>  =20
> -=09platform_set_drvdata(pdev, data);
> -
>   =09return 0;
>  =20
>   out_unregister_fusb302:
>   =09i2c_unregister_device(data->fusb302);
>  =20
>   out_unregister_max17047:
> -=09i2c_unregister_device(data->max17047);
> +=09i2c_unregister_device(data->battery_fg);
>  =20
>   out_remove_nodes:
>   =09cht_int33fe_remove_nodes(data);
> @@ -381,36 +342,13 @@ static int cht_int33fe_probe(struct platform_device=
 *pdev)
>   =09return ret;
>   }
>  =20
> -static int cht_int33fe_remove(struct platform_device *pdev)
> +int cht_int33fe_typec_remove(struct cht_int33fe_data *data)
>   {
> -=09struct cht_int33fe_data *data =3D platform_get_drvdata(pdev);
> -
>   =09i2c_unregister_device(data->pi3usb30532);
>   =09i2c_unregister_device(data->fusb302);
> -=09i2c_unregister_device(data->max17047);
> +=09i2c_unregister_device(data->battery_fg);
>  =20
>   =09cht_int33fe_remove_nodes(data);
>  =20
>   =09return 0;
>   }
> -
> -static const struct acpi_device_id cht_int33fe_acpi_ids[] =3D {
> -=09{ "INT33FE", },
> -=09{ }
> -};
> -MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
> -
> -static struct platform_driver cht_int33fe_driver =3D {
> -=09.driver=09=3D {
> -=09=09.name =3D "Intel Cherry Trail ACPI INT33FE driver",
> -=09=09.acpi_match_table =3D ACPI_PTR(cht_int33fe_acpi_ids),
> -=09},
> -=09.probe =3D cht_int33fe_probe,
> -=09.remove =3D cht_int33fe_remove,
> -};
> -
> -module_platform_driver(cht_int33fe_driver);
> -
> -MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver=
");
> -MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> -MODULE_LICENSE("GPL v2");
>=20

