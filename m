Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08627C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521420673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZTcrOnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF3RQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:16:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45610 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3RQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:16:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so7101884lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9rNQOD8km8vdYp8DxhWTjDHTfMtkLWGsHr+/bHwal0=;
        b=DZTcrOnfZsozMxm4bJ8IdiQaaC+ND7rW/rJZeNKNrSPsZXVt7CBREdXP7CFlAXreK5
         C04pLNyLONr9JIDHza9Y5jzmEcu2ku6HkStHe7JIwjE29RDy9rZzHPYQ4rUUETvfpIuM
         fmHb8Y3mMtSlpm+g+O4TYG7XJoTT6lFc8BNd+cokN+LBwIZcdRn5EdVYxKOClj3E0ctJ
         iqKM197Xh1FfvPMNllYDSCFNbOmzqzbrmy5EQmKyV2O7aj8x0rjlvcdwJst3Yt5V+o1S
         v3POItYenr6tQax9dLWW1AMvB7aiO8lhrI0Da1LF9QtgFQac7b/1U10Eh/jqfLpLtT9P
         LrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9rNQOD8km8vdYp8DxhWTjDHTfMtkLWGsHr+/bHwal0=;
        b=sqieT1bq3I/ZoXxCJupu/MHaZwY6IbwkUUiZ28I4C5TwhbUwZU2wI+KCDer4tLQ+qL
         Aruili6hf/cUKMTwRddxBI5JTDOckav4wpxNAZLdevVBBrNyRZb9jn7qXeBcBD7GkFxD
         iAIwu99dfTXq8JxjyJXRNLX3Z+GtcVSvEVYb1igeDZXDbylAAJgyMRcLHLgWnbUPLJCx
         S507S/ebP7K37wEjmSZdmWtyIRmJlwseQxh8jb6hHT4CbV73EKeZhEsESdYAUdl1mk57
         PbXtgBR0eb4VpElxEw9EMAKJBZytgroZ9JW7UD5HMn9QbeG9K8TUUqHEndrd5hvODQK1
         jSWg==
X-Gm-Message-State: APjAAAU3jyGSiAJAemTXBN5kh1oJ0SYKwgxGqMrTVVgA+O9CLNdzsIcy
        MP6dTyLsa5WnA4PtVS8cqKVk9Ormq0A=
X-Google-Smtp-Source: APXvYqwUiymWNuOwnlGvtSW2Vx2N7NdG+LGerpD1fG8BhmxBwzl5JQ9MAThbX4gNCsBpzpJkxI9r3A==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr4715419lfl.9.1561914989927;
        Sun, 30 Jun 2019 10:16:29 -0700 (PDT)
Received: from pablo-laptop ([2a02:a315:5445:5300:2177:4817:659:9c2a])
        by smtp.googlemail.com with ESMTPSA id f16sm2506179lfc.81.2019.06.30.10.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 10:16:29 -0700 (PDT)
Message-ID: <e8c2130831dfac42d301e3fe5f614117aabb8a76.camel@gmail.com>
Subject: Re: [PATCH] misc: fsa9480: Delete this driver
From:   =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>
Date:   Sun, 30 Jun 2019 19:16:27 +0200
In-Reply-To: <20190630140302.16245-1-linus.walleij@linaro.org>
References: <20190630140302.16245-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-30 at 16:03 +0200, Linus Walleij wrote:
> The FSA9480 has a new driver more appropriately located
> in the drivers/extcon subsystem. It is also more complete
> and includes device tree support. Delete the old misc
> driver.
> 
> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/misc/Kconfig                  |   9 -
>  drivers/misc/Makefile                 |   1 -
>  drivers/misc/fsa9480.c                | 547 --------------------------
>  include/linux/platform_data/fsa9480.h |  24 --
>  4 files changed, 581 deletions(-)
>  delete mode 100644 drivers/misc/fsa9480.c
>  delete mode 100644 include/linux/platform_data/fsa9480.h
Hi

Reviewed-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Thanks
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 85fc77148d19..88e59bb1b06f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -431,15 +431,6 @@ config PCH_PHUB
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called pch_phub.
>  
> -config USB_SWITCH_FSA9480
> -	tristate "FSA9480 USB Switch"
> -	depends on I2C
> -	help
> -	  The FSA9480 is a USB port accessory detector and switch.
> -	  The FSA9480 is fully controlled using I2C and enables USB data,
> -	  stereo and mono audio, video, microphone and UART data to use
> -	  a common connector port.
> -
>  config LATTICE_ECP3_CONFIG
>  	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
>  	depends on SPI && SYSFS
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b9affcdaa3d6..95440c335dd4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -42,7 +42,6 @@ obj-$(CONFIG_VMWARE_BALLOON)	+= vmw_balloon.o
>  obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
>  obj-y				+= ti-st/
>  obj-y				+= lis3lv02d/
> -obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
>  obj-$(CONFIG_INTEL_MEI)		+= mei/
>  obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
> diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
> deleted file mode 100644
> index fab02f2da077..000000000000
> --- a/drivers/misc/fsa9480.c
> +++ /dev/null
> @@ -1,547 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * fsa9480.c - FSA9480 micro USB switch device driver
> - *
> - * Copyright (C) 2010 Samsung Electronics
> - * Minkyu Kang <mk7.kang@samsung.com>
> - * Wonguk Jeong <wonguk.jeong@samsung.com>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/err.h>
> -#include <linux/i2c.h>
> -#include <linux/platform_data/fsa9480.h>
> -#include <linux/irq.h>
> -#include <linux/interrupt.h>
> -#include <linux/workqueue.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/pm_runtime.h>
> -
> -/* FSA9480 I2C registers */
> -#define FSA9480_REG_DEVID		0x01
> -#define FSA9480_REG_CTRL		0x02
> -#define FSA9480_REG_INT1		0x03
> -#define FSA9480_REG_INT2		0x04
> -#define FSA9480_REG_INT1_MASK		0x05
> -#define FSA9480_REG_INT2_MASK		0x06
> -#define FSA9480_REG_ADC			0x07
> -#define FSA9480_REG_TIMING1		0x08
> -#define FSA9480_REG_TIMING2		0x09
> -#define FSA9480_REG_DEV_T1		0x0a
> -#define FSA9480_REG_DEV_T2		0x0b
> -#define FSA9480_REG_BTN1		0x0c
> -#define FSA9480_REG_BTN2		0x0d
> -#define FSA9480_REG_CK			0x0e
> -#define FSA9480_REG_CK_INT1		0x0f
> -#define FSA9480_REG_CK_INT2		0x10
> -#define FSA9480_REG_CK_INTMASK1		0x11
> -#define FSA9480_REG_CK_INTMASK2		0x12
> -#define FSA9480_REG_MANSW1		0x13
> -#define FSA9480_REG_MANSW2		0x14
> -
> -/* Control */
> -#define CON_SWITCH_OPEN		(1 << 4)
> -#define CON_RAW_DATA		(1 << 3)
> -#define CON_MANUAL_SW		(1 << 2)
> -#define CON_WAIT		(1 << 1)
> -#define CON_INT_MASK		(1 << 0)
> -#define CON_MASK		(CON_SWITCH_OPEN | CON_RAW_DATA | \
> -				CON_MANUAL_SW | CON_WAIT)
> -
> -/* Device Type 1 */
> -#define DEV_USB_OTG		(1 << 7)
> -#define DEV_DEDICATED_CHG	(1 << 6)
> -#define DEV_USB_CHG		(1 << 5)
> -#define DEV_CAR_KIT		(1 << 4)
> -#define DEV_UART		(1 << 3)
> -#define DEV_USB			(1 << 2)
> -#define DEV_AUDIO_2		(1 << 1)
> -#define DEV_AUDIO_1		(1 << 0)
> -
> -#define DEV_T1_USB_MASK		(DEV_USB_OTG | DEV_USB)
> -#define DEV_T1_UART_MASK	(DEV_UART)
> -#define DEV_T1_CHARGER_MASK	(DEV_DEDICATED_CHG | DEV_USB_CHG)
> -
> -/* Device Type 2 */
> -#define DEV_AV			(1 << 6)
> -#define DEV_TTY			(1 << 5)
> -#define DEV_PPD			(1 << 4)
> -#define DEV_JIG_UART_OFF	(1 << 3)
> -#define DEV_JIG_UART_ON		(1 << 2)
> -#define DEV_JIG_USB_OFF		(1 << 1)
> -#define DEV_JIG_USB_ON		(1 << 0)
> -
> -#define DEV_T2_USB_MASK		(DEV_JIG_USB_OFF | DEV_JIG_USB_ON)
> -#define DEV_T2_UART_MASK	(DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> -#define DEV_T2_JIG_MASK		(DEV_JIG_USB_OFF | DEV_JIG_USB_ON | \
> -				DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
> -
> -/*
> - * Manual Switch
> - * D- [7:5] / D+ [4:2]
> - * 000: Open all / 001: USB / 010: AUDIO / 011: UART / 100: V_AUDIO
> - */
> -#define SW_VAUDIO		((4 << 5) | (4 << 2))
> -#define SW_UART			((3 << 5) | (3 << 2))
> -#define SW_AUDIO		((2 << 5) | (2 << 2))
> -#define SW_DHOST		((1 << 5) | (1 << 2))
> -#define SW_AUTO			((0 << 5) | (0 << 2))
> -
> -/* Interrupt 1 */
> -#define INT_DETACH		(1 << 1)
> -#define INT_ATTACH		(1 << 0)
> -
> -struct fsa9480_usbsw {
> -	struct i2c_client		*client;
> -	struct fsa9480_platform_data	*pdata;
> -	int				dev1;
> -	int				dev2;
> -	int				mansw;
> -};
> -
> -static struct fsa9480_usbsw *chip;
> -
> -static int fsa9480_write_reg(struct i2c_client *client,
> -		int reg, int value)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte_data(client, reg, value);
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -static int fsa9480_read_reg(struct i2c_client *client, int reg)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_byte_data(client, reg);
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -static int fsa9480_read_irq(struct i2c_client *client, int *value)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_i2c_block_data(client,
> -			FSA9480_REG_INT1, 2, (u8 *)value);
> -	*value &= 0xffff;
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -static void fsa9480_set_switch(const char *buf)
> -{
> -	struct fsa9480_usbsw *usbsw = chip;
> -	struct i2c_client *client = usbsw->client;
> -	unsigned int value;
> -	unsigned int path = 0;
> -
> -	value = fsa9480_read_reg(client, FSA9480_REG_CTRL);
> -
> -	if (!strncmp(buf, "VAUDIO", 6)) {
> -		path = SW_VAUDIO;
> -		value &= ~CON_MANUAL_SW;
> -	} else if (!strncmp(buf, "UART", 4)) {
> -		path = SW_UART;
> -		value &= ~CON_MANUAL_SW;
> -	} else if (!strncmp(buf, "AUDIO", 5)) {
> -		path = SW_AUDIO;
> -		value &= ~CON_MANUAL_SW;
> -	} else if (!strncmp(buf, "DHOST", 5)) {
> -		path = SW_DHOST;
> -		value &= ~CON_MANUAL_SW;
> -	} else if (!strncmp(buf, "AUTO", 4)) {
> -		path = SW_AUTO;
> -		value |= CON_MANUAL_SW;
> -	} else {
> -		printk(KERN_ERR "Wrong command\n");
> -		return;
> -	}
> -
> -	usbsw->mansw = path;
> -	fsa9480_write_reg(client, FSA9480_REG_MANSW1, path);
> -	fsa9480_write_reg(client, FSA9480_REG_CTRL, value);
> -}
> -
> -static ssize_t fsa9480_get_switch(char *buf)
> -{
> -	struct fsa9480_usbsw *usbsw = chip;
> -	struct i2c_client *client = usbsw->client;
> -	unsigned int value;
> -
> -	value = fsa9480_read_reg(client, FSA9480_REG_MANSW1);
> -
> -	if (value == SW_VAUDIO)
> -		return sprintf(buf, "VAUDIO\n");
> -	else if (value == SW_UART)
> -		return sprintf(buf, "UART\n");
> -	else if (value == SW_AUDIO)
> -		return sprintf(buf, "AUDIO\n");
> -	else if (value == SW_DHOST)
> -		return sprintf(buf, "DHOST\n");
> -	else if (value == SW_AUTO)
> -		return sprintf(buf, "AUTO\n");
> -	else
> -		return sprintf(buf, "%x", value);
> -}
> -
> -static ssize_t fsa9480_show_device(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> -{
> -	struct fsa9480_usbsw *usbsw = dev_get_drvdata(dev);
> -	struct i2c_client *client = usbsw->client;
> -	int dev1, dev2;
> -
> -	dev1 = fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
> -	dev2 = fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
> -
> -	if (!dev1 && !dev2)
> -		return sprintf(buf, "NONE\n");
> -
> -	/* USB */
> -	if (dev1 & DEV_T1_USB_MASK || dev2 & DEV_T2_USB_MASK)
> -		return sprintf(buf, "USB\n");
> -
> -	/* UART */
> -	if (dev1 & DEV_T1_UART_MASK || dev2 & DEV_T2_UART_MASK)
> -		return sprintf(buf, "UART\n");
> -
> -	/* CHARGER */
> -	if (dev1 & DEV_T1_CHARGER_MASK)
> -		return sprintf(buf, "CHARGER\n");
> -
> -	/* JIG */
> -	if (dev2 & DEV_T2_JIG_MASK)
> -		return sprintf(buf, "JIG\n");
> -
> -	return sprintf(buf, "UNKNOWN\n");
> -}
> -
> -static ssize_t fsa9480_show_manualsw(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	return fsa9480_get_switch(buf);
> -
> -}
> -
> -static ssize_t fsa9480_set_manualsw(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	fsa9480_set_switch(buf);
> -
> -	return count;
> -}
> -
> -static DEVICE_ATTR(device, S_IRUGO, fsa9480_show_device, NULL);
> -static DEVICE_ATTR(switch, S_IRUGO | S_IWUSR,
> -		fsa9480_show_manualsw, fsa9480_set_manualsw);
> -
> -static struct attribute *fsa9480_attributes[] = {
> -	&dev_attr_device.attr,
> -	&dev_attr_switch.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group fsa9480_group = {
> -	.attrs = fsa9480_attributes,
> -};
> -
> -static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw, int intr)
> -{
> -	int val1, val2, ctrl;
> -	struct fsa9480_platform_data *pdata = usbsw->pdata;
> -	struct i2c_client *client = usbsw->client;
> -
> -	val1 = fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
> -	val2 = fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
> -	ctrl = fsa9480_read_reg(client, FSA9480_REG_CTRL);
> -
> -	dev_info(&client->dev, "intr: 0x%x, dev1: 0x%x, dev2: 0x%x\n",
> -			intr, val1, val2);
> -
> -	if (!intr)
> -		goto out;
> -
> -	if (intr & INT_ATTACH) {	/* Attached */
> -		/* USB */
> -		if (val1 & DEV_T1_USB_MASK || val2 & DEV_T2_USB_MASK) {
> -			if (pdata->usb_cb)
> -				pdata->usb_cb(FSA9480_ATTACHED);
> -
> -			if (usbsw->mansw) {
> -				fsa9480_write_reg(client,
> -					FSA9480_REG_MANSW1, usbsw->mansw);
> -			}
> -		}
> -
> -		/* UART */
> -		if (val1 & DEV_T1_UART_MASK || val2 & DEV_T2_UART_MASK) {
> -			if (pdata->uart_cb)
> -				pdata->uart_cb(FSA9480_ATTACHED);
> -
> -			if (!(ctrl & CON_MANUAL_SW)) {
> -				fsa9480_write_reg(client,
> -					FSA9480_REG_MANSW1, SW_UART);
> -			}
> -		}
> -
> -		/* CHARGER */
> -		if (val1 & DEV_T1_CHARGER_MASK) {
> -			if (pdata->charger_cb)
> -				pdata->charger_cb(FSA9480_ATTACHED);
> -		}
> -
> -		/* JIG */
> -		if (val2 & DEV_T2_JIG_MASK) {
> -			if (pdata->jig_cb)
> -				pdata->jig_cb(FSA9480_ATTACHED);
> -		}
> -	} else if (intr & INT_DETACH) {	/* Detached */
> -		/* USB */
> -		if (usbsw->dev1 & DEV_T1_USB_MASK ||
> -			usbsw->dev2 & DEV_T2_USB_MASK) {
> -			if (pdata->usb_cb)
> -				pdata->usb_cb(FSA9480_DETACHED);
> -		}
> -
> -		/* UART */
> -		if (usbsw->dev1 & DEV_T1_UART_MASK ||
> -			usbsw->dev2 & DEV_T2_UART_MASK) {
> -			if (pdata->uart_cb)
> -				pdata->uart_cb(FSA9480_DETACHED);
> -		}
> -
> -		/* CHARGER */
> -		if (usbsw->dev1 & DEV_T1_CHARGER_MASK) {
> -			if (pdata->charger_cb)
> -				pdata->charger_cb(FSA9480_DETACHED);
> -		}
> -
> -		/* JIG */
> -		if (usbsw->dev2 & DEV_T2_JIG_MASK) {
> -			if (pdata->jig_cb)
> -				pdata->jig_cb(FSA9480_DETACHED);
> -		}
> -	}
> -
> -	usbsw->dev1 = val1;
> -	usbsw->dev2 = val2;
> -
> -out:
> -	ctrl &= ~CON_INT_MASK;
> -	fsa9480_write_reg(client, FSA9480_REG_CTRL, ctrl);
> -}
> -
> -static irqreturn_t fsa9480_irq_handler(int irq, void *data)
> -{
> -	struct fsa9480_usbsw *usbsw = data;
> -	struct i2c_client *client = usbsw->client;
> -	int intr;
> -
> -	/* clear interrupt */
> -	fsa9480_read_irq(client, &intr);
> -
> -	/* device detection */
> -	fsa9480_detect_dev(usbsw, intr);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int fsa9480_irq_init(struct fsa9480_usbsw *usbsw)
> -{
> -	struct fsa9480_platform_data *pdata = usbsw->pdata;
> -	struct i2c_client *client = usbsw->client;
> -	int ret;
> -	int intr;
> -	unsigned int ctrl = CON_MASK;
> -
> -	/* clear interrupt */
> -	fsa9480_read_irq(client, &intr);
> -
> -	/* unmask interrupt (attach/detach only) */
> -	fsa9480_write_reg(client, FSA9480_REG_INT1_MASK, 0xfc);
> -	fsa9480_write_reg(client, FSA9480_REG_INT2_MASK, 0x1f);
> -
> -	usbsw->mansw = fsa9480_read_reg(client, FSA9480_REG_MANSW1);
> -
> -	if (usbsw->mansw)
> -		ctrl &= ~CON_MANUAL_SW;	/* Manual Switching Mode */
> -
> -	fsa9480_write_reg(client, FSA9480_REG_CTRL, ctrl);
> -
> -	if (pdata && pdata->cfg_gpio)
> -		pdata->cfg_gpio();
> -
> -	if (client->irq) {
> -		ret = request_threaded_irq(client->irq, NULL,
> -				fsa9480_irq_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"fsa9480 micro USB", usbsw);
> -		if (ret) {
> -			dev_err(&client->dev, "failed to request IRQ\n");
> -			return ret;
> -		}
> -
> -		if (pdata)
> -			device_init_wakeup(&client->dev, pdata->wakeup);
> -	}
> -
> -	return 0;
> -}
> -
> -static int fsa9480_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> -{
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> -	struct fsa9480_usbsw *usbsw;
> -	int ret = 0;
> -
> -	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		return -EIO;
> -
> -	usbsw = kzalloc(sizeof(struct fsa9480_usbsw), GFP_KERNEL);
> -	if (!usbsw) {
> -		dev_err(&client->dev, "failed to allocate driver data\n");
> -		return -ENOMEM;
> -	}
> -
> -	usbsw->client = client;
> -	usbsw->pdata = client->dev.platform_data;
> -
> -	chip = usbsw;
> -
> -	i2c_set_clientdata(client, usbsw);
> -
> -	ret = fsa9480_irq_init(usbsw);
> -	if (ret)
> -		goto fail1;
> -
> -	ret = sysfs_create_group(&client->dev.kobj, &fsa9480_group);
> -	if (ret) {
> -		dev_err(&client->dev,
> -				"failed to create fsa9480 attribute group\n");
> -		goto fail2;
> -	}
> -
> -	/* ADC Detect Time: 500ms */
> -	fsa9480_write_reg(client, FSA9480_REG_TIMING1, 0x6);
> -
> -	if (chip->pdata->reset_cb)
> -		chip->pdata->reset_cb();
> -
> -	/* device detection */
> -	fsa9480_detect_dev(usbsw, INT_ATTACH);
> -
> -	pm_runtime_set_active(&client->dev);
> -
> -	return 0;
> -
> -fail2:
> -	if (client->irq)
> -		free_irq(client->irq, usbsw);
> -fail1:
> -	kfree(usbsw);
> -	return ret;
> -}
> -
> -static int fsa9480_remove(struct i2c_client *client)
> -{
> -	struct fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
> -
> -	if (client->irq)
> -		free_irq(client->irq, usbsw);
> -
> -	sysfs_remove_group(&client->dev.kobj, &fsa9480_group);
> -	device_init_wakeup(&client->dev, 0);
> -	kfree(usbsw);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int fsa9480_suspend(struct device *dev)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
> -	struct fsa9480_platform_data *pdata = usbsw->pdata;
> -
> -	if (device_may_wakeup(&client->dev) && client->irq)
> -		enable_irq_wake(client->irq);
> -
> -	if (pdata->usb_power)
> -		pdata->usb_power(0);
> -
> -	return 0;
> -}
> -
> -static int fsa9480_resume(struct device *dev)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
> -	int dev1, dev2;
> -
> -	if (device_may_wakeup(&client->dev) && client->irq)
> -		disable_irq_wake(client->irq);
> -
> -	/*
> -	 * Clear Pending interrupt. Note that detect_dev does what
> -	 * the interrupt handler does. So, we don't miss pending and
> -	 * we reenable interrupt if there is one.
> -	 */
> -	fsa9480_read_reg(client, FSA9480_REG_INT1);
> -	fsa9480_read_reg(client, FSA9480_REG_INT2);
> -
> -	dev1 = fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
> -	dev2 = fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
> -
> -	/* device detection */
> -	fsa9480_detect_dev(usbsw, (dev1 || dev2) ? INT_ATTACH : INT_DETACH);
> -
> -	return 0;
> -}
> -
> -static SIMPLE_DEV_PM_OPS(fsa9480_pm_ops, fsa9480_suspend, fsa9480_resume);
> -#define FSA9480_PM_OPS (&fsa9480_pm_ops)
> -
> -#else
> -
> -#define FSA9480_PM_OPS NULL
> -
> -#endif /* CONFIG_PM_SLEEP */
> -
> -static const struct i2c_device_id fsa9480_id[] = {
> -	{"fsa9480", 0},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, fsa9480_id);
> -
> -static struct i2c_driver fsa9480_i2c_driver = {
> -	.driver = {
> -		.name = "fsa9480",
> -		.pm = FSA9480_PM_OPS,
> -	},
> -	.probe = fsa9480_probe,
> -	.remove = fsa9480_remove,
> -	.id_table = fsa9480_id,
> -};
> -
> -module_i2c_driver(fsa9480_i2c_driver);
> -
> -MODULE_AUTHOR("Minkyu Kang <mk7.kang@samsung.com>");
> -MODULE_DESCRIPTION("FSA9480 USB Switch driver");
> -MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/fsa9480.h b/include/linux/platform_data/fsa9480.h
> deleted file mode 100644
> index dea8d84448ec..000000000000
> --- a/include/linux/platform_data/fsa9480.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2010 Samsung Electronics
> - * Minkyu Kang <mk7.kang@samsung.com>
> - */
> -
> -#ifndef _FSA9480_H_
> -#define _FSA9480_H_
> -
> -#define FSA9480_ATTACHED	1
> -#define FSA9480_DETACHED	0
> -
> -struct fsa9480_platform_data {
> -	void (*cfg_gpio) (void);
> -	void (*usb_cb) (u8 attached);
> -	void (*uart_cb) (u8 attached);
> -	void (*charger_cb) (u8 attached);
> -	void (*jig_cb) (u8 attached);
> -	void (*reset_cb) (void);
> -	void (*usb_power) (u8 on);
> -	int wakeup;
> -};
> -
> -#endif /* _FSA9480_H_ */


