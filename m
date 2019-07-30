Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF096C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF3D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564488678;
	bh=gw814FfJtrLshc5h1nYd2yzsg+qlM4XEhrVRQauZo9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=auQf75BplCXdApVT/8m7ooOsZMDDcbTBWfzv0ArjMCX/nS/fnb7oFp/BkY4bNz9N0
	 CyM/S5FpmL0EBKOLaefa/hgZpfGiK+vJBMSH5ZH85wFKJxtH6MUJv7RfDj3KP2AXxT
	 6ChHjABZYa/SQDJUJ2nXl71C9jgh5ZZ+oY63HYOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfG3MLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:11:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39110 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfG3MLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:11:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so29966357pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wpon5LXiMRjWM4VYIexd4NaoumE7zgOXY2Q2zhMR31E=;
        b=bYOaA1bjRco0KHiZUAi1zM5jzjhzBM9TFIVJFCNiCUd9klzlUnSBKKxdDG4ISThyEg
         dKAvL9lhA4uGT5YSTc3c/AQ7R68uUd7Qh3u1Ib/j9CIUG36TpMQxJJbYXw7vHVZcO59A
         BczKwzrUBb0l+kBbfjr/G3/FnLYjZdWYP52hSIax7z7O3Giv8C50XnV4a1Vpu+gJS4Xd
         8PI7hObtiD+MWvhhPxwZw+For/ajH7QgYSyEkQtIVLp2461/mPALNlafvpkaB1gsbWiP
         /RDkpdDEAStH+4711XBFhYWtRgR3XN777zbvF4LMwCWK3qOQ3nCovPrhKed6mVA5NYFU
         K3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wpon5LXiMRjWM4VYIexd4NaoumE7zgOXY2Q2zhMR31E=;
        b=NZGw05Ne2wLf12rBoie5NtH2gK8FupRl1E1Nbv/GFeTsalmW0kRKYvZgy6sDMpzTmE
         IC5i6O/bMag23h6ZJlHhWcTOyVJbY/wOKiY02YZXe8+lciij/jZm0EwIrlSuraHIxVOM
         ndiS07uM/evR7R1bPESUbSlgRV5Lr/Okh8221gLuL/COumy4TIkw3MgB11wOLPeGSifl
         3lnmU1kifHXI4X0LzhaWXArBByBscg/OPyvpHTKkKsz5HGmJCSr5aSYJuUEB3cqObLDX
         gzNKFUFSQ2Af0vN1xju2KoaT0h/oinrcqGf8hmz+Y0NXap+FGu6jd04DTWBgKXz7fX5t
         QjnA==
X-Gm-Message-State: APjAAAWsDR4UIHyP16csB5GHeVY6E/bzauwF1XlOCorOhmNnAYbTTzvg
        ywUViR/aa1XUApdxKdwERIo=
X-Google-Smtp-Source: APXvYqz+7hvZ1/fI1zRquioobNABSKavQ8310Y3CJ+5E/soZhgZLg7s+89NlIGB9IMVG6KNx+Kd2Nw==
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr114501776pje.123.1564488676117;
        Tue, 30 Jul 2019 05:11:16 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a5sm56153980pjv.21.2019.07.30.05.11.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 05:11:14 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:11:10 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190730121110.GA184615@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729083515.GD9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:35:15AM +0200, Michal Hocko wrote:
> On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> > On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > > takes above 6ms with preemption disabled easily. When I see that, the
> > > > reason is it holds page table spinlock during entire 512 page operation
> > > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > > run in the time because it could make frame drop or glitch audio problem.
> > > 
> > > Where is the time spent during the tear down? 512 pages doesn't sound
> > > like a lot to tear down. Is it the TLB flushing?
> > 
> > Miguel confirmed there is no such big latency without mark_page_accessed
> > in zap_pte_range so I guess it's the contention of LRU lock as well as
> > heavy activate_page overhead which is not trivial, either.
> 
> Please give us more details ideally with some numbers.

I had a time to benchmark it via adding some trace_printk hooks between
pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
device is 2018 premium mobile device.

I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
task runs on little core even though it doesn't have any IPI and LRU
lock contention. It's already too heavy.

If I remove activate_page, 35-40% overhead of zap_pte_range is gone
so most of overhead(about 0.7ms) comes from activate_page via
mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
accumulate up to several ms.
