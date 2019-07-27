Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E5AC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957CD20840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfG0Pjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 11:39:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbfG0Pju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:39:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrOnR-00019o-C2; Sat, 27 Jul 2019 17:39:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrOnP-0005nI-HV; Sat, 27 Jul 2019 17:39:43 +0200
Date:   Sat, 27 Jul 2019 17:39:43 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        info@acmesystems.it
Subject: Re: [PATCH v3 6/7] ARM: dts: at91: at91sam9x5: switch to new clock
 bindings
Message-ID: <20190727153943.abjyfhkdnafq2u5w@pengutronix.de>
References: <20181112133108.31021-1-alexandre.belloni@bootlin.com>
 <20181112133108.31021-7-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112133108.31021-7-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On Mon, Nov 12, 2018 at 02:31:07PM +0100, Alexandre Belloni wrote:
> Switch at91sam9x5 boards to the new PMC clock bindings.

This patch results in a broken dtb for my AriettaG25[1]. It compiles
fine, but booting results in:

	SD/MMC: dt blob: Read file acme-arietta.dtb to 0x21000000
	SD: Card Capacity: Standard
	SD: Specification Version 3.0X

	Booting zImage ......
	zImage magic: 0x16f2818 is found

	Using device tree in place at 0x21000000

	Starting linux kernel ..., machid: 0xffffffff

	Uncompressing Linux... done, booting the kernel.
	Booting Linux on physical CPU 0x0
	Linux version 5.3.0-rc1+ (uwe@taurus) (gcc version 7.3.1 20180201 (OSELAS.Toolchain-2018.02.0 7-20180201)) #4 Sat Jul 27 15:47:15 CEST 2019
	CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
	CPU: VIVT data cache, VIVT instruction cache
	OF: fdt: Machine model: Acme Systems Arietta G25
	printk: bootconsole [earlycon0] enabled
	printk: debug: ignoring loglevel setting.
	Memory policy: Data cache writeback
	On node 0 totalpages: 32768
	  Normal zone: 256 pages used for memmap
	  Normal zone: 0 pages reserved
	  Normal zone: 32768 pages, LIFO batch:7
	pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
	pcpu-alloc: [0] 0 
	Built 1 zonelists, mobility grouping on.  Total pages: 32512
	Kernel command line: earlyprintk ignore_loglevel  mem=128M console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait
	Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
	Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
	mem auto-init: stack:off, heap alloc:off, heap free:off
	Memory: 121352K/131072K available (5826K kernel code, 199K rwdata, 1892K rodata, 232K init, 125K bss, 9720K reserved, 0K cma-reserved)
	NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
	random: get_random_bytes called from start_kernel+0x294/0x474 with crng_init=0
	bad: scheduling from the idle thread!
	CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.0-rc1+ #4
	Hardware name: Atmel AT91SAM9
	[<c000fc4c>] (unwind_backtrace) from [<c000d654>] (show_stack+0x10/0x18)
	[<c000d654>] (show_stack) from [<c059db74>] (dump_stack+0x18/0x24)
	[<c059db74>] (dump_stack) from [<c00386e8>] (dequeue_task_idle+0x1c/0x34)
	[<c00386e8>] (dequeue_task_idle) from [<c05b5818>] (__schedule+0x250/0x38c)
	[<c05b5818>] (__schedule) from [<c05b59e8>] (schedule+0x94/0xc8)
	[<c05b59e8>] (schedule) from [<c05b876c>] (schedule_hrtimeout_range_clock+0xf4/0x13c)
	[<c05b876c>] (schedule_hrtimeout_range_clock) from [<c05b87cc>] (schedule_hrtimeout_range+0x18/0x24)
	[<c05b87cc>] (schedule_hrtimeout_range) from [<c05b8240>] (usleep_range+0x70/0x98)
	[<c05b8240>] (usleep_range) from [<c02a18a0>] (clk_slow_rc_osc_prepare+0x28/0x34)
	[<c02a18a0>] (clk_slow_rc_osc_prepare) from [<c029af78>] (clk_core_prepare+0x84/0xa0)
	[<c029af78>] (clk_core_prepare) from [<c029af54>] (clk_core_prepare+0x60/0xa0)
	[<c029af54>] (clk_core_prepare) from [<c029b790>] (clk_prepare+0x1c/0x30)
	[<c029b790>] (clk_prepare) from [<c02f1310>] (regmap_mmio_attach_clk+0x1c/0x24)
	[<c02f1310>] (regmap_mmio_attach_clk) from [<c02f7a98>] (of_syscon_register+0x218/0x268)
	[<c02f7a98>] (of_syscon_register) from [<c02f7b18>] (syscon_node_to_regmap+0x30/0x58)
	[<c02f7b18>] (syscon_node_to_regmap) from [<c07d2f7c>] (at91sam9x5_pmc_setup+0x78/0x430)
	[<c07d2f7c>] (at91sam9x5_pmc_setup) from [<c07cfe88>] (of_clk_init+0x188/0x21c)
	[<c07cfe88>] (of_clk_init) from [<c07c062c>] (time_init+0x1c/0x2c)
	[<c07c062c>] (time_init) from [<c07bcbec>] (start_kernel+0x2c4/0x474)
	[<c07bcbec>] (start_kernel) from [<00000000>] (0x0)
	bad: scheduling from the idle thread!
	CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.0-rc1+ #4
	Hardware name: Atmel AT91SAM9
	[<c000fc4c>] (unwind_backtrace) from [<c000d654>] (show_stack+0x10/0x18)
	[<c000d654>] (show_stack) from [<c059db74>] (dump_stack+0x18/0x24)
	[<c059db74>] (dump_stack) from [<c00386e8>] (dequeue_task_idle+0x1c/0x34)
	[<c00386e8>] (dequeue_task_idle) from [<c05b5818>] (__schedule+0x250/0x38c)
	[<c05b5818>] (__schedule) from [<c05b59e8>] (schedule+0x94/0xc8)
	[<c05b59e8>] (schedule) from [<c05b876c>] (schedule_hrtimeout_range_clock+0xf4/0x13c)
	[<c05b876c>] (schedule_hrtimeout_range_clock) from [<c05b87cc>] (schedule_hrtimeout_range+0x18/0x24)
	[<c05b87cc>] (schedule_hrtimeout_range) from [<c05b8240>] (usleep_range+0x70/0x98)
	[<c05b8240>] (usleep_range) from [<c02a18a0>] (clk_slow_rc_osc_prepare+0x28/0x34)
	[<c02a18a0>] (clk_slow_rc_osc_prepare) from [<c029af78>] (clk_core_prepare+0x84/0xa0)
	[<c029af78>] (clk_core_prepare) from [<c029af54>] (clk_core_prepare+0x60/0xa0)
	[<c029af54>] (clk_core_prepare) from [<c029b790>] (clk_prepare+0x1c/0x30)
	[<c029b790>] (clk_prepare) from [<c02f1310>] (regmap_mmio_attach_clk+0x1c/0x24)
	[<c02f1310>] (regmap_mmio_attach_clk) from [<c02f7a98>] (of_syscon_register+0x218/0x268)
	[<c02f7a98>] (of_syscon_register) from [<c02f7b18>] (syscon_node_to_regmap+0x30/0x58)
	[<c02f7b18>] (syscon_node_to_regmap) from [<c07d2f7c>] (at91sam9x5_pmc_setup+0x78/0x430)
	[<c07d2f7c>] (at91sam9x5_pmc_setup) from [<c07cfe88>] (of_clk_init+0x188/0x21c)
	[<c07cfe88>] (of_clk_init) from [<c07c062c>] (time_init+0x1c/0x2c)
	[<c07c062c>] (time_init) from [<c07bcbec>] (start_kernel+0x2c4/0x474)
	[<c07bcbec>] (start_kernel) from [<00000000>] (0x0)
	bad: scheduling from the idle thread!
	CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.0-rc1+ #4
	Hardware name: Atmel AT91SAM9
	...

The error message repeats without end. (I obviously didn't test until
the end :-), but after 10 minutes the machine still prints this message.)

With the old dtb Linux 5.3-rc1 boots just fine. I assume this is not
related to my dts or .config so I'm not attaching these here. If you're
interested I can provide them of course.

Best regards
Uwe

[1] https://www.acmesystems.it/arietta

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
