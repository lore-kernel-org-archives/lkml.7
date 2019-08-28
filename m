Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E6EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8922CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567001688;
	bh=P8gtf0Qo++u6nd4xNtlN18En0UpTSf2d/9hcpJbUkbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lMMDMweWg7sr9GuCmHJsS4jojbYBU/u5n0IIh0cWHu+3YEdLDdNfaQTXEElaFVl1R
	 fMkYZ8xi9o2jSvDpmhK06Wc4y2mnr3ZqCIjc0m61f+tDNhWEKQvE61U31ZRpnbSesQ
	 35AWNeBSNc80D2crwRbjHQm8mNCcRS8kHBpUvK9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1OOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1OOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:14:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B52D2189D;
        Wed, 28 Aug 2019 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567001684;
        bh=P8gtf0Qo++u6nd4xNtlN18En0UpTSf2d/9hcpJbUkbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHxhyGFRcb4kdBEdhVJmQ6nhb4KpdyMmysZ/i/NqjnMJInIXbxvpYhsOto3U0bB2e
         haS+d6dRjRF7nz6jk8/xw3NVjlEtLvVEa0WpcAWPGwj0W/rY5msjlunhn8pRL9CyZj
         sRGuYqsNzS10g6TeaCx0p+LaW13VujVbZ55MDrPQ=
Date:   Wed, 28 Aug 2019 15:14:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
References: <20190827163204.29903-1-will@kernel.org>
 <20190828073052.GL2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073052.GL2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:30:52AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> > Will Deacon (6):
> >   lib/refcount: Define constants for saturation and max refcount values
> >   lib/refcount: Ensure integer operands are treated as signed
> >   lib/refcount: Remove unused refcount_*_checked() variants
> >   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
> >   lib/refcount: Improve performance of generic REFCOUNT_FULL code
> >   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
> 
> So I'm not a fan; I itch at the whole racy nature of this thing and I
> find the code less than obvious. Yet, I have to agree it is exceedingly
> unlikely the race will ever actually happen, I just don't want to be the
> one having to debug it.

FWIW, I think much the same about the version under arch/x86 ;)

> I've not looked at the implementation much; does it do all the same
> checks the FULL one does? The x86-asm one misses a few iirc, so if this
> is similarly fast but has all the checks, it is in fact better.

Yes, it passes all of the REFCOUNT_* tests in lkdtm [1] so I agree that
it's an improvement over the asm version.

> Can't we make this a default !FULL implementation?

My concern with doing that is I think it would make the FULL implementation
entirely pointless. I can't see anybody using it, and it would only exist
as an academic exercise in handling the theoretical races. That's a change
from the current situation where it genuinely handles cases which the
x86-specific code does not and, judging by the Kconfig text, that's the
only reason for its existence.

Will

[1]

bash-4.4# for t in `grep REFCOUNT DIRECT`; do echo $t > DIRECT; done
[  439.626480] lkdtm: Performing direct entry REFCOUNT_INC_OVERFLOW
[  439.629352] lkdtm: attempting good refcount_inc() without overflow
[  439.631335] lkdtm: attempting bad refcount_inc() overflow
[  439.633335] ------------[ cut here ]------------
[  439.635334] refcount_t: saturated; leaking memory.
[  439.636364] WARNING: CPU: 12 PID: 177 at ./include/linux/refcount.h:149 refcount_add.part.7+0x13/0x20
[  439.637329] Modules linked in:
[  439.637329] CPU: 12 PID: 177 Comm: bash Not tainted 5.3.0-rc3+ #1
[  439.637329] RIP: 0010:refcount_add.part.7+0x13/0x20
[  439.637329] Code: 32 a9 ff 48 c7 c7 f0 c1 e5 83 e9 81 32 a9 ff 0f 1f 84 00 00 00 00 00 48 c7 c7 20 39 dd 83 c6 05 00 ad f0 00 01 e8 4d cd a3 ff <0f> 0b c3 66 2e 0f 1f 84 00 00 00 00 00 8b 07 3d ff ff ff 7f 74 21
[  439.637329] RSP: 0018:ffffb51ec040be40 EFLAGS: 00010286
[  439.637329] RAX: 0000000000000000 RBX: 0000000000000027 RCX: ffffffff84049418
[  439.637329] RDX: 0000000000000001 RSI: 0000000000000082 RDI: ffffffff847030ac
[  439.637329] RBP: ffffffff83e5b35b R08: 000000000009b1c6 R09: 000000000000015c
[  439.637329] R10: ffffd77ac120fd00 R11: ffffb51ec040bce5 R12: ffff9dca883f4000
[  439.637329] R13: 0000000000d86408 R14: 0000000000000016 R15: ffffb51ec040bf08
[  439.637329] FS:  00007f7b86147700(0000) GS:ffff9dca8a400000(0000) knlGS:0000000000000000
[  439.637329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.637329] CR2: 0000000000d86408 CR3: 00000000482b6003 CR4: 00000000001606a0
[  439.637329] Call Trace:
[  439.637329]  lkdtm_REFCOUNT_INC_OVERFLOW+0x16d/0x210
[  439.637329]  direct_entry+0xc5/0x110
[  439.637329]  full_proxy_write+0x4e/0x70
[  439.637329]  vfs_write+0xab/0x190
[  439.637329]  ksys_write+0x57/0xd0
[  439.637329]  do_syscall_64+0x43/0x110
[  439.637329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.637329] RIP: 0033:0x7f7b85836970
[  439.637329] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
[  439.637329] RSP: 002b:00007ffc7ad9ae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  439.637329] RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 00007f7b85836970
[  439.637329] RDX: 0000000000000016 RSI: 0000000000d86408 RDI: 0000000000000001
[  439.637329] RBP: 0000000000d86408 R08: 00007f7b85af6760 R09: 00007f7b86147700
[  439.637329] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000016
[  439.637329] R13: 0000000000000001 R14: 00007f7b85af5600 R15: 0000000000000016
[  439.637329] ---[ end trace aedef77d83b518cc ]---
[  439.676328] lkdtm: Overflow detected: saturated
[  439.677384] lkdtm: Performing direct entry REFCOUNT_ADD_OVERFLOW
[  439.678326] lkdtm: attempting good refcount_add() without overflow
[  439.679325] lkdtm: attempting bad refcount_add() overflow
[  439.680325] lkdtm: Overflow detected: saturated
[  439.681117] lkdtm: Performing direct entry REFCOUNT_INC_NOT_ZERO_OVERFLOW
[  439.682325] lkdtm: attempting bad refcount_inc_not_zero() overflow
[  439.683324] ------------[ cut here ]------------
[  439.684071] refcount_t: saturated; leaking memory.
[  439.684340] WARNING: CPU: 12 PID: 177 at ./include/linux/refcount.h:120 lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW+0x88/0xb0
[  439.685321] Modules linked in:
[  439.685321] CPU: 12 PID: 177 Comm: bash Tainted: G        W         5.3.0-rc3+ #1
[  439.685321] RIP: 0010:lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW+0x88/0xb0
[  439.685321] Code: 41 48 83 c4 10 c3 80 3d e5 a7 f0 00 00 c7 44 24 04 00 00 00 c0 75 d0 48 c7 c7 20 39 dd 83 c6 05 cd a7 f0 00 01 e8 18 c8 a3 ff <0f> 0b eb b9 85 c0 89 c2 75 9e 48 c7 c7 50 c4 e5 83 e8 1b 2d a9 ff
[  439.685321] RSP: 0018:ffffb51ec040be48 EFLAGS: 00010282
[  439.685321] RAX: 0000000000000000 RBX: 0000000000000029 RCX: ffffffff84049418
[  439.685321] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff847030ac
[  439.685321] RBP: ffffffff83e5aff0 R08: 00000000000a7027 R09: 0000000000000184
[  439.685321] R10: ffffd77ac120fd00 R11: ffffb51ec040bced R12: ffff9dca883f4000
[  439.685321] R13: 0000000000d86408 R14: 000000000000001f R15: ffffb51ec040bf08
[  439.685321] FS:  00007f7b86147700(0000) GS:ffff9dca8a400000(0000) knlGS:0000000000000000
[  439.685321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.685321] CR2: 0000000000d88ea4 CR3: 00000000482b6003 CR4: 00000000001606a0
[  439.685321] Call Trace:
[  439.685321]  direct_entry+0xc5/0x110
[  439.685321]  full_proxy_write+0x4e/0x70
[  439.685321]  vfs_write+0xab/0x190
[  439.685321]  ksys_write+0x57/0xd0
[  439.685321]  do_syscall_64+0x43/0x110
[  439.685321]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.685321] RIP: 0033:0x7f7b85836970
[  439.685321] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
[  439.685321] RSP: 002b:00007ffc7ad9ae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  439.685321] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f7b85836970
[  439.685321] RDX: 000000000000001f RSI: 0000000000d86408 RDI: 0000000000000001
[  439.685321] RBP: 0000000000d86408 R08: 00007f7b85af6760 R09: 00007f7b86147700
[  439.685321] R10: 0000000000000073 R11: 0000000000000246 R12: 000000000000001f
[  439.685321] R13: 0000000000000001 R14: 00007f7b85af5600 R15: 000000000000001f
[  439.685321] ---[ end trace aedef77d83b518cd ]---
[  439.717319] lkdtm: Overflow detected: saturated
[  439.718352] lkdtm: Performing direct entry REFCOUNT_ADD_NOT_ZERO_OVERFLOW
[  439.719321] lkdtm: attempting bad refcount_add_not_zero() overflow
[  439.720319] lkdtm: Overflow detected: saturated
[  439.721036] lkdtm: Performing direct entry REFCOUNT_DEC_ZERO
[  439.721319] lkdtm: attempting good refcount_dec()
[  439.722318] lkdtm: attempting bad refcount_dec() to zero
[  439.723318] ------------[ cut here ]------------
[  439.724008] refcount_t: decrement hit 0; leaking memory.
[  439.724331] WARNING: CPU: 12 PID: 177 at ./include/linux/refcount.h:259 lkdtm_REFCOUNT_DEC_ZERO+0xe5/0x120
[  439.725315] Modules linked in:
[  439.725315] CPU: 12 PID: 177 Comm: bash Tainted: G        W         5.3.0-rc3+ #1
[  439.725315] RIP: 0010:lkdtm_REFCOUNT_DEC_ZERO+0xe5/0x120
[  439.725315] Code: 9a 2b a9 ff eb bd 80 3d 24 a6 f0 00 00 c7 44 24 04 00 00 00 c0 75 86 48 c7 c7 18 7d e0 83 c6 05 0c a6 f0 00 01 e8 5b c6 a3 ff <0f> 0b e9 6c ff ff ff 80 3d f9 a5 f0 00 00 c7 44 24 04 00 00 00 c0
[  439.725315] RSP: 0018:ffffb51ec040be48 EFLAGS: 00010282
[  439.725315] RAX: 0000000000000000 RBX: 000000000000002b RCX: ffffffff84049418
[  439.725315] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff847030ac
[  439.725315] RBP: ffffffff83e5b387 R08: 00000000000b0c28 R09: 00000000000001ab
[  439.725315] R10: ffffd77ac120fd00 R11: ffffb51ec040bced R12: ffff9dca883f4000
[  439.725315] R13: 0000000000d86408 R14: 0000000000000012 R15: ffffb51ec040bf08
[  439.725315] FS:  00007f7b86147700(0000) GS:ffff9dca8a400000(0000) knlGS:0000000000000000
[  439.725315] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.725315] CR2: 0000000000d88ea4 CR3: 00000000482b6003 CR4: 00000000001606a0
[  439.725315] Call Trace:
[  439.725315]  direct_entry+0xc5/0x110
[  439.725315]  full_proxy_write+0x4e/0x70
[  439.725315]  vfs_write+0xab/0x190
[  439.725315]  ksys_write+0x57/0xd0
[  439.725315]  do_syscall_64+0x43/0x110
[  439.725315]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.725315] RIP: 0033:0x7f7b85836970
[  439.725315] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
[  439.725315] RSP: 002b:00007ffc7ad9ae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  439.725315] RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007f7b85836970
[  439.725315] RDX: 0000000000000012 RSI: 0000000000d86408 RDI: 0000000000000001
[  439.725315] RBP: 0000000000d86408 R08: 00007f7b85af6760 R09: 00007f7b86147700
[  439.725315] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000012
[  439.725315] R13: 0000000000000001 R14: 00007f7b85af5600 R15: 0000000000000012
[  439.725315] ---[ end trace aedef77d83b518ce ]---
[  439.755314] lkdtm: Zero detected: saturated
[  439.756357] lkdtm: Performing direct entry REFCOUNT_DEC_NEGATIVE
[  439.757313] lkdtm: attempting bad refcount_dec() below zero
[  439.758313] lkdtm: Negative detected: saturated
[  439.759351] lkdtm: Performing direct entry REFCOUNT_DEC_AND_TEST_NEGATIVE
[  439.760313] lkdtm: attempting bad refcount_dec_and_test() below zero
[  439.761312] ------------[ cut here ]------------
[  439.761990] refcount_t: underflow; use-after-free.
[  439.762326] WARNING: CPU: 12 PID: 177 at ./include/linux/refcount.h:219 lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE+0x90/0xa0
[  439.763309] Modules linked in:
[  439.763309] CPU: 12 PID: 177 Comm: bash Tainted: G        W         5.3.0-rc3+ #1
[  439.763309] RIP: 0010:lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE+0x90/0xa0
[  439.763309] Code: 3f 2a a9 ff eb d1 80 3d ca a4 f0 00 00 c7 44 24 04 00 00 00 c0 75 c0 48 c7 c7 f8 6a dd 83 c6 05 b2 a4 f0 00 01 e8 00 c5 a3 ff <0f> 0b eb a9 e8 77 c7 a3 ff 0f 1f 80 00 00 00 00 48 83 ec 10 48 c7
[  439.763309] RSP: 0018:ffffb51ec040be48 EFLAGS: 00010282
[  439.763309] RAX: 0000000000000000 RBX: 000000000000002d RCX: ffffffff84049418
[  439.763309] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff847030ac
[  439.763309] RBP: ffffffff83e5b030 R08: 00000000000ba086 R09: 00000000000001d1
[  439.763309] R10: ffffd77ac120fd00 R11: ffffb51ec040bced R12: ffff9dca883f4000
[  439.763309] R13: 0000000000d86408 R14: 000000000000001f R15: ffffb51ec040bf08
[  439.763309] FS:  00007f7b86147700(0000) GS:ffff9dca8a400000(0000) knlGS:0000000000000000
[  439.763309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.763309] CR2: 0000000000d88ea4 CR3: 00000000482b6003 CR4: 00000000001606a0
[  439.763309] Call Trace:
[  439.763309]  direct_entry+0xc5/0x110
[  439.763309]  full_proxy_write+0x4e/0x70
[  439.763309]  vfs_write+0xab/0x190
[  439.763309]  ksys_write+0x57/0xd0
[  439.763309]  do_syscall_64+0x43/0x110
[  439.763309]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.763309] RIP: 0033:0x7f7b85836970
[  439.763309] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
[  439.763309] RSP: 002b:00007ffc7ad9ae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  439.763309] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f7b85836970
[  439.763309] RDX: 000000000000001f RSI: 0000000000d86408 RDI: 0000000000000001
[  439.763309] RBP: 0000000000d86408 R08: 00007f7b85af6760 R09: 00007f7b86147700
[  439.763309] R10: 0000000000000073 R11: 0000000000000246 R12: 000000000000001f
[  439.763309] R13: 0000000000000001 R14: 00007f7b85af5600 R15: 000000000000001f
[  439.763309] ---[ end trace aedef77d83b518cf ]---
[  439.792308] lkdtm: Negative detected: saturated
[  439.793349] lkdtm: Performing direct entry REFCOUNT_SUB_AND_TEST_NEGATIVE
[  439.794308] lkdtm: attempting bad refcount_sub_and_test() below zero
[  439.795307] lkdtm: Negative detected: saturated
[  439.796344] lkdtm: Performing direct entry REFCOUNT_INC_ZERO
[  439.797307] lkdtm: attempting safe refcount_inc_not_zero() from zero
[  439.798307] lkdtm: Good: zero detected
[  439.798864] lkdtm: Correctly stayed at zero
[  439.799306] lkdtm: attempting bad refcount_inc() from zero
[  439.800307] ------------[ cut here ]------------
[  439.801003] refcount_t: addition on 0; use-after-free.
[  439.801319] WARNING: CPU: 12 PID: 177 at ./include/linux/refcount.h:146 lkdtm_REFCOUNT_INC_ZERO+0x165/0x170
[  439.802303] Modules linked in:
[  439.802303] CPU: 12 PID: 177 Comm: bash Tainted: G        W         5.3.0-rc3+ #1
[  439.802303] RIP: 0010:lkdtm_REFCOUNT_INC_ZERO+0x165/0x170
[  439.802303] Code: 44 24 04 00 00 00 c0 0f 85 46 ff ff ff e8 a3 f5 ff ff e9 3c ff ff ff 48 c7 c7 20 6b dd 83 c6 05 9f a2 f0 00 01 e8 eb c2 a3 ff <0f> 0b eb bd e8 62 c5 a3 ff 66 90 48 83 ec 10 48 c7 c7 c0 c7 e5 83
[  439.802303] RSP: 0018:ffffb51ec040be48 EFLAGS: 00010282
[  439.802303] RAX: 0000000000000000 RBX: 000000000000002f RCX: ffffffff84049418
[  439.802303] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff847030ac
[  439.802303] RBP: ffffffff83e5b3af R08: 00000000000c38eb R09: 00000000000001fa
[  439.802303] R10: ffffd77ac120fd00 R11: ffffb51ec040bced R12: ffff9dca883f4000
[  439.802303] R13: 0000000000d86408 R14: 0000000000000012 R15: ffffb51ec040bf08
[  439.802303] FS:  00007f7b86147700(0000) GS:ffff9dca8a400000(0000) knlGS:0000000000000000
[  439.802303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.802303] CR2: 0000000000d88ea4 CR3: 00000000482b6003 CR4: 00000000001606a0
[  439.802303] Call Trace:
[  439.802303]  direct_entry+0xc5/0x110
[  439.802303]  full_proxy_write+0x4e/0x70
[  439.802303]  vfs_write+0xab/0x190
[  439.802303]  ksys_write+0x57/0xd0
[  439.802303]  do_syscall_64+0x43/0x110
[  439.802303]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.802303] RIP: 0033:0x7f7b85836970
[  439.802303] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
[  439.802303] RSP: 002b:00007ffc7ad9ae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  439.802303] RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007f7b85836970
[  439.802303] RDX: 0000000000000012 RSI: 0000000000d86408 RDI: 0000000000000001
[  439.802303] RBP: 0000000000d86408 R08: 00007f7b85af6760 R09: 00007f7b86147700
[  439.802303] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000012
[  439.802303] R13: 0000000000000001 R14: 00007f7b85af5600 R15: 0000000000000012
[  439.802303] ---[ end trace aedef77d83b518d0 ]---
[  439.831302] lkdtm: Zero detected: saturated
[  439.832344] lkdtm: Performing direct entry REFCOUNT_ADD_ZERO
[  439.833189] lkdtm: attempting safe refcount_add_not_zero() from zero
[  439.833309] lkdtm: Good: zero detected
[  439.834308] lkdtm: Correctly stayed at zero
[  439.835301] lkdtm: attempting bad refcount_add() from zero
[  439.836105] lkdtm: Zero detected: saturated
[  439.836339] lkdtm: Performing direct entry REFCOUNT_INC_SATURATED
[  439.837301] lkdtm: attempting bad refcount_inc() from saturated
[  439.838301] lkdtm: Saturation detected: still saturated
[  439.839338] lkdtm: Performing direct entry REFCOUNT_DEC_SATURATED
[  439.840301] lkdtm: attempting bad refcount_dec() from saturated
[  439.841300] lkdtm: Saturation detected: still saturated
[  439.842093] lkdtm: Performing direct entry REFCOUNT_ADD_SATURATED
[  439.842300] lkdtm: attempting bad refcount_dec() from saturated
[  439.843300] lkdtm: Saturation detected: still saturated
[  439.844337] lkdtm: Performing direct entry REFCOUNT_INC_NOT_ZERO_SATURATED
[  439.845300] lkdtm: attempting bad refcount_inc_not_zero() from saturated
[  439.846299] lkdtm: Saturation detected: still saturated
[  439.847344] lkdtm: Performing direct entry REFCOUNT_ADD_NOT_ZERO_SATURATED
[  439.848306] lkdtm: attempting bad refcount_add_not_zero() from saturated
[  439.849300] lkdtm: Saturation detected: still saturated
[  439.850335] lkdtm: Performing direct entry REFCOUNT_DEC_AND_TEST_SATURATED
[  439.851299] lkdtm: attempting bad refcount_dec_and_test() from saturated
[  439.852299] lkdtm: Saturation detected: still saturated
[  439.853335] lkdtm: Performing direct entry REFCOUNT_SUB_AND_TEST_SATURATED
[  439.854298] lkdtm: attempting bad refcount_sub_and_test() from saturated
[  439.855298] lkdtm: Saturation detected: still saturated
[  439.856333] lkdtm: Performing direct entry REFCOUNT_TIMING
[  471.816139] lkdtm: refcount timing: done
