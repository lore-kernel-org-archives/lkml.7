Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5090AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DCE206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfIQOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:10:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfIQOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:10:46 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAEBg-0002Eq-J3; Tue, 17 Sep 2019 16:10:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAEBe-000378-Ri; Tue, 17 Sep 2019 16:10:34 +0200
Date:   Tue, 17 Sep 2019 16:10:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Regression in fd5f7cde1b85 ("printk: Never set console_may_schedule
 in console_trylock()")
Message-ID: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today it saw sysrq on an UART driven by drivers/tty/serial/imx.c report
a lockdep issue. Bisecting pointed to 

	fd5f7cde1b85 ("printk: Never set console_may_schedule in console_trylock()")

When I type <break>t I get:

[   87.940104] sysrq: SysRq : This sysrq operation is disabled.
[   87.948752] 
[   87.948772] ======================================================
[   87.948787] WARNING: possible circular locking dependency detected
[   87.948798] 4.14.0-12954-gfd5f7cde1b85 #26 Not tainted
[   87.948813] ------------------------------------------------------
[   87.948822] swapper/0 is trying to acquire lock:
[   87.948829]  (console_owner){-...}, at: [<c015e438>] console_unlock+0x110/0x598
[   87.948861] 
[   87.948869] but task is already holding lock:
[   87.948874]  (&port_lock_key){-.-.}, at: [<c048d5b0>] imx_rxint+0x2c/0x290
[   87.948902] 
[   87.948911] which lock already depends on the new lock.
[   87.948917] 
[   87.948923] 
[   87.948932] the existing dependency chain (in reverse order) is:
[   87.948938] 
[   87.948943] -> #1 (&port_lock_key){-.-.}:
[   87.948975]        _raw_spin_lock_irqsave+0x5c/0x70
[   87.948983]        imx_console_write+0x138/0x15c
[   87.948991]        console_unlock+0x204/0x598
[   87.949000]        register_console+0x21c/0x3e8
[   87.949008]        uart_add_one_port+0x3e4/0x4dc
[   87.949019]        platform_drv_probe+0x3c/0x78
[   87.949027]        driver_probe_device+0x25c/0x47c
[   87.949035]        __driver_attach+0xec/0x114
[   87.949044]        bus_for_each_dev+0x80/0xb0
[   87.949054]        bus_add_driver+0x1d4/0x264
[   87.949062]        driver_register+0x80/0xfc
[   87.949069]        imx_serial_init+0x28/0x48
[   87.949078]        do_one_initcall+0x44/0x18c
[   87.949087]        kernel_init_freeable+0x11c/0x1cc
[   87.949095]        kernel_init+0x10/0x114
[   87.949103]        ret_from_fork+0x14/0x30
[   87.949108] 
[   87.949113] -> #0 (console_owner){-...}:
[   87.949145]        lock_acquire+0x100/0x23c
[   87.949154]        console_unlock+0x1a4/0x598
[   87.949162]        vprintk_emit+0x1a4/0x45c
[   87.949171]        vprintk_default+0x28/0x30
[   87.949180]        printk+0x28/0x38
[   87.949189]        __handle_sysrq+0x1c4/0x244
[   87.949196]        imx_rxint+0x258/0x290
[   87.949206]        imx_int+0x170/0x178
[   87.949216]        __handle_irq_event_percpu+0x78/0x418
[   87.949225]        handle_irq_event_percpu+0x24/0x6c
[   87.949233]        handle_irq_event+0x40/0x64
[   87.949242]        handle_level_irq+0xb4/0x138
[   87.949252]        generic_handle_irq+0x28/0x3c
[   87.949261]        __handle_domain_irq+0x50/0xb0
[   87.949269]        avic_handle_irq+0x3c/0x5c
[   87.949277]        __irq_svc+0x6c/0xa4
[   87.949287]        arch_cpu_idle+0x30/0x40
[   87.949297]        arch_cpu_idle+0x30/0x40
[   87.949305]        do_idle+0xa0/0x104
[   87.949313]        cpu_startup_entry+0x14/0x18
[   87.949323]        start_kernel+0x30c/0x368
[   87.949328] 
[   87.949337] other info that might help us debug this:
[   87.949342] 
[   87.949351]  Possible unsafe locking scenario:
[   87.949356] 
[   87.949364]        CPU0                    CPU1
[   87.949372]        ----                    ----
[   87.949378]   lock(&port_lock_key);
[   87.949398]                                lock(console_owner);
[   87.949423]                                lock(&port_lock_key);
[   87.949441]   lock(console_owner);
[   87.949459] 
[   87.949466]  *** DEADLOCK ***
[   87.949471] 
[   87.949478] 3 locks held by swapper/0:
[   87.949484]  #0:  (&port_lock_key){-.-.}, at: [<c048d5b0>] imx_rxint+0x2c/0x290
[   87.949515]  #1:  (rcu_read_lock){....}, at: [<c0486ea8>] __handle_sysrq+0x0/0x244
[   87.949549]  #2:  (console_lock){+.+.}, at: [<c015ea58>] vprintk_emit+0x198/0x45c
[   87.949581] 
[   87.949588] stack backtrace:
[   87.949600] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-12954-gfd5f7cde1b85 #26
[   87.949611] Hardware name: Freescale i.MX25 (Device Tree Support)
[   87.949623] [<c0108f70>] (unwind_backtrace) from [<c010680c>] (show_stack+0x18/0x1c)
[   87.949635] [<c010680c>] (show_stack) from [<c01526ec>] (print_circular_bug+0x284/0x3c0)
[   87.949647] [<c01526ec>] (print_circular_bug) from [<c0153714>] (check_prev_add+0x4ac/0x7cc)
[   87.949660] [<c0153714>] (check_prev_add) from [<c015561c>] (__lock_acquire+0x9e8/0x13bc)
[   87.949671] [<c015561c>] (__lock_acquire) from [<c0156a28>] (lock_acquire+0x100/0x23c)
[   87.949683] [<c0156a28>] (lock_acquire) from [<c015e4cc>] (console_unlock+0x1a4/0x598)
[   87.949696] [<c015e4cc>] (console_unlock) from [<c015ea64>] (vprintk_emit+0x1a4/0x45c)
[   87.949707] [<c015ea64>] (vprintk_emit) from [<c015eec8>] (vprintk_default+0x28/0x30)
[   87.949719] [<c015eec8>] (vprintk_default) from [<c015fa80>] (printk+0x28/0x38)
[   87.949730] [<c015fa80>] (printk) from [<c048706c>] (__handle_sysrq+0x1c4/0x244)
[   87.949742] [<c048706c>] (__handle_sysrq) from [<c048d7dc>] (imx_rxint+0x258/0x290)
[   87.949753] [<c048d7dc>] (imx_rxint) from [<c048edd0>] (imx_int+0x170/0x178)
[   87.949765] [<c048edd0>] (imx_int) from [<c0160ce4>] (__handle_irq_event_percpu+0x78/0x418)
[   87.949781] [<c0160ce4>] (__handle_irq_event_percpu) from [<c01610a8>] (handle_irq_event_percpu+0x24/0x6c)
[   87.949794] [<c01610a8>] (handle_irq_event_percpu) from [<c0161130>] (handle_irq_event+0x40/0x64)
[   87.949808] [<c0161130>] (handle_irq_event) from [<c01642b4>] (handle_level_irq+0xb4/0x138)
[   87.949821] [<c01642b4>] (handle_level_irq) from [<c01602dc>] (generic_handle_irq+0x28/0x3c)
[   87.949833] [<c01602dc>] (generic_handle_irq) from [<c01608e4>] (__handle_domain_irq+0x50/0xb0)
[   87.949846] [<c01608e4>] (__handle_domain_irq) from [<c0101494>] (avic_handle_irq+0x3c/0x5c)
[   87.949857] [<c0101494>] (avic_handle_irq) from [<c01075ec>] (__irq_svc+0x6c/0xa4)
[   87.949866] Exception stack(0xc0c01f48 to 0xc0c01f90)
[   87.949879] 1f40:                   00000001 00000001 00000000 20000013 ffffe000 c0c078c8
[   87.949891] 1f60: c0c835aa c094ac0c c7eeca40 c0b3a920 00053177 00000000 00000000 c0c01f98
[   87.949900] 1f80: c01548b4 c01033bc 20000013 ffffffff
[   87.949911] [<c01075ec>] (__irq_svc) from [<c01033bc>] (arch_cpu_idle+0x30/0x40)
[   87.949922] [<c01033bc>] (arch_cpu_idle) from [<c014f09c>] (do_idle+0xa0/0x104)
[   87.949934] [<c014f09c>] (do_idle) from [<c014f448>] (cpu_startup_entry+0x14/0x18)
[   87.949946] [<c014f448>] (cpu_startup_entry) from [<c0b00c78>] (start_kernel+0x30c/0x368)

I didn't even try to understand that change, so for now you just get the
lockdep splat :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
