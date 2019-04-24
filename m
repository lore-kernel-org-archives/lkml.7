Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74477C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A94205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK5/cDiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfDXTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:14:46 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:50351 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDXTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:14:46 -0400
Received: by mail-yw1-f73.google.com with SMTP id j66so15454710ywa.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YMOcZ6hYHsZD+sSFKx+9vdGslH8MLfzgQRgSaDPv8B4=;
        b=CK5/cDiIJONIYgXEjD4RYg7dx7rZaJFUstQgjPj46FIZEmxSoXJYUzd8KizMI7qZm5
         RcqPy5y2ld7r7T+zmkQjj033UEft/zD76GShdGT7dLBn6VrP68WZ1rGH4Pmtx/S0GSaE
         CCfK92GDkQqkZOAtecU27oeItmXzP9praIYdYw5cNNArlD39XW+UpYDma69msyOZA0FI
         D6dyGnZFsxYy1qrivHoTo+C+iIwSLYT7ryXiEs5828TsFejMYMFsZRVhGrtLaiEwafMe
         Gvk0ihsMGd6z+9yOt5fiSz7NiuW8t356Mu8rXv9SBYJ/njQ4T+cJc0hvGUHeJ++5KSjE
         ETVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YMOcZ6hYHsZD+sSFKx+9vdGslH8MLfzgQRgSaDPv8B4=;
        b=Xe+uxMlWZOeUDYaWZMC045BjUFyC0RGeW141RW5V3WG/AdO0MBe6V4ZcpDa7NXOihJ
         PrYGchb16Rht5nyFBGR/U7vPS6WoNOK4Tj63bRuo5whq8Z3mCuusnFwmZf5atcsvQWa4
         OR/P6TkwdKrYEpSfbO9hunOVIhIbbNqBSIvK3NVKgLNbXl082XuFi1XwxEhGKI2AhaYt
         xVtkrAq2BR8Rn7pwN6gA4AzMIsxNXFYrJsIplGvkzlnAyozR9mk0cHvwFPBu5DR5vQIM
         8FD6JcmNNXTsHHmXt2Xa55uNEx3bt+e8vf6bzjLnBfgcw6CgSAh/uj4EldS6e1Cf/Ult
         1pxQ==
X-Gm-Message-State: APjAAAWuK93YmQq6XV8ye7rk6z/2U9/NH32qH6Pj9BZr3VhXdPDjid3+
        ctM8wiBoFSz64H8iL8An/uAOuhuxG7UW0focuexvxg==
X-Google-Smtp-Source: APXvYqwGnqehJEjs5NYoxwPs3X8dJXUEmrQ64ohhLda/ISlPMpUEBLkRXx820otp2prfmVVgP2TGuihp1B4/RY5E10/nnA==
X-Received: by 2002:a25:2a13:: with SMTP id q19mr26364218ybq.243.1556133285327;
 Wed, 24 Apr 2019 12:14:45 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:14:40 -0700
Message-Id: <20190424191440.170422-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] mm: Allow userland to request that the kernel clear memory on release
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Applications that hold secrets and wish to avoid them leaking can use
mlock() to prevent the page from being pushed out to swap and
MADV_DONTDUMP to prevent it from being included in core dumps. Applications
can also use atexit() handlers to overwrite secrets on application exit.
However, if an attacker can reboot the system into another OS, they can
dump the contents of RAM and extract secrets. We can avoid this by setting
CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
firmware wipe the contents of RAM before booting another OS, but this means
rebooting takes a *long* time - the expected behaviour is for a clean
shutdown to remove the request after scrubbing secrets from RAM in order to
avoid this.

Unfortunately, if an application exits uncleanly, its secrets may still be
present in RAM. This can't be easily fixed in userland (eg, if the OOM
killer decides to kill a process holding secrets, we're not going to be able
to avoid that), so this patch adds a new flag to madvise() to allow userland
to request that the kernel clear the covered pages whenever the page
reference count hits zero. Since vm_flags is already full on 32-bit, it
will only work on 64-bit systems.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---

I know nothing about mm, so this is doubtless broken in any number of
ways - please let me know how!

 include/linux/mm.h                     |  6 ++++
 include/linux/page-flags.h             |  2 ++
 include/trace/events/mmflags.h         |  4 +--
 include/uapi/asm-generic/mman-common.h |  2 ++
 mm/hugetlb.c                           |  2 ++
 mm/madvise.c                           | 39 ++++++++++++++++++++++++++
 mm/mempolicy.c                         |  2 ++
 mm/page_alloc.c                        |  6 ++++
 8 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..64bdab679275 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -257,6 +257,8 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+
+#define VM_WIPEONRELEASE BIT(37)       /* Clear pages when releasing them */
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -298,6 +300,10 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_GROWSUP	VM_NONE
 #endif
 
+#ifndef VM_WIPEONRELEASE
+# define VM_WIPEONRELEASE VM_NONE
+#endif
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f8712a4b1a5..c52ea8a89c5d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -118,6 +118,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_wipeonrelease,
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -316,6 +317,7 @@ PAGEFLAG(Referenced, referenced, PF_HEAD)
 PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
+PAGEFLAG(WipeOnRelease, wipeonrelease, PF_HEAD) __CLEARPAGEFLAG(WipeOnRelease, wipeonrelease, PF_HEAD)
 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d43777e..4e5116a95b82 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -100,13 +100,13 @@
 	{1UL << PG_mappedtodisk,	"mappedtodisk"	},		\
 	{1UL << PG_reclaim,		"reclaim"	},		\
 	{1UL << PG_swapbacked,		"swapbacked"	},		\
-	{1UL << PG_unevictable,		"unevictable"	}		\
+	{1UL << PG_unevictable,		"unevictable"	},		\
+	{1UL << PG_wipeonrelease,	"wipeonrelease"	}		\
 IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
 IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
-
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
 	__def_pageflag_names						\
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..82dfff4a8e3d 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -64,6 +64,8 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_WIPEONRELEASE 20
+#define MADV_DONTWIPEONRELEASE 21
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6cdc7b2d9100..2816dc5c31f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1683,6 +1683,8 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = alloc_huge_page_nodemask(h, node, nodemask);
 	mpol_cond_put(mpol);
+	if (vma->vm_flags & VM_WIPEONRELEASE)
+		SetPageWipeOnRelease(page);
 
 	return page;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 21a7881a2db4..bf256c1a3b51 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -48,6 +48,23 @@ static int madvise_need_mmap_write(int behavior)
 	}
 }
 
+static int madvise_wipe_on_release(unsigned long start, unsigned long end)
+{
+	struct page *page;
+
+	for (; start < end; start += PAGE_SIZE) {
+		int ret;
+
+		ret = get_user_pages(start, 1, 0, &page, NULL);
+		if (ret != 1)
+			return ret;
+		SetPageWipeOnRelease(page);
+		put_page(page);
+	}
+
+	return 0;
+}
+
 /*
  * We can potentially split a vm area into separate
  * areas, each area with its own behavior.
@@ -92,6 +109,23 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	case MADV_KEEPONFORK:
 		new_flags &= ~VM_WIPEONFORK;
 		break;
+	case MADV_WIPEONRELEASE:
+		/* MADV_WIPEONRELEASE is only supported on anonymous memory. */
+		if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
+		    vma->vm_flags & VM_SHARED) {
+			error = -EINVAL;
+			goto out;
+		}
+		madvise_wipe_on_release(start, end);
+		new_flags |= VM_WIPEONRELEASE;
+		break;
+	case MADV_DONTWIPEONRELEASE:
+		if (VM_WIPEONRELEASE == 0) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_flags &= ~VM_WIPEONRELEASE;
+		break;
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
@@ -727,6 +761,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_WIPEONRELEASE:
+	case MADV_DONTWIPEONRELEASE:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
@@ -785,6 +821,9 @@ madvise_behavior_valid(int behavior)
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
+ *  MADV_WIPEONRELEASE - clear the contents of the memory after the last
+ *		reference to it has been released
+ *  MADV_DONTWIPEONRELEASE - cancel MADV_WIPEONRELEASE
  *
  * return values:
  *  zero    - success
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2219e747df49..c3bda2d9ab8e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2096,6 +2096,8 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
 	mpol_cond_put(pol);
 out:
+	if (vma->vm_flags & VM_WIPEONRELEASE)
+		SetPageWipeOnRelease(page);
 	return page;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c6ce20aaf80b..39a37d7601a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1083,11 +1083,17 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					unsigned int order, bool check_free)
 {
 	int bad = 0;
+	int i;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	trace_mm_page_free(page, order);
 
+	if (PageWipeOnRelease(page)) {
+		for (i = 0; i < (1<<order); i++)
+			clear_highpage(page + i);
+	}
+
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
-- 
2.21.0.593.g511ec345e18-goog

