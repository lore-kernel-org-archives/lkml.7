Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83431ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492D82089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F64H2U15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439690AbfJQLTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:19:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39180 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439661AbfJQLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:19:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so978095plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpvJaWuaj5p2zl6AGhLO6pPdP5dG2XMc5QcqZdbusrA=;
        b=F64H2U154pkhqclozn5m1COmSg6ol6+JJiinDjL1LrOeCLpjIbV0wQnJhUS4CueIRI
         r8xgFOFBoNptMsktYxV/tN4bpFAxLzAxOn94uyp1C2friHJatGXeaA/yc+a9lL8s7jNM
         VZg8fszdfmjl6Y4GCLTp30kr9DQNuQWTEeEJMXSY1lRk0L4uzSKBDcl827+Tbd6oExqC
         464EtOOekl7Zn3uoYGMq2BjJ5WgPq1Xr6ONKJGzga4xKjb3bvkJ5ZhtPDsua5E0bUUpN
         S8CSer6zuTrq1aWvCSooO3yN6g5GQRTsxzwd37xq4deT8lcVtWHMAZYr8xAg4bzJzij2
         uSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpvJaWuaj5p2zl6AGhLO6pPdP5dG2XMc5QcqZdbusrA=;
        b=unQBmUfGH26+G0L8x7kSx818+4xO0h54NmCPdZKKF0WEIYF1Xu4QULrwiX2flzPHMK
         lsqWE3X3P3Afh8B6OxSeGPUPyaLLBNC5roppOqjBsw6T9B0Og8uySfpAAwVtuG5H7Yy8
         XkR24iGQLtXaOmHOXkhGypSdWWBTFUCLjRdorPXisCGTa6mwBfsrWhL0WyqRgY2CRx5D
         Cpa4uy58KfZOabB+Ec6R+gJLOkhtN1BI+9+No80ldavvNVT0fuV+9dSLXdaZPXu7oJBa
         7t/SDEOKnz7h4b5qex/KErBdsiNz7BUX+oTHSg/VFbnv1t5x35bMPNF6RzdG+HGsJZLp
         t9Hg==
X-Gm-Message-State: APjAAAV4gC92s0u9QS7NAvf7sQDUk8c4z1v+XIVj3FjDSzSEuQlaHZBf
        scuksBKtz9qBnI7+Kd53O7yBjVldzvVyYDdbA1Twfw==
X-Google-Smtp-Source: APXvYqw06LcVrow5/Sx3dP8eikh/LxB1skUYyIr4JsFUvmR7b+l7zw+/Wbmh2bmKCiLkv8IdRKvnwr2sqXpLqrx4PjY=
X-Received: by 2002:a17:902:9696:: with SMTP id n22mr3228007plp.252.1571311152434;
 Thu, 17 Oct 2019 04:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000087ce3a0595115382@google.com>
In-Reply-To: <00000000000087ce3a0595115382@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 17 Oct 2019 13:19:01 +0200
Message-ID: <CAAeHK+xyVSgSfXrTtgzP7JRy7GtU+pDPwBUfd0hz1TEipWCntA@mail.gmail.com>
Subject: Re: BUG: bad usercopy in ld_usb_read (3)
To:     syzbot <syzbot+acee996f6938b9ded381@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        info@metux.net, isaacm@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 3:42 AM syzbot
<syzbot+acee996f6938b9ded381@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1756ff77600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
> dashboard link: https://syzkaller.appspot.com/bug?extid=acee996f6938b9ded381
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+acee996f6938b9ded381@syzkaller.appspotmail.com
>
> ldusb 5-1:0.28: Read buffer overflow, 177886378725897 bytes dropped
> usercopy: Kernel memory exposure attempt detected from process stack
> (offset 0, size 2147479552)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:99!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 1 PID: 6543 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 32 51 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 40
> d9 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 46 e3 c0 ff <0f> 0b e8 06 51
> d6 ff e8 31 8b fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881d35f7c58 EFLAGS: 00010282
> RAX: 0000000000000061 RBX: ffffffff85cdd660 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bcbd RDI: ffffed103a6bef7d
> RBP: ffffffff85cdd820 R08: 0000000000000061 R09: fffffbfff11b23be
> R10: fffffbfff11b23bd R11: ffffffff88d91def R12: ffffffff85cdda40
> R13: ffffffff85cdd660 R14: 000000007ffff000 R15: ffffffff85cdd660
> FS:  00007fb330338700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f07cea47000 CR3: 00000001cc11e000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __check_object_size mm/usercopy.c:282 [inline]
>   __check_object_size.cold+0x91/0xbb mm/usercopy.c:256
>   check_object_size include/linux/thread_info.h:119 [inline]
>   check_copy_size include/linux/thread_info.h:150 [inline]
>   copy_to_user include/linux/uaccess.h:151 [inline]
>   ld_usb_read+0x31a/0x760 drivers/usb/misc/ldusb.c:492
>   __vfs_read+0x76/0x100 fs/read_write.c:425
>   vfs_read+0x1ea/0x430 fs/read_write.c:461
>   ksys_read+0x1e8/0x250 fs/read_write.c:587
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459a59
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb330337c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
> RDX: 00000000ffffffad RSI: 0000000020003200 RDI: 0000000000000004
> RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb3303386d4
> R13: 00000000004c7120 R14: 00000000004dcae8 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 0fa22c64036b6ebe ]---
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 32 51 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 40
> d9 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 46 e3 c0 ff <0f> 0b e8 06 51
> d6 ff e8 31 8b fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881d35f7c58 EFLAGS: 00010282
> RAX: 0000000000000061 RBX: ffffffff85cdd660 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bcbd RDI: ffffed103a6bef7d
> RBP: ffffffff85cdd820 R08: 0000000000000061 R09: fffffbfff11b23be
> R10: fffffbfff11b23bd R11: ffffffff88d91def R12: ffffffff85cdda40
> R13: ffffffff85cdd660 R14: 000000007ffff000 R15: ffffffff85cdd660
> FS:  00007fb330338700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f07cea47000 CR3: 00000001cc11e000 CR4: 00000000001406e0
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

Most likely a duplicate of
https://syzkaller.appspot.com/bug?extid=6fe95b826644f7f12b0b

#syz dup: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
