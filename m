Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DB8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F9D218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGCJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfGCJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:17:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 465AAAF70;
        Wed,  3 Jul 2019 09:17:49 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:17:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
Message-ID: <20190703091747.GA13484@suse.de>
References: <20190624025604.30896-1-ying.huang@intel.com>
 <20190624140950.GF2947@suse.de>
 <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:23:22PM +0800, huang ying wrote:
> On Mon, Jun 24, 2019 at 10:25 PM Mel Gorman <mgorman@suse.de> wrote:
> >
> > On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
> > > The autonuma scan period should be increased (scanning is slowed down)
> > > if the majority of the page accesses are shared with other processes.
> > > But in current code, the scan period will be decreased (scanning is
> > > speeded up) in that situation.
> > >
> > > This patch fixes the code.  And this has been tested via tracing the
> > > scan period changing and /proc/vmstat numa_pte_updates counter when
> > > running a multi-threaded memory accessing program (most memory
> > > areas are accessed by multiple threads).
> > >
> >
> > The patch somewhat flips the logic on whether shared or private is
> > considered and it's not immediately obvious why that was required. That
> > aside, other than the impact on numa_pte_updates, what actual
> > performance difference was measured and on on what workloads?
> 
> The original scanning period updating logic doesn't match the original
> patch description and comments.  I think the original patch
> description and comments make more sense.  So I fix the code logic to
> make it match the original patch description and comments.
> 
> If my understanding to the original code logic and the original patch
> description and comments were correct, do you think the original patch
> description and comments are wrong so we need to fix the comments
> instead?  Or you think we should prove whether the original patch
> description and comments are correct?
> 

I'm about to get knocked offline so cannot answer properly. The code may
indeed be wrong and I have observed higher than expected NUMA scanning
behaviour than expected although not enough to cause problems. A comment
fix is fine but if you're changing the scanning behaviour, it should be
backed up with data justifying that the change both reduces the observed
scanning and that it has no adverse performance implications.

-- 
Mel Gorman
SUSE Labs
