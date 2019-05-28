Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB39A2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559041095;
	bh=ey7p4X1wfa9kxKJXxfm5PD943tl7JF7TPRul9r5XyWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fxB0aaTEWSclp9JTP9ZzDfTd6H8VX3MnpZ3VbY5+NERHDaKKur03vO5HK1CwFID3d
	 kLxuhKkcXuOEe6R9M98m+qQC8/GG/hcCcNdK8T4gN4Stz8Y2Fb+Yyq1KzuII/Bx5zS
	 mHxSO4RGNDXB05hAIsQhtd6J/C9PoQ3h/X54NnC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE1K6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:58:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43753 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1K6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:58:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so10762149pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fuHKQ9T5TF7CoHiaUBHdgwZ4clmbQ6BLbnAB0WfINcA=;
        b=D/+9pqXkGNjYgp2Awn39VAjUAH7/nskqQCjZIjBpGrNsU8NUQHbbB3a20tLDYIOQis
         EYsVHOQJNfzpr7QNHL8qEW4I1j6+C6mWtE/5DUdIRFwR5AG1fcpozoisjP/Dzka6WTQh
         az5zHrFFLHvyzQ6xflrryM9e2KKsSdziQto8Cpa+Xa8Yr+1JnvfXVf9C+xtBwv8yU4zi
         rKTTjYz+66mZLYd6+WIbSquKPKW3W/bTaCcFZyRSYtyi3Ul797P93SKxOd8QahUQ6qFP
         mTZlTff0hvO8tP0yZZ01RUQPH7AHoccYaS8wRbBvC7JRvxku3KdvviQkvlE/aQQC9IDC
         8dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fuHKQ9T5TF7CoHiaUBHdgwZ4clmbQ6BLbnAB0WfINcA=;
        b=FVP951F8ZgOFC7hbjyg7U4fEZcSDCOWkPD2UDmQP5KPf/4p/vNEy3qy77lMKzMljW0
         OuS5J4/R+yFWDQFbvurRJsH+iFlY5SQwL6KnNFQRW2izX/zfZeM1NbZDMbcvNoIunKQs
         edN29g+L5L5hC30O32N/UPDtmceAU9DCxTNaTWmE0wG1WXjaA5FUz6l22c+Kp3DcDUgr
         SQbSqyJTZOBh0KcJhtiyssgZ3OyXzQ65XcQzXLgJZYp3Ei86ionSvYRUd/4GMvXmD8ar
         XYpsEo1Hw0sdeJuJ8RWSag/iR9udqezD2Wm3d+5ujMZFFNnkXCwldup+Wa1zRN+aGcvR
         wLWA==
X-Gm-Message-State: APjAAAUtMdxUfUoiMGTg96BVUvR1kF4cHK0Vew1jNflkYCFOA+7m7Avt
        gDORoQbm7j8QZJBF+pR0kHfjK3Nl
X-Google-Smtp-Source: APXvYqw26N29+Qub8Ub/ZJVZJG7pRxup0UUWkTRau57yBbLnouQ4Lumva5Q60FJpYlJ77RnCCBf5Pg==
X-Received: by 2002:a17:90a:4814:: with SMTP id a20mr5125900pjh.62.1559041093273;
        Tue, 28 May 2019 03:58:13 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m7sm8311281pff.44.2019.05.28.03.58.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 03:58:11 -0700 (PDT)
Date:   Tue, 28 May 2019 19:58:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190528105806.GA21060@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:53:01PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 May 2019 12:52:48 +0900 Minchan Kim wrote:
> > +static int madvise_cool_pte_range(pmd_t *pmd, unsigned long addr,
> > +				unsigned long end, struct mm_walk *walk)
> > +{
> > +	pte_t *orig_pte, *pte, ptent;
> > +	spinlock_t *ptl;
> > +	struct page *page;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	unsigned long next;
> > +
> > +	next = pmd_addr_end(addr, end);
> > +	if (pmd_trans_huge(*pmd)) {
> > +		spinlock_t *ptl;
> 
> Seems not needed with another ptl declared above.

Will remove it.

> > +
> > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > +		if (!ptl)
> > +			return 0;
> > +
> > +		if (is_huge_zero_pmd(*pmd))
> > +			goto huge_unlock;
> > +
> > +		page = pmd_page(*pmd);
> > +		if (page_mapcount(page) > 1)
> > +			goto huge_unlock;
> > +
> > +		if (next - addr != HPAGE_PMD_SIZE) {
> > +			int err;
> 
> Alternately, we deactivate thp only if the address range from userspace
> is sane enough, in order to avoid complex works we have to do here.

Not sure it's a good idea. That's the way we have done in MADV_FREE
so want to be consistent.

> > +
> > +			get_page(page);
> > +			spin_unlock(ptl);
> > +			lock_page(page);
> > +			err = split_huge_page(page);
> > +			unlock_page(page);
> > +			put_page(page);
> > +			if (!err)
> > +				goto regular_page;
> > +			return 0;
> > +		}
> > +
> > +		pmdp_test_and_clear_young(vma, addr, pmd);
> > +		deactivate_page(page);
> > +huge_unlock:
> > +		spin_unlock(ptl);
> > +		return 0;
> > +	}
> > +
> > +	if (pmd_trans_unstable(pmd))
> > +		return 0;
> > +
> > +regular_page:
> 
> Take a look at pending signal?

Do you have any reason to see pending signal here? I want to know what's
your requirement so that what's the better place to handle it.

> 
> > +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> 
> s/end/next/ ?

Why do you think it should be next?

> > +		ptent = *pte;
> > +
> > +		if (pte_none(ptent))
> > +			continue;
> > +
> > +		if (!pte_present(ptent))
> > +			continue;
> > +
> > +		page = vm_normal_page(vma, addr, ptent);
> > +		if (!page)
> > +			continue;
> > +
> > +		if (page_mapcount(page) > 1)
> > +			continue;
> > +
> > +		ptep_test_and_clear_young(vma, addr, pte);
> > +		deactivate_page(page);
> > +	}
> > +
> > +	pte_unmap_unlock(orig_pte, ptl);
> > +	cond_resched();
> > +
> > +	return 0;
> > +}
> > +
> > +static long madvise_cool(struct vm_area_struct *vma,
> > +			unsigned long start_addr, unsigned long end_addr)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct mmu_gather tlb;
> > +
> > +	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
> > +		return -EINVAL;
> 
> No service in case of VM_IO?

I don't know VM_IO would have regular LRU pages but just follow normal
convention for DONTNEED and FREE.
Do you have anything in your mind?
