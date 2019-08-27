Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB507C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="eJUxPH8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfH0QAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:00:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38915 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:00:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so21782993qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rH/1tTvlYkg15K2136KKkCg35YWO5qbCo6KQMWJH/dA=;
        b=eJUxPH8tUpDBeYhZKoy1hw88Tryl0kFC0GG9rM9jzV22IAdgol1wTRmxWg4HyfxiZy
         5e9PjEgIMpLuv4RuwBmLILrM5KITh8zt1KBeQsyv1B5J3rWcKzRXPib3rHSsKxe3TsZC
         VzBEUZBjsjw/qX33qi2GwcMNsdw55UJgk5Pzonzwvb3zUHqFkRwUjsXk2/qiWcPZgK6D
         iMutWNGahYD3AzRn4yy3s+QRx9ffWar/LVjPdPIpzwIw6MRdC9WlonArFrGJ3EVS7II+
         Cp/6bExywOnkSQa7rvwwTtT9nLJn3nfvwrWPWDdBApt50dONhmDfLC+OxSK8E0ACh5Su
         hqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rH/1tTvlYkg15K2136KKkCg35YWO5qbCo6KQMWJH/dA=;
        b=alp1hZ4Zf4g7EEbpgoLTcvJ8pUPGoJdTPheBHWn/HtKcEbhmM21tSyF+dckwz8Xiel
         xvO2aMQbl0USf2hMuDpSlFCbVRJ75NPt4GQArBuXcfjy3Xf8fCR/dwgFbhNrxGHeUdUB
         IDk/xuzNJguIRx2SmngSZZ0pGxmEmSwHHbK6FM99h+IleWJzt2mtrWk/nUIYSCQ/8Y6M
         h7Gk2KcgnXMpctkR8IyGsKPlzYRhX9JbNR/fujYZfzS9hBq9+2b/qFiBr8WrfmIpyyXN
         pNm++wpLm1AedtKIVjgnrpw8T/1IZLeAJcjg9b1Z4Ccu4Ne3bU2MDF8eauXc30Yr396E
         j8xQ==
X-Gm-Message-State: APjAAAV3pTVuyZ86OiEyFmU9ZS8mZQntwNQs1KsblbjqwcNM0TVSh6dh
        GmaEV7F30XcSW+wf0BjkQGWJBg==
X-Google-Smtp-Source: APXvYqw4XmVgosaFRnbyI5ViD/J6mQI+By7Nkk4W+/DmGJ4WHb2ZXey6VL5DjwigbWd69yP+VQKDiQ==
X-Received: by 2002:ac8:b8e:: with SMTP id h14mr23859599qti.177.1566921629148;
        Tue, 27 Aug 2019 09:00:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:3d13])
        by smtp.gmail.com with ESMTPSA id 20sm8153707qkg.59.2019.08.27.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:00:27 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:00:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: drop mark_page_access from the unmap path
Message-ID: <20190827160026.GA27686@cmpxchg.org>
References: <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
 <20190809124305.GQ18351@dhcp22.suse.cz>
 <20190809183424.GA22347@cmpxchg.org>
 <20190812080947.GA5117@dhcp22.suse.cz>
 <20190812150725.GA3684@cmpxchg.org>
 <20190813105143.GG17933@dhcp22.suse.cz>
 <20190826120630.GI7538@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826120630.GI7538@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 02:06:30PM +0200, Michal Hocko wrote:
> On Tue 13-08-19 12:51:43, Michal Hocko wrote:
> > On Mon 12-08-19 11:07:25, Johannes Weiner wrote:
> > > On Mon, Aug 12, 2019 at 10:09:47AM +0200, Michal Hocko wrote:
> [...]
> > > > > Maybe the refaults will be fine - but latency expectations around
> > > > > mapped page cache certainly are a lot higher than unmapped cache.
> > > > >
> > > > > So I'm a bit reluctant about this patch. If Minchan can be happy with
> > > > > the lock batching, I'd prefer that.
> > > > 
> > > > Yes, it seems that the regular lock drop&relock helps in Minchan's case
> > > > but this is a kind of change that might have other subtle side effects.
> > > > E.g. will-it-scale has noticed a regression [1], likely because the
> > > > critical section is shorter and the overal throughput of the operation
> > > > decreases. Now, the w-i-s is an artificial benchmark so I wouldn't lose
> > > > much sleep over it normally but we have already seen real regressions
> > > > when the locking pattern has changed in the past so I would by a bit
> > > > cautious.
> > > 
> > > I'm much more concerned about fundamentally changing the aging policy
> > > of mapped page cache then about the lock breaking scheme. With locking
> > > we worry about CPU effects; with aging we worry about additional IO.
> > 
> > But the later is observable and debuggable little bit easier IMHO.
> > People are quite used to watch for major faults from my experience
> > as that is an easy metric to compare.

Rootcausing additional (re)faults is really difficult. We're talking
about a slight trend change in caching behavior in a sea of millions
of pages. There could be so many factors causing this, and for most
you have to patch debugging stuff into the kernel to rule them out.

A CPU regression you can figure out with perf.

> > > > As I've said, this RFC is mostly to open a discussion. I would really
> > > > like to weigh the overhead of mark_page_accessed and potential scenario
> > > > when refaults would be visible in practice. I can imagine that a short
> > > > lived statically linked applications have higher chance of being the
> > > > only user unlike libraries which are often being mapped via several
> > > > ptes. But the main problem to evaluate this is that there are many other
> > > > external factors to trigger the worst case.
> > > 
> > > We can discuss the pros and cons, but ultimately we simply need to
> > > test it against real workloads to see if changing the promotion rules
> > > regresses the amount of paging we do in practice.
> > 
> > Agreed. Do you see other option than to try it out and revert if we see
> > regressions? We would get a workload description which would be helpful
> > for future regression testing when touching this area. We can start
> > slower and keep it in linux-next for a release cycle to catch any
> > fallouts early.
> > 
> > Thoughts?
> 
> ping...

Personally, I'm not convinced by this patch. I think it's a pretty
drastic change in aging heuristics just to address a CPU overhead
problem that has simpler, easier to verify, alternative solutions.

It WOULD be great to clarify and improve the aging model for mapped
cache, to make it a bit easier to reason about. But this patch does
not really get there either. Instead of taking a serious look at
mapped cache lifetime and usage scenarios, the changelog is more in
"let's see what breaks if we take out this screw here" territory.

So I'm afraid I don't think the patch & changelog in its current shape
should go upstream.
