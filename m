Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81D20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565602475;
	bh=rmMS2H6rfBmdrI6TRiVcvZH0KEUzxeD6Bc1rwdGZy4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgqIyGtHpfEJ7SDpYMqjrrUAh8/DnMXFSWkTeeRIMs/5SOJPrSvGdoZQ9YSBGl3QQ
	 EnUBfGJfqCcxyPNrQDC5AJtJqdELVaVgtfPwNf+up3xWR2Ht22Hdmsgrm+wrnBa3BW
	 10rYYByHn7xpONR7dEDtM98Xdiary1f8wGX1uCjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHLJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:34:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbfHLJed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:34:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C69CADEC;
        Mon, 12 Aug 2019 09:34:32 +0000 (UTC)
Date:   Mon, 12 Aug 2019 11:34:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190812093430.GD5117@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
 <fb1f4958-5147-2fab-531f-d234806c2f37@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1f4958-5147-2fab-531f-d234806c2f37@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 16:54:43, Yang Shi wrote:
> 
> 
> On 8/9/19 11:26 AM, Yang Shi wrote:
> > 
> > 
> > On 8/9/19 11:02 AM, Michal Hocko wrote:
[...]
> > > I have to study the code some more but is there any reason why those
> > > pages are not accounted as proper THPs anymore? Sure they are partially
> > > unmaped but they are still THPs so why cannot we keep them accounted
> > > like that. Having a new counter to reflect that sounds like papering
> > > over the problem to me. But as I've said I might be missing something
> > > important here.
> > 
> > I think we could keep those pages accounted for NR_ANON_THPS since they
> > are still THP although they are unmapped as you mentioned if we just
> > want to fix the improper accounting.
> 
> By double checking what NR_ANON_THPS really means,
> Documentation/filesystems/proc.txt says "Non-file backed huge pages mapped
> into userspace page tables". Then it makes some sense to dec NR_ANON_THPS
> when removing rmap even though they are still THPs.
> 
> I don't think we would like to change the definition, if so a new counter
> may make more sense.

Yes, changing NR_ANON_THPS semantic sounds like a bad idea. Let
me try whether I understand the problem. So we have some THP in
limbo waiting for them to be split and unmapped parts to be freed,
right? I can see that page_remove_anon_compound_rmap does correctly
decrement NR_ANON_MAPPED for sub pages that are no longer mapped by
anybody. LRU pages seem to be accounted properly as well.  As you've
said NR_ANON_THPS reflects the number of THPs mapped and that should be
reflecting the reality already IIUC.

So the only problem seems to be that deferred THP might aggregate a lot
of immediately freeable memory (if none of the subpages are mapped) and
that can confuse MemAvailable because it doesn't know about the fact.
Has an skewed counter resulted in a user observable behavior/failures?
I can see that memcg rss size was the primary problem David was looking
at. But MemAvailable will not help with that, right? Moreover is
accounting the full THP correct? What if subpages are still mapped?

-- 
Michal Hocko
SUSE Labs
