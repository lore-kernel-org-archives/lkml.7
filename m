Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C828C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D929D218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562238546;
	bh=g5ycTf7PkumM7Zijrp1lGqgFT6mSvlMA9pnh97KNkd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QYnOdNKxlMUvVs52wONkKk/rpN3U3yIrTRgcCeanMIqw+OW5PACgOFIh+DP4D8fEK
	 n/0t8g/oxDVPgoM+KrHy8Mm82qcrrS63vjOjCYHRyORLgBp1roAtjL9TpunLd3LtI0
	 VmW5bIPqOUX7LBuAozvEjdLtp3Y8u4j29JiV4nOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGDLJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:09:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfGDLJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B698AEAF;
        Thu,  4 Jul 2019 11:09:04 +0000 (UTC)
Date:   Thu, 4 Jul 2019 13:09:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190704110903.GE5620@dhcp22.suse.cz>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
 <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
 <20190701085920.GB2812@suse.de>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <20190703094325.GB2737@techsingularity.net>
 <571d5557-2153-59ea-334b-8636cc1a49c9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571d5557-2153-59ea-334b-8636cc1a49c9@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-07-19 16:54:35, Mike Kravetz wrote:
> On 7/3/19 2:43 AM, Mel Gorman wrote:
> > Indeed. I'm getting knocked offline shortly so I didn't give this the
> > time it deserves but it appears that part of this problem is
> > hugetlb-specific when one node is full and can enter into this continual
> > loop due to __GFP_RETRY_MAYFAIL requiring both nr_reclaimed and
> > nr_scanned to be zero.
> 
> Yes, I am not aware of any other large order allocations consistently made
> with __GFP_RETRY_MAYFAIL.  But, I did not look too closely.  Michal believes
> that hugetlb pages allocations should use __GFP_RETRY_MAYFAIL.

Yes. The argument is that this is controlable by an admin and failures
should be prevented as much as possible. I didn't get to understand
should_continue_reclaim part of the problem but I have a strong feeling
that __GFP_RETRY_MAYFAIL handling at that layer is not correct. What
happens if it is simply removed and we rely only on the retry mechanism
from the page allocator instead? Does the success rate is reduced
considerably?
-- 
Michal Hocko
SUSE Labs
