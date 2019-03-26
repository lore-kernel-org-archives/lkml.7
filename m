Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE7420856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="saf7D+xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfCZNdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:33:05 -0400
Received: from mail.intenta.de ([178.249.25.132]:38897 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZNdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:33:04 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 09:33:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=E4LgTeAYS90v+QPMpYy6r78rOfJneZnRqnHkuTTGwkw=;
        b=saf7D+xrGbY4t59dSisXEiCcWrJ0GsM7/KWEJ290QYx3aO2mpI4N5AscGg+XEYjXkG6en4BIuni4K/dRsMCKdARDxFg8eJ+lDBDX6zHbWJkMaW35R20tE7y7Lbs+RrEeQdk5PYVFxKXJUGR4333e1paNJm2UK7SI9Sw4x4y1+pwr6Y/6Lx8nzB9yXkFiSE5ap90dDXLjERMmPb0cq/Jor9bz8MgWv2zJdJJHgeIozl08vtKNN0uORXitxVqbPiCPUB1wel0nvP8f3+HX1iljhto7wDilj2fCRvWbB2IUXMDAVGDGzZ/TWW1AqmEgGOqWUdHWfm5WG6wG26OvbV7v4A==;
X-CTCH-RefID: str=0001.0A0C0211.5C9A28BB.00B2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Tue, 26 Mar 2019 14:27:23 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm pl353
 smc nand interface
Message-ID: <20190326132721.52e7ktnptgwvzeor@laureti-dev>
References: <1549694247-24625-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1549694247-24625-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 12:07:27PM +0530, Naga Sureshkumar Relli wrote:
> +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> +					bool force_8bit)
> +{
> +	struct pl353_nand_controller *xnfc =
> +		container_of(chip, struct pl353_nand_controller, chip);

This `xnfc' variable is never used anywhere inside this function.

> +/**
> + * pl353_nand_exec_op_cmd - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> +				  const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op = {};
> +	struct pl353_nand_controller *xnfc =
> +		container_of(chip, struct pl353_nand_controller, chip);
> +	unsigned long cmd_phase_data = 0, end_cmd_valid = 0;
> +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> +	unsigned int op_id, len, offset;
> +	bool reading;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +
> +	offset = nand_subop_get_data_start_off(subop, op_id);

This `offset' variable is never used anywhere inside this function. The
call is unnecessary and should be removed.

Beyond being useless, it also is harmful. When applying this patch on
top of a v5.1-rc2, this can be found in dmesg:

| ------------[ cut here ]------------
| WARNING: CPU: 0 PID: 1 at .../linux/drivers/mtd/nand/raw/nand_base.c:2299 nand_subop_get_data_start_off+0x30/0x6c
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-dirty #3
| Hardware name: Xilinx Zynq Platform
| [<c001743c>] (unwind_backtrace) from [<c00145a4>] (show_stack+0x18/0x1c)
| [<c00145a4>] (show_stack) from [<c03afe98>] (dump_stack+0xa0/0xcc)
| [<c03afe98>] (dump_stack) from [<c0021c10>] (__warn+0x10c/0x128)
| [<c0021c10>] (__warn) from [<c0021d14>] (warn_slowpath_null+0x48/0x50)
| [<c0021d14>] (warn_slowpath_null) from [<c02703f0>] (nand_subop_get_data_start_off+0x30/0x6c)
| [<c02703f0>] (nand_subop_get_data_start_off) from [<c0279fe0>] (pl353_nand_exec_op_cmd+0x94/0x2f0)
| [<c0279fe0>] (pl353_nand_exec_op_cmd) from [<c027025c>] (nand_op_parser_exec_op+0x460/0x4cc)
| [<c027025c>] (nand_op_parser_exec_op) from [<c026ee4c>] (nand_reset_op+0x134/0x1a0)
| [<c026ee4c>] (nand_reset_op) from [<c0270adc>] (nand_reset+0x60/0xbc)
| [<c0270adc>] (nand_reset) from [<c0272410>] (nand_scan_with_ids+0x288/0x1600)
| [<c0272410>] (nand_scan_with_ids) from [<c027974c>] (pl353_nand_probe+0xf8/0x1a0)
| [<c027974c>] (pl353_nand_probe) from [<c025185c>] (platform_drv_probe+0x3c/0x74)
| [<c025185c>] (platform_drv_probe) from [<c024fd28>] (really_probe+0x278/0x400)
| [<c024fd28>] (really_probe) from [<c024e440>] (bus_for_each_drv+0x68/0x9c)
| [<c024e440>] (bus_for_each_drv) from [<c0250090>] (__device_attach+0xa8/0x11c)
| [<c0250090>] (__device_attach) from [<c024e63c>] (bus_probe_device+0x90/0x98)
| [<c024e63c>] (bus_probe_device) from [<c024cf7c>] (device_add+0x3b4/0x5f0)
| [<c024cf7c>] (device_add) from [<c02b91b8>] (of_platform_device_create_pdata+0x98/0xc8)
| [<c02b91b8>] (of_platform_device_create_pdata) from [<c02beba8>] (pl353_smc_probe+0x194/0x234)
| [<c02beba8>] (pl353_smc_probe) from [<c0223a64>] (amba_probe+0x60/0x74)
| [<c0223a64>] (amba_probe) from [<c024fd28>] (really_probe+0x278/0x400)
| [<c024fd28>] (really_probe) from [<c025062c>] (device_driver_attach+0x60/0x68)
| [<c025062c>] (device_driver_attach) from [<c02506bc>] (__driver_attach+0x88/0x180)
| [<c02506bc>] (__driver_attach) from [<c024df98>] (bus_for_each_dev+0x60/0x9c)
| [<c024df98>] (bus_for_each_dev) from [<c024e894>] (bus_add_driver+0x10c/0x208)
| [<c024e894>] (bus_add_driver) from [<c0250dcc>] (driver_register+0x80/0x114)
| [<c0250dcc>] (driver_register) from [<c04e2194>] (do_one_initcall+0x164/0x374)
| [<c04e2194>] (do_one_initcall) from [<c04e2738>] (kernel_init_freeable+0x394/0x474)
| [<c04e2738>] (kernel_init_freeable) from [<c03c9660>] (kernel_init+0x14/0x100)
| [<c03c9660>] (kernel_init) from [<c00090ac>] (ret_from_fork+0x14/0x28)
| Exception stack(0xdd8c9fb0 to 0xdd8c9ff8)
| 9fa0:                                     00000000 00000000 00000000 00000000
| 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
| 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
| irq event stamp: 414355
| hardirqs last  enabled at (414361): [<c007c318>] console_unlock+0x4c4/0x690
| hardirqs last disabled at (414366): [<c007bf30>] console_unlock+0xdc/0x690
| softirqs last  enabled at (414350): [<c000a4cc>] __do_softirq+0x454/0x544
| softirqs last disabled at (414345): [<c0027d98>] irq_exit+0x124/0x128
| ---[ end trace 3be9247df2f8dfb5 ]---

After removing the call (and the variable), this particular problem goes away.

> +/**
> + * pl353_nand_probe - Probe method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware.
> + * The NAND driver has dependency with the pl353_smc memory controller
> + * driver for initializing the NAND timing parameters, bus width, ECC modes,
> + * control and status information.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_probe(struct platform_device *pdev)
> +{
> +	struct pl353_nand_controller *xnfc;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	struct resource *res;
> +	struct device_node *np, *dn;
> +	u32 ret, val;

This `val' variable is never used anywhere inside this function.

Even after fixing these, I couldn't make this driver work on actual
hardware.

| nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
| nand: Micron MT29F2G08ABAEAWP
| nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
| nand: WARNING: MT29F2G08ABAEAWP: the ECC used on your system is too weak compared to the one required by the NAND chip
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| Bad block table not found for chip 0
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| pl353_nand_calculate_hwecc status failed
| Bad block table not found for chip 0

The very same device works fine with an older version of the out-of-tree
driver based on a v4.14 tree. Thus far I couldn't figure out why it
fails like this.

I'd appreciate if you could Cc me on future postings of this driver.

Helmut
