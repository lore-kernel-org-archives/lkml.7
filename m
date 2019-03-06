Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746AC20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfCFLk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:40:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:40:28 -0500
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1UuP-0002Hh-OP; Wed, 06 Mar 2019 12:40:25 +0100
Date:   Wed, 6 Mar 2019 12:40:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: On reboot sometimes "sched: Unexpected reschedule of offline
 CPU#1!"
In-Reply-To: <CAHp75VcG4x29UvXrRAG0HSch97JaJagtUQiHx7APTNP3ta1n5g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903061240050.1646@nanos.tec.linutronix.de>
References: <CAHp75VcG4x29UvXrRAG0HSch97JaJagtUQiHx7APTNP3ta1n5g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Andy Shevchenko wrote:

CC+ PeterZ

> I have an Intel Merrifield platform where from time to time (don't
> know how to reproduce reliably) I have got a warning on reboot.
> 
> Requesting system reboot
> [   64.945973] reboot: Restarting system
> [   64.950770] reboot: machine restart
> [   64.955962] ------------[ cut here ]------------
> [   64.962601] sched: Unexpected reschedule of offline CPU#1!
> [   64.970144] WARNING: CPU: 0 PID: 22 at arch/x86/kernel/smp.c:128
> native_smp_send_reschedule+0x2f/0x40
> [   64.982429] Modules linked in: brcmfmac brcmutil mmc_block
> spi_pxa2xx_platform pwm_lpss_pci pwm_lpss spi_pxa2xx
> _pci sdhci_pci cqhci sdhci led_class intel_mrfld_pwrbtn
> intel_mrfld_adc extcon_intel_mrfld mmc_core mi0283qt mipi_
> dbi tinydrm backlight edt_ft5x06 ti_ads7950
> industrialio_triggered_buffer kfifo_buf intel_soc_pmic_mrfld hci_uart
> btbcm
> [   65.021950] CPU: 0 PID: 22 Comm: kworker/0:1 Tainted: G        W
>      5.0.0+ #271
> [   65.032718] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> BIOS 542 2015.01.21:18.19.48
> [   65.044541] Workqueue:            (null) (events)
> [   65.051259] RIP: 0010:native_smp_send_reschedule+0x2f/0x40
> [   65.058759] Code: 05 36 dc 53 01 73 15 48 8b 05 8d 30 2c 01 be fd
> 00 00 00 48 8b 40 30 e9 1f 33 dc 00 89 fe 48
> c7 c7 b0 fd e1 ac e8 18 4e 02 00 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 00 48 83 ec 10 48
> [   65.083627] RSP: 0000:ffff90f2fe003ed8 EFLAGS: 00010086
> [   65.090893] RAX: 0000000000000000 RBX: ffff90f2fdeba4c0 RCX: ffffffffad04cf98
> [   65.100085] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffffad71308c
> [   65.109278] RBP: 0000000000000000 R08: 00000000000003af R09: 00000000ad55ad55
> [   65.118471] R10: 0000000000000000 R11: 0000000000000002 R12: ffff9aaec024bd98
> [   65.127661] R13: ffff90f2fe01ba00 R14: ffffffffabce3a30 R15: ffff90f2fe01bb38
> [   65.136860] FS:  0000000000000000(0000) GS:ffff90f2fe000000(0000)
> knlGS:0000000000000000
> [   65.148010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.155823] CR2: 00000000000000b0 CR3: 00000000070c6000 CR4: 00000000001006f0
> [   65.165031] Call Trace:
> [   65.168522]  <IRQ>
> [   65.171574]  update_process_times+0x4a/0x60
> [   65.177800]  tick_sched_handle+0x34/0x40
> [   65.183751]  tick_sched_timer+0x32/0x70
> [   65.189615]  __hrtimer_run_queues+0xfb/0x280
> [   65.195911]  hrtimer_interrupt+0xfb/0x210
> [   65.201931]  smp_apic_timer_interrupt+0x5d/0x130
> [   65.208553]  apic_timer_interrupt+0xf/0x20
> [   65.214632]  </IRQ>
> [   65.217722] RIP: 0010:finish_task_switch+0x69/0x210
> [   65.224553] Code: 00 00 00 00 4d 8b 7d 10 65 4c 8b 34 25 40 4d 01
> 00 0f 1f 44 00 00 0f 1f 44 00 00 41 c7 45 38
> 00 00 00 00 c6 03 00 fb 4d 85 e4 <74> 1c 41 8b 84 24 78 03 00 00 a8 20
> 0f 85 0b 01 00 00 f0 41 ff 4c
> [   65.249209] RSP: 0000:ffff9aaec024be48 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff13
> [   65.259706] RAX: 0000000080000000 RBX: ffff90f2fe020900 RCX: 0000000000000000
> [   65.268817] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90f2fcd7e200
> [   65.277949] RBP: ffff9aaec024be70 R08: 00000000000000cf R09: ffff90f2fdeba540
> [   65.287090] R10: 0000000000000001 R11: 0000000000000006 R12: 0000000000000000
> [   65.296238] R13: ffff90f2fcd7e200 R14: ffff90f2fdeba4c0 R15: 0000000000000000
> [   65.305401]  __schedule+0x2c9/0x6b0
> [   65.309916]  ? _cond_resched+0x10/0x20
> [   65.315665]  schedule+0x23/0x70
> [   65.319825]  worker_thread+0xa4/0x3c0
> [   65.324502]  ? process_one_work+0x3f0/0x3f0
> [   65.330650]  kthread+0x10d/0x130
> [   65.334891]  ? kthread_create_on_node+0x60/0x60
> [   65.341415]  ret_from_fork+0x35/0x40
> [   65.345995] ---[ end trace 350a4f4eb4973887 ]---
> 
> Any ideas where to look / what possible a root cause?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
