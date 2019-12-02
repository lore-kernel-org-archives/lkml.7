Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EFEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56732146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575251764;
	bh=kh/UNCAnqZyjo+76mnWesFmYTkQ1qMNTcBTJSiYYJnA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vPWlmIjye27gk/qVFTWpWn67ATnNNQ2BkdS5DMce6UIBmXL4jdLi/URowzy+1nG0K
	 y7VzTcEHk7bGGrooHAuL9Tcx8pLxUjxuOFZpbav7wwXAONcVeGQbphYqgvQd3uGxzk
	 fYjWSfvoJK8tiikjDGTR5TeGAdSnsb7y6oLxp3io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLBBzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 20:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfLBBzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 20:55:50 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AD42146E;
        Mon,  2 Dec 2019 01:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575251749;
        bh=kh/UNCAnqZyjo+76mnWesFmYTkQ1qMNTcBTJSiYYJnA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uqfy8dv240PcCOMhZ3muvYXvRhAjDN6Jdk5z9HuZcVY1WZGfrqT+UTbU3lJm5+5NH
         h8c2bhWoK25WFKdx8bSF7GTlPld3VJz2gnhE2jGICR3kELBdAxTfsl9rflsdTBP+cd
         IuhPfGFdwesrkaerfbfrox1dOw/Vlc7rL62EJ1zA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 042A7352278B; Sun,  1 Dec 2019 17:55:49 -0800 (PST)
Date:   Sun, 1 Dec 2019 17:55:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191202015548.GA13391@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129155850.GA17002@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 07:58:50AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 28, 2019 at 08:18:23AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 27, 2019 at 07:50:27AM -0800, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > And still -ENOREPRODUCE.  It did happen on this system with
> > hyperthreading, so the next step is to make rcutorture better tolerate
> > very large hyperthreaded systems and try again.
> 
> [ . . . ]
> 
> And hyperthreading seems to have done the trick!  One splat thus far,
> shown below.  The run should complete this evening, Pacific Time.

That was the only one for that run, but another 24*56-hour run got three
more.  All of them expected to be on CPU 0 (which never goes offline, so
why?) and the "XXX" diagnostic never did print.

							Thanx, Paul

------------------------------------------------------------------------
2019.11.29-20:46:36/TREE02.14/console.log
------------------------------------------------------------------------
[ 3570.209627] ------------[ cut here ]------------
[ 3570.211476] expected on cpu 0 but on cpu 1, pool 0, workfn=sync_rcu_exp_select_node_cpus
[ 3570.212721] WARNING: CPU: 1 PID: 4 at kernel/workqueue.c:2186 process_one_work+0x53b/0x550
[ 3570.213971] Modules linked in:
[ 3570.214471] CPU: 1 PID: 4 Comm: rcu_par_gp Not tainted 5.4.0-rc1+ #36
[ 3570.215469] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 3570.216760] Workqueue:  0x0 (rcu_par_gp)
[ 3570.217385] RIP: 0010:process_one_work+0x53b/0x550
[ 3570.218096] Code: 99 0f 0b eb d2 c6 05 3c dd 6d 01 01 65 8b 15 64 78 78 47 41 8b 4c 24 40 4c 8b 43 18 48 c7 c7 08 72 ac b9 31 c0 e8 55 08 fe ff <0f> 0b e9 53 fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41
[ 3570.220936] RSP: 0000:ffffb73c0002fe30 EFLAGS: 00010086
[ 3570.221740] RAX: 0000000000000000 RBX: ffffffffb9e65f68 RCX: ffffb73c0002fcdc
[ 3570.222880] RDX: 0000000000000002 RSI: ffffffffb9e627d8 RDI: 00000000ffffffff
[ 3570.224332] RBP: ffff98871ec95600 R08: 0000000000000001 R09: 0000000000000000
[ 3570.225418] R10: 5f7563725f636e79 R11: 656c65735f707865 R12: ffff98871f228a80
[ 3570.226507] R13: ffff98871f22d400 R14: 0000000000000000 R15: ffff98871ec95600
[ 3570.227595] FS:  0000000000000000(0000) GS:ffff98871f240000(0000) knlGS:0000000000000000
[ 3570.228827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3570.229716] CR2: 0000000000000148 CR3: 000000000521e000 CR4: 00000000000006e0
[ 3570.231199] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3570.233546] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3570.235793] Call Trace:
[ 3570.236223]  rescuer_thread+0x1b5/0x2e0
[ 3570.236807]  kthread+0xf3/0x130
[ 3570.237311]  ? worker_thread+0x3c0/0x3c0
[ 3570.237893]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[ 3570.238731]  ret_from_fork+0x35/0x40
[ 3570.239436] ---[ end trace 10a567590f676f64 ]---

------------------------------------------------------------------------
2019.11.29-20:46:36/TREE02.14/console.log
------------------------------------------------------------------------
[ 7611.377493] ------------[ cut here ]------------
[ 7611.379592] expected on cpu 0 but on cpu 5, pool 0, workfn=sync_rcu_exp_select_node_cpus
[ 7611.381178] WARNING: CPU: 5 PID: 4 at kernel/workqueue.c:2186 process_one_work+0x53b/0x550
[ 7611.382782] Modules linked in:
[ 7611.383423] CPU: 5 PID: 4 Comm: rcu_par_gp Not tainted 5.4.0-rc1+ #36
[ 7611.384851] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 7611.386482] Workqueue:  0x0 (rcu_par_gp)
[ 7611.387256] RIP: 0010:process_one_work+0x53b/0x550
[ 7611.388357] Code: 99 0f 0b eb d2 c6 05 3c dd 6d 01 01 65 8b 15 64 78 b8 55 41 8b 4c 24 40 4c 8b 43 18 48 c7 c7 08 72 6c ab 31 c0 e8 55 08 fe ff <0f> 0b e9 53 fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41
[ 7611.392663] RSP: 0000:ffffb4f54002fe30 EFLAGS: 00010086
[ 7611.393675] RAX: 0000000000000000 RBX: ffffffffaba65ba8 RCX: ffffb4f54002fcdc
[ 7611.395058] RDX: 0000000000000002 RSI: ffffffffaba627d8 RDI: 00000000ffffffff
[ 7611.396454] RBP: ffffa1941ec95600 R08: 0000000000000001 R09: 0000000000000000
[ 7611.397845] R10: 757063206e6f2074 R11: 7562203020757063 R12: ffffa1941f228a80
[ 7611.399209] R13: ffffa1941f22d400 R14: 0000000000000000 R15: ffffa1941ec95600
[ 7611.400584] FS:  0000000000000000(0000) GS:ffffa1941f340000(0000) knlGS:0000000000000000
[ 7611.402121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7611.403222] CR2: 0000000000000148 CR3: 000000001b61e000 CR4: 00000000000006e0
[ 7611.404844] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7611.406958] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 7611.408854] Call Trace:
[ 7611.409372]  rescuer_thread+0x1b5/0x2e0
[ 7611.410108]  kthread+0xf3/0x130
[ 7611.410720]  ? worker_thread+0x3c0/0x3c0
[ 7611.411482]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[ 7611.412525]  ret_from_fork+0x35/0x40
[ 7611.413234] ---[ end trace 63b5961f08d2230c ]---

------------------------------------------------------------------------
2019.11.29-20:46:36/TREE02.6/console.log
------------------------------------------------------------------------
[ 8656.713321] ------------[ cut here ]------------
[ 8656.717080] expected on cpu 0 but on cpu 1, pool 0, workfn=sync_rcu_exp_select_node_cpus
[ 8656.719854] WARNING: CPU: 1 PID: 4 at kernel/workqueue.c:2186 process_one_work+0x53b/0x550
[ 8656.722821] Modules linked in:
[ 8656.724024] CPU: 1 PID: 4 Comm: rcu_par_gp Not tainted 5.4.0-rc1+ #36
[ 8656.726108] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 8656.727973] Workqueue:  0x0 (rcu_par_gp)
[ 8656.728842] RIP: 0010:process_one_work+0x53b/0x550
[ 8656.729886] Code: 99 0f 0b eb d2 c6 05 3c dd 6d 01 01 65 8b 15 64 78 18 6b 41 8b 4c 24 40 4c 8b 43 18 48 c7 c7 08 72 0c 96 31 c0 e8 55 08 fe ff <0f> 0b e9 53 fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41
[ 8656.734413] RSP: 0000:ffffadf10002fe30 EFLAGS: 00010086
[ 8656.735467] RAX: 0000000000000000 RBX: ffffffff96465f68 RCX: ffffadf10002fcdc
[ 8656.737094] RDX: 0000000000000002 RSI: ffffffff964627d8 RDI: 00000000ffffffff
[ 8656.738657] RBP: ffff9bd09ec95600 R08: 0000000000000001 R09: 0000000000000000
[ 8656.740224] R10: 757063206e6f2074 R11: 7562203020757063 R12: ffff9bd09f228a80
[ 8656.741476] R13: ffff9bd09f22d400 R14: 0000000000000000 R15: ffff9bd09ec95600
[ 8656.742751] FS:  0000000000000000(0000) GS:ffff9bd09f240000(0000) knlGS:0000000000000000
[ 8656.745267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8656.747560] CR2: 0000000000000148 CR3: 0000000019e1e000 CR4: 00000000000006e0
[ 8656.750223] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8656.751797] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8656.753406] Call Trace:
[ 8656.753850]  rescuer_thread+0x1b5/0x2e0
[ 8656.754693]  kthread+0xf3/0x130
[ 8656.755270]  ? worker_thread+0x3c0/0x3c0
[ 8656.756119]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[ 8656.757273]  ret_from_fork+0x35/0x40
[ 8656.758086] ---[ end trace 2d4f67335fea1163 ]---
