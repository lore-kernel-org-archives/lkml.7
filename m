Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A790C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1974121D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="M5WPvNyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbfISN2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:28:15 -0400
Received: from first.geanix.com ([116.203.34.67]:40500 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388551AbfISN2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:28:14 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 7382D681E6;
        Thu, 19 Sep 2019 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568899688; bh=LxLOy5bS6bTw7GCC5DV/lEeFtPvqU59MmQl1lxDD9uU=;
        h=To:Cc:From:Subject:Date;
        b=M5WPvNyfcc5qstaASPir9Vm+L2+2qXpyWq/42YcODuhvmuzxW8OhE9lDTW2StCbKD
         rDaFU5r9+BJ+DFdpWU3ilhYW/sENAW2mla0A8fS6BfBgsx6s8rmUU5f+DyQrXrAmIr
         yoA8Wj2MKJdgy1cSW17e1oZHb/RjvW/qWAhakCwyNFh/wFkoxTHuZikNEySE+GindO
         wdHBuqZC8mDbyZkoVHH8wQ7PRxNQqGgI+PQ1XLmnTO6dq1tbNg3rO1aKKpDyAgMe39
         2ble5YznWiJJVkzjW12AtbLxOt0IXEchrMIw9TLsN4ouY5a05RSPWzsNzsH5Z5PP5/
         THehPvEdFA4Og==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Subject: [BUG] tty: n_gsm: possible circular locking dependency detected
Message-ID: <4b2455c0-25ba-0187-6df6-c63b4ccc6a6e@geanix.com>
Date:   Thu, 19 Sep 2019 15:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've come across the below lockdep report when using n_gsm multiplexing 
on an imx uart.

The inverted lock scenario caused by:
   1) the uart tx-ready interrupt causing the tty layer to call down 
into n_gsm, and
   2) n_gsm transmitting data, causing it to call up into the tty layer

We have about 2-3k devices running, and get the report from ~100 devices 
during a 1 hour span. But we haven't been able to reproduce locally.

The devices run 4.19.22 with my recent n_gsm patches backported.

Any hints on how to dig further are appreciated.

// Martin

[  201.633281] ======================================================
[  201.639473] WARNING: possible circular locking dependency detected
[  201.645667] 4.19.22 #1 Not tainted
[  201.649078] ------------------------------------------------------
[  201.655270] kworker/u2:0/7 is trying to acquire lock:
[  201.660337] a66ff7b8 (&(&gsm->tx_lock)->rlock){-.-.}, at: 
gsmld_write_wakeup+0x28/0x5c
[  201.668309]
[  201.668309] but task is already holding lock:
[  201.674155] 456c79ff (&port_lock_key){-.-.}, at: 
imx_uart_txint+0x18/0x198
[  201.681070]
[  201.681070] which lock already depends on the new lock.
[  201.681070]
[  201.689261]
[  201.689261] the existing dependency chain (in reverse order) is:
[  201.696754]
[  201.696754] -> #1 (&port_lock_key){-.-.}:
[  201.702282]        _raw_spin_lock_irqsave+0x40/0x54
[  201.707178]        uart_write_room+0x60/0xf8
[  201.711467]        tty_write_room+0x20/0x2c
[  201.715665]        gsmld_output+0x20/0x94
[  201.719690]        gsm_data_kick+0x80/0x164
[  201.723888]        __gsm_data_queue+0x188/0x1a4
[  201.728433]        gsm_control_transmit+0x78/0x8c
[  201.733151]        gsm_control_send+0x130/0x170
[  201.737693]        gsmld_ioctl+0x238/0x4f8
[  201.741805]        tty_ioctl+0x3a0/0xc44
[  201.745744]        do_vfs_ioctl+0xa8/0xa3c
[  201.749855]        ksys_ioctl+0x3c/0x68
[  201.753703]        sys_ioctl+0x10/0x14
[  201.757468]        ret_fast_syscall+0x0/0x28
[  201.761752]        0xbecd6ab4
[  201.764728]
[  201.764728] -> #0 (&(&gsm->tx_lock)->rlock){-.-.}:
[  201.771036]        lock_acquire+0xd0/0x1f4
[  201.775148]        _raw_spin_lock_irqsave+0x40/0x54
[  201.780042]        gsmld_write_wakeup+0x28/0x5c
[  201.784587]        tty_wakeup+0x58/0x64
[  201.788436]        tty_port_default_wakeup+0x1c/0x28
[  201.793412]        tty_port_tty_wakeup+0x18/0x1c
[  201.798043]        uart_write_wakeup+0x1c/0x24
[  201.802498]        imx_uart_txint+0x13c/0x198
[  201.806868]        imx_uart_int+0x100/0x1a4
[  201.811066]        __handle_irq_event_percpu+0x44/0x364
[  201.816302]        handle_irq_event_percpu+0x30/0x88
[  201.821279]        handle_irq_event+0x40/0x64
[  201.825652]        handle_fasteoi_irq+0xc4/0x174
[  201.830282]        generic_handle_irq+0x28/0x3c
[  201.834826]        __handle_domain_irq+0x6c/0xe8
[  201.839459]        gic_handle_irq+0x60/0xc4
[  201.843657]        __irq_svc+0x70/0x98
[  201.847421]        _raw_spin_unlock_irq+0x30/0x34
[  201.852141]        process_one_work+0x210/0x718
[  201.856686]        worker_thread+0x2c/0x54c
[  201.860881]        kthread+0x14c/0x164
[  201.864643]        ret_from_fork+0x14/0x20
[  201.868749]          (null)
[  201.871551]
[  201.871551] other info that might help us debug this:
[  201.871551]
[  201.879568]  Possible unsafe locking scenario:
[  201.879568]
[  201.885499]        CPU0                    CPU1
[  201.890038]        ----                    ----
[  201.894574]   lock(&port_lock_key);
[  201.898082]                                lock(&(&gsm->tx_lock)->rlock);
[  201.904890]                                lock(&port_lock_key);
[  201.910913]   lock(&(&gsm->tx_lock)->rlock);
[  201.915200]
[  201.915200]  *** DEADLOCK ***
[  201.915200]
[  201.921134] 2 locks held by kworker/u2:0/7:
[  201.925326]  #0: 456c79ff (&port_lock_key){-.-.}, at: 
imx_uart_txint+0x18/0x198
[  201.932683]  #1: e4c7457f (&tty->ldisc_sem){++++}, at: 
tty_ldisc_ref+0x1c/0x44
[  201.939948]
[  201.939948] stack backtrace:
[  201.944326] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 4.19.22 #1
[  201.950604] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[  201.956800] Workqueue: events_unbound flush_to_ldisc
[  201.961782] Backtrace:
[  201.964255] [<c010ebd4>] (dump_backtrace) from [<c010ef5c>] 
(show_stack+0x18/0x1c)
[  201.971840]  r7:00000000 r6:60030193 r5:00000000 r4:c0d7e300
[  201.977519] [<c010ef44>] (show_stack) from [<c0859d80>] 
(dump_stack+0xb4/0xec)
[  201.984760] [<c0859ccc>] (dump_stack) from [<c017bf80>] 
(print_circular_bug.constprop.15+0x264/0x328)
[  201.993996]  r10:c14e4e24 r9:00000000 r8:c8094b00 r7:c8095038 
r6:c1200718 r5:c11e2e38
[  202.001836]  r4:c1200718 r3:14127a92
[  202.005430] [<c017bd1c>] (print_circular_bug.constprop.15) from 
[<c017edec>] (__lock_acquire+0x14a8/0x1970)
[  202.015186]  r10:00000002 r9:c1491038 r8:c8094b00 r7:c1200718 
r6:c8094ff8 r5:00000001
[  202.023027]  r4:c1200718 r3:c8094ff8
[  202.026620] [<c017d944>] (__lock_acquire) from [<c017fc04>] 
(lock_acquire+0xd0/0x1f4)
[  202.034466]  r10:c0d08930 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c8ccd5ec
[  202.042303]  r4:60030193
[  202.044856] [<c017fb34>] (lock_acquire) from [<c0877fcc>] 
(_raw_spin_lock_irqsave+0x40/0x54)
[  202.053310]  r10:00000241 r9:00000015 r8:000000e3 r7:00030193 
r6:c04d434c r5:60030193
[  202.061148]  r4:c8ccd5dc
[  202.063704] [<c0877f8c>] (_raw_spin_lock_irqsave) from [<c04d434c>] 
(gsmld_write_wakeup+0x28/0x5c)
[  202.072674]  r6:00000fff r5:c8ccd5dc r4:c8ccd400
[  202.077313] [<c04d4324>] (gsmld_write_wakeup) from [<c04c46a8>] 
(tty_wakeup+0x58/0x64)
[  202.085244]  r7:00030193 r6:00000fff r5:c8d759c0 r4:c8ccdc00
[  202.090922] [<c04c4650>] (tty_wakeup) from [<c04cf0b0>] 
(tty_port_default_wakeup+0x1c/0x28)
[  202.099284]  r5:c82f0000 r4:c8ccdc00
[  202.102875] [<c04cf094>] (tty_port_default_wakeup) from [<c04cec68>] 
(tty_port_tty_wakeup+0x18/0x1c)
[  202.112018]  r5:c82f0000 r4:c8322440
[  202.115610] [<c04cec50>] (tty_port_tty_wakeup) from [<c04e9a88>] 
(uart_write_wakeup+0x1c/0x24)
[  202.124239] [<c04e9a6c>] (uart_write_wakeup) from [<c04ee3d4>] 
(imx_uart_txint+0x13c/0x198)
[  202.132605] [<c04ee298>] (imx_uart_txint) from [<c04ee530>] 
(imx_uart_int+0x100/0x1a4)
[  202.140538]  r9:00000015 r8:00000000 r7:00000000 r6:00000000 
r5:c8322440 r4:00002040
[  202.148299] [<c04ee430>] (imx_uart_int) from [<c018df68>] 
(__handle_irq_event_percpu+0x44/0x364)
[  202.157100]  r10:00000015 r9:c80b3da8 r8:00000001 r7:00000000 
r6:c0d08930 r5:c8158464
[  202.164941]  r4:c8343e40 r3:c04ee430
[  202.168534] [<c018df24>] (__handle_irq_event_percpu) from 
[<c018e2b8>] (handle_irq_event_percpu+0x30/0x88)
[  202.178203]  r10:c0d42038 r9:c8010400 r8:00000001 r7:00000000 
r6:c8158400 r5:c8158464
[  202.186042]  r4:c0d08908
[  202.188594] [<c018e288>] (handle_irq_event_percpu) from [<c018e350>] 
(handle_irq_event+0x40/0x64)
[  202.197477]  r6:c0d14f0c r5:c8158464 r4:c8158400
[  202.202114] [<c018e310>] (handle_irq_event) from [<c019201c>] 
(handle_fasteoi_irq+0xc4/0x174)
[  202.210652]  r7:00000000 r6:c0d14f0c r5:c8158464 r4:c8158400
[  202.216330] [<c0191f58>] (handle_fasteoi_irq) from [<c018d090>] 
(generic_handle_irq+0x28/0x3c)
[  202.224956]  r7:00000000 r6:c0d08d08 r5:00000015 r4:c0c8d128
[  202.230633] [<c018d068>] (generic_handle_irq) from [<c018d71c>] 
(__handle_domain_irq+0x6c/0xe8)
[  202.239350] [<c018d6b0>] (__handle_domain_irq) from [<c048a358>] 
(gic_handle_irq+0x60/0xc4)
[  202.247717]  r9:c80b3e80 r8:c0d08f34 r7:d080a000 r6:000003ff 
r5:000003eb r4:d080a00c
[  202.255478] [<c048a2f8>] (gic_handle_irq) from [<c0101a30>] 
(__irq_svc+0x70/0x98)
[  202.262972] Exception stack(0xc80b3e80 to 0xc80b3ec8)
[  202.268043] 3e80: 00000001 00000001 00000000 0000b51a c8010000 
c8028900 c8010000 c800f000
[  202.276238] 3ea0: c80b3f04 c82f0418 c8010000 c80b3ee4 00000000 
c80b3ed0 c017fe38 c087816c
[  202.284425] 3ec0: 20030113 ffffffff
[  202.287930]  r10:c8010000 r9:c80b2000 r8:c80b3f04 r7:c80b3eb4 
r6:ffffffff r5:20030113
[  202.295769]  r4:c087816c
[  202.298323] [<c087813c>] (_raw_spin_unlock_irq) from [<c014728c>] 
(process_one_work+0x210/0x718)
[  202.307122]  r5:c8028900 r4:c82f0414
[  202.310716] [<c014707c>] (process_one_work) from [<c01477c0>] 
(worker_thread+0x2c/0x54c)
[  202.318826]  r10:c8010000 r9:c0d05900 r8:00000088 r7:c8010034 
r6:c8010000 r5:c8028914
[  202.326666]  r4:c8028900
[  202.329216] [<c0147794>] (worker_thread) from [<c014e6c4>] 
(kthread+0x14c/0x164)
[  202.336628]  r10:c8099e40 r9:c0147794 r8:c8028900 r7:c80b2000 
r6:c8037fc0 r5:c8028980
[  202.344468]  r4:00000000 r3:00000000
[  202.348060] [<c014e578>] (kthread) from [<c01010b4>] 
(ret_from_fork+0x14/0x20)
[  202.355292] Exception stack(0xc80b3fb0 to 0xc80b3ff8)
[  202.360356] 3fa0:                                     00000000 
00000000 00000000 00000000
[  202.368549] 3fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[  202.376740] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  202.383369]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c014e578
[  202.391208]  r4:c8037fc0
