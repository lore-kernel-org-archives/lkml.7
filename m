Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DEC2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ec2V3hEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDEEnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:43:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEEnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:43:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x354gjqY054834;
        Thu, 4 Apr 2019 23:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554439365;
        bh=FrOEIZruaUA+WUuGykmOzZJvsIbd8p65+rQQUO2qvLI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ec2V3hEN/pG98J/7yvYs0cN7xTeNu3hTzryAaysVhXypsYCwrEX4mpULLoMvRvKM2
         qviRzENcyqZUyfQHg/a+HxCjMXDU+tae0tjEwOh4cG0r8rCuyygjMcrC0ZkJZMlHj+
         oRvRI/pWRfFkpk1mQp/s+BJy6RuYhXWx9r+FVxxQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x354gjmj034331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 23:42:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 23:42:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 23:42:44 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x354gewt052962;
        Thu, 4 Apr 2019 23:42:41 -0500
Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c8f73eab-99eb-ddbc-9776-ea6b3a3ecf0f@ti.com>
Date:   Fri, 5 Apr 2019 10:13:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/19 1:29 PM, Naga Sureshkumar Relli wrote:
> +/**
> + * zynq_qspi_config_op - Configure QSPI controller for specified transfer
> + * @xqspi:	Pointer to the zynq_qspi structure
> + * @qspi:	Pointer to the spi_device structure
> + *
> + * Sets the operational mode of QSPI controller for the next QSPI transfer and
> + * sets the requested clock frequency.
> + *
> + * Return:	0 on success and -EINVAL on invalid input parameter
> + *
> + * Note: If the requested frequency is not an exact match with what can be
> + * obtained using the prescalar value, the driver sets the clock frequency which
> + * is lower than the requested frequency (maximum lower) for the transfer. If
> + * the requested frequency is higher or lower than that is supported by the QSPI
> + * controller the driver will set the highest or lowest frequency supported by
> + * controller.
> + */
> +static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
> +{
> +	u32 config_reg, baud_rate_val = 0;
> +
> +	/*
> +	 * Set the clock frequency
> +	 * The baud rate divisor is not a direct mapping to the value written
> +	 * into the configuration register (config_reg[5:3])
> +	 * i.e. 000 - divide by 2
> +	 *      001 - divide by 4
> +	 *      ----------------
> +	 *      111 - divide by 256
> +	 */
> +	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
> +	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
> +		spi->max_speed_hz)
> +		baud_rate_val++;
> +

Instead use DIV_ROUND_UP, something like below should work(untested):

	unsigned long refclk_rate = clk_get_rate(xqspi->refclk);
	u32 baud_rate_val = DIV_ROUND_UP(refclk_rate, spi->max_speed_hz) - 1;

	if (baud_rate_val > ZYNQ_QSPI_BAUD_DIV_MAX)
		baud_rate_val = ZYNQ_QSPI_BAUD_DIV_MAX;

> +	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
> +
> +	/* Set the QSPI clock phase and clock polarity */
> +	config_reg &= (~ZYNQ_QSPI_CONFIG_CPHA_MASK) &
> +		      (~ZYNQ_QSPI_CONFIG_CPOL_MASK);
> +	if (spi->mode & SPI_CPHA)
> +		config_reg |= ZYNQ_QSPI_CONFIG_CPHA_MASK;
> +	if (spi->mode & SPI_CPOL)
> +		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
> +
> +	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
> +	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
> +	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
> +
> +	return 0;
> +}
> +

-- 
Regards
Vignesh
