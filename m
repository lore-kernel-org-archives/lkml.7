Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9678FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D5D20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgAISIl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:08:41 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47307 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAISIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:08:41 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1D997C000B;
        Thu,  9 Jan 2020 18:08:39 +0000 (UTC)
Date:   Thu, 9 Jan 2020 19:08:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: spi: rework detect procedure for different
 read id op
Message-ID: <20200109190838.7028c8d9@xps13>
In-Reply-To: <20200109075551.357179-1-gch981213@gmail.com>
References: <20200109075551.357179-1-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

Chuanhong Guo <gch981213@gmail.com> wrote on Thu,  9 Jan 2020 15:54:00
+0800:

> Currently there are 3 different variants of read_id implementation:
> 1. opcode only. Found in GD5FxGQ4xF.
> 2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
> 3. opcode + 1 dummy byte. Found in other currently supported chips.
> 
> Original implementation was for variant 1 and let detect function
> of chips with variant 2 and 3 to ignore the first byte. This isn't
> robust:
> 
> 1. For chips of variant 2, if SPI master doesn't keep MOSI low
> during read, chip will get a random id offset, and the entire id
> buffer will shift by that offset, causing detect failure.
> 
> 2. For chips of variant 1, if it happens to get a devid that equals
> to manufacture id of variant 2 or 3 chips, it'll get incorrectly
> detected.
> 
> This patch reworks detect procedure to address problems above. New
> logic do detection for all variants separatedly, in 1-2-3 order.
> Since all current detect methods do exactly the same id matching
> procedure, unify them into core.c and remove detect method from
> manufacture_ops.
> 
> Tested on GD5F1GQ4UAYIG and W25N01GVZEIG.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  drivers/mtd/nand/spi/core.c       | 89 +++++++++++++++++++++++--------
>  drivers/mtd/nand/spi/gigadevice.c | 46 ++++++----------
>  drivers/mtd/nand/spi/macronix.c   | 25 ++-------
>  drivers/mtd/nand/spi/micron.c     | 24 ++-------
>  drivers/mtd/nand/spi/paragon.c    | 23 ++------
>  drivers/mtd/nand/spi/toshiba.c    | 25 ++-------
>  drivers/mtd/nand/spi/winbond.c    | 29 ++--------
>  include/linux/mtd/spinand.h       | 24 ++++-----
>  8 files changed, 110 insertions(+), 175 deletions(-)

Nice diffstat, and nice implementation IMHO.

I'm fine with the patch but I would love to hear Boris' voice on this.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

One minor nit below.


> @@ -215,15 +204,22 @@ struct spinand_manufacturer_ops {
>   * struct spinand_manufacturer - SPI NAND manufacturer instance
>   * @id: manufacturer ID
>   * @name: manufacturer name
> + * @devid_len: number of bytes in device ID
> + * @spinand_table: array with info for spi nands under current manufacturer

This description is not very clear to me.
And also s/spi nands/SPI-NANDs/

> + * @nchips: number of chips available in spinand_table
>   * @ops: manufacturer operations
>   */
>  struct spinand_manufacturer {
>  	u8 id;
>  	char *name;
> +	u8 devid_len;
> +	const struct spinand_info *spinand_table;
> +	size_t nchips;
>  	const struct spinand_manufacturer_ops *ops;
>  };
>  
>  /* SPI NAND manufacturers */
> +extern const struct spinand_manufacturer gigadevice_spinand_manufacturer_1a_id;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;

Thanks,
Miquèl
