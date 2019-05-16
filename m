Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91AB20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="VBWQprmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEPPKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:10:17 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45768 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEPPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:10:16 -0400
Received: by mail-pg1-f182.google.com with SMTP id i21so1693442pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgItyBJzDLlqz5Gik0C+96TskxzuElNQz9xK2Z679ZU=;
        b=VBWQprmA5MZXlwsCQ6SwCKgJVN0e1o1lvPIlSlGB0YXBQ7jqt4v8fvoD4mi76vuqSM
         QiH7hBI2bl3frHolfT0kMLi9jGMjn/GJmWA9bakf6lgiL2WDCmE2w/PKCPQzWhp7Iem1
         sx0za8uNbzuAfjm3n7SLvyCizmCpY72aj8AJwWVjGE1aKvynWqKQlnH7DBbSYU8W6X73
         HCRpNHtdeWlBzb0QDCSzzJvEK2zPMKrw6F+oxIu/i0TNSezxiKi6pina0dLKUXOYU8Ma
         dUBa6NTSwUcZ/i8rc54cgBQGa5FBv9k8D4OhJdGdLZMRa3XAHOM3+B2fOA04NwYBN714
         gw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgItyBJzDLlqz5Gik0C+96TskxzuElNQz9xK2Z679ZU=;
        b=QAKfUci7jL0R5nS5nY5E1nCnaP1g0A85wURsRgCHKPm/mQAwYCDNZj3X1OKSWcNZk0
         gtGfc71kQtBnN1niyEOJYJi7PxkGbXlu4sUKrlngcQ/EWYxy4Ajy1DvnKmsihm7zoYWC
         Vs6rmamBtneUlVVLqnQcInZaCRogdjwDO05bOnngjOZrUWIlnzaK6Fc+8evmeNQ8VwPf
         PTA8opkJx/R3ff/QjEzbPZPwFjaOfi8CGhtbfmCXFjGBzAm2vHX8pLc7D0SH+NX2eJis
         gwVgSoSBVZixeo7bhOj3Zwa8Qp3rq3By+7N/mSq1fOS3uSKBBdJI1iKkjv8E8cB2T8MU
         XwoA==
X-Gm-Message-State: APjAAAVCKu5kLJ7WqTZSVFtLepbvczxUG3LwjntM2MvF+N2gT6O4Wsm8
        t6AtlpthE0JQcosZ63r4XVmhSw==
X-Google-Smtp-Source: APXvYqzKlIoNcZy0ZhhqzXFmL2Ia8ljcPo6txDYTujPDJiGwxQFbwyA5fAqpvMifyWIYzSQHgX3fKw==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr51006664pgv.330.1558019414956;
        Thu, 16 May 2019 08:10:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::b2f6])
        by smtp.gmail.com with ESMTPSA id p2sm6305231pgd.63.2019.05.16.08.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:10:14 -0700 (PDT)
Date:   Thu, 16 May 2019 11:10:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190516151012.GA20038@cmpxchg.org>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
 <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
 <20190513214503.GB25356@dhcp22.suse.cz>
 <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
 <20190514062039.GB20868@dhcp22.suse.cz>
 <509de066-17bb-e3cf-d492-1daf1cb11494@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509de066-17bb-e3cf-d492-1daf1cb11494@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 01:44:35PM -0700, Yang Shi wrote:
> On 5/13/19 11:20 PM, Michal Hocko wrote:
> > On Mon 13-05-19 21:36:59, Yang Shi wrote:
> > > On Mon, May 13, 2019 at 2:45 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > On Mon 13-05-19 14:09:59, Yang Shi wrote:
> > > > [...]
> > > > > I think we can just account 512 base pages for nr_scanned for
> > > > > isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT
> > > > > just use it.
> > > > > 
> > > > > And, sc->nr_scanned should be accounted as 512 base pages too otherwise we
> > > > > may have nr_scanned < nr_to_reclaim all the time to result in false-negative
> > > > > for priority raise and something else wrong (e.g. wrong vmpressure).
> > > > Be careful. nr_scanned is used as a pressure indicator to slab shrinking
> > > > AFAIR. Maybe this is ok but it really begs for much more explaining
> > > I don't know why my company mailbox didn't receive this email, so I
> > > replied with my personal email.
> > > 
> > > It is not used to double slab pressure any more since commit
> > > 9092c71bb724 ("mm: use sc->priority for slab shrink targets"). It uses
> > > sc->priority to determine the pressure for slab shrinking now.
> > > 
> > > So, I think we can just remove that "double slab pressure" code. It is
> > > not used actually and looks confusing now. Actually, the "double slab
> > > pressure" does something opposite. The extra inc to sc->nr_scanned
> > > just prevents from raising sc->priority.
> > I have to get in sync with the recent changes. I am aware there were
> > some patches floating around but I didn't get to review them. I was
> > trying to point out that nr_scanned used to have a side effect to be
> > careful about. If it doesn't have anymore then this is getting much more
> > easier of course. Please document everything in the changelog.
> 
> Thanks for reminding. Yes, I remembered nr_scanned would double slab
> pressure. But, when I inspected into the code yesterday, it turns out it is
> not true anymore. I will run some test to make sure it doesn't introduce
> regression.

Yeah, sc->nr_scanned is used for three things right now:

1. vmpressure - this looks at the scanned/reclaimed ratio so it won't
change semantics as long as scanned & reclaimed are fixed in parallel

2. compaction/reclaim - this is broken. Compaction wants a certain
number of physical pages freed up before going back to compacting.
Without Yang Shi's fix, we can overreclaim by a factor of 512.

3. kswapd priority raising - this is broken. kswapd raises priority if
we scan fewer pages than the reclaim target (which itself is obviously
expressed in order-0 pages). As a result, kswapd can falsely raise its
aggressiveness even when it's making great progress.

Both sc->nr_scanned & sc->nr_reclaimed should be fixed.

> BTW, I noticed the counter of memory reclaim is not correct with THP swap on
> vanilla kernel, please see the below:
> 
> pgsteal_kswapd 21435
> pgsteal_direct 26573329
> pgscan_kswapd 3514
> pgscan_direct 14417775
> 
> pgsteal is always greater than pgscan, my patch could fix the problem.

Ouch, how is that possible with the current code?

I think it happens when isolate_lru_pages() counts 1 nr_scanned for a
THP, then shrink_page_list() splits the THP and we reclaim tail pages
one by one. This goes all the way back to the initial THP patch!

isolate_lru_pages() needs to be fixed. Its return value, nr_taken, is
correct, but its *nr_scanned parameter is wrong, which causes issues:

1. The trace point, as Yang Shi pointed out, will underreport the
number of pages scanned, as it reports it along with nr_to_scan (base
pages) and nr_taken (base pages)

2. vmstat and memory.stat count 'struct page' operations rather than
base pages, which makes zero sense to neither user nor kernel
developers (I routinely multiply these counters by 4096 to get a sense
of work performed).

All of isolate_lru_pages()'s accounting should be in base pages, which
includes nr_scanned and PGSCAN_SKIPPED.

That should also simplify the code; e.g.:

	for (total_scan = 0;
	     scan < nr_to_scan && nr_taken < nr_to_scan && !list_empty(src);
	     total_scan++) {

scan < nr_to_scan && nr_taken >= nr_to_scan is a weird condition that
does not make sense in page reclaim imo. Reclaim cares about physical
memory - freeing one THP is as much progress for reclaim as freeing
512 order-0 pages.

IMO *all* '++' in vmscan.c are suspicious and should be reviewed:
nr_scanned, nr_reclaimed, nr_dirty, nr_unqueued_dirty, nr_congested,
nr_immediate, nr_writeback, nr_ref_keep, nr_unmap_fail, pgactivate,
total_scan & scan, nr_skipped.

Yang Shi, it would be nice if you could convert all of these to base
page accounting in one patch, as it's a single logical fix for the
initial introduction of THP that had huge pages show up on the LRUs.

[ check_move_unevictable_pages() seems weird. It gets a pagevec from
  find_get_entries(), which, if I understand the THP page cache code
  correctly, might contain the same compound page over and over. It'll
  be !unevictable after the first iteration, so will only run once. So
  it produces incorrect numbers now, but it is probably best to ignore
  it until we figure out THP cache. Maybe add an XXX comment. ]
