Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C63BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A4F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558420465;
	bh=mTMabEUu9HZMTWHLlF9ySoPMEs8IE/R6YEWmU5ljFd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oO8fh4JgewgmfgScRvcakuCEVnFfmm2Qtevmiw6gSCaTLNJZOhduxvJJ8SbuTIqKx
	 1u9d2XpeD+yV6AQI7K7tLr5FXKIwqdqYvGuMOlWJ90a4s1Tro7hvsUc6CgzMB66QuG
	 ZeseHUOrvwPoYJcAL6Ba2zOdr5MX5yZnpvJwArkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfEUGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfEUGeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D7E5AEC6;
        Tue, 21 May 2019 06:34:23 +0000 (UTC)
Date:   Tue, 21 May 2019 08:34:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521063421.GG32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521014452.GA6738@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521014452.GA6738@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-api]

On Mon 20-05-19 18:44:52, Matthew Wilcox wrote:
> On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > and MADV_FREE by adding non-destructive ways to gain some free memory
> > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > when memory pressure rises.
> 
> Do we tear down page tables for these ranges?  That seems like a good
> way of reclaiming potentially a substantial amount of memory.

I do not think we can in general because this is a non-destructive
operation. So at least we cannot tear down anonymous ptes (they will
turn into swap entries).

-- 
Michal Hocko
SUSE Labs
