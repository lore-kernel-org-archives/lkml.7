Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67F020857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UiFZMYPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbfB1R6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:58:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52742 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1R6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:58:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1SHw3G7075646;
        Thu, 28 Feb 2019 11:58:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551376683;
        bh=3m5H1fECuF6Xjp1oaL1qeTwJaS7TasKJA9+tDD9Nxps=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UiFZMYPwpPPtvtfr534RUvtlZQ5I8gH2Z6Tclh3IDJ46mhPCvEnql1ihVJHA7Duuv
         DGSDz8uN806wV+4SfNG3E/KUnmKw1RWBoDkW3ffRXgzIqC+FqKKMCOLz1tI0PZk8WJ
         Hs+qtlfqhox1DcbgPya+HrHKChwiX9jWweXFsm9I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1SHw3fI047518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 11:58:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 28
 Feb 2019 11:58:02 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 28 Feb 2019 11:58:03 -0600
Received: from [172.22.127.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1SHw2an003538;
        Thu, 28 Feb 2019 11:58:02 -0600
Subject: Re: [PATCH v5 2/5] can: m_can: Migrate the m_can code to use the
 framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <20190214182754.30721-3-dmurphy@ti.com>
 <0f5f732a-945c-da56-1086-00fb2c621331@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <639f316a-1190-1e0e-0a1d-6008a1c332d7@ti.com>
Date:   Thu, 28 Feb 2019 11:57:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0f5f732a-945c-da56-1086-00fb2c621331@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 2/28/19 11:33 AM, Wolfgang Grandegger wrote:
> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>> Migrate the m_can code to use the m_can_platform framework
>> code.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v5 - Updated copyright, change m_can_classdev to m_can_priv, removed extra
>> KCONFIG flag - https://lore.kernel.org/patchwork/patch/1033095/
>>
>>  drivers/net/can/m_can/Kconfig  |   8 +-
>>  drivers/net/can/m_can/Makefile |   1 +
>>  drivers/net/can/m_can/m_can.c  | 745 ++++++++++++++++-----------------
>>  3 files changed, 367 insertions(+), 387 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>> index 04f20dd39007..66e31022a5fa 100644
>> --- a/drivers/net/can/m_can/Kconfig
>> +++ b/drivers/net/can/m_can/Kconfig
>> @@ -1,5 +1,11 @@
>>  config CAN_M_CAN
>> +	tristate "Bosch M_CAN support"
>> +	---help---
>> +	  Say Y here if you want to support for Bosch M_CAN controller.
> 
> Typo?
> 

Maybe like you pointed out to update the help.

>> +
>> +config CAN_M_CAN_PLATFORM
>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>  	depends on HAS_IOMEM
>> -	tristate "Bosch M_CAN devices"
>> +	depends on CAN_M_CAN
>>  	---help---
>>  	  Say Y here if you want to support for Bosch M_CAN controller.
> 
> Please update the help.

Ack
> 
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
>> index 9b449400376b..2ceccb870557 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -1,20 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// CAN bus driver for Bosch M_CAN controller
>> +// Copyright (C) 2014 Freescale Semiconductor, Inc.
>> +//      Dong Aisheng <b29396@freescale.com>
>> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>> +
>>  /*
>> - * CAN bus driver for Bosch M_CAN controller
>> - *
>> - * Copyright (C) 2014 Freescale Semiconductor, Inc.
>> - *	Dong Aisheng <b29396@freescale.com>
>> - *
>>   * Bosch M_CAN user manual can be obtained from:
>>   * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>>   * mcan_users_manual_v302.pdf
>>   *
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
>> @@ -28,87 +24,14 @@
>>  #include <linux/can/dev.h>
>>  #include <linux/pinctrl/consumer.h>
>>  
>> +#include "m_can.h"
>> +
>>  /* napi related */
>>  #define M_CAN_NAPI_WEIGHT	64
>>  
>>  /* message ram configuration data length */
>>  #define MRAM_CFG_LEN	8
>>  
>> -/* registers definition */
>> -enum m_can_reg {
>> -	M_CAN_CREL	= 0x0,
>> -	M_CAN_ENDN	= 0x4,
>> -	M_CAN_CUST	= 0x8,
>> -	M_CAN_DBTP	= 0xc,
>> -	M_CAN_TEST	= 0x10,
>> -	M_CAN_RWD	= 0x14,
>> -	M_CAN_CCCR	= 0x18,
>> -	M_CAN_NBTP	= 0x1c,
>> -	M_CAN_TSCC	= 0x20,
>> -	M_CAN_TSCV	= 0x24,
>> -	M_CAN_TOCC	= 0x28,
>> -	M_CAN_TOCV	= 0x2c,
>> -	M_CAN_ECR	= 0x40,
>> -	M_CAN_PSR	= 0x44,
>> -/* TDCR Register only available for version >=3.1.x */
>> -	M_CAN_TDCR	= 0x48,
>> -	M_CAN_IR	= 0x50,
>> -	M_CAN_IE	= 0x54,
>> -	M_CAN_ILS	= 0x58,
>> -	M_CAN_ILE	= 0x5c,
>> -	M_CAN_GFC	= 0x80,
>> -	M_CAN_SIDFC	= 0x84,
>> -	M_CAN_XIDFC	= 0x88,
>> -	M_CAN_XIDAM	= 0x90,
>> -	M_CAN_HPMS	= 0x94,
>> -	M_CAN_NDAT1	= 0x98,
>> -	M_CAN_NDAT2	= 0x9c,
>> -	M_CAN_RXF0C	= 0xa0,
>> -	M_CAN_RXF0S	= 0xa4,
>> -	M_CAN_RXF0A	= 0xa8,
>> -	M_CAN_RXBC	= 0xac,
>> -	M_CAN_RXF1C	= 0xb0,
>> -	M_CAN_RXF1S	= 0xb4,
>> -	M_CAN_RXF1A	= 0xb8,
>> -	M_CAN_RXESC	= 0xbc,
>> -	M_CAN_TXBC	= 0xc0,
>> -	M_CAN_TXFQS	= 0xc4,
>> -	M_CAN_TXESC	= 0xc8,
>> -	M_CAN_TXBRP	= 0xcc,
>> -	M_CAN_TXBAR	= 0xd0,
>> -	M_CAN_TXBCR	= 0xd4,
>> -	M_CAN_TXBTO	= 0xd8,
>> -	M_CAN_TXBCF	= 0xdc,
>> -	M_CAN_TXBTIE	= 0xe0,
>> -	M_CAN_TXBCIE	= 0xe4,
>> -	M_CAN_TXEFC	= 0xf0,
>> -	M_CAN_TXEFS	= 0xf4,
>> -	M_CAN_TXEFA	= 0xf8,
>> -};
>> -
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
>> -
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
>> -
>>  /* Core Release Register (CREL) */
>>  #define CREL_REL_SHIFT		28
>>  #define CREL_REL_MASK		(0xF << CREL_REL_SHIFT)
>> @@ -343,77 +266,89 @@ enum m_can_mram_cfg {
>>  #define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
>>  
>>  /* Tx event FIFO Element */
>> -/* E1 */
>>  #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
>>  #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
>>  
>> -/* address offset and element number for each FIFO/Buffer in the Message RAM */
>> -struct mram_cfg {
>> -	u16 off;
>> -	u8  num;
>> -};
>> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
>> +{
>> +	u32 ret = -EINVAL;
>>  
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
>> +	if (priv->ops->read_reg)
>> +		ret = priv->ops->read_reg(priv, reg);
>> +
>> +	return ret;
>> +}
>>  
>> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
>> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
>>  {
>> -	return readl(priv->base + reg);
>> +	int ret = -EINVAL;
>> +
>> +	if (priv->ops->write_reg)
>> +		ret = priv->ops->write_reg(priv, reg, val);
>> +
>> +	return ret;
> 
> Why not just:
> 
> 	if (priv->ops->write_reg)
> 		return priv->ops->write_reg(priv, reg, val);
> 	else
> 		return -EINVAL;
> 
> Here and below.
> 

ACK

>>  }
>>  
>> -static inline void m_can_write(const struct m_can_priv *priv,
>> -			       enum m_can_reg reg, u32 val)
>> +static u32 m_can_fifo_read(struct m_can_priv *priv,
>> +			   u32 fgi, unsigned int offset)
>>  {
>> -	writel(val, priv->base + reg);
>> +	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE + offset;
>> +	u32 ret = -EINVAL;
>> +
>> +	if (priv->ops->read_fifo)
>> +		ret = priv->ops->read_fifo(priv, addr_offset);
>> +
>> +	return ret;
>>  }
>>  
>> -static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>> -				  u32 fgi, unsigned int offset)
>> +static u32 m_can_fifo_write(struct m_can_priv *priv,
>> +			    u32 fpi, unsigned int offset, u32 val)
>>  {
>> -	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>> -		     fgi * RXF0_ELEMENT_SIZE + offset);
>> +	u32 addr_offset =  priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE + offset;
>> +	u32 ret = -EINVAL;
>> +
>> +	if (priv->ops->write_fifo)
>> +		ret = priv->ops->write_fifo(priv, addr_offset, val);
>> +
>> +	return ret;
>>  }
>>  
>> -static inline void m_can_fifo_write(const struct m_can_priv *priv,
>> -				    u32 fpi, unsigned int offset, u32 val)
>> +static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
>> +				   u32 fpi, u32 val)
>>  {
>> -	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
>> -	       fpi * TXB_ELEMENT_SIZE + offset);
>> +	u32 ret = 0;
>> +
>> +	if (priv->ops->write_fifo)
>> +		ret = priv->ops->write_fifo(priv, fpi, val);
>> +
>> +	return ret;
>>  }
>>  
>> -static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
>> -				      u32 fgi,
>> -				      u32 offset) {
>> -	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
>> -			fgi * TXE_ELEMENT_SIZE + offset);
>> +static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
>> +{
>> +	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE + offset;
>> +	u32 ret = -EINVAL;
>> +
>> +	if (priv->ops->read_fifo)
>> +		ret = priv->ops->read_fifo(priv, addr_offset);
>> +
>> +	return ret;
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
>>  	if (enable) {
>>  		/* enable m_can configuration */
>>  		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>> @@ -430,7 +365,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>>  
>>  	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
>>  		if (timeout == 0) {
>> -			netdev_warn(priv->dev, "Failed to init module\n");
>> +			netdev_warn(priv->net, "Failed to init module\n");
>>  			return;
>>  		}
>>  		timeout--;
>> @@ -438,13 +373,13 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
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
>> @@ -633,9 +568,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
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
>> @@ -644,7 +582,8 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>  
>>  static void m_can_clk_stop(struct m_can_priv *priv)
>>  {
>> -	pm_runtime_put_sync(priv->device);
>> +	if (priv->pm_clock_support)
>> +		pm_runtime_put_sync(priv->dev);
>>  }
>>  
>>  static int m_can_get_berr_counter(const struct net_device *dev,
>> @@ -811,9 +750,8 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
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
>> @@ -831,13 +769,33 @@ static int m_can_poll(struct napi_struct *napi, int quota)
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
>> +	int work_done = 0;
> 
> Is the pre-initialization needed?
> 

No when I copied the function the work_done was pre-initialized.

I can remove it.

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
>> @@ -902,7 +860,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
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
>> @@ -924,6 +885,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>>  		}
>>  	}
>>  
>> +	if (priv->ops->clr_dev_interrupts)
>> +		priv->ops->clr_dev_interrupts(priv);
> 
> post_irq _handler?
> 

I can clear them on entry as well

>> +
>>  	return IRQ_HANDLED;
>>  }
>>  
>> @@ -1155,6 +1119,9 @@ static void m_can_chip_config(struct net_device *dev)
>>  	m_can_set_bittiming(dev);
>>  
>>  	m_can_config_endisable(priv, false);
>> +
>> +	if (priv->ops->device_init)
>> +		priv->ops->device_init(priv);
>>  }
>>  
>>  static void m_can_start(struct net_device *dev)
>> @@ -1188,20 +1155,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
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
>> @@ -1219,18 +1183,22 @@ static int m_can_check_core_release(void __iomem *m_can_base)
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
>> +		if (cccr_poll == cccr_reg)
>> +			niso_timeout = 0;
>> +	}
> 
> There is no break and delay in the loop? What was the reason why you
> can't use readl_poll_timeout()?
> 

OK a break if NISO is supported then and probably could add a 1us delay original code on
line 1232 had no delay but timeout at 10us.

readl_poll_timeout is for iomapped devices.  How would this work for peripherial devices?

>>  
>>  	/* Clear NISO */
>>  	cccr_reg &= ~(CCCR_NISO);
>> @@ -1242,107 +1210,95 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
>>  	return !niso_timeout;
>>  }
>>  
>> -static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
>> -			   void __iomem *addr)
>> +static int m_can_dev_setup(struct m_can_priv *m_can_dev)
>>  {
>> -	struct m_can_priv *priv;
>> +	struct net_device *dev = m_can_dev->net;
>>  	int m_can_version;
>>  
>> -	m_can_version = m_can_check_core_release(addr);
>> +	m_can_version = m_can_check_core_release(m_can_dev);
>>  	/* return if unsupported version */
>>  	if (!m_can_version) {
>> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
>> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
>>  			m_can_version);
>>  		return -EINVAL;
>>  	}
>>  
>> -	priv = netdev_priv(dev);
>> -	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
>> +	if (!m_can_dev->is_peripherial)
>> +		netif_napi_add(dev, &m_can_dev->napi,
>> +			       m_can_poll, M_CAN_NAPI_WEIGHT);
>>  
>>  	/* Shared properties of all M_CAN versions */
>> -	priv->version = m_can_version;
>> -	priv->dev = dev;
>> -	priv->base = addr;
>> -	priv->can.do_set_mode = m_can_set_mode;
>> -	priv->can.do_get_berr_counter = m_can_get_berr_counter;
>> +	m_can_dev->version = m_can_version;
>> +	m_can_dev->can.do_set_mode = m_can_set_mode;
>> +	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
>>  
>>  	/* Set M_CAN supported operations */
>> -	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>> +	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>  					CAN_CTRLMODE_LISTENONLY |
>>  					CAN_CTRLMODE_BERR_REPORTING |
>>  					CAN_CTRLMODE_FD;
>>  
>>  	/* Set properties depending on M_CAN version */
>> -	switch (priv->version) {
>> +	switch (m_can_dev->version) {
>>  	case 30:
>>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
>>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
>> -		priv->can.bittiming_const = &m_can_bittiming_const_30X;
>> -		priv->can.data_bittiming_const =
>> +		if (m_can_dev->bit_timing)
>> +			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
>> +		else
>> +			m_can_dev->can.bittiming_const =
>> +				&m_can_bittiming_const_30X;
>> +		if (m_can_dev->data_timing)
>> +			m_can_dev->can.data_bittiming_const =
>> +				m_can_dev->data_timing;
>> +		else
>> +			m_can_dev->can.data_bittiming_const =
>>  				&m_can_data_bittiming_const_30X;
>>  		break;
>>  	case 31:
>>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
>>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
>> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
>> -		priv->can.data_bittiming_const =
>> +		if (m_can_dev->bit_timing)
>> +			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
>> +		else
>> +			m_can_dev->can.bittiming_const =
>> +				&m_can_bittiming_const_31X;
>> +		if (m_can_dev->data_timing)
>> +			m_can_dev->can.data_bittiming_const =
>> +				m_can_dev->data_timing;
>> +		else
>> +			m_can_dev->can.data_bittiming_const =
>>  				&m_can_data_bittiming_const_31X;
>>  		break;
>>  	case 32:
>> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
>> -		priv->can.data_bittiming_const =
>> +		if (m_can_dev->bit_timing)
>> +			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
>> +		else
>> +			m_can_dev->can.bittiming_const =
>> +				&m_can_bittiming_const_31X;
>> +
>> +		if (m_can_dev->data_timing)
>> +			m_can_dev->can.data_bittiming_const =
>> +				m_can_dev->data_timing;
>> +		else
>> +			m_can_dev->can.data_bittiming_const =
>>  				&m_can_data_bittiming_const_31X;
>> -		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
>> +
>> +		m_can_dev->can.ctrlmode_supported |=
>> +						(m_can_niso_supported(m_can_dev)
>>  						? CAN_CTRLMODE_FD_NON_ISO
>>  						: 0);
> 
> 	        if (m_can_niso_supported(m_can_dev))
> 			m_can_dev->can.ctrlmode_supported |=
> 		 		CAN_CTRLMODE_FD_NON_ISO;
> 

This would be a change from original source line 1295.  Attempted to minimize deltas from original.

>>  		break;
>>  	default:
>> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
>> -			priv->version);
>> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
>> +			m_can_dev->version);
>>  		return -EINVAL;
>>  	}
>>  
>> -	return 0;
>> -}
>> -
>> -static int m_can_open(struct net_device *dev)
>> -{
>> -	struct m_can_priv *priv = netdev_priv(dev);
>> -	int err;
>> -
>> -	err = m_can_clk_start(priv);
>> -	if (err)
>> -		return err;
>> -
>> -	/* open the can device */
>> -	err = open_candev(dev);
>> -	if (err) {
>> -		netdev_err(dev, "failed to open can device\n");
>> -		goto exit_disable_clks;
>> -	}
>> -
>> -	/* register interrupt handler */
>> -	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
>> -			  dev);
>> -	if (err < 0) {
>> -		netdev_err(dev, "failed to request interrupt\n");
>> -		goto exit_irq_fail;
>> -	}
>> -
>> -	/* start the m_can controller */
>> -	m_can_start(dev);
>> -
>> -	can_led_event(dev, CAN_LED_EVENT_OPEN);
>> -	napi_enable(&priv->napi);
>> -	netif_start_queue(dev);
>> +	if (m_can_dev->ops->device_init)
>> +		m_can_dev->ops->device_init(m_can_dev);
>>  
>>  	return 0;
>> -
>> -exit_irq_fail:
>> -	close_candev(dev);
>> -exit_disable_clks:
>> -	m_can_clk_stop(priv);
>> -	return err;
>>  }
>>  
>>  static void m_can_stop(struct net_device *dev)
>> @@ -1361,10 +1317,17 @@ static int m_can_close(struct net_device *dev)
>>  	struct m_can_priv *priv = netdev_priv(dev);
>>  
>>  	netif_stop_queue(dev);
>> -	napi_disable(&priv->napi);
>> +	if (!priv->is_peripherial)
>> +		napi_disable(&priv->napi);
>>  	m_can_stop(dev);
>>  	m_can_clk_stop(priv);
>>  	free_irq(dev->irq, dev);
>> +
>> +	if (priv->is_peripherial) {
>> +		destroy_workqueue(priv->wq);
>> +		priv->wq = NULL;
>> +	}
>> +
>>  	close_candev(dev);
>>  	can_led_event(dev, CAN_LED_EVENT_STOP);
>>  
>> @@ -1385,18 +1348,15 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
>>  	return !!priv->can.echo_skb[next_idx];
>>  }
>>  
>> -static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>> -				    struct net_device *dev)
>> +static void m_can_tx_handler(struct m_can_priv *priv)
>>  {
>> -	struct m_can_priv *priv = netdev_priv(dev);
>> -	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>> +	struct canfd_frame *cf = (struct canfd_frame *)priv->skb->data;
>> +	struct net_device *dev = priv->net;
>> +	struct sk_buff *skb = priv->skb;
> 
> Maybe "tx_skb" is a clearer member name..

Again this was named skb to minimize deltas from original code.

skb was passed into the start_xmit function and used throughout the function.

Since there was little delta in this function I opt'd to keep the names as is.

> 
>>  	u32 id, cccr, fdflags;
>>  	int i;
>>  	int putidx;
>>  
>> -	if (can_dropped_invalid_skb(dev, skb))
>> -		return NETDEV_TX_OK;
>> -
>>  	/* Generate ID field for TX buffer Element */
>>  	/* Common to all supported M_CAN versions */
>>  	if (cf->can_id & CAN_EFF_FLAG) {
>> @@ -1451,7 +1411,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>  			netif_stop_queue(dev);
>>  			netdev_warn(dev,
>>  				    "TX queue active although FIFO is full.");
>> -			return NETDEV_TX_BUSY;
>> +			return;
>>  		}
>>  
>>  		/* get put index for frame */
>> @@ -1492,14 +1452,101 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>  		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
>>  
>>  		/* stop network queue if fifo full */
>> -			if (m_can_tx_fifo_full(priv) ||
>> -			    m_can_next_echo_skb_occupied(dev, putidx))
>> -				netif_stop_queue(dev);
>> +		if (m_can_tx_fifo_full(priv) ||
>> +		    m_can_next_echo_skb_occupied(dev, putidx))
>> +			netif_stop_queue(dev);
>> +	}
>> +}
>> +
>> +static void m_can_tx_work_queue(struct work_struct *ws)
>> +{
>> +	struct m_can_priv *priv = container_of(ws, struct m_can_priv,
>> +						tx_work);
>> +	m_can_tx_handler(priv);
>> +}
>> +
>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>> +				    struct net_device *dev)
>> +{
>> +	struct m_can_priv *priv = netdev_priv(dev);
>> +
>> +
>> + 	if (can_dropped_invalid_skb(dev, skb))
>> +		return NETDEV_TX_OK;
>> + 
>> + 	priv->skb = skb;
>> +	if (priv->is_peripherial) {
>> +		netif_stop_queue(priv->net);
>> +		queue_work(priv->wq, &priv->tx_work);
> 
> s/wq/tx_wq/ ?

This is fine.

Dan

<snip>>>
> 
> Wolfgang
> 


-- 
------------------
Dan Murphy
