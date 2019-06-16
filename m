Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840FC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867892133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqh/7GCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfFPNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:43:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36245 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:43:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so4665402lfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXWZ5UexIRmyYBBuMtlnLVrDXtCKcTUdxpXDAAOej+g=;
        b=Jqh/7GCNsbS9Rm7Op/IcbqbEAR0Hah0BL8OWuNuB7Zn5tie4O8zgUxR2hgU+cGtujY
         cy512hrMBnuXvStpN8IYc3o+880f1MYC63uz3Mtqi3C3Ptnk1iMjqKYwMN7QyXpj9yNx
         j8gu1AwmQMrgQosW+nNLOgYFPUF8jqJoIrlvoDLCjq5gAdkkCA6w+d5LvsWs+EH4ymoc
         F3hSoE4HlB1VFHVsCa/2kMwKm27kmd1y7J7Nrm7WpcdVbEdMtLM9Zie9UcldNysdyjIi
         4AZRwKDZ/d5BqJ/qhptizaTt1ilVwa1svjpBIoovZ9Nz6nIxh66UomuYzKwXB1snNabJ
         vZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXWZ5UexIRmyYBBuMtlnLVrDXtCKcTUdxpXDAAOej+g=;
        b=ltrCS+XUSkmD1H7hP5U1JeAxV9HVsVG0UK68Kt9w/Yoxoi3cqDiZLTeaQF+dVR3YZJ
         3ZWkeY7dbWlKa7CMnLPug7xOjQvnOkKkILegZy7S9EwLm7FmJx3rdDp1Jbn2dOnu9SHy
         UjWb7yhTLTzbv+BDqxIxFwYEhMWTCl43T2OZjksT0yw421iXzK0p9QmLI9QAHm90hk8g
         EafFZpgexkBTiO6dQ+0UlSDwQAQOoh8aXP3Uf+ClPXzrUqV52ROQrpkO7+usxNLmr9cF
         Vdbpp5rTWwwv+Q9/DPF7J6M0hY/CgZenTfaW1pfIeOrsH5J9B6GPDoGcTcUEJBKiQFPe
         7x1w==
X-Gm-Message-State: APjAAAU6KLRHJYA1z1iHZj266J6X0APTUNfKvg2qcW003VtQjAvvvTj8
        qdvgknz7ulthZKz/7sk56UE=
X-Google-Smtp-Source: APXvYqwIJUYGhAV4LJMP9F0yUkW3PLBdZZBvaMA/cMwvm7NvnZ0q2khKahtU1sAs6kewCVnMBDirsA==
X-Received: by 2002:a19:24d5:: with SMTP id k204mr22338825lfk.190.1560692590570;
        Sun, 16 Jun 2019 06:43:10 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id y15sm1301596lfg.43.2019.06.16.06.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 06:43:09 -0700 (PDT)
Subject: Re: [v3 1/2] mtd: nand: Add Cadence NAND controller driver
To:     Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org
References: <20190614150638.28383-1-piotrs@cadence.com>
 <20190614150956.31244-1-piotrs@cadence.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd96bd1b-e944-e95d-31c9-6dd1d0b5720f@gmail.com>
Date:   Sun, 16 Jun 2019 16:42:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614150956.31244-1-piotrs@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.06.2019 18:09, Piotr Sroka пишет:

Commit description is mandatory.

> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---

[snip]

> +
> +/* Cadnence NAND flash controller capabilities get from driver data. */
> +struct cadence_nand_dt_devdata {
> +	/* Skew value of the output signals of the NAND Flash interface. */
> +	u32 if_skew;
> +	/* It informs if aging feature in the DLL PHY supported. */
> +	u8 phy_dll_aging;
> +	/*
> +	 * It informs if per bit deskew for read and write path in
> +	 * the PHY is supported.
> +	 */
> +	u8 phy_per_bit_deskew;
> +	/* It informs if slave DMA interface is connected to DMA engine. */
> +	u8 has_dma;

There is no needed to dedicate 8 bits to a variable if you only care about a single
bit. You may write this as:

bool has_dma : 1;

[snip]

> +static struct
> +cdns_nand_chip *to_cdns_nand_chip(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct cdns_nand_chip, chip);
> +}
> +
> +static struct
> +cdns_nand_ctrl *to_cdns_nand_ctrl(struct nand_controller *controller)
> +{
> +	return container_of(controller, struct cdns_nand_ctrl, controller);
> +}

It's better to inline explicitly such cases because they won't get inlined with some
kernel configurations, like enabled ftracing for example.

> +static bool
> +cadence_nand_dma_buf_ok(struct cdns_nand_ctrl *cdns_ctrl, const void *buf,
> +			u32 buf_len)
> +{
> +	u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
> +
> +	return buf && virt_addr_valid(buf) &&
> +		likely(IS_ALIGNED((uintptr_t)buf, data_dma_width)) &&
> +		likely(IS_ALIGNED(buf_len, data_dma_width));
> +}
> +
> +static int cadence_nand_wait_for_value(struct cdns_nand_ctrl *cdns_ctrl,
> +				       u32 reg_offset, u32 timeout_us,
> +				       u32 mask, bool is_clear)
> +{
> +	u32 val;
> +	int ret = 0;
> +
> +	ret = readl_poll_timeout(cdns_ctrl->reg + reg_offset,
> +				 val, !(val & mask) == is_clear,
> +				 10, timeout_us);

Apparently you don't care about having memory barrier here, hence
readl_relaxed_poll_timeout().

> +	if (ret < 0) {
> +		dev_err(cdns_ctrl->dev,
> +			"Timeout while waiting for reg %x with mask %x is clear %d\n",
> +			reg_offset, mask, is_clear);
> +	}
> +
> +	return ret;
> +}
> +
> +static int cadence_nand_set_ecc_enable(struct cdns_nand_ctrl *cdns_ctrl,
> +				       bool enable)
> +{
> +	u32 reg;
> +
> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					1000000,
> +					CTRL_STATUS_CTRL_BUSY, true))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
> +
> +	if (enable)
> +		reg |= ECC_CONFIG_0_ECC_EN;
> +	else
> +		reg &= ~ECC_CONFIG_0_ECC_EN;
> +
> +	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);

And here.. looks like there is no need for the memory barries, hence use the relaxed
versions of readl/writel. Same for the rest of the patch.

> +	return 0;
> +}
> +
> +static void cadence_nand_set_ecc_strength(struct cdns_nand_ctrl *cdns_ctrl,
> +					  u8 corr_str_idx)
> +{
> +	u32 reg;
> +
> +	if (cdns_ctrl->curr_corr_str_idx == corr_str_idx)
> +		return;
> +
> +	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
> +	reg &= ~ECC_CONFIG_0_CORR_STR;
> +	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
> +	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
> +
> +	cdns_ctrl->curr_corr_str_idx = corr_str_idx;
> +}
> +
> +static u8 cadence_nand_get_ecc_strength_idx(struct cdns_nand_ctrl *cdns_ctrl,
> +					    u8 strength)
> +{
> +	u8 i, corr_str_idx = 0;
> +
> +	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
> +		if (cdns_ctrl->ecc_strengths[i] == strength) {
> +			corr_str_idx = i;
> +			break;
> +		}
> +	}

Is it a error case when i == BCH_MAX_NUM_CORR_CAPS?

> +	return corr_str_idx;
> +}
> +
> +static int cadence_nand_set_skip_marker_val(struct cdns_nand_ctrl *cdns_ctrl,
> +					    u16 marker_value)
> +{
> +	u32 reg = 0;
> +
> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					1000000,
> +					CTRL_STATUS_CTRL_BUSY, true))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
> +	reg &= ~SKIP_BYTES_MARKER_VALUE;
> +	reg |= FIELD_PREP(SKIP_BYTES_MARKER_VALUE,
> +		    marker_value);
> +
> +	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
> +
> +	return 0;
> +}
> +
> +static int cadence_nand_set_skip_bytes_conf(struct cdns_nand_ctrl *cdns_ctrl,
> +					    u8 num_of_bytes,
> +					    u32 offset_value,
> +					    int enable)
> +{
> +	u32 reg = 0;
> +	u32 skip_bytes_offset = 0;

Please don't initialize variables if not necessary. You could also write this in a
single line.

	u32 skip_bytes_offset, reg;

Same for the rest of the patch.

> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
> +					1000000,
> +					CTRL_STATUS_CTRL_BUSY, true))
> +		return -ETIMEDOUT;
> +
> +	if (!enable) {
> +		num_of_bytes = 0;
> +		offset_value = 0;
> +	}
> +
> +	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
> +	reg &= ~SKIP_BYTES_NUM_OF_BYTES;
> +	reg |= FIELD_PREP(SKIP_BYTES_NUM_OF_BYTES,
> +		    num_of_bytes);
> +	skip_bytes_offset = FIELD_PREP(SKIP_BYTES_OFFSET_VALUE,
> +				       offset_value);
> +
> +	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
> +	writel(skip_bytes_offset, cdns_ctrl->reg + SKIP_BYTES_OFFSET);
> +
> +	return 0;
> +}
> +
> +/* Fucntions enables/disables hardware detection of erased data */

s/Fucntions/Function/, please use spellchecker. I'd also recommend to start all
single-line comments with a lower case (and without a dot in the end) because it is a
more common style in the kernel and is a bit easier for the eyes.

[snip]
