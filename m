Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B82C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFC27E12
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559565674;
	bh=purKlpevxX3/NR3bDCz6o1xMW5szM0zAXaiUthXoA0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bmekLzIvMaXS5pFslW+scyGb8WKlW4Lz1ZOKWTIJK9HrxP14YOKkVfRXBNfpuWHqK
	 1F0kRP5VfjmJ2oOMSmKy3ZlfBGOu4ehgD7tHe6IE82w3JHg6WBD/F9wu/Xc617pjV6
	 GXZYtMa2zRwYJPV4TmX10WQxNH70qbX8H3cpHC5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfFCMlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:41:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2D425FCC;
        Mon,  3 Jun 2019 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559565670;
        bh=purKlpevxX3/NR3bDCz6o1xMW5szM0zAXaiUthXoA0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oIZuSZQ3HNjdYL9Uax26ZKlLqdFY7cxDE9izwPcPzn2ztTWZIitCGV2cG+R/V6pjJ
         ZCEL/kr8yiiclHuZpXrYEwPjl0XjWFuPx8kCMZ3qTYzUwqX3ZBHVaJKuJnxVP0fhxN
         ieA70HfpZDhxDPP8uKjnGBl1lWvqfWrkQYucpfl8=
Date:   Mon, 3 Jun 2019 21:41:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing/kprobe: Add kprobe_event= boot parameter
Message-Id: <20190603214105.715a4072472ef4946123dc20@kernel.org>
In-Reply-To: <20190603205238.3cef1ef724bda35d11369ea7@kernel.org>
References: <155851393823.15728.9489409117921369593.stgit@devnote2>
        <155851395498.15728.830529496248543583.stgit@devnote2>
        <CADYN=9KHQPQTgy==TYZ5iD_zViPbHq4hgOUwuX69aQWV6vZOQg@mail.gmail.com>
        <20190528083629.3c100256@gandalf.local.home>
        <CADYN=9L2Lz9xgsP7jn3UNMOtAYtg6fAb1hbv=OJ_Xi4dA0Z5NQ@mail.gmail.com>
        <20190603205238.3cef1ef724bda35d11369ea7@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 20:52:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Anders,
> 
> Sorry for replying later.
> 
> On Tue, 28 May 2019 15:39:15 +0200
> Anders Roxell <anders.roxell@linaro.org> wrote:
> 
> > On Tue, 28 May 2019 at 14:36, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Tue, 28 May 2019 14:23:43 +0200
> > > Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > > On Wed, 22 May 2019 at 10:32, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > Add kprobe_event= boot parameter to define kprobe events
> > > > > at boot time.
> > > > > The definition syntax is similar to tracefs/kprobe_events
> > > > > interface, but use ',' and ';' instead of ' ' and '\n'
> > > > > respectively. e.g.
> > > > >
> > > > >   kprobe_event=p,vfs_read,$arg1,$arg2
> > > > >
> > > > > This puts a probe on vfs_read with argument1 and 2, and
> > > > > enable the new event.
> > > > >
> > > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > >
> > > > I built an arm64 kernel from todays linux-next tag next-20190528 and
> > > > ran in to this issue when I booted it up in qemu:
> 
> Thank you for reporting!
> 
> 
> > [    9.020354][    T1] Kprobe smoke test: started
> > [    9.064132][    T1] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP
> > [    9.067084][    T1] Modules linked in:
> > [    9.068772][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 5.2.0-rc2-next-20190528-00019-g9a6008710716 #8
> > [    9.072893][    T1] Hardware name: linux,dummy-virt (DT)
> > [    9.075143][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
> > [    9.077528][    T1] pc : kprobe_target+0x0/0x30
> > [    9.079479][    T1] lr : init_test_probes+0x134/0x540
> > [    9.081611][    T1] sp : ffff80003f51fbe0
> > [    9.083331][    T1] x29: ffff80003f51fbe0 x28: ffff200013c17820
> > [    9.085906][    T1] x27: ffff200015d3ab40 x26: ffff2000122bb120
> > [    9.088491][    T1] x25: 0000000000000000 x24: ffff200013c08ae0
> > [    9.091068][    T1] x23: ffff200015d39000 x22: ffff200013a15ac8
> > [    9.093667][    T1] x21: 1ffff00007ea3f86 x20: ffff200015d39420
> > [    9.096214][    T1] x19: ffff2000122bad20 x18: 0000000000001400
> > [    9.098831][    T1] x17: 0000000000000000 x16: ffff80003f510040
> > [    9.101410][    T1] x15: 0000000000001480 x14: 1ffff00007ea3ea2
> > [    9.103963][    T1] x13: 00000000f1f1f1f1 x12: ffff040002782e0d
> > [    9.106549][    T1] x11: 1fffe40002782e0c x10: ffff040002782e0c
> > [    9.109120][    T1] x9 : 1fffe40002782e0c x8 : dfff200000000000
> > [    9.111676][    T1] x7 : ffff040002782e0d x6 : ffff200013c17067
> > [    9.114234][    T1] x5 : ffff80003f510040 x4 : 0000000000000000
> > [    9.116843][    T1] x3 : ffff200010427508 x2 : 0000000000000000
> > [    9.119409][    T1] x1 : ffff200010426e10 x0 : 0000000000a6326b
> > [    9.121980][    T1] Call trace:
> > [    9.123380][    T1]  kprobe_target+0x0/0x30
> > [    9.125205][    T1]  init_kprobes+0x2b8/0x300
> > [    9.127074][    T1]  do_one_initcall+0x4c0/0xa68
> > [    9.129076][    T1]  kernel_init_freeable+0x3c4/0x4e4
> > [    9.131234][    T1]  kernel_init+0x14/0x1fc
> > [    9.133032][    T1]  ret_from_fork+0x10/0x18
> > [    9.134908][    T1] Code: a9446bf9 f9402bfb a8d87bfd d65f03c0 (d4200080)
> > [    9.137845][    T1] ---[ end trace 49243ee03446b072 ]---
> > [    9.140114][    T1] Kernel panic - not syncing: Fatal exception
> > [    9.142684][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Ah, I think you hit this in [1/2], not this change. 
> 
> I guess arm64's breakpoint handler is not initialized at postcore_initcall().
> I have to check the arch depend implementation on arm64.

Yes, for some reason, arm64 breakpoint handler vector is initalized in arch_initcall().
Let's move init_kprobes to subsys_initcall, which is called before fs_initcall.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
