Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F9C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CD82063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfHMJlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:41:02 -0400
Received: from foss.arm.com ([217.140.110.172]:60934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfHMJlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B882D1570;
        Tue, 13 Aug 2019 02:41:01 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39863F706;
        Tue, 13 Aug 2019 02:41:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:40:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 0/3] mm: kmemleak: Use a memory pool for kmemleak
 object allocations
Message-ID: <20190813094058.GG62772@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812140730.71dd7f35d568b4d8530f8908@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812140730.71dd7f35d568b4d8530f8908@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:07:30PM -0700, Andrew Morton wrote:
> On Mon, 12 Aug 2019 17:06:39 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Following the discussions on v2 of this patch(set) [1], this series
> > takes slightly different approach:
> > 
> > - it implements its own simple memory pool that does not rely on the
> >   slab allocator
> > 
> > - drops the early log buffer logic entirely since it can now allocate
> >   metadata from the memory pool directly before kmemleak is fully
> >   initialised
> > 
> > - CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE option is renamed to
> >   CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE
> > 
> > - moves the kmemleak_init() call earlier (mm_init())
> > 
> > - to avoid a separate memory pool for struct scan_area, it makes the
> >   tool robust when such allocations fail as scan areas are rather an
> >   optimisation
> > 
> > [1] http://lkml.kernel.org/r/20190727132334.9184-1-catalin.marinas@arm.com
> 
> Using the term "memory pool" is a little unfortunate, but better than
> using "mempool"!

I agree, it could have been more inspired. What about "metadata pool"
(together with function name updates etc.)? Happy to send a v4.

> The changelog doesn't answer the very first question: why not use
> mempools.  Please send along a paragraph which explains this decision.

I posted one in reply to the patch where the changelog should be
updated.

Thanks.

-- 
Catalin
