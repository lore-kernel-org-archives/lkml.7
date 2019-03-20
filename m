Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162CF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUbwWnAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCTRLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:11:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35750 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCTRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:11:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2KHB3u7024413;
        Wed, 20 Mar 2019 12:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553101863;
        bh=vNyrPfp/rapz2FAlW3IAC6oQ99GzNrsC7h56+ls4X90=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FUbwWnApr91TgwAXRLMVFI3Dm/NINuItT+KjBLwW/4MJMulkHpn6BIxYqo1xkd28j
         +1hPIO/X80mAqGB+4NSk9+V3l+XsLHQ4IR0BL+qJGJUdNjc8JoR7cMcCa4aCfoxSm/
         hLEHUZmFpxtSKO0nN5O+MWlK6Db+OrNhhMNjIpis=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2KHB3tk013133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 12:11:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 12:11:03 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 12:11:03 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2KHAxxC010307;
        Wed, 20 Mar 2019 12:11:00 -0500
Subject: Re: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI
 controller
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>
References: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <be5f5974-2f8f-1d8d-6f93-4b975a8114b1@ti.com>
Date:   Wed, 20 Mar 2019 22:41:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few more comments that I missed last time around.

On 28/02/19 12:32 PM, Naga Sureshkumar Relli wrote:
> Add support for QSPI controller driver used by Xilinx Zynq SOC.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
>  drivers/spi/Kconfig         |   8 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-zynq-qspi.c | 780 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 789 insertions(+)
>  create mode 100644 drivers/spi/spi-zynq-qspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..f12c880 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -816,6 +816,14 @@ config SPI_XTENSA_XTFPGA
>  	  16 bit words in SPI mode 0, automatically asserting CS on transfer
>  	  start and deasserting on end.
>  
> +config SPI_ZYNQ_QSPI
> +	tristate "Xilinx Zynq QSPI controller"
> +	depends on ARCH_ZYNQ

Could you enable the driver for compile testing?
From quick look this should enough:

depends on ARCH_ZYNQ || COMPILE_TEST

> +	help
> +	  This enables support for the Zynq Quad SPI controller
> +	  in master mode.
> +	  This controller only supports SPI memory interface.
> +
>  config SPI_ZYNQMP_GQSPI
>  	tristate "Xilinx ZynqMP GQSPI controller"
>  	depends on SPI_MASTER && HAS_DMA

[...]

> +/**
> + * zynq_qspi_exec_mem_op() - Initiates the QSPI transfer
> + * @mem: the SPI memory
> + * @op: the memory operation to execute
> + *
> + * Executes a memory operation.
> + *
> + * This function first selects the chip and starts the memory operation.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
> +	int err = 0, i;
> +	u8 *tmpbuf;
> +
> +	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
> +		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +		op->dummy.buswidth, op->data.buswidth);
> +
> +	zynq_qspi_chipselect(mem->spi, true);
> +	zynq_qspi_config_op(xqspi, mem->spi);
> +
> +	if (op->cmd.opcode) {
> +		reinit_completion(&xqspi->data_completion);
> +		xqspi->txbuf = (u8 *)&op->cmd.opcode;
> +		xqspi->rxbuf = NULL;
> +		xqspi->tx_bytes = sizeof(op->cmd.opcode);
> +		xqspi->rx_bytes = sizeof(op->cmd.opcode);
> +		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
> +		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
> +				ZYNQ_QSPI_IXR_RXTX_MASK);
> +		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +							       msecs_to_jiffies(1000))) {
> +			err = -ETIMEDOUT;
> +		}
> +	}
> +	zynq_qspi_config_op(xqspi, mem->spi);

Why is it required to call zynq_qspi_config_op() b/w every stage of
single flash operation? Is it not enough to do once at the beginning?

> +	if (op->addr.nbytes) {
> +		for (i = 0; i < op->addr.nbytes; i++) {
> +			xqspi->txbuf[i] = op->addr.val >>
> +					(8 * (op->addr.nbytes - i - 1));
> +		}
> +
> +		reinit_completion(&xqspi->data_completion);
> +		xqspi->rxbuf = NULL;
> +		xqspi->tx_bytes = op->addr.nbytes;
> +		xqspi->rx_bytes = op->addr.nbytes;
> +		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
> +		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
> +				ZYNQ_QSPI_IXR_RXTX_MASK);
> +		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +							       msecs_to_jiffies(1000))) {
> +			err = -ETIMEDOUT;
> +		}
> +	}
> +	zynq_qspi_config_op(xqspi, mem->spi);
> +	if (op->dummy.nbytes) {
> +		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL);
> +		memset(tmpbuf, 0xff, op->dummy.nbytes);
> +		reinit_completion(&xqspi->data_completion);
> +		xqspi->txbuf = tmpbuf;
> +		xqspi->rxbuf = NULL;
> +		xqspi->tx_bytes = op->dummy.nbytes;
> +		xqspi->rx_bytes = op->dummy.nbytes;
> +		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
> +		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
> +				ZYNQ_QSPI_IXR_RXTX_MASK);
> +		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +							       msecs_to_jiffies(1000))) {
> +			err = -ETIMEDOUT;
> +		}
> +		kfree(tmpbuf);
> +	}
> +	zynq_qspi_config_op(xqspi, mem->spi);
> +	if (op->data.nbytes) {
> +		reinit_completion(&xqspi->data_completion);
> +		if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			xqspi->txbuf = (u8 *)op->data.buf.out;
> +			xqspi->tx_bytes = op->data.nbytes;
> +			xqspi->rxbuf = NULL;
> +			xqspi->rx_bytes = op->data.nbytes;
> +		} else {
> +			xqspi->txbuf = NULL;
> +			xqspi->rxbuf = (u8 *)op->data.buf.in;
> +			xqspi->rx_bytes = op->data.nbytes;
> +			xqspi->tx_bytes = op->data.nbytes;
> +		}
> +
> +		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
> +		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
> +				ZYNQ_QSPI_IXR_RXTX_MASK);
> +		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
> +							       msecs_to_jiffies(1000))) {
> +			err = -ETIMEDOUT;
> +		}
> +	}
> +	zynq_qspi_chipselect(mem->spi, false);
> +
> +	return err;
> +}
> +
> +static const struct spi_controller_mem_ops zynq_qspi_mem_ops = {
> +	.supports_op = zynq_qspi_supports_op,
> +	.exec_op = zynq_qspi_exec_mem_op,
> +};
> +
> +/**
> + * zynq_qspi_probe - Probe method for the QSPI driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware.
> + *
> + * Return:	0 on success and error value on failure
> + */
> +static int zynq_qspi_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct spi_controller *ctlr;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct zynq_qspi *xqspi;
> +	struct resource *res;
> +	u32 num_cs;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	xqspi = spi_controller_get_devdata(ctlr);
> +	xqspi->dev = dev;
> +	platform_set_drvdata(pdev, xqspi);
> +	ctlr->mem_ops = &zynq_qspi_mem_ops;


ctlr->mem_ops is initialized twice. See below..

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xqspi->regs)) {
> +		ret = PTR_ERR(xqspi->regs);
> +		goto remove_master;
> +	}
> +
> +	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(xqspi->pclk)) {
> +		dev_err(&pdev->dev, "pclk clock not found.\n");
> +		ret = PTR_ERR(xqspi->pclk);
> +		goto remove_master;
> +	}
> +
> +	init_completion(&xqspi->data_completion);
> +
> +	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
> +	if (IS_ERR(xqspi->refclk)) {
> +		dev_err(&pdev->dev, "ref_clk clock not found.\n");
> +		ret = PTR_ERR(xqspi->refclk);
> +		goto remove_master;
> +	}
> +
> +	ret = clk_prepare_enable(xqspi->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
> +		goto remove_master;
> +	}
> +
> +	ret = clk_prepare_enable(xqspi->refclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable device clock.\n");
> +		goto clk_dis_pclk;
> +	}
> +
> +	/* QSPI controller initializations */
> +	zynq_qspi_init_hw(xqspi);
> +
> +	xqspi->irq = platform_get_irq(pdev, 0);
> +	if (xqspi->irq <= 0) {
> +		ret = -ENXIO;
> +		dev_err(&pdev->dev, "irq resource not found\n");
> +		goto remove_master;
> +	}
> +	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
> +			       0, pdev->name, xqspi);
> +	if (ret != 0) {
> +		ret = -ENXIO;
> +		dev_err(&pdev->dev, "request_irq failed\n");
> +		goto remove_master;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "num-cs",
> +				   &num_cs);
> +	if (ret < 0)
> +		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
> +	else
> +		ctlr->num_chipselect = num_cs;
> +	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
> +			    SPI_TX_DUAL | SPI_TX_QUAD;
> +	ctlr->mem_ops = &zynq_qspi_mem_ops;

And here again...

> +	ctlr->setup = zynq_qspi_setup_op;
> +	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
> +	ctlr->dev.of_node = np;
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");
> +		goto clk_dis_all;
> +	}
> +
> +	return ret;
> +
> +clk_dis_all:
> +	clk_disable_unprepare(xqspi->refclk);
> +clk_dis_pclk:
> +	clk_disable_unprepare(xqspi->pclk);
> +remove_master:
> +	spi_controller_put(ctlr);
> +
> +	return ret;
> +}
> +
> +/**
> + * zynq_qspi_remove - Remove method for the QSPI driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function is called if a device is physically removed from the system or
> + * if the driver module is being unloaded. It frees all resources allocated to
> + * the device.
> + *
> + * Return:	0 on success and error value on failure
> + */
> +static int zynq_qspi_remove(struct platform_device *pdev)
> +{
> +	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
> +
> +	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
> +
> +	clk_disable_unprepare(xqspi->refclk);
> +	clk_disable_unprepare(xqspi->pclk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zynq_qspi_of_match[] = {
> +	{ .compatible = "xlnx,zynq-qspi-1.0", },
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynq_qspi_of_match);
> +
> +/*
> + * zynq_qspi_driver - This structure defines the QSPI platform driver
> + */
> +static struct platform_driver zynq_qspi_driver = {
> +	.probe = zynq_qspi_probe,
> +	.remove = zynq_qspi_remove,
> +	.driver = {
> +		.name = "zynq-qspi",
> +		.of_match_table = zynq_qspi_of_match,
> +	},
> +};
> +
> +module_platform_driver(zynq_qspi_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_DESCRIPTION("Xilinx Zynq QSPI driver");
> +MODULE_LICENSE("GPL");
> 

-- 
Regards
Vignesh
