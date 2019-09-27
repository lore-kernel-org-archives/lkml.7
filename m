Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735F2217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pxW2QGX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfI0IjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:39:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34304 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0IjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:39:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id p10so1646334edq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndEvsrlgqf/+JNY1iKbrN6I2n99EViOwtwmCGIHFch0=;
        b=pxW2QGX/B0y+4xjmfvcoNOv7GjD50zyyruQTwfdC/B94rKZ63vJJ6SHkz6577KJuyD
         81cJ4kXgRxhNdpzQA4OToKN7jIIhOzKG7n7RccxPGvNBCi2Rw6LiJHZLyfolX+PP2HoW
         WNW1FHQ6hQFWCx7qyTwjLohYekbbNOtGctqxU5qsjdUUDYJqnUr9A4h0xggdMBwrUq5V
         bIFvkQiPut+dwpM6b2h6z6q4v4W8RIaQI9WfNuFGrSrxN6nKRwBjhELqSNQS4zm2HujM
         +qg2s3iojbjIx3HdeQF5I0o0bIjBLtOXcTDBFuQkgR0J4KmBVtXoYc9bKzwBSyFeyFlQ
         bNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndEvsrlgqf/+JNY1iKbrN6I2n99EViOwtwmCGIHFch0=;
        b=nKZQka1TIhwlYKsfVRvEn0XWmBNPa9NuMRR/ym1M1O+uZ8K+Odyo8JZ88vM2DcBNNl
         bdzzBZbVr940FinfXuNRbqmV/2TZMpuEZs8GtVqPoHwaSX6AthLn9q74pdjtdbsSKdVw
         jIRJJpd1UEaiU6GOlpLtumAjoUoICBKpRDqfOz5AkQCzULVFxc+19Av/tUKez2ZzIzHc
         LPaVf5Rb/Ap1nt7aKu0bFFdL0iQQsHEkHU3bE64D2ko6kri6Uv88+YRiUBtbliDF3SIE
         yKXzMFGeitg3JnVFqtDQpvckOLviUl9z2NEY/HV48k2meyzPDaLijc6J99eEDjozx782
         yNwA==
X-Gm-Message-State: APjAAAVZoyOplozGMh5q0tWROb6daBbkM3H/aBHm2XvLQWxsY0f5suXX
        WFcxRfh39dIONZKJqvO5Psod8ot+fFTzAA==
X-Google-Smtp-Source: APXvYqxrn8qSCPW4Yk+BsBfFrhkqeHPJ+cfsHT7+RG2EqYe6pxI7nug+YGMdfivPfibkExjxKtu69A==
X-Received: by 2002:a50:f747:: with SMTP id j7mr3154901edn.73.1569573545439;
        Fri, 27 Sep 2019 01:39:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s42sm378612edm.57.2019.09.27.01.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 01:39:04 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 17CB7101F61; Fri, 27 Sep 2019 11:39:08 +0300 (+03)
Date:   Fri, 27 Sep 2019 11:39:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190927083908.rhifa4mmaxefc24r@box>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
 <20190924204608.GI1855@bombadil.infradead.org>
 <20190924214337.GA17405@cmpxchg.org>
 <20190926134923.wqlkymjdfxd4iymh@box>
 <20190926192624.GA12439@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926192624.GA12439@cmpxchg.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:26:24PM -0400, Johannes Weiner wrote:
> I have just one nitpick:

Here's addressed one:

From 22a9d58a79a3ebb727d9e909c8f833cd0a751c08 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 26 Sep 2019 16:34:26 +0300
Subject: [PATCH] shmem: Pin the file in shmem_fault() if mmap_sem is dropped

syzbot found the following crash:

 BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530
 include/trace/events/lock.h:13
 Read of size 8 at addr ffff8880a5cf2c50 by task syz-executor.0/26173

 CPU: 0 PID: 26173 Comm: syz-executor.0 Not tainted 5.3.0-rc6 #146
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
 Google 01/01/2011
 Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
   print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
   __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
   kasan_report+0x12/0x17 mm/kasan/common.c:618
   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
   perf_trace_lock_acquire+0x401/0x530 include/trace/events/lock.h:13
   trace_lock_acquire include/trace/events/lock.h:13 [inline]
   lock_acquire+0x2de/0x410 kernel/locking/lockdep.c:4411
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   shmem_fault+0x5ec/0x7b0 mm/shmem.c:2034
   __do_fault+0x111/0x540 mm/memory.c:3083
   do_shared_fault mm/memory.c:3535 [inline]
   do_fault mm/memory.c:3613 [inline]
   handle_pte_fault mm/memory.c:3840 [inline]
   __handle_mm_fault+0x2adf/0x3f20 mm/memory.c:3964
   handle_mm_fault+0x1b5/0x6b0 mm/memory.c:4001
   do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
   __do_page_fault+0x536/0xdd0 arch/x86/mm/fault.c:1506
   do_page_fault+0x38/0x590 arch/x86/mm/fault.c:1530
   page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1202

It happens if the VMA got unmapped under us while we dropped mmap_sem
and inode got freed.

Pinning the file if we drop mmap_sem fixes the issue.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 30ce722c23fa..0601ad615ccb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2022,16 +2022,14 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		    shmem_falloc->waitq &&
 		    vmf->pgoff >= shmem_falloc->start &&
 		    vmf->pgoff < shmem_falloc->next) {
+			struct file *fpin;
 			wait_queue_head_t *shmem_falloc_waitq;
 			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
 
 			ret = VM_FAULT_NOPAGE;
-			if ((vmf->flags & FAULT_FLAG_ALLOW_RETRY) &&
-			   !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
-				/* It's polite to up mmap_sem if we can */
-				up_read(&vma->vm_mm->mmap_sem);
+			fpin = maybe_unlock_mmap_for_io(vmf, NULL);
+			if (fpin)
 				ret = VM_FAULT_RETRY;
-			}
 
 			shmem_falloc_waitq = shmem_falloc->waitq;
 			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
@@ -2049,6 +2047,9 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 			spin_lock(&inode->i_lock);
 			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
 			spin_unlock(&inode->i_lock);
+
+			if (fpin)
+				fput(fpin);
 			return ret;
 		}
 		spin_unlock(&inode->i_lock);
-- 
 Kirill A. Shutemov
