Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C97C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCADA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyP350dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCTQ4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:56:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:56:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so2899820ljk.4;
        Wed, 20 Mar 2019 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SopXWI4+FnojzE1UDMhifKT74cTHRgmw7apaWSbVH0=;
        b=RyP350dLnCgrNzW2ll/W5kK+i6CswFzshcl8S1O/ygEbQg0QyxcZiQrmjOYk/mKygi
         vaRCS3DV+f8mLAhBmwIfiVHzzI0JV31LRKRj8vWVjnjruRrUDVdGPCJK01goFDpvH8y/
         12lvRfr8u1UIYFRUu0hLz5lJaycGOzXfAd06zEHZg7OJcVMZsHwKm2cCacRfnP64ZA7W
         VCU1sxoaldDbpdo4BE3mILOTLoiQ0/B2nSp48DIRP+8qYyLUcXNNCkP4Va3u5H9M6IgB
         ni3Kn7oWYWeP2/XCnEXmZkamV5yQEWbmXfdEmBhhitJ3jux0vT07zFkGcCor/W46AHBZ
         2yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SopXWI4+FnojzE1UDMhifKT74cTHRgmw7apaWSbVH0=;
        b=kr0dBly3RYV0mgokz5I/+ljdtw4bceDs5fBVJkiUkzwzA5Vcmw9qNcxVXxXHgfqwNb
         tZfKj1BiyG7ArBWDOHbIvnJpiboho6TBFz6BWrpNMpHVRSqWEbsP85/Oi5z8ZmsxNCCY
         48QG0dImoQJwwn1VuSlQpYdfvBz/t/JClyCSz5IY+XYtHWI4Paz17zpCZ45CsnZIbU6h
         xzXUxWM59wIzW4XtTTvxXGCQPZXwNGCQk2T8Bfi6zm70AShB3Q6Kg/P7T8D3OWsnGmqG
         +/C/rnxXntvjdzcFphbNhxTBBquNe2RNEVsYyo8TnHCnFSmHhfTtYGyOZm12sPC6qeb4
         vrbg==
X-Gm-Message-State: APjAAAU0oBqFWzGbSUGuzyBE0iDHQ+AykK3TySej+48Wz2OFl05SCeNH
        HsQp+nLTWdSbdAa6ekZ4q4s=
X-Google-Smtp-Source: APXvYqySaPnzxQ23ghiWeVTnCz7dowJyBqlZaMvjqfof8GXh2w2tTjTnpH7OY1LKQ7+IWgoe0QWOgA==
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr6330881ljh.118.1553100962872;
        Wed, 20 Mar 2019 09:56:02 -0700 (PDT)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:4d68:5734:4ddd:8dbe])
        by smtp.gmail.com with ESMTPSA id s26sm426943ljj.52.2019.03.20.09.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 09:56:01 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH 2/2] extcon: Add fsa9480 extcon driver
Date:   Wed, 20 Mar 2019 17:56:00 +0100
Message-ID: <3709772.JujWszgv7K@acerlaptop>
In-Reply-To: <cf4b529c-2c04-96fc-3d83-289dea3bd7eb@samsung.com>
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com> <20190225165822.2770-3-pawel.mikolaj.chmiel@gmail.com> <cf4b529c-2c04-96fc-3d83-289dea3bd7eb@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia=C5=82ek, 18 marca 2019 11:47:38 CET Chanwoo Choi wrote:
> Hi,
>=20
> Sorry for late reply.
Thanks for review. I'll fix all issues and submit v2 version of patches.
>=20
> On 19. 2. 26. =EC=98=A4=EC=A0=84 1:58, Pawe=C5=82 Chmiel wrote:
> > From: Tomasz Figa <tomasz.figa@gmail.com>
> >=20
> > This patch adds extcon driver for Fairchild Semiconductor FSA9480
> > microUSB switch.
> >=20
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/extcon/Kconfig          |  10 +
> >  drivers/extcon/Makefile         |   1 +
> >  drivers/extcon/extcon-fsa9480.c | 473 ++++++++++++++++++++++++++++++++
> >  3 files changed, 484 insertions(+)
> >  create mode 100644 drivers/extcon/extcon-fsa9480.c
> >=20
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index de15bf55895b..9904f993d39a 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -36,6 +36,16 @@ config EXTCON_AXP288
> >  	  Say Y here to enable support for USB peripheral detection
> >  	  and USB MUX switching by X-Power AXP288 PMIC.
> > =20
> > +config EXTCON_FSA9480
> > +	tristate "FSA9480 EXTCON Support"
> > +	depends on INPUT
>=20
> I add the comment about I2C interface. If you use the REGMAP_I2C,
> please add the proper dependency to prevent the build error.
>=20
> > +	help
> > +	  If you say yes here you get support for the Fairchild Semiconductor
> > +	  FSA9480 microUSB switch and accessory detector chip. The FSA9480 is=
 a USB
> > +	  port accessory detector and switch. The FSA9480 is fully controlled=
 using
> > +	  I2C and enables USB data, stereo and mono audio, video, microphone
> > +	  and UART data to use a common connector port.
> > +
> >  config EXTCON_GPIO
> >  	tristate "GPIO extcon support"
> >  	depends on GPIOLIB || COMPILE_TEST
> > diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> > index 0888fdeded72..0a3a96d92a28 100644
> > --- a/drivers/extcon/Makefile
> > +++ b/drivers/extcon/Makefile
> > @@ -8,6 +8,7 @@ extcon-core-objs		+=3D extcon.o devres.o
> >  obj-$(CONFIG_EXTCON_ADC_JACK)	+=3D extcon-adc-jack.o
> >  obj-$(CONFIG_EXTCON_ARIZONA)	+=3D extcon-arizona.o
> >  obj-$(CONFIG_EXTCON_AXP288)	+=3D extcon-axp288.o
> > +obj-$(CONFIG_EXTCON_FSA9480)	+=3D extcon-fsa9480.o
> >  obj-$(CONFIG_EXTCON_GPIO)	+=3D extcon-gpio.o
> >  obj-$(CONFIG_EXTCON_INTEL_INT3496) +=3D extcon-intel-int3496.o
> >  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) +=3D extcon-intel-cht-wc.o
> > diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fs=
a9480.c
> > new file mode 100644
> > index 000000000000..5c58f3e3f0e4
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-fsa9480.c
> > @@ -0,0 +1,473 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * extcon-fsa9480.c - Fairchild Semiconductor FSA9480 extcon driver
> > + *
> > + * Copyright (c) 2014 Tomasz Figa <tomasz.figa@gmail.com>
> > + *
> > + * Loosely based on old fsa9480 misc-device driver.
> > + *
>=20
> This driver keep the 'SPDX' license rule. So, you don't need
> following license sentences. Please remove them.
>=20
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/i2c.h>
> > +#include <linux/slab.h>
> > +#include <linux/bitops.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/kobject.h>
> > +#include <linux/extcon-provider.h>
> > +#include <linux/irqdomain.h>
> > +
> > +/* FSA9480 I2C registers */
> > +#define FSA9480_REG_DEVID               0x01
> > +#define FSA9480_REG_CTRL                0x02
> > +#define FSA9480_REG_INT1                0x03
> > +#define FSA9480_REG_INT2                0x04
> > +#define FSA9480_REG_INT1_MASK           0x05
> > +#define FSA9480_REG_INT2_MASK           0x06
> > +#define FSA9480_REG_ADC                 0x07
> > +#define FSA9480_REG_TIMING1             0x08
> > +#define FSA9480_REG_TIMING2             0x09
> > +#define FSA9480_REG_DEV_T1              0x0a
> > +#define FSA9480_REG_DEV_T2              0x0b
> > +#define FSA9480_REG_BTN1                0x0c
> > +#define FSA9480_REG_BTN2                0x0d
> > +#define FSA9480_REG_CK                  0x0e
> > +#define FSA9480_REG_CK_INT1             0x0f
> > +#define FSA9480_REG_CK_INT2             0x10
> > +#define FSA9480_REG_CK_INTMASK1         0x11
> > +#define FSA9480_REG_CK_INTMASK2         0x12
> > +#define FSA9480_REG_MANSW1              0x13
> > +#define FSA9480_REG_MANSW2              0x14
> > +
> > +/* Control */
> > +#define CON_SWITCH_OPEN         (1 << 4)
> > +#define CON_RAW_DATA            (1 << 3)
> > +#define CON_MANUAL_SW           (1 << 2)
> > +#define CON_WAIT                (1 << 1)
> > +#define CON_INT_MASK            (1 << 0)
> > +#define CON_MASK                (CON_SWITCH_OPEN | CON_RAW_DATA | \
> > +				 CON_MANUAL_SW | CON_WAIT)
> > +
> > +/* Device Type 1 */
> > +#define DEV_USB_OTG             7
> > +#define DEV_DEDICATED_CHG       6
> > +#define DEV_USB_CHG             5
> > +#define DEV_CAR_KIT             4
> > +#define DEV_UART                3
> > +#define DEV_USB                 2
> > +#define DEV_AUDIO_2             1
> > +#define DEV_AUDIO_1             0
> > +
> > +#define DEV_T1_USB_MASK         (DEV_USB_OTG | DEV_USB)
> > +#define DEV_T1_UART_MASK        (DEV_UART)
> > +#define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
> > +
> > +/* Device Type 2 */
> > +#define DEV_AV                  14
> > +#define DEV_TTY                 13
> > +#define DEV_PPD                 12
> > +#define DEV_JIG_UART_OFF        11
> > +#define DEV_JIG_UART_ON         10
> > +#define DEV_JIG_USB_OFF         9
> > +#define DEV_JIG_USB_ON          8
> > +
> > +#define DEV_T2_USB_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON)
> > +#define DEV_T2_UART_MASK        (DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> > +#define DEV_T2_JIG_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON | \
> > +				 DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> > +
> > +/*
> > + * Manual Switch
> > + * D- [7:5] / D+ [4:2]
> > + * 000: Open all / 001: USB / 010: AUDIO / 011: UART / 100: V_AUDIO
> > + */
> > +#define SW_VAUDIO               ((4 << 5) | (4 << 2))
> > +#define SW_UART                 ((3 << 5) | (3 << 2))
> > +#define SW_AUDIO                ((2 << 5) | (2 << 2))
> > +#define SW_DHOST                ((1 << 5) | (1 << 2))
> > +#define SW_AUTO                 ((0 << 5) | (0 << 2))
> > +
> > +/* Interrupt 1 */
> > +#define INT1_MASK               (0xff << 0)
> > +#define INT_DETACH              (1 << 1)
> > +#define INT_ATTACH              (1 << 0)
> > +
> > +/* Interrupt 2 mask */
> > +#define INT2_MASK               (0x1f << 0)
> > +
> > +/* Timing Set 1 */
> > +#define TIMING1_ADC_500MS       (0x6 << 0)
> > +
> > +struct fsa9480_usbsw {
> > +	struct i2c_client *client;
>=20
> Usually, many device drivers uses the REGMAP_I2C instead of
> using the i2c API directly. I recommend you use regmap interface.
>=20
>=20
> > +	struct extcon_dev *edev;
> > +	u16 dev;
> > +	u16 mansw;
> > +};
> > +
> > +static const unsigned int fsa9480_extcon_cable[] =3D {
> > +	EXTCON_USB_HOST,
> > +	EXTCON_USB,
> > +	EXTCON_CHG_USB_DCP,
> > +	EXTCON_CHG_USB_SDP,
> > +	EXTCON_CHG_USB_ACA,
> > +	EXTCON_JACK_LINE_OUT,
> > +	EXTCON_JACK_VIDEO_OUT,
> > +	EXTCON_JIG,
> > +
> > +	EXTCON_NONE,
> > +};
> > +
> > +static const u64 cable_types[] =3D {
> > +	[DEV_USB_OTG] =3D BIT_ULL(EXTCON_USB_HOST),
> > +	[DEV_DEDICATED_CHG] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_=
DCP),
> > +	[DEV_USB_CHG] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
> > +	[DEV_CAR_KIT] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP)
> > +			| BIT_ULL(EXTCON_JACK_LINE_OUT),
> > +	[DEV_UART] =3D BIT_ULL(EXTCON_JIG),
> > +	[DEV_USB] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
> > +	[DEV_AUDIO_2] =3D BIT_ULL(EXTCON_JACK_LINE_OUT),
> > +	[DEV_AUDIO_1] =3D BIT_ULL(EXTCON_JACK_LINE_OUT),
> > +	[DEV_AV] =3D BIT_ULL(EXTCON_JACK_LINE_OUT)
> > +		   | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
> > +	[DEV_TTY] =3D BIT_ULL(EXTCON_JIG),
> > +	[DEV_PPD] =3D BIT_ULL(EXTCON_JACK_LINE_OUT) | BIT_ULL(EXTCON_CHG_USB_=
ACA),
> > +	[DEV_JIG_UART_OFF] =3D BIT_ULL(EXTCON_JIG),
> > +	[DEV_JIG_UART_ON] =3D BIT_ULL(EXTCON_JIG),
> > +	[DEV_JIG_USB_OFF] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
> > +	[DEV_JIG_USB_ON] =3D BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
> > +};
> > +
> > +static int fsa9480_write_reg(struct i2c_client *client, int reg, int v=
alue)
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client, reg, value);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int fsa9480_read_reg(struct i2c_client *client, int reg)
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(client, reg);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int fsa9480_read_irq(struct i2c_client *client, int *value)
> > +{
> > +	u8 regs[2];
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_i2c_block_data(client, FSA9480_REG_INT1, 2, re=
gs);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> > +
> > +	*value =3D regs[1] << 8 | regs[0];
> > +	return ret;
> > +}
> > +
> > +static void fsa9480_set_switch(struct i2c_client *client, const char *=
buf)
> > +{
> > +	struct  fsa9480_usbsw *usbsw =3D i2c_get_clientdata(client);
> > +	unsigned int value;
> > +	unsigned int path =3D 0;
> > +
> > +	value =3D fsa9480_read_reg(client, FSA9480_REG_CTRL);
> > +
> > +	if (!strncmp(buf, "VAUDIO", 6)) {
> > +		path =3D SW_VAUDIO;
> > +		value &=3D ~CON_MANUAL_SW;
> > +	} else if (!strncmp(buf, "UART", 4)) {
> > +		path =3D SW_UART;
> > +		value &=3D ~CON_MANUAL_SW;
> > +	} else if (!strncmp(buf, "AUDIO", 5)) {
> > +		path =3D SW_AUDIO;
> > +		value &=3D ~CON_MANUAL_SW;
> > +	} else if (!strncmp(buf, "DHOST", 5)) {
> > +		path =3D SW_DHOST;
> > +		value &=3D ~CON_MANUAL_SW;
> > +	} else if (!strncmp(buf, "AUTO", 4)) {
> > +		path =3D SW_AUTO;
> > +		value |=3D CON_MANUAL_SW;
> > +	} else {
> > +		dev_err(&client->dev, "Wrong command\n");
> > +		return;
> > +	}
> > +
> > +	usbsw->mansw =3D path;
> > +	fsa9480_write_reg(client, FSA9480_REG_MANSW1, path);
> > +	fsa9480_write_reg(client, FSA9480_REG_CTRL, value);
> > +}
> > +
> > +static ssize_t fsa9480_get_switch(struct i2c_client *client, char *buf)
> > +{
> > +	unsigned int value;
> > +
> > +	value =3D fsa9480_read_reg(client, FSA9480_REG_MANSW1);
> > +
> > +	if (value =3D=3D SW_VAUDIO)
> > +		return sprintf(buf, "VAUDIO\n");
> > +	else if (value =3D=3D SW_UART)
> > +		return sprintf(buf, "UART\n");
> > +	else if (value =3D=3D SW_AUDIO)
> > +		return sprintf(buf, "AUDIO\n");
> > +	else if (value =3D=3D SW_DHOST)
> > +		return sprintf(buf, "DHOST\n");
> > +	else if (value =3D=3D SW_AUTO)
> > +		return sprintf(buf, "AUTO\n");
> > +	else
> > +		return sprintf(buf, "%x", value);
> > +}
> > +
> > +static ssize_t fsa9480_manualsw_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > +	return fsa9480_get_switch(client, buf);
> > +
> > +}
> > +
> > +static ssize_t fsa9480_manualsw_set(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > +	fsa9480_set_switch(client, buf);
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(switch, 0644,
> > +		   fsa9480_manualsw_show, fsa9480_manualsw_set);
> > +
> > +static struct attribute *fsa9480_attributes[] =3D {
> > +	&dev_attr_switch.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group fsa9480_group =3D {
> > +	.attrs	=3D fsa9480_attributes,
> > +};
>=20
> Unfortunately, we have to export the some attribute
> from linux framework. I think that it is not proper
> to add the specific sysfs entry for only one device driver.
>=20
> If you want to add the new sysfs entry, please contribue
> the extcon framework for all extcon device drivers.
>=20
> Please remove it.
>=20
> > +
> > +static void fsa9480_handle_change(struct fsa9480_usbsw *usbsw,
> > +				  u16 mask, bool attached)
> > +{
> > +	while (mask) {
> > +		int dev =3D fls64(mask) - 1;
> > +		u64 cables =3D cable_types[dev];
> > +
> > +		while (cables) {
> > +			int cable =3D fls64(cables) - 1;
> > +
> > +			extcon_set_state_sync(usbsw->edev, cable, attached);
> > +			cables &=3D ~BIT_ULL(cable);
> > +		}
> > +
> > +		mask &=3D ~BIT_ULL(dev);
> > +	}
> > +}
> > +
> > +static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw)
> > +{
> > +	struct i2c_client *client =3D usbsw->client;
> > +	int val1, val2;
> > +	u16 val;
> > +
> > +	val1 =3D fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
> > +	val2 =3D fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
> > +	if (val1 < 0 || val2 < 0) {
> > +		dev_err(&client->dev, "%s: failed to read registers", __func__);
> > +		return;
> > +	}
> > +	val =3D val2 << 8 | val1;
> > +
> > +	dev_info(&client->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
> > +
> > +	if (usbsw->mansw && (val1 & DEV_T1_USB_MASK || val2 & DEV_T2_USB_MASK=
))
> > +		fsa9480_write_reg(client, FSA9480_REG_MANSW1, usbsw->mansw);
> > +
> > +	/* handle detached cables first */
> > +	fsa9480_handle_change(usbsw, usbsw->dev & ~val, false);
> > +
> > +	/* then handle attached ones */
> > +	fsa9480_handle_change(usbsw, val & ~usbsw->dev, true);
> > +
> > +	usbsw->dev =3D val;
> > +}
> > +
> > +static irqreturn_t fsa9480_irq_handler(int irq, void *data)
> > +{
> > +	struct fsa9480_usbsw *usbsw =3D data;
> > +	struct i2c_client *client =3D usbsw->client;
> > +	int intr =3D 0;
> > +
> > +	/* clear interrupt */
> > +	fsa9480_read_irq(client, &intr);
> > +	if (!intr)
> > +		return IRQ_NONE;
> > +
> > +	/* device detection */
> > +	fsa9480_detect_dev(usbsw);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int fsa9480_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct fsa9480_usbsw *info;
> > +	int ret;
> > +
> > +	if (!client->irq) {
> > +		dev_err(&client->dev, "no interrupt provided\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	info =3D devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +	info->client =3D client;
> > +
> > +	i2c_set_clientdata(client, info);
> > +
> > +	/* External connector */
> > +	info->edev =3D devm_extcon_dev_allocate(&client->dev,
> > +					      fsa9480_extcon_cable);
> > +	if (IS_ERR(info->edev)) {
> > +		dev_err(&client->dev, "failed to allocate memory for extcon\n");
> > +		ret =3D -ENOMEM;
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_extcon_dev_register(&client->dev, info->edev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to register extcon device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* ADC Detect Time: 500ms */
> > +	fsa9480_write_reg(client, FSA9480_REG_TIMING1, TIMING1_ADC_500MS);
> > +
> > +	/* configure automatic switching */
> > +	fsa9480_write_reg(client, FSA9480_REG_CTRL, CON_MASK);
> > +
> > +	/* unmask interrupt (attach/detach only) */
> > +	fsa9480_write_reg(client, FSA9480_REG_INT1_MASK,
> > +			  INT1_MASK & ~(INT_ATTACH | INT_DETACH));
> > +	fsa9480_write_reg(client, FSA9480_REG_INT2_MASK, INT2_MASK);
> > +
> > +	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > +					fsa9480_irq_handler,
> > +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +					"fsa9480", info);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to request IRQ\n");
> > +		return ret;
> > +	}
> > +
> > +	device_init_wakeup(&client->dev, true);
> > +	fsa9480_detect_dev(info);
> > +
> > +	ret =3D sysfs_create_group(&client->dev.kobj, &fsa9480_group);
>=20
> Please remove it.
>=20
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			"failed to create fsa9480 attribute group\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsa9480_remove(struct i2c_client *client)
> > +{
> > +	sysfs_remove_group(&client->dev.kobj, &fsa9480_group);
>=20
> Please remove it.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int fsa9480_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(&client->dev) && client->irq)
> > +		enable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsa9480_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(&client->dev) && client->irq)
> > +		disable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops fsa9480_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(fsa9480_suspend, fsa9480_resume)
> > +};
> > +
> > +static const struct i2c_device_id fsa9480_id[] =3D {
> > +	{ "fsa9480", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, fsa9480_id);
> > +
> > +static const struct of_device_id fsa9480_of_match[] =3D {
> > +	{ .compatible =3D "fcs,fsa9480", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, fsa9480_of_match);
> > +
> > +static struct i2c_driver fsa9480_i2c_driver =3D {
> > +	.driver			=3D {
> > +		.name		=3D "fsa9480",
> > +		.pm		=3D &fsa9480_pm_ops,
> > +		.of_match_table =3D fsa9480_of_match,
> > +	},
> > +	.probe			=3D fsa9480_probe,
> > +	.remove			=3D fsa9480_remove,
> > +	.id_table		=3D fsa9480_id,
> > +};
> > +
> > +static int __init fsa9480_module_init(void)
> > +{
> > +	return i2c_add_driver(&fsa9480_i2c_driver);
> > +}
> > +subsys_initcall(fsa9480_module_init);
> > +
> > +static void __exit fsa9480_module_exit(void)
> > +{
> > +	i2c_del_driver(&fsa9480_i2c_driver);
> > +}
> > +module_exit(fsa9480_module_exit);
> > +
> > +MODULE_DESCRIPTION("Fairchild Semiconductor FSA9480 extcon driver");
> > +MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
> > +MODULE_LICENSE("GPL");
> >=20
>=20
>=20
>=20




