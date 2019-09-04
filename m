Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01B422CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="D9ih9Cw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfIDO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:59:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41818 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbfIDO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:59:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so11390426pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rE1O7fdRvE37jnARAHsLuKHdyufLxZ8cmQ0gadZAgL8=;
        b=D9ih9Cw29Le6OiWtBd6aRyEWwpDTtYVafWcJb7+7LuDHHVOIIXPs+2zV1Ht8Ax++BC
         ia8+M2H3nQxG94rQvOCQVj16tbKYPYaFGu4HsuhvV78nwd2wFSOzc3c/yQNBbBvBA0Yd
         qsTZxSaf3QzMI1+NuWyOro0muhD4GtxAju2jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rE1O7fdRvE37jnARAHsLuKHdyufLxZ8cmQ0gadZAgL8=;
        b=Ftur+1+DdQcDPKF9nSKMl7qdr4M5wj7EC95/b9YE4hs+8FgPSqHsCQe49Ey+ylpJhi
         B6ex2t2ieSOvnCQLk/HYTCkK8DeGVo1VNjBuN26skqH8yjsXdyEmXGZ5/oZWB051zqA5
         Nh3ZcKbr2FYAUmIcED1kqzIvK+kUxFGgaFEmblS70F/iADOHwIEGiifnmJOLQRDg79LK
         iB90WEhdzSAfdgA0ggnuz7Wyyb4oDpk5nNxVW3fcKeOuS1tAeWKiofyZfLS9wqwIo6On
         eLItM8d13pAOzU/gI9mTQy9N7KnRmomma51ErggiziJ6t6vgTJvcyNBzLgskhsWZuNEW
         +bUA==
X-Gm-Message-State: APjAAAW9F5AS9Kzjajbw4cdPRMxSHS3twc4ZDakhnUXo9yfqW6LRQYxA
        9J31F+EyMAEE7QDBgFMKwmRT2Q==
X-Google-Smtp-Source: APXvYqxuEGPgataM5LlCHGmg8spcNNtos2YS2T0M6fjjvvs1uxXK1j1DXp8YMRz+T1Ekbu4SuHJDKg==
X-Received: by 2002:a17:90a:2e15:: with SMTP id q21mr5316128pjd.97.1567609182722;
        Wed, 04 Sep 2019 07:59:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e6sm643717pfl.146.2019.09.04.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:59:42 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:59:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190904145941.GF240514@google.com>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <CAJuCfpEXpYq2i3zNbJ3w+R+QXTuMyzwL6S9UpiGEDvTioKORhQ@mail.gmail.com>
 <CAKOZuesWV9yxbS9+T5+p1Ty1-=vFeYcHuO=6MgzTY8akMhbFbQ@mail.gmail.com>
 <20190904051549.GB256568@google.com>
 <CAKOZuet_M7nu5PYQj1iZErXV8hSZnjv4kMokVyumixVXibveoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuet_M7nu5PYQj1iZErXV8hSZnjv4kMokVyumixVXibveoQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:42:53PM -0700, Daniel Colascione wrote:
> On Tue, Sep 3, 2019 at 10:15 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Sep 03, 2019 at 09:51:20PM -0700, Daniel Colascione wrote:
> > > On Tue, Sep 3, 2019 at 9:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Tue, Sep 3, 2019 at 1:09 PM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > >
> > > > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > > > memory hogs. Several Android teams have been using this patch in various
> > > > > kernel trees for half a year now. Many reported to me it is really
> > > > > useful so I'm posting it upstream.
> > >
> > > It's also worth being able to turn off the per-task memory counter
> > > caching, otherwise you'll have two levels of batching before the
> > > counter gets updated, IIUC.
> >
> > I prefer to keep split RSS accounting turned on if it is available.
> 
> Why? AFAIK, nobody's produced numbers showing that split accounting
> has a real benefit.

I am not too sure. Have you checked the original patches that added this
stuff though? It seems to me the main win would be on big systems that have
to pay for atomic updates.

> > I think
> > discussing split RSS accounting is a bit out of scope of this patch as well.
> 
> It's in-scope, because with split RSS accounting, allocated memory can
> stay accumulated in task structs for an indefinite time without being
> flushed to the mm. As a result, if you take the stream of virtual
> memory management system calls that  program makes on one hand, and VM
> counter values on the other, the two don't add up. For various kinds
> of robustness (trace self-checking, say) it's important that various
> sources of data add up.
> 
> If we're adding a configuration knob that controls how often VM
> counters get reflected in system trace points, we should also have a
> knob to control delayed VM counter operations. The whole point is for
> users to be able to specify how precisely they want VM counter changes
> reported to analysis tools.

We're not adding more configuration knobs.

> > Any improvements on that front can be a follow-up.
> >
> > Curious, has split RSS accounting shown you any issue with this patch?
> 
> Split accounting has been a source of confusion for a while now: it
> causes that numbers-don't-add-up problem even when sampling from
> procfs instead of reading memory tracepoint data.

I think you can just disable split RSS accounting if it does not work well
for your configuration. It sounds like the problems you share are common all
with existing ways of getting RSS accounting working, and not this particular
one, hence I mentioned it is a bit of scope.

Also AFAIU, every TASK_RSS_EVENTS_THRESH the page fault code does sync the
counters. So it does not indefinitely lurk. The tracepoint's main intended
use is to detect spikes which provides ample opportunity to sync the cache.

You could reduce TASK_RSS_EVENTS_THRESH in your kernel, or even just disable
split RSS accounting if that suits you better. That would solve all the
issues you raised, not just any potential ones that you raised here for this
tracepoint.

thanks,

 - Joel


