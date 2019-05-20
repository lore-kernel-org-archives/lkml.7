Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C4C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D4F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558340185;
	bh=lPGpXXOnYAYc6rMpfQU8JT3+Wmv7ki9IOnGCh6ChLQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IGmE60gGtjor5UyE89ZnfIymf/mWPwSxfk9VKLZrWJxZKLgOEo1Y6liuGXaMgmKzv
	 dxjyIXwqKEQb4lCxa7LQZXCh/7pqR9tqGp9z3MPgSlcfLS8sOlm+RXbZ+LCCmt8Nv+
	 dKXC2n+6PGfGHwKH21q2fjDyQpvIZOG/oB6eEx+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfETIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:16:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:52238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729496AbfETIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CBF8ADEA;
        Mon, 20 May 2019 08:16:22 +0000 (UTC)
Date:   Mon, 20 May 2019 10:16:21 +0200
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
Message-ID: <20190520081621.GV6836@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC linux-api]

On Mon 20-05-19 12:52:48, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range
> it could hint kernel that the pages can be reclaimed
> when memory pressure happens but data should be preserved
> for future use.  This could reduce workingset eviction so it
> ends up increasing performance.
> 
> This patch introduces the new MADV_COOL hint to madvise(2)
> syscall. MADV_COOL can be used by a process to mark a memory range
> as not expected to be used in the near future. The hint can help
> kernel in deciding which pages to evict early during memory
> pressure.

I do not want to start naming fight but MADV_COOL sounds a bit
misleading. Everybody thinks his pages are cool ;). Probably MADV_COLD
or MADV_DONTNEED_PRESERVE.

> Internally, it works via deactivating memory from active list to
> inactive's head so when the memory pressure happens, they will be
> reclaimed earlier than other active pages unless there is no
> access until the time.

Could you elaborate about the decision to move to the head rather than
tail? What should happen to inactive pages? Should we move them to the
tail? Your implementation seems to ignore those completely. Why?

What should happen for shared pages? In other words do we want to allow
less privileged process to control evicting of shared pages with a more
privileged one? E.g. think of all sorts of side channel attacks. Maybe
we want to do the same thing as for mincore where write access is
required.
-- 
Michal Hocko
SUSE Labs
