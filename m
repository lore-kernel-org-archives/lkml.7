Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB5C207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRBQpDE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfJVW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:27:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34414 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbfJVW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:27:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so10839609pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MMatxSwB0mVXfrgjKkBzOUtpq16IKZXG5pseS/xWs+Q=;
        b=BRBQpDE01Egq4iGtX57txEWQ9UT9kam0PhJPlX2UfFfUVSocPfxTpWKsywVSa6sfRU
         dsjkWcJsoH9hJkVrIXwdFlJMuOpKw0lx3luxSt/GtyKhI0GeaP6DNjhvuUJNKyPLNg0G
         2hLgq1YPfjvqskiBZF6CO7o5MshAhjq/oO57zTT3+uM01o1ZGbXrbeHABnPoDfUkHhe9
         nVExdw8tHNx2AirUgbNYbGN4sMBulsMjuKX/5m9iGUisrXXoBQ5EIPaTdYzLBrXM2Tfv
         Q8vx1dhJtO3A+8KW9LaVFuwXY9H1TANOIU4Rgfoonrfr38aR/tAKUOhJGIAZFNw6RWyR
         9jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MMatxSwB0mVXfrgjKkBzOUtpq16IKZXG5pseS/xWs+Q=;
        b=lvepsYXenN2Lyq7R9B9iFAR6XlcyX6agAAvtoEcDj0gZNxcJ+3UTwiy2ABBu0/+4dc
         vBA3xPl7V9p1njk1MTjmPKOFBCvabTQ/cu2zcdTOtoynSUpIomUKC8PwCb3xMhugmJnD
         uhdF8IOxCus2yH17FKv1d/jWOMDpX/qeQHm2LdIbZVc7dH/vOXTCcfyKjV4y5zaNviv9
         kPgCKZQOsG4wu73j8GC0EVXizLd44sx4xwosm7xp7UIw0A9oY5o9X+y+KT3xTaczpp0e
         i6aFie357yyB3IE4VVGbfS1S86Xt2CqCNhOpq1GG2Ft4TrWhf4AjdWO23w4Jj0+W6BvL
         sKcA==
X-Gm-Message-State: APjAAAVKTcOCImG2eVRu6Cg1xYGnesYv82+CnkGuRCAgt0xSGRiQN0BP
        8J/PBLvE9rPkhnPkWEz1CNDJoA==
X-Google-Smtp-Source: APXvYqy+7P+LK4vKHjfOL/30XOXOjl7eeNZKN7c4hptS97Ihgq2L+FukRorNJoGoEogMpMFaOFHtjw==
X-Received: by 2002:a17:90a:bd10:: with SMTP id y16mr7164819pjr.111.1571783272619;
        Tue, 22 Oct 2019 15:27:52 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id g7sm3524804pfq.143.2019.10.22.15.27.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 15:27:51 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:27:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, gavin.dg@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
In-Reply-To: <1571769577-89735-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1910221454060.2077@eggly.anvils>
References: <1571769577-89735-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Yang Shi wrote:

> We have usecase to use tmpfs as QEMU memory backend and we would like to
> take the advantage of THP as well.  But, our test shows the EPT is not
> PMD mapped even though the underlying THP are PMD mapped on host.
> The number showed by /sys/kernel/debug/kvm/largepage is much less than
> the number of PMD mapped shmem pages as the below:
> 
> 7f2778200000-7f2878200000 rw-s 00000000 00:14 262232 /dev/shm/qemu_back_mem.mem.Hz2hSf (deleted)
> Size:            4194304 kB
> [snip]
> AnonHugePages:         0 kB
> ShmemPmdMapped:   579584 kB
> [snip]
> Locked:                0 kB
> 
> cat /sys/kernel/debug/kvm/largepages
> 12
> 
> And some benchmarks do worse than with anonymous THPs.
> 
> By digging into the code we figured out that commit 127393fbe597 ("mm:
> thp: kvm: fix memory corruption in KVM with THP enabled") checks if
> there is a single PTE mapping on the page for anonymous THP when
> setting up EPT map.  But, the _mapcount < 0 check doesn't fit to page
> cache THP since every subpage of page cache THP would get _mapcount
> inc'ed once it is PMD mapped, so PageTransCompoundMap() always returns
> false for page cache THP.  This would prevent KVM from setting up PMD
> mapped EPT entry.
> 
> So we need handle page cache THP correctly.  However, when page cache
> THP's PMD gets split, kernel just remove the map instead of setting up
> PTE map like what anonymous THP does.  Before KVM calls get_user_pages()
> the subpages may get PTE mapped even though it is still a THP since the
> page cache THP may be mapped by other processes at the mean time.
> 
> Checking its _mapcount and whether the THP is double mapped or not since
> we can't tell if the single PTE mapping comes from the current process
> or not by _mapcount.  Although this may report some false negative cases
> (PTE mapped by other processes), it looks not trivial to make this
> accurate.
> 
> With this fix /sys/kernel/debug/kvm/largepage would show reasonable
> pages are PMD mapped by EPT as the below:
> 
> 7fbeaee00000-7fbfaee00000 rw-s 00000000 00:14 275464 /dev/shm/qemu_back_mem.mem.SKUvat (deleted)
> Size:            4194304 kB
> [snip]
> AnonHugePages:         0 kB
> ShmemPmdMapped:   557056 kB
> [snip]
> Locked:                0 kB
> 
> cat /sys/kernel/debug/kvm/largepages
> 271
> 
> And the benchmarks are as same as anonymous THPs.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Tested-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org> 4.8+
> ---
>  include/linux/page-flags.h | 54 ++++++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb88..3b8e5c5 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -610,27 +610,6 @@ static inline int PageTransCompound(struct page *page)
>  }
>  
>  /*
> - * PageTransCompoundMap is the same as PageTransCompound, but it also
> - * guarantees the primary MMU has the entire compound page mapped
> - * through pmd_trans_huge, which in turn guarantees the secondary MMUs
> - * can also map the entire compound page. This allows the secondary
> - * MMUs to call get_user_pages() only once for each compound page and
> - * to immediately map the entire compound page with a single secondary
> - * MMU fault. If there will be a pmd split later, the secondary MMUs
> - * will get an update through the MMU notifier invalidation through
> - * split_huge_pmd().
> - *
> - * Unlike PageTransCompound, this is safe to be called only while
> - * split_huge_pmd() cannot run from under us, like if protected by the
> - * MMU notifier, otherwise it may result in page->_mapcount < 0 false
> - * positives.
> - */
> -static inline int PageTransCompoundMap(struct page *page)
> -{
> -	return PageTransCompound(page) && atomic_read(&page->_mapcount) < 0;
> -}
> -
> -/*
>   * PageTransTail returns true for both transparent huge pages
>   * and hugetlbfs pages, so it should only be called when it's known
>   * that hugetlbfs pages aren't involved.
> @@ -681,6 +660,39 @@ static inline int TestClearPageDoubleMap(struct page *page)
>  	return test_and_clear_bit(PG_double_map, &page[1].flags);
>  }
>  
> +/*
> + * PageTransCompoundMap is the same as PageTransCompound, but it also
> + * guarantees the primary MMU has the entire compound page mapped
> + * through pmd_trans_huge, which in turn guarantees the secondary MMUs
> + * can also map the entire compound page. This allows the secondary
> + * MMUs to call get_user_pages() only once for each compound page and
> + * to immediately map the entire compound page with a single secondary
> + * MMU fault. If there will be a pmd split later, the secondary MMUs
> + * will get an update through the MMU notifier invalidation through
> + * split_huge_pmd().
> + *
> + * Unlike PageTransCompound, this is safe to be called only while
> + * split_huge_pmd() cannot run from under us, like if protected by the
> + * MMU notifier, otherwise it may result in page->_mapcount check false
> + * positives.
> + *
> + * We have to treat page cache THP differently since every subpage of it
> + * would get _mapcount inc'ed once it is PMD mapped.  But, it may be PTE
> + * mapped in the current process so checking PageDoubleMap flag to rule
> + * this out.
> + */
> +static inline int PageTransCompoundMap(struct page *page)
> +{
> +	bool pmd_mapped;
> +
> +	if (PageAnon(page))
> +		pmd_mapped = atomic_read(&page->_mapcount) < 0;
> +	else
> +		pmd_mapped = atomic_read(&page->_mapcount) >= 0 &&
> +			     !PageDoubleMap(compound_head(page));
> +
> +	return PageTransCompound(page) && pmd_mapped;
> +}
>  #else
>  TESTPAGEFLAG_FALSE(TransHuge)
>  TESTPAGEFLAG_FALSE(TransCompound)
> -- 
> 1.8.3.1

I completely agree that the current PageTransCompoundMap() is wrong.

A fix for that is one of many patches I've not yet got to upstreaming.
Comparing yours and mine, I'm worried by your use of PageDoubleMap(),
because really that's a flag for anon THP, and not properly supported
on shmem (or now I suppose file) THP - I forget the details, is it
that it sometimes gets set, but never cleared?  Generally, we just
don't refer to PageDoubleMap() on shmem THPs (but there may be
exceptions: sorting out the THP mapcount maze, and eliminating
PageDoubleMap(), is one of my long-held ambitions, not yet reached).

Here's the patch I've been carrying, but it's from earlier, so I
should warn that I've done no more than build-testing it on 5.4,
and I'm too far away from these issues at the moment to be able to
make a good judgement or argue for it - I hope you and others can
decide which patch is the better.  I should also add that we're
barely using PageTransCompoundMap() at all: at best it can only
give a heuristic guess as to whether the page is pmd-mapped in
any particular case, and we preferred to take forward the KVM
patches we posted back in April 2016, plumbing hva down to where
it's needed - though of course those are somewhat different now.

[PATCH] mm: kvm: huge tmpfs: fix PageTransCompoundMap()

4.6 commit 127393fbe597
("mm: thp: kvm: fix memory corruption in KVM with THP enabled")
replaced the PageTransCompound() in KVM's transparent_hugepage_adjust()
by a new PageTransCompoundMap() which also checks page _mapcount;
while 4.8 commit dd78fedde4b9 ("rmap: support file thp")
was under development, making shmem file THP's use of page _mapcount
different from anon THP's (to avoid double-accounting in the tiresome
NR_FILE_MAPPED statistic, I believe).

Nobody spotted the disconnect, whose consequence has been that KVM
could not recognize a shmem file THP, so could not optimize for it.

Fix PageTransCompoundMap() to handle both cases.  Unfortunately, its
definition has been placed (as you would suppose from the CamelCase)
in page-flags.h, but now it needs compound_mapcount_ptr() from mm.h.
My zest for header file refactoring has ebbed: instead, put identical
defines of it in both files - no build will get far if they disagree.

Whether PageTransCompoundMap() is actually correct is another matter.
Good enough heuristic, erring on the safe side?  Good enough heuristic
for anon, but not so good for shmem file (if a random other usage could
ever map some ptes)?

Fixes: dd78fedde4b9 ("rmap: support file thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/mm.h         |    6 ++----
 include/linux/page-flags.h |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

--- 5.4-rc4/include/linux/mm.h	2019-10-06 17:20:18.473153411 -0700
+++ linux/include/linux/mm.h	2019-10-22 13:00:30.697944228 -0700
@@ -695,10 +695,8 @@ static inline void *kvcalloc(size_t n, s
 
 extern void kvfree(const void *addr);
 
-static inline atomic_t *compound_mapcount_ptr(struct page *page)
-{
-	return &page[1].compound_mapcount;
-}
+/* #define in order to validate duplicate definition in page-flags.h */
+#define compound_mapcount_ptr(head)	(&(head)[1].compound_mapcount)
 
 static inline int compound_mapcount(struct page *page)
 {
--- 5.4-rc4/include/linux/page-flags.h	2019-09-15 14:19:32.000000000 -0700
+++ linux/include/linux/page-flags.h	2019-10-22 13:00:30.697944228 -0700
@@ -609,6 +609,9 @@ static inline int PageTransCompound(stru
 	return PageCompound(page);
 }
 
+/* #define in order to validate duplicate definition in mm.h */
+#define compound_mapcount_ptr(head)	(&(head)[1].compound_mapcount)
+
 /*
  * PageTransCompoundMap is the same as PageTransCompound, but it also
  * guarantees the primary MMU has the entire compound page mapped
@@ -622,12 +625,23 @@ static inline int PageTransCompound(stru
  *
  * Unlike PageTransCompound, this is safe to be called only while
  * split_huge_pmd() cannot run from under us, like if protected by the
- * MMU notifier, otherwise it may result in page->_mapcount < 0 false
- * positives.
+ * MMU notifier, otherwise it may result in false positives.
  */
 static inline int PageTransCompoundMap(struct page *page)
 {
-	return PageTransCompound(page) && atomic_read(&page->_mapcount) < 0;
+	struct page *head;
+
+	if (!PageTransCompound(page))
+		return 0;
+	if (PageAnon(page))
+		return atomic_read(&page->_mapcount) < 0;
+	/*
+	 * pmd mappings are not included in anon THP's _mapcounts,
+	 * but they are included in shmem file THP's _mapcounts.
+	 */
+	head = compound_head(page);
+	return atomic_read(&page->_mapcount) ==
+		atomic_read(compound_mapcount_ptr(head));
 }
 
 /*
