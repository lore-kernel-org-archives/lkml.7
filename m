Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71322C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3954520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="IuGLqpYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDJVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:38:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37804 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:38:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so4653527wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOxvXqKFPj3MVMl61HzHsAJfIq2rKeT4Ruwa8q/szlk=;
        b=IuGLqpYW78+nQWkej9wKStxCq8RIIrHjSMDS6OyqdFFNNxekxJhF89osk20TuKhrEO
         MElGo2FWORrNdRRerXLqjoT6MJkaWwt2JRoVTuFYipzOQEPGknG5meN37wEVLWBVLpAF
         x5IlPyQE3C1AOSQ8B1VRa/tpNetbiGbUNZFEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOxvXqKFPj3MVMl61HzHsAJfIq2rKeT4Ruwa8q/szlk=;
        b=JD8rRVNk6MNXtSwqlD2tc12EKHnMi1aI1VKZJu/4pL8ASGPBRE2ppA81vnruKsFCo3
         gHiHk+NWexATdOBr+Bq70lrjoZCGF4kxAcqOqISy3B8JhJaLQWPFQTpx25jwfFIvo1Qp
         VWS7MilthZM3qHMtS4ir9GV9N/NGvpISxIfnhrr+LunszXj1cKaPg009V7snWqNMWQry
         EInjZMWEHbdOhjhpx6M3ZemibUJd/ZW43gpbs+V1OxCE0wfxL0jZ0j7F6y4tlAAYgpop
         1cqu3BTKFzvLwgAeZQPNBFzSVVJmi6cvtL5ddy2coIufScA/j+AV5M16JW199M47M00s
         +lew==
X-Gm-Message-State: APjAAAVzhxJd1kEtT0bNlqrHLKiDJGLz7J491pc2KveP334a6kBgdt2F
        EgOtplF+KFXydV7jP3AZUs5vEg==
X-Google-Smtp-Source: APXvYqzYK41wa+yBABjfRn4lLJk4EEpjyQYNII3AdqhtAf0gjYSQko7bu1DksvIQIi7STAbWZb8KZw==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr7852347wrm.277.1554932306536;
        Wed, 10 Apr 2019 14:38:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id j11sm49008948wrw.85.2019.04.10.14.38.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Apr 2019 14:38:25 -0700 (PDT)
Date:   Wed, 10 Apr 2019 22:38:24 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 0/2] mm/memcontrol: Finer-grained memory control
Message-ID: <20190410213824.GA13638@chrisdown.name>
References: <20190410191321.9527-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410191321.9527-1-longman@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Waiman Long writes:
>The current control mechanism for memory cgroup v2 lumps all the memory
>together irrespective of the type of memory objects. However, there
>are cases where users may have more concern about one type of memory
>usage than the others.

I have concerns about this implementation, and the overall idea in general. We 
had per-class memory limiting in the cgroup v1 API, and it ended up really 
poorly, and resulted in a situation where it's really hard to compose a usable 
system out of it any more.

A major part of the restructure in cgroup v2 has been to simplify things so 
that it's more easy to understand for service owners and sysadmins. This was 
intentional, because otherwise the system overall is hard to make into 
something that does what users *really* want, and users end up with a lot of 
confusion, misconfiguration, and generally an inability to produce a coherent 
system, because we've made things too hard to piece together.

In general, for purposes of resource control, I'm not convinced that it makes 
sense to limit only one kind of memory based on prior experience with v1. Can 
you give a production use case where this would be a clear benefit, traded off 
against the increase in complexity to the API?

>For simplicity, the limit is not hierarchical and applies to only tasks
>in the local memory cgroup.

We've made an explicit effort to make all things hierarchical -- this confuses 
things further. Even if we did have something like this, it would have to 
respect the hierarchy, we really don't want to return to the use_hierarchy 
days where users, sysadmins, and even ourselves are confused by the resource 
control semantics that are supposed to be achieved.

>We have customer request to limit memory consumption on anonymous memory
>only as they said the feature was available in other OSes like Solaris.

What's the production use case where this is demonstrably providing clear 
benefits in terms of resource control? How can it compose as part of an easy to 
understand, resource controlling system? I'd like to see a lot more information 
on why this is needed, and the usability and technical tradeoffs considered.

Thanks,

Chris
