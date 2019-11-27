Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E0C206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574837794;
	bh=kyXfm7AOEZ8Syg1jiA3cZuR2h8U5E3zuVBPHsT7+B1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sox7Sm3J0BEW/OxtjpctXCgpI8txL9c548b3JVlf/ZcLHm3lJCtJf16w7aIJsEDZJ
	 bHmRiTIgE3kxsM8AZEYuY+2/E30i+PQIfbLslhgupN2XpW6id1i/wUqLR7pTfXZOEK
	 LQtMyW9Snv0KfogK6eGYOeEnx6Xy+AayjQVOb4Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfK0G4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfK0G4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:56:32 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109E120665;
        Wed, 27 Nov 2019 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574837791;
        bh=kyXfm7AOEZ8Syg1jiA3cZuR2h8U5E3zuVBPHsT7+B1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lfnfzy4NPW0+4d6PcBHZS+myWitxFIrLLcDf67hUfyCKxlOrRdxZR28q2AOk41INa
         oObBqgvBH4swW6AijumXLgcGMCqdZ6lG1ubPEnglbXMNldJdFpiUjHRqlNKXNDapUe
         66V3dPiL6PFbqbeJXOUpQNbAT8gfQp7zVOy6h8+U=
Date:   Wed, 27 Nov 2019 15:56:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org
Subject: Re: [PATCH -tip 2/2] kprobes: Set unoptimized flag after
 unoptimizing code
Message-Id: <20191127155626.5386bc3a25195cfd0fa82a08@kernel.org>
In-Reply-To: <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
        <157483422375.25881.13508326028469515760.stgit@devnote2>
        <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 22:19:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Nov 27, 2019 at 02:57:04PM +0900, Masami Hiramatsu wrote:
> > Fix to set unoptimized flag after confirming the code is completely
> > unoptimized. Without this fix, when a kprobe hits the intermediate
> > modified instruction (the first byte is replaced by int3, but
> > latter bytes still be a jump address operand) while unoptimizing,
> > it can return to the middle byte of the modified code. And it causes
> > an invalid instruction exception in the kernel.
> > 
> > Usually, this is a rare case, but if we put a probe on the function
> > called while text patching, it always causes a kernel panic as below.
> > (text_poke() is used for patching the code in optprobe)
> > 
> >  # echo p text_poke+5 > kprobe_events
> >  # echo 1 > events/kprobes/enable
> >  # echo 0 > events/kprobes/enable
> >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >  CPU: 7 PID: 137 Comm: kworker/7:1 Not tainted 5.4.0-rc8+ #29
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> >  Workqueue: events kprobe_optimizer
> >  RIP: 0010:text_poke+0x9/0x50
> >  Code: 01 00 00 5b 5d 41 5c 41 5d c3 89 c0 0f b7 4c 02 fe 66 89 4c 05 fe e9 31 ff ff ff e8 71 ac 03 00 90 55 48 89 f5 53 cc 30 cb fd <1e> ec 08 8b 05 72 98 31 01 85 c0 75 11 48 83 c4 08 48 89 ee 48 89
> >  RSP: 0018:ffffc90000343df0 EFLAGS: 00010686
> >  RAX: 0000000000000000 RBX: ffffffff81025796 RCX: 0000000000000000
> >  RDX: 0000000000000004 RSI: ffff88807c983148 RDI: ffffffff81025796
> >  RBP: ffff88807c983148 R08: 0000000000000001 R09: 0000000000000000
> >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82284fe0
> >  R13: ffff88807c983138 R14: ffffffff82284ff0 R15: 0ffff88807d9eee0
> >  FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000000000058158b CR3: 000000007b372000 CR4: 00000000000006a0
> >  Call Trace:
> >   arch_unoptimize_kprobe+0x22/0x28
> >   arch_unoptimize_kprobes+0x39/0x87
> >   kprobe_optimizer+0x6e/0x290
> >   process_one_work+0x2a0/0x610
> >   worker_thread+0x28/0x3d0
> >   ? process_one_work+0x610/0x610
> >   kthread+0x10d/0x130
> >   ? kthread_park+0x80/0x80
> >   ret_from_fork+0x3a/0x50
> >  Modules linked in:
> >  ---[ end trace 83b34b22a228711b ]---
> > 
> > This can happen even if we blacklist text_poke() and other functions,
> > because there is a small time window which showing the intermediate
> > code to other CPUs.
> > 
> > Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Awesome. It fixes the crash for me.
> Tested-by: Alexei Starovoitov <ast@kernel.org>

That's a good news :)

Thank you for testing!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
