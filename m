Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E45C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7DC2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fieDVVl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406633AbfHILrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:47:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHILrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:47:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79BkoIm030966;
        Fri, 9 Aug 2019 06:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565351210;
        bh=GpTvkwHyDxghgF8eAkYNAsKhLVqI6G7KQjlC91O3V6M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fieDVVl6acX6O2gIgj5Ba3Ht9GuJ5qtoS4nDiD6Rn0br5Rz2s2Cy4oDqB9XSYA1Tw
         PzvoLwW3xOZCaW3oKCxWovlLQYcgnj6tMjJ9hL8cKLlPPlUU/yDYGRSOTuccS31v+j
         eM1DDcS0gsoMtiarX46+UZHqulEeaMOkkYdd8HBs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79Bkocd087325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 06:46:50 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 06:46:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 06:46:50 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79Bkl62094730;
        Fri, 9 Aug 2019 06:46:48 -0500
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
To:     Tomer Maimon <tmaimon77@gmail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20190806051041.3636-1-vigneshr@ti.com>
 <20190806051041.3636-3-vigneshr@ti.com>
 <CAP6Zq1h9Xe9ptGxQpjYwoFaS1sTyd-3EsMTAYwp9e70Cm1czLg@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <e76881ad-5e84-bf75-52ed-5bd5ff133af2@ti.com>
Date:   Fri, 9 Aug 2019 17:17:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1h9Xe9ptGxQpjYwoFaS1sTyd-3EsMTAYwp9e70Cm1czLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On 08/08/19 3:35 PM, Tomer Maimon wrote:
> 
> Hi Vignesh,
> 
> Thanks for working on the spi-nor patches.
> 
> I have tested your latest patches with NPCM FIU driver on two different
> Flashes:
> 
> 1.  Winbond w25q256 - 32MB
> 2.  Macronix mx25l3205d- 4MB
> 
> Sorry I going to a vacation soon (on tight schedule) so I haven't had a
> time to do full stress test on the spi-nor driver (only erase,write, read).
> 

Thanks for testing!

> There is an issue with erase sector function, the address should send as
> a data. (see the modification below).
> 

As Boris pointed out, Erase sequence does not have data phase, spi-mem
controller driver should handle SPI_MEM_NO_DATA flag accordingly.
I guess you have fixed this in v2 of NPCM FIU controller driver support
series​ and this is no longer an issue right?

> Are you intend to add a direct spi-mem support to the spi-nor driver?

May not be for this merge window, moreover I don't have a spi-mem driver
to exercise this dirmap APIs (I am in the process of converting one).
But, feel free to submit a patch if you have one.

Please keep in mind the of changes done by Tudor here:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=122420
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=122423
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=122424

There may be potential conflicts and rebasing needed.

Regards
Vignesh

> 
> On Tue, 6 Aug 2019 at 08:10, Vignesh Raghavendra <vigneshr@ti.com
> <mailto:vigneshr@ti.com>> wrote:
> 
>     From: Boris Brezillon <boris.brezillon@bootlin.com
>     <mailto:boris.brezillon@bootlin.com>>
> 
>     The m25p80 driver is actually a generic wrapper around the spi-mem
>     layer. Not only the driver name is misleading, but we'd expect such a
>     common logic to be directly available in the core. Another reason for
>     moving this code is that SPI NOR controller drivers should
>     progressively be replaced by SPI controller drivers implementing the
>     spi_mem_ops interface, and when the conversion is done, we should have
>     a single spi-nor driver directly interfacing with the spi-mem layer.
> 
>     While moving the code we also fix a longstanding issue when
>     non-DMA-able buffers are passed by the MTD layer.
> 
>     Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com
>     <mailto:boris.brezillon@bootlin.com>>
>     Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com
>     <mailto:vigneshr@ti.com>>
>     ---
>     v5:
>     Fix comments by Tudor in spi_nor_spimem_read_data() and
>     spi_nor_read_sr2()
> 
>     v4:
>     Fix a bug in write_sr()
>     Update comments around allocation of bounce buffer
> 
>     v3:
>     Simplify register read/write by dropping spi_nor_exec_op() and using
>     spi_mem_exec_op() directly
>     Modify spi_nor_spimem_xfer_data() to drop "enum spi_nor_protocol proto"
>     Fix misc coding style comments by Tudor
> 
>     v2:
>     Add docs for new functions added
>     Add spi_nor_ prefix to new functions
>     Incorporate Andrey's patches https://lkml.org/lkml/2019/4/1/32
>     to avoid looping spi_nor_spimem_* APIs
> 
>      drivers/mtd/devices/Kconfig   |  18 -
>      drivers/mtd/devices/Makefile  |   1 -
>      drivers/mtd/devices/m25p80.c  | 347 -------------------
>      drivers/mtd/spi-nor/Kconfig   |   2 +
>      drivers/mtd/spi-nor/spi-nor.c | 628 ++++++++++++++++++++++++++++++++--
>      include/linux/mtd/spi-nor.h   |   3 +
>      6 files changed, 605 insertions(+), 394 deletions(-)
>      delete mode 100644 drivers/mtd/devices/m25p80.c
> 
>     diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
>     index 49abbc52457d..f96287c4b789 100644
>     --- a/drivers/mtd/devices/Kconfig
>     +++ b/drivers/mtd/devices/Kconfig
>     @@ -79,24 +79,6 @@ config MTD_DATAFLASH_OTP
>               other key product data.  The second half is programmed with a
>               unique-to-each-chip bit pattern at the factory.
> 
>     -config MTD_M25P80
>     -       tristate "Support most SPI Flash chips (AT26DF, M25P, W25X,
>     ...)"
>     -       depends on SPI_MASTER && MTD_SPI_NOR
>     -       select SPI_MEM
>     -       help
>     -         This enables access to most modern SPI flash chips, used for
>     -         program and data storage.   Series supported include Atmel
>     AT26DF,
>     -         Spansion S25SL, SST 25VF, ST M25P, and Winbond W25X. 
>     Other chips
>     -         are supported as well.  See the driver source for the
>     current list,
>     -         or to add other chips.
>     -
>     -         Note that the original DataFlash chips (AT45 series, not
>     AT26DF),
>     -         need an entirely different driver.
>     -
>     -         Set up your spi devices with the right board-specific
>     platform data,
>     -         if you want to specify device partitioning or to use a
>     device which
>     -         doesn't support the JEDEC ID instruction.
>     -
>      config MTD_MCHP23K256
>             tristate "Microchip 23K256 SRAM"
>             depends on SPI_MASTER
>     diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
>     index 94895eab3066..991c8d12c016 100644
>     --- a/drivers/mtd/devices/Makefile
>     +++ b/drivers/mtd/devices/Makefile
>     @@ -12,7 +12,6 @@ obj-$(CONFIG_MTD_MTDRAM)      += mtdram.o
>      obj-$(CONFIG_MTD_LART)         += lart.o
>      obj-$(CONFIG_MTD_BLOCK2MTD)    += block2mtd.o
>      obj-$(CONFIG_MTD_DATAFLASH)    += mtd_dataflash.o
>     -obj-$(CONFIG_MTD_M25P80)       += m25p80.o
>      obj-$(CONFIG_MTD_MCHP23K256)   += mchp23k256.o
>      obj-$(CONFIG_MTD_SPEAR_SMI)    += spear_smi.o
>      obj-$(CONFIG_MTD_SST25L)       += sst25l.o
>     diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>     deleted file mode 100644
>     index c50888670250..000000000000
>     --- a/drivers/mtd/devices/m25p80.c
>     +++ /dev/null
>     @@ -1,347 +0,0 @@
>     -// SPDX-License-Identifier: GPL-2.0-only
>     -/*
>     - * MTD SPI driver for ST M25Pxx (and similar) serial flash chips
>     - *
>     - * Author: Mike Lavender, mike@steroidmicros.com
>     <mailto:mike@steroidmicros.com>
>     - *
>     - * Copyright (c) 2005, Intec Automation Inc.
>     - *
>     - * Some parts are based on lart.c by Abraham Van Der Merwe
>     - *
>     - * Cleaned up and generalized based on mtd_dataflash.c
>     - */
>     -
>     -#include <linux/err.h>
>     -#include <linux/errno.h>
>     -#include <linux/module.h>
>     -#include <linux/device.h>
>     -
>     -#include <linux/mtd/mtd.h>
>     -#include <linux/mtd/partitions.h>
>     -
>     -#include <linux/spi/spi.h>
>     -#include <linux/spi/spi-mem.h>
>     -#include <linux/spi/flash.h>
>     -#include <linux/mtd/spi-nor.h>
>     -
>     -struct m25p {
>     -       struct spi_mem          *spimem;
>     -       struct spi_nor          spi_nor;
>     -};
>     -
>     -static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val,
>     int len)
>     -{
>     -       struct m25p *flash = nor->priv;
>     -       struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
>     -                                         SPI_MEM_OP_NO_ADDR,
>     -                                         SPI_MEM_OP_NO_DUMMY,
>     -                                         SPI_MEM_OP_DATA_IN(len,
>     NULL, 1));
>     -       void *scratchbuf;
>     -       int ret;
>     -
>     -       scratchbuf = kmalloc(len, GFP_KERNEL);
>     -       if (!scratchbuf)
>     -               return -ENOMEM;
>     -
>     -       op.data.buf.in <http://op.data.buf.in> = scratchbuf;
>     -       ret = spi_mem_exec_op(flash->spimem, &op);
>     -       if (ret < 0)
>     -               dev_err(&flash->spimem->spi->dev, "error %d reading
>     %x\n", ret,
>     -                       code);
>     -       else
>     -               memcpy(val, scratchbuf, len);
>     -
>     -       kfree(scratchbuf);
>     -
>     -       return ret;
>     -}
>     -
>     -static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8
>     *buf, int len)
>     -{
>     -       struct m25p *flash = nor->priv;
>     -       struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
>     -                                         SPI_MEM_OP_NO_ADDR,
>     -                                         SPI_MEM_OP_NO_DUMMY,
>     -                                         SPI_MEM_OP_DATA_OUT(len,
>     NULL, 1));
>     -       void *scratchbuf;
>     -       int ret;
>     -
>     -       scratchbuf = kmemdup(buf, len, GFP_KERNEL);
>     -       if (!scratchbuf)
>     -               return -ENOMEM;
>     -
>     -       op.data.buf.out = scratchbuf;
>     -       ret = spi_mem_exec_op(flash->spimem, &op);
>     -       kfree(scratchbuf);
>     -
>     -       return ret;
>     -}
>     -
>     -static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
>     -                           const u_char *buf)
>     -{
>     -       struct m25p *flash = nor->priv;
>     -       struct spi_mem_op op =
>     -                     
>      SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
>     -                                  SPI_MEM_OP_ADDR(nor->addr_width,
>     to, 1),
>     -                                  SPI_MEM_OP_NO_DUMMY,
>     -                                  SPI_MEM_OP_DATA_OUT(len, buf, 1));
>     -       int ret;
>     -
>     -       /* get transfer protocols. */
>     -       op.cmd.buswidth =
>     spi_nor_get_protocol_inst_nbits(nor->write_proto);
>     -       op.addr.buswidth =
>     spi_nor_get_protocol_addr_nbits(nor->write_proto);
>     -       op.data.buswidth =
>     spi_nor_get_protocol_data_nbits(nor->write_proto);
>     -
>     -       if (nor->program_opcode == SPINOR_OP_AAI_WP &&
>     nor->sst_write_second)
>     -               op.addr.nbytes = 0;
>     -
>     -       ret = spi_mem_adjust_op_size(flash->spimem, &op);
>     -       if (ret)
>     -               return ret;
>     -       op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
>     -
>     -       ret = spi_mem_exec_op(flash->spimem, &op);
>     -       if (ret)
>     -               return ret;
>     -
>     -       return op.data.nbytes;
>     -}
>     -
>     -/*
>     - * Read an address range from the nor chip.  The address range
>     - * may be any size provided it is within the physical boundaries.
>     - */
>     -static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t
>     len,
>     -                          u_char *buf)
>     -{
>     -       struct m25p *flash = nor->priv;
>     -       struct spi_mem_op op =
>     -                       SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
>     -                                  SPI_MEM_OP_ADDR(nor->addr_width,
>     from, 1),
>     -                                  SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
>     -                                  SPI_MEM_OP_DATA_IN(len, buf, 1));
>     -       size_t remaining = len;
>     -       int ret;
>     -
>     -       /* get transfer protocols. */
>     -       op.cmd.buswidth =
>     spi_nor_get_protocol_inst_nbits(nor->read_proto);
>     -       op.addr.buswidth =
>     spi_nor_get_protocol_addr_nbits(nor->read_proto);
>     -       op.dummy.buswidth = op.addr.buswidth;
>     -       op.data.buswidth =
>     spi_nor_get_protocol_data_nbits(nor->read_proto);
>     -
>     -       /* convert the dummy cycles to the number of bytes */
>     -       op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>     -
>     -       while (remaining) {
>     -               op.data.nbytes = remaining < UINT_MAX ? remaining :
>     UINT_MAX;
>     -               ret = spi_mem_adjust_op_size(flash->spimem, &op);
>     -               if (ret)
>     -                       return ret;
>     -
>     -               ret = spi_mem_exec_op(flash->spimem, &op);
>     -               if (ret)
>     -                       return ret;
>     -
>     -               op.addr.val += op.data.nbytes;
>     -               remaining -= op.data.nbytes;
>     -               op.data.buf.in <http://op.data.buf.in> +=
>     op.data.nbytes;
>     -       }
>     -
>     -       return len;
>     -}
>     -
>     -/*
>     - * board specific setup should have ensured the SPI clock used here
>     - * matches what the READ command supports, at least until this driver
>     - * understands FAST_READ (for clocks over 25 MHz).
>     - */
>     -static int m25p_probe(struct spi_mem *spimem)
>     -{
>     -       struct spi_device *spi = spimem->spi;
>     -       struct flash_platform_data      *data;
>     -       struct m25p *flash;
>     -       struct spi_nor *nor;
>     -       struct spi_nor_hwcaps hwcaps = {
>     -               .mask = SNOR_HWCAPS_READ |
>     -                       SNOR_HWCAPS_READ_FAST |
>     -                       SNOR_HWCAPS_PP,
>     -       };
>     -       char *flash_name;
>     -       int ret;
>     -
>     -       data = dev_get_platdata(&spimem->spi->dev);
>     -
>     -       flash = devm_kzalloc(&spimem->spi->dev, sizeof(*flash),
>     GFP_KERNEL);
>     -       if (!flash)
>     -               return -ENOMEM;
>     -
>     -       nor = &flash->spi_nor;
>     -
>     -       /* install the hooks */
>     -       nor->read = m25p80_read;
>     -       nor->write = m25p80_write;
>     -       nor->write_reg = m25p80_write_reg;
>     -       nor->read_reg = m25p80_read_reg;
>     -
>     -       nor->dev = &spimem->spi->dev;
>     -       spi_nor_set_flash_node(nor, spi->dev.of_node);
>     -       nor->priv = flash;
>     -
>     -       spi_mem_set_drvdata(spimem, flash);
>     -       flash->spimem = spimem;
>     -
>     -       if (spi->mode & SPI_RX_OCTAL) {
>     -               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
>     -
>     -               if (spi->mode & SPI_TX_OCTAL)
>     -                       hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
>     -                                       SNOR_HWCAPS_PP_1_1_8 |
>     -                                       SNOR_HWCAPS_PP_1_8_8);
>     -       } else if (spi->mode & SPI_RX_QUAD) {
>     -               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
>     -
>     -               if (spi->mode & SPI_TX_QUAD)
>     -                       hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
>     -                                       SNOR_HWCAPS_PP_1_1_4 |
>     -                                       SNOR_HWCAPS_PP_1_4_4);
>     -       } else if (spi->mode & SPI_RX_DUAL) {
>     -               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
>     -
>     -               if (spi->mode & SPI_TX_DUAL)
>     -                       hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>     -       }
>     -
>     -       if (data && data->name)
>     -               nor->mtd.name <http://mtd.name> = data->name;
>     -
>     -       if (!nor->mtd.name <http://mtd.name>)
>     -               nor->mtd.name <http://mtd.name> =
>     spi_mem_get_name(spimem);
>     -
>     -       /* For some (historical?) reason many platforms provide two
>     different
>     -        * names in flash_platform_data: "name" and "type". Quite
>     often name is
>     -        * set to "m25p80" and then "type" provides a real chip name.
>     -        * If that's the case, respect "type" and ignore a "name".
>     -        */
>     -       if (data && data->type)
>     -               flash_name = data->type;
>     -       else if (!strcmp(spi->modalias, "spi-nor"))
>     -               flash_name = NULL; /* auto-detect */
>     -       else
>     -               flash_name = spi->modalias;
>     -
>     -       ret = spi_nor_scan(nor, flash_name, &hwcaps);
>     -       if (ret)
>     -               return ret;
>     -
>     -       return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>     -                                  data ? data->nr_parts : 0);
>     -}
>     -
>     -
>     -static int m25p_remove(struct spi_mem *spimem)
>     -{
>     -       struct m25p     *flash = spi_mem_get_drvdata(spimem);
>     -
>     -       spi_nor_restore(&flash->spi_nor);
>     -
>     -       /* Clean up MTD stuff. */
>     -       return mtd_device_unregister(&flash->spi_nor.mtd);
>     -}
>     -
>     -static void m25p_shutdown(struct spi_mem *spimem)
>     -{
>     -       struct m25p *flash = spi_mem_get_drvdata(spimem);
>     -
>     -       spi_nor_restore(&flash->spi_nor);
>     -}
>     -/*
>     - * Do NOT add to this array without reading the following:
>     - *
>     - * Historically, many flash devices are bound to this driver by
>     their name. But
>     - * since most of these flash are compatible to some extent, and their
>     - * differences can often be differentiated by the JEDEC read-ID
>     command, we
>     - * encourage new users to add support to the spi-nor library, and
>     simply bind
>     - * against a generic string here (e.g., "jedec,spi-nor").
>     - *
>     - * Many flash names are kept here in this list (as well as in
>     spi-nor.c) to
>     - * keep them available as module aliases for existing platforms.
>     - */
>     -static const struct spi_device_id m25p_ids[] = {
>     -       /*
>     -        * Allow non-DT platform devices to bind to the "spi-nor"
>     modalias, and
>     -        * hack around the fact that the SPI core does not provide
>     uevent
>     -        * matching for .of_match_table
>     -        */
>     -       {"spi-nor"},
>     -
>     -       /*
>     -        * Entries not used in DTs that should be safe to drop after
>     replacing
>     -        * them with "spi-nor" in platform data.
>     -        */
>     -       {"s25sl064a"},  {"w25x16"},     {"m25p10"},     {"m25px64"},
>     -
>     -       /*
>     -        * Entries that were used in DTs without "jedec,spi-nor"
>     fallback and
>     -        * should be kept for backward compatibility.
>     -        */
>     -       {"at25df321a"}, {"at25df641"},  {"at26df081a"},
>     -       {"mx25l4005a"}, {"mx25l1606e"}, {"mx25l6405d"}, {"mx25l12805d"},
>     -       {"mx25l25635e"},{"mx66l51235l"},
>     -       {"n25q064"},    {"n25q128a11"}, {"n25q128a13"}, {"n25q512a"},
>     -       {"s25fl256s1"}, {"s25fl512s"},  {"s25sl12801"}, {"s25fl008k"},
>     -       {"s25fl064k"},
>     -       {"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
>     -       {"m25p40"},     {"m25p80"},     {"m25p16"},     {"m25p32"},
>     -       {"m25p64"},     {"m25p128"},
>     -       {"w25x80"},     {"w25x32"},     {"w25q32"},     {"w25q32dw"},
>     -       {"w25q80bl"},   {"w25q128"},    {"w25q256"},
>     -
>     -       /* Flashes that can't be detected using JEDEC */
>     -       {"m25p05-nonjedec"},    {"m25p10-nonjedec"},   
>     {"m25p20-nonjedec"},
>     -       {"m25p40-nonjedec"},    {"m25p80-nonjedec"},   
>     {"m25p16-nonjedec"},
>     -       {"m25p32-nonjedec"},    {"m25p64-nonjedec"},   
>     {"m25p128-nonjedec"},
>     -
>     -       /* Everspin MRAMs (non-JEDEC) */
>     -       { "mr25h128" }, /* 128 Kib, 40 MHz */
>     -       { "mr25h256" }, /* 256 Kib, 40 MHz */
>     -       { "mr25h10" },  /*   1 Mib, 40 MHz */
>     -       { "mr25h40" },  /*   4 Mib, 40 MHz */
>     -
>     -       { },
>     -};
>     -MODULE_DEVICE_TABLE(spi, m25p_ids);
>     -
>     -static const struct of_device_id m25p_of_table[] = {
>     -       /*
>     -        * Generic compatibility for SPI NOR that can be identified
>     by the
>     -        * JEDEC READ ID opcode (0x9F). Use this, if possible.
>     -        */
>     -       { .compatible = "jedec,spi-nor" },
>     -       {}
>     -};
>     -MODULE_DEVICE_TABLE(of, m25p_of_table);
>     -
>     -static struct spi_mem_driver m25p80_driver = {
>     -       .spidrv = {
>     -               .driver = {
>     -                       .name   = "m25p80",
>     -                       .of_match_table = m25p_of_table,
>     -               },
>     -               .id_table       = m25p_ids,
>     -       },
>     -       .probe  = m25p_probe,
>     -       .remove = m25p_remove,
>     -       .shutdown       = m25p_shutdown,
>     -
>     -       /* REVISIT: many of these chips have deep power-down modes,
>     which
>     -        * should clearly be entered on suspend() to minimize power use.
>     -        * And also when they're otherwise idle...
>     -        */
>     -};
>     -
>     -module_spi_mem_driver(m25p80_driver);
>     -
>     -MODULE_LICENSE("GPL");
>     -MODULE_AUTHOR("Mike Lavender");
>     -MODULE_DESCRIPTION("MTD SPI driver for ST M25Pxx flash chips");
>     diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>     index 6de83277ce8b..f237fcdf7f86 100644
>     --- a/drivers/mtd/spi-nor/Kconfig
>     +++ b/drivers/mtd/spi-nor/Kconfig
>     @@ -2,6 +2,8 @@
>      menuconfig MTD_SPI_NOR
>             tristate "SPI-NOR device support"
>             depends on MTD
>     +       depends on MTD && SPI_MASTER
>     +       select SPI_MEM
>             help
>               This is the framework for the SPI NOR which can be used by
>     the SPI
>               device drivers and the SPI-NOR device driver.
>     diff --git a/drivers/mtd/spi-nor/spi-nor.c
>     b/drivers/mtd/spi-nor/spi-nor.c
>     index 7f0831be90a0..de906ab907c7 100644
>     --- a/drivers/mtd/spi-nor/spi-nor.c
>     +++ b/drivers/mtd/spi-nor/spi-nor.c
>     @@ -19,6 +19,7 @@
> 
>      #include <linux/mtd/mtd.h>
>      #include <linux/of_platform.h>
>     +#include <linux/sched/task_stack.h>
>      #include <linux/spi/flash.h>
>      #include <linux/mtd/spi-nor.h>
> 
>     @@ -288,6 +289,154 @@ struct flash_info {
> 
>      #define JEDEC_MFR(info)        ((info)->id[0])
> 
>     +/**
>     + * spi_nor_spimem_xfer_data() - helper function to read/write data to
>     + *                              flash's memory region
>     + * @nor:        pointer to 'struct spi_nor'
>     + * @op:         pointer to 'struct spi_mem_op' template for transfer
>     + *
>     + * Return: number of bytes transferred on success, -errno otherwise
>     + */
>     +static ssize_t spi_nor_spimem_xfer_data(struct spi_nor *nor,
>     +                                       struct spi_mem_op *op)
>     +{
>     +       bool usebouncebuf = false;
>     +       void *rdbuf = NULL;
>     +       const void *buf;
>     +       int ret;
>     +
>     +       if (op->data.dir == SPI_MEM_DATA_IN)
>     +               buf = op->data.buf.in <http://data.buf.in>;
>     +       else
>     +               buf = op->data.buf.out;
>     +
>     +       if (object_is_on_stack(buf) || !virt_addr_valid(buf))
>     +               usebouncebuf = true;
>     +
>     +       if (usebouncebuf) {
>     +               if (op->data.nbytes > nor->bouncebuf_size)
>     +                       op->data.nbytes = nor->bouncebuf_size;
>     +
>     +               if (op->data.dir == SPI_MEM_DATA_IN) {
>     +                       rdbuf = op->data.buf.in <http://data.buf.in>;
>     +                       op->data.buf.in <http://data.buf.in> =
>     nor->bouncebuf;
>     +               } else {
>     +                       op->data.buf.out = nor->bouncebuf;
>     +                       memcpy(nor->bouncebuf, buf,
>     +                              op->data.nbytes);
>     +               }
>     +       }
>     +
>     +       ret = spi_mem_adjust_op_size(nor->spimem, op);
>     +       if (ret)
>     +               return ret;
>     +
>     +       ret = spi_mem_exec_op(nor->spimem, op);
>     +       if (ret)
>     +               return ret;
>     +
>     +       if (usebouncebuf && op->data.dir == SPI_MEM_DATA_IN)
>     +               memcpy(rdbuf, nor->bouncebuf, op->data.nbytes);
>     +
>     +       return op->data.nbytes;
>     +}
>     +
>     +/**
>     + * spi_nor_spimem_read_data() - read data from flash's memory
>     region via
>     + *                              spi-mem
>     + * @nor:        pointer to 'struct spi_nor'
>     + * @from:       offset to read from
>     + * @len:        number of bytes to read
>     + * @buf:        pointer to dst buffer
>     + *
>     + * Return: number of bytes read successfully, -errno otherwise
>     + */
>     +static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t
>     from,
>     +                                       size_t len, u8 *buf)
>     +{
>     +       struct spi_mem_op op =
>     +               SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
>     +                          SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
>     +                          SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
>     +                          SPI_MEM_OP_DATA_IN(len, buf, 1));
>     +
>     +       /* get transfer protocols. */
>     +       op.cmd.buswidth =
>     spi_nor_get_protocol_inst_nbits(nor->read_proto);
>     +       op.addr.buswidth =
>     spi_nor_get_protocol_addr_nbits(nor->read_proto);
>     +       op.dummy.buswidth = op.addr.buswidth;
>     +       op.data.buswidth =
>     spi_nor_get_protocol_data_nbits(nor->read_proto);
>     +
>     +       /* convert the dummy cycles to the number of bytes */
>     +       op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>     +
>     +       return spi_nor_spimem_xfer_data(nor, &op);
>     +}
>     +
>     +/**
>     + * spi_nor_read_data() - read data from flash memory
>     + * @nor:        pointer to 'struct spi_nor'
>     + * @from:       offset to read from
>     + * @len:        number of bytes to read
>     + * @buf:        pointer to dst buffer
>     + *
>     + * Return: number of bytes read successfully, -errno otherwise
>     + */
>     +static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from,
>     size_t len,
>     +                                u8 *buf)
>     +{
>     +       if (nor->spimem)
>     +               return spi_nor_spimem_read_data(nor, from, len, buf);
>     +
>     +       return nor->read(nor, from, len, buf);
>     +}
>     +
>     +/**
>     + * spi_nor_spimem_write_data() - write data to flash memory via
>     + *                               spi-mem
>     + * @nor:        pointer to 'struct spi_nor'
>     + * @to:         offset to write to
>     + * @len:        number of bytes to write
>     + * @buf:        pointer to src buffer
>     + *
>     + * Return: number of bytes written successfully, -errno otherwise
>     + */
>     +static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor,
>     loff_t to,
>     +                                        size_t len, const u8 *buf)
>     +{
>     +       struct spi_mem_op op =
>     +               SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
>     +                          SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
>     +                          SPI_MEM_OP_NO_DUMMY,
>     +                          SPI_MEM_OP_DATA_OUT(len, buf, 1));
>     +
>     +       op.cmd.buswidth =
>     spi_nor_get_protocol_inst_nbits(nor->write_proto);
>     +       op.addr.buswidth =
>     spi_nor_get_protocol_addr_nbits(nor->write_proto);
>     +       op.data.buswidth =
>     spi_nor_get_protocol_data_nbits(nor->write_proto);
>     +
>     +       if (nor->program_opcode == SPINOR_OP_AAI_WP &&
>     nor->sst_write_second)
>     +               op.addr.nbytes = 0;
>     +
>     +       return spi_nor_spimem_xfer_data(nor, &op);
>     +}
>     +
>     +/**
>     + * spi_nor_write_data() - write data to flash memory
>     + * @nor:        pointer to 'struct spi_nor'
>     + * @to:         offset to write to
>     + * @len:        number of bytes to write
>     + * @buf:        pointer to src buffer
>     + *
>     + * Return: number of bytes written successfully, -errno otherwise
>     + */
>     +static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to,
>     size_t len,
>     +                                 const u8 *buf)
>     +{
>     +       if (nor->spimem)
>     +               return spi_nor_spimem_write_data(nor, to, len, buf);
>     +
>     +       return nor->write(nor, to, len, buf);
>     +}
>     +
>      /*
>       * Read the status register, returning its value in the location
>       * Return the status register value.
>     @@ -297,7 +446,18 @@ static int read_sr(struct spi_nor *nor)
>      {
>             int ret;
> 
>     -       ret = nor->read_reg(nor, SPINOR_OP_RDSR, nor->bouncebuf, 1);
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1,
>     nor->bouncebuf, 1));
>     +
>     +               ret = spi_mem_exec_op(nor->spimem, &op);
>     +       } else {
>     +               ret = nor->read_reg(nor, SPINOR_OP_RDSR,
>     nor->bouncebuf, 1);
>     +       }
>     +
>             if (ret < 0) {
>                     pr_err("error %d reading SR\n", (int) ret);
>                     return ret;
>     @@ -315,7 +475,18 @@ static int read_fsr(struct spi_nor *nor)
>      {
>             int ret;
> 
>     -       ret = nor->read_reg(nor, SPINOR_OP_RDFSR, nor->bouncebuf, 1);
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1,
>     nor->bouncebuf, 1));
>     +
>     +               ret = spi_mem_exec_op(nor->spimem, &op);
>     +       } else {
>     +               ret = nor->read_reg(nor, SPINOR_OP_RDFSR,
>     nor->bouncebuf, 1);
>     +       }
>     +
>             if (ret < 0) {
>                     pr_err("error %d reading FSR\n", ret);
>                     return ret;
>     @@ -333,7 +504,18 @@ static int read_cr(struct spi_nor *nor)
>      {
>             int ret;
> 
>     -       ret = nor->read_reg(nor, SPINOR_OP_RDCR, nor->bouncebuf, 1);
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1,
>     nor->bouncebuf, 1));
>     +
>     +               ret = spi_mem_exec_op(nor->spimem, &op);
>     +       } else {
>     +               ret = nor->read_reg(nor, SPINOR_OP_RDCR,
>     nor->bouncebuf, 1);
>     +       }
>     +
>             if (ret < 0) {
>                     dev_err(nor->dev, "error %d reading CR\n", ret);
>                     return ret;
>     @@ -349,6 +531,16 @@ static int read_cr(struct spi_nor *nor)
>      static int write_sr(struct spi_nor *nor, u8 val)
>      {
>             nor->bouncebuf[0] = val;
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1,
>     nor->bouncebuf, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>             return nor->write_reg(nor, SPINOR_OP_WRSR, nor->bouncebuf, 1);
>      }
> 
>     @@ -358,6 +550,16 @@ static int write_sr(struct spi_nor *nor, u8 val)
>       */
>      static int write_enable(struct spi_nor *nor)
>      {
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>             return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
>      }
> 
>     @@ -366,6 +568,16 @@ static int write_enable(struct spi_nor *nor)
>       */
>      static int write_disable(struct spi_nor *nor)
>      {
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>             return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
>      }
> 
>     @@ -465,12 +677,64 @@ static void spi_nor_set_4byte_opcodes(struct
>     spi_nor *nor)
>             }
>      }
> 
>     +static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
>     +                                                 SPINOR_OP_EN4B :
>     +                                                 SPINOR_OP_EX4B,
>     +                                                 1),
>     +                                 SPI_MEM_OP_NO_ADDR,
>     +                                 SPI_MEM_OP_NO_DUMMY,
>     +                                 SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, enable ? SPINOR_OP_EN4B :
>     SPINOR_OP_EX4B,
>     +                             NULL, 0);
>     +}
>     +
>     +static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>     +{
>     +       nor->bouncebuf[0] = enable << 7;
>     +
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_OUT(1,
>     nor->bouncebuf, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
>     +}
>     +
>     +static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>     +{
>     +       nor->bouncebuf[0] = ear;
>     +
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_OUT(1,
>     nor->bouncebuf, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
>     +}
>     +
>      /* Enable/disable 4-byte addressing mode. */
>      static int set_4byte(struct spi_nor *nor, bool enable)
>      {
>             int status;
>             bool need_wren = false;
>     -       u8 cmd;
> 
>             switch (JEDEC_MFR(nor->info)) {
>             case SNOR_MFR_ST:
>     @@ -483,8 +747,7 @@ static int set_4byte(struct spi_nor *nor, bool
>     enable)
>                     if (need_wren)
>                             write_enable(nor);
> 
>     -               cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
>     -               status = nor->write_reg(nor, cmd, NULL, 0);
>     +               status = macronix_set_4byte(nor, enable);
>                     if (need_wren)
>                             write_disable(nor);
> 
>     @@ -497,25 +760,37 @@ static int set_4byte(struct spi_nor *nor, bool
>     enable)
>                              * We must clear the register to enable
>     normal behavior.
>                              */
>                             write_enable(nor);
>     -                       nor->bouncebuf[0] = 0;
>     -                       nor->write_reg(nor, SPINOR_OP_WREAR,
>     -                                      nor->bouncebuf, 1);
>     +                       spi_nor_write_ear(nor, 0);
>                             write_disable(nor);
>                     }
> 
>                     return status;
>             default:
>                     /* Spansion style */
>     -               nor->bouncebuf[0] = enable << 7;
>     -               return nor->write_reg(nor, SPINOR_OP_BRWR,
>     nor->bouncebuf, 1);
>     +               return spansion_set_4byte(nor, enable);
>             }
>      }
> 
>     +static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1, sr, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
>     +}
>     +
>      static int s3an_sr_ready(struct spi_nor *nor)
>      {
>             int ret;
> 
>     -       ret = nor->read_reg(nor, SPINOR_OP_XRDSR, nor->bouncebuf, 1);
>     +       ret = spi_nor_xread_sr(nor, nor->bouncebuf);
>             if (ret < 0) {
>                     dev_err(nor->dev, "error %d reading XRDSR\n", (int)
>     ret);
>                     return ret;
>     @@ -524,6 +799,21 @@ static int s3an_sr_ready(struct spi_nor *nor)
>             return !!(nor->bouncebuf[0] & XSR_RDY);
>      }
> 
>     +static int spi_nor_clear_sr(struct spi_nor *nor)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
>     +}
>     +
>      static int spi_nor_sr_ready(struct spi_nor *nor)
>      {
>             int sr = read_sr(nor);
>     @@ -536,13 +826,28 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>                     else
>                             dev_err(nor->dev, "Programming Error
>     occurred\n");
> 
>     -               nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
>     +               spi_nor_clear_sr(nor);
>                     return -EIO;
>             }
> 
>             return !(sr & SR_WIP);
>      }
> 
>     +static int spi_nor_clear_fsr(struct spi_nor *nor)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
>     +}
>     +
>      static int spi_nor_fsr_ready(struct spi_nor *nor)
>      {
>             int fsr = read_fsr(nor);
>     @@ -559,7 +864,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
>                             dev_err(nor->dev,
>                             "Attempted to modify a protected sector.\n");
> 
>     -               nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
>     +               spi_nor_clear_fsr(nor);
>                     return -EIO;
>             }
> 
>     @@ -627,6 +932,16 @@ static int erase_chip(struct spi_nor *nor)
>      {
>             dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >>
>     10));
> 
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                     
>      SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>             return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
>      } 
> 
>     @@ -688,6 +1003,16 @@ static int spi_nor_erase_sector(struct spi_nor
>     *nor, u32 addr)
>             if (nor->erase)
>                     return nor->erase(nor, addr);
> 
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 1),
>     +                                  SPI_MEM_OP_ADDR(nor->addr_width,
>     addr, 1),
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_NO_DATA);
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
> 
> 
> static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
> {
> 
>     int i;
> 
>     if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
> 
>         addr = spi_nor_s3an_addr_convert(nor, addr);
> 
> 
>     if (nor->erase)
> 
>         return nor->erase(nor, addr);
> 
> 
>     /*
>     * Default implementation, if driver doesn't have a specialized HW
>     * control
>     */
>     for (i = nor->addr_width - 1; i >= 0; i--) {
> 
>         nor->bouncebuf[i] = addr & 0xff;
> 
>         addr >>= 8;
> 
>     }
> 
>     if (nor->spimem) {
> 
>         struct spi_mem_op op =
> 
>             SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 1),
> 
>               SPI_MEM_OP_NO_ADDR,
> 
>               SPI_MEM_OP_NO_DUMMY,
> 
>               SPI_MEM_OP_DATA_OUT(nor->addr_width,
> 
>                   nor->bouncebuf, 1));
> 
> 
>         return spi_mem_exec_op(nor->spimem, &op);
> 
>     }
> 
>     return nor->write_reg(nor, nor->erase_opcode, nor->bouncebuf,
> 
>                 nor->addr_width);
> 
> }
>  
> 
>             /*
>              * Default implementation, if driver doesn't have a
>     specialized HW
>              * control
>     @@ -1403,7 +1728,18 @@ static int write_sr_cr(struct spi_nor *nor,
>     u8 *sr_cr)
> 
>             write_enable(nor);
> 
>     -       ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
>     +
>     +               ret = spi_mem_exec_op(nor->spimem, &op);
>     +       } else {
>     +               ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
>     +       }
>     +
>             if (ret < 0) {
>                     dev_err(nor->dev,
>                             "error while writing configuration register\n");
>     @@ -1584,6 +1920,36 @@ static int
>     spansion_read_cr_quad_enable(struct spi_nor *nor)
>             return 0;
>      }
> 
>     +static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_OUT(1, sr2, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
>     +}
>     +
>     +static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>     +{
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                  SPI_MEM_OP_DATA_IN(1, sr2, 1));
>     +
>     +               return spi_mem_exec_op(nor->spimem, &op);
>     +       }
>     +
>     +       return nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
>     +}
>     +
>      /**
>       * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
>       * @nor:       pointer to a 'struct spi_nor'
>     @@ -1602,7 +1968,7 @@ static int sr2_bit7_quad_enable(struct spi_nor
>     *nor)
>             int ret;
> 
>             /* Check current Quad Enable bit value. */
>     -       ret = nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
>     +       ret = spi_nor_read_sr2(nor, sr2);
>             if (ret)
>                     return ret;
>             if (*sr2 & SR2_QUAD_EN_BIT7)
>     @@ -1613,7 +1979,7 @@ static int sr2_bit7_quad_enable(struct spi_nor
>     *nor)
> 
>             write_enable(nor);
> 
>     -       ret = nor->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
>     +       ret = spi_nor_write_sr2(nor, sr2);
>             if (ret < 0) {
>                     dev_err(nor->dev, "error while writing status
>     register 2\n");
>                     return -EINVAL;
>     @@ -1626,7 +1992,7 @@ static int sr2_bit7_quad_enable(struct spi_nor
>     *nor)
>             }
> 
>             /* Read back and check it. */
>     -       ret = nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
>     +       ret = spi_nor_read_sr2(nor, sr2);
>             if (!(ret > 0 && (*sr2 & SR2_QUAD_EN_BIT7))) {
>                     dev_err(nor->dev, "SR2 Quad bit not set\n");
>                     return -EINVAL;
>     @@ -2179,7 +2545,18 @@ static const struct flash_info
>     *spi_nor_read_id(struct spi_nor *nor)
>             u8                      *id = nor->bouncebuf;
>             const struct flash_info *info;
> 
>     -       tmp = nor->read_reg(nor, SPINOR_OP_RDID, id,
>     SPI_NOR_MAX_ID_LEN);
>     +       if (nor->spimem) {
>     +               struct spi_mem_op op =
>     +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
>     +                                  SPI_MEM_OP_NO_ADDR,
>     +                                  SPI_MEM_OP_NO_DUMMY,
>     +                                 
>     SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
>     +
>     +               tmp = spi_mem_exec_op(nor->spimem, &op);
>     +       } else {
>     +               tmp = nor->read_reg(nor, SPINOR_OP_RDID, id,
>     +                                   SPI_NOR_MAX_ID_LEN);
>     +       }
>             if (tmp < 0) {
>                     dev_err(nor->dev, "error %d reading JEDEC ID\n", tmp);
>                     return ERR_PTR(tmp);
>     @@ -2215,7 +2592,7 @@ static int spi_nor_read(struct mtd_info *mtd,
>     loff_t from, size_t len,
>                     if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
>                             addr = spi_nor_s3an_addr_convert(nor, addr);
> 
>     -               ret = nor->read(nor, addr, len, buf);
>     +               ret = spi_nor_read_data(nor, addr, len, buf);
>                     if (ret == 0) {
>                             /* We shouldn't see 0-length reads */
>                             ret = -EIO;
>     @@ -2260,7 +2637,7 @@ static int sst_write(struct mtd_info *mtd,
>     loff_t to, size_t len,
>                     nor->program_opcode = SPINOR_OP_BP;
> 
>                     /* write one byte. */
>     -               ret = nor->write(nor, to, 1, buf);
>     +               ret = spi_nor_write_data(nor, to, 1, buf);
>                     if (ret < 0)
>                             goto sst_write_err;
>                     WARN(ret != 1, "While writing 1 byte written %i
>     bytes\n",
>     @@ -2276,7 +2653,7 @@ static int sst_write(struct mtd_info *mtd,
>     loff_t to, size_t len,
>                     nor->program_opcode = SPINOR_OP_AAI_WP;
> 
>                     /* write two bytes. */
>     -               ret = nor->write(nor, to, 2, buf + actual);
>     +               ret = spi_nor_write_data(nor, to, 2, buf + actual);
>                     if (ret < 0)
>                             goto sst_write_err;
>                     WARN(ret != 2, "While writing 2 bytes written %i
>     bytes\n",
>     @@ -2299,7 +2676,7 @@ static int sst_write(struct mtd_info *mtd,
>     loff_t to, size_t len,
>                     write_enable(nor);
> 
>                     nor->program_opcode = SPINOR_OP_BP;
>     -               ret = nor->write(nor, to, 1, buf + actual);
>     +               ret = spi_nor_write_data(nor, to, 1, buf + actual);
>                     if (ret < 0)
>                             goto sst_write_err;
>                     WARN(ret != 1, "While writing 1 byte written %i
>     bytes\n",
>     @@ -2361,7 +2738,7 @@ static int spi_nor_write(struct mtd_info *mtd,
>     loff_t to, size_t len,
>                             addr = spi_nor_s3an_addr_convert(nor, addr);
> 
>                     write_enable(nor);
>     -               ret = nor->write(nor, addr, page_remain, buf + i);
>     +               ret = spi_nor_write_data(nor, addr, page_remain, buf
>     + i);
>                     if (ret < 0)
>                             goto write_err;
>                     written = ret;
>     @@ -2380,8 +2757,10 @@ static int spi_nor_write(struct mtd_info
>     *mtd, loff_t to, size_t len,
> 
>      static int spi_nor_check(struct spi_nor *nor)
>      {
>     -       if (!nor->dev || !nor->read || !nor->write ||
>     -               !nor->read_reg || !nor->write_reg) {
>     +       if (!nor->dev ||
>     +           (!nor->spimem &&
>     +           (!nor->read || !nor->write || !nor->read_reg ||
>     +             !nor->write_reg))) {
>                     pr_err("spi-nor: please fill all the necessary
>     fields!\n");
>                     return -EINVAL;
>             }
>     @@ -2393,7 +2772,7 @@ static int s3an_nor_scan(struct spi_nor *nor)
>      {
>             int ret;
> 
>     -       ret = nor->read_reg(nor, SPINOR_OP_XRDSR, nor->bouncebuf, 1);
>     +       ret = spi_nor_xread_sr(nor, nor->bouncebuf);
>             if (ret < 0) {
>                     dev_err(nor->dev, "error %d reading XRDSR\n", (int)
>     ret);
>                     return ret;
>     @@ -2523,7 +2902,7 @@ static int spi_nor_read_raw(struct spi_nor
>     *nor, u32 addr, size_t len, u8 *buf)
>             int ret;
> 
>             while (len) {
>     -               ret = nor->read(nor, addr, len, buf);
>     +               ret = spi_nor_read_data(nor, addr, len, buf);
>                     if (!ret || ret > len)
>                             return -EIO;
>                     if (ret < 0)
>     @@ -4122,6 +4501,10 @@ int spi_nor_scan(struct spi_nor *nor, const
>     char *name,
>             /*
>              * We need the bounce buffer early to read/write registers
>     when going
>              * through the spi-mem layer (buffers have to be DMA-able).
>     +        * For spi-mem drivers, we'll reallocate a new buffer if
>     +        * nor->page_size turns out to be greater than PAGE_SIZE (which
>     +        * shouldn't happen before long since NOR pages are usually less
>     +        * than 1KB) after spi_nor_scan() returns.
>              */
>             nor->bouncebuf_size = PAGE_SIZE;
>             nor->bouncebuf = devm_kmalloc(dev, nor->bouncebuf_size,
>     @@ -4324,6 +4707,195 @@ int spi_nor_scan(struct spi_nor *nor, const
>     char *name,
>      }
>      EXPORT_SYMBOL_GPL(spi_nor_scan);
> 
>     +static int spi_nor_probe(struct spi_mem *spimem)
>     +{
>     +       struct spi_device *spi = spimem->spi;
>     +       struct flash_platform_data *data = dev_get_platdata(&spi->dev);
>     +       struct spi_nor *nor;
>     +       struct spi_nor_hwcaps hwcaps = {
>     +               .mask = SNOR_HWCAPS_READ |
>     +                       SNOR_HWCAPS_READ_FAST |
>     +                       SNOR_HWCAPS_PP,
>     +       };
>     +       char *flash_name;
>     +       int ret;
>     +
>     +       nor = devm_kzalloc(&spi->dev, sizeof(*nor), GFP_KERNEL);
>     +       if (!nor)
>     +               return -ENOMEM;
>     +
>     +       nor->spimem = spimem;
>     +       nor->dev = &spi->dev;
>     +       spi_nor_set_flash_node(nor, spi->dev.of_node);
>     +
>     +       spi_mem_set_drvdata(spimem, nor);
>     +
>     +       if (spi->mode & SPI_RX_OCTAL) {
>     +               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
>     +
>     +               if (spi->mode & SPI_TX_OCTAL)
>     +                       hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
>     +                                       SNOR_HWCAPS_PP_1_1_8 |
>     +                                       SNOR_HWCAPS_PP_1_8_8);
>     +       } else if (spi->mode & SPI_RX_QUAD) {
>     +               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
>     +
>     +               if (spi->mode & SPI_TX_QUAD)
>     +                       hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
>     +                                       SNOR_HWCAPS_PP_1_1_4 |
>     +                                       SNOR_HWCAPS_PP_1_4_4);
>     +       } else if (spi->mode & SPI_RX_DUAL) {
>     +               hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
>     +
>     +               if (spi->mode & SPI_TX_DUAL)
>     +                       hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>     +       }
>     +
>     +       if (data && data->name)
>     +               nor->mtd.name <http://mtd.name> = data->name;
>     +
>     +       if (!nor->mtd.name <http://mtd.name>)
>     +               nor->mtd.name <http://mtd.name> =
>     spi_mem_get_name(spimem);
>     +
>     +       /*
>     +        * For some (historical?) reason many platforms provide two
>     different
>     +        * names in flash_platform_data: "name" and "type". Quite
>     often name is
>     +        * set to "m25p80" and then "type" provides a real chip name.
>     +        * If that's the case, respect "type" and ignore a "name".
>     +        */
>     +       if (data && data->type)
>     +               flash_name = data->type;
>     +       else if (!strcmp(spi->modalias, "spi-nor"))
>     +               flash_name = NULL; /* auto-detect */
>     +       else
>     +               flash_name = spi->modalias;
>     +
>     +       ret = spi_nor_scan(nor, flash_name, &hwcaps);
>     +       if (ret)
>     +               return ret;
>     +
>     +       /*
>     +        * None of the existing parts have > 512B pages, but let's
>     play safe
>     +        * and add this logic so that if anyone ever adds support
>     for such
>     +        * a NOR we don't end up with buffer overflows.
>     +        */
>     +       if (nor->page_size > PAGE_SIZE) {
>     +               nor->bouncebuf_size = nor->page_size;
>     +               devm_kfree(nor->dev, nor->bouncebuf);
>     +               nor->bouncebuf = devm_kmalloc(nor->dev,
>     +                                             nor->bouncebuf_size,
>     +                                             GFP_KERNEL);
>     +               if (!nor->bouncebuf)
>     +                       return -ENOMEM;
>     +       }
>     +
>     +       return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>     +                                  data ? data->nr_parts : 0);
>     +}
>     +
>     +static int spi_nor_remove(struct spi_mem *spimem)
>     +{
>     +       struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>     +
>     +       spi_nor_restore(nor);
>     +
>     +       /* Clean up MTD stuff. */
>     +       return mtd_device_unregister(&nor->mtd);
>     +}
>     +
>     +static void spi_nor_shutdown(struct spi_mem *spimem)
>     +{
>     +       struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>     +
>     +       spi_nor_restore(nor);
>     +}
>     +
>     +/*
>     + * Do NOT add to this array without reading the following:
>     + *
>     + * Historically, many flash devices are bound to this driver by
>     their name. But
>     + * since most of these flash are compatible to some extent, and their
>     + * differences can often be differentiated by the JEDEC read-ID
>     command, we
>     + * encourage new users to add support to the spi-nor library, and
>     simply bind
>     + * against a generic string here (e.g., "jedec,spi-nor").
>     + *
>     + * Many flash names are kept here in this list (as well as in
>     spi-nor.c) to
>     + * keep them available as module aliases for existing platforms.
>     + */
>     +static const struct spi_device_id spi_nor_dev_ids[] = {
>     +       /*
>     +        * Allow non-DT platform devices to bind to the "spi-nor"
>     modalias, and
>     +        * hack around the fact that the SPI core does not provide
>     uevent
>     +        * matching for .of_match_table
>     +        */
>     +       {"spi-nor"},
>     +
>     +       /*
>     +        * Entries not used in DTs that should be safe to drop after
>     replacing
>     +        * them with "spi-nor" in platform data.
>     +        */
>     +       {"s25sl064a"},  {"w25x16"},     {"m25p10"},     {"m25px64"},
>     +
>     +       /*
>     +        * Entries that were used in DTs without "jedec,spi-nor"
>     fallback and
>     +        * should be kept for backward compatibility.
>     +        */
>     +       {"at25df321a"}, {"at25df641"},  {"at26df081a"},
>     +       {"mx25l4005a"}, {"mx25l1606e"}, {"mx25l6405d"}, {"mx25l12805d"},
>     +       {"mx25l25635e"},{"mx66l51235l"},
>     +       {"n25q064"},    {"n25q128a11"}, {"n25q128a13"}, {"n25q512a"},
>     +       {"s25fl256s1"}, {"s25fl512s"},  {"s25sl12801"}, {"s25fl008k"},
>     +       {"s25fl064k"},
>     +       {"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
>     +       {"m25p40"},     {"m25p80"},     {"m25p16"},     {"m25p32"},
>     +       {"m25p64"},     {"m25p128"},
>     +       {"w25x80"},     {"w25x32"},     {"w25q32"},     {"w25q32dw"},
>     +       {"w25q80bl"},   {"w25q128"},    {"w25q256"},
>     +
>     +       /* Flashes that can't be detected using JEDEC */
>     +       {"m25p05-nonjedec"},    {"m25p10-nonjedec"},   
>     {"m25p20-nonjedec"},
>     +       {"m25p40-nonjedec"},    {"m25p80-nonjedec"},   
>     {"m25p16-nonjedec"},
>     +       {"m25p32-nonjedec"},    {"m25p64-nonjedec"},   
>     {"m25p128-nonjedec"},
>     +
>     +       /* Everspin MRAMs (non-JEDEC) */
>     +       { "mr25h128" }, /* 128 Kib, 40 MHz */
>     +       { "mr25h256" }, /* 256 Kib, 40 MHz */
>     +       { "mr25h10" },  /*   1 Mib, 40 MHz */
>     +       { "mr25h40" },  /*   4 Mib, 40 MHz */
>     +
>     +       { },
>     +};
>     +MODULE_DEVICE_TABLE(spi, spi_nor_dev_ids);
>     +
>     +static const struct of_device_id spi_nor_of_table[] = {
>     +       /*
>     +        * Generic compatibility for SPI NOR that can be identified
>     by the
>     +        * JEDEC READ ID opcode (0x9F). Use this, if possible.
>     +        */
>     +       { .compatible = "jedec,spi-nor" },
>     +       { /* sentinel */ },
>     +};
>     +MODULE_DEVICE_TABLE(of, spi_nor_of_table);
>     +
>     +/*
>     + * REVISIT: many of these chips have deep power-down modes, which
>     + * should clearly be entered on suspend() to minimize power use.
>     + * And also when they're otherwise idle...
>     + */
>     +static struct spi_mem_driver spi_nor_driver = {
>     +       .spidrv = {
>     +               .driver = {
>     +                       .name = "spi-nor",
>     +                       .of_match_table = spi_nor_of_table,
>     +               },
>     +               .id_table = spi_nor_dev_ids,
>     +       },
>     +       .probe = spi_nor_probe,
>     +       .remove = spi_nor_remove,
>     +       .shutdown = spi_nor_shutdown,
>     +};
>     +module_spi_mem_driver(spi_nor_driver);
>     +
>      MODULE_LICENSE("GPL v2");
>      MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com
>     <mailto:shijie8@gmail.com>>");
>      MODULE_AUTHOR("Mike Lavender");
>     diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>     index 6b5956a7a65a..4f35b1877889 100644
>     --- a/include/linux/mtd/spi-nor.h
>     +++ b/include/linux/mtd/spi-nor.h
>     @@ -9,6 +9,7 @@
>      #include <linux/bitops.h>
>      #include <linux/mtd/cfi.h>
>      #include <linux/mtd/mtd.h>
>     +#include <linux/spi/spi-mem.h>
> 
>      /*
>       * Manufacturer IDs
>     @@ -344,6 +345,7 @@ struct flash_info;
>       * @mtd:               point to a mtd_info structure
>       * @lock:              the lock for the
>     read/write/erase/lock/unlock operations
>       * @dev:               point to a spi device, or a spi nor
>     controller device.
>     + * @spimem:            point to the spi mem device
>       * @bouncebuf:         bounce buffer used when the buffer passed by
>     the MTD
>       *                      layer is not DMA-able
>       * @bouncebuf_size:    size of the bounce buffer
>     @@ -384,6 +386,7 @@ struct spi_nor {
>             struct mtd_info         mtd;
>             struct mutex            lock;
>             struct device           *dev;
>     +       struct spi_mem          *spimem;
>             u8                      *bouncebuf;
>             size_t                  bouncebuf_size;
>             const struct flash_info *info;
>     -- 
>     2.22.0
> 
> 
> Thanks,
> 
> Tomer 

-- 
Regards
Vignesh
