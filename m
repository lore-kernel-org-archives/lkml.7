Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1EC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6199F20866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nlyClEWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFPNFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:05:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfFPNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:05:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5GD5MQL125473;
        Sun, 16 Jun 2019 08:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560690322;
        bh=2RA2xXNZVNHXhzN4iyBAxmX1EFLrT8461Okcvci1n6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nlyClEWa59PXLXs71NW8irUU1AdDG4XUgKl0Ya96XG9WpKeZjTFVwM4MQDLxq6kZz
         iQEDY67QI+kGjavrwrRr96LGhfCQ/agW9ap/KtWNi7NqDNoqnaGTREqiQae9KSAd/s
         mi+hg+5roShtG8LYYd8N5JrX6PLD/ctMa8+mOwII=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5GD5MRq047563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Jun 2019 08:05:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 16
 Jun 2019 08:05:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 16 Jun 2019 08:05:21 -0500
Received: from [10.250.133.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5GD5HHD072003;
        Sun, 16 Jun 2019 08:05:18 -0500
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <wesley@sifive.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com>
Date:   Sun, 16 Jun 2019 18:35:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
> have memory blocks guarded by block protection bits BP[0,1,2,3].
> 
> Clearing block protection bits,unlocks the flash memory regions
> The unlock scheme is registered during nor scans.
> 
> Based on code developed by Wesley Terpstra <wesley@sifive.com>
> and/or Palmer Dabbelt <palmer@sifive.com>.
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   |  1 +
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 2d5a925..b7c6261 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1461,6 +1461,49 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  }
>  
>  /**
> + * issi_unlock() - clear BP[0123] write-protection.
> + * @nor: pointer to a 'struct spi_nor'.
> + * @ofs: offset from which to unlock memory.
> + * @len: number of bytes to unlock.
> + *
> + * Bits [2345] of the Status Register are BP[0123].
> + * ISSI chips use a different block protection scheme than other chips.
> + * Just disable the write-protect unilaterally.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> +{
> +	int ret, val;
> +	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
> +
> +	val = read_sr(nor);
> +	if (val < 0)
> +		return val;
> +	if (!(val & mask))
> +		return 0;
> +
> +	write_enable(nor);
> +
> +	write_sr(nor, val & ~mask);
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> +
> +	ret = read_sr(nor);
> +	if (ret > 0 && !(ret & mask)) {
> +		dev_info(nor->dev,
> +			"ISSI Block Protection Bits cleared SR=0x%x", ret);
> +		ret = 0;
> +	} else {
> +		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +/**
>   * spansion_quad_enable() - set QE bit in Configuraiton Register.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
> @@ -1836,7 +1879,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			SPI_NOR_4B_OPCODES)
> +			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
>  	},
>  
>  	/* Macronix */
> @@ -4080,6 +4123,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		nor->flash_is_locked = stm_is_locked;
>  	}
>  
> +	/* NOR protection support for ISSI chips */
> +	if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
> +	    info->flags & SPI_NOR_HAS_LOCK) {

This should be:

	if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
	    info->flags & SPI_NOR_HAS_LOCK) {

Otherwise you would end up overriding nor->flash_unlock function for
other vendors too, right?

> +		nor->flash_unlock = issi_unlock;
> +

No need for blank line here.
Please run ./scripts/checkpatch.pl --strict on all patches and address
all the issues reported by it.



> +	}
>  	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
>  		mtd->_lock = spi_nor_lock;
>  		mtd->_unlock = spi_nor_unlock;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index ff13297..9a7d719 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -127,6 +127,7 @@
>  #define SR_BP0			BIT(2)	/* Block protect 0 */
>  #define SR_BP1			BIT(3)	/* Block protect 1 */
>  #define SR_BP2			BIT(4)	/* Block protect 2 */
> +#define SR_BP3			BIT(5)	/* Block protect 3 for ISSI device*/

No need to mention ISSI here. I am sure there are devices from other
vendors with BP3

>  #define SR_TB			BIT(5)	/* Top/Bottom protect */
>  #define SR_SRWD			BIT(7)	/* SR write protect */
>  /* Spansion/Cypress specific status bits */
> 

Regards
Vignesh
