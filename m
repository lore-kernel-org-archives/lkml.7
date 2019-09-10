Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA75C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290921019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568100685;
	bh=6biTzo7iAZosJTEx3rHSrgAsJH7N9jOfN0l1QdidfjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zym57SKbJFEzKg1YQsxXc7zrOd4qVxGIaCXj81bkTn94Bu7vYEaTWSZfO3sPRnup9
	 U/LxQ2jzPfClVDpYEhZP4ZRkqGZgCw6OtueUvy9czpqvwJt79/vaJCR/MUVWJgD3R8
	 3YhEJn1HVw9R9O4htbxg7V169ier1T10NdudJhU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfIJHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:31:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfIJHbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:31:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53D38B011;
        Tue, 10 Sep 2019 07:31:22 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:31:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Chris Down <chris@chrisdown.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@01.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [LKP] [mm, memcg] 1e577f970f: will-it-scale.per_process_ops
 -7.2% regression
Message-ID: <20190910073120.GK2063@dhcp22.suse.cz>
References: <20190909021544.GP15734@shao2-debian>
 <20190909194652.GE2063@dhcp22.suse.cz>
 <87d0g8hbly.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0g8hbly.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 15:08:41, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Mon 09-09-19 10:15:44, kernel test robot wrote:
> >> Greeting,
> >> 
> >> FYI, we noticed a -7.2% regression of will-it-scale.per_process_ops due to commit:
> >
> > What is the memcg setup for this test?
> 
> Except enabling memcg in kernel config, we don't do any special
> setup for memcg for the test.

OK, this is really interesting because the local events introduced by
this commits do not apply to the root memcg. So this smells like another
case when a microbenchmark is sensitive on the memcg layout changes.
-- 
Michal Hocko
SUSE Labs
