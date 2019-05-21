Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D9C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558418903;
	bh=dXyQKvVAAS2PMMvZGhgQTK3uZ6zmRariexjEwh6Fs7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RCNb1mYUcYvdfx+dlQbFT5FiSAekTpk2ytm/yHLjfS8lQCvZ/SkcAI7YWfMiwK/sx
	 zvg0AAE0SMEeR6OjtORHi1hSx4pmNb0Oc/U5e9XYO/xgb0qx04QPztSP0c8+MjpqIC
	 6zFW+FQKTu38KTLexxQzSoQ3Brb3nROUK1rKMrK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfEUGIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:08:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfEUGIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A6FDAD45;
        Tue, 21 May 2019 06:08:21 +0000 (UTC)
Date:   Tue, 21 May 2019 08:08:20 +0200
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
Subject: Re: [RFC 3/7] mm: introduce MADV_COLD
Message-ID: <20190521060820.GB32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-4-minchan@kernel.org>
 <20190520082703.GX6836@dhcp22.suse.cz>
 <20190520230038.GD10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520230038.GD10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 08:00:38, Minchan Kim wrote:
> On Mon, May 20, 2019 at 10:27:03AM +0200, Michal Hocko wrote:
> > [Cc linux-api]
> > 
> > On Mon 20-05-19 12:52:50, Minchan Kim wrote:
> > > When a process expects no accesses to a certain memory range
> > > for a long time, it could hint kernel that the pages can be
> > > reclaimed instantly but data should be preserved for future use.
> > > This could reduce workingset eviction so it ends up increasing
> > > performance.
> > > 
> > > This patch introduces the new MADV_COLD hint to madvise(2)
> > > syscall. MADV_COLD can be used by a process to mark a memory range
> > > as not expected to be used for a long time. The hint can help
> > > kernel in deciding which pages to evict proactively.
> > 
> > As mentioned in other email this looks like a non-destructive
> > MADV_DONTNEED alternative.
> > 
> > > Internally, it works via reclaiming memory in process context
> > > the syscall is called. If the page is dirty but backing storage
> > > is not synchronous device, the written page will be rotate back
> > > into LRU's tail once the write is done so they will reclaim easily
> > > when memory pressure happens. If backing storage is
> > > synchrnous device(e.g., zram), hte page will be reclaimed instantly.
> > 
> > Why do we special case async backing storage? Please always try to
> > explain _why_ the decision is made.
> 
> I didn't make any decesion. ;-) That's how current reclaim works to
> avoid latency of freeing page in interrupt context. I had a patchset
> to resolve the concern a few years ago but got distracted.

Please articulate that in the changelog then. Or even do not go into
implementation details and stick with - reuse the current reclaim
implementation. If you call out some of the specific details you are
risking people will start depending on them. The fact that this reuses
the currect reclaim logic is enough from the review point of view
because we know that there is no additional special casing to worry
about.
-- 
Michal Hocko
SUSE Labs
