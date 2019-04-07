Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF353C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBDF213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="v1+sqe/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDGTIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:08:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35002 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554664082; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QzbgrNOr9ePOxkeMkKdLDlZLH0PI1dv64gXFB2ByNE=;
        b=v1+sqe/Cao1hLKNdHxLqLuUGdiB5951HW7sWySM8qbXKa7PCCWE4XYfQygMTkPiaxUF0vv
        kllLfa5e6c7cGnDEChg9j6HBfl0YK3vZOD5riFhvJ1UaKRnmiZ9VL+5ZFtbNGNivq9SRe2
        p4CcVkK89crCzhkc8nAl+SjknDi9dtA=
Date:   Sun, 07 Apr 2019 21:07:57 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1554664077.4322.0@crapouillou.net>
In-Reply-To: <20190407165234.is66vmnjfc35jnho@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-4-contact@artur-rojek.eu>
        <20190324153137.04857cdf@archlinux>
        <20190407165234.is66vmnjfc35jnho@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Le dim. 7 avril 2019 =E0 18:52, Sebastian Reichel <sre@kernel.org> a=20
=E9crit :
> Hi,
>=20
> On Sun, Mar 24, 2019 at 03:31:37PM +0000, Jonathan Cameron wrote:
>>  On Sat, 23 Mar 2019 18:28:09 +0100
>>  Artur Rojek <contact@artur-rojek.eu> wrote:
>>=20
>>  > Add a driver for battery present on Ingenic JZ47xx SoCs.
>>  >
>>  > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  The IIO parts look fine to me.
>>  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>=20
>>  Sebastian, assuming you are happy with this version,
>=20
> The driver itself looks ok. I'm a bit unhappy, that we already have
> jz4740-battery. This driver is much cleaner, but does not yet seem
> to be ready to replace it. Artur Rojek what are your plans regarding
> to the existing driver? Is there currently work going on migrating
> JZ47xx to DT?

Why do you think it's not ready? Feature-wise, it has everything we
need to replace jz4740-battery, which will be trashed as soon as the
LB60 board code is updated to use the new driver.

We are working on porting the JZ47xx code to devicetree, yes. The
ultimate goal is to completely get rid of
arch/mips/jz4740/board-qi_lb60.c and arch/mips/jz4740/platform.c.

>>  do you have any preference for how we handle this series?
>>=20
>>  Probably needs one of us to do an immutable branch with just this
>>  in it.  I'm happy to do so once all the relevant Acks etc are in
>>  place, but don't mind if you want to!
>=20
> I suppose you could provide an immutable branch with just the first
> two patches in it. Then I can pull it and apply the power-supply
> patches on top.
>=20
> -- Sebastian
>=20
>>  Thanks,
>>=20
>>  Jonathan
>>=20
>>  > ---
>>  >
>>  > Changes:
>>  >
>>  > v2: - rework the return logic in ingenic_battery_get_property,
>>  >     - make index offsets point forward in=20
>> ingenic_battery_set_scale,
>>  >     - fix spacing around scale_raw[best_idx + 1]
>>  >
>>  >  drivers/power/supply/Kconfig           |  11 ++
>>  >  drivers/power/supply/Makefile          |   1 +
>>  >  drivers/power/supply/ingenic-battery.c | 180=20
>> +++++++++++++++++++++++++
>>  >  3 files changed, 192 insertions(+)
>>  >  create mode 100644 drivers/power/supply/ingenic-battery.c
>>  >
>>  > diff --git a/drivers/power/supply/Kconfig=20
>> b/drivers/power/supply/Kconfig
>>  > index e901b9879e7e..9bfb1637ec28 100644
>>  > --- a/drivers/power/supply/Kconfig
>>  > +++ b/drivers/power/supply/Kconfig
>>  > @@ -169,6 +169,17 @@ config BATTERY_COLLIE
>>  >  	  Say Y to enable support for the battery on the Sharp Zaurus
>>  >  	  SL-5500 (collie) models.
>>  >
>>  > +config BATTERY_INGENIC
>>  > +	tristate "Ingenic JZ47xx SoCs battery driver"
>>  > +	depends on MIPS || COMPILE_TEST
>>  > +	depends on INGENIC_ADC
>>  > +	help
>>  > +	  Choose this option if you want to monitor battery status on
>>  > +	  Ingenic JZ47xx SoC based devices.
>>  > +
>>  > +	  This driver can also be built as a module. If so, the module=20
>> will be
>>  > +	  called ingenic-battery.
>>  > +
>>  >  config BATTERY_IPAQ_MICRO
>>  >  	tristate "iPAQ Atmel Micro ASIC battery driver"
>>  >  	depends on MFD_IPAQ_MICRO
>>  > diff --git a/drivers/power/supply/Makefile=20
>> b/drivers/power/supply/Makefile
>>  > index b731c2a9b695..9e2c481d0187 100644
>>  > --- a/drivers/power/supply/Makefile
>>  > +++ b/drivers/power/supply/Makefile
>>  > @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
>>  >  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
>>  >  obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
>>  >  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
>>  > +obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
>>  >  obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
>>  >  obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
>>  >  obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
>>  > diff --git a/drivers/power/supply/ingenic-battery.c=20
>> b/drivers/power/supply/ingenic-battery.c
>>  > new file mode 100644
>>  > index 000000000000..822aee1c7b64
>>  > --- /dev/null
>>  > +++ b/drivers/power/supply/ingenic-battery.c
>>  > @@ -0,0 +1,180 @@
>>  > +// SPDX-License-Identifier: GPL-2.0
>>  > +/*
>>  > + * Battery driver for the Ingenic JZ47xx SoCs
>>  > + * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
>>  > + *
>>  > + * based on drivers/power/supply/jz4740-battery.c
>>  > + */
>>  > +
>>  > +#include <linux/iio/consumer.h>
>>  > +#include <linux/module.h>
>>  > +#include <linux/of.h>
>>  > +#include <linux/platform_device.h>
>>  > +#include <linux/power_supply.h>
>>  > +#include <linux/property.h>
>>  > +
>>  > +struct ingenic_battery {
>>  > +	struct device *dev;
>>  > +	struct iio_channel *channel;
>>  > +	struct power_supply_desc desc;
>>  > +	struct power_supply *battery;
>>  > +	struct power_supply_battery_info info;
>>  > +};
>>  > +
>>  > +static int ingenic_battery_get_property(struct power_supply *psy,
>>  > +					enum power_supply_property psp,
>>  > +					union power_supply_propval *val)
>>  > +{
>>  > +	struct ingenic_battery *bat =3D power_supply_get_drvdata(psy);
>>  > +	struct power_supply_battery_info *info =3D &bat->info;
>>  > +	int ret;
>>  > +
>>  > +	switch (psp) {
>>  > +	case POWER_SUPPLY_PROP_HEALTH:
>>  > +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
>>  > +		val->intval *=3D 1000;
>>  > +		if (val->intval < info->voltage_min_design_uv)
>>  > +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
>>  > +		else if (val->intval > info->voltage_max_design_uv)
>>  > +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>>  > +		else
>>  > +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
>>  > +		return ret;
>>  > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>  > +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
>>  > +		val->intval *=3D 1000;
>>  > +		return ret;
>>  > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>  > +		val->intval =3D info->voltage_min_design_uv;
>>  > +		return 0;
>>  > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>  > +		val->intval =3D info->voltage_max_design_uv;
>>  > +		return 0;
>>  > +	default:
>>  > +		return -EINVAL;
>>  > +	};
>>  > +}
>>  > +
>>  > +/* Set the most appropriate IIO channel voltage reference scale
>>  > + * based on the battery's max voltage.
>>  > + */
>>  > +static int ingenic_battery_set_scale(struct ingenic_battery *bat)
>>  > +{
>>  > +	const int *scale_raw;
>>  > +	int scale_len, scale_type, best_idx =3D -1, best_mV, max_raw, i,=20
>> ret;
>>  > +	u64 max_mV;
>>  > +
>>  > +	ret =3D iio_read_max_channel_raw(bat->channel, &max_raw);
>>  > +	if (ret) {
>>  > +		dev_err(bat->dev, "Unable to read max raw channel value\n");
>>  > +		return ret;
>>  > +	}
>>  > +
>>  > +	ret =3D iio_read_avail_channel_attribute(bat->channel, &scale_raw,
>>  > +					       &scale_type, &scale_len,
>>  > +					       IIO_CHAN_INFO_SCALE);
>>  > +	if (ret < 0) {
>>  > +		dev_err(bat->dev, "Unable to read channel avail scale\n");
>>  > +		return ret;
>>  > +	}
>>  > +	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D=20
>> IIO_VAL_FRACTIONAL_LOG2)
>>  > +		return -EINVAL;
>>  > +
>>  > +	max_mV =3D bat->info.voltage_max_design_uv / 1000;
>>  > +
>>  > +	for (i =3D 0; i < scale_len; i +=3D 2) {
>>  > +		u64 scale_mV =3D (max_raw * scale_raw[i]) >> scale_raw[i + 1];
>>  > +
>>  > +		if (scale_mV < max_mV)
>>  > +			continue;
>>  > +
>>  > +		if (best_idx >=3D 0 && scale_mV > best_mV)
>>  > +			continue;
>>  > +
>>  > +		best_mV =3D scale_mV;
>>  > +		best_idx =3D i;
>>  > +	}
>>  > +
>>  > +	if (best_idx < 0) {
>>  > +		dev_err(bat->dev, "Unable to find matching voltage scale\n");
>>  > +		return -EINVAL;
>>  > +	}
>>  > +
>>  > +	return iio_write_channel_attribute(bat->channel,
>>  > +					   scale_raw[best_idx],
>>  > +					   scale_raw[best_idx + 1],
>>  > +					   IIO_CHAN_INFO_SCALE);
>>  > +}
>>  > +
>>  > +static enum power_supply_property ingenic_battery_properties[] =3D=20
>> {
>>  > +	POWER_SUPPLY_PROP_HEALTH,
>>  > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>  > +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>  > +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>>  > +};
>>  > +
>>  > +static int ingenic_battery_probe(struct platform_device *pdev)
>>  > +{
>>  > +	struct device *dev =3D &pdev->dev;
>>  > +	struct ingenic_battery *bat;
>>  > +	struct power_supply_config psy_cfg =3D {};
>>  > +	struct power_supply_desc *desc;
>>  > +	int ret;
>>  > +
>>  > +	bat =3D devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
>>  > +	if (!bat)
>>  > +		return -ENOMEM;
>>  > +
>>  > +	bat->dev =3D dev;
>>  > +	bat->channel =3D devm_iio_channel_get(dev, "battery");
>>  > +	if (IS_ERR(bat->channel))
>>  > +		return PTR_ERR(bat->channel);
>>  > +
>>  > +	desc =3D &bat->desc;
>>  > +	desc->name =3D "jz-battery";
>>  > +	desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
>>  > +	desc->properties =3D ingenic_battery_properties;
>>  > +	desc->num_properties =3D ARRAY_SIZE(ingenic_battery_properties);
>>  > +	desc->get_property =3D ingenic_battery_get_property;
>>  > +	psy_cfg.drv_data =3D bat;
>>  > +	psy_cfg.of_node =3D dev->of_node;
>>  > +
>>  > +	bat->battery =3D devm_power_supply_register(dev, desc, &psy_cfg);
>>  > +	if (IS_ERR(bat->battery)) {
>>  > +		dev_err(dev, "Unable to register battery\n");
>>  > +		return PTR_ERR(bat->battery);
>>  > +	}
>>  > +
>>  > +	ret =3D power_supply_get_battery_info(bat->battery, &bat->info);
>>  > +	if (ret) {
>>  > +		dev_err(dev, "Unable to get battery info: %d\n", ret);
>>  > +		return ret;
>>  > +	}
>>  > +	if (bat->info.voltage_min_design_uv < 0) {
>>  > +		dev_err(dev, "Unable to get voltage min design\n");
>>  > +		return bat->info.voltage_min_design_uv;
>>  > +	}
>>  > +	if (bat->info.voltage_max_design_uv < 0) {
>>  > +		dev_err(dev, "Unable to get voltage max design\n");
>>  > +		return bat->info.voltage_max_design_uv;
>>  > +	}
>>  > +
>>  > +	return ingenic_battery_set_scale(bat);
>>  > +}
>>  > +
>>  > +#ifdef CONFIG_OF
>>  > +static const struct of_device_id ingenic_battery_of_match[] =3D {
>>  > +	{ .compatible =3D "ingenic,jz4740-battery", },
>>  > +	{ },
>>  > +};
>>  > +MODULE_DEVICE_TABLE(of, ingenic_battery_of_match);
>>  > +#endif
>>  > +
>>  > +static struct platform_driver ingenic_battery_driver =3D {
>>  > +	.driver =3D {
>>  > +		.name =3D "ingenic-battery",
>>  > +		.of_match_table =3D of_match_ptr(ingenic_battery_of_match),
>>=20
>>  I guess we can be fairly sure no one will even user this with ACPI
>>  (magic DT) bindings?  That would make this a rare case where the
>>  of_match_pr protection and ifdef fun is still fine.
>>=20
>>=20
>>  > +	},
>>  > +	.probe =3D ingenic_battery_probe,
>>  > +};
>>  > +module_platform_driver(ingenic_battery_driver);
>>=20

=

