Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FE3215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cs5bN0Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfJCTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:52:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46352 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:52:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id q24so1977212plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=At1JkwuXqZ3LFuZLMcGPn7BnqP6xgEOzm+oOPuoeZCw=;
        b=Cs5bN0Ms2J4H8eerWkKl+7VV4n6Drh5DalQ/YypF26lf038jPpPifIAM2oMFqh7kzu
         pfz26TAJbjuvoDyXxCizOyusCi+eM6NsntiQXXMvO1N6uLYyJg8HIWwMBz3elISvmfLV
         xwLook/rzaw2fF6V+6J1qDgniYYGc0ipVVzD+85wubnQDLtU5pyEE7Hvn7DO8gGIqjwn
         YSrqMS8kM5tNChmzwQCU3pekXwPB7CTlOKN/6kmVIJWGF7wZAXR4SqFEzQ7Xe7TPuMru
         Xiw/yv/+41TkWXP0k5Zo4ZlrnxqFroqTLoKxCXlJzy2OV1SqH/+PeEavAg6ClvWu+4Z9
         HgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=At1JkwuXqZ3LFuZLMcGPn7BnqP6xgEOzm+oOPuoeZCw=;
        b=Kth4+Ogoyqn4xrp2umE38XErXlGGn/f/5tHlOf+NJYzJhT646j+Fjt/i5lpAj4yd1G
         F6I7zOXIPyrUz5Evd54q5h+QkhJOxU8IOE+QjxQzZfBn0t+f0O6CUuPTDJ/QOxQnrUKn
         RtCrseUshJQyOQFxiA1TJe5W6aW9mKCc4dBTxKk9O7mmscpjg9n2ONaStGUyPCRY/tS/
         UllLlHY09L0vNu2+JdGDi9NW5byJImfmMaBsdlwkXeaw5z2NMcBCSJ4J31Sdsl2eY+Fz
         8DPgiFoIWyJOzOd+s8GIMv5VnxKsdJmeWDm2klUHUosGh9YAAWMC64dK/eRWeMySO3BI
         q+tg==
X-Gm-Message-State: APjAAAWZgeK1p1qKIjtQcWbsWjTepBF6aHhKxyfAuv9+S0bH/bQTob5E
        0MHXTJl5Q68nWvi/gtmRFL6YOw==
X-Google-Smtp-Source: APXvYqxWHU1cLDLEYvXF5ogNeQqdEl5RjrAy7PbpU/nMugHciefJV2xdXBvSWbbkOjkUnM8I8/cz+g==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr11269472plx.305.1570132355113;
        Thu, 03 Oct 2019 12:52:35 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d20sm6380430pfq.88.2019.10.03.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 12:52:34 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:52:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
In-Reply-To: <d7752ddf-ccdc-9ff4-ab9f-529c2cd7f041@suse.cz>
Message-ID: <alpine.DEB.2.21.1910031243050.88296@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com> <d7752ddf-ccdc-9ff4-ab9f-529c2cd7f041@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019, Vlastimil Babka wrote:

> I think the key differences between Mike's tests and Michal's is this part
> from Mike's mail linked above:
> 
> "I 'tested' by simply creating some background activity and then seeing
> how many hugetlb pages could be allocated. Of course, many tries over
> time in a loop."
> 
> - "some background activity" might be different than Michal's pre-filling
>   of the memory with (clean) page cache
> - "many tries over time in a loop" could mean that kswapd has time to 
>   reclaim and eventually the new condition for pageblock order will pass
>   every few retries, because there's enough memory for compaction and it
>   won't return COMPACT_SKIPPED
> 

I'll rely on Mike, the hugetlb maintainer, to assess the trade-off between 
the potential for encountering very expensive reclaim as Andrea did and 
the possibility of being able to allocate additional hugetlb pages at 
runtime if we did that expensive reclaim.

For parity with previous kernels it seems reasonable to ask that this 
remains unchanged since allocating large amounts of hugetlb pages has 
different latency expectations than during page fault.  This patch is 
available if he'd prefer to go that route.

On the other hand, userspace could achieve similar results if it were to 
use vm.drop_caches and explicitly triggered compaction through either 
procfs or sysfs before writing to vm.nr_hugepages, and that would be much 
faster because it would be done in one go.  Users who allocate through the 
kernel command line would obviously be unaffected.

Commit b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when 
compaction may not succeed") was written with the latter in mind.  Mike 
subsequently requested that hugetlb not be impacted at least provisionally 
until it could be further assessed.

I'd suggest that latter: let the user initiate expensive reclaim and/or 
compaction when tuning vm.nr_hugepages and leave no surprises for users 
using hugetlb overcommit, but I wouldn't argue against either approach, he 
knows the users and expectations of hugetlb far better than I do.
