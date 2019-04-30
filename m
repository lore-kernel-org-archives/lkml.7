Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F69C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E3720651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eo8mbG6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfD3RTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:19:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38160 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3RTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:19:13 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so5988327itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FiLJnoBGMZ9oBi3dnF5JorKlP2R1B74woYmCiWU3q4E=;
        b=eo8mbG6Zp1FjFJ0ysrn85VPXjbAGAkyFP1/8x3Tfyv07vBVd3xQMhqQhkSo/4dHdtf
         IrzOuPgDagw3ot0zYzQwuk2RaosxuSxg48PlJaiM0Xb/0bjQ7esnFaokU9deuYPAcuDv
         MwIAn1YR7T7wQ1DJvLVNGNWLjRbroxu/rmzSI0h7Wql1u2D2rXf+HQhG9zZZH/4JH3Qi
         y5jBvYI4NI5rSOmlzCSYUkwxCIck9lW4CxA31M0oH5ox3yjS/pvMXZGc2CUJ16trf6vs
         8+ejFS6yxbXoGzPlILgTGgEXvNESG9DY8+8ufs3ZkD9mEm5LBpWR1q2QXdf+GhpwxYFU
         uvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FiLJnoBGMZ9oBi3dnF5JorKlP2R1B74woYmCiWU3q4E=;
        b=IemiRCgMMdUyQtE2Gr0kGhzTu+f2wcvpIfk4wT7X4WTosWUw6yy8NzjTXS3cMAFLuj
         M1dViqhd5bHtOegcf94BnHRgwlLbAUImUp71+Dz0uqn54Nfy6fDmwHl4jXhh3SXr6agD
         +9JeDNVlUPzTrN1I+AVo+IjrkIHVEh2v0Vt/McbdnR3b5mdY54gYe/7TZLB6ieej5qgr
         ol/gNwj5B2jjyeH2xsZykHFAX/TAhe7RNMKUJShpy/Pu2z8wNvEwO1hBHE7qPKsEi23A
         j2m3V8M8USadvZTXX8EWgh/6N00fgPXRv9S/l36ZFEOnuG2ezb6H8LMGjsctv2FGNZdR
         alEQ==
X-Gm-Message-State: APjAAAWY9DYlJXuKFfkJL+nLYemCSieEUAXdcMzrH9qsHOH9ij8q6rRr
        anj0baSrxsvgco6B8Py2lf6VjA==
X-Google-Smtp-Source: APXvYqzrp/nKimnoq8jslzC4Mbr5Q2qCr/jPkQ8YAvMQ/Fpquys4+OccO/DxegQ1qHLcD4SMXFGNEA==
X-Received: by 2002:a24:7608:: with SMTP id z8mr4377301itb.116.1556644752532;
        Tue, 30 Apr 2019 10:19:12 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t196sm1949364ita.4.2019.04.30.10.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 10:19:11 -0700 (PDT)
Date:   Tue, 30 Apr 2019 10:19:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add support to unlock flash
 device.
In-Reply-To: <1556474956-27786-3-git-send-email-sagar.kadam@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1904301016400.7063@viisi.sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com> <1556474956-27786-3-git-send-email-sagar.kadam@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019, Sagar Shrikant Kadam wrote:

> Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
> have memory blocks guarded by block protection bits BP[0,1,2,3].
> 
> Clearing block protection bits,unlocks the flash memory regions
> The unlock scheme is registered during nor scans.

This also looks like it's partially based on Wes or Palmer's patch from 

https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Please note that in the patch message.

> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   |  1 +
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c5408ed..81c7b3e 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1461,6 +1461,46 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  }
>  
>  /**
> + * issi_unlock() - clear BP[0123] write-protection.
> + * @nor: pointer to a 'struct spi_nor'
> + * @ofs: offset from which to unlock memory
> + * @len: number of bytes to unlock
> + * Bits [2345] of the Status Register are BP[0123].
> + * ISSI chips use a different block protection scheme than other chips.
> + * Just disable the write-protect unilaterally.
> + * Return: 0 on success, -errno otherwise.

This is closer to kernel-doc format, but not quite.  Please update this to 
align to

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst#n57


- Paul

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
> +		return 0;
> +	} else {
> +		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
>   * spansion_quad_enable() - set QE bit in Configuraiton Register.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
> @@ -1836,7 +1876,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			SPI_NOR_4B_OPCODES)
> +			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
>  	},
>  
>  	/* Macronix */
> @@ -4078,6 +4118,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		nor->flash_is_locked = stm_is_locked;
>  	}
>  
> +	/* NOR protection support for ISSI chips */
> +	if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
> +	    info->flags & SPI_NOR_HAS_LOCK) {
> +		nor->flash_unlock = issi_unlock;
> +
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
>  #define SR_TB			BIT(5)	/* Top/Bottom protect */
>  #define SR_SRWD			BIT(7)	/* SR write protect */
>  /* Spansion/Cypress specific status bits */
> -- 
> 1.9.1
> 
> 
