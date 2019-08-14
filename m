Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B27C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B88206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdYwQLhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfHNNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:38:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47112 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHNNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:38:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7EDcKTR075923;
        Wed, 14 Aug 2019 08:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565789900;
        bh=aThyHL8ApwvdhvY3BnDVs0kFkolqrKiAquo0tskXkcg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IdYwQLhGto2moxtF4RXiQKJEPdAyT1FbAHYmlU/u5t+GnknGuqF2ookzKY2qbPLJI
         bvcjQQv6PzOzK+0lxODlqcqlpgf5W1WHQIUp/7wTpK3pWTpx4UGv1jDZ+l9DI6KbHo
         OzPdWRE3N7IZnctJF06lL1Rti/bm2x1L9Q2f1OXk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7EDcKi0130999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Aug 2019 08:38:20 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 14
 Aug 2019 08:38:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 14 Aug 2019 08:38:20 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7EDcHrH100252;
        Wed, 14 Aug 2019 08:38:17 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <2c5ed505-6fee-1816-e5bb-59a9ed96fb70@ti.com>
Date:   Wed, 14 Aug 2019 16:38:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563733939-21214-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2019 21:32, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to Linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA platform. We have
> support for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliant with XHCI
> specification, so it works with standard XHCI Linux driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   46 +
>  drivers/usb/cdns3/Makefile         |   17 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  203 +++
>  drivers/usb/cdns3/core.c           |  554 +++++++
>  drivers/usb/cdns3/core.h           |  109 ++
>  drivers/usb/cdns3/debug.h          |  171 ++
>  drivers/usb/cdns3/debugfs.c        |   87 ++
>  drivers/usb/cdns3/drd.c            |  390 +++++
>  drivers/usb/cdns3/drd.h            |  166 ++
>  drivers/usb/cdns3/ep0.c            |  914 +++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 2338 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1321 ++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   71 +
>  drivers/usb/cdns3/trace.c          |   11 +
>  drivers/usb/cdns3/trace.h          |  493 ++++++
>  19 files changed, 6951 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
> 

<snip>

> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> new file mode 100644
> index 000000000000..291f08be56fe
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,2338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018-2019 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *          Peter Chen <peter.chen@nxp.com>
> + */
> +

<snip>

> +
> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> +{
> +	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +	u32 reg;
> +
> +	cdns3_ep0_config(priv_dev);
> +
> +	/* enable interrupts for endpoint 0 (in and out) */
> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
> +
> +	/*
> +	 * Driver needs to modify LFPS minimal U1 Exit time for DEV_VER_TI_V1
> +	 * revision of controller.
> +	 */
> +	if (priv_dev->dev_ver == DEV_VER_TI_V1) {
> +		reg = readl(&regs->dbg_link1);
> +
> +		reg &= ~DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_MASK;
> +		reg |= DBG_LINK1_LFPS_MIN_GEN_U1_EXIT(0x55) |
> +		       DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_SET;
> +		writel(reg, &regs->dbg_link1);
> +	}
> +
> +	/*
> +	 * By default some platforms has set protected access to memory.
> +	 * This cause problem with cache, so driver restore non-secure
> +	 * access to memory.
> +	 */
> +	reg = readl(&regs->dma_axi_ctrl);

Why read the reg at all if you are just overwriting it below?

> +	reg = DMA_AXI_CTRL_MARPROT(DMA_AXI_CTRL_NON_SECURE) |
> +	      DMA_AXI_CTRL_MAWPROT(DMA_AXI_CTRL_NON_SECURE);


Otherwise you need to read modify only necessary bits and then write.
i.e.
	#define DMA_AXI_CTRL_MAPROT_MASK 0x3
	reg &= ~(DMA_AXI_CTRL_MARPROT(DMA_AXI_CTRL_MAPROT_MASK) |
		 DMA_AXI_CTRL_MARPROT(DMA_AXI_CTRL_MAPROT_MASK))
	reg |= DMA_AXI_CTRL_MARPROT(DMA_AXI_CTRL_NON_SECURE) |
	       DMA_AXI_CTRL_MAWPROT(DMA_AXI_CTRL_NON_SECURE);

> +	writel(reg, &regs->dma_axi_ctrl);
> +
> +	/* enable generic interrupt*/
> +	writel(USB_IEN_INIT, &regs->usb_ien);
> +	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
> +
> +	cdns3_configure_dmult(priv_dev, NULL);
> +
> +	cdns3_gadget_pullup(&priv_dev->gadget, 1);
> +}
> +

<snip>

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
