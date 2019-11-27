Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F88C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE293206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taZFHodo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfK0GTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:19:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42998 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfK0GTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:19:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id i5so1985843pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 22:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVnLwY80c2ExsF07S2kiO5ycjnu/P5W6DtRoLT7Qr9c=;
        b=taZFHodoei/4QRNDF3ktNd11fzuPqd6pUM7Ic10pi/ICRoJEZ5A0/7wajri+2oRANu
         N0X0BFyoD4yV2cfPG39Bjt/I67fo7Jy2P1ymWZt5laD8mPQDg1r0Es56Iz78zfveTsGD
         tS3k3Nsu88XYnowcXIcCItKSsmP6gjonALC1G0KQG1UlschMT9x6ohV9/I9GpO6Bwsfn
         xEf5cfVTu75dWcuTAyGVqNw+w5gMjyySiO8bga6msiras3jdp06BUnyPdE7iIEJsAUxJ
         FHk4KBUrLSQItRbeRT7K4erFfUIJ7gL4+3e946liwKQfkHmchMTGmlFCzWPcJGzLeM21
         9L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVnLwY80c2ExsF07S2kiO5ycjnu/P5W6DtRoLT7Qr9c=;
        b=qtqfcsMnhJ9j/qkwJ/FXliomZZAstgXkve1lA9HIDLX7y+3AMN5lx1F2ELywAB3Qyw
         qZ8/rcvnYmvNgxO5afPWvhtEkyiOG062fraELTHmDxcE7x7ddqXw7+PVx4Lw647Dgll4
         8X9acpu7jJKxjXohpfY1W0RXd0P9Ay9OF8rx8FRR/qsBM0qCwNyI7vyt6USUgqwsO0xv
         7r+Q4Z6bWT9U3Ihw+zkns0ThhTlq1WpVOxheqf4+tFa1WoMf4MnSXpA85cpRa+u+XquJ
         LgDOO7qi7IDHkJZ3sB3cNJM/Viv1D6729X4MPziJQVwPE03ZGuTM/NeGuHsIEYHEvOyP
         gQGg==
X-Gm-Message-State: APjAAAXbFtWoBv/4RsXhkl0dBy39O3ic8bmdDmZ5+O4bPwcq8X9glA6D
        xJf9g01fYsBKdWQ5KcgDy966/V8l
X-Google-Smtp-Source: APXvYqw8793UoVWgmGF5RsKgjnpL5t9A7XhSeWveRxra7Ffj+oNU1vc46ZbQelFtTnfAH0WfiKoauQ==
X-Received: by 2002:a63:6fca:: with SMTP id k193mr2941225pgc.363.1574835554671;
        Tue, 26 Nov 2019 22:19:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d351])
        by smtp.gmail.com with ESMTPSA id w26sm15264713pfj.123.2019.11.26.22.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 22:19:13 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:19:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483422375.25881.13508326028469515760.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157483422375.25881.13508326028469515760.stgit@devnote2>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:57:04PM +0900, Masami Hiramatsu wrote:
> Fix to set unoptimized flag after confirming the code is completely
> unoptimized. Without this fix, when a kprobe hits the intermediate
> modified instruction (the first byte is replaced by int3, but
> latter bytes still be a jump address operand) while unoptimizing,
> it can return to the middle byte of the modified code. And it causes
> an invalid instruction exception in the kernel.
> 
> Usually, this is a rare case, but if we put a probe on the function
> called while text patching, it always causes a kernel panic as below.
> (text_poke() is used for patching the code in optprobe)
> 
>  # echo p text_poke+5 > kprobe_events
>  # echo 1 > events/kprobes/enable
>  # echo 0 > events/kprobes/enable
>  invalid opcode: 0000 [#1] PREEMPT SMP PTI
>  CPU: 7 PID: 137 Comm: kworker/7:1 Not tainted 5.4.0-rc8+ #29
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  Workqueue: events kprobe_optimizer
>  RIP: 0010:text_poke+0x9/0x50
>  Code: 01 00 00 5b 5d 41 5c 41 5d c3 89 c0 0f b7 4c 02 fe 66 89 4c 05 fe e9 31 ff ff ff e8 71 ac 03 00 90 55 48 89 f5 53 cc 30 cb fd <1e> ec 08 8b 05 72 98 31 01 85 c0 75 11 48 83 c4 08 48 89 ee 48 89
>  RSP: 0018:ffffc90000343df0 EFLAGS: 00010686
>  RAX: 0000000000000000 RBX: ffffffff81025796 RCX: 0000000000000000
>  RDX: 0000000000000004 RSI: ffff88807c983148 RDI: ffffffff81025796
>  RBP: ffff88807c983148 R08: 0000000000000001 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82284fe0
>  R13: ffff88807c983138 R14: ffffffff82284ff0 R15: 0ffff88807d9eee0
>  FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000058158b CR3: 000000007b372000 CR4: 00000000000006a0
>  Call Trace:
>   arch_unoptimize_kprobe+0x22/0x28
>   arch_unoptimize_kprobes+0x39/0x87
>   kprobe_optimizer+0x6e/0x290
>   process_one_work+0x2a0/0x610
>   worker_thread+0x28/0x3d0
>   ? process_one_work+0x610/0x610
>   kthread+0x10d/0x130
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x3a/0x50
>  Modules linked in:
>  ---[ end trace 83b34b22a228711b ]---
> 
> This can happen even if we blacklist text_poke() and other functions,
> because there is a small time window which showing the intermediate
> code to other CPUs.
> 
> Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Awesome. It fixes the crash for me.
Tested-by: Alexei Starovoitov <ast@kernel.org>

