Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98ACC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B71222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vFLrjiwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfIZT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:26:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40923 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfIZT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:26:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id f7so4288543qtq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Msv6XfuwBx4WufXP9Gu7nL4Uw+Bc55I+jZmvBv8DgwI=;
        b=vFLrjiwP1/YgDwOskF5vGCdkIdEhFtu2/+m8djybY9HH8qS/iuo8sy20deBUPmoax1
         DP14k6UIqTZ8rJKwg0GtV2IfsgzvlukI90gcA6ylPUo/zKQhOQrSRPzbqskbbEDW8Eyk
         MXfYga8VkdExElQaC9IK/BWQE+J+Jxg6EnZYBr5m2DJmUYO2N54ZHgundA/WyVAzyk0t
         AL1nUz/yeOY/yqEU5ZLeXW88lppaC+TVaeeHc8IIccMwfW/3NhLPT2yPjyq3MZtVmnWX
         iXqMn+dfaS/RpGjWHxIGHbhRo6jQ9S4/Ow28o8kb9vxE94SnqkJUUOZyoFV4rqeZ+POz
         8tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Msv6XfuwBx4WufXP9Gu7nL4Uw+Bc55I+jZmvBv8DgwI=;
        b=pnbj8ymdIKuiArKi4QFg3vBlmQt7fl1QU0+FFK83Eb8hd3DeiP41ACz+ufSE9RyzS+
         5KmNXmTfJoN2ieueKQAZKMhyqXJpCQQ4ngPjwuLoRNUboDK1zzlr6UCUUl5kqSNGuQmK
         2/RnCpZOAd4s1I1UbsS7mzVLpXrXipA2K5317Q90nrZ93kwmEcuq9FdkyRratdzyp+B2
         XejUsjdjqOWPyK6Td5jJGrQ6EeAgZ0H1aHrmTa9P1Q0s/GsPL0vxRCEG25A5yKoeuOen
         BRiEl9MJjfx4uAshhWocTXp7FbzstX8ugqgmGX5uGDlwDiu94tA1h296Z4TLwEoD3nNb
         mFog==
X-Gm-Message-State: APjAAAUYCbUDlpZF3wW0JIJ+yQ+gg60fvJDFRGAR9N9o0bdORaArDg7C
        0LnowS0RDp/KudMdtrSrVW6yjQ==
X-Google-Smtp-Source: APXvYqyg5Y9Yj88JGhbeGGKXyfc8SNuDTKBl3OgtSTGVPc0WUzYpWFOFHclneJlxpNXr3oG4kbcOVw==
X-Received: by 2002:aed:2786:: with SMTP id a6mr5779343qtd.28.1569525985953;
        Thu, 26 Sep 2019 12:26:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:cdc2])
        by smtp.gmail.com with ESMTPSA id t19sm1421087qto.55.2019.09.26.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:26:25 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:26:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190926192624.GA12439@cmpxchg.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
 <20190924204608.GI1855@bombadil.infradead.org>
 <20190924214337.GA17405@cmpxchg.org>
 <20190926134923.wqlkymjdfxd4iymh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926134923.wqlkymjdfxd4iymh@box>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 04:49:23PM +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 24, 2019 at 05:43:37PM -0400, Johannes Weiner wrote:
> > On Tue, Sep 24, 2019 at 01:46:08PM -0700, Matthew Wilcox wrote:
> > > On Tue, Sep 24, 2019 at 03:42:38PM -0400, Johannes Weiner wrote:
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks!

> From bdf96fe9e3c1a319e9fd131efbe0118ea41a41b1 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Thu, 26 Sep 2019 16:34:26 +0300
> Subject: [PATCH] shmem: Pin the file in shmem_fault() if mmap_sem is dropped
> 
> syzbot found the following crash:
> 
>  BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530
>  include/trace/events/lock.h:13
>  Read of size 8 at addr ffff8880a5cf2c50 by task syz-executor.0/26173
> 
>  CPU: 0 PID: 26173 Comm: syz-executor.0 Not tainted 5.3.0-rc6 #146
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>  Google 01/01/2011
>  Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>    print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
>    __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
>    kasan_report+0x12/0x17 mm/kasan/common.c:618
>    __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
>    perf_trace_lock_acquire+0x401/0x530 include/trace/events/lock.h:13
>    trace_lock_acquire include/trace/events/lock.h:13 [inline]
>    lock_acquire+0x2de/0x410 kernel/locking/lockdep.c:4411
>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
>    spin_lock include/linux/spinlock.h:338 [inline]
>    shmem_fault+0x5ec/0x7b0 mm/shmem.c:2034
>    __do_fault+0x111/0x540 mm/memory.c:3083
>    do_shared_fault mm/memory.c:3535 [inline]
>    do_fault mm/memory.c:3613 [inline]
>    handle_pte_fault mm/memory.c:3840 [inline]
>    __handle_mm_fault+0x2adf/0x3f20 mm/memory.c:3964
>    handle_mm_fault+0x1b5/0x6b0 mm/memory.c:4001
>    do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
>    __do_page_fault+0x536/0xdd0 arch/x86/mm/fault.c:1506
>    do_page_fault+0x38/0x590 arch/x86/mm/fault.c:1530
>    page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1202
> 
> It happens if the VMA got unmapped under us while we dropped mmap_sem
> and inode got freed.
> 
> Pinning the file if we drop mmap_sem fixes the issue.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I have just one nitpick:

> @@ -2022,16 +2022,14 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  		    shmem_falloc->waitq &&
>  		    vmf->pgoff >= shmem_falloc->start &&
>  		    vmf->pgoff < shmem_falloc->next) {
> +			struct file *fpin = NULL;

That initialization seems unnecessary, as the fpin assignment below is
unconditional in the variable's scope.

The second argument to maybe_unlock_mmap_for_io() for tracking state
when the function is called multiple times in the filemap fault goto
maze, we shouldn't need that here for a simple invocation.

>  			wait_queue_head_t *shmem_falloc_waitq;
>  			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
>  
>  			ret = VM_FAULT_NOPAGE;
> -			if ((vmf->flags & FAULT_FLAG_ALLOW_RETRY) &&
> -			   !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
> -				/* It's polite to up mmap_sem if we can */
> -				up_read(&vma->vm_mm->mmap_sem);
> +			fpin = maybe_unlock_mmap_for_io(vmf, fpin);

I.e. this:

			fpin = maybe_unlock_mmap_for_io(vmf, NULL);

> +			if (fpin)
>  				ret = VM_FAULT_RETRY;
> -			}
>  
>  			shmem_falloc_waitq = shmem_falloc->waitq;
>  			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> @@ -2049,6 +2047,9 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  			spin_lock(&inode->i_lock);
>  			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
>  			spin_unlock(&inode->i_lock);
> +
> +			if (fpin)
> +				fput(fpin);
>  			return ret;
>  		}
>  		spin_unlock(&inode->i_lock);
