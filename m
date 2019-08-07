Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90291C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E51229FA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfHGIem convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:34:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57557 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfHGIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:34:42 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1263A1BF205;
        Wed,  7 Aug 2019 08:34:37 +0000 (UTC)
Date:   Wed, 7 Aug 2019 10:34:37 +0200
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
Subject: Re: [PATCH 1/8] mtd: nand: move ONFI related functions to onfi.h
Message-ID: <20190807103437.36abb59b@xps13>
In-Reply-To: <20190722055621.23526-2-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-2-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:14 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> These functions will be used by both raw NAND and SPI NAND, which
> supports ONFI like standards.

This is not exactly what you do. Why not:

mtd: nand: export ONFI related functions to onfi.h

These functions can be used by all flavors of NAND chips (raw, SPI)
which may all follow ONFI standards. Export the related functions in
the onfi.h generic file.

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/raw/internals.h | 1 -
>  include/linux/mtd/onfi.h         | 9 +++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> index cba6fe7dd8c4..ed323087d884 100644
> --- a/drivers/mtd/nand/raw/internals.h
> +++ b/drivers/mtd/nand/raw/internals.h
> @@ -140,7 +140,6 @@ void nand_legacy_adjust_cmdfunc(struct nand_chip *chip);
>  int nand_legacy_check_hooks(struct nand_chip *chip);
>  
>  /* ONFI functions */
> -u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
>  int nand_onfi_detect(struct nand_chip *chip);
>  
>  /* JEDEC functions */
> diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
> index 339ac798568e..2c8a05a02bb0 100644
> --- a/include/linux/mtd/onfi.h
> +++ b/include/linux/mtd/onfi.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_MTD_ONFI_H
>  #define __LINUX_MTD_ONFI_H
>  
> +#include <linux/mtd/nand.h>

This should be removed, or at least not added at this moment.

>  #include <linux/types.h>
>  
>  /* ONFI version bits */
> @@ -175,4 +176,12 @@ struct onfi_params {
>  	u8 vendor[88];
>  };
>  
> +/* ONFI functions */
> +u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
> +void nand_bit_wise_majority(const void **srcbufs,
> +			    unsigned int nsrcbufs,
> +			    void *dstbuf,
> +			    unsigned int bufsize);

Don't export this function while you don't use it from elsewhere.

> +void sanitize_string(u8 *s, size_t len);

This one is used by jedec code and has no onfi-related logic, so you
may want to export it (only when you will use it) in another header
like linux/mtd/nand.h

> +
>  #endif /* __LINUX_MTD_ONFI_H */

Thanks,
Miquèl
