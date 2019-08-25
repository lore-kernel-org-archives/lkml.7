Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59232C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2C2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfHYLi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:38:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHYLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:38:57 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1D42426DF12;
        Sun, 25 Aug 2019 12:38:56 +0100 (BST)
Date:   Sun, 25 Aug 2019 13:38:53 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] mtd: spi-nor: move manuf out of the core - batch 0
Message-ID: <20190825133853.32532641@collabora.com>
In-Reply-To: <20190823155325.13459-1-tudor.ambarus@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:53:33 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> This series is a prerequisite for the effort of moving the
> manufacturer specific code out of the SPI NOR core.
> 
> The scope is to move all [FLASH-SPECIFIC] parameters and settings
> from 'struct spi_nor' to 'struct spi_nor_flash_parameter'. We will
> have a clear separation between the SPI NOR layer and the flash
> parameters and settings.
> 
> 'struct spi_nor_flash_parameter' describes the hardware capabilities
> and associated settings of the SPI NOR flash memory. It includes
> legacy flash parameters and settings that can be overwritten by the
> spi_nor_fixups hooks, or dynamically when parsing the JESD216
> Serial Flash Discoverable Parameters (SFDP) tables. All SFDP params
> and settings will fit inside 'struct spi_nor_flash_parameter'.

While we're at moving things around, I think it'd make sense to move
all '[DRIVER SPECIFIC]' fields (which are actually SPI NOR controller
driver specific fields) to a separate struct:

struct spi_nor_controller_ops {
	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
	ssize_t (*read)(struct spi_nor *nor, loff_t from,
			size_t len, u_char *read_buf);
	ssize_t (*write)(struct spi_nor *nor, loff_t to,
			size_t len, const u_char *write_buf);
	int (*erase)(struct spi_nor *nor, loff_t offs);
};

struct spi_nor {
...
	const struct spi_nor_controller_ops *controller_ops;
...
};

> 
> Tested uniform and non-uniform erase on sst26vf064b flash using the
> atmel-quadspi driver.
> 
> In order to test this, you'll have to merge v5.3-rc5 in spi-nor/next.
> This patch depends on
> 'commit 834de5c1aa76 ("mtd: spi-nor: Fix the disabling of write protection at init")
> 
> Tudor Ambarus (5):
>   mtd: spi-nor: Regroup flash parameter and settings
>   mtd: spi-nor: Use nor->params
>   mtd: spi-nor: Drop quad_enable() from 'struct spi-nor'
>   mtd: spi-nor: Move clear_sr_bp() to 'struct spi_nor_flash_parameter'
>   mtd: spi-nor: Move erase_map to 'struct spi_nor_flash_parameter'
> 
>  drivers/mtd/spi-nor/spi-nor.c | 236 ++++++++++++++++-----------------------
>  include/linux/mtd/spi-nor.h   | 254 ++++++++++++++++++++++++++++--------------
>  2 files changed, 269 insertions(+), 221 deletions(-)
> 

