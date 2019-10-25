Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C08CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9534220578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiGYS4Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408642AbfJYJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:01:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407258AbfJYJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gjrQ8fg83s7JkiMQ9aPQVmbBcAi7+6hRtoDH8D9H/Cc=; b=SiGYS4Rc71UCK08PWGo4o0SD6
        Bow1/yoJZznhNZYFSj9LnxmX4hE01+ZMBTVVdWAPVS+0KR1JpZwrIg58HqZnkF+3SogpEp1441449
        8zK3/RRGA/i0yrcXfnL6e5ZdRghxXBKntIcGusVYswGC/Hw6Iy6NywR0R5jITvqn6fdiuZ4FOApr0
        QH59d49WSzBot3EI0+kPvHXVr7zZ8TBvja0/GA3CP2d+EltdjejTvfegEmTkphYhiJ97cqgUr6Au2
        tk27vFVH6b93d0toCB6v0nRXm8PH/3UMMUCZTgMQx69jWNvIgGwiAx5aYSG+M/FELCxD4Kt+0HKfc
        gJelI3jOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNvTA-0001pV-4p; Fri, 25 Oct 2019 09:01:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD1B53006E3;
        Fri, 25 Oct 2019 11:00:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAFB9201A6624; Fri, 25 Oct 2019 11:01:13 +0200 (CEST)
Date:   Fri, 25 Oct 2019 11:01:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        aarcange@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>, luto@amacapital.net,
        mhocko@suse.com, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
Message-ID: <20191025090113.GH4131@hirez.programming.kicks-ass.net>
References: <000000000000b49e190595aa39fe@google.com>
 <20191024162432.GA4097@hirez.programming.kicks-ass.net>
 <CANpmjNPfTeMsdwghPiocjQDg6e0c_6Ks+jfKqh1Rqb4vm6edeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPfTeMsdwghPiocjQDg6e0c_6Ks+jfKqh1Rqb4vm6edeA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 08:59:50PM +0200, Marco Elver wrote:
> On Thu, 24 Oct 2019 at 18:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 24, 2019 at 09:07:08AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > > git tree:       https://github.com/google/ktsan.git kcsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1060c47b600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c034966b0b02f94f7f34
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
> > >
> > > read to 0xffff88811eef53e8 of 200 bytes by task 7738 on cpu 0:
> > >  vm_area_dup+0x70/0xf0 kernel/fork.c:359
> > >  __split_vma+0x88/0x350 mm/mmap.c:2678
> > >  __do_munmap+0xb02/0xb60 mm/mmap.c:2803
> > >  do_munmap mm/mmap.c:2856 [inline]
> > >  mmap_region+0x165/0xd50 mm/mmap.c:1749
> > >  do_mmap+0x6d4/0xba0 mm/mmap.c:1577
> > >  do_mmap_pgoff include/linux/mm.h:2353 [inline]
> > >  vm_mmap_pgoff+0x12d/0x190 mm/util.c:496
> > >  ksys_mmap_pgoff+0x2d8/0x420 mm/mmap.c:1629
> > >  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
> > >  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
> > >  __x64_sys_mmap+0x91/0xc0 arch/x86/kernel/sys_x86_64.c:91
> > >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > write to 0xffff88811eef5440 of 8 bytes by task 7737 on cpu 1:
> > >  __rb_rotate_set_parents+0x4d/0xf0 lib/rbtree.c:79
> > >  __rb_insert lib/rbtree.c:215 [inline]
> > >  __rb_insert_augmented+0x109/0x370 lib/rbtree.c:459
> > >  rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
> > >  rb_insert_augmented_cached include/linux/rbtree_augmented.h:60 [inline]
> > >  vma_interval_tree_insert+0x196/0x230 mm/interval_tree.c:23
> > >  __vma_link_file+0xd9/0x110 mm/mmap.c:634
> > >  __vma_adjust+0x1ac/0x12a0 mm/mmap.c:842
> > >  vma_adjust include/linux/mm.h:2276 [inline]
> > >  __split_vma+0x208/0x350 mm/mmap.c:2707
> > >  split_vma+0x73/0xa0 mm/mmap.c:2736
> > >  mprotect_fixup+0x43f/0x510 mm/mprotect.c:413
> > >  do_mprotect_pkey+0x3eb/0x660 mm/mprotect.c:553
> > >  __do_sys_mprotect mm/mprotect.c:578 [inline]
> > >  __se_sys_mprotect mm/mprotect.c:575 [inline]
> > >  __x64_sys_mprotect+0x51/0x70 mm/mprotect.c:575
> > >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > What is this thing trying to tell me? That the copy on alloc is racy,
> > because at that point the object isn't exposed yet.
> 
> In vm_area_dup, *orig is being concurrently modified while being
> copied into *new.

I'm not sure how it thinks there is concurrency here though;
__split_vma() *should* be holding mmap_sem for writing.

But yes, at least all the rb-tree and list crud should be re-initialized
for the object after copy.
