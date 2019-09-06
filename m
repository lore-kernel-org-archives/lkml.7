Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510B2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5852082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567745399;
	bh=aUv4wuCZGfhNs3j768vzfIVkfV5uyrkIy0vGHS8vQJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ccpHMR7f0LcXVtrMroDSpwm3tL9rXETNzIKWQWjNPjL+yYZsuJWDZ7TNemnz8x/BF
	 8lAdhnImStoW4zW7bzyctYhIb9r92fzIZ1qZXwPbX5XIBF8JadskOd+0ir8axR10Ag
	 SFoTs8eQLK+wUyHpOb5v3iGO/RLMVeF2WYGjJWhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfIFEt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIFEt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:49:57 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D3B207FC;
        Fri,  6 Sep 2019 04:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567745396;
        bh=aUv4wuCZGfhNs3j768vzfIVkfV5uyrkIy0vGHS8vQJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLfUIhq2RGk+82eBGoEMGAAKYdlj9VvE42bMOY4NkcGHw+6F86Q23i3zZwlWfYBaX
         uJlsclgeyXdAxxz3FglT7yKXueFJpnX2ihvu3Zb/WeW9KVOG+xa4wHFSubB8fmTtgl
         ZwNO7L/Ugj0YGMHsZ2VBSAmzc7jA+DtNSWK5tr5c=
Date:   Thu, 5 Sep 2019 21:49:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com>
Subject: Re: WARNING in posix_cpu_timer_del (3)
Message-ID: <20190906044954.GF803@sol.localdomain>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com>
References: <0000000000009b6b880591a8b697@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009b6b880591a8b697@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:38:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6d028043 Add linux-next specific files for 20190830
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=179e59de600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=82a6bec43ab0cb69
> dashboard link: https://syzkaller.appspot.com/bug?extid=dabf3198a30ed5a2158f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb4546600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af4356600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 9805 at kernel/time/posix-cpu-timers.c:401
> posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 9805 Comm: syz-executor380 Not tainted 5.3.0-rc6-next-20190830
> #75
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  panic+0x2dc/0x755 kernel/panic.c:220
>  __warn.cold+0x2f/0x3c kernel/panic.c:581
>  report_bug+0x289/0x300 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:179 [inline]
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
> Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85
> b5 00 00 00 48 83 bb c8 00 00 00 00 74 16 e8 00 58 0d 00 <0f> 0b e9 87 fe ff
> ff e8 c4 38 48 00 e9 dd fd ff ff e8 ea 57 0d 00
> RSP: 0018:ffff88809ac87a30 EFLAGS: 00010093
> RAX: ffff888090a6e0c0 RBX: ffff88809ae762e0 RCX: 1ffff1101214dd2a
> RDX: 0000000000000000 RSI: ffffffff8164fe10 RDI: ffff88809ae763a8
> RBP: ffff88809ac87ac0 R08: 0000000000000002 R09: ffff888090a6e958
> R10: fffffbfff138aef8 R11: ffffffff89c577c7 R12: ffff88809b326100
> R13: 1ffff11013590f47 R14: ffff88809ac87a98 R15: ffff88809ae76338
>  timer_delete_hook kernel/time/posix-timers.c:978 [inline]
>  itimer_delete kernel/time/posix-timers.c:1021 [inline]
>  exit_itimers+0xdb/0x2e0 kernel/time/posix-timers.c:1041
>  do_exit+0x1980/0x2e60 kernel/exit.c:853
>  do_group_exit+0x135/0x360 kernel/exit.c:983
>  get_signal+0x47c/0x2500 kernel/signal.c:2734
>  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
>  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
>  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x446679
> Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffff909e168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: 0000000000000000 RBX: 0000000000017a92 RCX: 0000000000446679
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc2c
> RBP: 00000000006dbc2c R08: 000000037ffffa00 R09: 000000037ffffa00
> R10: 00007ffff909e180 R11: 0000000000000246 R12: 00000000006dbc20
> R13: 0000000000000000 R14: 000000000000002d R15: 20c49ba5e353f7cf
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

FYI, this is still reproducible on latest linux-next (next-20190904).

- Eric
