Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E7C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB509208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559915938;
	bh=UN1+JuDr46Td//mWUs1uzPfcVkPQKEqdpiQGqoFI2wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9Dokz7dVjQY5OkJ1m8pQZsEj+DTl9EALIRdZed+aQmG76PcLly7bdcvbHnkMidBd
	 5lD6aWB9Tbg0cHR/toO/5NEgStq5YTVtbc07/fyf4Db48FJ0EEoHr9A9pXdRYdsB8z
	 PIe/QfcxNkd7s5AVAPtd1n1DeqHoTdELxvNfBBZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfFGN65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfFGN64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:58:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E283208E3;
        Fri,  7 Jun 2019 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559915936;
        bh=UN1+JuDr46Td//mWUs1uzPfcVkPQKEqdpiQGqoFI2wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKvxlVVoafzcNqxixcFGL7ZTlCkA25ogu60AA+xGBULRvIJB91LN1vaQITNEoTJvP
         ARqcjurF+0534q8J56KQxFVkZxgIG1lPWRWsEFUss97gl1LUWcrtpDxw+xEJfEfRi4
         BaMKetQ2tuPFdBGM9/3UHlroI4f95Icy+8DFHN8M=
Date:   Fri, 7 Jun 2019 15:58:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
Cc:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel patch  in USB 4.4.138 Version
Message-ID: <20190607135853.GB14665@kroah.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 08:23:37AM +0000, Varadarajan, Kiruthika wrote:
> Hi All,
>   During Cay Play session connect/disconnect several times,  with USB gadget driver I found kernel crash in rx_submit.
> 
> 
> 64.802125] CPU: 0 PID: 636 Comm: kworker/u8:2 Tainted: G U W O 4.4.71-quilt-2e5dc0ac-g0b463804d692-dirty #45
> [ 64.814092] Workqueue: uether process_rx_w
> [ 64.818675] task: ffff8800779c40c0 ti: ffff88007702c000 task.ti: ffff88007702c000
> [ 64.827040] RIP: 0010:[<ffffffff81736b6d>] [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0
> [ 64.835706] RSP: 0000:ffff88007702fd80 EFLAGS: 00010246
> [ 64.841642] RAX: 0000000000000000 RBX: ffff88006f2768c0 RCX: 0000000000000200
> [ 64.849617] RDX: 00000000000001fd RSI: ffffffff82081f71 RDI: 00000000ffffffff
> [ 64.857591] RBP: ffff88007702fdc8 R08: ffffc90000285000 R09: 0000000000000600
> [ 64.865566] R10: ffff88002ab99670 R11: 0000000000000f7a R12: 0000000000000002
> [ 64.873541] R13: ffff88006f2768f0 R14: 0000000000000600 R15: ffff88006bf6f118
> [ 64.881509] FS: 0000000000000000(0000) GS:ffff88007ac00000(0000) knlGS:0000000000000000
> [ 64.890545] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 64.896965] CR2: 00000000000000f0 CR3: 0000000065c99000 CR4: 00000000003406f0
> [ 64.904936] Last Branch Records:
> [ 64.908551] to: [<ffffffff81a50260>] page_fault+0x0/0x80
> [ 64.914787] from: [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0
> [ 64.921020] to: [<ffffffff81736b69>] rx_fill+0x1e9/0x3b0
> [ 64.927253] from: [<ffffffff81736b63>] rx_fill+0x1e3/0x3b0
> [ 64.933480] to: [<ffffffff81736b37>] rx_fill+0x1b7/0x3b0
> [ 64.939704] from: [<ffffffff811804bd>] printk+0x4f/0x50
> [ 64.945654] to: [<ffffffff811804b6>] printk+0x48/0x50
> [ 64.951588] from: [<ffffffff810ecb60>] vprintk_default+0x20/0x30
> [ 64.958403] to: [<ffffffff810ecb5f>] vprintk_default+0x1f/0x30
> [ 64.965219] from: [<ffffffff810ec64f>] vprintk_emit+0x16f/0x530
> [ 64.971941] to: [<ffffffff810ec641>] vprintk_emit+0x161/0x530
> [ 64.978653] from: [<ffffffff810ec752>] vprintk_emit+0x272/0x530
> [ 64.985383] to: [<ffffffff810ec752>] vprintk_emit+0x272/0x530
> [ 64.992116] from: [<ffffffff81001387>] restore+0xd/0x16
> [ 64.998059] to: [<ffffffff8100137a>] restore+0x0/0x16
> [ 65.003999] from: [<ffffffff81001364>] ___preempt_schedule+0x12/0x14
> [ 65.011205] to: [<ffffffff81001364>] ___preempt_schedule+0x12/0x14
> [ 65.018411] from: [<ffffffff81a47a60>] preempt_schedule+0x20/0x30
> [ 65.025324] to: [<ffffffff81a47a5f>] preempt_schedule+0x1f/0x30
> [ 65.032228] from: [<ffffffff81a47a33>] preempt_schedule_common+0x33/0x40
> [ 65.039835] to: [<ffffffff81a47a1f>] preempt_schedule_common+0x1f/0x40
> [ 65.047427] from: [<ffffffff81a471db>] __schedule+0x36b/0xb90
> [ 65.053952] to: [<ffffffff81a471bc>] __schedule+0x34c/0xb90
> [ 65.060478] from: [<ffffffff810c1326>] finish_task_switch+0xb6/0x210
> [ 65.067688] to: [<ffffffff810c12fb>] finish_task_switch+0x8b/0x210
> [ 65.074886] from: [<ffffffff81a4db3a>] _raw_spin_unlock_irq+0x2a/0x40
> [ 65.082190] to: [<ffffffff81a4db2e>] _raw_spin_unlock_irq+0x1e/0x40
> [ 65.089494] from: [<ffffffff810bde65>] preempt_count_sub+0x35/0xb0
> [ 65.096508] to: [<ffffffff810bde5b>] preempt_count_sub+0x2b/0xb0
> [ 65.103511] from: [<ffffffff810bdea5>] preempt_count_sub+0x75/0xb0
> [ 65.110517] to: [<ffffffff810bde9c>] preempt_count_sub+0x6c/0xb0
> [ 65.117522] from: [<ffffffff810bde59>] preempt_count_sub+0x29/0xb0
> [ 65.124530] to: [<ffffffff810bde30>] preempt_count_sub+0x0/0xb0
> [ 65.131444] from: [<ffffffff81a4db29>] _raw_spin_unlock_irq+0x19/0x40
> [ 65.138748] to: [<ffffffff81a4db23>] _raw_spin_unlock_irq+0x13/0x40
> [ 65.146052] from: [<ffffffff81155389>] trace_hardirqs_on+0x9/0xf0
> [ 65.152958] to: [<ffffffff81155380>] trace_hardirqs_on+0x0/0xf0
> [ 65.159872] from: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40
> [ 65.167065] to: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40
> [ 65.174257] from: [<ffffffff810e58cb>] do_raw_spin_unlock+0x4b/0xa0
> [ 65.181364] to: [<ffffffff810e5880>] do_raw_spin_unlock+0x0/0xa0
> [ 65.188372] from: [<ffffffff81a4db19>] _raw_spin_unlock_irq+0x9/0x40
> [ 65.195575] to: [<ffffffff81a4db10>] _raw_spin_unlock_irq+0x0/0x40
> [ 65.202776] from: [<ffffffff810c12f6>] finish_task_switch+0x86/0x210
> [ 65.209980] to: [<ffffffff810c1295>] finish_task_switch+0x25/0x210
> [ 65.217183] from: [<ffffffff813dec08>] debug_smp_processor_id+0x18/0x20
> [ 65.224676] to: [<ffffffff813dec07>] debug_smp_processor_id+0x17/0x20
> [ 65.232171] from: [<ffffffff813deb26>] check_preemption_disabled+0x26/0xf0
> [ 65.239952] to: [<ffffffff813deb00>] check_preemption_disabled+0x0/0xf0
> [ 65.247632] from: [<ffffffff813dec02>] debug_smp_processor_id+0x12/0x20
> [ 65.255124] to: [<ffffffff813debf0>] debug_smp_processor_id+0x0/0x20
> [ 65.262521] from: [<ffffffff810c1290>] finish_task_switch+0x20/0x210
> [ 65.269734] to: [<ffffffff810c1270>] finish_task_switch+0x0/0x210
> [ 65.276831] from: [<ffffffff81a471b7>] __schedule+0x347/0xb90
> [ 65.283353] to: [<ffffffff81a47184>] __schedule+0x314/0xb90
> [ 65.289871] from: [<ffffffff81003677>] __switch_to+0x297/0x5a0
> [ 65.296486] to: [<ffffffff81003666>] __switch_to+0x286/0x5a0
> [ 65.303092] from: [<ffffffff81003654>] __switch_to+0x274/0x5a0
> [ 65.309728] to: [<ffffffff81003610>] __switch_to+0x230/0x5a0
> [ 65.316352] from: [<ffffffff81003600>] __switch_to+0x220/0x5a0
> [ 65.322972] to: [<ffffffff810035d3>] __switch_to+0x1f3/0x5a0
> [ 65.329582] from: [<ffffffff810035c3>] __switch_to+0x1e3/0x5a0
> [ 65.336203] to: [<ffffffff81003525>] __switch_to+0x145/0x5a0
> [ 65.342821] from: [<ffffffff810034ce>] __switch_to+0xee/0x5a0
> [ 65.349343] Stack:
> [ 65.351585] 0000000000000286 ffff88006bd22548 024000c081a4dae8 ffff88006f276918
> [ 65.359856] 0000000000000000 0000000000000000 ffff88006f276938 ffff88006f2768c0
> [ 65.368143] ffff88006f2769a8 ffff88007702fe00 ffffffff81736f5f ffff88006f2769a8
> [ 65.376447] Call Trace:
> [ 65.379176] [<ffffffff81736f5f>] process_rx_w+0xcf/0x130
> [ 65.385213] [<ffffffff810b29aa>] process_one_work+0x14a/0x450
> [ 65.391736] [<ffffffff810b2fe6>] worker_thread+0x66/0x450
> [ 65.397868] [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0
> [ 65.404391] [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0
> [ 65.410911] [<ffffffff810b80ad>] kthread+0xfd/0x120
> [ 65.416456] [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
> [ 65.423755] [<ffffffff81a4e46f>] ret_from_fork+0x3f/0x70
> [ 65.429785] [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
> [ 65.437077] Code: 4c 89 c9 41 83 e9 01 4d 63 c9 4d 01 f1 4c 89 c8 48 f7 f1 8b 83 b0 00 00 00 49 29 d1 4d 89 ce 85 c0 74 04 4c 0f af f0 48 8b 43 18 <80> b8 f0 00 00 00 00 0f 85 78 01 00 00 48 8b 73 20 4c 89 f1 48
> [ 65.458462] RIP [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0
> [ 65.464493] RSP <ffff88007702fd80>
> [ 65.468388] CR2: 00000000000000f0
> [ 65.472090] ---[ end trace 5a9d1e73247ee2aa ]---
> [ 65.479952] Kernel panic - not syncing: Fatal exception
> [ 65.486167] intel_tasks_dumper: intel_task_panic_hndl: Skip tasks dumper.
> [ 65.493763] reboot: panic mode set: p,w
> [ 65.498045] Kernel Offset: disabled
> [ 65.509960] Rebooting in 10 seconds..
> 
> 
>   I have a patch and I would like to mainline the same patch.
>   Could you please review the same and provide your comments.

Please submit this in a format that we can apply it in.  We can't apply
patchs directly to the 4.4.y tree, they have to be backports from
Linus's tree only (read the stable kernel rules for details.)

Also, your patch referenced a git commit id that is not in Linus's tree,
and you do not need the Change-Id: line as well.

Please fix that up, and redo it against linux-next and resend and we
will be glad to review it.

thanks,

greg k-h
