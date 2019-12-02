Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5F206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZd1rysi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLBVz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:55:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35107 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfLBVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:55:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so1314848lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8VPfgs8EtF9ws16P6RG86MCdjgDEUTvyqD2NPSMYto=;
        b=OZd1rysiy4jFHHOTRTgXgZs3lS1Lhgz0q37iEw7HZRqkFdQloV9nTt3R/XAam+7YhW
         ya2GeXy63to+6kVt3BSXom+hM/WKwzLk1NvyldRsOXHm2zeUr5tWJgQePV8pjedmQlN3
         LE9b6zhvp1nmtF+JPMhFktnwU/1AcHLOLKuRohUSt/vwqgp6klt8qyB2qYRUsj9bsDYb
         ZTdaT7pJlt/O1s/rTy927/gWoIJWo/BzW7QsPGL6Y8KJYw+tQZQgDKGglzgpkCRlUCeF
         jAaeRd7XdnV1oIPgM8SLFZ/gD2Hz1lx1a20XY2qIv5ONTwmIx9HE8/lv90nU61ETE69P
         dybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8VPfgs8EtF9ws16P6RG86MCdjgDEUTvyqD2NPSMYto=;
        b=c+CrMjeO76rufeRvRjzKbQzWWJZvkYv50spmT6UcvupYB92sE6BX8h3EeXBz1497mj
         vQFVKCQw/wmmxLGu/UCkXblS1EoDh1FA6xri1WnkuMnTPqbufkTL4ZvcIarknvVmY3B0
         U/owAvCgGnBterRHfiBEFagWm465J3NCGJOMAzlAxNxuWPWLwHs6+R4J94k7+rxUe136
         blyKu0adQiUicqzgIb3Dr78mHrXo//uHn42cJdZTcVD9V+6+XTWfGGM6ds2NjuPJMZxX
         DoUvEGFruuvkTVuV/ib+pJdv6LOVEOKYffZXiOWH4tgaiE0mLksnAe4HdHuCcMFp5wdB
         EyhA==
X-Gm-Message-State: APjAAAVEXgWFsnrCdeKEnP5bIeR6yaZArOntw5KXJ2F7QXXMghGRTIQ6
        jNhe/awIJM1LeDaVSIm/bGm0Gy0ztkxuMcPZiRA=
X-Google-Smtp-Source: APXvYqxa0qMeSE/+uePTOBBk3fqqhRihvAdxYqnCN4yP9asZ63700puy70Azc+T+T8ymEDB2z5zMui5cw7CttIA5vX8=
X-Received: by 2002:a2e:999a:: with SMTP id w26mr598071lji.142.1575323723684;
 Mon, 02 Dec 2019 13:55:23 -0800 (PST)
MIME-Version: 1.0
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483422375.25881.13508326028469515760.stgit@devnote2> <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
 <20191127064904.GA52731@gmail.com>
In-Reply-To: <20191127064904.GA52731@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 2 Dec 2019 13:55:12 -0800
Message-ID: <CAADnVQ+uJ5sWtC18HZATDkfrtUcsKNoTrQ_5SRr7mmU8ziEC9w@mail.gmail.com>
Subject: Re: [PATCH -tip 2/2] kprobes: Set unoptimized flag after unoptimizing code
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        bristot <bristot@redhat.com>, jbaron@akamai.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:49 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Wed, Nov 27, 2019 at 02:57:04PM +0900, Masami Hiramatsu wrote:
> > > Fix to set unoptimized flag after confirming the code is completely
> > > unoptimized. Without this fix, when a kprobe hits the intermediate
> > > modified instruction (the first byte is replaced by int3, but
> > > latter bytes still be a jump address operand) while unoptimizing,
> > > it can return to the middle byte of the modified code. And it causes
> > > an invalid instruction exception in the kernel.
> > >
> > > Usually, this is a rare case, but if we put a probe on the function
> > > called while text patching, it always causes a kernel panic as below.
> > > (text_poke() is used for patching the code in optprobe)
> > >
> > >  # echo p text_poke+5 > kprobe_events
> > >  # echo 1 > events/kprobes/enable
> > >  # echo 0 > events/kprobes/enable
> > >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > >  CPU: 7 PID: 137 Comm: kworker/7:1 Not tainted 5.4.0-rc8+ #29
> > >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > >  Workqueue: events kprobe_optimizer
> > >  RIP: 0010:text_poke+0x9/0x50
> > >  Code: 01 00 00 5b 5d 41 5c 41 5d c3 89 c0 0f b7 4c 02 fe 66 89 4c 05 fe e9 31 ff ff ff e8 71 ac 03 00 90 55 48 89 f5 53 cc 30 cb fd <1e> ec 08 8b 05 72 98 31 01 85 c0 75 11 48 83 c4 08 48 89 ee 48 89
> > >  RSP: 0018:ffffc90000343df0 EFLAGS: 00010686
> > >  RAX: 0000000000000000 RBX: ffffffff81025796 RCX: 0000000000000000
> > >  RDX: 0000000000000004 RSI: ffff88807c983148 RDI: ffffffff81025796
> > >  RBP: ffff88807c983148 R08: 0000000000000001 R09: 0000000000000000
> > >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82284fe0
> > >  R13: ffff88807c983138 R14: ffffffff82284ff0 R15: 0ffff88807d9eee0
> > >  FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 000000000058158b CR3: 000000007b372000 CR4: 00000000000006a0
> > >  Call Trace:
> > >   arch_unoptimize_kprobe+0x22/0x28
> > >   arch_unoptimize_kprobes+0x39/0x87
> > >   kprobe_optimizer+0x6e/0x290
> > >   process_one_work+0x2a0/0x610
> > >   worker_thread+0x28/0x3d0
> > >   ? process_one_work+0x610/0x610
> > >   kthread+0x10d/0x130
> > >   ? kthread_park+0x80/0x80
> > >   ret_from_fork+0x3a/0x50
> > >  Modules linked in:
> > >  ---[ end trace 83b34b22a228711b ]---
> > >
> > > This can happen even if we blacklist text_poke() and other functions,
> > > because there is a small time window which showing the intermediate
> > > code to other CPUs.
> > >
> > > Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Awesome. It fixes the crash for me.
> > Tested-by: Alexei Starovoitov <ast@kernel.org>
>
> Thanks guys - I just pushed out a rebased tree, based on an upstream
> version that has both the BPF tree and most x86 trees merged, into
> tip:WIP.core/kprobes. This includes these two fixes as well.

fwiw. I merged WIP.core/kprobes into my local tree and have been
testing everything with it. No issues found.
