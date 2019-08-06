Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC80C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A860214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565088918;
	bh=Wpc7UFRtSn91DP/hlpVpiyZpzyo3vr6qsPFJwNUwfP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JZh3KheW9xa25Lol8vTa3ZwZjIHPmp4qf7WZvV2RdgMqPW6m1SJjkmuJA7ObSXm/L
	 l50Mr/0lrk5NmD/TOlEfhUgpb1jOUqt+LB3NmQOXkY4crE1hrLXhljqhjOj00Vy4Yb
	 qesB543DpArPss1l8d0DnBfpIo7PdRmC0f7W2dLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfHFKzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:55:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfHFKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:55:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so41298747pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oa5z6zUvCHcd7r910UMaS4iQDg5URkCU1Ylsu0mgnns=;
        b=blv8rluI18O6mziiEb2dE4tZgdd+rRx2neLdiacDFpSj6cKi/JVgKIEpfl3XbLdHZ3
         z2Z4xTX0KMsT6r+sQv4cwLvWDRXLPdJ7HxEFdqDAS69w2UjEgYqX1O54hmoPijaPpOlg
         4fPbhHpn0CBaDJeekIvtg6hyw+Fh7fyBune0pzfEetyOLl1L+SOwPdqGNQv6/CUArNrn
         Ahtddt682EsIVhH5tqFu7VRgj+wmbX61q9Xj6PqIbMeCkJ/7w+UXuorVaVkKZ7n3e/eB
         3re38XoitkuxZjIsHBlY2sfzc9MyeITx+MK0hNdTz/4P3hwVyHQxTtogGSezk/+NYOuJ
         T6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oa5z6zUvCHcd7r910UMaS4iQDg5URkCU1Ylsu0mgnns=;
        b=ZwMkk12IL5UMQ/4DquHeyXtX559TuDff1iARYy5NCrSxTij05cAegK1j7l8BqwR0Iy
         ZvyKoJuWZSasurz0E++2m7Vb+ATtrhbrJdIKhhAagZjhuWW56au08Ts381pRHDwoI09I
         qVLhZ8+2CYzoNyS9xQujRFeeOt9lutgjBAA/zbtp8lGRwX3O5u52pij/GVHF6mK6gITp
         12+9i2Qb+hu9IhAdANFE/nk+jZZDlm0uajY6P7b50/ToEJWjsBlXvustWLjC2eHQDprA
         M+f3y32wy2fyy1lQZOhU4MmO28PcNmI5mjNmN5S0JEkqlfFUjBmtUrGbSSYRSSLauVEG
         gR8w==
X-Gm-Message-State: APjAAAVilokKyOEKiIEwDC97B6Wj+aqHls0ysORsis9wI4ZBbLlhIqlI
        Ot/txbTepdSDO0+68j1uihM=
X-Google-Smtp-Source: APXvYqyQN7R6BSpr072n52qskPQBVMmzd3IQWnQI+qk4MMW2i6gA9H2POAcCLk9dZyoMIglmWEsqWg==
X-Received: by 2002:a62:5c3:: with SMTP id 186mr3056758pff.144.1565088915615;
        Tue, 06 Aug 2019 03:55:15 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z24sm15294361pga.2.2019.08.06.03.55.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:55:14 -0700 (PDT)
Date:   Tue, 6 Aug 2019 19:55:09 +0900
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
Message-ID: <20190806105509.GA94582@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731072101.GX9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 09:21:01AM +0200, Michal Hocko wrote:
> On Wed 31-07-19 14:44:47, Minchan Kim wrote:
> > On Tue, Jul 30, 2019 at 02:57:51PM +0200, Michal Hocko wrote:
> > > [Cc Nick - the email thread starts http://lkml.kernel.org/r/20190729071037.241581-1-minchan@kernel.org
> > >  A very brief summary is that mark_page_accessed seems to be quite
> > >  expensive and the question is whether we still need it and why
> > >  SetPageReferenced cannot be used instead. More below.]
> > > 
> > > On Tue 30-07-19 21:39:35, Minchan Kim wrote:
> [...]
> > > > commit bf3f3bc5e73
> > > > Author: Nick Piggin <npiggin@suse.de>
> > > > Date:   Tue Jan 6 14:38:55 2009 -0800
> > > > 
> > > >     mm: don't mark_page_accessed in fault path
> > > > 
> > > >     Doing a mark_page_accessed at fault-time, then doing SetPageReferenced at
> > > >     unmap-time if the pte is young has a number of problems.
> > > > 
> > > >     mark_page_accessed is supposed to be roughly the equivalent of a young pte
> > > >     for unmapped references. Unfortunately it doesn't come with any context:
> > > >     after being called, reclaim doesn't know who or why the page was touched.
> > > > 
> > > >     So calling mark_page_accessed not only adds extra lru or PG_referenced
> > > >     manipulations for pages that are already going to have pte_young ptes anyway,
> > > >     but it also adds these references which are difficult to work with from the
> > > >     context of vma specific references (eg. MADV_SEQUENTIAL pte_young may not
> > > >     wish to contribute to the page being referenced).
> > > > 
> > > >     Then, simply doing SetPageReferenced when zapping a pte and finding it is
> > > >     young, is not a really good solution either. SetPageReferenced does not
> > > >     correctly promote the page to the active list for example. So after removing
> > > >     mark_page_accessed from the fault path, several mmap()+touch+munmap() would
> > > >     have a very different result from several read(2) calls for example, which
> > > >     is not really desirable.
> > > 
> > > Well, I have to say that this is rather vague to me. Nick, could you be
> > > more specific about which workloads do benefit from this change? Let's
> > > say that the zapped pte is the only referenced one and then reclaim
> > > finds the page on inactive list. We would go and reclaim it. But does
> > > that matter so much? Hot pages would be referenced from multiple ptes
> > > very likely, no?
> > 
> > As Nick mentioned in the description, without mark_page_accessed in
> > zapping part, repeated mmap + touch + munmap never acticated the page
> > while several read(2) calls easily promote it.
> 
> And is this really a problem? If we refault the same page then the
> refaults detection should catch it no? In other words is the above still
> a problem these days?

I admit we have been not fair for them because read(2) syscall pages are
easily promoted regardless of zap timing unlike mmap-based pages.

However, if we remove the mark_page_accessed in the zap_pte_range, it
would make them more unfair in that read(2)-accessed pages are easily
promoted while mmap-based page should go through refault to be promoted.

I also want to remove the costly overhead from the hot path but couldn't
come up with nice solution.
