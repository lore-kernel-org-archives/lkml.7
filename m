Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFC4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC2620659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0fNHH7wY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439868AbfJXQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:25:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733261AbfJXQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qRvbB1DtzyIxHygXmCt9H0/9hok1MUyXJRvheNP/d/A=; b=0fNHH7wYU8K5SQRItorJjuSmY
        BDNJr8VcbWKdq5PzXU7KMo3ChB2WOzqRKkNaQPggtGijmFUWibJY5cZbmoBty7Ye7npOTFCr1CvVn
        oi+w30QJVb2ACfsUGLjCyEmXuGnUG4wbByZQi6fmFgIqGjc3+507wrFWJZYnbLDvj2qkp2IkHtQlc
        oj+AxStnPUeTxuJaR0b+7/SQ1bRFOi2nDg+rGmsZbMGTtGep1aFrAnFjjF9s8QIechHZqQPi0Plhe
        ieZuCxykvVRcmsgVr7Yn7U1F5/7CaoPOqj2Yys2Sz/JT5HpHwv+6wKNXCFTkr1XPjTPB07kVJ4xGn
        L+jnPuDnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNfue-0001RD-3t; Thu, 24 Oct 2019 16:24:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DC773056C0;
        Thu, 24 Oct 2019 18:23:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3AC82100B87D; Thu, 24 Oct 2019 18:24:32 +0200 (CEST)
Date:   Thu, 24 Oct 2019 18:24:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, cyphar@cyphar.com, elena.reshetova@intel.com,
        elver@google.com, guro@fb.com, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wad@chromium.org
Subject: Re: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
Message-ID: <20191024162432.GA4097@hirez.programming.kicks-ass.net>
References: <000000000000b49e190595aa39fe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b49e190595aa39fe@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 09:07:08AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=1060c47b600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=c034966b0b02f94f7f34
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
> 
> read to 0xffff88811eef53e8 of 200 bytes by task 7738 on cpu 0:
>  vm_area_dup+0x70/0xf0 kernel/fork.c:359
>  __split_vma+0x88/0x350 mm/mmap.c:2678
>  __do_munmap+0xb02/0xb60 mm/mmap.c:2803
>  do_munmap mm/mmap.c:2856 [inline]
>  mmap_region+0x165/0xd50 mm/mmap.c:1749
>  do_mmap+0x6d4/0xba0 mm/mmap.c:1577
>  do_mmap_pgoff include/linux/mm.h:2353 [inline]
>  vm_mmap_pgoff+0x12d/0x190 mm/util.c:496
>  ksys_mmap_pgoff+0x2d8/0x420 mm/mmap.c:1629
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
>  __x64_sys_mmap+0x91/0xc0 arch/x86/kernel/sys_x86_64.c:91
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> write to 0xffff88811eef5440 of 8 bytes by task 7737 on cpu 1:
>  __rb_rotate_set_parents+0x4d/0xf0 lib/rbtree.c:79
>  __rb_insert lib/rbtree.c:215 [inline]
>  __rb_insert_augmented+0x109/0x370 lib/rbtree.c:459
>  rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
>  rb_insert_augmented_cached include/linux/rbtree_augmented.h:60 [inline]
>  vma_interval_tree_insert+0x196/0x230 mm/interval_tree.c:23
>  __vma_link_file+0xd9/0x110 mm/mmap.c:634
>  __vma_adjust+0x1ac/0x12a0 mm/mmap.c:842
>  vma_adjust include/linux/mm.h:2276 [inline]
>  __split_vma+0x208/0x350 mm/mmap.c:2707
>  split_vma+0x73/0xa0 mm/mmap.c:2736
>  mprotect_fixup+0x43f/0x510 mm/mprotect.c:413
>  do_mprotect_pkey+0x3eb/0x660 mm/mprotect.c:553
>  __do_sys_mprotect mm/mprotect.c:578 [inline]
>  __se_sys_mprotect mm/mprotect.c:575 [inline]
>  __x64_sys_mprotect+0x51/0x70 mm/mprotect.c:575
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

What is this thing trying to tell me? That the copy on alloc is racy,
because at that point the object isn't exposed yet.

How do you tell it to shut up?
