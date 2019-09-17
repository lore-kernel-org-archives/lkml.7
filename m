Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32256C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F128521881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MWDcXo4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfIQMIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:08:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36490 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfIQMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:08:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id f2so3109514edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeQ/1nXTTrle8KmSh5j6zE8zudmgS+wCxY0/be2bjcg=;
        b=MWDcXo4T7JxMWIkBCc8lU+Ny/cxvG9pyCUHx1cl+8D+TIWgDxdmdynGoWQOtHnYTHS
         xWI+FZrl7UixBxU1PizQee/JkI6OHyRWf64Zl4maQ+OD6Z+uknbMnjL1rr4FHUE71Dgb
         D/5pCKiq+d9KzcyiHwFelYySGlA/UEVWBy8jElpgwoQv8Tna6ArQ8uciVzEhHhhqMRUg
         HQ42+P74bhTLOIoBrC8/HZI1jzHfTNiEzktjuH4UtdLSyFyQ9DfZjo0POvAm9/fwld54
         Cfpo5k2cX8LRl4cuXPb+T4i5vSeoPb/0goLuMLXAD7mCYR5z9bZAU90tuWrh0UEw9aL2
         2tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeQ/1nXTTrle8KmSh5j6zE8zudmgS+wCxY0/be2bjcg=;
        b=pocqnlwJgmDm/6S/8z1reFV7Sus0Jk6QYRFHBD4F6gVaWluJK6XFlyEm//xBeh2GuS
         QW6756WpdhoK37r/rU5iSXMuCmZsfelBPsqq+018Y9v3Et3oJNi5nyqxcXCLtLYdZvqv
         89y1bKGHpu+VXkYYrFcRuU0Uk75CS6Ib4yMDcAi4GotEa8wWOg4Xz+e856lW9lkY+per
         85mNn4nTh8bF9uUJo8Nbt+4RM27UGW6IB4llxtga7G70jzACz8xrmL/gfZKj9WDn/JUS
         QY+xwKG5b0dctZPR1QpDemkMG8w5YaRPaoMWZqpiQ2rDSy3Dwy8gnjd8d5d/a/FEQgTf
         OK3g==
X-Gm-Message-State: APjAAAUGECc5nmKlnqG6ooWahT1XxuVcg/AsURRWAzF3qua777SUIxvY
        zFBluWpkfdTILeya5slj1GYSiQ==
X-Google-Smtp-Source: APXvYqzmu0Kl2boVfXe9EcmtKusJSgFe0nuy9Lo88Wd9TFkOaWGoi9DYOpTYSJCBlM1xc61DdHEsbA==
X-Received: by 2002:a17:906:60d0:: with SMTP id f16mr4362508ejk.267.1568722131705;
        Tue, 17 Sep 2019 05:08:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f21sm181972edt.52.2019.09.17.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:08:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 326F9101C0B; Tue, 17 Sep 2019 15:08:53 +0300 (+03)
Date:   Tue, 17 Sep 2019 15:08:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+03ee87124ee05af991bd@syzkaller.appspotmail.com>,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in shmem_fault (2)
Message-ID: <20190917120852.x6x3aypwvh573kfa@box>
References: <20190831045826.748-1-hdanton@sina.com>
 <20190902135254.GC2431@bombadil.infradead.org>
 <20190902142029.fyq3dwn72pqqlzul@box>
 <20190909135521.GD29434@bombadil.infradead.org>
 <20190909150412.ut6fbshii4sohwag@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909150412.ut6fbshii4sohwag@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:04:12PM +0300, Kirill A. Shutemov wrote:
> On Mon, Sep 09, 2019 at 06:55:21AM -0700, Matthew Wilcox wrote:
> > On Mon, Sep 02, 2019 at 05:20:30PM +0300, Kirill A. Shutemov wrote:
> > > On Mon, Sep 02, 2019 at 06:52:54AM -0700, Matthew Wilcox wrote:
> > > > On Sat, Aug 31, 2019 at 12:58:26PM +0800, Hillf Danton wrote:
> > > > > On Fri, 30 Aug 2019 12:40:06 -0700
> > > > > > syzbot found the following crash on:
> > > > > > 
> > > > > > HEAD commit:    a55aa89a Linux 5.3-rc6
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12f4beb6600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6a2b9826fdadf9
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=03ee87124ee05af991bd
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > 
> > > > > > ==================================================================
> > > > > > BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530  
> > > > > > include/trace/events/lock.h:13
> > > > > > Read of size 8 at addr ffff8880a5cf2c50 by task syz-executor.0/26173
> > > > > 
> > > > > --- a/mm/shmem.c
> > > > > +++ b/mm/shmem.c
> > > > > @@ -2021,6 +2021,12 @@ static vm_fault_t shmem_fault(struct vm_
> > > > >  			shmem_falloc_waitq = shmem_falloc->waitq;
> > > > >  			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> > > > >  					TASK_UNINTERRUPTIBLE);
> > > > > +			/*
> > > > > +			 * it is not trivial to see what will take place after
> > > > > +			 * releasing i_lock and taking a nap, so hold inode to
> > > > > +			 * be on the safe side.
> > > > 
> > > > I think the comment could be improved.  How about:
> > > > 
> > > > 			 * The file could be unmapped by another thread after
> > > > 			 * releasing i_lock, and the inode then freed.  Hold
> > > > 			 * a reference to the inode to prevent this.
> > > 
> > > It only can happen if mmap_sem was released, so it's better to put
> > > __iget() to the branch above next to up_read(). I've got confused at first
> > > how it is possible from ->fault().
> > > 
> > > This way iput() below should only be called for ret == VM_FAULT_RETRY.
> > 
> > Looking at the rather similar construct in filemap.c, should we solve
> > it the same way, where we inc the refcount on the struct file instead
> > of the inode before releasing the mmap_sem?
> 
> Are you talking about maybe_unlock_mmap_for_io()? Yeah, worth moving it to
> mm/internal.h and reuse.
> 
> Care to prepare the patch? :P

Something like this? Untested.

diff --git a/mm/filemap.c b/mm/filemap.c
index d0cf700bf201..a542f72f57cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2349,26 +2349,6 @@ EXPORT_SYMBOL(generic_file_read_iter);
 
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
 
 /*
  * lock_page_maybe_drop_mmap - lock the page, possibly dropping the mmap_sem
diff --git a/mm/internal.h b/mm/internal.h
index e32390802fd3..75ffa646de82 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -362,6 +362,27 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	return max(start, vma->vm_start);
 }
 
+static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
+					     struct file *fpin)
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
diff --git a/mm/shmem.c b/mm/shmem.c
index 2bed4761f279..551fa49eb7f6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2007,16 +2007,14 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
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
@@ -2034,6 +2032,9 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
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
