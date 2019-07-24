Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDBFC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D912238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Myk/Gq/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfGXPrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:47:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfGXPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:47:17 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so90554095ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e91RU/Uzz3dxmlV1YYbFb2yB3ZDeyFoQVCvWxmZGx6U=;
        b=Myk/Gq/G6dwWFrykH2qp/tqo06K1Cv+Cr7pQOc6qDpqevIIb1WhKPPQ+fHay8zjDTo
         d9UVJyoHfQ4ffWQ5zQgGn0kod2WVShhIWQHiV3wVZQFwm5Yfod2dvv7MD9RAZgssNK/k
         ZYn/bRMxKcvL4O9wfOazt/Tc5ArvnoK8nRNr7Bc0aUzzP1LblqyJdsOTI2Nmdhd7OeEY
         w2zyQsOO0Gr1OlYN/H7TWMuz9/2Hf+mKLeEcou8sfuSnNnq+yboAHIbMEv6ZD1VjhC3s
         pn/nfKq/hQk95iXuWCEtf0IMuOC2bdAxxnmAiAnCPKphUBmsj5vWLw4wvd9uUOZsKUri
         8Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e91RU/Uzz3dxmlV1YYbFb2yB3ZDeyFoQVCvWxmZGx6U=;
        b=kE3VG5kAfgxrlx6Enz0kIGk20n4CUtILe3mHYTgUsACzgqu1Kayu9hEDOVWFTF6Kbr
         Fgy909kE/XekG/Vab2cnPi83ovyTxgPj71ZtLRUduIiSsJPhpWpTgDpEQxaJCw7VdHU3
         ZedPUVj08ZuvvXSNQzd9xWC5R1GSVk2Ct3twSZ3eQOGslovhyyk4zo7r2agAKL3QKskU
         cRtOoykEAX3P3kTZ9mUUypZROKDxQTVLBR6C1Bb5hACck2Q9QsFLZW2Rog5uO5LI1NXO
         JLcJG+3ljapTzhX8hzBbdPbdslwaP7D7BF0ToHpFUPB6bbo7WSRXiKAzvw5kh9wrI0dZ
         x/4A==
X-Gm-Message-State: APjAAAXDSgQt1l92g+7le/Upko5w86VLh3fE4uNnQQ9i6QeXiW6Jb77i
        IACmmRxJv7hgkNWjrq0ASXlXWEyF3tHMHSJkp6EYAJx0U+dhQQ==
X-Google-Smtp-Source: APXvYqxnrz/Rkjs9cYyoJO+j6vzLLSDT9si2barOLaZ5pTonpHnFhnywyxZPbm2/IJDJKwQXlU1nCfAc4bapXN/JCEQ=
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr53071086iok.144.1563983235173;
 Wed, 24 Jul 2019 08:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000070c81a058e6c2917@google.com>
In-Reply-To: <00000000000070c81a058e6c2917@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Jul 2019 17:47:03 +0200
Message-ID: <CACT4Y+aC_gdOMioLJ+v9D_1dMkgjnFYor-QjQydf6DY4WWoUHA@mail.gmail.com>
Subject: Re: memory leak in v9fs_session_init
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 24, 2019 at 2:08 PM syzbot
<syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    abdfd52a Merge tag 'armsoc-defconfig' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=163046afa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d31de3d88059b7fa
> dashboard link: https://syzkaller.appspot.com/bug?extid=15b759334fd44cd9785a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1735466c600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e0cf0600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+15b759334fd44cd9785a@syzkaller.appspotmail.com

+fs/9p/v9fs.c maintainers

> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 16.360s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 16.350s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 16.350s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 16.340s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 16.410s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 16.400s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 16.400s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 16.390s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 17.280s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 17.270s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 17.270s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 17.260s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 18.150s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 18.140s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 18.140s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 18.130s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 19.020s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 19.010s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 19.010s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 19.000s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88811181c360 (size 32):
>    comm "syz-executor114", pid 7075, jiffies 4294946393 (age 19.070s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 46 04 00 ea ff ff 80 4a 46 04 00 ea ff ff  r.F......JF.....
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109294a0 (size 32):
>    comm "syz-executor114", pid 7076, jiffies 4294946394 (age 19.060s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888110929b40 (size 32):
>    comm "syz-executor114", pid 7080, jiffies 4294946394 (age 19.060s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  r...............
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff8881109292a0 (size 32):
>    comm "syz-executor114", pid 7081, jiffies 4294946395 (age 19.050s)
>    hex dump (first 32 bytes):
>      77 66 64 6e 6f 25 61 63 63 65 73 73 3d 75 73 65  wfdno%access=use
>      72 00 6b 65 72 6e 65 6c 5f 74 3a 73 30 00 00 00  r.kernel_t:s0...
>    backtrace:
>      [<00000000830cd797>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<00000000830cd797>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<00000000830cd797>] slab_alloc /mm/slab.c:3319 [inline]
>      [<00000000830cd797>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<00000000830cd797>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000004c2bde0e>] kmemdup_nul+0x31/0x80 /mm/util.c:143
>      [<00000000d3b2a6b1>] match_strdup+0x21/0x30 /lib/parser.c:322
>      [<00000000cb5a9103>] v9fs_parse_options /fs/9p/v9fs.c:281 [inline]
>      [<00000000cb5a9103>] v9fs_session_init+0x29e/0x880 /fs/9p/v9fs.c:422
>      [<0000000060a9624b>] v9fs_mount+0x5e/0x3a0 /fs/9p/vfs_super.c:120
>      [<0000000045c47d3a>] legacy_get_tree+0x27/0x80 /fs/fs_context.c:661
>      [<00000000966bd655>] vfs_get_tree+0x2e/0x110 /fs/super.c:1416
>      [<000000004bdabb83>] do_new_mount /fs/namespace.c:2795 [inline]
>      [<000000004bdabb83>] do_mount+0x94e/0xc70 /fs/namespace.c:3115
>      [<000000008f276989>] ksys_mount+0xab/0x120 /fs/namespace.c:3324
>      [<000000003dd28c22>] __do_sys_mount /fs/namespace.c:3338 [inline]
>      [<000000003dd28c22>] __se_sys_mount /fs/namespace.c:3335 [inline]
>      [<000000003dd28c22>] __x64_sys_mount+0x26/0x30 /fs/namespace.c:3335
>      [<00000000b6179601>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000005924437c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> executing program
> executing program
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000070c81a058e6c2917%40google.com.
