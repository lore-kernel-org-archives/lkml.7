Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827E820733
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574722994;
	bh=V5myIoi+TkGF78Dq2cQKGEetssgdzrwL1cU7IB/74DI=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=QAEAZeLN5t5rzz7yGxbcJp/oSitPfPVcXOgoSssQsO9RKvT1615qsUmalrf3CVSZt
	 hHaMzY8jHVEd0w6XUdrQPSBkKMTKWcRTBt72Cp7oB9ZnxfYAhJMgxtvdu1gDNCUWc4
	 SliLTdL2B19j6WM6RVS/m4/QgB32tm+TNz+zfUTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKYXDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKYXDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:03:13 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8CF20733;
        Mon, 25 Nov 2019 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574722992;
        bh=V5myIoi+TkGF78Dq2cQKGEetssgdzrwL1cU7IB/74DI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TR4KUVPBCbIfN99ArwvHsc2FoU95ZOrzHGfNz5TeVAoriNm6VOnhyUmyhBrbzfG33
         uV2anc+e6O3hthYn5CWCmKVKfysZMd8FHZ0fCsBX/FFerapQaNEENbx8LhItbGnGWB
         zOpAO+0aXxgkFvJxEVwK/z+pSRgwwFSrZ7i5eyAQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64CA83522A71; Mon, 25 Nov 2019 15:03:12 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:03:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191125230312.GP2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am seeing this occasionally during rcutorture runs in the presence
of CPU hotplug.  This is on v5.4-rc1 in process_one_work() at the first
WARN_ON():

	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
		     raw_smp_processor_id() != pool->cpu);

What should I do to help further debug this?

							Thanx, Paul

------------------------------------------------------------------------

[ 7119.309435] WARNING: CPU: 1 PID: 4 at kernel/workqueue.c:2179 process_one_work+0x86/0x510
[ 7119.310449] Modules linked in:
[ 7119.310849] CPU: 1 PID: 4 Comm: rcu_par_gp Not tainted 5.4.0-rc1+ #21
[ 7119.311656] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 7119.312693] RIP: 0010:process_one_work+0x86/0x510
[ 7119.313250] Code: ee 05 48 89 44 24 10 48 8b 46 38 41 83 e6 01 41 f6 44 24 44 04 48 89 44 24 28 75 10 65 8b 05 39 7d 98 7b 41 3b 44 24 38 74 02 <0f> 0b 48 89 de 4c 89 e7 e8 7d cd ff ff 48 85 c0 0f 85 0e 04 00 00
[ 7119.315555] RSP: 0000:ffff9aba4002fe30 EFLAGS: 00010002
[ 7119.316189] RAX: 0000000000000001 RBX: ffffffff85c65f68 RCX: 0000000000000000
[ 7119.317064] RDX: ffff97a5df22d400 RSI: ffffffff85c65f68 RDI: ffff97a5dec95600
[ 7119.317943] RBP: ffff97a5dec95600 R08: ffffffff85c65f70 R09: ffffffff86856140
[ 7119.318812] R10: 0000000000000000 R11: 0000000000000001 R12: ffff97a5df228a80
[ 7119.319703] R13: ffff97a5df22d400 R14: 0000000000000000 R15: ffff97a5dec95600
[ 7119.320602] FS:  0000000000000000(0000) GS:ffff97a5df240000(0000) knlGS:0000000000000000
[ 7119.321581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7119.322301] CR2: 0000000000000148 CR3: 0000000015c1e000 CR4: 00000000000006e0
[ 7119.323188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7119.324069] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 7119.324957] Call Trace:
[ 7119.325288]  rescuer_thread+0x1b5/0x2e0
[ 7119.325772]  kthread+0xf3/0x130
[ 7119.326164]  ? worker_thread+0x3c0/0x3c0
[ 7119.326655]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[ 7119.327349]  ret_from_fork+0x35/0x40
[ 7119.327795] ---[ end trace 6dd6d520676d8e8e ]---
