Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8912075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564388460;
	bh=2reDpY1GEyjzQtlHiV8p373beke5fk65+cJe/iFMedc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQneKEaUSn5YhMAzFCieWNBlNFAPWDObWVgu/+jIpmPCRwP9+e0Y9G6RWrEnqRp1p
	 PeTpmTfhUVaBfwijMi7UkPfgRSPtclMY8E15Pl3Uc/r8ds0WDRCGKAVUOE2suK7mgv
	 ISYJNL8pm+NEzfyqxs9kawV0iA+JDInE6BBsgF7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfG2IU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:20:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33456 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:20:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so27145173plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2sHb6igh5/VG31vZ5TimH3Lv/XXcD5eHvB6x/vi/sxg=;
        b=gmynHK9gyyTGbg08KX1ZQt/n4uNaNufyxFQUsiO6i7otivMqyM4q94qS47AsyjiSVz
         sh/KPvUiy8JFTmCXgaBbyvbzFmuebJJpq7OKcH656fOdOUDx1Ff2mlmF7RiGQiBYHtwU
         jbwDZsWevu5V4BTlyjpzZh3wGR1cUNovfzrkFOPT1JpXxKGxXa+IDLkxqbMdq1PEiyVk
         rrIqoI562bWsu3KXIN6408heothnZN4VbnypkaWfRf5oJo1Q3PchVIpQHMX43q+tpgCs
         MmeT9qhO+HEm7abd7SjLKzzuBbMqTIWzxZhZLX1kfTOnCT/q+up4nY4kIku7111SK4a1
         2d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2sHb6igh5/VG31vZ5TimH3Lv/XXcD5eHvB6x/vi/sxg=;
        b=B1Zq6v9ZgQ3bmKWGpOx2ZaorRDYCrpNTcrO3XqbXO8ZP8RFRCqw3jjoYzxtlDLCKx9
         9pqnHz0q67yQGtgQ6/ZigaqSflqo9MoSIX3FVQ2+MppnjyxRcuJVwjY10MhqHc4Gxiy9
         eJv5JmBdTPRspoZxfjFOsdxJ9KrwWJDp8R9wBC0mURDZMaDf4waCprQLcK37OYQzU2T+
         M9RCe3bwuT6q4zyzgEiQhLwU1ZYqZxlmDknhRhAKFpvwbIC+7nlOvt/G/oxFI0jK4a5w
         wFr65JtZk/T5TjVN4BL8gXcOrztqwoNgm66Aeh8prXRSJY54/l2rHw2isNN9zNs1lnhu
         ZfPg==
X-Gm-Message-State: APjAAAX00mG9vsR9XH7N7V4DPxEq5kZDQ4cLvztHHwrX7ewszcYSaXF0
        ZA8bDsubWzcBCuydZQTXl0YeD66a
X-Google-Smtp-Source: APXvYqzPD2uMU0BPGJcyzlG6gVZffWUBi8HGnNgWln9aj61e+obG9uHjQlq+n0jJV4ijNPnNUaKatg==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr33346954pla.182.1564388457651;
        Mon, 29 Jul 2019 01:20:57 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id n98sm60659702pjc.26.2019.07.29.01.20.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:20:56 -0700 (PDT)
Date:   Mon, 29 Jul 2019 17:20:52 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190729082052.GA258885@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729074523.GC9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > takes above 6ms with preemption disabled easily. When I see that, the
> > reason is it holds page table spinlock during entire 512 page operation
> > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > run in the time because it could make frame drop or glitch audio problem.
> 
> Where is the time spent during the tear down? 512 pages doesn't sound
> like a lot to tear down. Is it the TLB flushing?

Miguel confirmed there is no such big latency without mark_page_accessed
in zap_pte_range so I guess it's the contention of LRU lock as well as
heavy activate_page overhead which is not trivial, either.

> 
> > This patch adds preemption point like coyp_pte_range.
> > 
> > Reported-by: Miguel de Dios <migueldedios@google.com>
> > Reported-by: Wei Wang <wvw@google.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/memory.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2e796372927fd..bc3e0c5e4f89b 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1007,6 +1007,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  				struct zap_details *details)
> >  {
> >  	struct mm_struct *mm = tlb->mm;
> > +	int progress = 0;
> >  	int force_flush = 0;
> >  	int rss[NR_MM_COUNTERS];
> >  	spinlock_t *ptl;
> > @@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  	flush_tlb_batched_pending(mm);
> >  	arch_enter_lazy_mmu_mode();
> >  	do {
> > -		pte_t ptent = *pte;
> > +		pte_t ptent;
> > +
> > +		if (progress >= 32) {
> > +			progress = 0;
> > +			if (need_resched())
> > +				break;
> > +		}
> > +		progress += 8;
> 
> Why 8?

Just copied from copy_pte_range.
