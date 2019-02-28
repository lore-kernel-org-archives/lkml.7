Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDF92171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6FzPT1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfB1JcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:32:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36513 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfB1JcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:32:05 -0500
Received: by mail-io1-f66.google.com with SMTP id r136so16060667iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SiVL0phPtLvd3BWub8/+zvbm8s/u1KyJ8RzgcKT76U=;
        b=G6FzPT1LV7dj+FQJGuABkovL1VVtS02DrzhYKKE8VSYP7Np0baQIEVmDxY1G/zinH4
         0gSYhf0NkXFONL2ZR8cglrKm6wfk1AWuRWc5BDG371ExEziESpHlvDGAWOWz8iLFvrrS
         BmVDXwITLRKsIiCBAr+X5fBU9H/tntyEBF1yqnjaxhrIjTrYQT/eByT4Ngi1mA9PN2Dh
         xexreKjSrY4xmvGhjOX6dHEjlymGbOoMdWev+U0dVkfFStsvZyfsWLAGUu1OctBqVgsY
         tEcGGS6ylJR4+dqj5C8CeNCB0Zfyn1H9Yv/qmh3Zt1y8lOrwBsEXabt2uHh9Zw+pb8rt
         l9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SiVL0phPtLvd3BWub8/+zvbm8s/u1KyJ8RzgcKT76U=;
        b=DLBZHl1bwViqA8TpZqoMBItSY+abvZ9dW9ZAgkGO1Z/WgE/g8OgG0c7hWIxgUWW8Y7
         XRD/g6CIq4RVs7CjZgZRrnM2iGc9dTmg4E4j1Yr4O44IpJRkraSu4d7F3Pkf+aCEOFZi
         7FW3HU/bf0KESGd/PH5l+DL+6vkVd9XfG61xn0i9ffRO+waANGeD6ciZfmq1dKPDcGNX
         xqQDKH+x+wiZZEwlQIfpPjV7wdY24xk4aJ2DwpC+1i9IPCCqJpl9o2tyvOGYhyNyZB8i
         h4BNlHuVzKzftx3+OBClwdbcFi74f32V/IMGj8ghbQSO2gy79ma3G35DIfowFFyNoJmY
         C/lQ==
X-Gm-Message-State: APjAAAX5o37yLkDSSlWuCYZwZWp/r65gtXMkHjDhN7prbm7qqDJy9vqK
        lPtdfHl9yXyYU7zaYJA1l5utMims8Wq6TIMlzYiegQ==
X-Google-Smtp-Source: APXvYqyWEaSRUhuqrolOQXRpb24mHMkegApbbOoDD1NvTD/+UTGzEoJXDUd+ScXDpEjpNg3Vo2UtIBdD/y9ZyVg9VTk=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr4000240ioc.282.1551346324216;
 Thu, 28 Feb 2019 01:32:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006a12bd0581ca4145@google.com> <20190213122331.632a4eb1a12b738ef9633855@linux-foundation.org>
 <20190226182129.GA218103@gmail.com> <20190227205323.GA186986@gmail.com>
 <CACT4Y+ZK5MrJ3GZ-sxihNpRaun4aMOxkRqmLqQJxYEgD2cnfZQ@mail.gmail.com> <20190228075943.GG699@sol.localdomain>
In-Reply-To: <20190228075943.GG699@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 10:31:53 +0100
Message-ID: <CACT4Y+aNnTzD1Q+WxFA9ob-t+NrehL3GYF-e+=U5Z8f5ZQTudg@mail.gmail.com>
Subject: Re: BUG: Bad page state (5)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        nborisov@suse.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mike Kravetz <kravetz@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 8:59 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Feb 28, 2019 at 07:53:09AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > On Wed, Feb 27, 2019 at 9:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 10:21:30AM -0800, Eric Biggers wrote:
> > > > On Wed, Feb 13, 2019 at 12:23:31PM -0800, Andrew Morton wrote:
> > > > > On Wed, 13 Feb 2019 09:56:04 -0800 syzbot <syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    c4f3ef3eb53f Add linux-next specific files for 20190213
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1130a124c00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9ec67976eb2df882
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=2cd2887ea471ed6e6995
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ecdaa8c00000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ebe178c00000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com
> > > > >
> > > > > It looks like a a memfd page was freed with a non-NULL ->mapping.
> > > > >
> > > > > Joel touched the memfd code with "mm/memfd: add an F_SEAL_FUTURE_WRITE
> > > > > seal to memfd" but it would be surprising if syzbot tickled that code?
> > > > >
> > > > >
> > > > > > BUG: Bad page state in process udevd  pfn:472f0
> > > > > > name:"memfd:"
> > > > > > page:ffffea00011cbc00 count:0 mapcount:0 mapping:ffff88800df2ad40 index:0xf
> > > > > > shmem_aops
> > > > > > flags: 0x1fffc000008000c(uptodate|dirty|swapbacked)
> > > > > > raw: 01fffc000008000c ffffea0000ac4f08 ffff8880a85af890 ffff88800df2ad40
> > > > > > raw: 000000000000000f 0000000000000000 00000000ffffffff 0000000000000000
> > > > > > page dumped because: non-NULL mapping
> > > > > > Modules linked in:
> > > > > > CPU: 1 PID: 7586 Comm: udevd Not tainted 5.0.0-rc6-next-20190213 #34
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Call Trace:
> > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > > > >   bad_page.cold+0xda/0xff mm/page_alloc.c:586
> > > > > >   free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1014
> > > > > >   free_pages_check mm/page_alloc.c:1023 [inline]
> > > > > >   free_pages_prepare mm/page_alloc.c:1113 [inline]
> > > > > >   free_pcp_prepare mm/page_alloc.c:1138 [inline]
> > > > > >   free_unref_page_prepare mm/page_alloc.c:2991 [inline]
> > > > > >   free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3060
> > > > > > name:"memfd:"
> > > > > >   release_pages+0x60d/0x1940 mm/swap.c:791
> > > > > >   pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
> > > > > >   __pagevec_lru_add mm/swap.c:917 [inline]
> > > > > >   lru_add_drain_cpu+0x2f7/0x520 mm/swap.c:581
> > > > > >   lru_add_drain+0x20/0x60 mm/swap.c:652
> > > > > >   exit_mmap+0x290/0x530 mm/mmap.c:3134
> > > > > >   __mmput kernel/fork.c:1047 [inline]
> > > > > >   mmput+0x15f/0x4c0 kernel/fork.c:1068
> > > > > >   exec_mmap fs/exec.c:1046 [inline]
> > > > > >   flush_old_exec+0x8d9/0x1c20 fs/exec.c:1279
> > > > > >   load_elf_binary+0x9bc/0x53f0 fs/binfmt_elf.c:864
> > > > > >   search_binary_handler fs/exec.c:1656 [inline]
> > > > > >   search_binary_handler+0x17f/0x570 fs/exec.c:1634
> > > > > >   exec_binprm fs/exec.c:1698 [inline]
> > > > > >   __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
> > > > > >   do_execveat_common fs/exec.c:1865 [inline]
> > > > > >   do_execve fs/exec.c:1882 [inline]
> > > > > >   __do_sys_execve fs/exec.c:1958 [inline]
> > > > > >   __se_sys_execve fs/exec.c:1953 [inline]
> > > > > >   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
> > > > > >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> > > > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > > RIP: 0033:0x7fc7001ba207
> > > > > > Code: Bad RIP value.
> > > > > > RSP: 002b:00007ffe06aa13b8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> > > > > > RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fc7001ba207
> > > > > > RDX: 0000000001fd5fd0 RSI: 00007ffe06aa14b0 RDI: 00007ffe06aa24c0
> > > > > > RBP: 0000000000625500 R08: 0000000000001c49 R09: 0000000000001c49
> > > > > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000001fd5fd0
> > > > > > R13: 0000000000000007 R14: 0000000001fc6250 R15: 0000000000000005
> > > > > > BUG: Bad page state in process udevd  pfn:2b13c
> > > > > > page:ffffea0000ac4f00 count:0 mapcount:0 mapping:ffff88800df2ad40 index:0xe
> > > > > > shmem_aops
> > > > > > flags: 0x1fffc000008000c(uptodate|dirty|swapbacked)
> > > > > > raw: 01fffc000008000c ffff8880a85af890 ffff8880a85af890 ffff88800df2ad40
> > > > > > raw: 000000000000000e 0000000000000000 00000000ffffffff 0000000000000000
> > > > > > page dumped because: non-NULL mapping
> > > > > > Modules linked in:
> > > > > > CPU: 1 PID: 7586 Comm: udevd Tainted: G    B
> > > > > > 5.0.0-rc6-next-20190213 #34
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Call Trace:
> > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > > > >   bad_page.cold+0xda/0xff mm/page_alloc.c:586
> > > > > > name:"memfd:"
> > > > > >   free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1014
> > > > > >   free_pages_check mm/page_alloc.c:1023 [inline]
> > > > > >   free_pages_prepare mm/page_alloc.c:1113 [inline]
> > > > > >   free_pcp_prepare mm/page_alloc.c:1138 [inline]
> > > > > >   free_unref_page_prepare mm/page_alloc.c:2991 [inline]
> > > > > >   free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3060
> > > > > >   release_pages+0x60d/0x1940 mm/swap.c:791
> > > > > >   pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
> > > > > >   __pagevec_lru_add mm/swap.c:917 [inline]
> > > > > >   lru_add_drain_cpu+0x2f7/0x520 mm/swap.c:581
> > > > > >   lru_add_drain+0x20/0x60 mm/swap.c:652
> > > > > >   exit_mmap+0x290/0x530 mm/mmap.c:3134
> > > > > >   __mmput kernel/fork.c:1047 [inline]
> > > > > >   mmput+0x15f/0x4c0 kernel/fork.c:1068
> > > > > >   exec_mmap fs/exec.c:1046 [inline]
> > > > > >   flush_old_exec+0x8d9/0x1c20 fs/exec.c:1279
> > > > > >   load_elf_binary+0x9bc/0x53f0 fs/binfmt_elf.c:864
> > > > > >   search_binary_handler fs/exec.c:1656 [inline]
> > > > > >   search_binary_handler+0x17f/0x570 fs/exec.c:1634
> > > > > >   exec_binprm fs/exec.c:1698 [inline]
> > > > > >   __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
> > > > > >   do_execveat_common fs/exec.c:1865 [inline]
> > > > > >   do_execve fs/exec.c:1882 [inline]
> > > > > >   __do_sys_execve fs/exec.c:1958 [inline]
> > > > > >   __se_sys_execve fs/exec.c:1953 [inline]
> > > > > >   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
> > > > > >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> > > > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > > RIP: 0033:0x7fc7001ba207
> > > > > > Code: Bad RIP value.
> > > > > > RSP: 002b:00007ffe06aa13b8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> > > > > > RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fc7001ba207
> > > > > > RDX: 0000000001fd5fd0 RSI: 00007ffe06aa14b0 RDI: 00007ffe06aa24c0
> > > > > > RBP: 0000000000625500 R08: 0000000000001c49 R09: 0000000000001c49
> > > > > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000001fd5fd0
> > > > > > R13: 0000000000000007 R14: 0000000001fc6250 R15: 0000000000000005
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > This bug is generated by a bot. It may contain errors.
> > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > >
> > > > > > syzbot will keep track of this bug report. See:
> > > > > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > > > > > syzbot.
> > > > > > syzbot can test patches for this bug, for details see:
> > > > > > https://goo.gl/tpsmEJ#testing-patches
> > > > >
> > > >
> > > > It's apparently the bug in the io_uring patchset I reported yesterday (well, I
> > > > stole it from another open syzbot bug...) and Jens is already planning to fix:
> > > > https://marc.info/?l=linux-api&m=155115288114046&w=2.  Reproducer is similar,
> > > > and the crash bisects down to the same commit from the io_uring patchset:
> > > > "block: implement bio helper to add iter bvec pages to bio".
> > > >
> > >
> > > Fixed in next-20190227.  The fix was folded into "block: implement bio helper to
> > > add iter bvec pages to bio".  Telling syzbot to invalidate this bug report:
> > >
> > > #syz invalid
> >
> > Was this discovered separately? We could also add Reported-by (or
> > Tested-by) tag to the commit.
> >
>
> My report was based on a crash from the syzbot dashboard.  However, there's no
> fixing commit, as the fix was folded into the original patch.  I.e. the mainline
> git history (if/when the io_uring stuff is actually merged) won't show the bug
> ever being introduced.  Thus Reported-by isn't appropriate, and I used '#syz
> invalid' instead of '#syz fix'.  Nor did syzbot specifically test the new
> version of the patch beyond fuzzing the next day's linux-next...  So while I
> personally might have added an informal note in the commit message, I don't
> think those formal tags make sense for folded-in linux-next fixes like this.

This was discussed before and we come to conclusion that Tested-by is
a reasonable thing in such case:
https://groups.google.com/d/msg/syzkaller-bugs/xiSF9GdiikU/uBoyYyf3AQAJ
It did test the patch since it found the bug. Tested-by does not
necessary mean that the person did all possible kinds of testing on
all versions, right?
