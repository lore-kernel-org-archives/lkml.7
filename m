Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D507C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jv7DxdnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfD3RD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:03:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43226 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3RD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:03:58 -0400
Received: by mail-io1-f68.google.com with SMTP id v9so12827382iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=etJ1WR4qO+3IuPfLuVdMXPbV+XDBvAU6tcECrR4xCrc=;
        b=jv7DxdnVudtPMbDXxMEw/GM6NMPqoYoCohNeCzcb2ZSDFyhwR53p8yt5rztmB+SlAf
         /6HkkM1OGFkTHmp6HqKcBGui9wGjTtcdnfFajTPjETmcuAIhe9NUW0xK/jTAi7NKtmHI
         lL2AftBMEwQCtNz7CwfBTolnOwMRZxouvJvbRP9iDJKEwDZbq+agZE/edhY16NycGWzf
         D0zkdHg9jEo/1wZ4p2aGffpsSAtgX6TsX+Vd0um8aKmDQ3T9FoNbSkve4NsttbhxTaq4
         o5LzkTsG3l9hA0mHJxLmZ2vDRt2nqULQ71SsYLA1yapsTMA5oOJoYFdsY9wZ06I3p7yQ
         /tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=etJ1WR4qO+3IuPfLuVdMXPbV+XDBvAU6tcECrR4xCrc=;
        b=n2cSponVud87jOBqrV364ArDEKtb/x5xgdbb1vBAXeqrLiEKB+/oCnig5KA2jcYUkk
         loU1LraleilZi+lmBdPG8pzKRuIwCCdYxEkVOJoMRtl29PN6oW9FsBTUHZutb3vNSPx8
         poUlM740iDrZ/iSvxWgvdeqSDIL+IltfKD19Wyq1h9Ha5UM5e8367NmHFkKWdd2Yriky
         DLPn8SWe+Te5yJrka03AP5S1ds/09mAUZO7B8H1wR2W9ecL7l/G/GlGgOFc1PAQjtwXp
         wHFcJxjWtXYt6Hbg4bF0O+Ksyx5+haEos8y78aomHVsU8mk3fAwgOVajUXKs0whq9xXm
         +crA==
X-Gm-Message-State: APjAAAXfaLzDDLRLkJhGoggrF6NSSKM6vyfVPQqbI/uHoJpIapb/4UX+
        Hjar8uN/lKbyUr30MNMZtcm3XQ==
X-Google-Smtp-Source: APXvYqwtQ6krzDTRPbFVrDov44ozx7k+PlhNoNgKqYFMwYfxTI/Usg4vUIfk12zixNg61hOvW70aRA==
X-Received: by 2002:a5e:9307:: with SMTP id k7mr16429275iom.155.1556643837925;
        Tue, 30 Apr 2019 10:03:57 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id 12sm526406itm.2.2019.04.30.10.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 10:03:57 -0700 (PDT)
Date:   Tue, 30 Apr 2019 10:03:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: add support for is25wp256
In-Reply-To: <1556474956-27786-2-git-send-email-sagar.kadam@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1904301002170.7063@viisi.sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com> <1556474956-27786-2-git-send-email-sagar.kadam@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019, Sagar Shrikant Kadam wrote:

> Update spi_nor_id tablet for is25wp256 (32MB)device from ISSI,
> present on HiFive Unleashed dev board (Rev: A00).
> 
> Set method to enable quad mode for ISSI device in flash parameters
> table.

This patch was based on one originally written by Wes and/or Palmer: 
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

The right thing to do is to note this in the commit message.

> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
>  include/linux/mtd/spi-nor.h   |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index fae1474..c5408ed 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1834,6 +1834,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_4B_OPCODES)
> +	},
>  
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> @@ -3650,6 +3654,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		case SNOR_MFR_MACRONIX:
>  			params->quad_enable = macronix_quad_enable;
>  			break;
> +		case SNOR_MFR_ISSI:
> +			params->quad_enable = macronix_quad_enable;
> +			break;
> +
>  
>  		case SNOR_MFR_ST:
>  		case SNOR_MFR_MICRON:
> @@ -4127,7 +4135,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	if (nor->addr_width) {
> +	if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
>  		/* already configured from SFDP */
>  	} else if (info->addr_width) {
>  		nor->addr_width = info->addr_width;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b3d360b..ff13297 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -19,6 +19,7 @@
>  #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
>  #define SNOR_MFR_GIGADEVICE	0xc8
>  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
> +#define SNOR_MFR_ISSI		0x9d		/* ISSI */
>  #define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
>  #define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
>  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> -- 
> 1.9.1
> 
> 
