Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9BEC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA972206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575962027;
	bh=1f3xF2z6IXV5Hww/LLFA/wmT8xoBof2+AMdKIPBGcA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=d0w3jxtOZE8NfFCnD9OU/5a2UNs5QLNMBiWGlccKye6Mi4CPldtt+BjX8xVG0IM0A
	 xrfIzJ4mF68qNfddEBTJi6EiAbDNvvy4wdVu6ic0E1vXhiNHp0xx8ssYAnhvaz5Og1
	 uUUaWdje3yTdN1xVBstOI77I2ceBnONx+T9rE5ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJHNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:13:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39422 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:13:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so1493863lfb.6;
        Mon, 09 Dec 2019 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=j0ouWls4GJBccLTWwhcTs4JscgXoQqne6AxKBOJDJsk=;
        b=jA8bTpQFteM1DASdU/MSgc0DXQHoKcbNilSmYDy4gXIAvuoO1eZGUglDMJL4xq12Mt
         ms6D9rmCIrPNZnCfk5VXhSPn+ZFeTPaZtOUdyPkHFMmekrlCKml67wzoVRpJ3n2hdFEH
         mOtg62j3KDKLEdC+ILTcq+AxHSwA02aBIlDV82lBkJY4T9pA/npFSB/kny/COQGYw6pa
         SCno0Ey7AvYYyUIV5jrdYj+6sS0Zj1SQY2fAbRVzVtn8Kw3fovD4DKAtvGsWk8oa4pwL
         onmsnQ7hILr9qCdNvuAp1Vc9MVK/qio9r0xXiWu2CSMbflH3pcXDchCYHYUBtgMJEB7H
         ycoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=j0ouWls4GJBccLTWwhcTs4JscgXoQqne6AxKBOJDJsk=;
        b=lbeCw4qQBv8lV2Hx8fKpEltz3C9z58IBPAOkePLvE8bKNScZyH+X1SBvKTPPTYt2Lr
         YLJlJeJ31+Za2HCji6UaFmQ5aOnHg6ZRlDp4PtaaOqJZ4sb4z33TwtakhrMg+664Njwo
         adynn9AoXrQB+UjdPLorihLSkhsyzc9oNfbESSYN4FLJRdcY3PsUXvJo/LNrjWNQwcpN
         lErLAcZW5Xr0+Ds8As3kNLdlor2Fqxz7odOuJzEFFOfIEUMEjR1Y98ABGtq7OjXP5UnJ
         6BHzBpQ5NEZ9kUvGj0nWQVx9QNRqw2hIZxl/NpuakBVqn+o1uDRuyjfnaVoOwetgqy+R
         11+g==
X-Gm-Message-State: APjAAAVD58KEZgyFXO5qGpDS3C22HVaAtULWAB8VrdvYtEVVzvNKaAgo
        VS1eFAx5VdCWFMaPHSZe1yE=
X-Google-Smtp-Source: APXvYqyb9HRr7s2TEFTF8q+KJ167bpvLs3FBVUYB9BdZOyoi9rx28oWtRQaPJKc1MPQw9B9Aixui0A==
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr11541780lfm.15.1575962021409;
        Mon, 09 Dec 2019 23:13:41 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id n30sm1155744lfi.54.2019.12.09.23.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 23:13:40 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCHv1 2/2] usb: gadget: add udc driver for max3420
In-Reply-To: <20191210003135.32427-1-jassisinghbrar@gmail.com>
References: <20191210003135.32427-1-jassisinghbrar@gmail.com>
Date:   Tue, 10 Dec 2019 09:14:27 +0200
Message-ID: <87eexclkj0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

jassisinghbrar@gmail.com writes:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> The MAX3420 is USB2.0 only, UDC-over-SPI controller. This driver
> also supports the peripheral mode of MAX3421.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/usb/gadget/udc/Kconfig       |   10 +
>  drivers/usb/gadget/udc/Makefile      |    1 +
>  drivers/usb/gadget/udc/max3420_udc.c | 1334 ++++++++++++++++++++++++++
>  3 files changed, 1345 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/max3420_udc.c
>
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index ae70ce29d5e4..702cf1547c37 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -441,6 +441,16 @@ config USB_GADGET_XILINX
>  	  dynamically linked module called "udc-xilinx" and force all
>  	  gadget drivers to also be dynamically linked.
>=20=20
> +config USB_MAX3420_UDC
> +	tristate "MAX3420 (USB-over-SPI) support"
> +	depends on SPI
> +	help
> +	  The Maxim MAX3420 chip supports USB2.0 full-speed peripheral mode.
> +	  The MAX3420 is run by SPI interface, and hence the dependency.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called max3420_udc
> +
>  config USB_TEGRA_XUDC
>  	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Mak=
efile
> index f6777e654a8e..f5a7ce28aecd 100644
> --- a/drivers/usb/gadget/udc/Makefile
> +++ b/drivers/usb/gadget/udc/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_USB_GADGET_XILINX)	+=3D udc-xilinx.o
>  obj-$(CONFIG_USB_SNP_UDC_PLAT) +=3D snps_udc_plat.o
>  obj-$(CONFIG_USB_ASPEED_VHUB)	+=3D aspeed-vhub/
>  obj-$(CONFIG_USB_BDC_UDC)	+=3D bdc/
> +obj-$(CONFIG_USB_MAX3420_UDC)	+=3D max3420_udc.o
> diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/ud=
c/max3420_udc.c
> new file mode 100644
> index 000000000000..0213255c4b9a
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/max3420_udc.c
> @@ -0,0 +1,1337 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MAX3420 Device Controller driver for USB.
> + *
> + * Author: Jaswinder Singh Brar <jaswinder.singh@linaro.org>
> + * (C) Copyright 2019 Linaro Ltd
> + *
> + * Based on:
> + *	o MAX3420E datasheet
> + *		http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
> + *	o MAX342{0,1}E Programming Guides
> + *		https://pdfserv.maximintegrated.com/en/an/AN3598.pdf
> + *		https://pdfserv.maximintegrated.com/en/an/AN3785.pdf
> + *
> + * This file is licenced under the GPL v2.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/prefetch.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio/consumer.h>
> +
> +#define MAX3420_MAX_EPS		4
> +#define EP_MAX_PACKET		64  /* Same for all Endpoints */
> +#define EPNAME_SIZE		16  /* Buffer size for endpoint name */
> +
> +#define ACKSTAT		BIT(0)

Let's prepend everything with MAX3420_.

> +#define MAX3420_SPI_DIR_RD	0	/* read register from MAX3420 */
> +#define MAX3420_SPI_DIR_WR	1	/* write register to MAX3420 */
> +
> +/* SPI commands: */
> +#define MAX3420_SPI_DIR_SHIFT	1
> +#define MAX3420_SPI_REG_SHIFT	3
> +
> +#define MAX3420_REG_EP0FIFO	0
> +#define MAX3420_REG_EP1FIFO	1
> +#define MAX3420_REG_EP2FIFO	2
> +#define MAX3420_REG_EP3FIFO	3
> +#define MAX3420_REG_SUDFIFO	4
> +#define MAX3420_REG_EP0BC	5
> +#define MAX3420_REG_EP1BC	6
> +#define MAX3420_REG_EP2BC	7
> +#define MAX3420_REG_EP3BC	8
> +
> +#define MAX3420_REG_EPSTALLS	9
> +	#define bACKSTAT	BIT(6)

let's avoid CaMeLcAsE :-)

> +#define field(val, bit)	((val) << (bit))

The kernel has a bunch of helpers for this. Look at BIT() and GENMASK()
for example.

> +struct max3420_req {
> +	struct usb_request usb_req;
> +	struct list_head queue;
> +	struct max3420_ep *ep;
> +};
> +
> +struct max3420_ep {
> +	struct max3420_udc *udc;
> +	struct list_head queue;
> +	char name[EPNAME_SIZE];
> +	unsigned int maxpacket;
> +	struct usb_ep ep_usb;

considering you'll run container_of() on this ep_usb field, it's wise to
put it as the first field in the struct. That way, compiler can optimize
container_of() into a simple type cast.

> +struct max3420_udc {
> +	struct max3420_ep ep[MAX3420_MAX_EPS];
> +	struct usb_gadget_driver *driver;
> +	struct task_struct *thread_task;
> +	int remote_wkp, is_selfpowered;
> +	bool vbus_active, softconnect;
> +	struct usb_ctrlrequest setup;
> +	struct mutex spi_bus_mutex;
> +	struct max3420_req ep0req;
> +	struct usb_gadget gadget;

likewise with gadget field.

> +	struct spi_device *spi;
> +	struct device *dev;
> +	spinlock_t lock;
> +	bool suspended;
> +	u8 ep0buf[64];
> +	u32 todo;
> +};
> +
> +#define to_max3420_req(r)	container_of((r), struct max3420_req, usb_req)
> +#define to_max3420_ep(e)	container_of((e), struct max3420_ep, ep_usb)
> +#define to_udc(g)		container_of((g), struct max3420_udc, gadget)
> +
> +#define DRIVER_DESC     "MAX3420 USB Device-Mode Driver"
> +static const char driver_name[] =3D "max3420-udc";
> +
> +/* Control endpoint configuration.*/
> +static const struct usb_endpoint_descriptor ep0_desc =3D {
> +	.bEndpointAddress	=3D USB_DIR_OUT,
> +	.bmAttributes		=3D USB_ENDPOINT_XFER_CONTROL,
> +	.wMaxPacketSize		=3D cpu_to_le16(EP_MAX_PACKET),
> +};
> +
> +static void spi_ack_ctrl(struct max3420_udc *udc)
> +{
> +	struct spi_device *spi =3D udc->spi;
> +	struct spi_transfer transfer;
> +	struct spi_message msg;
> +	u8 txdata[1];
> +
> +	memset(&transfer, 0, sizeof(transfer));
> +
> +	spi_message_init(&msg);
> +
> +	txdata[0] =3D ACKSTAT;
> +	transfer.tx_buf =3D txdata;
> +	transfer.len =3D 1;
> +
> +	spi_message_add_tail(&transfer, &msg);
> +	spi_sync(spi, &msg);

Not checking return code?

> +}
> +
> +static u8 spi_rd8_ack(struct max3420_udc *udc, u8 reg, int actstat)
> +{
> +	struct spi_device *spi =3D udc->spi;
> +	struct spi_transfer transfer;
> +	struct spi_message msg;
> +	u8 txdata[2], rxdata[2];
> +
> +	memset(&transfer, 0, sizeof(transfer));
> +
> +	spi_message_init(&msg);
> +
> +	txdata[0] =3D field(reg, MAX3420_SPI_REG_SHIFT) |
> +			field(MAX3420_SPI_DIR_RD, MAX3420_SPI_DIR_SHIFT) |
> +			(actstat ? ACKSTAT : 0);
> +
> +	transfer.tx_buf =3D txdata;
> +	transfer.rx_buf =3D rxdata;
> +	transfer.len =3D 2;
> +
> +	spi_message_add_tail(&transfer, &msg);
> +	spi_sync(spi, &msg);

Not checking return code?

> +	return rxdata[1];
> +}
> +
> +static u8 spi_rd8(struct max3420_udc *udc, u8 reg)
> +{
> +	return spi_rd8_ack(udc, reg, 0);
> +}
> +
> +static void spi_wr8_ack(struct max3420_udc *udc, u8 reg, u8 val, int act=
stat)
> +{
> +	struct spi_device *spi =3D udc->spi;
> +	struct spi_transfer transfer;
> +	struct spi_message msg;
> +	u8 txdata[2];
> +
> +	memset(&transfer, 0, sizeof(transfer));
> +
> +	spi_message_init(&msg);
> +
> +	txdata[0] =3D field(reg, MAX3420_SPI_REG_SHIFT) |
> +			field(MAX3420_SPI_DIR_WR, MAX3420_SPI_DIR_SHIFT) |
> +			(actstat ? ACKSTAT : 0);
> +	txdata[1] =3D val;
> +
> +	transfer.tx_buf =3D txdata;
> +	transfer.len =3D 2;
> +
> +	spi_message_add_tail(&transfer, &msg);
> +	spi_sync(spi, &msg);

Not checking return code?

> +}
> +
> +static void spi_wr8(struct max3420_udc *udc, u8 reg, u8 val)
> +{
> +	spi_wr8_ack(udc, reg, val, 0);
> +}
> +
> +static void spi_rd_buf(struct max3420_udc *udc, u8 reg, void *buf, u8 le=
n)
> +{
> +	struct spi_device *spi =3D udc->spi;
> +	struct spi_transfer transfer;
> +	struct spi_message msg;
> +	u8 local_buf[EP_MAX_PACKET + 1] =3D {};
> +
> +	memset(&transfer, 0, sizeof(transfer));
> +
> +	spi_message_init(&msg);
> +
> +	local_buf[0] =3D (field(reg, MAX3420_SPI_REG_SHIFT) |
> +			field(MAX3420_SPI_DIR_RD, MAX3420_SPI_DIR_SHIFT));
> +
> +	transfer.tx_buf =3D &local_buf[0];
> +	transfer.rx_buf =3D &local_buf[0];
> +	transfer.len =3D len + 1;
> +
> +	spi_message_add_tail(&transfer, &msg);
> +	spi_sync(spi, &msg);

Not checking return code?

> +	memcpy(buf, &local_buf[1], len);
> +}
> +
> +static void spi_wr_buf(struct max3420_udc *udc, u8 reg, void *buf, u8 le=
n)
> +{
> +	struct spi_device *spi =3D udc->spi;
> +	struct spi_transfer transfer;
> +	struct spi_message msg;
> +	u8 local_buf[EP_MAX_PACKET + 1] =3D {};
> +
> +	memset(&transfer, 0, sizeof(transfer));
> +
> +	spi_message_init(&msg);
> +
> +	local_buf[0] =3D (field(reg, MAX3420_SPI_REG_SHIFT) |
> +			field(MAX3420_SPI_DIR_WR, MAX3420_SPI_DIR_SHIFT));
> +	memcpy(&local_buf[1], buf, len);
> +
> +	transfer.tx_buf =3D local_buf;
> +	transfer.len =3D len + 1;
> +
> +	spi_message_add_tail(&transfer, &msg);
> +	spi_sync(spi, &msg);

Not checking return code?

> +static int spi_max3420_enable(struct max3420_ep *ep)
> +{
> +	struct max3420_udc *udc =3D ep->udc;
> +	unsigned long flags;
> +	u8 epdis, epien;
> +	int todo;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +	todo =3D ep->todo & ENABLE_EP;
> +	ep->todo &=3D ~ENABLE_EP;
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	if (!todo || ep->id =3D=3D 0)
> +		return 0;
> +
> +	epien =3D spi_rd8(udc, MAX3420_REG_EPIEN);
> +	epdis =3D spi_rd8(udc, MAX3420_REG_CLRTOGS);
> +
> +	if (todo =3D=3D ENABLE) {
> +		epdis &=3D ~BIT(ep->id + 4);
> +		epien |=3D BIT(ep->id + 1);
> +	} else {
> +		epdis |=3D BIT(ep->id + 4);
> +		epien &=3D ~BIT(ep->id + 1);
> +	}
> +
> +	spi_wr8(udc, MAX3420_REG_CLRTOGS, epdis);
> +	spi_wr8(udc, MAX3420_REG_EPIEN, epien);
> +
> +	return 1;

Usually we return 0 on success and a negative errno on failure. What do
you mean here by return 1?

> +static int spi_max3420_stall(struct max3420_ep *ep)
> +{
> +	struct max3420_udc *udc =3D ep->udc;
> +	unsigned long flags;
> +	u8 epstalls;
> +	int todo;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +	todo =3D ep->todo & STALL_EP;
> +	ep->todo &=3D ~STALL_EP;
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	if (!todo || ep->id =3D=3D 0)
> +		return 0;
> +
> +	epstalls =3D spi_rd8(udc, MAX3420_REG_EPSTALLS);
> +	if (todo =3D=3D STALL) {
> +		ep->halted =3D 1;
> +		epstalls |=3D BIT(ep->id + 1);
> +	} else {
> +		u8 clrtogs;
> +
> +		ep->halted =3D 0;
> +		epstalls &=3D ~BIT(ep->id + 1);
> +		clrtogs =3D spi_rd8(udc, MAX3420_REG_CLRTOGS);
> +		clrtogs |=3D BIT(ep->id + 1);
> +		spi_wr8(udc, MAX3420_REG_CLRTOGS, clrtogs);
> +	}
> +	spi_wr8(udc, MAX3420_REG_EPSTALLS, epstalls | bACKSTAT);
> +
> +	return 1;

and here?

> +}
> +
> +static int spi_max3420_rwkup(struct max3420_udc *udc)
> +{
> +	unsigned long flags;
> +	int wake_remote;
> +	u8 usbctl;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	wake_remote =3D udc->todo & REMOTE_WAKEUP;
> +	udc->todo &=3D ~REMOTE_WAKEUP;
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	if (!wake_remote || !udc->suspended)
> +		return 0;
> +
> +	/* Set Remote-WkUp Signal*/
> +	usbctl =3D spi_rd8(udc, MAX3420_REG_USBCTL);
> +	usbctl |=3D bSIGRWU;
> +	spi_wr8(udc, MAX3420_REG_USBCTL, usbctl);
> +
> +	msleep_interruptible(5);
> +
> +	/* Clear Remote-WkUp Signal*/
> +	usbctl =3D spi_rd8(udc, MAX3420_REG_USBCTL);
> +	usbctl &=3D ~bSIGRWU;
> +	spi_wr8(udc, MAX3420_REG_USBCTL, usbctl);
> +
> +	udc->suspended =3D false;
> +
> +	return 1;

here?

> +}
> +
> +static void max3420_nuke(struct max3420_ep *ep, int status);
> +static void __max3420_stop(struct max3420_udc *udc)
> +{
> +	u8 val;
> +	int i;
> +
> +	/* clear all pending requests */
> +	for (i =3D 1; i < MAX3420_MAX_EPS; i++)
> +		max3420_nuke(&udc->ep[i], -ECONNRESET);
> +
> +	/* Disable IRQ to CPU */
> +	spi_wr8(udc, MAX3420_REG_CPUCTL, 0);
> +
> +	val =3D spi_rd8(udc, MAX3420_REG_USBCTL);
> +	val |=3D bPWRDOWN;
> +	if (udc->is_selfpowered)
> +		val &=3D ~bHOSCSTEN;
> +	else
> +		val |=3D bHOSCSTEN;
> +	spi_wr8(udc, MAX3420_REG_USBCTL, val);
> +}
> +
> +static void __max3420_start(struct max3420_udc *udc)
> +{
> +	u8 val;
> +
> +	/* Need this delay if bus-powered */
> +	msleep_interruptible(250);

should you check if you're bus powered?

> +	/* configure SPI */
> +	spi_wr8(udc, MAX3420_REG_PINCTL, bFDUPSPI);
> +
> +	/* Chip Reset */
> +	spi_wr8(udc, MAX3420_REG_USBCTL, bCHIPRES);
> +	msleep_interruptible(5);
> +	spi_wr8(udc, MAX3420_REG_USBCTL, 0);
> +
> +	/* Poll for OSC to stabilize */
> +	while (1) {
> +		val =3D spi_rd8(udc, MAX3420_REG_USBIRQ);
> +		if (val & bOSCOKIRQ)
> +			break;
> +		cond_resched();
> +	}

readl_poll_timeout(), maybe?

> +	/* Enable PULL-UP only when Vbus detected */
> +	val =3D spi_rd8(udc, MAX3420_REG_USBCTL);
> +	val |=3D bVBGATE | bCONNECT;
> +	spi_wr8(udc, MAX3420_REG_USBCTL, val);
> +
> +	val =3D bURESDNIRQ | bURESIRQ;
> +	if (udc->is_selfpowered)
> +		val |=3D bNOVBUSIRQ;
> +	spi_wr8(udc, MAX3420_REG_USBIEN, val);
> +
> +	/* Enable only EP0 interrupts */
> +	val =3D bIN0BAVIRQ | bOUT0DAVIRQ | bSUDAVIRQ;
> +	spi_wr8(udc, MAX3420_REG_EPIEN, val);
> +
> +	/* Enable IRQ to CPU */
> +	spi_wr8(udc, MAX3420_REG_CPUCTL, bIE);
> +}
> +
> +static int max3420_start(struct max3420_udc *udc)
> +{
> +	unsigned long flags;
> +	int todo;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	todo =3D udc->todo & UDC_START;
> +	udc->todo &=3D ~UDC_START;
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	if (!todo)
> +		return 0;
> +
> +	if (udc->vbus_active && udc->softconnect)
> +		__max3420_start(udc);
> +	else
> +		__max3420_stop(udc);
> +
> +	return 1;
> +}
> +
> +static irqreturn_t max3420_vbus_handler(int irq, void *dev_id)
> +{
> +	struct max3420_udc *udc =3D dev_id;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	/* its a vbus change interrupt */
> +	udc->vbus_active =3D !udc->vbus_active;
> +	udc->todo |=3D UDC_START;
> +	usb_udc_vbus_handler(&udc->gadget, udc->vbus_active);
> +	usb_gadget_set_state(&udc->gadget, udc->vbus_active
> +			     ? USB_STATE_POWERED : USB_STATE_NOTATTACHED);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	if (udc->thread_task &&
> +	    udc->thread_task->state !=3D TASK_RUNNING)
> +		wake_up_process(udc->thread_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t max3420_irq_handler(int irq, void *dev_id)
> +{
> +	struct max3420_udc *udc =3D dev_id;
> +	struct spi_device *spi =3D udc->spi;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if ((udc->todo & ENABLE_IRQ) =3D=3D 0) {
> +		disable_irq_nosync(spi->irq);
> +		udc->todo |=3D ENABLE_IRQ;
> +	}
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	if (udc->thread_task &&
> +	    udc->thread_task->state !=3D TASK_RUNNING)
> +		wake_up_process(udc->thread_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void max3420_getstatus(struct max3420_udc *udc)
> +{
> +	struct max3420_ep *ep;
> +	u16 status =3D 0;
> +
> +	switch (udc->setup.bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		/* Get device status */
> +		status =3D udc->gadget.is_selfpowered << USB_DEVICE_SELF_POWERED;
> +		status |=3D (udc->remote_wkp << USB_DEVICE_REMOTE_WAKEUP);
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		if (udc->driver->setup(&udc->gadget, &udc->setup) < 0)
> +			goto stall;
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		ep =3D &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];
> +		if (udc->setup.wIndex & USB_DIR_IN) {
> +			if (!ep->ep_usb.caps.dir_in)
> +				goto stall;
> +		} else {
> +			if (!ep->ep_usb.caps.dir_out)
> +				goto stall;
> +		}
> +		if (ep->halted)
> +			status =3D 1 << USB_ENDPOINT_HALT;
> +		break;
> +	default:
> +		goto stall;
> +	}
> +
> +	status =3D cpu_to_le16(status);
> +	spi_wr_buf(udc, MAX3420_REG_EP0FIFO, &status, 2);
> +	spi_wr8_ack(udc, MAX3420_REG_EP0BC, 2, 1);
> +	return;
> +stall:
> +	dev_err(udc->dev, "Can't respond to getstatus request\n");
> +	spi_wr8(udc, MAX3420_REG_EPSTALLS, bSTLEP0IN | bSTLEP0OUT | bSTLSTAT);
> +}
> +
> +static void max3420_set_clear_feature(struct max3420_udc *udc)
> +{
> +	struct max3420_ep *ep;
> +	int set =3D udc->setup.bRequest =3D=3D USB_REQ_SET_FEATURE;
> +	unsigned long flags;
> +	int id;
> +
> +	switch (udc->setup.bRequestType) {
> +	case USB_RECIP_DEVICE:
> +		if (udc->setup.wValue !=3D USB_DEVICE_REMOTE_WAKEUP)
> +			break;
> +
> +		if (udc->setup.bRequest =3D=3D USB_REQ_SET_FEATURE)
> +			udc->remote_wkp =3D 1;
> +		else
> +			udc->remote_wkp =3D 0;
> +
> +		return spi_ack_ctrl(udc);
> +
> +	case USB_RECIP_ENDPOINT:
> +		if (udc->setup.wValue !=3D USB_ENDPOINT_HALT)
> +			break;
> +
> +		id =3D udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
> +		ep =3D &udc->ep[id];
> +
> +		spin_lock_irqsave(&ep->lock, flags);
> +		ep->todo &=3D ~STALL_EP;
> +		if (set)
> +			ep->todo |=3D STALL;
> +		else
> +			ep->todo |=3D UNSTALL;
> +		spin_unlock_irqrestore(&ep->lock, flags);
> +
> +		spi_max3420_stall(ep);
> +		return;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(udc->dev, "Can't respond to SET/CLEAR FEATURE\n");
> +	spi_wr8(udc, MAX3420_REG_EPSTALLS, bSTLEP0IN | bSTLEP0OUT | bSTLSTAT);
> +}
> +
> +static void max3420_handle_setup(struct max3420_udc *udc)
> +{
> +	struct usb_ctrlrequest setup;
> +	u8 addr;
> +
> +	spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);
> +
> +	udc->setup =3D setup;
> +	udc->setup.wValue =3D cpu_to_le16(setup.wValue);
> +	udc->setup.wIndex =3D cpu_to_le16(setup.wIndex);
> +	udc->setup.wLength =3D cpu_to_le16(setup.wLength);
> +
> +	switch (udc->setup.bRequest) {
> +	case USB_REQ_GET_STATUS:
> +		/* Data+Status phase form udc */
> +		if ((udc->setup.bRequestType &
> +				(USB_DIR_IN | USB_TYPE_MASK)) !=3D
> +				(USB_DIR_IN | USB_TYPE_STANDARD)) {
> +			break;
> +		}
> +		return max3420_getstatus(udc);
> +	case USB_REQ_SET_ADDRESS:
> +		/* Status phase from udc */
> +		if (udc->setup.bRequestType !=3D (USB_DIR_OUT |
> +				USB_TYPE_STANDARD | USB_RECIP_DEVICE)) {
> +			break;
> +		}
> +		addr =3D spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
> +		dev_dbg(udc->dev, "Assigned Address=3D%d\n", udc->setup.wValue);
> +		return;
> +	case USB_REQ_CLEAR_FEATURE:
> +	case USB_REQ_SET_FEATURE:
> +		/* Requests with no data phase, status phase from udc */
> +		if ((udc->setup.bRequestType & USB_TYPE_MASK)
> +				!=3D USB_TYPE_STANDARD)
> +			break;
> +		return max3420_set_clear_feature(udc);
> +	default:
> +		break;
> +	}
> +
> +	if (udc->driver->setup(&udc->gadget, &setup) < 0) {
> +		/* Stall EP0 */
> +		spi_wr8(udc, MAX3420_REG_EPSTALLS,
> +			bSTLEP0IN | bSTLEP0OUT | bSTLSTAT);
> +	}
> +}
> +
> +static void max3420_req_done(struct max3420_req *req, int status)
> +{
> +	struct max3420_ep *ep =3D req->ep;
> +	struct max3420_udc *udc =3D ep->udc;
> +
> +	if (req->usb_req.status =3D=3D -EINPROGRESS)
> +		req->usb_req.status =3D status;
> +	else
> +		status =3D req->usb_req.status;
> +
> +	if (status && status !=3D -ESHUTDOWN)
> +		dev_err(udc->dev, "%s done %p, status %d\n",
> +			ep->ep_usb.name, req, status);
> +
> +	if (req->usb_req.complete)
> +		req->usb_req.complete(&ep->ep_usb, &req->usb_req);
> +}
> +
> +static int do_data(struct max3420_udc *udc, int ep_id, int in)

add a max3420_ prefix like all other functions

> +{
> +	struct max3420_ep *ep =3D &udc->ep[ep_id];
> +	struct max3420_req *req;
> +	int done, length, psz;
> +	void *buf;
> +
> +	if (list_empty(&ep->queue))
> +		return 0;
> +
> +	req =3D list_first_entry(&ep->queue, struct max3420_req, queue);
> +	buf =3D req->usb_req.buf + req->usb_req.actual;
> +
> +	psz =3D ep->ep_usb.maxpacket;
> +	length =3D req->usb_req.length - req->usb_req.actual;
> +	length =3D min(length, psz);
> +
> +	if (length =3D=3D 0) {
> +		done =3D 1;
> +		goto xfer_done;
> +	}
> +
> +	done =3D 0;
> +	if (in) {
> +		prefetch(buf);
> +		spi_wr_buf(udc, MAX3420_REG_EP0FIFO + ep_id, buf, length);
> +		spi_wr8(udc, MAX3420_REG_EP0BC + ep_id, length);
> +		if (length < psz)
> +			done =3D 1;
> +	} else {
> +		psz =3D spi_rd8(udc, MAX3420_REG_EP0BC + ep_id);
> +		length =3D min(length, psz);
> +		prefetchw(buf);
> +		spi_rd_buf(udc, MAX3420_REG_EP0FIFO + ep_id, buf, length);
> +		if (length < ep->ep_usb.maxpacket)
> +			done =3D 1;
> +	}
> +
> +	req->usb_req.actual +=3D length;
> +
> +	if (req->usb_req.actual =3D=3D req->usb_req.length)
> +		done =3D 1;
> +
> +xfer_done:
> +	if (done) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&ep->lock, flags);
> +		list_del_init(&req->queue);
> +		spin_unlock_irqrestore(&ep->lock, flags);
> +
> +		if (ep_id =3D=3D 0)
> +			spi_ack_ctrl(udc);
> +
> +		max3420_req_done(req, 0);
> +	}
> +
> +	return 1;
> +}
> +
> +static int max3420_handle_irqs(struct max3420_udc *udc)
> +{
> +	u8 epien, epirq, usbirq, usbien, reg[4];
> +	int ret =3D 0;
> +
> +	spi_rd_buf(udc, MAX3420_REG_EPIRQ, reg, 4);
> +	epirq =3D reg[0];
> +	epien =3D reg[1];
> +	usbirq =3D reg[2];
> +	usbien =3D reg[3];
> +
> +	usbirq &=3D usbien;
> +	epirq &=3D epien;
> +
> +	if (epirq & bSUDAVIRQ) {
> +		spi_wr8(udc, MAX3420_REG_EPIRQ, bSUDAVIRQ);
> +		max3420_handle_setup(udc);
> +		return 1;
> +	}
> +
> +	if (usbirq & bVBUSIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bVBUSIRQ);
> +		dev_dbg(udc->dev, "Cable plugged in\n");
> +		return 1;
> +	}
> +
> +	if (usbirq & bNOVBUSIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bNOVBUSIRQ);
> +		dev_dbg(udc->dev, "Cable pulled out\n");
> +		return 1;
> +	}
> +
> +	if (usbirq & bURESIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bURESIRQ);
> +		dev_dbg(udc->dev, "USB Reset - Start\n");
> +		return 1;
> +	}
> +
> +	if (usbirq & bURESDNIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bURESDNIRQ);
> +		dev_dbg(udc->dev, "USB Reset - END\n");
> +		spi_wr8(udc, MAX3420_REG_USBIEN, bURESDNIRQ | bURESIRQ);
> +		spi_wr8(udc, MAX3420_REG_EPIEN, bSUDAVIRQ | bIN0BAVIRQ
> +			| bOUT0DAVIRQ);
> +		return 1;
> +	}
> +
> +	if (usbirq & bSUSPIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bSUSPIRQ);
> +		dev_dbg(udc->dev, "USB Suspend - Enter\n");
> +		udc->suspended =3D true;
> +		return 1;
> +	}
> +
> +	if (usbirq & bBUSACTIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bBUSACTIRQ);
> +		dev_dbg(udc->dev, "USB Suspend - Exit\n");
> +		udc->suspended =3D false;
> +		return 1;
> +	}
> +
> +	if (usbirq & bRWUDNIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bRWUDNIRQ);
> +		dev_dbg(udc->dev, "Asked Host to wakeup\n");
> +		return 1;
> +	}
> +
> +	if (usbirq & bOSCOKIRQ) {
> +		spi_wr8(udc, MAX3420_REG_USBIRQ, bOSCOKIRQ);
> +		dev_dbg(udc->dev, "Osc stabilized, start work\n");
> +		return 1;
> +	}
> +
> +	if (epirq & bOUT0DAVIRQ && do_data(udc, 0, 0)) {
> +		spi_wr8_ack(udc, MAX3420_REG_EPIRQ, bOUT0DAVIRQ, 1);
> +		ret =3D 1;
> +	}
> +
> +	if (epirq & bIN0BAVIRQ && do_data(udc, 0, 1))
> +		ret =3D 1;
> +
> +	if (epirq & bOUT1DAVIRQ && do_data(udc, 1, 0)) {
> +		spi_wr8_ack(udc, MAX3420_REG_EPIRQ, bOUT1DAVIRQ, 1);
> +		ret =3D 1;
> +	}
> +
> +	if (epirq & bIN2BAVIRQ && do_data(udc, 2, 1))
> +		ret =3D 1;
> +
> +	if (epirq & bIN3BAVIRQ && do_data(udc, 3, 1))
> +		ret =3D 1;
> +
> +	return ret;
> +}
> +
> +static int max3420_thread(void *dev_id)

Why do you need this thread? Sure you can't live without it?

> +{
> +	struct max3420_udc *udc =3D dev_id;
> +	struct spi_device *spi =3D udc->spi;
> +	int i, loop_again =3D 1;
> +	unsigned long flags;
> +
> +	while (!kthread_should_stop()) {
> +		if (!loop_again) {
> +			ktime_t kt =3D ns_to_ktime(1000 * 1000 * 250); /* 250ms */
> +
> +			set_current_state(TASK_INTERRUPTIBLE);
> +
> +			spin_lock_irqsave(&udc->lock, flags);
> +			if (udc->todo & ENABLE_IRQ) {
> +				enable_irq(spi->irq);
> +				udc->todo &=3D ~ENABLE_IRQ;
> +			}
> +			spin_unlock_irqrestore(&udc->lock, flags);
> +
> +			schedule_hrtimeout(&kt, HRTIMER_MODE_REL);
> +		}
> +		loop_again =3D 0;
> +
> +		mutex_lock(&udc->spi_bus_mutex);
> +
> +		/* If bus-vbus_active and disconnected */
> +		if (!udc->vbus_active || !udc->softconnect)
> +			goto loop;
> +
> +		if (max3420_start(udc)) {
> +			loop_again =3D 1;
> +			goto loop;
> +		}
> +
> +		if (max3420_handle_irqs(udc)) {
> +			loop_again =3D 1;
> +			goto loop;
> +		}
> +
> +		if (spi_max3420_rwkup(udc)) {
> +			loop_again =3D 1;
> +			goto loop;
> +		}
> +
> +		do_data(udc, 0, 1); /* get done with the EP0 ZLP */
> +
> +		for (i =3D 1; i < MAX3420_MAX_EPS; i++) {
> +			struct max3420_ep *ep =3D &udc->ep[i];
> +
> +			if (spi_max3420_enable(ep))
> +				loop_again =3D 1;
> +			if (spi_max3420_stall(ep))
> +				loop_again =3D 1;
> +		}
> +loop:
> +		mutex_unlock(&udc->spi_bus_mutex);
> +	}
> +
> +	set_current_state(TASK_RUNNING);
> +	dev_info(udc->dev, "SPI thread exiting");
> +	return 0;
> +}
> +
> +static int max3420_ep_set_halt(struct usb_ep *_ep, int stall)
> +{
> +	struct max3420_ep *ep =3D to_max3420_ep(_ep);
> +	struct max3420_udc *udc =3D ep->udc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +
> +	ep->todo &=3D ~STALL_EP;
> +	if (stall)
> +		ep->todo |=3D STALL;
> +	else
> +		ep->todo |=3D UNSTALL;
> +
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	wake_up_process(udc->thread_task);
> +
> +	dev_dbg(udc->dev, "%sStall %s\n", stall ? "" : "Un", ep->name);
> +	return 0;
> +}
> +
> +static int __max3420_ep_enable(struct max3420_ep *ep,
> +			      const struct usb_endpoint_descriptor *desc)
> +{
> +	unsigned int maxp =3D usb_endpoint_maxp(desc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +	ep->ep_usb.desc =3D desc;
> +	ep->ep_usb.maxpacket =3D maxp;
> +
> +	ep->todo &=3D ~ENABLE_EP;
> +	ep->todo |=3D ENABLE;
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int max3420_ep_enable(struct usb_ep *_ep,
> +			     const struct usb_endpoint_descriptor *desc)
> +{
> +	struct max3420_ep *ep =3D to_max3420_ep(_ep);
> +	struct max3420_udc *udc =3D ep->udc;
> +
> +	__max3420_ep_enable(ep, desc);
> +
> +	wake_up_process(udc->thread_task);
> +
> +	return 0;
> +}
> +
> +static void max3420_nuke(struct max3420_ep *ep, int status)
> +{
> +	struct max3420_req *req, *r;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +
> +	list_for_each_entry_safe(req, r, &ep->queue, queue) {
> +
> +		list_del_init(&req->queue);
> +
> +		spin_unlock_irqrestore(&ep->lock, flags);
> +		max3420_req_done(req, status);
> +		spin_lock_irqsave(&ep->lock, flags);
> +	}
> +
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +}
> +
> +static void __max3420_ep_disable(struct max3420_ep *ep)
> +{
> +	struct max3420_udc *udc =3D ep->udc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ep->lock, flags);
> +
> +	ep->ep_usb.desc =3D NULL;
> +
> +	ep->todo &=3D ~ENABLE_EP;
> +	ep->todo |=3D DISABLE;
> +
> +	spin_unlock_irqrestore(&ep->lock, flags);
> +
> +	dev_dbg(udc->dev, "Disabled %s\n", ep->name);
> +}
> +
> +static int max3420_ep_disable(struct usb_ep *_ep)
> +{
> +	struct max3420_ep *ep =3D to_max3420_ep(_ep);
> +	struct max3420_udc *udc =3D ep->udc;
> +
> +	max3420_nuke(ep, -ESHUTDOWN);
> +
> +	__max3420_ep_disable(ep);
> +
> +	wake_up_process(udc->thread_task);
> +
> +	return 0;
> +}
> +
> +static struct usb_request *max3420_alloc_request(struct usb_ep *_ep,
> +						    gfp_t gfp_flags)
> +{
> +	struct max3420_ep *ep =3D to_max3420_ep(_ep);
> +	struct max3420_req *req;
> +
> +	req =3D kzalloc(sizeof(*req), gfp_flags);
> +	if (!req)
> +		return NULL;
> +
> +	req->ep =3D ep;
> +	INIT_LIST_HEAD(&req->queue);

unnecessary list initialization

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl3vRdQACgkQzL64meEa
mQZv9Q/9FRNlpzDhRj+xmkfmor3HqogFoQwIW56BAPqWGjhrfDDvGB2iYmjYB0aH
5FW7av6RFmR5+Q/k2je0URe6aw9uEqr9SO1EMGbBYxxMRKobMr9SwOVGA1YSIzSA
PdaCnvyAx0resyCyM52f0PaCOZUf+us/bUJa4nZ+niikmQA1yPfKilBd5A3DqxG2
Xj3AANnklfVMe77h3lgoTt49SOc8yYZjpK+iDuDvcUGLiEi02HOxr3BubOAQhkjc
pNP/GkH1Oj7FLvYRijZoHWr1Sjd08+/WIP3a7erL7B2MzTrHkdTMYyLzTqsSKeww
fUhCkxpjE6edouJCX8xItDbuY6IZL6nnabWQWYsHSWTW9GKWmfMsCOiHvCFapVPT
NYLsNnsLjBfloaDAR95rXYrNtta15jujGmId2Mu+nV9kMyhna+0Grcy8cXNJ5Bjf
H2PCbJt3z/RxeFqOm/AiCftF2vBPl07OWuJSmO/whj8GS/3FtUWC06fy1VQ6cTI7
0xyA39VjUb+oK8yWaHVgzvTjd8mx30+BtX3PP53zl40MDiHV3ZDBnllF/kGicNr8
/a7Y62q6mal1yBGrZ7faBYnUZ0ug1NH2faNJj87hhoNkUksjDBf/g2jB1Mlc4mT1
qqI9tzt7kgAmB2cAPoY5md0y561QB42BzyvIsgxjYkRyS2DUj9M=
=Acbg
-----END PGP SIGNATURE-----
--=-=-=--
