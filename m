Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E91241C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCu9MPsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE2VIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:08:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43689 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE2VIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:08:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so597109pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JDuSTehyNdkjsOxtouLoAdMdAueINAK3K8uBz+p0jwg=;
        b=iCu9MPsyqSyo52dk3bz2YcMkQmNZYRBnUvKfoC/4nlsyxR2kImqL5WSQ/tyUgbQGS5
         tWRxoAuFxGICRlXINV3c2tZaoNnVTDCu3AQWUlvkm0C+fQdRbz4FGqR1DvMkNENEbQCo
         4mLnFfcmw7g7RiFYFM3uP/L9kskO6vNvXIOsYcoEhUccyXOhOgTv1ZIoqlt4GkhouIyt
         NoatEjQ0v842w1+LfUE6qcm/wVA+RI1gtWZSmg7y9eYS/xmE8gKbr0HdmnWyXfEA8pYA
         D2roDVoI+GkFybcqvS37aJdhvvXWEunPHYJZmGU1JBmPeR7muDxlo4h6jHkWn7gz9wTu
         D19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JDuSTehyNdkjsOxtouLoAdMdAueINAK3K8uBz+p0jwg=;
        b=PZINtSUWLZCN2hIEn4jKmOnae1IfUjduYoqJkE4jwwGNIjmW77xxUlH868LHKfo08Y
         YeSKIeX8QZsPBdRka0+noTtxHj8eG0Yw3kz9Wi3TPIAl5kMVKPou/XC2f+mmPn6+kD5K
         rSKi/oK1WxV4LCN32DpfauutXsgvJmIa1MA+5GM+FPNCrSHwsR+S3ZzFlhoG80CHVxM/
         DxZkfYFUdu3tiFV6OZb8toqcbPTG6SljiRpJ1sNr66mm4biaEypk6f0sBzR0qCVGjFe0
         5b4KhvdeK+o+1KpGTq/vE1sdQOxN9DIFvkZIhLUydIpLGZP4EtMVjyhlPGjwUG0B++k1
         S18Q==
X-Gm-Message-State: APjAAAUQRd3qahqXekKXz4wVfEIWu8CkeFvKFbIUx1y05R+xupqhLtF3
        jZvepmoUJWlUlERrccfSqqmXAQ==
X-Google-Smtp-Source: APXvYqz7P8HgjdZeBHIm1rggdqtNB5srYYVApd3MRmDP73Wpy18Y0LXtAZVWv+Kw+t04RSc4FWh44w==
X-Received: by 2002:a62:e303:: with SMTP id g3mr150555799pfh.220.1559164080811;
        Wed, 29 May 2019 14:08:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 25sm574143pfp.76.2019.05.29.14.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:07:58 -0700 (PDT)
Date:   Wed, 29 May 2019 14:07:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Make deferred split shrinker memcg aware
In-Reply-To: <2e23bd8c-6120-5a86-9e9e-ab43b02ce150@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1905291402360.242480@chino.kir.corp.google.com>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.DEB.2.21.1905281817090.86034@chino.kir.corp.google.com> <2e23bd8c-6120-5a86-9e9e-ab43b02ce150@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Yang Shi wrote:

> > Right, we've also encountered this.  I talked to Kirill about it a week or
> > so ago where the suggestion was to split all compound pages on the
> > deferred split queues under the presence of even memory pressure.
> > 
> > That breaks cgroup isolation and perhaps unfairly penalizes workloads that
> > are running attached to other memcg hierarchies that are not under
> > pressure because their compound pages are now split as a side effect.
> > There is a benefit to keeping these compound pages around while not under
> > memory pressure if all pages are subsequently mapped again.
> 
> Yes, I do agree. I tried other approaches too, it sounds making deferred split
> queue per memcg is the optimal one.
> 

The approach we went with were to track the actual counts of compound 
pages on the deferred split queue for each pgdat for each memcg and then 
invoke the shrinker for memcg reclaim and iterate those not charged to the 
hierarchy under reclaim.  That's suboptimal and was a stop gap measure 
under time pressure: it's refreshing to see the optimal method being 
pursued, thanks!

> > I'm curious if your internal applications team is also asking for
> > statistics on how much memory can be freed if the deferred split queues
> > can be shrunk?  We have applications that monitor their own memory usage
> 
> No, but this reminds me. The THPs on deferred split queue should be accounted
> into available memory too.
> 

Right, and we have also seen this for users of MADV_FREE that have both an 
increased rss and memcg usage that don't realize that the memory is freed 
under pressure.  I'm thinking that we need some kind of MemAvailable for 
memcg hierarchies to be the authoritative source of what can be reclaimed 
under pressure.

> > through memcg stats or usage and proactively try to reduce that usage when
> > it is growing too large.  The deferred split queues have significantly
> > increased both memcg usage and rss when they've upgraded kernels.
> > 
> > How are your applications monitoring how much memory from deferred split
> > queues can be freed on memory pressure?  Any thoughts on providing it as a
> > memcg stat?
> 
> I don't think they have such monitor. I saw rss_huge is abormal in memcg stat
> even after the application is killed by oom, so I realized the deferred split
> queue may play a role here.
> 

Exactly the same in my case :)  We were likely looking at the exact same 
issue at the same time.

> The memcg stat doesn't have counters for available memory as global vmstat. It
> may be better to have such statistics, or extending reclaimable "slab" to
> shrinkable/reclaimable "memory".
> 

Have you considered following how NR_ANON_MAPPED is tracked for each pgdat 
and using that as an indicator of when the modify a memcg stat to track 
the amount of memory on a compound page?  I think this would be necessary 
for userspace to know what their true memory usage is.
