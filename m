Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21E4215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570192051;
	bh=5BsV8wSWbxyVqhhX79nMUYfk6RC2pG+PtlDpZLgRmbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fYJ6+Oh+PRp0bocn4zTuxMZcyytVwgWYTdyOCb8zR2C4xnXKJ7tMHDcC/bWJ7lP6l
	 VYy0pf6X24H/kmsvgcgkglN6N64MCLJu0qSJa0ddcfvznyGd4ONZzSCXhTaB/aX9mp
	 pub9otaikFxPYYX/rzV/gypEn/d8E5NYchko4eCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfJDM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730101AbfJDM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EC52AD14;
        Fri,  4 Oct 2019 12:27:28 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:27:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004122727.GA10845@dhcp22.suse.cz>
References: <157018386639.6110.3058050375244904201.stgit@buzz>
 <20191004121017.GG32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004121017.GG32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 05:10:17, Matthew Wilcox wrote:
> On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
> > This is very slow operation. There is no reason to do it again if somebody
> > else already drained all per-cpu vectors after we waited for lock.
> > +	seq = raw_read_seqcount_latch(&seqcount);
> > +
> >  	mutex_lock(&lock);
> > +
> > +	/* Piggyback on drain done by somebody else. */
> > +	if (__read_seqcount_retry(&seqcount, seq))
> > +		goto done;
> > +
> > +	raw_write_seqcount_latch(&seqcount);
> > +
> 
> Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
> have the same effect?

Yeah, this makes sense. From correctness point of view it should be ok
because no caller can expect that per-cpu pvecs are empty on return.
This might have some runtime effects that some paths might retry more -
e.g. offlining path drains pcp pvces before migrating the range away, if
there are pages still waiting for a worker to drain them then the
migration would fail and we would retry. But this not a correctness
issue.

-- 
Michal Hocko
SUSE Labs
