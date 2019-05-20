Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC74C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAEE20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfETGhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:37:34 -0400
Received: from foss.arm.com ([217.140.101.70]:38168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETGhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:37:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571BA80D;
        Sun, 19 May 2019 23:37:33 -0700 (PDT)
Received: from [10.162.41.132] (p8cg001049571a15.blr.arm.com [10.162.41.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34EA53F575;
        Sun, 19 May 2019 23:37:28 -0700 (PDT)
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
Date:   Mon, 20 May 2019 12:07:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/20/2019 09:22 AM, Minchan Kim wrote:
> - Problem
> 
> Naturally, cached apps were dominant consumers of memory on the system.
> However, they were not significant consumers of swap even though they are
> good candidate for swap. Under investigation, swapping out only begins
> once the low zone watermark is hit and kswapd wakes up, but the overall
> allocation rate in the system might trip lmkd thresholds and cause a cached
> process to be killed(we measured performance swapping out vs. zapping the
> memory by killing a process. Unsurprisingly, zapping is 10x times faster
> even though we use zram which is much faster than real storage) so kill
> from lmkd will often satisfy the high zone watermark, resulting in very
> few pages actually being moved to swap.

Getting killed by lmkd which is triggered by custom system memory allocation
parameters and hence not being able to swap out is a problem ? But is not the
problem created by lmkd itself.

Or Is the objective here is reduce the number of processes which get killed by
lmkd by triggering swapping for the unused memory (user hinted) sooner so that
they dont get picked by lmkd. Under utilization for zram hardware is a concern
here as well ?

Swapping out memory into zram wont increase the latency for a hot start ? Or
is it because as it will prevent a fresh cold start which anyway will be slower
than a slow hot start. Just being curious.
