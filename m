Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D263C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503F021906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788128;
	bh=ndnVZThFnrsHfKpeo1GtWwshZV5PPDymC2h1oGnbKbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vak/CntNWpND4+aS4siJBKSXIwafI4JYfDmwUvGk1RxW90Pr6lUS+JbHqv+VDpwD1
	 uH7vwCUD5iyNfFLL5L5bpUWvno4nfifxWey5/N0A8E6oVQX16Q37X4daAdXYbdkvcF
	 rrqsRXQWscU8PVXpp1oYEjtceQbEi2fZSXYiO+kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfIRG2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbfIRG2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:28:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E737A21924;
        Wed, 18 Sep 2019 06:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788124;
        bh=ndnVZThFnrsHfKpeo1GtWwshZV5PPDymC2h1oGnbKbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cB3Lk9V07SUyTgHZ+IJG1KHS1oCwZZR053yVd2GFV3LYn8SO+d8F45Cl5pG8c2Sfr
         pw+SBpxT0b2GV6zTcBU7yhIard1WFpxoesyp2kxBuPfdbw9USMet4W2tBl4gt6DlHF
         QomjysMb9z6CTfQx6/lvYGMRAx17RqRyUKUNOqrQ=
Date:   Wed, 18 Sep 2019 15:28:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tracing/kprobe: Fix NULL pointer access in
 trace_porbe_unlink()
Message-Id: <20190918152840.fbbf3a874d09f0c8203c7148@kernel.org>
In-Reply-To: <20190917085643.26b86260@gandalf.local.home>
References: <0000000000003006220592b41c5b@google.com>
        <156869709721.22406.5153754822203046939.stgit@devnote2>
        <20190917085643.26b86260@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 08:56:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Sep 2019 14:11:37 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix NULL pointer access in trace_probe_unlink() by initializing
> > trace_probe.list correctly in trace_probe_init().
> > 
> > In the error case of trace_probe_init(), it can call trace_probe_unlink()
> > before initializing trace_probe.list member. This causes NULL pointer
> > dereference at list_del_init() in trace_probe_unlink().
> > 
> > Syzbot reported :
> > 
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 8633 Comm: syz-executor797 Not tainted 5.3.0-rc8-next-20190915
> > #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
> > Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00
> > 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75
> > 53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
> > RSP: 0018:ffff888090a7f9d8 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffff88809b6f90c0 RCX: ffffffff817c0ca9
> > RDX: 0000000000000000 RSI: ffffffff817c0a73 RDI: ffff88809b6f90c8
> > RBP: ffff888090a7f9f0 R08: ffff88809a04e600 R09: ffffed1015d26aed
> > R10: ffffed1015d26aec R11: ffff8880ae935763 R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff88809b6f90c0 R15: ffff88809b6f90d0
> > FS:  0000555556f99880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000006cc090 CR3: 00000000962b2000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   __list_del_entry include/linux/list.h:131 [inline]
> >   list_del_init include/linux/list.h:190 [inline]
> >   trace_probe_unlink+0x1f/0x200 kernel/trace/trace_probe.c:959
> >   trace_probe_cleanup+0xd3/0x110 kernel/trace/trace_probe.c:973
> >   trace_probe_init+0x3f2/0x510 kernel/trace/trace_probe.c:1011
> >   alloc_trace_uprobe+0x5e/0x250 kernel/trace/trace_uprobe.c:353
> >   create_local_trace_uprobe+0x109/0x4a0 kernel/trace/trace_uprobe.c:1508
> >   perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:314
> >   perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8898
> >   perf_try_init_event+0x135/0x590 kernel/events/core.c:10184
> >   perf_init_event kernel/events/core.c:10228 [inline]
> >   perf_event_alloc.part.0+0x1b89/0x33d0 kernel/events/core.c:10505
> >   perf_event_alloc kernel/events/core.c:10887 [inline]
> >   __do_sys_perf_event_open+0xa2d/0x2d00 kernel/events/core.c:10989
> >   __se_sys_perf_event_open kernel/events/core.c:10871 [inline]
> >   __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10871
> >   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > Reported-by: syzbot+2f807f4d3a2a4e87f18f@syzkaller.appspotmail.com
> > Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks Masami. I was just about to get my pull request to Linus out,
> but will now add this and start running my tests with it.

Thanks Steve, and sorry, I found another issue on multiprobe. I'll send it soon.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
