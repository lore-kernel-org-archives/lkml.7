Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3437520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565088714;
	bh=kmKIvIJkyBaPZsGIyMclmezcj1Lv6hfOU6Sr/4MtWew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=td3HK/PRw6mhPW1ehi8PuT0yNX80JmI8HubowkoUMs3Jla4vCVcd8G2tEsb37nsd4
	 krlC5SbBoP8USMwlzmzgqq/HEUPPslOCb134PFrVFh+m3LHzSTDIU9c9ctUO06Tqkm
	 eFC+FRfx1IOLRbUmrjtNxOqDJeq4MOSmkQmC6OsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfHFKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:51:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF4EBAFCC;
        Tue,  6 Aug 2019 10:51:50 +0000 (UTC)
Date:   Tue, 6 Aug 2019 12:51:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 4/5] page_idle: Drain all LRU pagevec before idle
 tracking
Message-ID: <20190806105149.GT11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-4-joel@joelfernandes.org>
 <20190806084357.GK11812@dhcp22.suse.cz>
 <20190806104554.GB218260@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806104554.GB218260@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 06:45:54, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 10:43:57AM +0200, Michal Hocko wrote:
> > On Mon 05-08-19 13:04:50, Joel Fernandes (Google) wrote:
> > > During idle tracking, we see that sometimes faulted anon pages are in
> > > pagevec but are not drained to LRU. Idle tracking considers pages only
> > > on LRU. Drain all CPU's LRU before starting idle tracking.
> > 
> > Please expand on why does this matter enough to introduce a potentially
> > expensinve draining which has to schedule a work on each CPU and wait
> > for them to finish.
> 
> Sure, I can expand. I am able to find multiple issues involving this. One
> issue looks like idle tracking is completely broken. It shows up in my
> testing as if a page that is marked as idle is always "accessed" -- because
> it was never marked as idle (due to not draining of pagevec).
> 
> The other issue shows up as a failure in my "swap test", with the following
> sequence:
> 1. Allocate some pages
> 2. Write to them
> 3. Mark them as idle                                    <--- fails
> 4. Introduce some memory pressure to induce swapping.
> 5. Check the swap bit I introduced in this series.      <--- fails to set idle
>                                                              bit in swap PTE.
> 
> Draining the pagevec in advance fixes both of these issues.

This belongs to the changelog.

> This operation even if expensive is only done once during the access of the
> page_idle file. Did you have a better fix in mind?

Can we set the idle bit also for non-lru pages as long as they are
reachable via pte?
-- 
Michal Hocko
SUSE Labs
