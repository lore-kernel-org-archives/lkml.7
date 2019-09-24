Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA0FC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380BB21906
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qgN8j5wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438944AbfIXRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:15:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37837 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437098AbfIXRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:15:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so2565046qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVvT+zKf/9SBbC4bQyrI1w+/sdRkQQsfH03mgMh0xIQ=;
        b=qgN8j5wh4ZY3/4P7ncwh8L4fitk036GmpCfIAE3FYJHqfWCclrEDPw5gwn6VBp1D+9
         VLis0Fc34AJXorm/PAha5x2FeqoOxq2k3nydriTtsNPhlRdI2gAJcGxzPGNoCvCM6lxG
         ufwjNum6f5uRG0vcaKPgGQANbM33Kkz+zh7ukB1XJxml5l/1lyJcn+zml8S5wEtXA5Xr
         jbPwhYEiyEOzjRHXoPW41IwAnl/DPdAT9dGs5iA1oIeLzYq+z3NS7tp+uoWIhuMgl1eY
         frsYXFC23zuIqXA52BrS3oiRc2NUB13mVRwW8UBkEVHQPxLnn6FYhfis6EUfu8Ra+FrF
         +yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVvT+zKf/9SBbC4bQyrI1w+/sdRkQQsfH03mgMh0xIQ=;
        b=gqVSlGbWkGRAHMFptjC+0oGS7nL3GTqAAsIOFEh+VyuRtLEen7iBFCs2SDQmy1u+sG
         pZ8L7PIl9H8vPgrCA1z2jXEV45jPs+sdSCTAyAXoj9k+lkf7W17dGrTh7xIITktphlQb
         12hkcTeJ/FmJu1OyYsdOmYo+giFQHjiS2ad1dsa2eEx3j0p7aT7f2wAt/WkUZdVMb3Jy
         cPPD6vSsiBEaCvNWn002JzZFMeBD0ywB7iwyTqjE0N4V9LIIjQ4KKVrbyJZhRIuV5o7Y
         R2Hez1G1CgZ8pSrikUZr0DSl2WrS3A2NEZL9pAH+l70APNV+G74TO2XZ7V7/wGj1xr4Z
         JOVg==
X-Gm-Message-State: APjAAAUSCVIFxRxSnvcn+JEGFXWy4M8+0YVXJJNo/iFsZk5TYvhEoLUX
        No9RjMR04Wx+8y55W2/5HBZ/pg==
X-Google-Smtp-Source: APXvYqwt7+cEOOnoNq+IeVwbFeMvXPiYOy2qk8m4i5VPe0Mjp6mV1JJrbC2SX0NZDlpOzE+QuU7bMw==
X-Received: by 2002:a37:a00d:: with SMTP id j13mr3679827qke.2.1569345320080;
        Tue, 24 Sep 2019 10:15:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::a51])
        by smtp.gmail.com with ESMTPSA id g31sm1995914qte.78.2019.09.24.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 10:15:19 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages() in write fault
Date:   Tue, 24 Sep 2019 13:15:18 -0400
Message-Id: <20190924171518.26682-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <jweiner@fb.com>

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
 mm/memory.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2e796372927f..da5eb1d67447 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2221,12 +2221,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
  *
  * The function expects the page to be locked and unlocks it.
  */
-static void fault_dirty_shared_page(struct vm_area_struct *vma,
-				    struct page *page)
+static int fault_dirty_shared_page(struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping;
+	struct page *page = vmf->page;
 	bool dirtied;
 	bool page_mkwrite = vma->vm_ops && vma->vm_ops->page_mkwrite;
+	int ret = 0;
 
 	dirtied = set_page_dirty(page);
 	VM_BUG_ON_PAGE(PageAnon(page), page);
@@ -2239,16 +2241,36 @@ static void fault_dirty_shared_page(struct vm_area_struct *vma,
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
+		struct file *fpin = NULL;
+
+		if ((vmf->flags &
+		     (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
+		    FAULT_FLAG_ALLOW_RETRY) {
+			fpin = get_file(vma->vm_file);
+			up_read(&vma->vm_mm->mmap_sem);
+			ret = VM_FAULT_RETRY;
+		}
+
 		balance_dirty_pages_ratelimited(mapping);
+
+		if (fpin)
+			fput(fpin);
 	}
 
-	if (!page_mkwrite)
-		file_update_time(vma->vm_file);
+	return ret;
 }
 
 /*
@@ -2491,6 +2513,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	int ret = VM_FAULT_WRITE;
 
 	get_page(vmf->page);
 
@@ -2514,10 +2537,10 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
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
@@ -3561,7 +3584,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 		return ret;
 	}
 
-	fault_dirty_shared_page(vma, vmf->page);
+	ret |= fault_dirty_shared_page(vmf);
 	return ret;
 }
 
@@ -3576,7 +3599,6 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 static vm_fault_t do_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
 	/*
@@ -3617,7 +3639,12 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 
 	/* preallocated pagetable is unused: free it */
 	if (vmf->prealloc_pte) {
-		pte_free(vm_mm, vmf->prealloc_pte);
+		/*
+		 * XXX: Accessing vma->vm_mm now is not safe. The page
+		 * fault handler may have dropped the mmap_sem a long
+		 * time ago. Only s390 derefs that parameter.
+		 */
+		pte_free(vma->vm_mm, vmf->prealloc_pte);
 		vmf->prealloc_pte = NULL;
 	}
 	return ret;
-- 
2.23.0

