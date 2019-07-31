Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DCFC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B11B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564551896;
	bh=DlWlL6uaT2k9KfTmMXIs7WmDQw1zJNbE0+7F4W8pIjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgeF6NyremHoUX4Oj0odTZ0vBcWcq1bzhTM55aGmTU5dpDzn3tacRX3uEHPORmAPA
	 NAjE+3bLcdBNuF0Wow8hRFgh+GJdjHKE2ikhMzGCZHz645hf22Q/4wFDOUZeVYhLxp
	 +Rlus+lSLx/YZZuRc39gWYirKK7k+9B8o+iJiEzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfGaFoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:44:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35031 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaFoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:44:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so29959642plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhefx6+bI5/lxdg6oXf3wodWpmayqnB7DDdokXpcjMg=;
        b=sQjfjK3y/z/3d1JS6WvWhqo3J5FttXfKN2QWJlL8hmfsh08bqrfKSPzjH+q2i2VfxF
         xCQ2z5zwl6OtquqRKi67ATkp1OfGjV+nBURLRH7z6cMVP9/Ky7KbQU8+zW7ugMs+KqBo
         QEj06w4vrVT8k1fVsIUC5EfRbHUEJ2wDz6aYPMDeLSVQ94ZV7+UV7Z4dJHGsisMijpxT
         fcWFYOMTGkQtcJFUc/aLLuFg6Ho13xn9gZpyIwvWNOgxyibFI8p/BvqXKZPrM2pCIP+N
         33IoFcZ99cw8qXIB+c0G9p+sH6OvabS41kyP/1hHSzxYUh5fTH1UR/x9J0Buw02Bp9SL
         0zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhefx6+bI5/lxdg6oXf3wodWpmayqnB7DDdokXpcjMg=;
        b=obPBUC3fefRM26yAEP/mLY5KKm+A8Z/gz2oNq2Fk4id9gH5MN4ay6+53EKzkQAVeZ9
         QXqrrdO+RgbfD4bBUBfXGuif7KS9T2XbGpwN/JK2gIysnWrNOEYBtlgFK3UanOqvghS3
         BY60TcOg+212dkUdevvaQKrY9GkQKmh03iNyv/Q3qJJQ1TYjJXx2N4yA0AVFPyxYTik8
         bqtH/vhklVR9U3m5zj91r3XN4qYDeKp9Yz4ov+yOwcnB4t7qhM9X9qu1EkC0C9aFOzLt
         lthELIIaP470RWhcoH61VyXw0VjQLzAe1dR/9QVtfmLuoAD86ESIPkLIPNlp+mIAUIrA
         Sh/A==
X-Gm-Message-State: APjAAAVXvPw3ZZQnzwBQttHj6nIfn19mWXTQBrtszFyPMy38KqCf62WH
        cKBLkeIL2ggXi+5pTL4W1yQ=
X-Google-Smtp-Source: APXvYqw+GsX0jKceDzctiXZbIk5pPQYlHAy301YmRVfmXsab/Hyl6L4qaNTVaKCKGnaLMO3DWpwiDQ==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr108502842pls.307.1564551893301;
        Tue, 30 Jul 2019 22:44:53 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id w4sm86568867pfn.144.2019.07.30.22.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 22:44:52 -0700 (PDT)
Date:   Wed, 31 Jul 2019 14:44:47 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190731054447.GB155569@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730125751.GS9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:57:51PM +0200, Michal Hocko wrote:
> [Cc Nick - the email thread starts http://lkml.kernel.org/r/20190729071037.241581-1-minchan@kernel.org
>  A very brief summary is that mark_page_accessed seems to be quite
>  expensive and the question is whether we still need it and why
>  SetPageReferenced cannot be used instead. More below.]
> 
> On Tue 30-07-19 21:39:35, Minchan Kim wrote:
> > On Tue, Jul 30, 2019 at 02:32:37PM +0200, Michal Hocko wrote:
> > > On Tue 30-07-19 21:11:10, Minchan Kim wrote:
> > > > On Mon, Jul 29, 2019 at 10:35:15AM +0200, Michal Hocko wrote:
> > > > > On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> > > > > > On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > > > > > > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > > > > > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > > > > > > takes above 6ms with preemption disabled easily. When I see that, the
> > > > > > > > reason is it holds page table spinlock during entire 512 page operation
> > > > > > > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > > > > > > run in the time because it could make frame drop or glitch audio problem.
> > > > > > > 
> > > > > > > Where is the time spent during the tear down? 512 pages doesn't sound
> > > > > > > like a lot to tear down. Is it the TLB flushing?
> > > > > > 
> > > > > > Miguel confirmed there is no such big latency without mark_page_accessed
> > > > > > in zap_pte_range so I guess it's the contention of LRU lock as well as
> > > > > > heavy activate_page overhead which is not trivial, either.
> > > > > 
> > > > > Please give us more details ideally with some numbers.
> > > > 
> > > > I had a time to benchmark it via adding some trace_printk hooks between
> > > > pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
> > > > device is 2018 premium mobile device.
> > > > 
> > > > I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
> > > > task runs on little core even though it doesn't have any IPI and LRU
> > > > lock contention. It's already too heavy.
> > > > 
> > > > If I remove activate_page, 35-40% overhead of zap_pte_range is gone
> > > > so most of overhead(about 0.7ms) comes from activate_page via
> > > > mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
> > > > accumulate up to several ms.
> > > 
> > > Thanks for this information. This is something that should be a part of
> > > the changelog. I am sorry to still poke into this because I still do not
> > 
> > I will include it.
> > 
> > > have a full understanding of what is going on and while I do not object
> > > to drop the spinlock I still suspect this is papering over a deeper
> > > problem.
> > 
> > I couldn't come up with better solution. Feel free to suggest it.
> > 
> > > 
> > > If mark_page_accessed is really expensive then why do we even bother to
> > > do it in the tear down path in the first place? Why don't we simply set
> > > a referenced bit on the page to reflect the young pte bit? I might be
> > > missing something here of course.
> > 
> > commit bf3f3bc5e73
> > Author: Nick Piggin <npiggin@suse.de>
> > Date:   Tue Jan 6 14:38:55 2009 -0800
> > 
> >     mm: don't mark_page_accessed in fault path
> > 
> >     Doing a mark_page_accessed at fault-time, then doing SetPageReferenced at
> >     unmap-time if the pte is young has a number of problems.
> > 
> >     mark_page_accessed is supposed to be roughly the equivalent of a young pte
> >     for unmapped references. Unfortunately it doesn't come with any context:
> >     after being called, reclaim doesn't know who or why the page was touched.
> > 
> >     So calling mark_page_accessed not only adds extra lru or PG_referenced
> >     manipulations for pages that are already going to have pte_young ptes anyway,
> >     but it also adds these references which are difficult to work with from the
> >     context of vma specific references (eg. MADV_SEQUENTIAL pte_young may not
> >     wish to contribute to the page being referenced).
> > 
> >     Then, simply doing SetPageReferenced when zapping a pte and finding it is
> >     young, is not a really good solution either. SetPageReferenced does not
> >     correctly promote the page to the active list for example. So after removing
> >     mark_page_accessed from the fault path, several mmap()+touch+munmap() would
> >     have a very different result from several read(2) calls for example, which
> >     is not really desirable.
> 
> Well, I have to say that this is rather vague to me. Nick, could you be
> more specific about which workloads do benefit from this change? Let's
> say that the zapped pte is the only referenced one and then reclaim
> finds the page on inactive list. We would go and reclaim it. But does
> that matter so much? Hot pages would be referenced from multiple ptes
> very likely, no?

As Nick mentioned in the description, without mark_page_accessed in
zapping part, repeated mmap + touch + munmap never acticated the page
while several read(2) calls easily promote it.
