Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D06C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56BF218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I+V78RVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406101AbfHIL1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:27:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:27:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79BR8Ww066638;
        Fri, 9 Aug 2019 06:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565350028;
        bh=Ppi3TU5ZQgR8D+tREXONR6IGdx55ybqquqWRoMb0in8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I+V78RVowMEWKyKlao3EaFh/8b0N3c9FSUSInWuzQaZXBcEqks1GBOnom6rD47Kw6
         0qsN83gMomykiMPWWhUlelwnF4dhLvzAODQ9tYn/l0EwFi969uja9458x4vJzy/SjC
         cxCQ6Jqyx/8BCCEoGAIp68IwezEE1oRsmdltLeP4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79BR8gR036947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 06:27:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 06:27:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 06:27:07 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79BR3xf051395;
        Fri, 9 Aug 2019 06:27:04 -0500
Subject: Re: [PATCH v7 4/4] mtd: spi-nor: add locking support for is25wp256
 device
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <1562092745-11541-5-git-send-email-sagar.kadam@sifive.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f3a1617e-0478-63ea-ab76-feaab7ac1e9b@ti.com>
Date:   Fri, 9 Aug 2019 16:57:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562092745-11541-5-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagar,

On 03/07/19 12:09 AM, Sagar Shrikant Kadam wrote:
[...]> +static int issi_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> +{
> +	int status_old, status_new, blk_prot;
> +	u8 mask;
> +	u8 shift;
> +	u8 pow, ret, func_reg;
> +	bool use_top;
> +	loff_t lock_len;
> +
> +	if (nor->flags & SNOR_F_HAS_BP3)
> +		mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
> +	else
> +		mask = SR_BP2 | SR_BP1 | SR_BP0;
> +
> +	shift = ffs(mask) - 1;
> +
> +	status_old = read_sr(nor);
> +
> +	/* if status reg is Write protected don't update bit protection */
> +	if (status_old & SR_SRWD) {
> +		dev_err(nor->dev,
> +			"SR is write protected, can't update BP bits...\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
> +	if (!ret)
> +		/* Older protected blocks include the new requested block's */
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +
> +	func_reg = spi_nor_read_fr(nor);

Sorry, I don't understand where func_reg is used? Since TBS OTP, how
does issi_lock() code comprehend that TBS bit value in OTP register and
use_top returned by spi_nor_select_zone() are matching before we go
ahead and program status register.

We should reject locking request if top-bottom calculation does not
match OTP bit. Where is that done?

Regards
Vignesh

> +	/* lock_len: length of region that should end up locked */
> +	if (use_top)
> +		lock_len = nor->mtd.size - ofs;
> +	else
> +		lock_len = ofs + len;
> +
> +	pow = order_base_2(lock_len);
> +	blk_prot = mask & (((pow + 1) & 0xf) << shift);
> +	if (lock_len <= 0) {
> +		dev_err(nor->dev, "invalid Length to protect");
> +		return -EINVAL;
> +	}
> +
> +	status_new = status_old | blk_prot;
> +	if (status_old == status_new)
> +		return 0;
> +
> +	return write_sr_and_check(nor, status_new, mask);
> +}
> +
> +/**
>   * issi_unlock() - clear BP[0123] write-protection.
>   * @nor: pointer to a 'struct spi_nor'.
>   * @ofs: offset from which to unlock memory.
> @@ -4171,6 +4338,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
>  	    info->flags & SPI_NOR_HAS_LOCK &&
>  	    info->flags & SPI_NOR_HAS_BP3) {
> +		nor->flash_lock = issi_lock;
>  		nor->flash_unlock = issi_unlock;
>  	}
>  
> @@ -4194,6 +4362,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
>  	if (info->flags & USE_CLSR)
>  		nor->flags |= SNOR_F_USE_CLSR;
> +	if (info->flags & SPI_NOR_HAS_BP3)
> +		nor->flags |= SNOR_F_HAS_BP3;
>  
>  	if (info->flags & SPI_NOR_NO_ERASE)
>  		mtd->flags |= MTD_NO_ERASE;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index f6fa70f..26dbf48 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -40,6 +40,8 @@
>  #define SPINOR_OP_RDSR		0x05	/* Read status register */
>  #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
>  #define SPINOR_OP_RDSR2		0x3f	/* Read status register 2 */
> +#define SPINOR_OP_RDFR		0x48	/* Read Function register */
> +#define SPINOR_OP_WRFR		0x42	/* Write Function register 1 byte */
>  #define SPINOR_OP_WRSR2		0x3e	/* Write status register 2 */
>  #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
>  #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
> @@ -139,6 +141,9 @@
>  /* Enhanced Volatile Configuration Register bits */
>  #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
>  
> +/*Function register bit */
> +#define FR_TB			BIT(1)	/*ISSI: Top/Bottom protect */
> +
>  /* Flag Status Register bits */
>  #define FSR_READY		BIT(7)	/* Device status, 0 = Busy, 1 = Ready */
>  #define FSR_E_ERR		BIT(5)	/* Erase operation status */
> 

-- 
Regards
Vignesh
