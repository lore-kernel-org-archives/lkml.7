Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71AAC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B52081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558340386;
	bh=xF84CdxIjO8C8zV6xXT3nd+sydUEA5/2KHb/XrEYxFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=faij8x0Sm6zQ6hpg4ccNpOtVOsDZkcoZO7JsCLihfjURaJQDUqEs+tQT1x3+uxkqG
	 xdBdbNr5PtVHUC8cEs93SU8ZyH1c9O9D5yGSgaKp+EQbRe5hTSD5PY7May2H7MoSvZ
	 ZMAEGdqK3iLrR6srAvhvzAVCSpI4y5Jueraci9gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfETITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:19:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfETITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:19:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19660AE48;
        Mon, 20 May 2019 08:19:44 +0000 (UTC)
Date:   Mon, 20 May 2019 10:19:43 +0200
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
Message-ID: <20190520081943.GW6836@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520081621.GV6836@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-05-19 10:16:21, Michal Hocko wrote:
> [CC linux-api]
> 
> On Mon 20-05-19 12:52:48, Minchan Kim wrote:
> > When a process expects no accesses to a certain memory range
> > it could hint kernel that the pages can be reclaimed
> > when memory pressure happens but data should be preserved
> > for future use.  This could reduce workingset eviction so it
> > ends up increasing performance.
> > 
> > This patch introduces the new MADV_COOL hint to madvise(2)
> > syscall. MADV_COOL can be used by a process to mark a memory range
> > as not expected to be used in the near future. The hint can help
> > kernel in deciding which pages to evict early during memory
> > pressure.
> 
> I do not want to start naming fight but MADV_COOL sounds a bit
> misleading. Everybody thinks his pages are cool ;). Probably MADV_COLD
> or MADV_DONTNEED_PRESERVE.

OK, I can see that you have used MADV_COLD for a different mode.
So this one is effectively a non destructive MADV_FREE alternative
so MADV_FREE_PRESERVE would sound like a good fit. Your MADV_COLD
in other patch would then be MADV_DONTNEED_PRESERVE. Right?

-- 
Michal Hocko
SUSE Labs
