Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D9DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4C20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565089874;
	bh=TMm6oqmx5PpUGjqqMqLwT0Tqw0Nq4KsVh/fjsfwMlJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WOW0B1pQM7QO/RQMYMhQfJuyhapslk+O4QNa9sGotJgnPI5BRK+iX5yRYtepmbucG
	 aTUjkSYeSwV772kCGaVQCmwNtsWNiQwnnqft0TojrxbYnvgnQ0Ic8mg7GaOw7/3JMY
	 R5A37q4iZW8doL10UBbsJCmmztmym0/S/71EffIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfHFLLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFLLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:11:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB69CB629;
        Tue,  6 Aug 2019 11:11:11 +0000 (UTC)
Date:   Tue, 6 Aug 2019 13:11:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>, lkp@01.org
Subject: Re: [mm]  755d6edc1a:  will-it-scale.per_process_ops -4.1% regression
Message-ID: <20190806111109.GV11812@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190806070547.GA10123@xsang-OptiPlex-9020>
 <20190806080415.GG11812@dhcp22.suse.cz>
 <20190806110024.GA32615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806110024.GA32615@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 20:00:24, Minchan Kim wrote:
> On Tue, Aug 06, 2019 at 10:04:15AM +0200, Michal Hocko wrote:
> > On Tue 06-08-19 15:05:47, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -4.1% regression of will-it-scale.per_process_ops due to commit:
> > 
> > I have to confess I cannot make much sense from numbers because they
> > seem to be too volatile and the main contributor doesn't stand up for
> > me. Anyway, regressions on microbenchmarks like this are not all that
> > surprising when a locking is slightly changed and the critical section
> > made shorter. I have seen that in the past already.
> 
> I guess if it's multi process workload. The patch will give more chance
> to be scheduled out so TLB miss ratio would be bigger than old.
> I see it's natural trade-off for latency vs. performance so only thing
> I could think is just increase threshold from 32 to 64 or 128?

This still feels like a magic number tunning, doesn't it?

-- 
Michal Hocko
SUSE Labs
