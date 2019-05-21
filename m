Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA14C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2993920863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558418688;
	bh=dwP+hF54/5DDb/MoWdQiNpn5z4UDxIG5REIV0I5/T8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hJjFsDLDlIqmLKVswoQvOql8TbN//rIBt2rTj7Rx57FFO9K3Sn7VJfSIhs9tU/V/X
	 GEo8aBsyFz+hWyt9WXJjGi0CdJSSmeIfcDuZ+FpMtGiza/faJlmCGnJPQ5Z4BaXrem
	 xo7aFE7huiAgx2xKQCCDZ2uexO0qV/PustwIgVcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfEUGEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:04:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfEUGEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:04:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B8CEAC20;
        Tue, 21 May 2019 06:04:45 +0000 (UTC)
Date:   Tue, 21 May 2019 08:04:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190521060443.GA32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz>
 <20190520225419.GA10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520225419.GA10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 07:54:19, Minchan Kim wrote:
> On Mon, May 20, 2019 at 10:16:21AM +0200, Michal Hocko wrote:
[...]
> > > Internally, it works via deactivating memory from active list to
> > > inactive's head so when the memory pressure happens, they will be
> > > reclaimed earlier than other active pages unless there is no
> > > access until the time.
> > 
> > Could you elaborate about the decision to move to the head rather than
> > tail? What should happen to inactive pages? Should we move them to the
> > tail? Your implementation seems to ignore those completely. Why?
> 
> Normally, inactive LRU could have used-once pages without any mapping
> to user's address space. Such pages would be better candicate to
> reclaim when the memory pressure happens. With deactivating only
> active LRU pages of the process to the head of inactive LRU, we will
> keep them in RAM longer than used-once pages and could have more chance
> to be activated once the process is resumed.

You are making some assumptions here. You have an explicit call what is
cold now you are assuming something is even colder. Is this assumption a
general enough to make people depend on it? Not that we wouldn't be able
to change to logic later but that will always be risky - especially in
the area when somebody want to make a user space driven memory
management.
 
> > What should happen for shared pages? In other words do we want to allow
> > less privileged process to control evicting of shared pages with a more
> > privileged one? E.g. think of all sorts of side channel attacks. Maybe
> > we want to do the same thing as for mincore where write access is
> > required.
> 
> It doesn't work with shared pages(ie, page_mapcount > 1). I will add it
> in the description.

OK, this is good for the starter. It makes the implementation simpler
and we can add shared mappings coverage later.

Although I would argue that touching only writeable mappings should be
reasonably safe.

-- 
Michal Hocko
SUSE Labs
