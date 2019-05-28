Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD44C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64120883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559047176;
	bh=fLQob2yJV1r+QFvvnTJN4+CryXMorkmFnQHvueISkUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+2IcELpZ5YtpCvVh5V77IehHOkBSaIocl94ddyUJKkrbF3hyMTB70ryUAyUdljvm
	 oNocHaCrhKS7awhPgjlNHt5p6mUjfwbk3Pd7xwf6XODIN2UGGChk0j+WU/pDSxuPtv
	 EHPw5Sv+dHKZlNzFtjc1FfCQXrrdnPYLR7iGm5Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfE1Mjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:39:35 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42629 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfE1Mje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:39:34 -0400
Received: by mail-pg1-f179.google.com with SMTP id 33so7960043pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0GGJ9E3lhqD0UC/knIrJEgiqCZ8PrxRG6rZ2SffQ2U=;
        b=UGOy2/kZjdBjgfqvj1j+jxHyO5V/VSEN+HuHhC+2OGbzfLU7oqz0skSQ+OlstxFagu
         Oh/P/pIHFr82HvV4kKoX7NLHUuUz7XTtoQCn7pnhyHUjvRaDR6aOwNZthNLoqFxYGdis
         MKZGhRt3nQpWj3oX09OEYSwF5JC3T/Jw0wQ+12b7xHbCS4S1/IFLXck/d+fHU7AmWRMZ
         r7vsq7jfxI8BhYamJ+HmZuSHnu/6XMSsbg21SvWzAUOfukwhdnTrHkYVHdR4QTQUdzGC
         PudCObJVy0vCeVUi5BFF7wLRoAbIJlictzAx2JgexOMgb7af3/yOcwkQ7anksLfwZCpa
         fEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0GGJ9E3lhqD0UC/knIrJEgiqCZ8PrxRG6rZ2SffQ2U=;
        b=Wyu/XX+uADdjL2OLn4uvmRrUo+RR92k8nPdH/hEFhPt1t8dKa7OEfKK7hJM80rIoQy
         7H87lSneOAm69L/wflhybVfrlcxXN8c0HPVr3drzxeGa5czAFx7GLrYBugpqgVskLFnk
         a5LuLAdYWqOtPz4f/KKBshpFUawBUe5xp9yPV5UjDT832CIYYLDcynenFw0/VjV7ltXc
         F0M7XU8eLvWI/3IkbZCGIw2NW2htaxc1UOP3Nko+Wwr/MUg6V/9ZtL8f71evoyd7+KLn
         99MaUZqsy/mFk00Jx4hmQrZTnUFsvxgDVtdAruo37vBDD0MGdxXD6Z2DBiFnXuuvBlLY
         3ajA==
X-Gm-Message-State: APjAAAVsIAiVEi7c7Oi88N/nsk/mTCYbMwmcjSXmNCUifmyjIgQP1Po2
        eOifqhhRf7X/9NmQVvrKyRo=
X-Google-Smtp-Source: APXvYqyGM1xtjCB2K9oAV87OuF9CGEazBx3PokYX+PUZTSq8vJPyK7BaRMcc0ieAyWVWRj5Yk5ZofQ==
X-Received: by 2002:a62:2c17:: with SMTP id s23mr112882243pfs.51.1559047173978;
        Tue, 28 May 2019 05:39:33 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z32sm11451756pgk.25.2019.05.28.05.39.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 05:39:32 -0700 (PDT)
Date:   Tue, 28 May 2019 21:39:27 +0900
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
Message-ID: <20190528123927.GE30365@google.com>
References: <20190528121523.8764-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528121523.8764-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:15:23PM +0800, Hillf Danton wrote:
< snip >
> > > > +
> > > > +			get_page(page);
> > > > +			spin_unlock(ptl);
> > > > +			lock_page(page);
> > > > +			err = split_huge_page(page);
> > > > +			unlock_page(page);
> > > > +			put_page(page);
> > > > +			if (!err)
> > > > +				goto regular_page;
> > > > +			return 0;
> > > > +		}
> > > > +
> > > > +		pmdp_test_and_clear_young(vma, addr, pmd);
> > > > +		deactivate_page(page);
> > > > +huge_unlock:
> > > > +		spin_unlock(ptl);
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	if (pmd_trans_unstable(pmd))
> > > > +		return 0;
> > > > +
> > > > +regular_page:
> > >
> > > Take a look at pending signal?
> >
> > Do you have any reason to see pending signal here? I want to know what's
> > your requirement so that what's the better place to handle it.
> >
> We could bail out without work done IMO if there is a fatal siganl pending.
> And we can do that, if it makes sense to you, before the hard work.

Make sense, especically, swapping out.
I will add it in next revision.

> 
> > >
> > > > +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > > > +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> > >
> > > s/end/next/ ?
> >
> > Why do you think it should be next?
> >
> Simply based on the following line, and afraid that next != end
> 	> > > +	next = pmd_addr_end(addr, end);

pmd_addr_end will return smaller address so end is more proper.

> 
> > > > +		ptent = *pte;
> > > > +
> > > > +		if (pte_none(ptent))
> > > > +			continue;
> > > > +
> > > > +		if (!pte_present(ptent))
> > > > +			continue;
> > > > +
> > > > +		page = vm_normal_page(vma, addr, ptent);
> > > > +		if (!page)
> > > > +			continue;
> > > > +
> > > > +		if (page_mapcount(page) > 1)
> > > > +			continue;
> > > > +
> > > > +		ptep_test_and_clear_young(vma, addr, pte);
> > > > +		deactivate_page(page);
> > > > +	}
> > > > +
> > > > +	pte_unmap_unlock(orig_pte, ptl);
> > > > +	cond_resched();
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static long madvise_cool(struct vm_area_struct *vma,
> > > > +			unsigned long start_addr, unsigned long end_addr)
> > > > +{
> > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > +	struct mmu_gather tlb;
> > > > +
> > > > +	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
> > > > +		return -EINVAL;
> > >
> > > No service in case of VM_IO?
> >
> > I don't know VM_IO would have regular LRU pages but just follow normal
> > convention for DONTNEED and FREE.
> > Do you have anything in your mind?
> >
> I want to skip a mapping set up for DMA.

What you meant is those pages in VM_IO vma are not in LRU list?
Or
pages in the vma are always pinned so no worth to deactivate or reclaim?
