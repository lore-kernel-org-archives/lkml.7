Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608DEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D89207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AheNdYdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfIZNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:49:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42666 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:49:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so2071622ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R7IVgyPRRFSRpfOxm+EKyWEaPrHUhyy8HY8QC9TtB90=;
        b=AheNdYdj+hkNO+S8EXNMukRLxHVmIh0bnd/ch7crrrfRv98oLH8zy2IjXS7tLP25aV
         gqFOfwBiLMh9KbXz4CM+N2QGfj4kr391ypiQET4KiXUoCZsph9dv+qL4F329L7pyO/yU
         MFj2MVznPZnZ5aTxcQ5UfEBcxsieQH5lRG/IeG4rHvATWu9NyGYXtupY4hyzxov+7BS1
         N9ZCQ+x+nb7bXfYu7Yk6kBQMoKIDhMNRb5WoEkjhdff/G2ZrNVeOGKjsh5V1p7FcwskS
         KQY+NoebY2vujC3Thb09RuPonrESr7ZpAtVRt504l2S03EVBcAqPIBizHr6TRguYx6GS
         nvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7IVgyPRRFSRpfOxm+EKyWEaPrHUhyy8HY8QC9TtB90=;
        b=O/iSOvbkHb+x8z2YR0260qALHH0jIv67xYIsuCT6iJ3QRuqqUMin1pxe9J9wxp/W/c
         nvqgIOqwhDxqFMY+aIgRsnNsSdrFNQjBVUXWWKgy6i5p9t7lTrJwVjVHaaJfj78ZYHEa
         4CtM2q84sl5gebRRYOYqbcwgp/HcoN4cliOBMBkxY1znT+MaS9FKcx3MKuQG5tr25fQS
         9r7mDbjVeY9ucvd5eX/Nurv92EozUV9ZS/rw9a01tnAn/sarKbxsZ/rqBzFGpWMWVg1P
         p9iNh04s5JrHAdPyKhEc5ZgKzxwvPFG1G6EpNi0DLKqm9FD4+BJVMRa/EJf6G1Io8vLP
         LBHQ==
X-Gm-Message-State: APjAAAXI8OKSexmQmgTOOtMBFPAeuDNYeEVZzhB1wWxlUZYg2v17RruQ
        weEw7ADNUsbAGD9IjMeG+a9P+Cg8K1eGbw==
X-Google-Smtp-Source: APXvYqw86wfoEOyTVA3I0tRhS0nWJrqIDDVvBSMqRIiz0mbo+4NpYm3V5q3h2K8PIemh3yDNdDUR5g==
X-Received: by 2002:a50:99da:: with SMTP id n26mr3671012edb.293.1569505761791;
        Thu, 26 Sep 2019 06:49:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j8sm482292edy.44.2019.09.26.06.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:49:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E5533101CFB; Thu, 26 Sep 2019 16:49:23 +0300 (+03)
Date:   Thu, 26 Sep 2019 16:49:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190926134923.wqlkymjdfxd4iymh@box>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
 <20190924204608.GI1855@bombadil.infradead.org>
 <20190924214337.GA17405@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924214337.GA17405@cmpxchg.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:43:37PM -0400, Johannes Weiner wrote:
> On Tue, Sep 24, 2019 at 01:46:08PM -0700, Matthew Wilcox wrote:
> > On Tue, Sep 24, 2019 at 03:42:38PM -0400, Johannes Weiner wrote:
> > > > I'm not a fan of moving file_update_time() to _before_ the
> > > > balance_dirty_pages call.
> > > 
> > > Can you elaborate why? If the filesystem has a page_mkwrite op, it
> > > will have already called file_update_time() before this function is
> > > entered. If anything, this change makes the sequence more consistent.
> > 
> > Oh, that makes sense.  I thought it should be updated after all the data
> > was written, but it probably doesn't make much difference.
> > 
> > > > Also, this is now the third place that needs
> > > > maybe_unlock_mmap_for_io, see
> > > > https://lore.kernel.org/linux-mm/20190917120852.x6x3aypwvh573kfa@box/
> > > 
> > > Good idea, I moved the helper to internal.h and converted to it.
> > > 
> > > I left the shmem site alone, though. It doesn't require the file
> > > pinning, so it shouldn't pointlessly bump the file refcount and
> > > suggest such a dependency - that could cost somebody later quite a bit
> > > of time trying to understand the code.
> > 
> > The problem for shmem is this:
> > 
> >                         spin_unlock(&inode->i_lock);
> >                         schedule();
> > 
> >                         spin_lock(&inode->i_lock);
> >                         finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
> >                         spin_unlock(&inode->i_lock);
> > 
> > While scheduled, the VMA can go away and the inode be reclaimed, making
> > this a use-after-free.  The initial suggestion was an increment on
> > the inode refcount, but since we already have a pattern which involves
> > pinning the file, I thought that was a better way to go.
> 
> I completely read over the context of that email you linked - that
> there is a bug in the existing code - and looked at it as mere
> refactoring patch. My apologies.
> 
> Switching that shmem site to maybe_unlock_mmap_for_io() to indirectly
> pin the inode (in a separate bug fix patch) indeed makes sense to me.

The patch on top of this one is below. Please post them together if you are
going to resend yours.
> 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

From bdf96fe9e3c1a319e9fd131efbe0118ea41a41b1 Mon Sep 17 00:00:00 2001
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
Cc: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 30ce722c23fa..f672e4145cfd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2022,16 +2022,14 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		    shmem_falloc->waitq &&
 		    vmf->pgoff >= shmem_falloc->start &&
 		    vmf->pgoff < shmem_falloc->next) {
+			struct file *fpin = NULL;
 			wait_queue_head_t *shmem_falloc_waitq;
 			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
 
 			ret = VM_FAULT_NOPAGE;
-			if ((vmf->flags & FAULT_FLAG_ALLOW_RETRY) &&
-			   !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
-				/* It's polite to up mmap_sem if we can */
-				up_read(&vma->vm_mm->mmap_sem);
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
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
2.21.0

-- 
 Kirill A. Shutemov
