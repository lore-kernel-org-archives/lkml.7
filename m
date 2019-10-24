Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EDCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C268F21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ii2r79Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394182AbfJXTAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:00:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46433 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390493AbfJXTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:00:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so21543546oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZrSMPu/e6BXUdEIOUcOkTaeF4a2vUNu+HOk7EqusHk=;
        b=ii2r79JrxO4W/+AltDDnipA6v8AYCjoTvxzErHC4fsMuwU9OX/JQYyCiHpt2/aWzSW
         JqTLXdd4d91DoApvs//Rxbn3y/lQW11BG4rQHthZ6CgoJ3HD6Ny5gvIuqafYl3TmKfpX
         x47weENDi9qMN3t+NcCkzsW8SkH31pCCwYZf1gFKNCeF1nYYRXtTp7KUyQaR+Tz8qNi+
         TRyeJjuzd2NCwhqqQJYRb45ngpf7IyVkjfNCPzkz1elc96gSPmVvm1N0yj8QijdaO14W
         amMnewlPycMv50LUh8nLAzeRNbK56XkDiD1fUImaIYbxv84SykH1djPoBcvZYysxFp26
         7Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZrSMPu/e6BXUdEIOUcOkTaeF4a2vUNu+HOk7EqusHk=;
        b=rMOaF+OgVbVMrkjN6zJNXJPRWsIGP/uHPzwKzL+zeuCquAy+BdP8ROjbf3qOGSUCOz
         jROw1upvb4KZdqgkAaOa0Xd9HwbtIarHVy+Vzt57daSqO9xw7BgoDeUp7KSYjlirab65
         x0FYQwCWeHRI/33oGpew8hgRSVGyyJpTrHgBF/xnkfYWgsRl98VIc//prWG1ro90epBx
         PnBQerlxAupixFkyPACvGoNUgcVDW3ymqmGk2zCvlWcW6pUf28eQPUGNkK0DNG3Y69dk
         ev8XC6xFqxNLSK4jj+02vBRdK7XhjpHYbD/4ZQZCUkWkFEqnX2AaKcSd7BpaEEIuOo0N
         BgLg==
X-Gm-Message-State: APjAAAUaCmIxMh2Ozmlao4cg8+rfvUwBj1aVrlLpajvXB7gnsfez+zh/
        Pxz7pBTY6P5SIJ4LsIN43igsHi08YJTBztBIRZR5AA==
X-Google-Smtp-Source: APXvYqy7KOpcCjwUn9hCaZeF/eWIhLGxf+u8iFlSSssAFUwD03cvY4TKXfNKw9riL/HBNgMdRAtT/hNFxf2TGV7d7NA=
X-Received: by 2002:aca:f17:: with SMTP id 23mr5693390oip.155.1571943601922;
 Thu, 24 Oct 2019 12:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b49e190595aa39fe@google.com> <20191024162432.GA4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191024162432.GA4097@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Oct 2019 20:59:50 +0200
Message-ID: <CANpmjNPfTeMsdwghPiocjQDg6e0c_6Ks+jfKqh1Rqb4vm6edeA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        aarcange@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>, luto@amacapital.net,
        mhocko@suse.com, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 at 18:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 24, 2019 at 09:07:08AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1060c47b600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c034966b0b02f94f7f34
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
> >
> > read to 0xffff88811eef53e8 of 200 bytes by task 7738 on cpu 0:
> >  vm_area_dup+0x70/0xf0 kernel/fork.c:359
> >  __split_vma+0x88/0x350 mm/mmap.c:2678
> >  __do_munmap+0xb02/0xb60 mm/mmap.c:2803
> >  do_munmap mm/mmap.c:2856 [inline]
> >  mmap_region+0x165/0xd50 mm/mmap.c:1749
> >  do_mmap+0x6d4/0xba0 mm/mmap.c:1577
> >  do_mmap_pgoff include/linux/mm.h:2353 [inline]
> >  vm_mmap_pgoff+0x12d/0x190 mm/util.c:496
> >  ksys_mmap_pgoff+0x2d8/0x420 mm/mmap.c:1629
> >  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
> >  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
> >  __x64_sys_mmap+0x91/0xc0 arch/x86/kernel/sys_x86_64.c:91
> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > write to 0xffff88811eef5440 of 8 bytes by task 7737 on cpu 1:
> >  __rb_rotate_set_parents+0x4d/0xf0 lib/rbtree.c:79
> >  __rb_insert lib/rbtree.c:215 [inline]
> >  __rb_insert_augmented+0x109/0x370 lib/rbtree.c:459
> >  rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
> >  rb_insert_augmented_cached include/linux/rbtree_augmented.h:60 [inline]
> >  vma_interval_tree_insert+0x196/0x230 mm/interval_tree.c:23
> >  __vma_link_file+0xd9/0x110 mm/mmap.c:634
> >  __vma_adjust+0x1ac/0x12a0 mm/mmap.c:842
> >  vma_adjust include/linux/mm.h:2276 [inline]
> >  __split_vma+0x208/0x350 mm/mmap.c:2707
> >  split_vma+0x73/0xa0 mm/mmap.c:2736
> >  mprotect_fixup+0x43f/0x510 mm/mprotect.c:413
> >  do_mprotect_pkey+0x3eb/0x660 mm/mprotect.c:553
> >  __do_sys_mprotect mm/mprotect.c:578 [inline]
> >  __se_sys_mprotect mm/mprotect.c:575 [inline]
> >  __x64_sys_mprotect+0x51/0x70 mm/mprotect.c:575
> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> What is this thing trying to tell me? That the copy on alloc is racy,
> because at that point the object isn't exposed yet.

In vm_area_dup, *orig is being concurrently modified while being
copied into *new.

> How do you tell it to shut up?

We wanted to get feedback on what is happening here, as it didn't seem
straightforward to dismiss on our side.

Is it correct to assume that, the parts of the *orig struct that are
being modified while being copied, will subsequently be re-initialized
for *new?

If no explicit markings are useful (READ_ONCE would suppress it, but
seems strange if the above assumption is true), I will think of a way
to suppress these for now and no further action is needed here.

Many thanks,
-- Marco
