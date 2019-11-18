Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998C2186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nX8hO1n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRQoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:44:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52024 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfKRQoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:44:14 -0500
Received: from zn.tnic (p200300EC2F27B5003D22FC05E431AFF8.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:3d22:fc05:e431:aff8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30B521EC0BF8;
        Mon, 18 Nov 2019 17:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574095452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/12TPIe9NGWwR5n7WZI8L7PfOwYBBYIH7pXbgDhu9SQ=;
        b=nX8hO1n9TiQJmQk3YN4pu+9Q7ROF6hMYzRiK5UfaGZVbwxX5Kh/dW2z6ysTEvKlH/ty38Y
        RH1EJoXTbxdcZ/b/ms8o+UWiRIg89ZlwW+ZNI8jl5tT0wg6QHPog7knBtufZi2dyMy9gBu
        J80PVYYnZ6bujloAMn/I7SLI7xrpfJM=
Date:   Mon, 18 Nov 2019 17:44:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191118164407.GH6363@zn.tnic>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
 <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
 <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 05:29:42PM +0100, Dmitry Vyukov wrote:
> > And of not having a standard way to signal "this line starts something
> > that should be reported as a bug"? Maybe as a longer-term idea, it'd
> > help to have some sort of extra prefix byte that the kernel can print
> > to say "here comes a bug report, first line should be the subject", or
> > something like that, similar to how we have loglevels...
> 
> This would be great.
> Also a way to denote crash end.
> However we have lots of special logic for subjects, not sure if kernel
> could provide good subject:
> https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L537-L1588
> Probably it could, but it won't be completely trivial. E.g. if there
> is a stall inside of a timer function, it should give the name of the
> actual timer callback as identity ("stall in timer_subsystem_foo"). Or
> for syscalls we use more disambiguation b/c "in sys_ioclt" is not much
> different than saying "there is a bug in kernel" :)

While external tools are fine and cool, they can't really block kernel
development and printk strings format is not an ABI. And yeah, we have
this discussion each time someone proposes changes to those "magic"
strings but I guess it is about time to fix this in a way that any
future changes don't break tools.

And so I like the idea of marking *only* the first splat with some small
prefix char as that first splat is the special and very important one.
I.e., the one where die_counter is 0.

So I could very well imagine something like:

...
[    2.523708] Write protecting the kernel read-only data: 16384k
[    2.524729] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    2.525594] Freeing unused kernel image (rodata/data gap) memory: 368K
[    2.541414] x86/mm: Checked W+X mappings: passed, no W+X pages found.

<--- important first splat starts here:

[    2.542218] [*] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
[    2.543343] [*] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
[    2.544138] [*] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    2.545120] [*] RIP: 0010:kernel_init+0x58/0x107
[    2.546055] [*] Code: 48 c7 c7 e0 5c e7 81 e8 eb d2 90 ff c7 05 77 d6 95 00 02 00 00 00 e8 4e 1d a2 ff e8 69 b7 91 ff 48 b8 01 00 00 00 00 00 ff df <ff> e0 48 8b 3d fe 54 d7 00 48 85 ff 74 22 e8 76 93 84 ff 85 c0 89
[    2.550242] [*] RSP: 0018:ffffc90000013f50 EFLAGS: 00010246
[    2.551691] [*] RAX: dfff000000000001 RBX: ffffffff817b7ac9 RCX: 0000000000000040
[    2.553435] [*] RDX: 0000000000000030 RSI: ffff88807da2f170 RDI: 000000000002f170
[    2.555169] [*] RBP: 0000000000000000 R08: 00000000000001a6 R09: 00000000ad55ad55
[    2.556393] [*] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
[    2.557268] [*] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.558417] [*] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    2.559370] [*] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.560138] [*] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406f0
[    2.561013] [*] Call Trace:
[    2.561506] [*]  ret_from_fork+0x22/0x40
[    2.562080] [*] Modules linked in:
[    2.583706] [*] ---[ end trace 8ceb5a62d3ebbfa6 ]---
[    2.584384] [*] RIP: 0010:kernel_init+0x58/0x107
[    2.584999] [*] Code: 48 c7 c7 e0 5c e7 81 e8 eb d2 90 ff c7 05 77 d6 95 00 02 00 00 00 e8 4e 1d a2 ff e8 69 b7 91 ff 48 b8 01 00 00 00 00 00 ff df <ff> e0 48 8b 3d fe 54 d7 00 48 85 ff 74 22 e8 76 93 84 ff 85 c0 89
[    2.591746] [*] RSP: 0018:ffffc90000013f50 EFLAGS: 00010246
[    2.593175] [*] RAX: dfff000000000001 RBX: ffffffff817b7ac9 RCX: 0000000000000040
[    2.594892] [*] RDX: 0000000000000030 RSI: ffff88807da2f170 RDI: 000000000002f170
[    2.599706] [*] RBP: 0000000000000000 R08: 00000000000001a6 R09: 00000000ad55ad55
[    2.600585] [*] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
[    2.601433] [*] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.602283] [*] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    2.603207] [*] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.607706] [*] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406f0
[    2.608565] [*] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.609600] [*] Kernel Offset: disabled
[    2.610168] [*] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

<--- and ends here.

to denote that first splat. And the '*' thing is just an example - it
can be any char - whatever's easier to grep for.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
