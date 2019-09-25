Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B5C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB502082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442605AbfIYH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:29:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:28444 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442594AbfIYH3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:29:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 00:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="191258350"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2019 00:29:11 -0700
Date:   Wed, 25 Sep 2019 15:28:51 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/mm: Clean up the pmd_read_atomic() comments
Message-ID: <20190925072851.GA32558@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190925014453.20236-1-richardw.yang@linux.intel.com>
 <20190925015956.GA20295@richard>
 <20190925065514.GA21740@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925065514.GA21740@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:55:14AM +0200, Ingo Molnar wrote:
>
>* Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> To be honest, I have a question on how this works.
>> 
>> As the comment says, we need to call pmd_read_atomic before using
>> pte_offset_map_lock to avoid data corruption.
>
>There's only a risk of data corruption if mmap_sem is held for reading. 
>If it's held for writing then the pagetable contents should be stable.
>
>> For example, in function swapin_walk_pmd_entry:
>> 
>>     pmd_none_or_trans_huge_or_clear_bad(pmd)
>>         pmd_read_atomic(pmd)                      ---   1
>>     pte_offset_map_lock(mm, pmd, ...)             ---   2
>> 
>> At point 1, we are assured the content is intact. While in point 2, we would
>> read pmd again to calculate the pte address. How we ensure this time the
>> content is intact? Because pmd_none_or_trans_huge_or_clear_bad() ensures the
>> pte is stable, so that the content won't be changed?
>
>Indeed pte_offset_map_lock() will take a non-atomic *pmd value in 
>pte_lockptr() before taking the pte spinlock.
>
>I believe the rule here is that if pmd_none_or_trans_huge_or_clear_bad() 
>finds the pmd 'stable' while holding the mmap_sem read-locked, then the 
>pmd cannot change while we are continuously holding the mmap_sem.
>

I have the same gut feeling as you.

Then I have another question, why in page fault routines, we don't use
pmd_read_atomic() to retrieve pmd value? Since we support concurrent page
fault, and we just grap mmap_sem read-locked during page fault, the value
could be corrupted too.

For example in __handle_mm_fault()

	pmd_t orig_pmd = *vmf.pmd;
	barrier();

This is why the barrier() is here?

>Hence the followup pte_offset_map_lock() and other iterators can look at 
>the value of the pmd without locking. (Individual pte entries still need 
>the pte-lock, because they might be faulted-in in parallel.)
>
>So the pmd use pattern in swapin_walk_pmd_entry() should be safe.
>
>I'm not 100% sure though - so I've added a few more Cc:s ...
>
>I've also cleaned up the pmd_read_atomic() some more to make it more 
>readable - see the patch below.
>
>Thanks,
>
>	Ingo
>
>==================>
>From: Ingo Molnar <mingo@kernel.org>
>Date: Wed, 25 Sep 2019 08:38:57 +0200
>Subject: [PATCH] x86/mm: Clean up the pmd_read_atomic() comments
>
>Fix spelling, consistent parenthesis and grammar - and also clarify
>the language where needed.
>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: H. Peter Anvin <hpa@zytor.com>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Rik van Riel <riel@surriel.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Link: https://lkml.kernel.org/r/20190925014453.20236-1-richardw.yang@linux.intel.com
>Signed-off-by: Ingo Molnar <mingo@kernel.org>

The following change looks good to me.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> arch/x86/include/asm/pgtable-3level.h | 44 ++++++++++++++++++-----------------
> 1 file changed, 23 insertions(+), 21 deletions(-)
>
>diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
>index 1796462ff143..5afb5e0fe903 100644
>--- a/arch/x86/include/asm/pgtable-3level.h
>+++ b/arch/x86/include/asm/pgtable-3level.h
>@@ -36,39 +36,41 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
> 
> #define pmd_read_atomic pmd_read_atomic
> /*
>- * pte_offset_map_lock on 32bit PAE kernels was reading the pmd_t with
>- * a "*pmdp" dereference done by gcc. Problem is, in certain places
>- * where pte_offset_map_lock is called, concurrent page faults are
>+ * pte_offset_map_lock() on 32-bit PAE kernels was reading the pmd_t with
>+ * a "*pmdp" dereference done by GCC. Problem is, in certain places
>+ * where pte_offset_map_lock() is called, concurrent page faults are
>  * allowed, if the mmap_sem is hold for reading. An example is mincore
>  * vs page faults vs MADV_DONTNEED. On the page fault side
>- * pmd_populate rightfully does a set_64bit, but if we're reading the
>+ * pmd_populate() rightfully does a set_64bit(), but if we're reading the
>  * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
>- * because gcc will not read the 64bit of the pmd atomically. To fix
>- * this all places running pte_offset_map_lock() while holding the
>+ * because GCC will not read the 64-bit value of the pmd atomically.
>+ *
>+ * To fix this all places running pte_offset_map_lock() while holding the
>  * mmap_sem in read mode, shall read the pmdp pointer using this
>- * function to know if the pmd is null nor not, and in turn to know if
>+ * function to know if the pmd is null or not, and in turn to know if
>  * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
>  * operations.
>  *
>- * Without THP if the mmap_sem is hold for reading, the pmd can only
>- * transition from null to not null while pmd_read_atomic runs. So
>+ * Without THP if the mmap_sem is held for reading, the pmd can only
>+ * transition from null to not null while pmd_read_atomic() runs. So
>  * we can always return atomic pmd values with this function.
>  *
>- * With THP if the mmap_sem is hold for reading, the pmd can become
>+ * With THP if the mmap_sem is held for reading, the pmd can become
>  * trans_huge or none or point to a pte (and in turn become "stable")
>- * at any time under pmd_read_atomic. We could read it really
>- * atomically here with a atomic64_read for the THP enabled case (and
>+ * at any time under pmd_read_atomic(). We could read it truly
>+ * atomically here with an atomic64_read() for the THP enabled case (and
>  * it would be a whole lot simpler), but to avoid using cmpxchg8b we
>  * only return an atomic pmdval if the low part of the pmdval is later
>- * found stable (i.e. pointing to a pte). And we're returning a none
>- * pmdval if the low part of the pmd is none. In some cases the high
>- * and low part of the pmdval returned may not be consistent if THP is
>- * enabled (the low part may point to previously mapped hugepage,
>- * while the high part may point to a more recently mapped hugepage),
>- * but pmd_none_or_trans_huge_or_clear_bad() only needs the low part
>- * of the pmd to be read atomically to decide if the pmd is unstable
>- * or not, with the only exception of when the low part of the pmd is
>- * zero in which case we return a none pmd.
>+ * found to be stable (i.e. pointing to a pte). We are also returning a
>+ * 'none' (zero) pmdval if the low part of the pmd is zero.
>+ *
>+ * In some cases the high and low part of the pmdval returned may not be
>+ * consistent if THP is enabled (the low part may point to previously
>+ * mapped hugepage, while the high part may point to a more recently
>+ * mapped hugepage), but pmd_none_or_trans_huge_or_clear_bad() only
>+ * needs the low part of the pmd to be read atomically to decide if the
>+ * pmd is unstable or not, with the only exception when the low part
>+ * of the pmd is zero, in which case we return a 'none' pmd.
>  */
> static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> {

-- 
Wei Yang
Help you, Help me
