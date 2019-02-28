Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D91218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6ouqv1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfB1RyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:54:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39775 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1RyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:54:12 -0500
Received: by mail-io1-f67.google.com with SMTP id x3so17311540ior.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GsBb/zGrVdUQYJA1B0OjvALHOlIwmY2YbdIpuIpRiU=;
        b=D6ouqv1GCQsfSsG3biNBcMQ7ane/lKi6C6o0VwbtOpvPIhNngjN9myBHxv7FWIqXVo
         JRnSvdUkXYAYVROMYjKCZZwFQShRu/1f2KHqJzGE5CG8fVVJDSNAVpitw2/rRoyP1f9Y
         LA8/N1FPirOh+jBo292MkTf6u/yKfDmQ0qLTH0LnUODW8S8g574DBqGAInXX7meU+P9K
         +snfDX5d4Mzb6vcvCM2iVGmClfkVCS9C7Qj+UalE4FjmXxNH2gyY1mL0QV1wLd481uYf
         GegXGB0j99URq5LUD66eqViR3rAGX4nfUZwsT9Ai8j4VwFzag/3lwppMjrIJP6MTwUkJ
         2wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GsBb/zGrVdUQYJA1B0OjvALHOlIwmY2YbdIpuIpRiU=;
        b=dk/2x7mFP0Y9Br6wpZ3Apc4FNaAotgXa0OMpJ6NlawuDgUECgNV6P4Pvl4FFjPXHOu
         leiXMEmgWLo/i65dMcaACM8NWJoH5lL8JumCGoIGKrSygFu1/nu0+pleXlPW+HiLMzid
         hlBJWkwntX3wAENgrwVB1kRhNosee2FCVTbqYS18uObhxqGXzQ3Q/KZcBTZMCA4RmF+1
         Fkuz/lf3Putt1AbiU6v8EK2N909VjFrp6k8WV/QifYgNwKecbgq3UdhAovowmc+tedil
         raY+jYKSHAexlaUCWOhdqVsxz6JZ1WTj8MqmuPo7FfvhDI3YSbCvPmWxXFrj0iALD577
         W31A==
X-Gm-Message-State: APjAAAU3758xpDWqprx7FYAYLWLV6U3NWR8iGMDdtwECtk0JpOVpmeNj
        I9OZLym1WXJvhEIjm2l999S0c3L3I2ypHLFlfacB2g==
X-Google-Smtp-Source: APXvYqwfQDKQhT2WygWw1UsU1oBWFsJfl7kUl9TOPwtRqXS6iGdhFS4roNyy20LEPjW9t7s2rT/tIMbxOCimO+bADbY=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr300903ioc.282.1551376451272;
 Thu, 28 Feb 2019 09:54:11 -0800 (PST)
MIME-Version: 1.0
References: <00000000000024b3aa0582f1cde7@google.com> <CACT4Y+byrcaasUaEJj=hcemEEBBkon=VC24gPwGXHzfeRP0E3w@mail.gmail.com>
 <20190228174250.GB663@sol.localdomain> <54e34bcb-7de7-4488-cead-3ea3a2b71ed7@kernel.dk>
In-Reply-To: <54e34bcb-7de7-4488-cead-3ea3a2b71ed7@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 18:53:58 +0100
Message-ID: <CACT4Y+Zy4uY+guS3ZBZAtg-ES5-351mKSOfKxpZySafur+XvCw@mail.gmail.com>
Subject: Re: BUG: Bad page state (6)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+6f5a9b79b75b66078bf0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        arunks@codeaurora.org, Dan Williams <dan.j.williams@intel.com>,
        Lance Roy <ldr709@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        nborisov@suse.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 6:51 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/28/19 10:42 AM, Eric Biggers wrote:
> > On Thu, Feb 28, 2019 at 11:36:21AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> >> On Thu, Feb 28, 2019 at 11:32 AM syzbot
> >> <syzbot+6f5a9b79b75b66078bf0@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    42fd8df9d1d9 Add linux-next specific files for 20190228
> >>> git tree:       linux-next
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=179ba9e0c00000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=6f5a9b79b75b66078bf0
> >>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ed6bd0c00000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10690c8ac00000
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+6f5a9b79b75b66078bf0@syzkaller.appspotmail.com
> >>
> >> +Jens, Eric,
> >>
> >> Looks similar to:
> >> https://groups.google.com/forum/#!msg/syzkaller-bugs/E3v3XQweVBw/6BPrkIYJIgAJ
> >> Perhaps the fixing commit is not in the build yet?
> >>
> >>
> >>> BUG: Bad page state in process syz-executor193  pfn:9225a
> >>> page:ffffea0002489680 count:0 mapcount:0 mapping:ffff88808652fd80 index:0x81
> >>> shmem_aops
> >>> name:"memfd:cgroup2"
> >>> flags: 0x1fffc000008000e(referenced|uptodate|dirty|swapbacked)
> >>> raw: 01fffc000008000e ffff88809277fac0 ffff88809277fac0 ffff88808652fd80
> >>> raw: 0000000000000081 0000000000000000 00000000ffffffff 0000000000000000
> >>> page dumped because: non-NULL mapping
> >>> Modules linked in:
> >>> CPU: 0 PID: 7659 Comm: syz-executor193 Not tainted 5.0.0-rc8-next-20190228
> >>> #45
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >>> Google 01/01/2011
> >>> Call Trace:
> >>>   __dump_stack lib/dump_stack.c:77 [inline]
> >>>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >>>   bad_page.cold+0xda/0xff mm/page_alloc.c:586
> >>>   free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1013
> >>>   free_pages_check mm/page_alloc.c:1022 [inline]
> >>>   free_pages_prepare mm/page_alloc.c:1112 [inline]
> >>>   free_pcp_prepare mm/page_alloc.c:1137 [inline]
> >>>   free_unref_page_prepare mm/page_alloc.c:3001 [inline]
> >>>   free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3070
> >>>   release_pages+0x60d/0x1940 mm/swap.c:794
> >>>   pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
> >>>   activate_page_drain mm/swap.c:297 [inline]
> >>>   lru_add_drain_cpu+0x3b1/0x520 mm/swap.c:596
> >>>   lru_add_drain+0x20/0x60 mm/swap.c:647
> >>>   exit_mmap+0x290/0x530 mm/mmap.c:3134
> >>>   __mmput kernel/fork.c:1047 [inline]
> >>>   mmput+0x15f/0x4c0 kernel/fork.c:1068
> >>>   exit_mm kernel/exit.c:546 [inline]
> >>>   do_exit+0x816/0x2fa0 kernel/exit.c:863
> >>>   do_group_exit+0x135/0x370 kernel/exit.c:980
> >>>   __do_sys_exit_group kernel/exit.c:991 [inline]
> >>>   __se_sys_exit_group kernel/exit.c:989 [inline]
> >>>   __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
> >>>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>> RIP: 0033:0x442a58
> >>> Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0
> >>> 0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff
> >>> ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
> >>> RSP: 002b:00007ffe99e2faf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> >>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442a58
> >>> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> >>> RBP: 00000000004c2468 R08: 00000000000000e7 R09: ffffffffffffffd0
> >>> R10: 0000000002000005 R11: 0000000000000246 R12: 0000000000000001
> >>> R13: 00000000006d4180 R14: 0000000000000000 R15: 0000000000000000
> >>>
> >>>
> >>> ---
> >>> This bug is generated by a bot. It may contain errors.
> >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>
> >>> syzbot will keep track of this bug report. See:
> >>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> >>> syzbot.
> >>> syzbot can test patches for this bug, for details see:
> >>> https://goo.gl/tpsmEJ#testing-patches
> >>>
> >>> --
> >>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> >>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000024b3aa0582f1cde7%40google.com.
> >>> For more options, visit https://groups.google.com/d/optout.
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CACT4Y%2BbyrcaasUaEJj%3DhcemEEBBkon%3DVC24gPwGXHzfeRP0E3w%40mail.gmail.com.
> >> For more options, visit https://groups.google.com/d/optout.
> >
> > It bisects down to the same patch ("block: implement bio helper to add iter bvec
> > pages to bio") so apparently it's just still broken despite Jens' fix.
> >
> > BTW, as this is trivially bisectable with the reproducer, I still don't see why
> > syzbot can't do the bisection itself and use get_maintainer.pl on the broken
> > patch to actually send the report to the right person:
> >
> > $ ./scripts/get_maintainer.pl 0001-block-implement-bio-helper-to-add-iter-bvec-pages-to.patch
> > Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
> > linux-block@vger.kernel.org (open list:BLOCK LAYER)
> > linux-kernel@vger.kernel.org (open list)
> >
> > Spamming unrelated lists and maintainers not only prevents the bug from being
> > fixed, but it also reduces the average usefulness of syzbot reports which
> > teaches people to ignore them.
>
> Huh, weird. Where's the reproducer for this one?

Under the "C reproducer" link.
