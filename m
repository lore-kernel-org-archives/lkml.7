Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65787206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564553689;
	bh=B4fuF08OCJeiKMcHrXjDRih8nxRz15VJsD0f//El0EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eMc+R2etfqaE24pc5cLqLoltoLihvmIx0u04ZTUElHlJLqxDhZ8vjPXZ3NgFIlDTN
	 l8WjQt/W2k9BtX9zIypG0/SkvYQ59y9cQLxJ3e/6YWCNMbq0c7jmOfRzaphwWjgEKH
	 lKdwcXoyDZ3F88gIv1uegqcjrf5cG4RWTGjwwTwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGaGOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:14:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41792 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfGaGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:14:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so29887790pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iqFMksg+GEFnhHcmM4K8TjXa4SGBpwoJKaNawCff3BE=;
        b=pIS3Y8SuH3hxHZYjEY+VPhyyjAyo+FGqtGWW4NAuNJfqiqSygcvaq1zogoZMZ22TDV
         e5/jFcKAqDx4QgkhPV/1LWdmUTVf2YDlRCVHSue09MBhLKtMMGWoxspklADGUYxUARbJ
         46c8B/8+nQT0JQ7zxbD0kr8Vock5IGm9m0UJ+m6oCCl3Q06B+1fGK6bCiDdMJdQQucoY
         0v8ReN13g5if32JdgIjkTLHW7JfgkznVnENKTdGMGreyrD3BpaVGsIQIjIoZXNLxzCzo
         0R7aNcYuW3KqKa7dbBwWu3xZthNfGW+NlU04sAXWE4Ds4uO6RSpJ1mgPAfQfkoGmC6qg
         gL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqFMksg+GEFnhHcmM4K8TjXa4SGBpwoJKaNawCff3BE=;
        b=fwYbxNDjTVFhwBSuM02vyr4VeJi6q5Tc7ZuIWKhjKByMcMcoLwENzh4vd7Aqw3SgZ7
         sptzWWtL4W7ywYx7/sBhXavaGUbtWQ6IynO17gBKBX82uIYHqlUFJwqXtkd/oDpivSpa
         koUgi9GFZ0KyhFhlqSW+IMk2ucrsBsnIiH6Skts4F8+r/oYLRmDNG7G3zQwoUH5Pw3va
         YcUqJYVcXDjqgXtbzNGAB0viwrbsgPJ5SuTZW9HVcY7oCufUR7S5WxCdiyHBjFxWJdaQ
         +Hyi8sQnkoYt0ISjp8qVnuBwvcy5vdDjq1JO2ubWbjgGICcIpab1qyIgcAxdNXqGmeYj
         jl9Q==
X-Gm-Message-State: APjAAAUAqSabs5wm6GjE0Gx7F7fPNakdps2Q6zvorvDP9yC/ON9Rv2Dp
        NDBZTfTmQDubgIbqYZn4sHA=
X-Google-Smtp-Source: APXvYqx8tKIyBtlv4dSHH0G37FgBEdYFHX+HUdL62kS7gU/eDjdnm7vXcKWh9rO0yaniakChi9hDcQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr122711848plb.30.1564553685998;
        Tue, 30 Jul 2019 23:14:45 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 22sm76624580pfu.179.2019.07.30.23.14.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:14:44 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:14:40 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190731061440.GC155569@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190730124207.da70f92f19dc021bf052abd0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730124207.da70f92f19dc021bf052abd0@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:42:07PM -0700, Andrew Morton wrote:
> On Mon, 29 Jul 2019 17:20:52 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > > > @@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  	flush_tlb_batched_pending(mm);
> > > >  	arch_enter_lazy_mmu_mode();
> > > >  	do {
> > > > -		pte_t ptent = *pte;
> > > > +		pte_t ptent;
> > > > +
> > > > +		if (progress >= 32) {
> > > > +			progress = 0;
> > > > +			if (need_resched())
> > > > +				break;
> > > > +		}
> > > > +		progress += 8;
> > > 
> > > Why 8?
> > 
> > Just copied from copy_pte_range.
> 
> copy_pte_range() does
> 
> 		if (pte_none(*src_pte)) {
> 			progress++;
> 			continue;
> 		}
> 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
> 							vma, addr, rss);
> 		if (entry.val)
> 			break;
> 		progress += 8;
> 
> which appears to be an attempt to balance the cost of copy_one_pte()
> against the cost of not calling copy_one_pte().
> 

Indeed.

> Your code doesn't do this balancing and hence can be simpler.

Based on the balancing code of copy_one_pte, it seems we should balance
it with cost of mark_page_accessed against the cost of not calling
mark_page_accessed. IOW, add up 8 only when mark_page_accessed is called.

However, every mark_page_accessed is not heavy since it uses pagevec
and caller couldn't know whether the target page will be activated or
just have PG_referenced which is cheap. Thus, I agree, do not make it
complicated.

> 
> It all seems a bit overdesigned.  need_resched() is cheap.  It's
> possibly a mistake to check need_resched() on *every* loop because some
> crazy scheduling load might livelock us.  But surely it would be enough
> to do something like
> 
> 	if (progress++ && need_resched()) {
> 		<reschedule>
> 		progress = 0;
> 	}
> 
> and leave it at that?

Seems like this?

From bb1d7aaf520e98a6f9d988c25121602c28e12e67 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 29 Jul 2019 15:28:48 +0900
Subject: [PATCH] mm: release the spinlock on zap_pte_range

In our testing(carmera recording), Miguel and Wei found unmap_page_range
takes above 6ms with preemption disabled easily. When I see that, the
reason is it holds page table spinlock during entire 512 page operation
in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
run in the time because it could make frame drop or glitch audio problem.

I had a time to benchmark it via adding some trace_printk hooks between
pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
device is 2018 premium mobile device.

I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
task runs on little core even though it doesn't have any IPI and LRU
lock contention. It's already too heavy.

If I remove activate_page, 35-40% overhead of zap_pte_range is gone
so most of overhead(about 0.7ms) comes from activate_page via
mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
accumulate up to several ms.

Thus, this patch adds preemption point for once every 32 times in the
loop.

Reported-by: Miguel de Dios <migueldedios@google.com>
Reported-by: Wei Wang <wvw@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2e796372927fd..8bfcef09da674 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1007,6 +1007,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
+	int progress = 0;
 	int force_flush = 0;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
@@ -1022,7 +1023,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		pte_t ptent = *pte;
+		pte_t ptent;
+
+		if (progress++ >= 32) {
+			progress = 0;
+			if (need_resched())
+				break;
+		}
+
+		ptent = *pte;
 		if (pte_none(ptent))
 			continue;
 
@@ -1123,8 +1132,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	if (force_flush) {
 		force_flush = 0;
 		tlb_flush_mmu(tlb);
-		if (addr != end)
-			goto again;
+	}
+
+	if (addr != end) {
+		progress = 0;
+		goto again;
 	}
 
 	return addr;
-- 
2.22.0.709.g102302147b-goog

