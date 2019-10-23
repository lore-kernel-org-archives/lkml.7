Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C08CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143C21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbfJWSwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389636AbfJWSwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:52:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A75F2086D;
        Wed, 23 Oct 2019 18:52:46 +0000 (UTC)
Date:   Wed, 23 Oct 2019 14:52:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191023145245.53c75d70@gandalf.local.home>
In-Reply-To: <20191022202401.GO1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
        <20191018074634.801435443@infradead.org>
        <20191021222110.49044eb5@oasis.local.home>
        <20191022202401.GO1817@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 22:24:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 21, 2019 at 10:21:10PM -0400, Steven Rostedt wrote:
> > On Fri, 18 Oct 2019 09:35:40 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > Now that set_all_modules_text_*() is gone, nothing depends on the
> > > relation between ->state = COMING and the protection state anymore.
> > > This enables moving the protection changes later, such that the COMING
> > > notifier callbacks can more easily modify the text.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > ---  
> > 
> > This triggered the following bug:
> >   
> 
> > The trace_event_define_fields_<event>() is defined in
> > include/trace/trace_events.h and is an init function called by the
> > trace_events event_create_dir() via the module notifier:
> > MODULE_STATE_COMING  
> 
> The below seems to cure it; and seems to generate identical
> events/*/format output (for my .config, with the exception of ID).
> 
> It has just one section mismatch report that I'm too tired to look at
> just now.
> 
> I'm not particularly proud of the "__function__" hack, but it works :/ I
> couldn't come up with anything else for [uk]probes which seem to have
> dynamic fields and if we're having it then syscall_enter can also make
> use of it, the syscall_metadata crud was going to be ugly otherwise.
> 
> (also, win on LOC)
> 
>

After applying this series and this patch I triggered this:

[ 1397.281889] BUG: kernel NULL pointer dereference, address: 0000000000000001
[ 1397.288896] #PF: supervisor read access in kernel mode
[ 1397.294062] #PF: error_code(0x0000) - not-present page
[ 1397.299192] PGD 0 P4D 0 
[ 1397.301728] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1397.305908] CPU: 7 PID: 4252 Comm: ftracetest Not tainted 5.4.0-rc3-test+ #132
[ 1397.313114] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[ 1397.322056] RIP: 0010:event_create_dir+0x26a/0x520
[ 1397.326841] Code: ff ff 5a 85 c0 75 37 44 03 7b 10 48 83 c3 20 4c 8b 13 4d 85 d2 0f 84 66 fe ff ff b9 0d 00 00 00 4c 89 d6 4c 89 f7 48 8b 53 08 <f3> a6 0f 97 c1 80 d9 00 84 c9 75 a5 48 89 ef e8 b2 d4 a3 00 85 c0
[ 1397.345558] RSP: 0018:ffffc90000a63d18 EFLAGS: 00010202
[ 1397.350775] RAX: 0000000000000000 RBX: ffffc90000a63d80 RCX: 000000000000000d
[ 1397.357893] RDX: ffffffff811ccfac RSI: 0000000000000001 RDI: ffffffff8207c68a
[ 1397.365006] RBP: ffff888114b1c750 R08: 0000000000000000 R09: ffff8881147561b0
[ 1397.372119] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880b1d80528
[ 1397.379243] R13: ffff88811189aeb0 R14: ffffffff8207c68a R15: 00000000811d2d22
[ 1397.386365] FS:  00007f2567213740(0000) GS:ffff88811a9c0000(0000) knlGS:0000000000000000
[ 1397.394437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1397.400174] CR2: 0000000000000001 CR3: 00000000b1f06005 CR4: 00000000001606e0
[ 1397.407297] Call Trace:
[ 1397.409753]  trace_add_event_call+0x6c/0xb0
[ 1397.413938]  trace_probe_register_event_call+0x22/0x50
[ 1397.419071]  trace_kprobe_create+0x65c/0xa20
[ 1397.423340]  ? argv_split+0x99/0x130
[ 1397.426913]  ? __kmalloc+0x1d4/0x2c0
[ 1397.430485]  ? trace_kprobe_create+0xa20/0xa20
[ 1397.434922]  ? trace_kprobe_create+0xa20/0xa20
[ 1397.439361]  create_or_delete_trace_kprobe+0xd/0x30
[ 1397.444237]  trace_run_command+0x72/0x90
[ 1397.448158]  trace_parse_run_command+0xaf/0x131
[ 1397.452684]  vfs_write+0xa5/0x1a0
[ 1397.455996]  ksys_write+0x5c/0xd0
[ 1397.459312]  do_syscall_64+0x48/0x120
[ 1397.462971]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1397.468017] RIP: 0033:0x7f2567303ff8

By running tools/selftests/ftrace/ftracetest

Crashed here:

[33] Kprobe dynamic event - adding and removing	[PASS]
[34] Kprobe dynamic event - busy event check	[PASS]
[35] Kprobe event with comm arguments	[FAIL]
[36] Kprobe event string type argumentclient_loop:

-- Steve
