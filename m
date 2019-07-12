Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24456C742B1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA442064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mSrNEGpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGLJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:42:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGLJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8/S1+jX16TzxOOIxU/bRAzwTmHAX9u5kySICahCztRc=; b=mSrNEGprNQlxAb5b94YQqMyPMz
        kO0qgKwAjdYbQbt4ZLUYljy7WNvo98DtdOjLMkwQcC+18PUw+zCus/8lHAlhzfenlvKk3/Z2vY4/9
        poGaxdm1lKQXL+ObIt2v7JWeRaLtiqVQcLZdQ1GMpReUW8AmwLtxny/yVm2355jnSfECJcJqkElr0
        efFJMK0rpeOmHiLR4LtJhRb00cGecEEyJHgZct4gLmv1Qhuko/MvaUi4iuh7hx96d+cEh7LTSKMrR
        vq7hEteI36agAuTFdorAWUAocaMJg+9QtIMY2HCGkgtIpARgexlahUx3JF76qIbmqIXKBArIUAa4D
        0F/wsyBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hls4F-0004Df-KT; Fri, 12 Jul 2019 09:42:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4236020120CB1; Fri, 12 Jul 2019 11:42:14 +0200 (CEST)
Date:   Fri, 12 Jul 2019 11:42:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
Message-ID: <20190712094214.GR3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 05:11:25PM +0800, 王贇 wrote:
> 
> 
> On 2019/7/12 下午3:58, Peter Zijlstra wrote:
> [snip]
> >>>
> >>> Then our task t1 should be accounted to B (as you do), but also to A and
> >>> R.
> >>
> >> I get the point but not quite sure about this...
> >>
> >> Not like pages there are no hierarchical limitation on locality, also tasks
> > 
> > You can use cpusets to affect that.
> 
> Could you please give more detail on this?

Documentation/cgroup-v1/cpusets.txt

Look for mems_allowed.
