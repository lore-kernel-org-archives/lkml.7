Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4E2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XQQXULug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfC2PwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:52:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45425 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfC2PwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:52:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so1761103lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/UACOdw5Dy2jECqLOH6RgxKIWAdzzK2r2ydQ1m0AXs=;
        b=XQQXULugQ6+zK1QFWj8H4C9+3P3O/vc6EUsowWfdsB1bCI1pJVn68D14xoNFzDBEAf
         L+bq5DlBrhL5xDrx6V/TYzOL6zi4MejejaNcPOGaMf8kufxZgKviN3IIPE9NqgJyupgP
         oFcLq+/wvoPdpowtrqo8bATAemAiYsA9SUQdUo7VJC1Thqn60HQXW1g/HVR7UyJ9+Z8i
         TNJhREVWgJMzFxRbaFjwNbz4IRyEupr4aJhfklrMBMQyTcUy9cpw09aiGNUyG7HCDsNh
         dqf3qPXz8UvDefgK7WyNZE1ADa7x9Ae979nMWntl7kiIOkLr/YAowWGIGzwOnxyYFupk
         dVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6/UACOdw5Dy2jECqLOH6RgxKIWAdzzK2r2ydQ1m0AXs=;
        b=E6x9WTUpeAULEUyNIp5g9GSDOckv+lUutZz/OPKD3hzjPZ+pQ2BLrmD/8vYBGkS8/i
         cdZeM03uYfrByp+xA3PMtof+XOMCFXrQsuES1x7zIO7cNIv0zx2z7bdDpuws79cxGfDZ
         F7NoldkIqNsqQbBFSvTB48oufbFdvIf1mcXW118EUa8RswAcVlUsj8r9Z1/3+/z1xlJA
         JJJLoMjg/QxEg3F8m0ZYOBXFm73CoHwE4u/WCSCxk2vzGT0KO8O8yXmv37dfPOfrruNV
         h+nEC838r13s0R0c3qW1oKLKMEKnvnI4SFg0ZbQ04gEHA9PlOAlKMcd7DE9DVYmY2Jrs
         Y7/w==
X-Gm-Message-State: APjAAAV3DRAxfkLIGZCaWYS9ERs+AP85OMazqNRNcAxG/1VvKeK6TAMa
        Ulhg+IgNJ5fWesS9U+JSpJNqiA==
X-Google-Smtp-Source: APXvYqxlrpqzYqfD5Rx8aCtrPlQ5IbFmr65ETZF2qwTcQZIfXI+C/8RqLK4T8hl0tZoD6v1Fg+ObNg==
X-Received: by 2002:ac2:4354:: with SMTP id o20mr12051098lfl.62.1553874724852;
        Fri, 29 Mar 2019 08:52:04 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.161])
        by smtp.gmail.com with ESMTPSA id d4sm355317lfj.50.2019.03.29.08.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:52:04 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
Date:   Fri, 29 Mar 2019 18:52:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..037f273
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,640 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#include <linux/mfd/renesas-rpc.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +#include <asm/unaligned.h>
> +
> +struct rpc_spi {
> +	struct clk *clk_rpc;
> +	void __iomem *base;
> +	void __iomem *dirmap;
> +	void __iomem *wbuf;
> +	struct regmap *regmap;

   Why copy struct rpc_mfd's fields?

> +	u32 cur_speed_hz;
> +	u32 cmd;
> +	u32 addr;
> +	u32 dummy;
> +	u32 smcr;
> +	u32 smenr;

   I suggest renaming this field to 'enable'.

> +	u32 xferlen;
> +	u32 totalxferlen;
> +	enum spi_mem_data_dir xfer_dir;
> +	struct reset_control *rstc;
> +};
[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	//
> +	// NOTE: The 0x260 are undocumented bits, but they must be set.
> +	//	 RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	//	 0x0 : the delay is biggest,
> +	//	 0x1 : the delay is 2nd biggest,
> +	//	 On H3 ES1.x, the value should be 0, while on others,
> +	//	 the value should be 6.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	//
> +	// NOTE: The 0x1511144 are undocumented bits, but they must be set
> +	//       for RPC_PHYOFFSET1.
> +	//	 The 0x31 are undocumented bits, but they must be set
> +	//	 for RPC_PHYOFFSET2.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
> +		     0x1511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> +		     RPC_PHYOFFSET2_OCTTMG(4));
> +	regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> +		     RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +		     RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +		     RPC_CMNCR_BSZ(0));
> +}

  This function looks like a candidate to moving to the common (MFD) driver. 

> +
> +static int wait_msg_xfer_end(struct rpc_spi *rpc)
> +{
> +	u32 sts;
> +
> +	return regmap_read_poll_timeout(rpc->regmap, RPC_CMNSR, sts,
> +					sts & RPC_CMNSR_TEND, 0, USEC_PER_SEC);
> +}

   This as well.

> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
> +	struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
> +
> +	rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
> +	rpc->smenr = RPC_SMENR_CDE |
> +		     RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
> +	rpc->totalxferlen = 1;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +	rpc->xferlen = 0;
> +	rpc->addr = 0;
> +
> +	if (op->addr.nbytes) {
> +		rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
> +		if (op->addr.nbytes == 4)
> +			rpc->smenr |= RPC_SMENR_ADE(0xf);
> +		else
> +			rpc->smenr |= RPC_SMENR_ADE(0x7);
> +
> +		if (offs && len)
> +			rpc->addr = *offs;
> +		else
> +			rpc->addr = op->addr.val;
> +		rpc->totalxferlen += op->addr.nbytes;
> +	}
> +
> +	if (op->dummy.nbytes) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);

   So you haven't fixed this bug? I repeat, the driver doesn't work right
w/o this fixed!

[...]
> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +				       u64 offs, size_t len, void *buf)
> +{
> +	struct rpc_spi *rpc =
> +			spi_controller_get_devdata(desc->mem->spi->controller);
> +	int ret;
> +
> +	if (offs + desc->info.offset + len > U32_MAX)
> +		return -EINVAL;
> +
> +	if (len > 0x4000000)
> +		len = 0x4000000;

   Ugh...

> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
> +		     RPC_DRCR_RBE);
> +
> +	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));

   So you're not even trying to support flashes larger than the read dirmap?
Now I don't think it's acceptable (and I have rewritten this code internally).

[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
> +	struct rpc_spi *rpc =
> +			spi_controller_get_devdata(desc->mem->spi->controller);
> +	int ret;
> +
> +	if (offs + desc->info.offset + len > U32_MAX)
> +		return -EINVAL;
> +
> +	if (len > RPC_WBUF_SIZE)
> +		len = RPC_WBUF_SIZE;

   Ugh! Again, I no longer think this is acceptable... Maybe we just need
to drop the support of the write buffer...

[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
[...]
> +	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
> +		rpc->smenr |=
> +			RPC_SMENR_ADB(ilog2((unsigned int)xfer[1].tx_nbits));
> +
> +		for (i = 0; i < xfer[1].len; i++)
> +			rpc->addr |= ((u8 *)xfer[1].tx_buf)[i] <<
> +				     (8 * (xfer[1].len - i - 1));
> +
> +		if (xfer[1].len == 4)
> +			rpc->smenr |= RPC_SMENR_ADE(0xf);
> +		else
> +			rpc->smenr |= RPC_SMENR_ADE(0x7);
> +	}
> +
> +	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);

   Needs to be multiplied by 8 (or other value) as well...

[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
> +	struct rpc_spi *rpc;
> +	int ret;
[...]
> +	rpc->clk_rpc = rpc_mfd->clk_rpc;
> +	if (IS_ERR(rpc->clk_rpc))
> +		return PTR_ERR(rpc->clk_rpc);
> +
> +	rpc->base = rpc_mfd->base;
> +	if (IS_ERR(rpc->base))
> +		return PTR_ERR(rpc->base);
> +
> +	rpc->regmap = rpc_mfd->regmap;
> +	if (IS_ERR(rpc->regmap)) {
> +		dev_err(&pdev->dev,
> +			"failed to regmap for rpc-spi, error %ld\n",
> +			PTR_ERR(rpc->regmap));
> +		return PTR_ERR(rpc->regmap);
> +	}
> +
> +	rpc->dirmap = rpc_mfd->dirmap;
> +	if (IS_ERR(rpc->dirmap))
> +		rpc->dirmap = NULL;
> +
> +	rpc->wbuf = rpc_mfd->wbuf;
> +	if (IS_ERR(rpc->wbuf))
> +		rpc->wbuf = NULL;
> +
> +	rpc->rstc = rpc_mfd->rstc;
> +	if (IS_ERR(rpc->rstc))
> +		return PTR_ERR(rpc->rstc);

   Why do we need all this copying?

> +
> +	pm_runtime_enable(&pdev->dev);
> +	ctlr->auto_runtime_pm = true;
> +
> +	ctlr->num_chipselect = 1;
> +	ctlr->mem_ops = &rpc_spi_mem_ops;
> +	ctlr->transfer_one_message = rpc_spi_transfer_one_message;
> +
> +	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
> +

   We do need pm_runtime_get_sync() here!

> +	rpc_spi_hw_init(rpc);

   And pm_runtime_put() here...

[...]
> +static const struct of_device_id rpc_spi_of_ids[] = {
> +	{ .compatible = "renesas,rcar-rpc-spi", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);

   Not needed at all...

[...]

MBR, Sergei
