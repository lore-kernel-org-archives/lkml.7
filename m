Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEAC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5132245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575602360;
	bh=IvFsybcgk9VKY9vT8ouRCJPM206U8D73GN+FePLFIq0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PGkMajvfy5xGSTobvU0dqkeS3gXDlup1/UWFOi37Bit8UR8YyxTKesOipyOHSywFb
	 OkM7e2pGApNpVhFeEchx5qt0r6cUeYU6qCP1nlnhyN63/Mc9XOB342zZN+p/J2sGzc
	 b1ybnPr9dTbGlV/9zQEyHbI5k3JL0F748v50HF84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFDTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLFDTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:19:18 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA19821823;
        Fri,  6 Dec 2019 03:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575602358;
        bh=IvFsybcgk9VKY9vT8ouRCJPM206U8D73GN+FePLFIq0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g1HeOuLiwDb1o9Sn85UDD/E04o+SSbXjCqKV6SWSw8Oxg2aIyejb4/c2iu9oAy1ey
         HHSFKABEplYua+U61hItNYdEZDlu8o8sJJo72rSLCpi1EuvPwLjuAZjY7+IvABi0Io
         MvxO5+E1PNb490vQuBxJSzO0h0lplh2rB/hd1AN8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BFB823522782; Thu,  5 Dec 2019 19:19:17 -0800 (PST)
Date:   Thu, 5 Dec 2019 19:19:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191206031917.GA7304@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
 <20191205144805.GR2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205144805.GR2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:48:05AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 05, 2019 at 11:32:13AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 05, 2019 at 11:29:28AM +0100, Peter Zijlstra wrote:
> > > On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:
> > > 
> > > > And the good news is that I didn't see the workqueue splat, though my
> > > > best guess is that I had about a 13% chance of not seeing it due to
> > > > random chance (and I am currently trying an idea that I hope will make
> > > > it more probable).  But I did get a couple of new complaints about RCU
> > > > being used illegally from an offline CPU.  Splats below.
> > > 
> > > Shiny!
> 
> And my attempt to speed things up did succeed, but the success was limited
> to finding more places where rcutorture chokes on CPUs being slow to boot.
> Fixing those and trying again...

And I finally got a clean run, so I am doing an overnight high-stress
baseline without your patch.  The hope is that this ups the probability
of occurrence such that I can get decent stats on your patch much more
quickly.

I got several more lockdep-RCU splats similar to the one I posted earlier.

I also got the following NULL-pointer dereference out of ACPI.  This had
surprisingly little effect on rcutorture, other than preventing it from
going down cleanly once the test had completed.  No idea whether it is
related, though the acpi_soft_cpu_online() in the stack trace makes me
suspect that it might be.

							Thanx, Paul

------------------------------------------------------------------------

[   97.122142] BUG: kernel NULL pointer dereference, address: 0000000000000028
[   97.224145] #PF: supervisor read access in kernel mode
[   97.301663] #PF: error_code(0x0000) - not-present page
[   97.376716] PGD 0 P4D 0 
[   97.413183] Oops: 0000 [#1] PREEMPT SMP PTI
[   97.472911] CPU: 1 PID: 13 Comm: cpuhp/1 Not tainted 5.4.0-rc1+ #124
[   97.562978] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[   97.684860] RIP: 0010:acpi_processor_get_platform_limit+0x5b/0xf0
[   97.772315] Code: 48 c7 c6 5b d6 71 a7 e8 d3 4c fc ff 83 f8 05 74 0b 85 c0 c6 05 21 7c 34 02 01 75 78 48 8b 04 24 48 8b 93 78 02 00 00 89 43 18 <8b> 4a 28 48 39 c8 73 2e 48 83 bb a0 03 00 00 00 74 24 48 8d 04 40
[   98.042953] RSP: 0000:ffffb4490007bdf8 EFLAGS: 00010246
[   98.118508] RAX: 0000000000000000 RBX: ffff8cf91ef09800 RCX: 0000000000000000
[   98.220612] RDX: 0000000000000000 RSI: ffff8cf91f32c910 RDI: 000000000002c910
[   98.322913] RBP: 00000000000000b3 R08: 0000000000000000 R09: 0000000000000000
[   98.423893] R10: 0000000000000001 R11: ffffb4490007bbe0 R12: ffff8cf91f316500
[   98.525024] R13: 0000000000000001 R14: ffffffffa68c1630 R15: 00000000000000cd
[   98.627690] FS:  0000000000000000(0000) GS:ffff8cf91f300000(0000) knlGS:0000000000000000
[   98.740706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.819911] CR2: 0000000000000028 CR3: 0000000010e1e000 CR4: 00000000000006e0
[   98.918566] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   99.017110] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   99.115445] Call Trace:
[   99.148986]  acpi_processor_ppc_has_changed+0x25/0x80
[   99.218892]  acpi_soft_cpu_online+0x4e/0xc0
[   99.276406]  cpuhp_invoke_callback+0xb5/0xa30
[   99.335921]  cpuhp_thread_fun+0x179/0x210
[   99.390697]  ? cpuhp_thread_fun+0x34/0x210
[   99.445818]  smpboot_thread_fn+0x169/0x240
[   99.501944]  kthread+0xf3/0x130
[   99.545137]  ? sort_range+0x20/0x20
[   99.592636]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[   99.665536]  ret_from_fork+0x3a/0x50
[   99.715131] Modules linked in:
[   99.755972] CR2: 0000000000000028
[   99.800216] ---[ end trace 4f464e92083c0f67 ]---
[   99.862848] RIP: 0010:acpi_processor_get_platform_limit+0x5b/0xf0
[   99.945285] Code: 48 c7 c6 5b d6 71 a7 e8 d3 4c fc ff 83 f8 05 74 0b 85 c0 c6 05 21 7c 34 02 01 75 78 48 8b 04 24 48 8b 93 78 02 00 00 89 43 18 <8b> 4a 28 48 39 c8 73 2e 48 83 bb a0 03 00 00 00 74 24 48 8d 04 40
  100.200302] RSP: 0000:ffffb4490007bdf8 EFLAGS: 00010246
[  100.268022] RAX: 0000000000000000 RBX: ffff8cf91ef09800 RCX: 0000000000000000
[  100.361897] RDX: 0000000000000000 RSI: ffff8cf91f32c910 RDI: 000000000002c910
[  100.454643] RBP: 00000000000000b3 R08: 0000000000000000 R09: 0000000000000000
[  100.548611] R10: 0000000000000001 R11: ffffb4490007bbe0 R12: ffff8cf91f316500
[  100.642858] R13: 0000000000000001 R14: ffffffffa68c1630 R15: 00000000000000cd
[  100.739082] FS:  0000000000000000(0000) GS:ffff8cf91f300000(0000) knlGS:0000000000000000
[  100.844924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.919117] CR2: 0000000000000028 CR3: 0000000010e1e000 CR4: 00000000000006e0
[  101.011402] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  101.105372] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
