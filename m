Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1634207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfKYPFJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:05:09 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52839 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKYPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:05:09 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6A673FF81C;
        Mon, 25 Nov 2019 15:05:04 +0000 (UTC)
Date:   Mon, 25 Nov 2019 16:05:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: mtd: Use mtd device name instead of mtd->name when registering
 nvmem device
Message-ID: <20191125160503.1243f817@xps13>
In-Reply-To: <1574442222-19759-1-git-send-email-christophe.kerello@st.com>
References: <1574442222-19759-1-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 22 Nov
2019 18:03:42 +0100:

> MTD currently allows to have same partition name on different devices.
> Since nvmen device registration has been added, it is not more possible
> to have same partition name on different devices. We get following
> logs:
> sysfs: cannot create duplicate filename XXX
> Failed to register NVMEM device
> 
> To avoid such issue, the proposed patch uses the mtd device name instead of
> the partition name.
> 
> Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
> Hi,
> 
> With latest mtd-next branch, we get following logs on our STM32MP1 eval board.
> 
> [    1.979089] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xd3
> [    1.984055] nand: Micron MT29F8G08ABACAH4
> [    1.988000] nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 224
> [    1.996378] Bad block table found at page 262080, version 0x01
> [    2.001945] Bad block table found at page 262016, version 0x01
> [    2.008002] 4 fixed-partitions partitions found on MTD device 58002000.nand-controller
> [    2.015398] Creating 4 MTD partitions on "58002000.nand-controller":
> [    2.021751] 0x000000000000-0x000000200000 : "fsbl"
> [    2.028506] 0x000000200000-0x000000400000 : "ssbl1"
> [    2.033741] 0x000000400000-0x000000600000 : "ssbl2"
> [    2.038924] 0x000000600000-0x000040000000 : "UBI"
> [    2.051336] spi-nor spi0.0: mx66l51235l (65536 Kbytes)
> [    2.055123] 4 fixed-partitions partitions found on MTD device spi0.0
> [    2.061378] Creating 4 MTD partitions on "spi0.0":
> [    2.066243] 0x000000000000-0x000000040000 : "fsbl"
> [    2.071429] sysfs: cannot create duplicate filename '/bus/nvmem/devices/fsbl'
> [    2.078157] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc4-00031-g589e1b6 #176
> [    2.085781] Hardware name: STM32 (Device Tree Support)
> [    2.090957] [<c0312830>] (unwind_backtrace) from [<c030cbe4>] (show_stack+0x10/0x14)
> [    2.098693] [<c030cbe4>] (show_stack) from [<c0e8d340>] (dump_stack+0xb4/0xc8)
> [    2.105929] [<c0e8d340>] (dump_stack) from [<c050fcdc>] (sysfs_warn_dup+0x58/0x64)
> [    2.113509] [<c050fcdc>] (sysfs_warn_dup) from [<c0510010>] (sysfs_do_create_link_sd+0xe4/0xe8)
> [    2.122224] [<c0510010>] (sysfs_do_create_link_sd) from [<c0956f60>] (bus_add_device+0x80/0xfc)
> [    2.130938] [<c0956f60>] (bus_add_device) from [<c0953f54>] (device_add+0x35c/0x608)
> [    2.138697] [<c0953f54>] (device_add) from [<c0d12e0c>] (nvmem_register.part.2+0x180/0x624)
> [    2.147065] [<c0d12e0c>] (nvmem_register.part.2) from [<c09ea5c8>] (add_mtd_device+0x2d8/0x4b8)
> [    2.155776] [<c09ea5c8>] (add_mtd_device) from [<c09edbd4>] (add_mtd_partitions+0x84/0x16c)
> [    2.164140] [<c09edbd4>] (add_mtd_partitions) from [<c09ed9ac>] (parse_mtd_partitions+0x220/0x3c4)
> [    2.173118] [<c09ed9ac>] (parse_mtd_partitions) from [<c09ea8d4>] (mtd_device_parse_register+0x40/0x164)
> [    2.182622] [<c09ea8d4>] (mtd_device_parse_register) from [<c0a22dfc>] (spi_nor_probe+0xd0/0x190)
> [    2.191513] [<c0a22dfc>] (spi_nor_probe) from [<c0a370a0>] (spi_drv_probe+0x80/0xa4)
> [    2.199268] [<c0a370a0>] (spi_drv_probe) from [<c0957f8c>] (really_probe+0x234/0x34c)
> [    2.207111] [<c0957f8c>] (really_probe) from [<c095821c>] (driver_probe_device+0x60/0x174)
> [    2.215391] [<c095821c>] (driver_probe_device) from [<c0956378>] (bus_for_each_drv+0x58/0xb8)
> [    2.223932] [<c0956378>] (bus_for_each_drv) from [<c0957ce4>] (__device_attach+0xd0/0x13c)
> [    2.232212] [<c0957ce4>] (__device_attach) from [<c0957060>] (bus_probe_device+0x84/0x8c)
> [    2.240404] [<c0957060>] (bus_probe_device) from [<c0953fb4>] (device_add+0x3bc/0x608)
> [    2.248334] [<c0953fb4>] (device_add) from [<c0a377b4>] (spi_add_device+0x9c/0x14c)
> [    2.256003] [<c0a377b4>] (spi_add_device) from [<c0a37b98>] (of_register_spi_device+0x234/0x370)
> [    2.264807] [<c0a37b98>] (of_register_spi_device) from [<c0a384ec>] (spi_register_controller+0x578/0x734)
> [    2.274394] [<c0a384ec>] (spi_register_controller) from [<c0a386dc>] (devm_spi_register_controller+0x34/0x6c)
> [    2.284331] [<c0a386dc>] (devm_spi_register_controller) from [<c0a4d0b8>] (stm32_qspi_probe+0x338/0x3bc)
> [    2.293831] [<c0a4d0b8>] (stm32_qspi_probe) from [<c0959ee0>] (platform_drv_probe+0x48/0x98)
> [    2.302285] [<c0959ee0>] (platform_drv_probe) from [<c0957f8c>] (really_probe+0x234/0x34c)
> [    2.310566] [<c0957f8c>] (really_probe) from [<c095821c>] (driver_probe_device+0x60/0x174)
> [    2.318847] [<c095821c>] (driver_probe_device) from [<c09584d8>] (device_driver_attach+0x58/0x60)
> [    2.327735] [<c09584d8>] (device_driver_attach) from [<c0958560>] (__driver_attach+0x80/0xbc)
> [    2.336276] [<c0958560>] (__driver_attach) from [<c09562cc>] (bus_for_each_dev+0x74/0xb4)
> [    2.344469] [<c09562cc>] (bus_for_each_dev) from [<c09572c4>] (bus_add_driver+0x164/0x1e8)
> [    2.352749] [<c09572c4>] (bus_add_driver) from [<c0958fd8>] (driver_register+0x74/0x108)
> [    2.360854] [<c0958fd8>] (driver_register) from [<c0302ec8>] (do_one_initcall+0x54/0x22c)
> [    2.369047] [<c0302ec8>] (do_one_initcall) from [<c1501024>] (kernel_init_freeable+0x150/0x1ec)
> [    2.377762] [<c1501024>] (kernel_init_freeable) from [<c0ea5e74>] (kernel_init+0x8/0x114)
> [    2.385951] [<c0ea5e74>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    2.393525] Exception stack(0xe68c1fb0 to 0xe68c1ff8)
> [    2.398583] 1fa0:                                     00000000 00000000 00000000 00000000
> [    2.406777] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.414967] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.421879] mtd mtd4: Failed to register NVMEM device
> 
> Before nvmen device registration was added, it was possible to have same partition name on different devices.
> Instead of using the partition name, this patch proposes to use the MTD device name (mtdX).
> 
> Regards,
> Christophe Kerello.
> 
>  drivers/mtd/mtdcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5fac435..559b693 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -551,7 +551,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>  
>  	config.id = -1;
>  	config.dev = &mtd->dev;
> -	config.name = mtd->name;
> +	config.name = dev_name(&mtd->dev);

What about creating an mtd->fullname field which would be, for
partitions: mtdX:<partition-name> and would be unique?

>  	config.owner = THIS_MODULE;
>  	config.reg_read = mtd_nvmem_reg_read;
>  	config.size = mtd->size;

Thanks,
Miquèl
