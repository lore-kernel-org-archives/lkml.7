Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F975C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04E620663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o7wiUbFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfCDTn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:43:26 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59838 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDTnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:43:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24JhF2G107368;
        Mon, 4 Mar 2019 13:43:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551728595;
        bh=xqG3iNVRo2mAHIdO6bOuF8r4r6LOxvJ6iwSz2+/odSk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o7wiUbFH2zNOa8L+S/AH42Cs6r9Rgb3mifRRaZxOKojLU3g7R+v1Ges447iIpAIoT
         hETnO2p4wMlY6G/++Yl+BY5RmViuZGsxusMXv0VgsxPMu1O5B6bStOq/MUAPHd+Vhk
         cEjPqIXMQakPAATyMFde3Mium01TXSXs/fTvZUdU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24JhEKu071555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 13:43:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 13:43:14 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 13:43:14 -0600
Received: from [172.22.87.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24JhELh016921;
        Mon, 4 Mar 2019 13:43:14 -0600
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5657b161-5660-1ae5-a9b1-62d7d6651493@ti.com>
Date:   Mon, 4 Mar 2019 13:43:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 10:56 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> the series already looks quite good. I still realized a few (minor)
> issues while browsing the patch/code...
> 
> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>> Create a m_can platform framework that peripherial
>> devices can register to and use common code and register sets.
>> The peripherial devices may provide read/write and configuration
>> support of the IP.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>
>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>  drivers/net/can/m_can/Makefile         |   1 +
>>  drivers/net/can/m_can/m_can.c          | 702 +++++++++++++------------
>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>  drivers/net/can/m_can/m_can_platform.c | 198 +++++++
>>  5 files changed, 681 insertions(+), 343 deletions(-)
>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>
>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>> index 04f20dd39007..f7119fd72df4 100644
>> --- a/drivers/net/can/m_can/Kconfig
>> +++ b/drivers/net/can/m_can/Kconfig
>> @@ -1,5 +1,14 @@
>>  config CAN_M_CAN
>> +	tristate "Bosch M_CAN support"
>> +	---help---
>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>> +
>> +config CAN_M_CAN_PLATFORM
>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>  	depends on HAS_IOMEM
>> -	tristate "Bosch M_CAN devices"
>> +	depends on CAN_M_CAN
>>  	---help---
>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>> +	  This support is for devices that have the Bosch M_CAN controller
>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>> index 8bbd7f24f5be..057bbcdb3c74 100644
>> --- a/drivers/net/can/m_can/Makefile
>> +++ b/drivers/net/can/m_can/Makefile
>> @@ -3,3 +3,4 @@
>>  #
>>  
>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index 9b449400376b..b37d0886f9cb 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -1,20 +1,14 @@
>> -/*
>> - * CAN bus driver for Bosch M_CAN controller
>> - *
>> - * Copyright (C) 2014 Freescale Semiconductor, Inc.
>> - *	Dong Aisheng <b29396@freescale.com>
>> - *
>> - * Bosch M_CAN user manual can be obtained from:
>> +// SPDX-License-Identifier: GPL-2.0
>> +// CAN bus driver for Bosch M_CAN controller
>> +// Copyright (C) 2014 Freescale Semiconductor, Inc.
>> +//      Dong Aisheng <b29396@freescale.com>
>> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>> +
>> +/* Bosch M_CAN user manual can be obtained from:
>>   * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>>   * mcan_users_manual_v302.pdf
>> - *
>> - * This file is licensed under the terms of the GNU General Public
>> - * License version 2. This program is licensed "as is" without any
>> - * warranty of any kind, whether express or implied.
>>   */
>>  
>> -#include <linux/clk.h>
>> -#include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>> @@ -28,11 +22,7 @@
>>  #include <linux/can/dev.h>
>>  #include <linux/pinctrl/consumer.h>
>>  
>> -/* napi related */
>> -#define M_CAN_NAPI_WEIGHT	64
>> -
>> -/* message ram configuration data length */
>> -#define MRAM_CFG_LEN	8
>> +#include "m_can.h"
>>  
>>  /* registers definition */
>>  enum m_can_reg {
>> @@ -86,28 +76,11 @@ enum m_can_reg {
>>  	M_CAN_TXEFA	= 0xf8,
>>  };
>>  
>> -/* m_can lec values */
>> -enum m_can_lec_type {
>> -	LEC_NO_ERROR = 0,
>> -	LEC_STUFF_ERROR,
>> -	LEC_FORM_ERROR,
>> -	LEC_ACK_ERROR,
>> -	LEC_BIT1_ERROR,
>> -	LEC_BIT0_ERROR,
>> -	LEC_CRC_ERROR,
>> -	LEC_UNUSED,
>> -};
>> +/* napi related */
>> +#define M_CAN_NAPI_WEIGHT	64
>>  
>> -enum m_can_mram_cfg {
>> -	MRAM_SIDF = 0,
>> -	MRAM_XIDF,
>> -	MRAM_RXF0,
>> -	MRAM_RXF1,
>> -	MRAM_RXB,
>> -	MRAM_TXE,
>> -	MRAM_TXB,
>> -	MRAM_CFG_NUM,
>> -};
>> +/* message ram configuration data length */
>> +#define MRAM_CFG_LEN	8
>>  
>>  /* Core Release Register (CREL) */
>>  #define CREL_REL_SHIFT		28
>> @@ -343,77 +316,83 @@ enum m_can_mram_cfg {
>>  #define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
>>  
>>  /* Tx event FIFO Element */
>> -/* E1 */
> 
> I also don't understand what "E1" means... we should keep taht line anyway!
> 
>>  #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
>>  #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
>>  
>> -/* address offset and element number for each FIFO/Buffer in the Message RAM */
>> -struct mram_cfg {
>> -	u16 off;
>> -	u8  num;
>> -};
>> -
>> -/* m_can private data structure */
>> -struct m_can_priv {
>> -	struct can_priv can;	/* must be the first member */
>> -	struct napi_struct napi;
>> -	struct net_device *dev;
>> -	struct device *device;
>> -	struct clk *hclk;
>> -	struct clk *cclk;
>> -	void __iomem *base;
>> -	u32 irqstatus;
>> -	int version;
>> -
>> -	/* message ram configuration */
>> -	void __iomem *mram_base;
>> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
>> -};
>> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
>> +{
>> +	if (priv->ops->read_reg)
>> +		return priv->ops->read_reg(priv, reg);
>> +	else
>> +		return -EINVAL;
>> +}
>>  
>> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
>> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
>>  {
>> -	return readl(priv->base + reg);
>> +	if (priv->ops->write_reg)
>> +		return priv->ops->write_reg(priv, reg, val);
>> +	else
>> +		return -EINVAL;
>>  }
>>  
>> -static inline void m_can_write(const struct m_can_priv *priv,
>> -			       enum m_can_reg reg, u32 val)
>> +static u32 m_can_fifo_read(struct m_can_priv *priv,
>> +			   u32 fgi, unsigned int offset)
>>  {
>> -	writel(val, priv->base + reg);
>> +	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
>> +			  offset;
>> +
>> +	if (priv->ops->read_fifo)
>> +		return priv->ops->read_fifo(priv, addr_offset);
>> +	else
>> +		return -EINVAL;
>>  }
>>  
>> -static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>> -				  u32 fgi, unsigned int offset)
>> +static u32 m_can_fifo_write(struct m_can_priv *priv,
>> +			    u32 fpi, unsigned int offset, u32 val)
>>  {
>> -	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>> -		     fgi * RXF0_ELEMENT_SIZE + offset);
>> +	u32 addr_offset = priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
>> +			  offset;
>> +
>> +	if (priv->ops->write_fifo)
>> +		return priv->ops->write_fifo(priv, addr_offset, val);
>> +	else
>> +		return -EINVAL;
>>  }
>>  
>> -static inline void m_can_fifo_write(const struct m_can_priv *priv,
>> -				    u32 fpi, unsigned int offset, u32 val)
>> +static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
>> +				   u32 fpi, u32 val)
>>  {
>> -	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
>> -	       fpi * TXB_ELEMENT_SIZE + offset);
>> +	if (priv->ops->write_fifo)
>> +		return priv->ops->write_fifo(priv, fpi, val);
>> +	else
>> +		return 0;
>>  }
>>  
>> -static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
>> -				      u32 fgi,
>> -				      u32 offset) {
>> -	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
>> -			fgi * TXE_ELEMENT_SIZE + offset);
>> +static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
>> +{
>> +	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
>> +			  offset;
>> +
>> +	if (priv->ops->read_fifo)
>> +		return priv->ops->read_fifo(priv, addr_offset);
>> +	else
>> +		return -EINVAL;
>>  }
>>  
>> -static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
>> +static inline bool m_can_tx_fifo_full(struct m_can_priv *priv)
>>  {
>>  		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
>>  }
>>  
>> -static inline void m_can_config_endisable(const struct m_can_priv *priv,
>> -					  bool enable)
>> +void m_can_config_endisable(struct m_can_priv *priv, bool enable)
>>  {
>>  	u32 cccr = m_can_read(priv, M_CAN_CCCR);
>>  	u32 timeout = 10;
>>  	u32 val = 0;
>>  
>> +	if (cccr & CCCR_CSR)
>> +		cccr &= ~CCCR_CSR;
>> +
> 
> Is that a bug fix? Or why do we need it?
> 
>>  	if (enable) {
>>  		/* enable m_can configuration */
>>  		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>> @@ -430,7 +409,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>>  
>>  	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
>>  		if (timeout == 0) {
>> -			netdev_warn(priv->dev, "Failed to init module\n");
>> +			netdev_warn(priv->net, "Failed to init module\n");
>>  			return;
>>  		}
>>  		timeout--;
>> @@ -438,13 +417,13 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>>  	}
>>  }
>>  
>> -static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
>> +static inline void m_can_enable_all_interrupts(struct m_can_priv *priv)
>>  {
>>  	/* Only interrupt line 0 is used in this driver */
>>  	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
>>  }
>>  
>> -static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
>> +static inline void m_can_disable_all_interrupts(struct m_can_priv *priv)
>>  {
>>  	m_can_write(priv, M_CAN_ILE, 0x0);
>>  }
>> @@ -633,9 +612,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>  {
>>  	int err;
>>  
>> -	err = pm_runtime_get_sync(priv->device);
>> +	if (priv->pm_clock_support == 0)
>> +		return 0;
>> +
>> +	err = pm_runtime_get_sync(priv->dev);
>>  	if (err < 0) {
>> -		pm_runtime_put_noidle(priv->device);
>> +		pm_runtime_put_noidle(priv->dev);
>>  		return err;
>>  	}
>>  
>> @@ -644,7 +626,8 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>  
>>  static void m_can_clk_stop(struct m_can_priv *priv)
>>  {
>> -	pm_runtime_put_sync(priv->device);
>> +	if (priv->pm_clock_support)
>> +		pm_runtime_put_sync(priv->dev);
>>  }
>>  
>>  static int m_can_get_berr_counter(const struct net_device *dev,
>> @@ -811,9 +794,8 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
>>  	return work_done;
>>  }
>>  
>> -static int m_can_poll(struct napi_struct *napi, int quota)
>> +static int m_can_rx_handler(struct net_device *dev, int quota)
>>  {
>> -	struct net_device *dev = napi->dev;
>>  	struct m_can_priv *priv = netdev_priv(dev);
>>  	int work_done = 0;
>>  	u32 irqstatus, psr;
>> @@ -831,13 +813,33 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>>  
>>  	if (irqstatus & IR_RF0N)
>>  		work_done += m_can_do_rx_poll(dev, (quota - work_done));
>> +end:
>> +	return work_done;
>> +}
>> +
>> +static int m_can_rx_peripherial(struct net_device *dev)
>> +{
>> +	struct m_can_priv *priv = netdev_priv(dev);
>> +
>> +	m_can_rx_handler(dev, 1);
>> +
>> +	m_can_enable_all_interrupts(priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static int m_can_poll(struct napi_struct *napi, int quota)
>> +{
>> +	struct net_device *dev = napi->dev;
>> +	struct m_can_priv *priv = netdev_priv(dev);
>> +	int work_done;
>>  
>> +	work_done = m_can_rx_handler(dev, quota);
>>  	if (work_done < quota) {
>>  		napi_complete_done(napi, work_done);
>>  		m_can_enable_all_interrupts(priv);
>>  	}
>>  
>> -end:
>>  	return work_done;
>>  }
>>  
>> @@ -894,6 +896,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>>  	if (ir & IR_ALL_INT)
>>  		m_can_write(priv, M_CAN_IR, ir);
>>  
>> +	if (priv->ops->clr_dev_interrupts)
>> +		priv->ops->clr_dev_interrupts(priv);
>> +
>>  	/* schedule NAPI in case of
>>  	 * - rx IRQ
>>  	 * - state change IRQ
>> @@ -902,7 +907,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>>  	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
>>  		priv->irqstatus = ir;
>>  		m_can_disable_all_interrupts(priv);
>> -		napi_schedule(&priv->napi);
>> +		if (!priv->is_peripherial)
>> +			napi_schedule(&priv->napi);
>> +		else
>> +			m_can_rx_peripherial(dev);
>>  	}
>>  
>>  	if (priv->version == 30) {
>> @@ -1155,6 +1163,9 @@ static void m_can_chip_config(struct net_device *dev)
>>  	m_can_set_bittiming(dev);
>>  
>>  	m_can_config_endisable(priv, false);
>> +
>> +	if (priv->ops->device_init)
>> +		priv->ops->device_init(priv);
>>  }
>>  
>>  static void m_can_start(struct net_device *dev)
>> @@ -1188,20 +1199,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>>   * else it returns the release and step coded as:
>>   * return value = 10 * <release> + 1 * <step>
>>   */
>> -static int m_can_check_core_release(void __iomem *m_can_base)
>> +static int m_can_check_core_release(struct m_can_priv *priv)
>>  {
>>  	u32 crel_reg;
>>  	u8 rel;
>>  	u8 step;
>>  	int res;
>> -	struct m_can_priv temp_priv = {
>> -		.base = m_can_base
>> -	};
>>  
>>  	/* Read Core Release Version and split into version number
>>  	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
>>  	 */
>> -	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
>> +	crel_reg = m_can_read(priv, M_CAN_CREL);
>>  	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
>>  	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
>>  
>> @@ -1219,18 +1227,26 @@ static int m_can_check_core_release(void __iomem *m_can_base)
>>  /* Selectable Non ISO support only in version 3.2.x
>>   * This function checks if the bit is writable.
>>   */
>> -static bool m_can_niso_supported(const struct m_can_priv *priv)
>> +static bool m_can_niso_supported(struct m_can_priv *priv)
>>  {
>> -	u32 cccr_reg, cccr_poll;
>> -	int niso_timeout;
>> +	u32 cccr_reg, cccr_poll = 0;
>> +	int niso_timeout = -ETIMEDOUT;
>> +	int i;
>>  
>>  	m_can_config_endisable(priv, true);
>>  	cccr_reg = m_can_read(priv, M_CAN_CCCR);
>>  	cccr_reg |= CCCR_NISO;
>>  	m_can_write(priv, M_CAN_CCCR, cccr_reg);
>>  
>> -	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
>> -					  (cccr_poll == cccr_reg), 0, 10);
>> +	for (i = 0; i <= 10; i++) {
>> +		cccr_poll = m_can_read(priv, M_CAN_CCCR);
>> +		if (cccr_poll == cccr_reg) {
>> +			niso_timeout = 0;
>> +			break;
>> +		}
>> +
>> +		usleep_range(1, 5);
>> +	}

I wanted to point out to you that I did not add back the readl_timeout but I did add a break
and a timer to try to mimic the original code.

Dan

<snip>
-- 
------------------
Dan Murphy
