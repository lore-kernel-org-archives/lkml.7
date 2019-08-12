Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A302085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dCzkjnfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfHLKFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:05:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53996 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfHLKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:05:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CA5inM117333;
        Mon, 12 Aug 2019 05:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565604344;
        bh=2squYM050JBpZFBL7wu2/TiVqNRBbePM/Vxhi0sruKY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dCzkjnfsNb9WFqvjmKkh7Bm+8Q+/VSmHnRbPAN1JBtSh40qAG+6SzhxhxR0axNVBC
         v3o02LJLeFYW7JlepFQ8KRvyimrCHNHLGXf1kj95amfCuCyy0x3ipAozM2pzzakk/S
         mGeNKJOzfLotwzvV1EaqUlHE6vyr3ACW/ibFU/F0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CA5i66122540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 05:05:44 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 05:05:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 05:05:43 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CA5e8I029957;
        Mon, 12 Aug 2019 05:05:41 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
 <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <c5c52dae-21c8-340a-cbca-5f269dabb890@ti.com>
Date:   Mon, 12 Aug 2019 13:05:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/08/2019 14:59, Pawel Laszczak wrote:
> Hi,
> 
>>
>> On 21/07/2019 21:32, Pawel Laszczak wrote:
>>> This patch introduce new Cadence USBSS DRD driver to Linux kernel.
>>>
>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>> Host Only (XHCI)configurations.
>>>
>>> The current driver has been validated with FPGA platform. We have
>>> support for PCIe bus, which is used on FPGA prototyping.
>>>
>>> The host side of USBSS-DRD controller is compliant with XHCI
>>> specification, so it works with standard XHCI Linux driver.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/Kconfig                |    2 +
>>>  drivers/usb/Makefile               |    2 +
>>>  drivers/usb/cdns3/Kconfig          |   46 +
>>>  drivers/usb/cdns3/Makefile         |   17 +
>>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  203 +++
>>>  drivers/usb/cdns3/core.c           |  554 +++++++
>>>  drivers/usb/cdns3/core.h           |  109 ++
>>>  drivers/usb/cdns3/debug.h          |  171 ++
>>>  drivers/usb/cdns3/debugfs.c        |   87 ++
>>>  drivers/usb/cdns3/drd.c            |  390 +++++
>>>  drivers/usb/cdns3/drd.h            |  166 ++
>>>  drivers/usb/cdns3/ep0.c            |  914 +++++++++++
>>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>>  drivers/usb/cdns3/gadget.c         | 2338 ++++++++++++++++++++++++++++
>>>  drivers/usb/cdns3/gadget.h         | 1321 ++++++++++++++++
>>>  drivers/usb/cdns3/host-export.h    |   28 +
>>>  drivers/usb/cdns3/host.c           |   71 +
>>>  drivers/usb/cdns3/trace.c          |   11 +
>>>  drivers/usb/cdns3/trace.h          |  493 ++++++
>>>  19 files changed, 6951 insertions(+)
>>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>>  create mode 100644 drivers/usb/cdns3/Makefile
>>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>>  create mode 100644 drivers/usb/cdns3/core.c
>>>  create mode 100644 drivers/usb/cdns3/core.h
>>>  create mode 100644 drivers/usb/cdns3/debug.h
>>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>>  create mode 100644 drivers/usb/cdns3/drd.c
>>>  create mode 100644 drivers/usb/cdns3/drd.h
>>>  create mode 100644 drivers/usb/cdns3/ep0.c
>>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>>  create mode 100644 drivers/usb/cdns3/gadget.h
>>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>>  create mode 100644 drivers/usb/cdns3/host.c
>>>  create mode 100644 drivers/usb/cdns3/trace.c
>>>  create mode 100644 drivers/usb/cdns3/trace.h
>>>

<snip>

>>
>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>> new file mode 100644
>>> index 000000000000..291f08be56fe
>>> --- /dev/null
>>> +++ b/drivers/usb/cdns3/gadget.c
>>> @@ -0,0 +1,2338 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Cadence USBSS DRD Driver - gadget side.
>>> + *
>>> + * Copyright (C) 2018-2019 Cadence Design Systems.
>>> + * Copyright (C) 2017-2018 NXP
>>> + *
>>> + * Authors: Pawel Jez <pjez@cadence.com>,
>>> + *          Pawel Laszczak <pawell@cadence.com>
>>> + *          Peter Chen <peter.chen@nxp.com>
>>> + */
>>> +
>>
>> <snip>
>>
>>> +/**
>>> + * cdns3_device_irq_handler- interrupt handler for device part of controller
>>> + *
>>> + * @irq: irq number for cdns3 core device
>>> + * @data: structure of cdns3
>>> + *
>>> + * Returns IRQ_HANDLED or IRQ_NONE
>>> + */
>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>> +{
>>> +	struct cdns3_device *priv_dev;
>>> +	struct cdns3 *cdns = data;
>>> +	irqreturn_t ret = IRQ_NONE;
>>> +	unsigned long flags;
>>> +	u32 reg;
>>> +
>>> +	priv_dev = cdns->gadget_dev;
>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>> +
>>> +	/* check USB device interrupt */
>>> +	reg = readl(&priv_dev->regs->usb_ists);
>>> +
>>> +	if (reg) {
>>> +		writel(reg, &priv_dev->regs->usb_ists);
>>
>> Do we need to mask device interrupts till thread handler has done processing
>> current set of events?
> 
> Yes, we need do this to avoid raising the next the same interrupts. 
> If we return back from hard irq handler without clearing reported interrupts,
> then system report them again. The solution for this is to use IRQF_ONESHOT
> flag during registering interrupt, but I can't use this flag 
> because I have shared interrupt line with other component. 
> 
> In this version these (usb_ists) interrupts are handled in hard irq, but in next version
> will be moved to thread handler. 
> 
>>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>>> +		ret = IRQ_HANDLED;
>>> +	}
>>> +
>>> +	/* check endpoint interrupt */
>>> +	reg = readl(&priv_dev->regs->ep_ists);
>>> +
>>> +	if (reg) {
>>> +		priv_dev->shadow_ep_en |= reg;
>>> +		reg = ~reg & readl(&priv_dev->regs->ep_ien);
>>> +		/* mask deferred interrupt. */
>>> +		writel(reg, &priv_dev->regs->ep_ien);
>>> +		ret = IRQ_WAKE_THREAD;
>>> +	}
>>> +
>>> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>> +	return ret;
>>> +}
>>> +
>>
>> <snip>
>>
>>> +
>>> +static int cdns3_gadget_start(struct cdns3 *cdns)
>>> +{
>>> +	struct cdns3_device *priv_dev;
>>> +	u32 max_speed;
>>> +	int ret;
>>> +
>>> +	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
>>> +	if (!priv_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	cdns->gadget_dev = priv_dev;
>>> +	priv_dev->sysdev = cdns->dev;
>>> +	priv_dev->dev = cdns->dev;
>>> +	priv_dev->regs = cdns->dev_regs;
>>> +
>>> +	device_property_read_u16(priv_dev->dev, "cdns,on-chip-buff-size",
>>> +				 &priv_dev->onchip_buffers);
>>> +
>>> +	if (priv_dev->onchip_buffers <=  0) {
>>> +		u32 reg = readl(&priv_dev->regs->usb_cap2);
>>> +
>>> +		priv_dev->onchip_buffers = USB_CAP2_ACTUAL_MEM_SIZE(reg);
>>> +	}
>>> +
>>> +	if (!priv_dev->onchip_buffers)
>>> +		priv_dev->onchip_buffers = 256;
>>> +
>>> +	max_speed = usb_get_maximum_speed(cdns->dev);
>>> +
>>> +	/* Check the maximum_speed parameter */
>>> +	switch (max_speed) {
>>> +	case USB_SPEED_FULL:
>>
>> In this case we need to limit controller max speed to full-speed as system
>> integrator would expect that. e.g. in DT node, maximum-speed = "full-speed";
>>
>> I suppose we need to set the force Full-speed bit here?
>>
>>> +	case USB_SPEED_HIGH:
>>
>> Here we need to restrict device controller max-speed to high-speed.
>>
> 
> Why system integrator would limit the speed of controller? 

To save cost? For many use cases, high-speed is more then sufficient.

> For debugging purpose it's  ok, but in production system it's better 
> to use higher speed.
> Do we relay need such functionality ?

Mostly for testing purpose. I can just change the DT node's speed property
to the lower speed to limit the controller to that speed.

If we can achieve that with a few lines of code, why not support it?

> 
>>> +	case USB_SPEED_SUPER:
>>> +		break;
>>> +	default:
>>> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
>>> +			max_speed);
>>> +		/* fall through */
>>> +	case USB_SPEED_UNKNOWN:
>>> +		/* default to superspeed */
>>> +		max_speed = USB_SPEED_SUPER;
>>> +		break;
>>> +	}
>>> +
>>> +	/* fill gadget fields */
>>> +	priv_dev->gadget.max_speed = max_speed;
>>> +	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
>>> +	priv_dev->gadget.ops = &cdns3_gadget_ops;
>>> +	priv_dev->gadget.name = "usb-ss-gadget";
>>> +	priv_dev->gadget.sg_supported = 1;
>>> +
>>> +	spin_lock_init(&priv_dev->lock);
>>> +	INIT_WORK(&priv_dev->pending_status_wq,
>>> +		  cdns3_pending_setup_status_handler);
>>> +
>>> +	/* initialize endpoint container */
>>> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>>> +	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
>>> +
>>> +	ret = cdns3_init_eps(priv_dev);
>>> +	if (ret) {
>>> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
>>> +		goto err1;
>>> +	}
>>> +
>>> +	/* allocate memory for setup packet buffer */
>>> +	priv_dev->setup_buf = dma_alloc_coherent(priv_dev->sysdev, 8,
>>> +						 &priv_dev->setup_dma, GFP_DMA);
>>> +	if (!priv_dev->setup_buf) {
>>> +		ret = -ENOMEM;
>>> +		goto err2;
>>> +	}
>>> +
>>> +	priv_dev->dev_ver = readl(&priv_dev->regs->usb_cap6);
>>> +
>>> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
>>> +		readl(&priv_dev->regs->usb_cap6));
>>> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
>>> +		readl(&priv_dev->regs->usb_cap1));
>>> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
>>> +		readl(&priv_dev->regs->usb_cap2));
>>> +
>>> +	priv_dev->dev_ver = GET_DEV_BASE_VERSION(priv_dev->dev_ver);
>>> +
>>> +	priv_dev->zlp_buf = kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
>>> +	if (!priv_dev->zlp_buf) {
>>> +		ret = -ENOMEM;
>>> +		goto err3;
>>> +	}
>>> +
>>> +	/* add USB gadget device */
>>> +	ret = usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
>>> +	if (ret < 0) {
>>> +		dev_err(priv_dev->dev,
>>> +			"Failed to register USB device controller\n");
>>> +		goto err4;
>>> +	}
>>> +
>>> +	return 0;
>>> +err4:
>>> +	kfree(priv_dev->zlp_buf);
>>> +err3:
>>> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>>> +			  priv_dev->setup_dma);
>>> +err2:
>>> +	cdns3_free_all_eps(priv_dev);
>>> +err1:
>>> +	cdns->gadget_dev = NULL;
>>> +	return ret;
>>> +}
>>> +
>>

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
