Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F6C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1FB216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfGIQFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:05:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:32968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfGIQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:05:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 992D8AD07;
        Tue,  9 Jul 2019 16:05:30 +0000 (UTC)
Date:   Tue, 9 Jul 2019 18:05:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] watchdog/softlockup: Make softlockup reports more
 reliable and useful
Message-ID: <20190709160529.mp6l7mfulsqz4t6f@pathway.suse.cz>
References: <20190605140954.28471-1-pmladek@suse.com>
 <alpine.DEB.2.21.1906172307260.1963@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906172307260.1963@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-06-17 23:08:54, Thomas Gleixner wrote:
> On Wed, 5 Jun 2019, Petr Mladek wrote:
> 
> > Hi,
> > 
> > we were analyzing logs with several softlockup reports in flush_tlb_kernel_range().
> > They were confusing. Especially it was not clear whether it was deadlock,
> > livelock, or separate softlockups.
> > 
> > It went out that even a simple busy loop:
> > 
> > 	while (true)
> > 	      cpu_relax();
> > 
> > is able to produce several softlockups reports:
> > 
> > [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> > [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> > [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
> > 
> > 
> > I tried to understand the tricky watchdog code and produced two patches
> > that would be helpful to debug the original real bug:
> > 
> >    1st patch prevents restart of the watchdog from unrelated locations.
> > 
> >    2nd patch helps to distinguish several possible situations by
> >    regular reports.
> > 
> >    3rd patch can be used for testing the problem.
> > 
> > 
> > The watchdog code might deserve even more clean up. Anyway, I would
> > like to hear other's opinion first.
> 
> Anything which improves debugability is welcome. Unfortunately you missed
> to add an example of the output after these patches are applied.

After the 1st patch only one message is displayed. It is most likely
the original author expectation:

[  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]


But I think that more useful is to inform regularly that the problem
still exists. So after the 2nd patch we get:

[  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
[  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
[  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
[  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]


Note that the above lines always appear on the console because
they are printed with KERN_EMERG loglevel.

The log buffer contains more information:

[  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
[  480.374624] Modules linked in: livepatch_sample(EK)
[  480.375945] irq event stamp: 64036
[  480.376998] hardirqs last  enabled at (64035): [<ffffffffb7001ab0>] trace_hardirqs_on_thunk+0x1a/0x1c
[  480.379363] hardirqs last disabled at (64036): [<ffffffffb7001acc>] trace_hardirqs_off_thunk+0x1a/0x1c
[  480.381708] softirqs last  enabled at (64034): [<ffffffffb7e0034e>] __do_softirq+0x34e/0x3fd
[  480.383916] softirqs last disabled at (64027): [<ffffffffb714c430>] irq_exit+0xc0/0xd0
[  480.385956] CPU: 2 PID: 4943 Comm: cat Kdump: loaded Tainted: G            E K   5.2.0-rc2-default+ #4894
[  480.387898] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  480.390030] RIP: 0010:version_proc_show+0x3b/0x80
[  480.391428] Code: 48 89 fb 48 c7 c7 b0 54 36 b8 e8 83 8a dd ff c6 05 a1 ac 40 02 01 0f b6 05 9a ac 40 02 84 c0 74 0d f3 90 0f b6 05 8d ac 40 02 <84> c0 75 f3 65 48 8b 04 25 00 7f 01 00 48 8b 80 c8 0a 00 00 48 89
[  480.396442] RSP: 0018:ffffa78c407ffdf8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  480.398977] RAX: 0000000000000001 RBX: ffff973e77976b60 RCX: 0000000000000000
[  480.401441] RDX: 0000000000000000 RSI: ffff973e7bb18cd8 RDI: ffff973e7bb18cd8
[  480.403879] RBP: ffffa78c407ffe00 R08: 0000000000000000 R09: 0000000000000000
[  480.406331] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  480.408779] R13: ffffa78c407ffee8 R14: ffff973e72483600 R15: ffff973e77976b60
[  480.411212] FS:  00007f49c93a4700(0000) GS:ffff973e7bb00000(0000) knlGS:0000000000000000
[  480.413892] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  480.416004] CR2: 00007f49c920d008 CR3: 00000001378e2001 CR4: 00000000001606e0
[  480.418456] Call Trace:
[  480.419778]  seq_read+0xe2/0x3e0
[  480.421297]  proc_reg_read+0x3e/0x60
[  480.423122]  __vfs_read+0x1b/0x40
[  480.425014]  vfs_read+0x8e/0x130
[  480.426533]  ksys_read+0xaa/0xe0
[  480.428039]  ? lockdep_hardirqs_on+0xf6/0x190
[  480.429855]  __x64_sys_read+0x1a/0x20
[  480.431453]  do_syscall_64+0x55/0x1c0
[  480.433016]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  480.434919] RIP: 0033:0x7f49c8ed4270
[  480.436466] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 7f f7 08 00 e8 32 cb 01 00 66 90 83 3d f9 54 2c 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
[  480.442231] RSP: 002b:00007ffd49795a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  480.444760] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f49c8ed4270
[  480.447247] RDX: 0000000000020000 RSI: 00007f49c920e000 RDI: 0000000000000003
[  480.449696] RBP: 00007f49c920e000 R08: 00000000ffffffff R09: 0000000000000000
[  480.452168] R10: 000000007c9d4d41 R11: 0000000000000246 R12: 00007f49c920e000
[  480.454225] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
[  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
[  508.374581] Modules linked in: livepatch_sample(EK)
[  508.375866] irq event stamp: 135678
[  508.376930] hardirqs last  enabled at (135677): [<ffffffffb7001ab0>] trace_hardirqs_on_thunk+0x1a/0x1c
[  508.379066] hardirqs last disabled at (135678): [<ffffffffb7001acc>] trace_hardirqs_off_thunk+0x1a/0x1c
[  508.382676] softirqs last  enabled at (135676): [<ffffffffb7e0034e>] __do_softirq+0x34e/0x3fd
[  508.384705] softirqs last disabled at (135663): [<ffffffffb714c430>] irq_exit+0xc0/0xd0
[  508.386640] CPU: 2 PID: 4943 Comm: cat Kdump: loaded Tainted: G            ELK   5.2.0-rc2-default+ #4894
[  508.388819] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  508.391198] RIP: 0010:version_proc_show+0x3b/0x80
[  508.392555] Code: 48 89 fb 48 c7 c7 b0 54 36 b8 e8 83 8a dd ff c6 05 a1 ac 40 02 01 0f b6 05 9a ac 40 02 84 c0 74 0d f3 90 0f b6 05 8d ac 40 02 <84> c0 75 f3 65 48 8b 04 25 00 7f 01 00 48 8b 80 c8 0a 00 00 48 89
[  508.397427] RSP: 0018:ffffa78c407ffdf8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  508.399223] RAX: 0000000000000001 RBX: ffff973e77976b60 RCX: 0000000000000000
[  508.401122] RDX: 0000000000000000 RSI: ffff973e7bb18cd8 RDI: ffff973e7bb18cd8
[  508.403060] RBP: ffffa78c407ffe00 R08: 0000000000000000 R09: 0000000000000000
[  508.405002] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  508.406898] R13: ffffa78c407ffee8 R14: ffff973e72483600 R15: ffff973e77976b60
[  508.408662] FS:  00007f49c93a4700(0000) GS:ffff973e7bb00000(0000) knlGS:0000000000000000
[  508.410580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  508.412099] CR2: 00007f49c920d008 CR3: 00000001378e2001 CR4: 00000000001606e0
[  508.413861] Call Trace:
[  508.414834]  seq_read+0xe2/0x3e0
[  508.415918]  proc_reg_read+0x3e/0x60
[  508.417094]  __vfs_read+0x1b/0x40
[  508.418216]  vfs_read+0x8e/0x130
[  508.419297]  ksys_read+0xaa/0xe0
[  508.420390]  ? lockdep_hardirqs_on+0xf6/0x190
[  508.421667]  __x64_sys_read+0x1a/0x20
[  508.422798]  do_syscall_64+0x55/0x1c0
[  508.423931]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  508.425336] RIP: 0033:0x7f49c8ed4270
[  508.426478] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 7f f7 08 00 e8 32 cb 01 00 66 90 83 3d f9 54 2c 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
[  508.430666] RSP: 002b:00007ffd49795a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  508.432579] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f49c8ed4270
[  508.434360] RDX: 0000000000020000 RSI: 00007f49c920e000 RDI: 0000000000000003
[  508.436265] RBP: 00007f49c920e000 R08: 00000000ffffffff R09: 0000000000000000
[  508.438264] R10: 000000007c9d4d41 R11: 0000000000000246 R12: 00007f49c920e000
[  508.440233] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff


I believe that we could afford it every 26 seconds. They are
useful to distinguish hardlock from live-lock. They are limited
because the system either recovers or it has to get rebooted
anyway.

Best Regards,
Petr
