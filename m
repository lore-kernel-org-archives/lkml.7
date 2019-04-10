Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D12082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="xJDIIxl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfDJPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:34:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34141 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbfDJPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:34:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so3540680wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=arxBGNSX0OUYGmyljwVEu7bbeV7OhkzO+FdllTWnzPo=;
        b=xJDIIxl1eeL/dAIbEYlOuZSAFwejku7gsZgBW1BS1TBrC2f9JSBLITDJqVqs0PSeI4
         maDchJybAJdG0zBjinmp9wRxhX9DKa0H/MmG6XAo+vD62eSzMbE6SshIV9gtBlg76KPQ
         89iiOrmmBwbKuVrud8G0hORSsuQSWFNviuPfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arxBGNSX0OUYGmyljwVEu7bbeV7OhkzO+FdllTWnzPo=;
        b=Vs68rs/HbDsAitkeysw9lTORgRzrKinuMltAFLV0ypZm2kN3+QCt6gWpYtzA+G9Gbn
         QgwDTYUvjefwe/FmVG3g4NUK6yATFulXe9kka7H2uVuoQ53obT/mvxQm8gQD+1R9ZpjZ
         GEldK7nqFHnJLlHSBjIB/uQJTGY7QaTbnoIFNAHySUYsqooYwGqYD8Hr/LUZk7hhSWp+
         eeBPPWZhHhg2aD1+YPcqxfTqwE8ZlnqXq1WqmJaP9qf6el4goIC28a8tRCC3iYlOGdys
         Gfo9hRaPXByfOxmVvbhnott+Ciy9TZ5yDllpwYb44cJeOaHnDfuON3X/VqnwUwcjR46b
         Sadw==
X-Gm-Message-State: APjAAAXgqIaG1Bq8HzzOK2zo8rYOUAUxTbnnZbiVQtmZdaiv4z8sEwqT
        Rncepo8aHvx7SFJt7vnCHxdLOg==
X-Google-Smtp-Source: APXvYqwZJTtXFr6jhEhKPNCvW4MV9AmarGhvGr6jmEIy7i40TneIr27Iec90v8rr29B2QsQpsb/+5g==
X-Received: by 2002:adf:f050:: with SMTP id t16mr23381660wro.198.1554910490281;
        Wed, 10 Apr 2019 08:34:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:200::1:4ff4])
        by smtp.gmail.com with ESMTPSA id 7sm122837004wrc.81.2019.04.10.08.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 08:34:49 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:34:49 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH REBASED] mm: Throttle allocators when failing reclaim
 over memory.high
Message-ID: <20190410153449.GA14915@chrisdown.name>
References: <20190201191636.GA17391@chrisdown.name>
 <20190410153307.GA11122@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410153307.GA11122@chrisdown.name>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Michal,

Just to come back to your last e-mail about how this interacts with OOM.

Michal Hocko writes:
> I am not really opposed to the throttling in the absence of a reclaimable
> memory. We do that for the regular allocation paths already
> (should_reclaim_retry). A swapless system with anon memory is very likely to
> oom too quickly and this sounds like a real problem. But I do not think that
> we should throttle the allocation to freeze it completely. We should
> eventually OOM. And that was my question about essentially. How much we
> can/should throttle to give a high limit events consumer enough time to
> intervene. I am sorry to still not have time to study the patch more closely
> but this should be explained in the changelog. Are we talking about
> seconds/minutes or simply freeze each allocator to death?

Per-allocation, the maximum is 2 seconds (MEMCG_MAX_HIGH_DELAY_JIFFIES), so we 
don't freeze things to death -- they can recover if they are amenable to it.  
The idea here is that primarily you handle it, just like memory.oom_control in 
v1 (as mentioned in the commit message, or as a last resort, the kernel will 
still OOM if our userspace daemon has kicked the bucket or is otherwise 
ineffective.

If you're setting memory.high and memory.max together, then setting memory.high 
always has to come with a.) tolerance of heavy throttling by your application, 
and b.) userspace intervention in the case of high memory pressure resulting. 
This patch doesn't really change those semantics.
