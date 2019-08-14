Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C62C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73886206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JVebO4Qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfHNNcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:32:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46378 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:32:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7EDWeEs074337;
        Wed, 14 Aug 2019 08:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565789560;
        bh=bP6yJ5KyyLgh/I8Hoz2ZupwsCPy9IW5wvvEMIoyaQQA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JVebO4Qtb7VM8gLQc9DzBim9b9QOF/QqDSQnffxnb+sOqcWALPireh39clM96Y6G3
         DxIAKOTach7VIHgRKOylOrpictd9QZGc8bM0MU0S8alB3An8vA9NY/V7zxPj9lKhuC
         rORcKwnhAEmSlQrOKxp53B9OOc98yx6QDhMKY3I4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7EDWeSZ004010
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Aug 2019 08:32:40 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 14
 Aug 2019 08:32:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 14 Aug 2019 08:32:39 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7EDWawL091594;
        Wed, 14 Aug 2019 08:32:36 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <8eb0194a-ee7d-3880-81a7-482ed6e3f759@ti.com>
Date:   Wed, 14 Aug 2019 16:32:35 +0300
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

It is getting really hard to review this patch as it is so large.
I would still suggest to split host/gadget/drd if possible.
Felipe, any objections?

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

> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> new file mode 100644
> index 000000000000..2a97c16aea4b
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -0,0 +1,1321 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USBSS device controller driver header file
> + *
> + * Copyright (C) 2018-2019 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *         Pawel Jez <pjez@cadence.com>
> + *         Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_GADGET
> +#define __LINUX_CDNS3_GADGET
> +#include <linux/usb/gadget.h>
> +
> +/*
> + * USBSS-DEV register interface.
> + * This corresponds to the USBSS Device Controller Interface
> + */
> +
> +/**
> + * struct cdns3_usb_regs - device controller registers.
> + * @usb_conf:      Global Configuration Register.
> + * @usb_sts:       Global Status Register.
> + * @usb_cmd:       Global Command Register.
> + * @usb_itpn:      ITP/SOF number Register.
> + * @usb_lpm:       Global Command Register.
> + * @usb_ien:       USB Interrupt Enable Register.
> + * @usb_ists:      USB Interrupt Status Register.
> + * @ep_sel:        Endpoint Select Register.
> + * @ep_traddr:     Endpoint Transfer Ring Address Register.
> + * @ep_cfg:        Endpoint Configuration Register.
> + * @ep_cmd:        Endpoint Command Register.
> + * @ep_sts:        Endpoint Status Register.
> + * @ep_sts_sid:    Endpoint Status Register.
> + * @ep_sts_en:     Endpoint Status Register Enable.
> + * @drbl:          Doorbell Register.
> + * @ep_ien:        EP Interrupt Enable Register.
> + * @ep_ists:       EP Interrupt Status Register.
> + * @usb_pwr:       Global Power Configuration Register.
> + * @usb_conf2:     Global Configuration Register 2.
> + * @usb_cap1:      Capability Register 1.
> + * @usb_cap2:      Capability Register 2.
> + * @usb_cap3:      Capability Register 3.
> + * @usb_cap4:      Capability Register 4.
> + * @usb_cap5:      Capability Register 5.
> + * @usb_cap6:      Capability Register 6.
> + * @usb_cpkt1:     Custom Packet Register 1.
> + * @usb_cpkt2:     Custom Packet Register 2.
> + * @usb_cpkt3:     Custom Packet Register 3.
> + * @ep_dma_ext_addr: Upper address for DMA operations Register.
> + * @buf_addr:      Address for On-chip Buffer operations Register.
> + * @buf_data:      Data for On-chip Buffer operations Register.
> + * @buf_ctrl:      On-chip Buffer Access Control Registe.

/Registe./Register.

We know these are registers so probably could remove "Register" from
everywhere

> + * @dtrans:        DMA Transfer Mode Register.
> + * @tdl_from_trb:  Source of TD Configuration Register.
> + * @tdl_beh:       TDL Behavior Configuration Register.
> + * @ep_tdl:        Endpoint TDL Register.
> + * @tdl_beh2:      TDL Behavior 2 Configuration Register.
> + * @dma_adv_td:    DMA Advance TD Configuration Register.
> + * @reserved1:     Reserved.
> + * @cfg_regs:      Configuration registers.
> + * @reserved2:     Reserved.
> + * @dma_axi_ctrl:  AXI Control register.
> + * @dma_axi_id:    AXI ID register.
> + * @dma_axi_cap:   AXI Capability register.
> + * @dma_axi_ctrl0: AXI Control 0 register.
> + * @dma_axi_ctrl1: AXI Control 1 register.
> + */
> +struct cdns3_usb_regs {
> +	__le32 usb_conf;
> +	__le32 usb_sts;
> +	__le32 usb_cmd;
> +	__le32 usb_itpn;
> +	__le32 usb_lpm;
> +	__le32 usb_ien;
> +	__le32 usb_ists;
> +	__le32 ep_sel;
> +	__le32 ep_traddr;
> +	__le32 ep_cfg;
> +	__le32 ep_cmd;
> +	__le32 ep_sts;
> +	__le32 ep_sts_sid;
> +	__le32 ep_sts_en;
> +	__le32 drbl;
> +	__le32 ep_ien;
> +	__le32 ep_ists;
> +	__le32 usb_pwr;
> +	__le32 usb_conf2;
> +	__le32 usb_cap1;
> +	__le32 usb_cap2;
> +	__le32 usb_cap3;
> +	__le32 usb_cap4;
> +	__le32 usb_cap5;
> +	__le32 usb_cap6;
> +	__le32 usb_cpkt1;
> +	__le32 usb_cpkt2;
> +	__le32 usb_cpkt3;
> +	__le32 ep_dma_ext_addr;
> +	__le32 buf_addr;
> +	__le32 buf_data;
> +	__le32 buf_ctrl;
> +	__le32 dtrans;
> +	__le32 tdl_from_trb;
> +	__le32 tdl_beh;
> +	__le32 ep_tdl;
> +	__le32 tdl_beh2;
> +	__le32 dma_adv_td;

I don't see above registers after buf_ctrl in
programming guide. Are they applicable for V1?

> +	__le32 reserved1[26];
> +	__le32 cfg_reg1;
> +	__le32 dbg_link1;
> +	__le32 dbg_link2;
> +	__le32 cfg_regs[74];
> +	__le32 reserved2[51];
> +	__le32 dma_axi_ctrl;

dma_axi_ctrl shows up at offset 0x2bc instead of 0x300.
So we probably need to increase reserve2 size from 34 to 51.

> +	__le32 dma_axi_id;
> +	__le32 dma_axi_cap;
> +	__le32 dma_axi_ctrl0;
> +	__le32 dma_axi_ctrl1;
> +};
> +
> +/* USB_CONF - bitmasks */
> +/* Reset USB device configuration. */
> +#define USB_CONF_CFGRST		BIT(0)
> +/* Set Configuration. */
> +#define USB_CONF_CFGSET		BIT(1)
> +/* Disconnect USB device in SuperSpeed. */
> +#define USB_CONF_USB3DIS	BIT(3)
> +/* Disconnect USB device in HS/FS */
> +#define USB_CONF_USB2DIS	BIT(4)
> +/* Little Endian access - default */
> +#define USB_CONF_LENDIAN	BIT(5)
> +/*
> + * Big Endian access. Driver assume that byte order for
> + * SFRs access always is as Little Endian so this bit
> + * is not used.
> + */
> +#define USB_CONF_BENDIAN	BIT(6)
> +/* Device software reset. */
> +#define USB_CONF_SWRST		BIT(7)
> +/* Singular DMA transfer mode. Only for VER < DEV_VER_V3*/
> +#define USB_CONF_DSING		BIT(8)
> +/* Multiple DMA transfers mode. Only for VER < DEV_VER_V3 */
> +#define USB_CONF_DMULT		BIT(9)
> +/* DMA clock turn-off enable. */
> +#define USB_CONF_DMAOFFEN	BIT(10)
> +/* DMA clock turn-off disable. */
> +#define USB_CONF_DMAOFFDS	BIT(11)
> +/* Clear Force Full Speed. */
> +#define USB_CONF_CFORCE_FS	BIT(12)
> +/* Set Force Full Speed. */
> +#define USB_CONF_SFORCE_FS	BIT(13)
> +/* Device enable. */
> +#define USB_CONF_DEVEN		BIT(14)
> +/* Device disable. */
> +#define USB_CONF_DEVDS		BIT(15)
> +/* L1 LPM state entry enable (used in HS/FS mode). */
> +#define USB_CONF_L1EN		BIT(16)
> +/* L1 LPM state entry disable (used in HS/FS mode). */
> +#define USB_CONF_L1DS		BIT(17)
> +/* USB 2.0 clock gate disable. */
> +#define USB_CONF_CLK2OFFEN	BIT(18)
> +/* USB 2.0 clock gate enable. */
> +#define USB_CONF_CLK2OFFDS	BIT(19)
> +/* L0 LPM state entry request (used in HS/FS mode). */
> +#define USB_CONF_LGO_L0		BIT(20)
> +/* USB 3.0 clock gate disable. */
> +#define USB_CONF_CLK3OFFEN	BIT(21)
> +/* USB 3.0 clock gate enable. */
> +#define USB_CONF_CLK3OFFDS	BIT(22)
> +/* Bit 23 is reserved*/
> +/* U1 state entry enable (used in SS mode). */
> +#define USB_CONF_U1EN		BIT(24)
> +/* U1 state entry disable (used in SS mode). */
> +#define USB_CONF_U1DS		BIT(25)
> +/* U2 state entry enable (used in SS mode). */
> +#define USB_CONF_U2EN		BIT(26)
> +/* U2 state entry disable (used in SS mode). */
> +#define USB_CONF_U2DS		BIT(27)
> +/* U0 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U0		BIT(28)
> +/* U1 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U1		BIT(29)
> +/* U2 state entry request (used in SS mode). */
> +#define USB_CONF_LGO_U2		BIT(30)
> +/* SS.Inactive state entry request (used in SS mode) */
> +#define USB_CONF_LGO_SSINACT	BIT(31)
> +
> +/* USB_STS - bitmasks */
> +/*
> + * Configuration status.
> + * 1 - device is in the configured state.
> + * 0 - device is not configured.
> + */
> +#define USB_STS_CFGSTS_MASK	BIT(0)
> +#define USB_STS_CFGSTS(p)	((p) & USB_STS_CFGSTS_MASK)
> +/*
> + * On-chip memory overflow.
> + * 0 - On-chip memory status OK.
> + * 1 - On-chip memory overflow.
> + */
> +#define USB_STS_OV_MASK		BIT(1)
> +#define USB_STS_OV(p)		((p) & USB_STS_OV_MASK)
> +/*
> + * SuperSpeed connection status.
> + * 0 - USB in SuperSpeed mode disconnected.
> + * 1 - USB in SuperSpeed mode connected.
> + */
> +#define USB_STS_USB3CONS_MASK	BIT(2)
> +#define USB_STS_USB3CONS(p)	((p) & USB_STS_USB3CONS_MASK)
> +/*
> + * DMA transfer configuration status.
> + * 0 - single request.
> + * 1 - multiple TRB chain
> + * Supported only for controller version <  DEV_VER_V3
> + */
> +#define USB_STS_DTRANS_MASK	BIT(3)
> +#define USB_STS_DTRANS(p)	((p) & USB_STS_DTRANS_MASK)
> +/*
> + * Device speed.
> + * 0 - Undefined (value after reset).
> + * 1 - Low speed
> + * 2 - Full speed
> + * 3 - High speed
> + * 4 - Super speed
> + */
> +#define USB_STS_USBSPEED_MASK	GENMASK(6, 4)
> +#define USB_STS_USBSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) >> 4)
> +#define USB_STS_LS		(0x1 << 4)
> +#define USB_STS_FS		(0x2 << 4)
> +#define USB_STS_HS		(0x3 << 4)
> +#define USB_STS_SS		(0x4 << 4)
> +#define DEV_UNDEFSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == (0x0 << 4))
> +#define DEV_LOWSPEED(p)		(((p) & USB_STS_USBSPEED_MASK) == USB_STS_LS)
> +#define DEV_FULLSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_FS)
> +#define DEV_HIGHSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_HS)
> +#define DEV_SUPERSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_SS)
> +/*
> + * Endianness for SFR access.
> + * 0 - Little Endian order (default after hardware reset).
> + * 1 - Big Endian order
> + */
> +#define USB_STS_ENDIAN_MASK	BIT(7)
> +#define USB_STS_ENDIAN(p)	((p) & USB_STS_ENDIAN_MASK)
> +/*
> + * HS/FS clock turn-off status.
> + * 0 - hsfs clock is always on.
> + * 1 - hsfs clock turn-off in L2 (HS/FS mode) is enabled
> + *          (default after hardware reset).
> + */
> +#define USB_STS_CLK2OFF_MASK	BIT(8)
> +#define USB_STS_CLK2OFF(p)	((p) & USB_STS_CLK2OFF_MASK)
> +/*
> + * PCLK clock turn-off status.
> + * 0 - pclk clock is always on.
> + * 1 - pclk clock turn-off in U3 (SS mode) is enabled
> + *          (default after hardware reset).
> + */
> +#define USB_STS_CLK3OFF_MASK	BIT(9)
> +#define USB_STS_CLK3OFF(p)	((p) & USB_STS_CLK3OFF_MASK)
> +/*
> + * Controller in reset state.
> + * 0 - Internal reset is active.
> + * 1 - Internal reset is not active and controller is fully operational.
> + */
> +#define USB_STS_IN_RST_MASK	BIT(10)
> +#define USB_STS_IN_RST(p)	((p) & USB_STS_IN_RST_MASK)
> +/*
> + * Status of the "TDL calculation basing on TRB" feature.
> + * 0 - disabled
> + * 1 - enabled
> + * Supported only for DEV_VER_V2 controller version.
> + */
> +#define USB_STS_TDL_TRB_ENABLED	BIT(11)
> +/*
> + * Device enable Status.
> + * 0 - USB device is disabled (VBUS input is disconnected from internal logic).
> + * 1 - USB device is enabled (VBUS input is connected to the internal logic).
> + */
> +#define USB_STS_DEVS_MASK	BIT(14)
> +#define USB_STS_DEVS(p)		((p) & USB_STS_DEVS_MASK)
> +/*
> + * Address status.
> + * 0 - USB device is default state.
> + * 1 - USB device is at least in address state.
> + */
> +#define USB_STS_ADDRESSED_MASK	BIT(15)
> +#define USB_STS_ADDRESSED(p)	((p) & USB_STS_ADDRESSED_MASK)
> +/*
> + * L1 LPM state enable status (used in HS/FS mode).
> + * 0 - Entering to L1 LPM state disabled.
> + * 1 - Entering to L1 LPM state enabled.
> + */
> +#define USB_STS_L1ENS_MASK	BIT(16)
> +#define USB_STS_L1ENS(p)	((p) & USB_STS_L1ENS_MASK)
> +/*
> + * Internal VBUS connection status (used both in HS/FS  and SS mode).
> + * 0 - internal VBUS is not detected.
> + * 1 - internal VBUS is detected.
> + */
> +#define USB_STS_VBUSS_MASK	BIT(17)
> +#define USB_STS_VBUSS(p)	((p) & USB_STS_VBUSS_MASK)
> +/*
> + * HS/FS LPM  state (used in FS/HS mode).
> + * 0 - L0 State
> + * 1 - L1 State
> + * 2 - L2 State
> + * 3 - L3 State
> + */
> +#define USB_STS_LPMST_MASK	GENMASK(19, 18)
> +#define DEV_L0_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x0 << 18))
> +#define DEV_L1_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x1 << 18))
> +#define DEV_L2_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x2 << 18))
> +#define DEV_L3_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x3 << 18))
> +/*
> + * Disable HS status (used in FS/HS mode).
> + * 0 - the disconnect bit for HS/FS mode is set .
> + * 1 - the disconnect bit for HS/FS mode is not set.
> + */
> +#define USB_STS_USB2CONS_MASK	BIT(20)
> +#define USB_STS_USB2CONS(p)	((p) & USB_STS_USB2CONS_MASK)
> +/*
> + * HS/FS mode connection status (used in FS/HS mode).
> + * 0 - High Speed operations in USB2.0 (FS/HS) mode not disabled.
> + * 1 - High Speed operations in USB2.0 (FS/HS).
> + */
> +#define USB_STS_DISABLE_HS_MASK	BIT(21)
> +#define USB_STS_DISABLE_HS(p)	((p) & USB_STS_DISABLE_HS_MASK)
> +/*
> + * U1 state enable status (used in SS mode).
> + * 0 - Entering to  U1 state disabled.
> + * 1 - Entering to  U1 state enabled.
> + */
> +#define USB_STS_U1ENS_MASK	BIT(24)
> +#define USB_STS_U1ENS(p)	((p) & USB_STS_U1ENS_MASK)
> +/*
> + * U2 state enable status (used in SS mode).
> + * 0 - Entering to  U2 state disabled.
> + * 1 - Entering to  U2 state enabled.
> + */
> +#define USB_STS_U2ENS_MASK	BIT(25)
> +#define USB_STS_U2ENS(p)	((p) & USB_STS_U2ENS_MASK)
> +/*
> + * SuperSpeed Link LTSSM state. This field reflects USBSS-DEV current
> + * SuperSpeed link state
> + */
> +#define USB_STS_LST_MASK	GENMASK(29, 26)
> +#define DEV_LST_U0		(((p) & USB_STS_LST_MASK) == (0x0 << 26))
> +#define DEV_LST_U1		(((p) & USB_STS_LST_MASK) == (0x1 << 26))
> +#define DEV_LST_U2		(((p) & USB_STS_LST_MASK) == (0x2 << 26))
> +#define DEV_LST_U3		(((p) & USB_STS_LST_MASK) == (0x3 << 26))
> +#define DEV_LST_DISABLED	(((p) & USB_STS_LST_MASK) == (0x4 << 26))
> +#define DEV_LST_RXDETECT	(((p) & USB_STS_LST_MASK) == (0x5 << 26))
> +#define DEV_LST_INACTIVE	(((p) & USB_STS_LST_MASK) == (0x6 << 26))
> +#define DEV_LST_POLLING		(((p) & USB_STS_LST_MASK) == (0x7 << 26))
> +#define DEV_LST_RECOVERY	(((p) & USB_STS_LST_MASK) == (0x8 << 26))
> +#define DEV_LST_HOT_RESET	(((p) & USB_STS_LST_MASK) == (0x9 << 26))
> +#define DEV_LST_COMP_MODE	(((p) & USB_STS_LST_MASK) == (0xa << 26))
> +#define DEV_LST_LB_STATE	(((p) & USB_STS_LST_MASK) == (0xb << 26))
> +/*
> + * DMA clock turn-off status.
> + * 0 - DMA clock is always on (default after hardware reset).
> + * 1 - DMA clock turn-off in U1, U2 and U3 (SS mode) is enabled.
> + */
> +#define USB_STS_DMAOFF_MASK	BIT(30)
> +#define USB_STS_DMAOFF(p)	((p) & USB_STS_DMAOFF_MASK)
> +/*
> + * SFR Endian status.
> + * 0 - Little Endian order (default after hardware reset).
> + * 1 - Big Endian order.
> + */
> +#define USB_STS_ENDIAN2_MASK	BIT(31)
> +#define USB_STS_ENDIAN2(p)	((p) & USB_STS_ENDIAN2_MASK)
> +
> +/* USB_CMD -  bitmasks */
> +/* Set Function Address */
> +#define USB_CMD_SET_ADDR	BIT(0)
> +/*
> + * Function Address This field is saved to the device only when the field
> + * SET_ADDR is set '1 ' during write to USB_CMD register.
> + * Software is responsible for entering the address of the device during
> + * SET_ADDRESS request service. This field should be set immediately after
> + * the SETUP packet is decoded, and prior to confirmation of the status phase
> + */
> +#define USB_CMD_FADDR_MASK	GENMASK(7, 1)
> +#define USB_CMD_FADDR(p)	(((p) << 1) & USB_CMD_FADDR_MASK)
> +/* Send Function Wake Device Notification TP (used only in SS mode). */
> +#define USB_CMD_SDNFW		BIT(8)
> +/* Set Test Mode (used only in HS/FS mode). */
> +#define USB_CMD_STMODE		BIT(9)
> +/* Test mode selector (used only in HS/FS mode) */
> +#define USB_STS_TMODE_SEL_MASK	GENMASK(11, 10)
> +#define USB_STS_TMODE_SEL(p)	(((p) << 10) & USB_STS_TMODE_SEL_MASK)
> +/*
> + *  Send Latency Tolerance Message Device Notification TP (used only
> + *  in SS mode).
> + */
> +#define USB_CMD_SDNLTM		BIT(12)
> +/* Send Custom Transaction Packet (used only in SS mode) */
> +#define USB_CMD_SPKT		BIT(13)
> +/*Device Notification 'Function Wake' - Interface value (only in SS mode. */
> +#define USB_CMD_DNFW_INT_MASK	GENMASK(23, 16)
> +#define USB_STS_DNFW_INT(p)	(((p) << 16) & USB_CMD_DNFW_INT_MASK)
> +/*
> + * Device Notification 'Latency Tolerance Message' -373 BELT value [7:0]
> + * (used only in SS mode).
> + */
> +#define USB_CMD_DNLTM_BELT_MASK	GENMASK(27, 16)
> +#define USB_STS_DNLTM_BELT(p)	(((p) << 16) & USB_CMD_DNLTM_BELT_MASK)
> +
> +/* USB_ITPN - bitmasks */
> +/*
> + * ITP(SS) / SOF (HS/FS) number
> + * In SS mode this field represent number of last ITP received from host.
> + * In HS/FS mode this field represent number of last SOF received from host.
> + */
> +#define USB_ITPN_MASK		GENMASK(13, 0)
> +#define USB_ITPN(p)		((p) & USB_ITPN_MASK)
> +
> +/* USB_LPM - bitmasks */
> +/* Host Initiated Resume Duration. */
> +#define USB_LPM_HIRD_MASK	GENMASK(3, 0)
> +#define USB_LPM_HIRD(p)		((p) & USB_LPM_HIRD_MASK)
> +/* Remote Wakeup Enable (bRemoteWake). */
> +#define USB_LPM_BRW		BIT(4)
> +
> +/* USB_IEN - bitmasks */
> +/* SS connection interrupt enable */
> +#define USB_IEN_CONIEN		BIT(0)
> +/* SS disconnection interrupt enable. */
> +#define USB_IEN_DISIEN		BIT(1)
> +/* USB SS warm reset interrupt enable. */
> +#define USB_IEN_UWRESIEN	BIT(2)
> +/* USB SS hot reset interrupt enable */
> +#define USB_IEN_UHRESIEN	BIT(3)
> +/* SS link U3 state enter interrupt enable (suspend).*/
> +#define USB_IEN_U3ENTIEN	BIT(4)
> +/* SS link U3 state exit interrupt enable (wakeup). */
> +#define USB_IEN_U3EXTIEN	BIT(5)
> +/* SS link U2 state enter interrupt enable.*/
> +#define USB_IEN_U2ENTIEN	BIT(6)
> +/* SS link U2 state exit interrupt enable.*/
> +#define USB_IEN_U2EXTIEN	BIT(7)
> +/* SS link U1 state enter interrupt enable.*/
> +#define USB_IEN_U1ENTIEN	BIT(8)
> +/* SS link U1 state exit interrupt enable.*/
> +#define USB_IEN_U1EXTIEN	BIT(9)
> +/* ITP/SOF packet detected interrupt enable.*/
> +#define USB_IEN_ITPIEN		BIT(10)
> +/* Wakeup interrupt enable.*/
> +#define USB_IEN_WAKEIEN		BIT(11)
> +/* Send Custom Packet interrupt enable.*/
> +#define USB_IEN_SPKTIEN		BIT(12)
> +/* HS/FS mode connection interrupt enable.*/
> +#define USB_IEN_CON2IEN		BIT(16)
> +/* HS/FS mode disconnection interrupt enable.*/
> +#define USB_IEN_DIS2IEN		BIT(17)
> +/* USB reset (HS/FS mode) interrupt enable.*/
> +#define USB_IEN_U2RESIEN	BIT(18)
> +/* LPM L2 state enter interrupt enable.*/
> +#define USB_IEN_L2ENTIEN	BIT(20)
> +/* LPM  L2 state exit interrupt enable.*/
> +#define USB_IEN_L2EXTIEN	BIT(21)
> +/* LPM L1 state enter interrupt enable.*/
> +#define USB_IEN_L1ENTIEN	BIT(24)
> +/* LPM  L1 state exit interrupt enable.*/
> +#define USB_IEN_L1EXTIEN	BIT(25)
> +/* Configuration reset interrupt enable.*/
> +#define USB_IEN_CFGRESIEN	BIT(26)
> +/* Start of the USB SS warm reset interrupt enable.*/
> +#define USB_IEN_UWRESSIEN	BIT(28)
> +/* End of the USB SS warm reset interrupt enable.*/
> +#define USB_IEN_UWRESEIEN	BIT(29)
> +
> +#define USB_IEN_INIT  (USB_IEN_U2RESIEN | USB_ISTS_DIS2I | USB_IEN_CON2IEN \
> +		       | USB_IEN_UHRESIEN | USB_IEN_UWRESIEN | USB_IEN_DISIEN \
> +		       | USB_IEN_CONIEN | USB_IEN_U3EXTIEN | USB_IEN_L2ENTIEN \
> +		       | USB_IEN_L2EXTIEN | USB_IEN_L1ENTIEN)
> +
> +/* USB_ISTS - bitmasks */
> +/* SS Connection detected. */
> +#define USB_ISTS_CONI		BIT(0)
> +/* SS Disconnection detected. */
> +#define USB_ISTS_DISI		BIT(1)
> +/* UUSB warm reset detectede. */
> +#define USB_ISTS_UWRESI		BIT(2)
> +/* USB hot reset detected. */
> +#define USB_ISTS_UHRESI		BIT(3)
> +/* U3 link state enter detected (suspend).*/
> +#define USB_ISTS_U3ENTI		BIT(4)
> +/* U3 link state exit detected (wakeup). */
> +#define USB_ISTS_U3EXTI		BIT(5)
> +/* U2 link state enter detected.*/
> +#define USB_ISTS_U2ENTI		BIT(6)
> +/* U2 link state exit detected.*/
> +#define USB_ISTS_U2EXTI		BIT(7)
> +/* U1 link state enter detected.*/
> +#define USB_ISTS_U1ENTI		BIT(8)
> +/* U1 link state exit detected.*/
> +#define USB_ISTS_U1EXTI		BIT(9)
> +/* ITP/SOF packet detected.*/
> +#define USB_ISTS_ITPI		BIT(10)
> +/* Wakeup detected.*/
> +#define USB_ISTS_WAKEI		BIT(11)
> +/* Send Custom Packet detected.*/
> +#define USB_ISTS_SPKTI		BIT(12)
> +/* HS/FS mode connection detected.*/
> +#define USB_ISTS_CON2I		BIT(16)
> +/* HS/FS mode disconnection detected.*/
> +#define USB_ISTS_DIS2I		BIT(17)
> +/* USB reset (HS/FS mode) detected.*/
> +#define USB_ISTS_U2RESI		BIT(18)
> +/* LPM L2 state enter detected.*/
> +#define USB_ISTS_L2ENTI		BIT(20)
> +/* LPM  L2 state exit detected.*/
> +#define USB_ISTS_L2EXTI		BIT(21)
> +/* LPM L1 state enter detected.*/
> +#define USB_ISTS_L1ENTI		BIT(24)
> +/* LPM L1 state exit detected.*/
> +#define USB_ISTS_L1EXTI		BIT(25)
> +/* USB configuration reset detected.*/
> +#define USB_ISTS_CFGRESI	BIT(26)
> +/* Start of the USB warm reset detected.*/
> +#define USB_ISTS_UWRESSI	BIT(28)
> +/* End of the USB warm reset detected.*/
> +#define USB_ISTS_UWRESEI	BIT(29)
> +
> +/* USB_SEL - bitmasks */
> +#define EP_SEL_EPNO_MASK	GENMASK(3, 0)
> +/* Endpoint number. */
> +#define EP_SEL_EPNO(p)		((p) & EP_SEL_EPNO_MASK)
> +/* Endpoint direction bit - 0 - OUT, 1 - IN. */
> +#define EP_SEL_DIR		BIT(7)
> +
> +#define select_ep_in(nr)	(EP_SEL_EPNO(p) | EP_SEL_DIR)
> +#define select_ep_out		(EP_SEL_EPNO(p))
> +
> +/* EP_TRADDR - bitmasks */
> +/* Transfer Ring address. */
> +#define EP_TRADDR_TRADDR(p)	((p))
> +
> +/* EP_CFG - bitmasks */
> +/* Endpoint enable */
> +#define EP_CFG_ENABLE		BIT(0)
> +/*
> + *  Endpoint type.
> + * 1 - isochronous
> + * 2 - bulk
> + * 3 - interrupt
> + */
> +#define EP_CFG_EPTYPE_MASK	GENMASK(2, 1)
> +#define EP_CFG_EPTYPE(p)	(((p) << 1)  & EP_CFG_EPTYPE_MASK)
> +/* Stream support enable (only in SS mode). */
> +#define EP_CFG_STREAM_EN	BIT(3)
> +/* TDL check (only in SS mode for BULK EP). */
> +#define EP_CFG_TDL_CHK		BIT(4)
> +/* SID check (only in SS mode for BULK OUT EP). */
> +#define EP_CFG_SID_CHK		BIT(5)
> +/* DMA transfer endianness. */
> +#define EP_CFG_EPENDIAN		BIT(7)
> +/* Max burst size (used only in SS mode). */
> +#define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
> +#define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
> +/* ISO max burst. */
> +#define EP_CFG_MULT_MASK	GENMASK(15, 14)
> +#define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT_MASK)
> +/* ISO max burst. */
> +#define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
> +#define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
> +/* Max number of buffered packets. */
> +#define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
> +#define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
> +
> +/* EP_CMD - bitmasks */
> +/* Endpoint reset. */
> +#define EP_CMD_EPRST		BIT(0)
> +/* Endpoint STALL set. */
> +#define EP_CMD_SSTALL		BIT(1)
> +/* Endpoint STALL clear. */
> +#define EP_CMD_CSTALL		BIT(2)
> +/* Send ERDY TP. */
> +#define EP_CMD_ERDY		BIT(3)
> +/* Request complete. */
> +#define EP_CMD_REQ_CMPL		BIT(5)
> +/* Transfer descriptor ready. */
> +#define EP_CMD_DRDY		BIT(6)
> +/* Data flush. */
> +#define EP_CMD_DFLUSH		BIT(7)
> +/*
> + * Transfer Descriptor Length write  (used only for Bulk Stream capable
> + * endpoints in SS mode).
> + * Bit Removed from DEV_VER_V3 controller version.
> + */
> +#define EP_CMD_STDL		BIT(8)
> +/*
> + * Transfer Descriptor Length (used only in SS mode for bulk endpoints).
> + * Bits Removed from DEV_VER_V3 controller version.
> + */
> +#define EP_CMD_TDL_MASK		GENMASK(15, 9)
> +#define EP_CMD_TDL(p)		(((p) << 9) & EP_CMD_TDL_MASK)
> +/* ERDY Stream ID value (used in SS mode). */
> +#define EP_CMD_ERDY_SID_MASK	GENMASK(31, 16)
> +#define EP_CMD_ERDY_SID(p)	(((p) << 16) & EP_CMD_SID_MASK)
> +
> +/* EP_STS - bitmasks */
> +/* Setup transfer complete. */
> +#define EP_STS_SETUP		BIT(0)
> +/* Endpoint STALL status. */
> +#define EP_STS_STALL(p)		((p) & BIT(1))
> +/* Interrupt On Complete. */
> +#define EP_STS_IOC		BIT(2)
> +/* Interrupt on Short Packet. */
> +#define EP_STS_ISP		BIT(3)
> +/* Transfer descriptor missing. */
> +#define EP_STS_DESCMIS		BIT(4)
> +/* Stream Rejected (used only in SS mode) */
> +#define EP_STS_STREAMR		BIT(5)
> +/* EXIT from MOVE DATA State (used only for stream transfers in SS mode). */
> +#define EP_STS_MD_EXIT		BIT(6)
> +/* TRB error. */
> +#define EP_STS_TRBERR		BIT(7)
> +/* Not ready (used only in SS mode). */
> +#define EP_STS_NRDY		BIT(8)
> +/* DMA busy bit. */
> +#define EP_STS_DBUSY		BIT(9)
> +/* Endpoint Buffer Empty */
> +#define EP_STS_BUFFEMPTY(p)	((p) & BIT(10))
> +/* Current Cycle Status */
> +#define EP_STS_CCS(p)		((p) & BIT(11))
> +/* Prime (used only in SS mode. */
> +#define EP_STS_PRIME		BIT(12)
> +/* Stream error (used only in SS mode). */
> +#define EP_STS_SIDERR		BIT(13)
> +/* OUT size mismatch. */
> +#define EP_STS_OUTSMM		BIT(14)
> +/* ISO transmission error. */
> +#define EP_STS_ISOERR		BIT(15)
> +/* Host Packet Pending (only for SS mode). */
> +#define EP_STS_HOSTPP(p)	((p) & BIT(16))
> +/* Stream Protocol State Machine State (only for Bulk stream endpoints). */
> +#define EP_STS_SPSMST_MASK		GENMASK(18, 17)
> +#define EP_STS_SPSMST_DISABLED(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_IDLE(p)		(((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_START_STREAM(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
> +#define EP_STS_SPSMST_MOVE_DATA(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
> +/* Interrupt On Transfer complete. */
> +#define EP_STS_IOT		BIT(19)
> +/* OUT queue endpoint number. */
> +#define EP_STS_OUTQ_NO_MASK	GENMASK(27, 24)
> +#define EP_STS_OUTQ_NO(p)	(((p) & EP_STS_OUTQ_NO_MASK) >> 24)
> +/* OUT queue valid flag. */
> +#define EP_STS_OUTQ_VAL_MASK	BIT(28)
> +#define EP_STS_OUTQ_VAL(p)	((p) & EP_STS_OUTQ_VAL_MASK)
> +/* SETUP WAIT. */
> +#define EP_STS_STPWAIT		BIT(31)
> +
> +/* EP_STS_SID - bitmasks */
> +/* Stream ID (used only in SS mode). */
> +#define EP_STS_SID_MASK		GENMASK(15, 0)
> +#define EP_STS_SID(p)		((p) & EP_STS_SID_MASK)
> +
> +/* EP_STS_EN - bitmasks */
> +/* SETUP interrupt enable. */
> +#define EP_STS_EN_SETUPEN	BIT(0)
> +/* OUT transfer missing descriptor enable. */
> +#define EP_STS_EN_DESCMISEN	BIT(4)
> +/* Stream Rejected enable. */
> +#define EP_STS_EN_STREAMREN	BIT(5)
> +/* Move Data Exit enable.*/
> +#define EP_STS_EN_MD_EXITEN	BIT(6)
> +/* TRB enable. */
> +#define EP_STS_EN_TRBERREN	BIT(7)
> +/* NRDY enable. */
> +#define EP_STS_EN_NRDYEN	BIT(8)
> +/* Prime enable. */
> +#define EP_STS_EN_PRIMEEEN	BIT(12)
> +/* Stream error enable. */
> +#define EP_STS_EN_SIDERREN	BIT(13)
> +/* OUT size mismatch enable. */
> +#define EP_STS_EN_OUTSMMEN	BIT(14)
> +/* ISO transmission error enable. */
> +#define EP_STS_EN_ISOERREN	BIT(15)
> +/* Interrupt on Transmission complete enable. */
> +#define EP_STS_EN_IOTEN		BIT(19)
> +/* Setup Wait interrupt enable. */
> +#define EP_STS_EN_STPWAITEN	BIT(31)
> +
> +/* DRBL- bitmasks */
> +#define DB_VALUE_BY_INDEX(index) (1 << (index))
> +#define DB_VALUE_EP0_OUT	BIT(0)
> +#define DB_VALUE_EP0_IN		BIT(16)
> +
> +/* EP_IEN - bitmasks */
> +#define EP_IEN(index)		(1 << (index))
> +#define EP_IEN_EP_OUT0		BIT(0)
> +#define EP_IEN_EP_IN0		BIT(16)
> +
> +/* EP_ISTS - bitmasks */
> +#define EP_ISTS(index)		(1 << (index))
> +#define EP_ISTS_EP_OUT0		BIT(0)
> +#define EP_ISTS_EP_IN0		BIT(16)
> +
> +/* USB_PWR- bitmasks */
> +/*Power Shut Off capability enable*/
> +#define PUSB_PWR_PSO_EN		BIT(0)
> +/*Power Shut Off capability disable*/
> +#define PUSB_PWR_PSO_DS		BIT(1)
> +/*
> + * Enables turning-off Reference Clock.
> + * This bit is optional and implemented only when support for OTG is
> + * implemented (indicated by OTG_READY bit set to '1').
> + */
> +#define PUSB_PWR_STB_CLK_SWITCH_EN	BIT(8)
> +/*
> + * Status bit indicating that operation required by STB_CLK_SWITCH_EN write
> + * is completed
> + */
> +#define PUSB_PWR_STB_CLK_SWITCH_DONE	BIT(9)
> +/* This bit informs if Fast Registers Access is enabled. */
> +#define PUSB_PWR_FST_REG_ACCESS_STAT	BIT(30)
> +/* Fast Registers Access Enable. */
> +#define PUSB_PWR_FST_REG_ACCESS		BIT(31)
> +
> +/* USB_CONF2- bitmasks */
> +/*
> + * Writing 1 disables TDL calculation basing on TRB feature in controller
> + * for DMULT mode.
> + * Bit supported only for DEV_VER_V2 version.
> + */
> +#define USB_CONF2_DIS_TDL_TRB		BIT(1)
> +/*
> + * Writing 1 enables TDL calculation basing on TRB feature in controller
> + * for DMULT mode.
> + * Bit supported only for DEV_VER_V2 version.
> + */
> +#define USB_CONF2_EN_TDL_TRB		BIT(2)
> +
> +/* USB_CAP1- bitmasks */
> +/*
> + * SFR Interface type
> + * These field reflects type of SFR interface implemented:
> + * 0x0 - OCP
> + * 0x1 - AHB,
> + * 0x2 - PLB
> + * 0x3 - AXI
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_SFR_TYPE_MASK	GENMASK(3, 0)
> +#define DEV_SFR_TYPE_OCP(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x0)
> +#define DEV_SFR_TYPE_AHB(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x1)
> +#define DEV_SFR_TYPE_PLB(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x2)
> +#define DEV_SFR_TYPE_AXI(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x3)
> +/*
> + * SFR Interface width
> + * These field reflects width of SFR interface implemented:
> + * 0x0 - 8 bit interface,
> + * 0x1 - 16 bit interface,
> + * 0x2 - 32 bit interface
> + * 0x3 - 64 bit interface
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_SFR_WIDTH_MASK	GENMASK(7, 4)
> +#define DEV_SFR_WIDTH_8(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x0 << 4))
> +#define DEV_SFR_WIDTH_16(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x1 << 4))
> +#define DEV_SFR_WIDTH_32(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x2 << 4))
> +#define DEV_SFR_WIDTH_64(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x3 << 4))
> +/*
> + * DMA Interface type
> + * These field reflects type of DMA interface implemented:
> + * 0x0 - OCP
> + * 0x1 - AHB,
> + * 0x2 - PLB
> + * 0x3 - AXI
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_DMA_TYPE_MASK	GENMASK(11, 8)
> +#define DEV_DMA_TYPE_OCP(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x0 << 8))
> +#define DEV_DMA_TYPE_AHB(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x1 << 8))
> +#define DEV_DMA_TYPE_PLB(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x2 << 8))
> +#define DEV_DMA_TYPE_AXI(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x3 << 8))
> +/*
> + * DMA Interface width
> + * These field reflects width of DMA interface implemented:
> + * 0x0 - reserved,
> + * 0x1 - reserved,
> + * 0x2 - 32 bit interface
> + * 0x3 - 64 bit interface
> + * 0x4-0xF - reserved
> + */
> +#define USB_CAP1_DMA_WIDTH_MASK	GENMASK(15, 12)
> +#define DEV_DMA_WIDTH_32(p)	(((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x2 << 12))
> +#define DEV_DMA_WIDTH_64(p)	(((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x3 << 12))
> +/*
> + * USB3 PHY Interface type
> + * These field reflects type of USB3 PHY interface implemented:
> + * 0x0 - USB PIPE,
> + * 0x1 - RMMI,
> + * 0x2-0xF - reserved
> + */
> +#define USB_CAP1_U3PHY_TYPE_MASK GENMASK(19, 16)
> +#define DEV_U3PHY_PIPE(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x0 << 16))
> +#define DEV_U3PHY_RMMI(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x1 << 16))
> +/*
> + * USB3 PHY Interface width
> + * These field reflects width of USB3 PHY interface implemented:
> + * 0x0 - 8 bit PIPE interface,
> + * 0x1 - 16 bit PIPE interface,
> + * 0x2 - 32 bit PIPE interface,
> + * 0x3 - 64 bit PIPE interface
> + * 0x4-0xF - reserved
> + * Note: When SSIC interface is implemented this field shows the width of
> + * internal PIPE interface. The RMMI interface is always 20bit wide.
> + */
> +#define USB_CAP1_U3PHY_WIDTH_MASK GENMASK(23, 20)
> +#define DEV_U3PHY_WIDTH_8(p) \
> +	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x0 << 20))
> +#define DEV_U3PHY_WIDTH_16(p) \
> +	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x1 << 16))
> +#define DEV_U3PHY_WIDTH_32(p) \
> +	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x2 << 20))
> +#define DEV_U3PHY_WIDTH_64(p) \
> +	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x3 << 16))
> +
> +/*
> + * USB2 PHY Interface enable
> + * These field informs if USB2 PHY interface is implemented:
> + * 0x0 - interface NOT implemented,
> + * 0x1 - interface implemented
> + */
> +#define USB_CAP1_U2PHY_EN(p)	((p) & BIT(24))
> +/*
> + * USB2 PHY Interface type
> + * These field reflects type of USB2 PHY interface implemented:
> + * 0x0 - UTMI,
> + * 0x1 - ULPI
> + */
> +#define DEV_U2PHY_ULPI(p)	((p) & BIT(25))
> +/*
> + * USB2 PHY Interface width
> + * These field reflects width of USB2 PHY interface implemented:
> + * 0x0 - 8 bit interface,
> + * 0x1 - 16 bit interface,
> + * Note: The ULPI interface is always 8bit wide.
> + */
> +#define DEV_U2PHY_WIDTH_16(p)	((p) & BIT(26))
> +/*
> + * OTG Ready
> + * 0x0 - pure device mode
> + * 0x1 - some features and ports for CDNS USB OTG controller are implemented.
> + */
> +#define USB_CAP1_OTG_READY(p)	((p) & BIT(27))
> +
> +/*
> + * When set, indicates that controller supports automatic internal TDL
> + * calculation basing on the size provided in TRB (TRB[22:17]) for DMULT mode
> + * Supported only for DEV_VER_V2 controller version.
> + */
> +#define USB_CAP1_TDL_FROM_TRB(p)	((p) & BIT(28))
> +
> +/* USB_CAP2- bitmasks */
> +/*
> + * The actual size of the connected On-chip RAM memory in kB:
> + * - 0 means 256 kB (max supported mem size)
> + * - value other than 0 reflects the mem size in kB
> + */
> +#define USB_CAP2_ACTUAL_MEM_SIZE(p) ((p) & GENMASK(7, 0))
> +/*
> + * Max supported mem size
> + * These field reflects width of on-chip RAM address bus width,
> + * which determines max supported mem size:
> + * 0x0-0x7 - reserved,
> + * 0x8 - support for 4kB mem,
> + * 0x9 - support for 8kB mem,
> + * 0xA - support for 16kB mem,
> + * 0xB - support for 32kB mem,
> + * 0xC - support for 64kB mem,
> + * 0xD - support for 128kB mem,
> + * 0xE - support for 256kB mem,
> + * 0xF - reserved
> + */
> +#define USB_CAP2_MAX_MEM_SIZE(p) ((p) & GENMASK(11, 8))
> +
> +/* USB_CAP3- bitmasks */
> +#define EP_IS_IMPLEMENTED(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP4- bitmasks */
> +#define EP_SUPPORT_ISO(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP5- bitmasks */
> +#define EP_SUPPORT_STREAM(reg, index) ((reg) & (1 << (index)))
> +
> +/* USB_CAP6- bitmasks */
> +/* The USBSS-DEV Controller  Internal build number. */
> +#define GET_DEV_BASE_VERSION(p) ((p) & GENMASK(23, 0))
> +/* The USBSS-DEV Controller version number. */
> +#define GET_DEV_CUSTOM_VERSION(p) ((p) & GENMASK(31, 24))
> +
> +#define DEV_VER_NXP_V1		0x00024502
> +#define DEV_VER_TI_V1		0x00024509
> +#define DEV_VER_V2		0x0002450C
> +#define DEV_VER_V3		0x0002450d
> +
> +/* DBG_LINK1- bitmasks */
> +/*
> + * LFPS_MIN_DET_U1_EXIT value This parameter configures the minimum
> + * time required for decoding the received LFPS as an LFPS.U1_Exit.
> + */
> +#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT(p)	((p) & GENMASK(7, 0))
> +/*
> + * LFPS_MIN_GEN_U1_EXIT value This parameter configures the minimum time for
> + * phytxelecidle deassertion when LFPS.U1_Exit
> + */
> +#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_MASK	GENMASK(15, 8)
> +#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT(p)	(((p) << 8) & GENMASK(15, 8))
> +/*
> + * RXDET_BREAK_DIS value This parameter configures terminating the Far-end
> + * Receiver termination detection sequence:
> + * 0: it is possible that USBSS_DEV will terminate Farend receiver
> + *    termination detection sequence
> + * 1: USBSS_DEV will not terminate Far-end receiver termination
> + *    detection sequence
> + */
> +#define DBG_LINK1_RXDET_BREAK_DIS		BIT(16)
> +/* LFPS_GEN_PING value This parameter configures the LFPS.Ping generation */
> +#define DBG_LINK1_LFPS_GEN_PING(p)		(((p) << 17) & GENMASK(21, 17))
> +/*
> + * Set the LFPS_MIN_DET_U1_EXIT value Writing '1' to this bit writes the
> + * LFPS_MIN_DET_U1_EXIT field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT_SET	BIT(24)
> +/*
> + * Set the LFPS_MIN_GEN_U1_EXIT value. Writing '1' to this bit writes the
> + * LFPS_MIN_GEN_U1_EXIT field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_SET	BIT(25)
> +/*
> + * Set the RXDET_BREAK_DIS value Writing '1' to this bit writes
> + * the RXDET_BREAK_DIS field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect
> + */
> +#define DBG_LINK1_RXDET_BREAK_DIS_SET		BIT(26)
> +/*
> + * Set the LFPS_GEN_PING_SET value Writing '1' to this bit writes
> + * the LFPS_GEN_PING field value to the device. This bit is automatically
> + * cleared. Writing '0' has no effect."
> + */
> +#define DBG_LINK1_LFPS_GEN_PING_SET		BIT(27)
> +
> +/* DMA_AXI_CTRL- bitmasks */
> +/* The mawprot pin configuration. */
> +#define DMA_AXI_CTRL_MARPROT(p) ((p) & GENMASK(2, 0))
> +/* The marprot pin configuration. */
> +#define DMA_AXI_CTRL_MAWPROT(p) (((p) < 16) & GENMASK(18, 16))

This is wrong. It will always clear MAWPROT to 0.

#define DMA_AXI_CTRL_MAWPROT(p) (((p) & GENMASK(2, 0)) << 16)

> +#define DMA_AXI_CTRL_NON_SECURE 0x02
> +
> +#define gadget_to_cdns3_device(g) (container_of(g, struct cdns3_device, gadget))
> +
> +#define ep_to_cdns3_ep(ep) (container_of(ep, struct cdns3_endpoint, endpoint))
> +

<snip>

After these changes, the DMA_AXI security attribute fix is working correctly.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
