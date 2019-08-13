Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F64C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E5F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565731675;
	bh=JnDrtx/GuVJXE+K/6+7bGsOzbRZTo0uwMqXFtO03veI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ueLBWusqQoZFuVKoVNs7YXNarPfJ8X7+gChKX6KiHbgiW0hlUPbgK3hX2ICZhMTxi
	 rvgGfzKfYUvg6C+CTPI0Q//imuqtdrqfLVjc6bfHNo+2KHEjkCxw8rET/49yyv9A2X
	 6StrMePDo7tGsjS454dyCA/r4E4VimSXrkkQDphw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfHMV1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfHMV1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:27:53 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E57F20665;
        Tue, 13 Aug 2019 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731672;
        bh=JnDrtx/GuVJXE+K/6+7bGsOzbRZTo0uwMqXFtO03veI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TjxnzxQypKbYUc3VoT24ndSB0NUEq3OdCPnWH/WcRdNlbE8CSDvVztElNn3QMuBIO
         /YaMslZ4NwSjlMvBQ4kWRGX8P74H28X9zbRKOhfDOG4bQOFwxhd6r5KZp79jL8cv6V
         pH/HTTZycXXjnnyzj2C68WZ4fcUkvqGxdIFQvKDk=
Date:   Tue, 13 Aug 2019 14:27:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] mm: memcontrol: flush percpu vmstats before
 releasing memcg
Message-Id: <20190813142752.35807b6070db795674f86feb@linux-foundation.org>
In-Reply-To: <20190812222911.2364802-2-guro@fb.com>
References: <20190812222911.2364802-1-guro@fb.com>
        <20190812222911.2364802-2-guro@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 15:29:10 -0700 Roman Gushchin <guro@fb.com> wrote:

> Percpu caching of local vmstats with the conditional propagation
> by the cgroup tree leads to an accumulation of errors on non-leaf
> levels.
> 
> Let's imagine two nested memory cgroups A and A/B. Say, a process
> belonging to A/B allocates 100 pagecache pages on the CPU 0.
> The percpu cache will spill 3 times, so that 32*3=96 pages will be
> accounted to A/B and A atomic vmstat counters, 4 pages will remain
> in the percpu cache.
> 
> Imagine A/B is nearby memory.max, so that every following allocation
> triggers a direct reclaim on the local CPU. Say, each such attempt
> will free 16 pages on a new cpu. That means every percpu cache will
> have -16 pages, except the first one, which will have 4 - 16 = -12.
> A/B and A atomic counters will not be touched at all.
> 
> Now a user removes A/B. All percpu caches are freed and corresponding
> vmstat numbers are forgotten. A has 96 pages more than expected.
> 
> As memory cgroups are created and destroyed, errors do accumulate.
> Even 1-2 pages differences can accumulate into large numbers.
> 
> To fix this issue let's accumulate and propagate percpu vmstat
> values before releasing the memory cgroup. At this point these
> numbers are stable and cannot be changed.
> 
> Since on cpu hotplug we do flush percpu vmstats anyway, we can
> iterate only over online cpus.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")

Is this not serious enough for a cc:stable?
