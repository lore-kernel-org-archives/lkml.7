Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E73C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575043133;
	bh=mrP+RsbyeCBxDzwf5oKg4eBj3eyp8fTCa+3VQDcNKdc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Rg4JE9+T9K/vCLItaUQArkayJDLT4GG/R5gYcpDeAPZSSmgyYaydSccPmdSoYDOoJ
	 n+5V8kDYitdec9YRvt21bvNKa0pywho0zOu7W7zEUH87zl4adVN+qhX4e2oAB2q5y9
	 o27uXKymwQ8PwPuB0wuZLTepfzhEG+tC+tIbYdug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2P6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfK2P6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:58:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453D020869;
        Fri, 29 Nov 2019 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575043131;
        bh=mrP+RsbyeCBxDzwf5oKg4eBj3eyp8fTCa+3VQDcNKdc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZmGw9mSv6JibX+BSwi4zQ6b79ohRQaJ2Ppjdeyioy4pWxbkwpma5Qkar8MJHWxqG8
         C1D4Tac0mDW4PAS0lj3qwCSH/RlB6SEUfJ/Kb7N1vKeEzkQg7nar700JPhDBJ3zyZ8
         oG+ogowItaPWZIOvVuC5BbKdKQiUXvVjcy5XWPcY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CD05735227A4; Fri, 29 Nov 2019 07:58:50 -0800 (PST)
Date:   Fri, 29 Nov 2019 07:58:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191129155850.GA17002@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128161823.GA24667@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:18:23AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 27, 2019 at 07:50:27AM -0800, Paul E. McKenney wrote:

[ . . . ]

> And still -ENOREPRODUCE.  It did happen on this system with
> hyperthreading, so the next step is to make rcutorture better tolerate
> very large hyperthreaded systems and try again.

[ . . . ]

And hyperthreading seems to have done the trick!  One splat thus far,
shown below.  The run should complete this evening, Pacific Time.

							Thanx, Paul

------------------------------------------------------------------------

[29139.777628] ------------[ cut here ]------------
[29139.779342] expected on cpu 0 but on cpu 2, pool 0, workfn=sync_rcu_exp_select_node_cpus
[29139.780564] WARNING: CPU: 2 PID: 4 at kernel/workqueue.c:2186 process_one_work+0x53b/0x550
[29139.781854] Modules linked in:
[29139.782376] CPU: 2 PID: 4 Comm: rcu_par_gp Not tainted 5.4.0-rc1+ #35
[29139.783418] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[29139.784701] Workqueue:  0x0 (rcu_par_gp)
[29139.785308] RIP: 0010:process_one_work+0x53b/0x550
[29139.786058] Code: 99 0f 0b eb d2 c6 05 3c dd 6d 01 01 65 8b 15 64 78 b8 74 41 8b 4c 24 40 4c 8b 43 18 48 c7 c7 08 72 6c 8c 31 c0 e8 55 08 fe ff <0f> 0b e9 53 fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41
[29139.788978] RSP: 0000:ffff91d7c002fe30 EFLAGS: 00010086
[29139.789766] RAX: 0000000000000000 RBX: ffffffff8ca65f68 RCX: ffff91d7c002fcdc
[29139.790851] RDX: 0000000000000002 RSI: ffffffff8ca627d8 RDI: 00000000ffffffff
[29139.791982] RBP: ffff8d369ec95600 R08: 0000000000000001 R09: 0000000000000000
[29139.793129] R10: 757063206e6f2074 R11: 7562203020757063 R12: ffff8d369f228a80
[29139.794219] R13: ffff8d369f22d400 R14: 0000000000000000 R15: ffff8d369ec95600
[29139.795316] FS:  0000000000000000(0000) GS:ffff8d369f280000(0000) knlGS:0000000000000000
[29139.796596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29139.797509] CR2: 0000000000000148 CR3: 000000001a81e000 CR4: 00000000000006e0
[29139.798625] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[29139.799752] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[29139.801185] Call Trace:
[29139.801765]  rescuer_thread+0x1b5/0x2e0
[29139.802544]  kthread+0xf3/0x130
[29139.803054]  ? worker_thread+0x3c0/0x3c0
[29139.803664]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[29139.804730]  ret_from_fork+0x35/0x40
[29139.805338] ---[ end trace a630d585ddfc6bd2 ]---
