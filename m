Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0EC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD020665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfGHHLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:11:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:25110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfGHHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:11:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 00:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="asc'?scan'208";a="167593734"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2019 00:11:16 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, jpawar@cadence.com, kurahul@cadence.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <1562324238-16655-6-git-send-email-pawell@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com>
Date:   Mon, 08 Jul 2019 10:11:12 +0300
Message-ID: <877e8tm25r.fsf@linux.intel.com>
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

Pawel Laszczak <pawell@cadence.com> writes:
> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> +{
> +	struct cdns3_usb_regs __iomem *regs =3D priv_dev->regs;
> +	u32 reg;
> +
> +	cdns3_ep0_config(priv_dev);
> +
> +	/* enable interrupts for endpoint 0 (in and out) */
> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
> +
> +	/*
> +	 *Driver need modify LFPS minimal U1 Exit time for 0x00024505 revision

comment style

> +	 * of controller
> +	 */
> +	if (priv_dev->dev_ver =3D=3D DEV_VER_TI_V1) {

this version is really only for TI? And there's another only for NXP?

+#define DEV_VER_NXP_V1		0x00024502
+#define DEV_VER_TI_V1		0x00024509
+#define DEV_VER_V2		0x0002450C
+#define DEV_VER_V3		0x0002450d

How do you actually decode this?

> +static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
> +{
> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
> +	struct cdns3_endpoint *priv_ep;
> +	u32 bEndpointAddress;
> +	struct usb_ep *ep;
> +	int ret =3D 0;
> +
> +	priv_dev->gadget_driver =3D NULL;
> +
> +	priv_dev->onchip_used_size =3D 0;
> +	priv_dev->out_mem_is_allocated =3D 0;
> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
> +
> +	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> +		priv_ep =3D ep_to_cdns3_ep(ep);
> +		bEndpointAddress =3D priv_ep->num | priv_ep->dir;
> +		cdns3_select_ep(priv_dev, bEndpointAddress);
> +		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +		ret =3D cdns3_handshake(&priv_dev->regs->ep_cmd,
> +				      EP_CMD_EPRST, 0, 100);
> +		cdns3_free_trb_pool(priv_ep);

are you sure you want to free your trb pool when a gadget driver is
unloaded? One can easily fragment memory by constantly loading and
unloading a gadget driver, no?

How about you allocate the trb poll during cdns3 load and free it when
cdns3 is unloaded?

> +static int cdns3_gadget_start(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	u32 max_speed;
> +	int ret;
> +
> +	priv_dev =3D kzalloc(sizeof(*priv_dev), GFP_KERNEL);
> +	if (!priv_dev)
> +		return -ENOMEM;
> +
> +	cdns->gadget_dev =3D priv_dev;
> +	priv_dev->sysdev =3D cdns->dev;
> +	priv_dev->dev =3D cdns->dev;
> +	priv_dev->regs =3D cdns->dev_regs;
> +
> +	device_property_read_u16(priv_dev->dev, "cdns,on-chip-buff-size",
> +				 &priv_dev->onchip_buffers);
> +
> +	if (priv_dev->onchip_buffers <=3D  0) {
> +		u32 reg =3D readl(&priv_dev->regs->usb_cap2);
> +
> +		priv_dev->onchip_buffers =3D USB_CAP2_ACTUAL_MEM_SIZE(reg);
> +	}
> +
> +	if (!priv_dev->onchip_buffers)
> +		priv_dev->onchip_buffers =3D 256;
> +
> +	max_speed =3D usb_get_maximum_speed(cdns->dev);
> +
> +	/* Check the maximum_speed parameter */
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER:
> +		break;
> +	default:
> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
> +			max_speed);
> +		/* fall through */
> +	case USB_SPEED_UNKNOWN:
> +		/* default to superspeed */
> +		max_speed =3D USB_SPEED_SUPER;
> +		break;
> +	}
> +
> +	/* fill gadget fields */
> +	priv_dev->gadget.max_speed =3D max_speed;
> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	priv_dev->gadget.ops =3D &cdns3_gadget_ops;
> +	priv_dev->gadget.name =3D "usb-ss-gadget";
> +	priv_dev->gadget.sg_supported =3D 1;
> +
> +	spin_lock_init(&priv_dev->lock);
> +	INIT_WORK(&priv_dev->pending_status_wq,
> +		  cdns3_pending_setup_status_handler);
> +
> +	/* initialize endpoint container */
> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> +	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
> +
> +	ret =3D cdns3_init_eps(priv_dev);
> +	if (ret) {
> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
> +		goto err1;
> +	}
> +
> +	/* allocate memory for setup packet buffer */
> +	priv_dev->setup_buf =3D dma_alloc_coherent(priv_dev->sysdev, 8,
> +						 &priv_dev->setup_dma, GFP_DMA);
> +	if (!priv_dev->setup_buf) {
> +		ret =3D -ENOMEM;
> +		goto err2;
> +	}
> +
> +	priv_dev->dev_ver =3D readl(&priv_dev->regs->usb_cap6);
> +
> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
> +		readl(&priv_dev->regs->usb_cap6));
> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
> +		readl(&priv_dev->regs->usb_cap1));
> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
> +		readl(&priv_dev->regs->usb_cap2));
> +
> +	priv_dev->dev_ver =3D GET_DEV_BASE_VERSION(priv_dev->dev_ver);
> +
> +	priv_dev->zlp_buf =3D kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
> +	if (!priv_dev->zlp_buf) {
> +		ret =3D -ENOMEM;
> +		goto err3;
> +	}
> +
> +	/* add USB gadget device */
> +	ret =3D usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
> +	if (ret < 0) {
> +		dev_err(priv_dev->dev,
> +			"Failed to register USB device controller\n");
> +		goto err4;
> +	}
> +
> +	return 0;
> +err4:
> +	kfree(priv_dev->zlp_buf);
> +err3:
> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> +			  priv_dev->setup_dma);
> +err2:
> +	cdns3_free_all_eps(priv_dev);
> +err1:
> +	cdns->gadget_dev =3D NULL;
> +	return ret;
> +}
> +
> +static int __cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	int ret =3D 0;
> +
> +	cdns3_drd_switch_gadget(cdns, 1);
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	ret =3D cdns3_gadget_start(cdns);
> +	if (ret)
> +		return ret;
> +
> +	priv_dev =3D cdns->gadget_dev;
> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->dev_irq,
> +					cdns3_device_irq_handler,
> +					cdns3_device_thread_irq_handler,
> +					IRQF_SHARED, dev_name(cdns->dev), cdns);

copied handlers here for commenting. Note that you don't have
IRQF_ONESHOT:

> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
> +{
> +	struct cdns3_device *priv_dev;
> +	struct cdns3 *cdns =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	priv_dev =3D cdns->gadget_dev;
> +	spin_lock_irqsave(&priv_dev->lock, flags);

the top half handler runs in hardirq context. You don't need any locks
here. Also IRQs are *already* disabled, you don't need to disable them agai=
n.

> +
> +	/* check USB device interrupt */
> +	reg =3D readl(&priv_dev->regs->usb_ists);
> +
> +	if (reg) {
> +		writel(reg, &priv_dev->regs->usb_ists);
> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
> +		ret =3D IRQ_HANDLED;

now, because you _don't_ mask this interrupt, you're gonna have
issues. Say we actually get both device and endpoint interrupts while
the thread is already running with previous endpoint interrupts. Now
we're gonna reenter the top half, because device interrupts are *not*
masked, which will read usb_ists and handle it here.

Then it will ahead and read ep_ists and wake the thread that's already
running.

This hasn't really been tested, has it?

> +static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
> +{
> +	struct cdns3_device *priv_dev;
> +	struct cdns3 *cdns =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	unsigned long flags;
> +	u32 ep_ien;
> +	int bit;
> +	u32 reg;
> +
> +	priv_dev =3D cdns->gadget_dev;
> +	spin_lock_irqsave(&priv_dev->lock, flags);

Ideally, the _irqsave() here wouldn't be necessary (since this device's
interrupts are already masked), but removing _irqsave() causes problem
with networking gadgets. Just thought I'd leave a note here, nothing to
change in this handler.

> +	reg =3D readl(&priv_dev->regs->ep_ists);
> +
> +	/* handle default endpoint OUT */
> +	if (reg & EP_ISTS_EP_OUT0) {
> +		cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_OUT);
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	/* handle default endpoint IN */
> +	if (reg & EP_ISTS_EP_IN0) {
> +		cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_IN);
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	/* check if interrupt from non default endpoint, if no exit */
> +	reg &=3D ~(EP_ISTS_EP_OUT0 | EP_ISTS_EP_IN0);
> +	if (!reg)
> +		goto irqend;
> +
> +	for_each_set_bit(bit, (unsigned long *)&reg,
> +			 sizeof(u32) * BITS_PER_BYTE) {
> +		priv_dev->shadow_ep_en |=3D BIT(bit);
> +		cdns3_check_ep_interrupt_proceed(priv_dev->eps[bit]);
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	if (priv_dev->run_garbage_colector) {

wait, what?

ps: correct spelling is "collector" ;-)

> +		struct cdns3_aligned_buf *buf, *tmp;
> +
> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
> +					 list) {
> +			if (!buf->in_use) {
> +				list_del(&buf->list);
> +
> +				spin_unlock_irqrestore(&priv_dev->lock, flags);

creates the possibility of a race condition

> +				dma_free_coherent(priv_dev->sysdev, buf->size,
> +						  buf->buf,
> +						  buf->dma);
> +				spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +				kfree(buf);

why do you even need this "garbage collector"?

> +static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
> +{
> +	cdns3_gadget_exit(cdns);

so on suspend you completely teardown the entire controller? This means
that a mounted mass storage gadget will, actually, disconnect from the
host, no?

> diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
> new file mode 100644
> index 000000000000..1cc2abca320c
> --- /dev/null
> +++ b/drivers/usb/cdns3/trace.h
> @@ -0,0 +1,447 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USBSS device controller driver.
> + * Trace support header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cdns3
> +
> +#if !defined(__LINUX_CDNS3_TRACE) || defined(TRACE_HEADER_MULTI_READ)
> +#define __LINUX_CDNS3_TRACE
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +#include <asm/byteorder.h>
> +#include <linux/usb/ch9.h>
> +#include "core.h"
> +#include "gadget.h"
> +#include "debug.h"
> +
> +#define CDNS3_MSG_MAX	500
> +
> +TRACE_EVENT(cdns3_log,
> +	TP_PROTO(struct cdns3_device *priv_dev, struct va_format *vaf),
> +	TP_ARGS(priv_dev, vaf),
> +	TP_STRUCT__entry(
> +		__string(name, dev_name(priv_dev->dev))
> +		__dynamic_array(char, msg, CDNS3_MSG_MAX)
> +	),
> +	TP_fast_assign(
> +		__assign_str(name, dev_name(priv_dev->dev));
> +		vsnprintf(__get_str(msg), CDNS3_MSG_MAX, vaf->fmt, *vaf->va);
> +	),
> +	TP_printk("%s: %s", __get_str(name), __get_str(msg))
> +);
> +
> +DECLARE_EVENT_CLASS(cdns3_log_doorbell,
> +	TP_PROTO(const char *ep_name, u32 ep_trbaddr),
> +	TP_ARGS(ep_name, ep_trbaddr),
> +	TP_STRUCT__entry(
> +		__string(name, ep_name)
> +		__field(u32, ep_trbaddr)
> +	),
> +	TP_fast_assign(
> +		__assign_str(name, ep_name);
> +		__entry->ep_trbaddr =3D ep_trbaddr;
> +	),
> +	TP_printk("//Ding Dong %s, ep_trbaddr %08x", __get_str(name),

nit-picking but... the event name will be printed on trace log. You
don't need this "Ding Dong" string here :-p

> +	TP_printk("%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d,"
> +		  " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
> +		__get_str(name), __entry->req, __entry->buf, __entry->actual,
> +		__entry->length,
> +		__entry->zero ? "zero | " : "",
> +		__entry->short_not_ok ? "short | " : "",
> +		__entry->no_interrupt ? "no int" : "",

I guess you didn't really think the formatting through. Think about what
happens if you get a request with only zero flag or only short flag. How
will this log look like?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0i7JAACgkQzL64meEa
mQa0SRAA0QbauBgn1+5VjUBNWRDTgfhMJVocbpkZo/vbej4zcFE8fNOIudRmB1OQ
68JOTBfizhCZ19NSumgutpPLtLa6c/agaPUEZ3wbtf2fHj8ODXEiV//+S+O0IcuI
SoRvSNKoyFh/HD3cWh7FDruwonJhztJEHDemfkFYL8QKC7M7QdbddaTQTNWxzaQ/
vzuatBYU9Lv9oA51joS8xXOtwGnyxAAsmSjSiujwNkRHCYZxW/EFuqeq3aKimCES
8chSMwjRiA6gLhXrM6Qi56sAxD2ZhwExtui250EIJjstpI1Wl44WLSa7NmvJtsTA
7YfIPczFLEqT5OAJJ4LbUaL5uGuGz9LTYLe/ZIwrkB5+rh6B0yy/CIigaNKmiR7W
Yl2zbTek5f7tF3AZnCh3J5qE+6fK/xp2s3UZc+9LflXnurV6fYCW6VsqMjGroAUz
5/QHaaIf23rOQuIs+Fe1ZI3rjFLjQE4ilIzJ7r2sAZA8RsU2Jlnu5ayVnpmCJqcf
0PYK4EXFPbDNRx4kdvmJgd+q3btj0g41z3u0vlnQbpeo9+TzQ/puyZ2hQX5zunMc
qd5f9IRFmWPlyMTXCvwHNjgpN6dzCaLYtqIQ9dAeGTq/MHoR2xewvnsv5haYJeUs
x9TYrAt4DIRipHvXKnWvhlBYpRzjZ6/aOk9ukhvxwKc2XRIUrWc=
=UFAH
-----END PGP SIGNATURE-----
--=-=-=--
