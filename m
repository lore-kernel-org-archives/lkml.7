Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D177C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B6C20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564515737;
	bh=G5+s1InOymlQadkno0e/3LGyQgNwNdbMQyvnM6WZAnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Nb1DdO8qkeeDuJL1UtGu/QPtQaohv4SV6H4CPZbICZHqQAtQU7OIxtut3kQ4OPXqa
	 wn2wkbIISWDTCWcwM+s3/on0FkfmGK/zUT+VKGaQNOsY+/2JoA8g0MFDcihv9znCd8
	 XSyX7EjVuzpJWkExqb2AEYweFOg16CpxpTqkw1o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfG3TmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:42:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG3TmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:42:12 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 878213336;
        Tue, 30 Jul 2019 19:42:09 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:42:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-Id: <20190730124207.da70f92f19dc021bf052abd0@linux-foundation.org>
In-Reply-To: <20190729082052.GA258885@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
        <20190729074523.GC9330@dhcp22.suse.cz>
        <20190729082052.GA258885@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 17:20:52 +0900 Minchan Kim <minchan@kernel.org> wrote:

> > > @@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  	flush_tlb_batched_pending(mm);
> > >  	arch_enter_lazy_mmu_mode();
> > >  	do {
> > > -		pte_t ptent = *pte;
> > > +		pte_t ptent;
> > > +
> > > +		if (progress >= 32) {
> > > +			progress = 0;
> > > +			if (need_resched())
> > > +				break;
> > > +		}
> > > +		progress += 8;
> > 
> > Why 8?
> 
> Just copied from copy_pte_range.

copy_pte_range() does

		if (pte_none(*src_pte)) {
			progress++;
			continue;
		}
		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
							vma, addr, rss);
		if (entry.val)
			break;
		progress += 8;

which appears to be an attempt to balance the cost of copy_one_pte()
against the cost of not calling copy_one_pte().

Your code doesn't do this balancing and hence can be simpler.

It all seems a bit overdesigned.  need_resched() is cheap.  It's
possibly a mistake to check need_resched() on *every* loop because some
crazy scheduling load might livelock us.  But surely it would be enough
to do something like

	if (progress++ && need_resched()) {
		<reschedule>
		progress = 0;
	}

and leave it at that?
