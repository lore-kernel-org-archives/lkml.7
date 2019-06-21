Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578AFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E93320679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561126483;
	bh=If2xY54PgeQab1V1J0o6jcFnIezQuds+d6TlqX9UsKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hm7uj1zJIp2pPqgUxDHqX6kT26duKxbJbOMnfrRO/i/bT66bQhiaxHHw8BObf6tLr
	 bjzKl3KCW//3oZ3DErNW8XfaEX9OWr0l8jrcCAZ8V2tQww1eeDOtU7lIJ+UoLTXAqs
	 cc3HEml7Tepr/1BN6xXaNkpX5Aiaf+WufZQOnSDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFUOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:14:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030C420679;
        Fri, 21 Jun 2019 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126479;
        bh=If2xY54PgeQab1V1J0o6jcFnIezQuds+d6TlqX9UsKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyaZmE+O5FK3RWNcS6W0YLUhTdAfR0pg9hZ3QuufQ0HDUHzRgoQbJiGRltwCLVh1K
         NUE1Ic5mSHpQwTgMZXllZqemfb1oCWA7glgwa3qR1+Y2Fy5iJR9r5TSzcQUDS9HanP
         7UW9RT23+45ol50fqJJEljx9gi12edUHHYRsxhdM=
Date:   Fri, 21 Jun 2019 16:14:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V7 04/11] misc: xilinx_sdfec: Store driver config and
 state
Message-ID: <20190621141437.GA4130@kroah.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
 <1560274185-264438-5-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560274185-264438-5-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:29:38PM +0100, Dragan Cvetic wrote:
> Stores configuration based on parameters from the DT
> node and values from the SD-FEC core plus reads
> the default state from the SD-FEC core. To obtain
> values from the core register read, write capabilities
> have been added plus related register map details.
> 
> Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> ---
>  drivers/misc/xilinx_sdfec.c      | 293 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/misc/xilinx_sdfec.h | 138 ++++++++++++++++++
>  2 files changed, 431 insertions(+)
>  create mode 100644 include/uapi/misc/xilinx_sdfec.h
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index f257d38..3b031c6 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -20,11 +20,92 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  
> +#include <uapi/misc/xilinx_sdfec.h>
> +
>  #define DEV_NAME_LEN 12
>  
>  static struct idr dev_idr;
>  static struct mutex dev_idr_lock;
>  
> +/* Xilinx SDFEC Register Map */
> +/* CODE_WRI_PROTECT Register */
> +#define XSDFEC_CODE_WR_PROTECT_ADDR (0x4)
> +
> +/* ACTIVE Register */
> +#define XSDFEC_ACTIVE_ADDR (0x8)
> +#define XSDFEC_IS_ACTIVITY_SET (0x1)
> +
> +/* AXIS_WIDTH Register */
> +#define XSDFEC_AXIS_WIDTH_ADDR (0xC)
> +#define XSDFEC_AXIS_DOUT_WORDS_LSB (5)
> +#define XSDFEC_AXIS_DOUT_WIDTH_LSB (3)
> +#define XSDFEC_AXIS_DIN_WORDS_LSB (2)
> +#define XSDFEC_AXIS_DIN_WIDTH_LSB (0)
> +
> +/* AXIS_ENABLE Register */
> +#define XSDFEC_AXIS_ENABLE_ADDR (0x10)
> +#define XSDFEC_AXIS_OUT_ENABLE_MASK (0x38)
> +#define XSDFEC_AXIS_IN_ENABLE_MASK (0x7)
> +#define XSDFEC_AXIS_ENABLE_MASK                                                \
> +	(XSDFEC_AXIS_OUT_ENABLE_MASK | XSDFEC_AXIS_IN_ENABLE_MASK)
> +
> +/* FEC_CODE Register */
> +#define XSDFEC_FEC_CODE_ADDR (0x14)
> +
> +/* ORDER Register Map */
> +#define XSDFEC_ORDER_ADDR (0x18)
> +
> +/* Interrupt Status Register */
> +#define XSDFEC_ISR_ADDR (0x1C)
> +/* Interrupt Status Register Bit Mask */
> +#define XSDFEC_ISR_MASK (0x3F)
> +
> +/* Write Only - Interrupt Enable Register */
> +#define XSDFEC_IER_ADDR (0x20)
> +/* Write Only - Interrupt Disable Register */
> +#define XSDFEC_IDR_ADDR (0x24)
> +/* Read Only - Interrupt Mask Register */
> +#define XSDFEC_IMR_ADDR (0x28)
> +
> +/* ECC Interrupt Status Register */
> +#define XSDFEC_ECC_ISR_ADDR (0x2C)
> +/* Single Bit Errors */
> +#define XSDFEC_ECC_ISR_SBE_MASK (0x7FF)
> +/* PL Initialize Single Bit Errors */
> +#define XSDFEC_PL_INIT_ECC_ISR_SBE_MASK (0x3C00000)
> +/* Multi Bit Errors */
> +#define XSDFEC_ECC_ISR_MBE_MASK (0x3FF800)
> +/* PL Initialize Multi Bit Errors */
> +#define XSDFEC_PL_INIT_ECC_ISR_MBE_MASK (0x3C000000)
> +/* Multi Bit Error to Event Shift */
> +#define XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT (11)
> +/* PL Initialize Multi Bit Error to Event Shift */
> +#define XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_SHIFT (4)
> +/* ECC Interrupt Status Bit Mask */
> +#define XSDFEC_ECC_ISR_MASK (XSDFEC_ECC_ISR_SBE_MASK | XSDFEC_ECC_ISR_MBE_MASK)
> +/* ECC Interrupt Status PL Initialize Bit Mask */
> +#define XSDFEC_PL_INIT_ECC_ISR_MASK                                            \
> +	(XSDFEC_PL_INIT_ECC_ISR_SBE_MASK | XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
> +/* ECC Interrupt Status All Bit Mask */
> +#define XSDFEC_ALL_ECC_ISR_MASK                                                \
> +	(XSDFEC_ECC_ISR_MASK | XSDFEC_PL_INIT_ECC_ISR_MASK)
> +/* ECC Interrupt Status Single Bit Errors Mask */
> +#define XSDFEC_ALL_ECC_ISR_SBE_MASK                                            \
> +	(XSDFEC_ECC_ISR_SBE_MASK | XSDFEC_PL_INIT_ECC_ISR_SBE_MASK)
> +/* ECC Interrupt Status Multi Bit Errors Mask */
> +#define XSDFEC_ALL_ECC_ISR_MBE_MASK                                            \
> +	(XSDFEC_ECC_ISR_MBE_MASK | XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
> +
> +/* Write Only - ECC Interrupt Enable Register */
> +#define XSDFEC_ECC_IER_ADDR (0x30)
> +/* Write Only - ECC Interrupt Disable Register */
> +#define XSDFEC_ECC_IDR_ADDR (0x34)
> +/* Read Only - ECC Interrupt Mask Register */
> +#define XSDFEC_ECC_IMR_ADDR (0x38)
> +
> +/* BYPASS Register */
> +#define XSDFEC_BYPASS_ADDR (0x3C)
> +
>  /**
>   * struct xsdfec_clks - For managing SD-FEC clocks
>   * @core_clk: Main processing clock for core
> @@ -51,6 +132,8 @@ struct xsdfec_clks {
>   * struct xsdfec_dev - Driver data for SDFEC
>   * @regs: device physical base address
>   * @dev: pointer to device struct
> + * @state: State of the SDFEC device
> + * @config: Configuration of the SDFEC device
>   * @miscdev: Misc device handle
>   * @error_data_lock: Error counter and states spinlock
>   * @clks: Clocks managed by the SDFEC driver
> @@ -62,6 +145,8 @@ struct xsdfec_clks {
>  struct xsdfec_dev {
>  	void __iomem *regs;
>  	struct device *dev;
> +	enum xsdfec_state state;
> +	struct xsdfec_config config;
>  	struct miscdevice miscdev;
>  	/* Spinlock to protect state_updated and stats_updated */
>  	spinlock_t error_data_lock;
> @@ -70,10 +155,212 @@ struct xsdfec_dev {
>  	int dev_id;
>  };
>  
> +static inline void xsdfec_regwrite(struct xsdfec_dev *xsdfec, u32 addr,
> +				   u32 value)
> +{
> +	dev_dbg(xsdfec->dev, "Writing 0x%x to offset 0x%x", value, addr);
> +	iowrite32(value, xsdfec->regs + addr);
> +}
> +
> +static inline u32 xsdfec_regread(struct xsdfec_dev *xsdfec, u32 addr)
> +{
> +	u32 rval;
> +
> +	rval = ioread32(xsdfec->regs + addr);
> +	dev_dbg(xsdfec->dev, "Read value = 0x%x from offset 0x%x", rval, addr);
> +	return rval;
> +}
> +
> +static void update_bool_config_from_reg(struct xsdfec_dev *xsdfec,
> +					u32 reg_offset, u32 bit_num,
> +					char *config_value)
> +{
> +	u32 reg_val;
> +	u32 bit_mask = 1 << bit_num;
> +
> +	reg_val = xsdfec_regread(xsdfec, reg_offset);
> +	*config_value = (reg_val & bit_mask) > 0;
> +}
> +
> +static void update_config_from_hw(struct xsdfec_dev *xsdfec)
> +{
> +	u32 reg_value;
> +	bool sdfec_started;
> +
> +	/* Update the Order */
> +	reg_value = xsdfec_regread(xsdfec, XSDFEC_ORDER_ADDR);
> +	xsdfec->config.order = reg_value;
> +
> +	update_bool_config_from_reg(xsdfec, XSDFEC_BYPASS_ADDR,
> +				    0, /* Bit Number, maybe change to mask */
> +				    &xsdfec->config.bypass);
> +
> +	update_bool_config_from_reg(xsdfec, XSDFEC_CODE_WR_PROTECT_ADDR,
> +				    0, /* Bit Number */
> +				    &xsdfec->config.code_wr_protect);
> +
> +	reg_value = xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
> +	xsdfec->config.irq.enable_isr = (reg_value & XSDFEC_ISR_MASK) > 0;
> +
> +	reg_value = xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
> +	xsdfec->config.irq.enable_ecc_isr =
> +		(reg_value & XSDFEC_ECC_ISR_MASK) > 0;
> +
> +	reg_value = xsdfec_regread(xsdfec, XSDFEC_AXIS_ENABLE_ADDR);
> +	sdfec_started = (reg_value & XSDFEC_AXIS_IN_ENABLE_MASK) > 0;
> +	if (sdfec_started)
> +		xsdfec->state = XSDFEC_STARTED;
> +	else
> +		xsdfec->state = XSDFEC_STOPPED;
> +}
> +
> +static u32
> +xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
> +{
> +	u32 axis_width_field = 0;
> +
> +	switch (axis_width_cfg) {
> +	case XSDFEC_1x128b:
> +		axis_width_field = 0;
> +		break;
> +	case XSDFEC_2x128b:
> +		axis_width_field = 1;
> +		break;
> +	case XSDFEC_4x128b:
> +		axis_width_field = 2;
> +		break;
> +	}
> +
> +	return axis_width_field;
> +}
> +
> +static u32 xsdfec_translate_axis_words_cfg_val(enum xsdfec_axis_word_include
> +	axis_word_inc_cfg)
> +{
> +	u32 axis_words_field = 0;
> +
> +	if (axis_word_inc_cfg == XSDFEC_FIXED_VALUE ||
> +	    axis_word_inc_cfg == XSDFEC_IN_BLOCK)
> +		axis_words_field = 0;
> +	else if (axis_word_inc_cfg == XSDFEC_PER_AXI_TRANSACTION)
> +		axis_words_field = 1;
> +
> +	return axis_words_field;
> +}
> +
> +static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
> +{
> +	u32 reg_value;
> +	u32 dout_words_field;
> +	u32 dout_width_field;
> +	u32 din_words_field;
> +	u32 din_width_field;
> +	struct xsdfec_config *config = &xsdfec->config;
> +
> +	/* translate config info to register values */
> +	dout_words_field =
> +		xsdfec_translate_axis_words_cfg_val(config->dout_word_include);
> +	dout_width_field =
> +		xsdfec_translate_axis_width_cfg_val(config->dout_width);
> +	din_words_field =
> +		xsdfec_translate_axis_words_cfg_val(config->din_word_include);
> +	din_width_field =
> +		xsdfec_translate_axis_width_cfg_val(config->din_width);
> +
> +	reg_value = dout_words_field << XSDFEC_AXIS_DOUT_WORDS_LSB;
> +	reg_value |= dout_width_field << XSDFEC_AXIS_DOUT_WIDTH_LSB;
> +	reg_value |= din_words_field << XSDFEC_AXIS_DIN_WORDS_LSB;
> +	reg_value |= din_width_field << XSDFEC_AXIS_DIN_WIDTH_LSB;
> +
> +	xsdfec_regwrite(xsdfec, XSDFEC_AXIS_WIDTH_ADDR, reg_value);
> +
> +	return 0;
> +}
> +
>  static const struct file_operations xsdfec_fops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
> +{
> +	struct device *dev = xsdfec->dev;
> +	struct device_node *node = dev->of_node;
> +	int rval;
> +	const char *fec_code;
> +	enum xsdfec_axis_width din_width;
> +	enum xsdfec_axis_word_include din_word_include;
> +	enum xsdfec_axis_width dout_width;
> +	enum xsdfec_axis_word_include dout_word_include;
> +
> +	rval = of_property_read_string(node, "xlnx,sdfec-code", &fec_code);
> +	if (rval < 0)
> +		return rval;
> +
> +	if (!strcasecmp(fec_code, "ldpc"))
> +		xsdfec->config.code = XSDFEC_LDPC_CODE;
> +	else if (!strcasecmp(fec_code, "turbo"))
> +		xsdfec->config.code = XSDFEC_TURBO_CODE;
> +	else
> +		return -EINVAL;
> +
> +	rval = of_property_read_u32(node, "xlnx,sdfec-din-words",
> +				    &din_word_include);
> +	if (rval < 0)
> +		return rval;
> +
> +	if (din_word_include < XSDFEC_AXIS_WORDS_INCLUDE_MAX)
> +		xsdfec->config.din_word_include = din_word_include;
> +	else
> +		return -EINVAL;
> +
> +	rval = of_property_read_u32(node, "xlnx,sdfec-din-width", &din_width);
> +	if (rval < 0)
> +		return rval;
> +
> +	switch (din_width) {
> +	/* Fall through and set for valid values */
> +	case XSDFEC_1x128b:
> +	case XSDFEC_2x128b:
> +	case XSDFEC_4x128b:
> +		xsdfec->config.din_width = din_width;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rval = of_property_read_u32(node, "xlnx,sdfec-dout-words",
> +				    &dout_word_include);
> +	if (rval < 0)
> +		return rval;
> +
> +	if (dout_word_include < XSDFEC_AXIS_WORDS_INCLUDE_MAX)
> +		xsdfec->config.dout_word_include = dout_word_include;
> +	else
> +		return -EINVAL;
> +
> +	rval = of_property_read_u32(node, "xlnx,sdfec-dout-width", &dout_width);
> +	if (rval < 0)
> +		return rval;
> +
> +	switch (dout_width) {
> +	/* Fall through and set for valid values */
> +	case XSDFEC_1x128b:
> +	case XSDFEC_2x128b:
> +	case XSDFEC_4x128b:
> +		xsdfec->config.dout_width = dout_width;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Write LDPC to CODE Register */
> +	xsdfec_regwrite(xsdfec, XSDFEC_FEC_CODE_ADDR, xsdfec->config.code);
> +
> +	xsdfec_cfg_axi_streams(xsdfec);
> +
> +	return 0;
> +}
> +
>  static int xsdfec_clk_init(struct platform_device *pdev,
>  			   struct xsdfec_clks *clks)
>  {
> @@ -260,6 +547,12 @@ static int xsdfec_probe(struct platform_device *pdev)
>  		goto err_xsdfec_dev;
>  	}
>  
> +	err = xsdfec_parse_of(xsdfec);
> +	if (err < 0)
> +		goto err_xsdfec_dev;
> +
> +	update_config_from_hw(xsdfec);
> +
>  	/* Save driver private data */
>  	platform_set_drvdata(pdev, xsdfec);
>  
> diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
> new file mode 100644
> index 0000000..aec26b3
> --- /dev/null
> +++ b/include/uapi/misc/xilinx_sdfec.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Xilinx SD-FEC
> + *
> + * Copyright (C) 2019 Xilinx, Inc.
> + *
> + * Description:
> + * This driver is developed for SDFEC16 IP. It provides a char device
> + * in sysfs and supports file operations like open(), close() and ioctl().
> + */
> +#ifndef __XILINX_SDFEC_H__
> +#define __XILINX_SDFEC_H__
> +
> +#include <linux/types.h>
> +
> +/**
> + * enum xsdfec_code - Code Type.
> + * @XSDFEC_TURBO_CODE: Driver is configured for Turbo mode.
> + * @XSDFEC_LDPC_CODE: Driver is configured for LDPC mode.
> + *
> + * This enum is used to indicate the mode of the driver. The mode is determined
> + * by checking which codes are set in the driver. Note that the mode cannot be
> + * changed by the driver.
> + */
> +enum xsdfec_code {
> +	XSDFEC_TURBO_CODE = 0,
> +	XSDFEC_LDPC_CODE,
> +};
> +
> +/**
> + * enum xsdfec_order - Order
> + * @XSDFEC_MAINTAIN_ORDER: Maintain order execution of blocks.
> + * @XSDFEC_OUT_OF_ORDER: Out-of-order execution of blocks.
> + *
> + * This enum is used to indicate whether the order of blocks can change from
> + * input to output.
> + */
> +enum xsdfec_order {
> +	XSDFEC_MAINTAIN_ORDER = 0,
> +	XSDFEC_OUT_OF_ORDER,
> +};
> +
> +/**
> + * enum xsdfec_state - State.
> + * @XSDFEC_INIT: Driver is initialized.
> + * @XSDFEC_STARTED: Driver is started.
> + * @XSDFEC_STOPPED: Driver is stopped.
> + * @XSDFEC_NEEDS_RESET: Driver needs to be reset.
> + * @XSDFEC_PL_RECONFIGURE: Programmable Logic needs to be recofigured.
> + *
> + * This enum is used to indicate the state of the driver.
> + */
> +enum xsdfec_state {
> +	XSDFEC_INIT = 0,
> +	XSDFEC_STARTED,
> +	XSDFEC_STOPPED,
> +	XSDFEC_NEEDS_RESET,
> +	XSDFEC_PL_RECONFIGURE,
> +};
> +
> +/**
> + * enum xsdfec_axis_width - AXIS_WIDTH.DIN Setting for 128-bit width.
> + * @XSDFEC_1x128b: DIN data input stream consists of a 128-bit lane
> + * @XSDFEC_2x128b: DIN data input stream consists of two 128-bit lanes
> + * @XSDFEC_4x128b: DIN data input stream consists of four 128-bit lanes
> + *
> + * This enum is used to indicate the AXIS_WIDTH.DIN setting for 128-bit width.
> + * The number of lanes of the DIN data input stream depends upon the
> + * AXIS_WIDTH.DIN parameter.
> + */
> +enum xsdfec_axis_width {
> +	XSDFEC_1x128b = 1,
> +	XSDFEC_2x128b = 2,
> +	XSDFEC_4x128b = 4,
> +};
> +
> +/**
> + * enum xsdfec_axis_word_include - Words Configuration.
> + * @XSDFEC_FIXED_VALUE: Fixed, the DIN_WORDS AXI4-Stream interface is removed
> + *			from the IP instance and is driven with the specified
> + *			number of words.
> + * @XSDFEC_IN_BLOCK: In Block, configures the IP instance to expect a single
> + *		     DIN_WORDS value per input code block. The DIN_WORDS
> + *		     interface is present.
> + * @XSDFEC_PER_AXI_TRANSACTION: Per Transaction, configures the IP instance to
> + * expect one DIN_WORDS value per input transaction on the DIN interface. The
> + * DIN_WORDS interface is present.
> + * @XSDFEC_AXIS_WORDS_INCLUDE_MAX: Used to indicate out of bound Words
> + *				   Configurations.
> + *
> + * This enum is used to specify the DIN_WORDS configuration.
> + */
> +enum xsdfec_axis_word_include {
> +	XSDFEC_FIXED_VALUE = 0,
> +	XSDFEC_IN_BLOCK,
> +	XSDFEC_PER_AXI_TRANSACTION,
> +	XSDFEC_AXIS_WORDS_INCLUDE_MAX,
> +};
> +
> +/**
> + * struct xsdfec_irq - Enabling or Disabling Interrupts.
> + * @enable_isr: If true enables the ISR
> + * @enable_ecc_isr: If true enables the ECC ISR
> + */
> +struct xsdfec_irq {
> +	__s8 enable_isr;
> +	__s8 enable_ecc_isr;
> +};
> +
> +/**
> + * struct xsdfec_config - Configuration of SD-FEC core.
> + * @code: The codes being used by the SD-FEC instance
> + * @order: Order of Operation
> + * @bypass: Is the core being bypassed
> + * @code_wr_protect: Is write protection of LDPC codes enabled
> + * @din_width: Width of the DIN AXI4-Stream
> + * @din_word_include: How DIN_WORDS are inputted
> + * @dout_width: Width of the DOUT AXI4-Stream
> + * @dout_word_include: HOW DOUT_WORDS are outputted
> + * @irq: Enabling or disabling interrupts
> + */
> +struct xsdfec_config {
> +	__u32 code;
> +	__u32 order;
> +	__s8 bypass;
> +	__s8 code_wr_protect;
> +	__u32 din_width;
> +	__u32 din_word_include;
> +	__u32 dout_width;
> +	__u32 dout_word_include;
> +	struct xsdfec_irq irq;
> +};

Ick, that structure is not a good one to pass across the user/kernel
boundry.  Are you ok with that big hole in there?

Please use a tool like pahole to figure out how to get this to work
properly on both 32 and 64bit machines without unneeded padding.

thanks,

greg k-h
