Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF6FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD03206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GopTnzop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfIEUyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:54:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34725 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIEUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:54:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so1972543plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GXDxXxiCunZuVnnF1WXh8fyTBtwvohzNRCSob8YCkqs=;
        b=GopTnzopJhGc/1E7pEIdNYj2NEOXRitfg7q7knEqeyOrCB56oE1KvBY/akZgWAGqNp
         +CO2TqvOoZRa/Gm04jeqvL+0ls+id2lQ8ynq84VeoITKnEGjdukbHVvrERSVq6Q8youN
         HP/Q1oediJvamd6gH0laUTqRsW+VtIpg0+0J1KHkndTx5FfCjmBursJcsImruJMkxkkD
         t7RT1R8pfb6VuHVvRV+/5VbOm+sU7nqhws7PM2t+VfjZ5Y1wZH23dsAxmvnbxy068ENy
         f9QH9XDheQm3J7k+bVJjSGHWy8yjlW/E6xfPAYO56Gz1vhssx+LJuvkg9CtqyudaBDs4
         7LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GXDxXxiCunZuVnnF1WXh8fyTBtwvohzNRCSob8YCkqs=;
        b=ce3GHogg4645hcHA1/9Kc4Rx1BFOKPL3xTkaBmi2pnpaEcZf9ZSsHlpqMzlFkR3dJL
         TsoRuI1zTcen40PUdYh/c37sj+Q794Umjphw7LPFz6I9tf8CEhcyg8u3GHRXQ+fSIC6H
         EDioFS48pg/BpETrqTvycZfa8u8y/4qlKDYaGeSKeivgClio4G3o+crBm1vZBlt5o/YO
         UMGtSjoQPYiZCVqXkEDXlZK8xXbbaW1BO8+tLnjgxqZ9XGApGwo/EvWJqUczOWKAd0Hr
         Nkx5iLi0cgbV7D3FryoqFC+89nHQ2ZuIY2pL0o3aeiL1w/U433t+FdWqAiK6HNI4iT31
         xI7g==
X-Gm-Message-State: APjAAAWgr1bYg2BPUpWMOA9k6XrfJpj0VhHV4cPNR8GakM/U+hhqdb0z
        dboN6P+tFBTI9zq6Qhyfr0bqSg==
X-Google-Smtp-Source: APXvYqzAYeM22/fyHxCBOrtmbXM7+LXZbeoTfXSzse1HU/s8jOAo6MSqcBcOscaTohoVBfw5DzgyqQ==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr5794411plp.18.1567716885572;
        Thu, 05 Sep 2019 13:54:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v18sm3394315pfn.24.2019.09.05.13.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 13:54:44 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:54:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909051345030.217933@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Linus Torvalds wrote:

> > This series reverts those reverts and attempts to propose a more sane
> > default allocation strategy specifically for hugepages.  Andrea
> > acknowledges this is likely to fix the swap storms that he originally
> > reported that resulted in the patches that removed __GFP_THISNODE from
> > hugepage allocations.
> 
> There's no way we can try this for 5.3 even if looks ok. This is
> "let's try this during the 5.4 merge window" material, and see how it
> works.
> 
> But I'd love affected people to test this all on their loads and post
> numbers, so that we have actual numbers for this series when we do try
> to merge it.
> 

I'm certainly not proposing the last two patches in the series marked as 
RFC to be merged.  I'm proposing the first two patches in the series, 
reverts of the reverts that went into 5.3-rc5, are merged for 5.3 so that 
we return to the same behavior that we have had for years and semantics 
that MADV_HUGEPAGE has provided that entire libraries and userspaces have 
been based on.

It is very clear that there is a path forward here to address the *bug* 
that Andrea is reporting: it has become conflated with NUMA allocation 
policies which is not at all the issue.  Note that if 5.3 is released with 
these patches that it requires a very specialized usecase to benefit from: 
workloads that are larger than one socket and *requires* remote memory not 
being low on memory or fragmented.  If remote memory is as low on memory 
or fragmented as local memory (like in a datacenter), the reverts that 
went into 5.3 will double the impact of the very bug being reported 
because now it's causing swap storms for remote memory as well.  I don't 
anticipate we'll get numbers for that since it's not a configuration they 
run in.

The bug here is reclaim in the page allocator that does not benefit memory 
compaction because we are failing per-zone watermarks already.  The last 
two patches in these series avoid that, which is a sane default page 
allocation policy, and the allow fallback to remote memory only when we 
can't easily allocate locally.

We *need* the ability to allocate hugepages locally if compaction can 
work, anything else kills performance.  5.3-rc7 won't try that, it will 
simply fallback to remote memory.  We need to try compaction but we do not 
want to reclaim if failing watermark checks.

I hope that I'm not being unrealistically optimistic that we can make 
progress on providing a sane default allocation policy using those last 
two patches as a starter for 5.4, but I'm strongly suggesting that you 
take the first two patches to return us to the policy that has existed for 
years and not allow MADV_HUGEPAGE to be used for immediate remote 
allocation when local is possible.
