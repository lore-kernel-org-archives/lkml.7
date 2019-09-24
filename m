Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D789B21783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Kaa8D01n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441929AbfIXTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:42:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42725 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441488AbfIXTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:42:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so3051357qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMciHmBxHBQDxyP+Eh+I154TeCeJbBEgcjucUWxN/D0=;
        b=Kaa8D01nxH31BY/wU1r4Y14uNM+Tkf9xBu0lA6+ubSaYpvT6frXQYrBgbuMJQQqehS
         7TIiW3k/q72rVwFPiY6FtgItUs92dyablCd+wIa92fSWPErBIM3MIH9cf7DUQDUEQaLC
         +cwpbjBG4uBDui0S82iQVbz3XguCwKQ644Rv+LUNzk6Zot2Z4fpBrsQu7RJwJSZ2LS0L
         nu+ULRswP69lsXHtxHL4P4mAAM3PQvmBsVC2lZKNH9s3Z/X9VP7BAmyRCg1eDD7/65oD
         mH/UPwXJAN3TX90hq3LLvn7GJleI6kUXuG2T8qNATOVTtXmmxevLXKXkU0GLRxGu4+kE
         iIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMciHmBxHBQDxyP+Eh+I154TeCeJbBEgcjucUWxN/D0=;
        b=Wxv3q4E/+G8zQQ94a0/yFcEIfUtT8pqOQwfC5hdKeIASicWAZOY+fF7t14ydLY+0qb
         9ofi+oyxsS0IUiarDrtpaYlSJP+H81Am87Iv/D9KCo2NGb6H23TUDsxQWYqNbkkfnV+e
         4KWK5A+hIAFo/SWuQRr2lHrhlkEDwAlX0XJyWZWIWAjhv5xvK+ocRPev1OSjG4/faPgR
         CZ0EmD1B36xXcLm0zCEK8i3p7fQcuBbdpBKVWFqv8Yl2xjONhRn1Hb9bcIX8SCWnilwc
         Lc4nlI06XmiIb26SxA+R/eIPnS6l4lyTLsL5y6Or6UyZe//WqReNHTrZ2d/t4Scqrvo8
         5s3w==
X-Gm-Message-State: APjAAAXI4EtG3NofZkvYlFIAozySubJ40u4Ydpko1A3UIWgZLVd0CFPE
        vnG1AoKhEeQ5JYbR3y18UyamOEgC/Bc=
X-Google-Smtp-Source: APXvYqwmixPwLaGzBg6yXlhJamU8ogD8OKXEaJ/g1PkbV9sgFWUKBzennCFpy+4sp5ElfzNfn9QM5w==
X-Received: by 2002:a37:6292:: with SMTP id w140mr4250295qkb.24.1569354160079;
        Tue, 24 Sep 2019 12:42:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::a51])
        by smtp.gmail.com with ESMTPSA id z141sm1516042qka.126.2019.09.24.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:42:39 -0700 (PDT)
Date:   Tue, 24 Sep 2019 15:42:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190924194238.GA29030@cmpxchg.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924174809.GH1855@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:48:09AM -0700, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 01:15:18PM -0400, Johannes Weiner wrote:
> > +static int fault_dirty_shared_page(struct vm_fault *vmf)
> 
> vm_fault_t, shirley?

Ah yes, I changed it.

> > @@ -2239,16 +2241,36 @@ static void fault_dirty_shared_page(struct vm_area_struct *vma,
> >  	mapping = page_rmapping(page);
> >  	unlock_page(page);
> >  
> > +	if (!page_mkwrite)
> > +		file_update_time(vma->vm_file);
> > +
> > +	/*
> > +	 * Throttle page dirtying rate down to writeback speed.
> > +	 *
> > +	 * mapping may be NULL here because some device drivers do not
> > +	 * set page.mapping but still dirty their pages
> > +	 *
> > +	 * Drop the mmap_sem before waiting on IO, if we can. The file
> > +	 * is pinning the mapping, as per above.
> > +	 */
> >  	if ((dirtied || page_mkwrite) && mapping) {
> > -		/*
> > -		 * Some device drivers do not set page.mapping
> > -		 * but still dirty their pages
> > -		 */
> > +		struct file *fpin = NULL;
> > +
> > +		if ((vmf->flags &
> > +		     (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
> > +		    FAULT_FLAG_ALLOW_RETRY) {
> > +			fpin = get_file(vma->vm_file);
> > +			up_read(&vma->vm_mm->mmap_sem);
> > +			ret = VM_FAULT_RETRY;
> > +		}
> > +
> >  		balance_dirty_pages_ratelimited(mapping);
> > +
> > +		if (fpin)
> > +			fput(fpin);
> >  	}
> >  
> > -	if (!page_mkwrite)
> > -		file_update_time(vma->vm_file);
> > +	return ret;
> >  }
> 
> I'm not a fan of moving file_update_time() to _before_ the
> balance_dirty_pages call.

Can you elaborate why? If the filesystem has a page_mkwrite op, it
will have already called file_update_time() before this function is
entered. If anything, this change makes the sequence more consistent.

> Also, this is now the third place that needs
> maybe_unlock_mmap_for_io, see
> https://lore.kernel.org/linux-mm/20190917120852.x6x3aypwvh573kfa@box/

Good idea, I moved the helper to internal.h and converted to it.

I left the shmem site alone, though. It doesn't require the file
pinning, so it shouldn't pointlessly bump the file refcount and
suggest such a dependency - that could cost somebody later quite a bit
of time trying to understand the code.

> How about:
> 
> +	struct file *fpin = NULL;
> 
>  	if ((dirtied || page_mkwrite) && mapping) {
> 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		balance_dirty_pages_ratelimited(mapping);
> 	}
> +
> +	if (fpin) {
> +		file_update_time(fpin);

This isn't an equivalent change and could update the time twice if the
fs has a page_mkwrite op.

> +		fput(fpin);
> +		return VM_FAULT_RETRY;
> +	}
> 
>  	if (!page_mkwrite)
>  		file_update_time(vma->vm_file);
> +	return 0;
>  }
> 
> >  /*
> > @@ -2491,6 +2513,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
> >  	__releases(vmf->ptl)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> > +	int ret = VM_FAULT_WRITE;
> 
> vm_fault_t again.

Done.

> > @@ -3576,7 +3599,6 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
> >  static vm_fault_t do_fault(struct vm_fault *vmf)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> > -	struct mm_struct *vm_mm = vma->vm_mm;
> >  	vm_fault_t ret;
> >  
> >  	/*
> > @@ -3617,7 +3639,12 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
> >  
> >  	/* preallocated pagetable is unused: free it */
> >  	if (vmf->prealloc_pte) {
> > -		pte_free(vm_mm, vmf->prealloc_pte);
> > +		/*
> > +		 * XXX: Accessing vma->vm_mm now is not safe. The page
> > +		 * fault handler may have dropped the mmap_sem a long
> > +		 * time ago. Only s390 derefs that parameter.
> > +		 */
> > +		pte_free(vma->vm_mm, vmf->prealloc_pte);
> 
> I'm confused.  This code looks like it was safe before (as it was caching
> vma->vm_mm in a local variable), and now you've made it unsafe ... ?

You're right. After looking at it again, this was a total brainfart:
the mm itself is of course safe to access. I removed these two hunks.

Thanks!

Updated patch:

---
From 60c1493bd3b5e0800147165a1dc36b77cf3306e5 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <jweiner@fb.com>
Date: Wed, 8 May 2019 13:53:38 -0700
Subject: [PATCH v2] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault

One of our services is observing hanging ps/top/etc under heavy write
IO, and the task states show this is an mmap_sem priority inversion:

A write fault is holding the mmap_sem in read-mode and waiting for
(heavily cgroup-limited) IO in balance_dirty_pages():

[<0>] balance_dirty_pages+0x724/0x905
[<0>] balance_dirty_pages_ratelimited+0x254/0x390
[<0>] fault_dirty_shared_page.isra.96+0x4a/0x90
[<0>] do_wp_page+0x33e/0x400
[<0>] __handle_mm_fault+0x6f0/0xfa0
[<0>] handle_mm_fault+0xe4/0x200
[<0>] __do_page_fault+0x22b/0x4a0
[<0>] page_fault+0x45/0x50
[<0>] 0xffffffffffffffff

Somebody tries to change the address space, contending for the
mmap_sem in write-mode:

[<0>] call_rwsem_down_write_failed_killable+0x13/0x20
[<0>] do_mprotect_pkey+0xa8/0x330
[<0>] SyS_mprotect+0xf/0x20
[<0>] do_syscall_64+0x5b/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<0>] 0xffffffffffffffff

The waiting writer locks out all subsequent readers to avoid lock
starvation, and several threads can be seen hanging like this:

[<0>] call_rwsem_down_read_failed+0x14/0x30
[<0>] proc_pid_cmdline_read+0xa0/0x480
[<0>] __vfs_read+0x23/0x140
[<0>] vfs_read+0x87/0x130
[<0>] SyS_read+0x42/0x90
[<0>] do_syscall_64+0x5b/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<0>] 0xffffffffffffffff

To fix this, do what we do for cache read faults already: drop the
mmap_sem before calling into anything IO bound, in this case the
balance_dirty_pages() function, and return VM_FAULT_RETRY.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c  | 21 ---------------------
 mm/internal.h | 21 +++++++++++++++++++++
 mm/memory.c   | 38 +++++++++++++++++++++++++++-----------
 3 files changed, 48 insertions(+), 32 deletions(-)

version 2:
- use maybe_unlock_mmap_for_io(), as per Willy
- remove vma dereference bug, as per Willy
- use vm_fault_t, as per Willy

diff --git a/mm/filemap.c b/mm/filemap.c
index 7f99d53005bb..9072c3fbf837 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2362,27 +2362,6 @@ EXPORT_SYMBOL(generic_file_read_iter);
 
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
-static struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
-					     struct file *fpin)
-{
-	int flags = vmf->flags;
-
-	if (fpin)
-		return fpin;
-
-	/*
-	 * FAULT_FLAG_RETRY_NOWAIT means we don't want to wait on page locks or
-	 * anything, so we only pin the file and drop the mmap_sem if only
-	 * FAULT_FLAG_ALLOW_RETRY is set.
-	 */
-	if ((flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
-	    FAULT_FLAG_ALLOW_RETRY) {
-		fpin = get_file(vmf->vma->vm_file);
-		up_read(&vmf->vma->vm_mm->mmap_sem);
-	}
-	return fpin;
-}
-
 /*
  * lock_page_maybe_drop_mmap - lock the page, possibly dropping the mmap_sem
  * @vmf - the vm_fault for this fault.
diff --git a/mm/internal.h b/mm/internal.h
index 0d5f720c75ab..7dd7fbb577a9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -362,6 +362,27 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	return max(start, vma->vm_start);
 }
 
+static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
+						    struct file *fpin)
+{
+	int flags = vmf->flags;
+
+	if (fpin)
+		return fpin;
+
+	/*
+	 * FAULT_FLAG_RETRY_NOWAIT means we don't want to wait on page locks or
+	 * anything, so we only pin the file and drop the mmap_sem if only
+	 * FAULT_FLAG_ALLOW_RETRY is set.
+	 */
+	if ((flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
+	    FAULT_FLAG_ALLOW_RETRY) {
+		fpin = get_file(vmf->vma->vm_file);
+		up_read(&vmf->vma->vm_mm->mmap_sem);
+	}
+	return fpin;
+}
+
 #else /* !CONFIG_MMU */
 static inline void clear_page_mlock(struct page *page) { }
 static inline void mlock_vma_page(struct page *page) { }
diff --git a/mm/memory.c b/mm/memory.c
index 2e796372927f..088b6d3b6f88 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2221,10 +2221,11 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
  *
  * The function expects the page to be locked and unlocks it.
  */
-static void fault_dirty_shared_page(struct vm_area_struct *vma,
-				    struct page *page)
+static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping;
+	struct page *page = vmf->page;
 	bool dirtied;
 	bool page_mkwrite = vma->vm_ops && vma->vm_ops->page_mkwrite;
 
@@ -2239,16 +2240,30 @@ static void fault_dirty_shared_page(struct vm_area_struct *vma,
 	mapping = page_rmapping(page);
 	unlock_page(page);
 
+	if (!page_mkwrite)
+		file_update_time(vma->vm_file);
+
+	/*
+	 * Throttle page dirtying rate down to writeback speed.
+	 *
+	 * mapping may be NULL here because some device drivers do not
+	 * set page.mapping but still dirty their pages
+	 *
+	 * Drop the mmap_sem before waiting on IO, if we can. The file
+	 * is pinning the mapping, as per above.
+	 */
 	if ((dirtied || page_mkwrite) && mapping) {
-		/*
-		 * Some device drivers do not set page.mapping
-		 * but still dirty their pages
-		 */
+		struct file *fpin;
+
+		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
 		balance_dirty_pages_ratelimited(mapping);
+		if (fpin) {
+			fput(fpin);
+			return VM_FAULT_RETRY;
+		}
 	}
 
-	if (!page_mkwrite)
-		file_update_time(vma->vm_file);
+	return 0;
 }
 
 /*
@@ -2491,6 +2506,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = VM_FAULT_WRITE;
 
 	get_page(vmf->page);
 
@@ -2514,10 +2530,10 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 		wp_page_reuse(vmf);
 		lock_page(vmf->page);
 	}
-	fault_dirty_shared_page(vma, vmf->page);
+	ret |= fault_dirty_shared_page(vmf);
 	put_page(vmf->page);
 
-	return VM_FAULT_WRITE;
+	return ret;
 }
 
 /*
@@ -3561,7 +3577,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 		return ret;
 	}
 
-	fault_dirty_shared_page(vma, vmf->page);
+	ret |= fault_dirty_shared_page(vmf);
 	return ret;
 }
 
-- 
2.23.0

