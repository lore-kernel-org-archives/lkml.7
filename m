Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3932C74A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717BF2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562829169;
	bh=lURm8nlYnx34Q0B3lWlzdEhexGY9yIUU3Zix5gcyGb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aZ5iPX7YQV6lpCSaU0mbYjyHKTs5VcXDqbMEhmTCcayAxXKS8J2t4eAzAUFZqPOlH
	 F4BEmxmanDMxStgrz3TRiF7BG0qZTb83eTv0pYdt6bl29LacY7kr0Q6WkR1crGd3RY
	 LEst58rUY7Bpgg9M5j66gyF2lVyyP2xJAGxFqWF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfGKHMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:12:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728118AbfGKHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1E01AD12;
        Thu, 11 Jul 2019 07:12:46 +0000 (UTC)
Date:   Thu, 11 Jul 2019 09:12:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190711071245.GB29483@dhcp22.suse.cz>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <885afb7b-f5be-590a-00c8-a24d2bc65f37@oracle.com>
 <20190710194403.GR29695@dhcp22.suse.cz>
 <9d6c8b74-3cf6-4b9e-d3cb-a7ef49f838c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6c8b74-3cf6-4b9e-d3cb-a7ef49f838c7@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-07-19 16:36:58, Mike Kravetz wrote:
> On 7/10/19 12:44 PM, Michal Hocko wrote:
> > On Wed 10-07-19 11:42:40, Mike Kravetz wrote:
> > [...]
> >> As Michal suggested, I'm going to do some testing to see what impact
> >> dropping the __GFP_RETRY_MAYFAIL flag for these huge page allocations
> >> will have on the number of pages allocated.
> > 
> > Just to clarify. I didn't mean to drop __GFP_RETRY_MAYFAIL from the
> > allocation request. I meant to drop the special casing of the flag in
> > should_continue_reclaim. I really have hard time to argue for this
> > special casing TBH. The flag is meant to retry harder but that shouldn't
> > be reduced to a single reclaim attempt because that alone doesn't really
> > help much with the high order allocation. It is more about compaction to
> > be retried harder.
> 
> Thanks Michal.  That is indeed what you suggested earlier.  I remembered
> incorrectly.  Sorry.
> 
> Removing the special casing for __GFP_RETRY_MAYFAIL in should_continue_reclaim
> implies that it will return false if nothing was reclaimed (nr_reclaimed == 0)
> in the previous pass.
> 
> When I make such a modification and test, I see long stalls as a result
> of should_compact_retry returning true too often.  On a system I am currently
> testing, should_compact_retry has returned true 36000000 times.  My guess
> is that this may stall forever.  Vlastmil previously asked about this behavior,
> so I am capturing the reason.  Like before [1], should_compact_retry is
> returning true mostly because compaction_withdrawn() returns COMPACT_DEFERRED.

This smells like a problem to me. But somebody more familiar with
compaction should comment.

> 
> Total 36000000
>       35437500	COMPACT_DEFERRED
>         562500  COMPACT_PARTIAL_SKIPPED
> 
> 
> [1] https://lkml.org/lkml/2019/6/5/643
> -- 
> Mike Kravetz

-- 
Michal Hocko
SUSE Labs
