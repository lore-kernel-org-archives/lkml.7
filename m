Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDEDC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42193214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Udm2ZIVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfGANc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:32:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36736 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfGANc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:32:26 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so28873315ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUEhbsEHx4i8bkxCJ83bDciXYOsLRbm1SvwaTT4rboI=;
        b=Udm2ZIVK5oNaybJbVicQqtdJPxlzQ+AkLwdJ8PRtI9MNnjoxj+XBXfW9DVdFSmMiQZ
         0P637VbWYHM85+EYphPgN7xwHbGxmjDL6nwR9w3zygcXTNPZFMt2s+3y/YwtLBZi48uL
         94OhhDyyPMFqZqEzLDqf8cFhzvOr47NQbzFhUuMz0/bj+0xgx6QKJVLwOQKs7rxyqZJm
         PEyhiu3Oq1RcHjqrvA8yZRmDSmUpLZyvTwzIhqWeNDvQiyCjqttxF9c1x34buDOpSLe6
         o1/faV9H780nBxh+cq0j/NEyh3OOYue2RgyfPJdIcArLO4GBumdFduQGHZcA4W9dGwvk
         a9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUEhbsEHx4i8bkxCJ83bDciXYOsLRbm1SvwaTT4rboI=;
        b=gk+fCuWNYOz9yuxGeHYgoom12EW12TBWCThZuOUHj30rqjpfKMUWvl4EMCMoUDDT8k
         Zzk4Jyd4jj3l4ojpWhJD+WyWm2Bc9K3cu5REciLOHwCuL6vVA+K2oG3F+UF8AT9RPITX
         FmJYOuZHOt9JPNFyLy42GNbX+bWiZvDcWk86y39WSCLz7H+mYt6xpuQ5BtSiMtgov/zX
         2qfG6vfKfnjvqCg71nkTCWOHU2rQXQRXztxlNnioJNl/50Y/0/C8RGcXS87UL4VufRnn
         q4nHC5PUL8KqGlShRjgpFnY8df2ruzU7BAaUquMfcx7d9XoYe1k3bwLbMTtLVTHJ1ZQn
         dqNA==
X-Gm-Message-State: APjAAAV+3ShOxjm/4K5zjFNWbvN5Hq2c4oWL4oSHngXKuGI/T44pYNip
        LYDCydXzTI9lC5O4VweFYII9Dw==
X-Google-Smtp-Source: APXvYqymvIDs01OIcxQ4o/i7u5VkNGf0aMo7MCFtMS0+l4kG2QAZjXi8Fy8H+cTr21Fb0WrJXHwlbw==
X-Received: by 2002:a5e:da4b:: with SMTP id o11mr25144726iop.212.1561987945404;
        Mon, 01 Jul 2019 06:32:25 -0700 (PDT)
Received: from brauner.io ([208.54.80.252])
        by smtp.gmail.com with ESMTPSA id u187sm23350429iod.37.2019.07.01.06.32.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 06:32:24 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:32:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     syzbot <syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        gregkh@linuxfoundation.org, guro@fb.com, jannh@google.com,
        ktsanaktsidis@zendesk.com, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, rppt@linux.vnet.ibm.com, scuttimmy@gmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, willy@infradead.org, yuehaibing@huawei.com
Subject: Re: general protection fault in get_task_pid
Message-ID: <20190701133215.73kblwpghfrzwbwb@brauner.io>
References: <000000000000e0dc0d058c9e7142@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000e0dc0d058c9e7142@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 06:17:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    556e2f60 Merge tag 'clk-fixes-for-linus' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=112a45a9a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=002e636502bc4b64eb5c
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1716d35ba00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1489f565a00000
> 
> The bug was bisected to:
> 
> commit 6fd2fe494b17bf2dec37b610d23a43a72b16923a
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Jun 27 02:22:09 2019 +0000
> 
>     copy_process(): don't use ksys_close() on cleanups

I think I see the issue. Will hopefully have a fix in a bit.

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135a66f9a00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10da66f9a00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=175a66f9a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com
> Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
> R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7990 Comm: syz-executor290 Not tainted 5.2.0-rc6+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
> Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c
> e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08
> 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
> RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
> RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
> R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
> R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
> FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  _do_fork+0x1b9/0x5f0 kernel/fork.c:2360
>  __do_sys_clone kernel/fork.c:2454 [inline]
>  __se_sys_clone kernel/fork.c:2448 [inline]
>  __x64_sys_clone+0xc1/0xd0 kernel/fork.c:2448
>  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x446649
> Code: e8 bc b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff07e47ddb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446649
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000041ffc
> RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
> R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 403a74d6aeda7e67 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
> Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c
> e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08
> 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
> RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
> RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
> R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
> R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
> FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
