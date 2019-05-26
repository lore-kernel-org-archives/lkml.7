Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E2C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 06:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879A212F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 06:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6Mjp9Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEZGnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 02:43:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44570 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfEZGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 02:43:15 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so10876207iol.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykvxJITftYjuXxiA50DtpHZBYlqXNVskwhB9Mpf150E=;
        b=m6Mjp9YwG+MO3GK3/WiJs8xMKUyMflKU3POY+nzvZwJon57SHLuJJaPdItjQTu2h+L
         YWVXgcXz8NuEwKLZsoqOOIMu497tHmO9lLoT8iGLEKZmvBgnyAAgjpp6myuRntsOZlRv
         PGfX4tRUYCq/MbvaaMeLlLxmyUTYXZVCSzKULIwg5j/KTgNmesJ3pkR4AVb1km/8O6Bq
         AVIzYiO6xuJC9i2tWYfQ7yNzm66A60o7tt38tg+2uC975pzVF8nQsgJapfTIghTZedcb
         RsvWxJg57lMAW1hzL5eqF/yzmgPNx8YKQQl9ygiiaFgp31wnluUNQX+BpI+AQskxao9w
         GKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykvxJITftYjuXxiA50DtpHZBYlqXNVskwhB9Mpf150E=;
        b=lwcSGFKSv5vhYAJaaMomuvvAqje4h4g3WPse2GLUEu7U3SC7HzEMrIM5nmzCYpR0B8
         EndIkYtslTOE7TkbZ142lSAhfmT595y52TOoZkh75KIERujZyUI2MXmPgAnEdYSqgT5L
         mXBzFDBmrpOtHjyvvRq4uJ0929jR6UfUKeR9ZoCI1D06C5H81D9RNSuMCSLZiObBvNeD
         HXO9mTWVk5Re8BEaf0AFWWnvVcekgozjBYrOlKSIUWr5w6RVf8KnMaUH2cF7+ao6xOvh
         GfSgCjgXTyMG+qd50BurYxF3G6cvdR1SaPNhWmWBoHEuu4VCqUJYcjPTh//a4oaB7eYK
         PO/Q==
X-Gm-Message-State: APjAAAUSbR3mkErpkNspjFMpby2tJm8IJvkBi3qk1T9dLBwDqmro5ACX
        e7c1ski+8y7Wo9S+AdjpiVk6JCQvVeuGPxZ4c3gAtg==
X-Google-Smtp-Source: APXvYqyjpTDjnSSHq2fQV4pZzfv+tFE5wgmT0Hz3I1nXVoGdzPZUfQv3VVFhV2rsLC3qe5ChyymvplhalIYwWsedv34=
X-Received: by 2002:a6b:dc0d:: with SMTP id s13mr35756721ioc.144.1558852994241;
 Sat, 25 May 2019 23:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001a546b0589b9c74f@google.com>
In-Reply-To: <0000000000001a546b0589b9c74f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 26 May 2019 08:43:03 +0200
Message-ID: <CACT4Y+bME3hecCNXQHvr6uwWjYY6BEqCnu8W4RUMZCm7XemPmQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in class_equal
To:     syzbot <syzbot+83c135be90fc92db7e13@syzkaller.appspotmail.com>,
        bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 7:38 PM syzbot
<syzbot+83c135be90fc92db7e13@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c50bbf61 Merge tag 'platform-drivers-x86-v5.2-2' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12130c9aa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=83c135be90fc92db7e13
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e7d84ca00000

From the repro looks like

#syz dup: KASAN: slab-out-of-bounds Read in class_equal

+bpf mailing list

If bpf maps started badly smashing memory in a way that KASAN can't
detect, please fix asap. Or we will start getting dozens of random
reports. The usual question: why does not KASAN detect the root cause
smash? How can we make it detect it?


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+83c135be90fc92db7e13@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in class_equal+0x40/0x50
> kernel/locking/lockdep.c:1527
> Read of size 8 at addr ffff88807aedf360 by task syz-executor.0/9275
>
> CPU: 0 PID: 9275 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #7
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> Allocated by task 9264:
>   save_stack+0x23/0x90 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_kmalloc mm/kasan/common.c:489 [inline]
>   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
>   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:497
>   slab_post_alloc_hook mm/slab.h:437 [inline]
>   slab_alloc mm/slab.c:3326 [inline]
>   kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3488
>   getname_flags fs/namei.c:138 [inline]
>   getname_flags+0xd6/0x5b0 fs/namei.c:128
>   getname+0x1a/0x20 fs/namei.c:209
>   do_sys_open+0x2c9/0x5d0 fs/open.c:1064
>   __do_sys_open fs/open.c:1088 [inline]
>   __se_sys_open fs/open.c:1083 [inline]
>   __x64_sys_open+0x7e/0xc0 fs/open.c:1083
>   do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 9264:
>   save_stack+0x23/0x90 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
>   __cache_free mm/slab.c:3432 [inline]
>   kmem_cache_free+0x86/0x260 mm/slab.c:3698
>   putname+0xef/0x130 fs/namei.c:259
>   do_sys_open+0x318/0x5d0 fs/open.c:1079
>   __do_sys_open fs/open.c:1088 [inline]
>   __se_sys_open fs/open.c:1083 [inline]
>   __x64_sys_open+0x7e/0xc0 fs/open.c:1083
>   do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff88807aede580
>   which belongs to the cache names_cache of size 4096
> The buggy address is located 3552 bytes inside of
>   4096-byte region [ffff88807aede580, ffff88807aedf580)
> The buggy address belongs to the page:
> page:ffffea0001ebb780 refcount:1 mapcount:0 mapping:ffff8880aa596c40
> index:0x0 compound_mapcount: 0
> flags: 0x1fffc0000010200(slab|head)
> raw: 01fffc0000010200 ffffea0001ebb708 ffffea0001ebb908 ffff8880aa596c40
> raw: 0000000000000000 ffff88807aede580 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff88807aedf200: 00 00 fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88807aedf280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb f1 f1
> > ffff88807aedf300: f1 f1 00 f2 f2 f2 00 f2 f2 f2 fb fb fb fb 00 00
>                                                         ^
>   ffff88807aedf380: 00 f3 f3 f3 f3 f3 fb fb fb fb fb fb fb fb fb fb
>   ffff88807aedf400: fb fb fb fb fb fb fb fb fb fb fb fb fb 00 00 00
> ==================================================================
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001a546b0589b9c74f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
