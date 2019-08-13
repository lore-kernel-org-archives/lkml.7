Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC4C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287120663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqulxs/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHMRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:22:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfHMRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:22:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so6708239pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=k8N1+CVxt+RJj8Si9vYbnsuXtAKEpExU7o2UK2KgdhA=;
        b=Wqulxs/IqBFJerqJEhOtZ6R8tJJJ4oo6uKVQRnyyCSK6crKU0MUkbeWvT+IutOzfK7
         I6KpqsK28kEq5P5h/CNsz/7Iic03Pu3YnV5l6xv2IOPAEguLIuXxPrp5KtIf3T+Wxkbo
         HFMJFR8kaC9/kGtWe+PQe3dnMf92OxiYZWZYY0Mqc21LETZr9UX9BYAoeyWOMef9x1+U
         yl4E6RhhBtjYdDN8tZc6cSaW3viAsk2jgUnmZK1zmbgIGHEQHhED5T4ahqKVm3AI/YEo
         QJkMfqqGEox5DER+eJJl3xVcge13QA9IJZkoaLR7BhJ2CBT3yH/w0l5fIjhd+6eYkhqA
         F76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=k8N1+CVxt+RJj8Si9vYbnsuXtAKEpExU7o2UK2KgdhA=;
        b=FsP3QynjCW/BXzMco9kApQ/ECuNvgBgMTz1cD8Vw1YzUWMynvr+jLl6oFZjAMwyPYB
         xUUcN94IwbQN8lLorvwdwL97Pd638p0gDhrcnTu6RP7RmSPz6sVXzszBH1WWVPHaJm6Q
         QX5Hy/4BhUQodoh5prPC8iYgJ8EFDfjEEM0QFItNP7sj7ZD809J1689SL8EPlx1Grjj2
         iI9oqtNWEPK9HClNeFV9aE3pMsT/+0TPe+O3QNLtSR1grvXvBhxDO0rcBWepxk9wXEgr
         BJ+xC9tqbOBfUHKXNUh8H/1PGAwQCxRugxmhVlLYnd48PqVjrC4Nr1hi8HTOLFtsbe1j
         1SrQ==
X-Gm-Message-State: APjAAAWj7W+sTxPBpDawEpofDbXN+qwlhnZVEQmYPIV6b2TKisZwM6fX
        5Ua6Yf8Y465aQ7K3UNzkc8ySLw==
X-Google-Smtp-Source: APXvYqzgpMvNagdXqj1a0ANkB3Dtmxg8Umv6rI8BDjlaJFsyT8mZstls16B/grRHwkMkJtMnZcrlsA==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr3272874pjr.132.1565716962792;
        Tue, 13 Aug 2019 10:22:42 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z4sm166362957pfg.166.2019.08.13.10.22.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:22:41 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:22:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, page_alloc: move_freepages should not examine struct
 page of reserved memory
In-Reply-To: <3aadeed1-3f38-267d-8dae-839e10a2f9d2@suse.cz>
Message-ID: <alpine.DEB.2.21.1908131018450.230426@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com> <3aadeed1-3f38-267d-8dae-839e10a2f9d2@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Vlastimil Babka wrote:

> > After commit 907ec5fca3dc ("mm: zero remaining unavailable struct pages"),
> > struct page of reserved memory is zeroed.  This causes page->flags to be 0
> > and fixes issues related to reading /proc/kpageflags, for example, of
> > reserved memory.
> > 
> > The VM_BUG_ON() in move_freepages_block(), however, assumes that
> > page_zone() is meaningful even for reserved memory.  That assumption is no
> > longer true after the aforementioned commit.
> 
> How comes that move_freepages_block() gets called on reserved memory in
> the first place?
> 

It's simply math after finding a valid free page from the per-zone free 
area to use as fallback.  We find the beginning and end of the pageblock 
of the valid page and that can bring us into memory that was reserved per 
the e820.  pfn_valid() is still true (it's backed by a struct page), but 
since it's zero'd we shouldn't make any inferences here about comparing 
its node or zone.  The current node check just happens to succeed most of 
the time by luck because reserved memory typically appears on node 0.

The fix here is to validate that we actually have buddy pages before 
testing if there's any type of zone or node strangeness going on.

> > There's no reason why move_freepages_block() should be testing the
> > legitimacy of page_zone() for reserved memory; its scope is limited only
> > to pages on the zone's freelist.
> > 
> > Note that pfn_valid() can be true for reserved memory: there is a backing
> > struct page.  The check for page_to_nid(page) is also buggy but reserved
> > memory normally only appears on node 0 so the zeroing doesn't affect this.
> > 
> > Move the debug checks to after verifying PageBuddy is true.  This isolates
> > the scope of the checks to only be for buddy pages which are on the zone's
> > freelist which move_freepages_block() is operating on.  In this case, an
> > incorrect node or zone is a bug worthy of being warned about (and the
> > examination of struct page is acceptable bcause this memory is not
> > reserved).
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/page_alloc.c | 19 ++++---------------
> >  1 file changed, 4 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2238,27 +2238,12 @@ static int move_freepages(struct zone *zone,
> >  	unsigned int order;
> >  	int pages_moved = 0;
> >  
> > -#ifndef CONFIG_HOLES_IN_ZONE
> > -	/*
> > -	 * page_zone is not safe to call in this context when
> > -	 * CONFIG_HOLES_IN_ZONE is set. This bug check is probably redundant
> > -	 * anyway as we check zone boundaries in move_freepages_block().
> > -	 * Remove at a later date when no bug reports exist related to
> > -	 * grouping pages by mobility
> > -	 */
> > -	VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
> > -	          pfn_valid(page_to_pfn(end_page)) &&
> > -	          page_zone(start_page) != page_zone(end_page));
> > -#endif
> >  	for (page = start_page; page <= end_page;) {
> >  		if (!pfn_valid_within(page_to_pfn(page))) {
> >  			page++;
> >  			continue;
> >  		}
> >  
> > -		/* Make sure we are not inadvertently changing nodes */
> > -		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
> > -
> >  		if (!PageBuddy(page)) {
> >  			/*
> >  			 * We assume that pages that could be isolated for
> > @@ -2273,6 +2258,10 @@ static int move_freepages(struct zone *zone,
> >  			continue;
> >  		}
> >  
> > +		/* Make sure we are not inadvertently changing nodes */
> > +		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
> > +		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
> 
> The later check implies the former check, so if it's to stay, the first
> one could be removed and comment adjusted s/nodes/zones/
> 

Does it?  The first is checking for a corrupted page_to_nid the second is 
checking for a corrupted or unexpected page_zone.  What's being tested 
here is the state of struct page, as it was previous to this patch, not 
the state of struct zone.
