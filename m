Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A2C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BA215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570192642;
	bh=FAzojmdPNkVJcQ++mzq0Bw8iUir2p33ToR5u5Hn3qQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F03t4PgckVROX3+CoaRpBMQHt1jI4O//Bth5JDc3Kh9dA5k1poBkwuOP9Pz4LwgdE
	 aNgkVwZBhQiplXZdUK4NIsNqnUWaPq+2vZlt5J6NUQ4KYKHmBxZxD0Ojj9a3jbNMjS
	 U8vHLuHOLfFKReu2x4LUAE4HKdRAu5oFvglZ4tXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfJDMhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387501AbfJDMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5899B125;
        Fri,  4 Oct 2019 12:37:18 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:37:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004123718.GI9578@dhcp22.suse.cz>
References: <157018386639.6110.3058050375244904201.stgit@buzz>
 <20191004121017.GG32665@bombadil.infradead.org>
 <20191004122727.GA10845@dhcp22.suse.cz>
 <257f6172-971b-e0bd-0a74-30a0d143d6f9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257f6172-971b-e0bd-0a74-30a0d143d6f9@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 15:32:01, Konstantin Khlebnikov wrote:
> 
> 
> On 04/10/2019 15.27, Michal Hocko wrote:
> > On Fri 04-10-19 05:10:17, Matthew Wilcox wrote:
> > > On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
> > > > This is very slow operation. There is no reason to do it again if somebody
> > > > else already drained all per-cpu vectors after we waited for lock.
> > > > +	seq = raw_read_seqcount_latch(&seqcount);
> > > > +
> > > >   	mutex_lock(&lock);
> > > > +
> > > > +	/* Piggyback on drain done by somebody else. */
> > > > +	if (__read_seqcount_retry(&seqcount, seq))
> > > > +		goto done;
> > > > +
> > > > +	raw_write_seqcount_latch(&seqcount);
> > > > +
> > > 
> > > Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
> > > have the same effect?
> > 
> > Yeah, this makes sense. From correctness point of view it should be ok
> > because no caller can expect that per-cpu pvecs are empty on return.
> > This might have some runtime effects that some paths might retry more -
> > e.g. offlining path drains pcp pvces before migrating the range away, if
> > there are pages still waiting for a worker to drain them then the
> > migration would fail and we would retry. But this not a correctness
> > issue.
> > 
> 
> Caller might expect that pages added by him before are drained.
> Exiting after mutex_trylock() will not guarantee that.
> 
> For example POSIX_FADV_DONTNEED uses that.

OK, I was not aware of this case. Please make sure to document that in
the changelog and a comment in the code wouldn't hurt either. It would
certainly explain more thatn "Piggyback on drain done by somebody
else.".

Thanks!
-- 
Michal Hocko
SUSE Labs
