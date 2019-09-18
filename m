Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88C2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568810025;
	bh=jAwRnHRw84b6xgaW2kdqv+OKCsn2ZTwh5vS2IBzvaps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1+0coprf4ruYQTTFdydLOcI0IVLzicCRE97qdey1J5zGWygJvzFBMd+EMCb8QvrR3
	 UXZnS3ZEA2V0eBfbDjO0r3Ms3N+6TJjHylNDM16vfaV7OvrOPgfN5F3T1sZa2zqAWU
	 7JUO4yZdqdrut8qrcwh9bHhoqwWDfnAmMcQEiXmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfIRMdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfIRMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E333AD4E;
        Wed, 18 Sep 2019 12:33:43 +0000 (UTC)
Date:   Wed, 18 Sep 2019 14:33:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lin Feng <linf@wangsu.com>, corbet@lwn.net, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, keescook@chromium.org,
        mchehab+samsung@kernel.org, mgorman@techsingularity.net,
        vbabka@suse.cz, ktkhai@virtuozzo.com, hannes@cmpxchg.org
Subject: Re: [PATCH] [RFC] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190918123342.GF12770@dhcp22.suse.cz>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917120646.GT29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 05:06:46, Matthew Wilcox wrote:
> On Tue, Sep 17, 2019 at 07:58:24PM +0800, Lin Feng wrote:
[...]
> > +mm_reclaim_congestion_wait_jiffies
> > +==========
> > +
> > +This control is used to define how long kernel will wait/sleep while
> > +system memory is under pressure and memroy reclaim is relatively active.
> > +Lower values will decrease the kernel wait/sleep time.
> > +
> > +It's suggested to lower this value on high-end box that system is under memory
> > +pressure but with low storage IO utils and high CPU iowait, which could also
> > +potentially decrease user application response time in this case.
> > +
> > +Keep this control as it were if your box are not above case.
> > +
> > +The default value is HZ/10, which is of equal value to 100ms independ of how
> > +many HZ is defined.
> 
> Adding a new tunable is not the right solution.  The right way is
> to make Linux auto-tune itself to avoid the problem.

I absolutely agree here. From you changelog it is also not clear what is
the underlying problem. Both congestion_wait and wait_iff_congested
should wake up early if the congestion is handled. Is this not the case?
Why? Are you sure a shorter timeout is not just going to cause problems
elsewhere. These sleeps are used to throttle the reclaim. I do agree
there is no great deal of design behind them so they are more of "let's
hope it works" kinda thing but making their timeout configurable just
doesn't solve this at all. You are effectively exporting a very subtle
implementation detail into the userspace.
-- 
Michal Hocko
SUSE Labs
