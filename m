Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6FC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EDC21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569394520;
	bh=VI74PN1jVCSYjYeQyTAfOw+l1DeZDyW2OTJrcBF213E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fOIVgM5cPG5WBWD9OYq6etiDIfjdsGIeVbuH/ogWDs4ckbITBtPaLIPPMKVE+gEim
	 91yP1CvSiL+GcfRjKFpPRgaWLe/FP76nQpGbt3VjWOlQj1w/8pWAVNgNLM1Jt0Yf+d
	 n3NZVL7bH4nGx4X0A1Zi2s5nOQ8SOgxsrVFj0wyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442414AbfIYGzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:55:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442402AbfIYGzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:55:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so5063548wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mr0rHIX84j5zIY5Uipi5s0jSvGWjuHax2KlVj0xWmbc=;
        b=WfwdnhInyKiAxaZKvSPPXcN2YMrLJJ0apXmm+G1gyN34iZUagQ/uxWNF72VXhLgmZe
         DgtA8idQQlci9AM6tHesrxaWHIVggagRi3rB3HXp50NGY4eniEyOOGzoCJuLrbbkaUsp
         o71QBlJvSPZ5aYxEIbomp2HjyTU0L25BhVHAvPZX9UvSOiC3wSqe3caQpfkRghXDEQXu
         K8G0Rc0/rc2AdCPb9+MRi+NvXJb1WxMNjU3qNglSEFLJiDo4I7jpBGl8fu61gX7dmnPo
         h6uldyBx6akBQ6PaSekC0hs57XPTv9aO+4jXafWOUh2W1IrVqETLJs7/X7gKZ8+0xjds
         qibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mr0rHIX84j5zIY5Uipi5s0jSvGWjuHax2KlVj0xWmbc=;
        b=PMLrPXdhbo64dDKxMVg6BReBT5Xfag/Pk0RWGE44tKOCCQu89jq1QaBU+JLkOK1kgH
         F5Qkgs2LnhkUhPNs7VMILwrJURoscwH4oGJ5j+l4pPeTwk5t9fY4m7WoXrzfFATxi3bi
         4KsD6b4RCjNI+HeTY/p6XXaAc3ufMzkl7w9EPFv9ZvHYU94Uc2Ma2SB9r42+F5URbXhQ
         m40uKFyNcX5CM2U2fV2Z90kqWqeaRZqZt6+2zSK1+pIgtvYq3IPfLwm4u0TPeARW5hKY
         fT3bqAZnOrDzidRr5Rf2szEGqPLwSd8WSHUCULQTu6vOC3zETB4/nEObAVgHVwOxifR8
         vDlA==
X-Gm-Message-State: APjAAAXi4EpWQzhiIFuEhDj8juEF6iUaRcRUFSp6+GL20B+o+gdugJ00
        3wfKskWmt/ttZOJfnPI85YQ=
X-Google-Smtp-Source: APXvYqzDm1l0egvUx2bUQp0br2zrhgUQt6QS4J6efoiVmGvkZUuqgmKpjC7dcKikfkZXIXL++QaBeg==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr7879921wrj.269.1569394517137;
        Tue, 24 Sep 2019 23:55:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l1sm3948898wrb.1.2019.09.24.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 23:55:16 -0700 (PDT)
Date:   Wed, 25 Sep 2019 08:55:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/mm: Clean up the pmd_read_atomic() comments
Message-ID: <20190925065514.GA21740@gmail.com>
References: <20190925014453.20236-1-richardw.yang@linux.intel.com>
 <20190925015956.GA20295@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925015956.GA20295@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Wei Yang <richardw.yang@linux.intel.com> wrote:

> To be honest, I have a question on how this works.
> 
> As the comment says, we need to call pmd_read_atomic before using
> pte_offset_map_lock to avoid data corruption.

There's only a risk of data corruption if mmap_sem is held for reading. 
If it's held for writing then the pagetable contents should be stable.

> For example, in function swapin_walk_pmd_entry:
> 
>     pmd_none_or_trans_huge_or_clear_bad(pmd)
>         pmd_read_atomic(pmd)                      ---   1
>     pte_offset_map_lock(mm, pmd, ...)             ---   2
> 
> At point 1, we are assured the content is intact. While in point 2, we would
> read pmd again to calculate the pte address. How we ensure this time the
> content is intact? Because pmd_none_or_trans_huge_or_clear_bad() ensures the
> pte is stable, so that the content won't be changed?

Indeed pte_offset_map_lock() will take a non-atomic *pmd value in 
pte_lockptr() before taking the pte spinlock.

I believe the rule here is that if pmd_none_or_trans_huge_or_clear_bad() 
finds the pmd 'stable' while holding the mmap_sem read-locked, then the 
pmd cannot change while we are continuously holding the mmap_sem.

Hence the followup pte_offset_map_lock() and other iterators can look at 
the value of the pmd without locking. (Individual pte entries still need 
the pte-lock, because they might be faulted-in in parallel.)

So the pmd use pattern in swapin_walk_pmd_entry() should be safe.

I'm not 100% sure though - so I've added a few more Cc:s ...

I've also cleaned up the pmd_read_atomic() some more to make it more 
readable - see the patch below.

Thanks,

	Ingo

==================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 25 Sep 2019 08:38:57 +0200
Subject: [PATCH] x86/mm: Clean up the pmd_read_atomic() comments

Fix spelling, consistent parenthesis and grammar - and also clarify
the language where needed.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Link: https://lkml.kernel.org/r/20190925014453.20236-1-richardw.yang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable-3level.h | 44 ++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 1796462ff143..5afb5e0fe903 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -36,39 +36,41 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
 
 #define pmd_read_atomic pmd_read_atomic
 /*
- * pte_offset_map_lock on 32bit PAE kernels was reading the pmd_t with
- * a "*pmdp" dereference done by gcc. Problem is, in certain places
- * where pte_offset_map_lock is called, concurrent page faults are
+ * pte_offset_map_lock() on 32-bit PAE kernels was reading the pmd_t with
+ * a "*pmdp" dereference done by GCC. Problem is, in certain places
+ * where pte_offset_map_lock() is called, concurrent page faults are
  * allowed, if the mmap_sem is hold for reading. An example is mincore
  * vs page faults vs MADV_DONTNEED. On the page fault side
- * pmd_populate rightfully does a set_64bit, but if we're reading the
+ * pmd_populate() rightfully does a set_64bit(), but if we're reading the
  * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
- * because gcc will not read the 64bit of the pmd atomically. To fix
- * this all places running pte_offset_map_lock() while holding the
+ * because GCC will not read the 64-bit value of the pmd atomically.
+ *
+ * To fix this all places running pte_offset_map_lock() while holding the
  * mmap_sem in read mode, shall read the pmdp pointer using this
- * function to know if the pmd is null nor not, and in turn to know if
+ * function to know if the pmd is null or not, and in turn to know if
  * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
  * operations.
  *
- * Without THP if the mmap_sem is hold for reading, the pmd can only
- * transition from null to not null while pmd_read_atomic runs. So
+ * Without THP if the mmap_sem is held for reading, the pmd can only
+ * transition from null to not null while pmd_read_atomic() runs. So
  * we can always return atomic pmd values with this function.
  *
- * With THP if the mmap_sem is hold for reading, the pmd can become
+ * With THP if the mmap_sem is held for reading, the pmd can become
  * trans_huge or none or point to a pte (and in turn become "stable")
- * at any time under pmd_read_atomic. We could read it really
- * atomically here with a atomic64_read for the THP enabled case (and
+ * at any time under pmd_read_atomic(). We could read it truly
+ * atomically here with an atomic64_read() for the THP enabled case (and
  * it would be a whole lot simpler), but to avoid using cmpxchg8b we
  * only return an atomic pmdval if the low part of the pmdval is later
- * found stable (i.e. pointing to a pte). And we're returning a none
- * pmdval if the low part of the pmd is none. In some cases the high
- * and low part of the pmdval returned may not be consistent if THP is
- * enabled (the low part may point to previously mapped hugepage,
- * while the high part may point to a more recently mapped hugepage),
- * but pmd_none_or_trans_huge_or_clear_bad() only needs the low part
- * of the pmd to be read atomically to decide if the pmd is unstable
- * or not, with the only exception of when the low part of the pmd is
- * zero in which case we return a none pmd.
+ * found to be stable (i.e. pointing to a pte). We are also returning a
+ * 'none' (zero) pmdval if the low part of the pmd is zero.
+ *
+ * In some cases the high and low part of the pmdval returned may not be
+ * consistent if THP is enabled (the low part may point to previously
+ * mapped hugepage, while the high part may point to a more recently
+ * mapped hugepage), but pmd_none_or_trans_huge_or_clear_bad() only
+ * needs the low part of the pmd to be read atomically to decide if the
+ * pmd is unstable or not, with the only exception when the low part
+ * of the pmd is zero, in which case we return a 'none' pmd.
  */
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
