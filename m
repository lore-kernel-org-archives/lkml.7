Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED26C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4A022305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfHGJDi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:03:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49741 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfHGJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:03:37 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E422B20016;
        Wed,  7 Aug 2019 09:03:32 +0000 (UTC)
Date:   Wed, 7 Aug 2019 11:03:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [PATCH 2/8] mtd: nand: move support functions for ONFI to
 nand/onfi.c
Message-ID: <20190807110332.748d2c14@xps13>
In-Reply-To: <20190722055621.23526-3-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-3-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi shiva.linuxworks@gmail.com,

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:15 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>

"mtd: nand: move ONFI specific helpers to nand/onfi.c"?

> 
> These functions are support functions for enabling ONFI standard and
> common between raw NAND and SPI NAND.

"
These are ONFI specific helpers that might be shared between raw and
SPI NAND logics, move them to a generic place.

While at it, add kernel doc on the function parameters.
"

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/Makefile        |  2 +-
>  drivers/mtd/nand/onfi.c          | 89 ++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/nand_base.c | 18 -------
>  drivers/mtd/nand/raw/nand_onfi.c | 43 ---------------
>  4 files changed, 90 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/mtd/nand/onfi.c
> 
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 7ecd80c0a66e..221945c223c3 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -nandcore-objs := core.o bbt.o
> +nandcore-objs := core.o bbt.o onfi.o
>  obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>  
>  obj-y	+= onenand/
> diff --git a/drivers/mtd/nand/onfi.c b/drivers/mtd/nand/onfi.c
> new file mode 100644
> index 000000000000..7aaf36dfc5e0
> --- /dev/null
> +++ b/drivers/mtd/nand/onfi.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt)     "nand-onfi: " fmt
> +
> +#include <linux/mtd/onfi.h>
> +#include <linux/mtd/nand.h>
> +
> +/**
> + * onfi_crc16() - Check CRC of ONFI table

There is no check in this function.

                     Derive the CRC of an ONFI table

> + * @crc: base CRC
> + * @p: buffer pointing to ONFI table
                            ^ the
> + * @len: length of ONFI table
                     ^the
> + *
> + * Return: CRC of the ONFI table
      @return: the CRC of the given ONFI table

> + */
> +u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
> +{
> +	int i;
> +
> +	while (len--) {
> +		crc ^= *p++ << 8;
> +		for (i = 0; i < 8; i++)
> +			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
> +	}
> +
> +	return crc;
> +}
> +EXPORT_SYMBOL_GPL(onfi_crc16);
> +
> +/**
> + * nand_bit_wise_majority() - Recover data with bit-wise majority
> + * @srcbufs: buffer pointing to ONFI table
> + * @nsrcbufs: length of ONFI table
                         ^the
> + * @dstbuf: valid ONFI table to be returned
> + * @bufsize: length og valid ONFI table
                       of the valid...
> + *

Extra line

> + */
> +void nand_bit_wise_majority(const void **srcbufs,
> +			    unsigned int nsrcbufs,
> +			    void *dstbuf,
> +			    unsigned int bufsize)
> +{
> +	int i, j, k;
> +
> +	for (i = 0; i < bufsize; i++) {
> +		u8 val = 0;
> +
> +		for (j = 0; j < 8; j++) {
> +			unsigned int cnt = 0;
> +
> +			for (k = 0; k < nsrcbufs; k++) {
> +				const u8 *srcbuf = srcbufs[k];
> +
> +				if (srcbuf[i] & BIT(j))
> +					cnt++; 
> +			}
> +
> +			if (cnt > nsrcbufs / 2)
> +				val |= BIT(j);
> +		}
> +
> +		((u8 *)dstbuf)[i] = val;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nand_bit_wise_majority);
> +
> +/**
> + * sanitize_string() - Sanitize ONFI strings so we can safely print them

It is used by JEDEC logic so this should be moved elsewhere and not
refer to any ONFI naming.

> + * @s: string to be sanitized
> + * @len: length of the string
> + *
> + */
> +void sanitize_string(u8 *s, size_t len)
> +{
> +	ssize_t i;
> +
> +	/* Null terminate */
> +	s[len - 1] = 0;
> +
> +	/* Remove non printable chars */
> +	for (i = 0; i < len - 1; i++) {
> +		if (s[i] < ' ' || s[i] > 127)
> +			s[i] = '?';
> +	}
> +
> +	/* Remove trailing spaces */
> +	strim(s);
> +}
> +EXPORT_SYMBOL_GPL(sanitize_string);
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 6ecd1c496ce3..c198829bcd79 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4375,24 +4375,6 @@ static void nand_set_defaults(struct nand_chip *chip)
>  		chip->buf_align = 1;
>  }
>  
> -/* Sanitize ONFI strings so we can safely print them */
> -void sanitize_string(uint8_t *s, size_t len)
> -{
> -	ssize_t i;
> -
> -	/* Null terminate */
> -	s[len - 1] = 0;
> -
> -	/* Remove non printable chars */
> -	for (i = 0; i < len - 1; i++) {
> -		if (s[i] < ' ' || s[i] > 127)
> -			s[i] = '?';
> -	}
> -
> -	/* Remove trailing spaces */
> -	strim(s);
> -}
> -
>  /*
>   * nand_id_has_period - Check if an ID string has a given wraparound period
>   * @id_data: the ID string
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
> index 0b879bd0a68c..2e8edfa636ef 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -16,18 +16,6 @@
>  
>  #include "internals.h"
>  
> -u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
> -{
> -	int i;
> -	while (len--) {
> -		crc ^= *p++ << 8;
> -		for (i = 0; i < 8; i++)
> -			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
> -	}
> -
> -	return crc;
> -}
> -
>  /* Parse the Extended Parameter Page. */
>  static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
>  					    struct nand_onfi_params *p)
> @@ -103,37 +91,6 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
>  	return ret;
>  }
>  
> -/*
> - * Recover data with bit-wise majority
> - */
> -static void nand_bit_wise_majority(const void **srcbufs,
> -				   unsigned int nsrcbufs,
> -				   void *dstbuf,
> -				   unsigned int bufsize)
> -{
> -	int i, j, k;
> -
> -	for (i = 0; i < bufsize; i++) {
> -		u8 val = 0;
> -
> -		for (j = 0; j < 8; j++) {
> -			unsigned int cnt = 0;
> -
> -			for (k = 0; k < nsrcbufs; k++) {
> -				const u8 *srcbuf = srcbufs[k];
> -
> -				if (srcbuf[i] & BIT(j))
> -					cnt++;
> -			}
> -
> -			if (cnt > nsrcbufs / 2)
> -				val |= BIT(j);
> -		}
> -
> -		((u8 *)dstbuf)[i] = val;
> -	}
> -}
> -
>  /*
>   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
>   */

Thanks,
Miquèl
