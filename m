Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF721C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF8207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlwnS9y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKYAK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:10:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:43812 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfKYAK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:10:58 -0500
Received: by mail-pj1-f66.google.com with SMTP id a10so5629057pju.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 16:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1Kw/YJFY7FdkspqNzAdhItAYE6RHL+AQcC843r1nKzY=;
        b=IlwnS9y48HAZR4SRnDtCeYrAIHNe0/yaew5KZMyjhL/UwVCtP/fJ0soOR+gTq8IhQM
         kBkGu/yS2L31Yr2eZrc3+Tbx1yCOfUqWQ0LgyjvxgwGsOrGdquSSVVdunr/g9xdIoqCY
         CXioFkaVLVbap7H1iT4ZWdW66KEWakWqWhPWVgiKTrkmZcMilgnFpIc2UAYB0wFLep2e
         fj4gNqxmnfb7kmElqI9THnwf98AAvflBwEcBFhQeeOA3EsNtd9W9C6qpdm68tkkzx+iY
         HFbz4Y3gecqfkMhK31kI8G5EBUDVhTV9Ej43ZkI5uBG4Sn7c6MhghpU3uEJlZJavKJDZ
         K3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1Kw/YJFY7FdkspqNzAdhItAYE6RHL+AQcC843r1nKzY=;
        b=Td9o4Dp7EznaTLflP6OdANuxiJ2x0/hR0g1R8k4G+HRNQashjVJz5WlFTPl0jzkFgg
         7S+xD3cOeDkgYRglMBEZCLjqBbq4rBFsAE1vrFZ6XiR52JIyfohf43RN/FwX5s0qldW3
         Um6tGX+N/wQjhk/glo0gxtphinhGXWFv5/WrxmjZwsA4ZnD/XJD0TSGWQ7SaC1DbuUpC
         zG0pRATOJ/Nt77hK7qgAkexHnlDc/UkLqa8bp64Iyp1Y4oGi8Zk9bjY3V7wl36QauVCz
         1sGQFV/EIFlZVPqP5TPHTjd0/3c7R3IX4pkw0B4NAXagH73oXyDgXVQPpiXp6wig2bp8
         7u2w==
X-Gm-Message-State: APjAAAUB9NwRFy2LXw5kmPtMfebQDyuVY/OOfKgtFh3fUq6wVHte7Cfv
        8HZMwOpJijrTuGm9FHB1jeAgUk43MY0=
X-Google-Smtp-Source: APXvYqzEHie0SPQg/ED0itD56tfX5gTuCeBPP29nFrjxZtr5KsKROMGTtZaL6uH46Npi+dtZ7p8Bmg==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr26185343ple.320.1574640655648;
        Sun, 24 Nov 2019 16:10:55 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d11sm6059348pfq.72.2019.11.24.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 16:10:54 -0800 (PST)
Date:   Sun, 24 Nov 2019 16:10:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@suse.de>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191113112042.GG28938@suse.de>
Message-ID: <alpine.DEB.2.21.1911241548340.192260@chino.kir.corp.google.com>
References: <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz> <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com> <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz> <20191029151549.GO31513@dhcp22.suse.cz> <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
 <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com> <20191105130253.GO22672@dhcp22.suse.cz> <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com> <20191106073521.GC8314@dhcp22.suse.cz> <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com>
 <20191113112042.GG28938@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Mel Gorman wrote:

> > > The whole point of the Vlastimil's patch is to have an optimistic local
> > > node allocation first and the full gfp context one in the fallback path.
> > > If our full gfp context doesn't really work well then we can revisit
> > > that of course but that should happen at alloc_hugepage_direct_gfpmask
> > > level.
> > 
> > Since the patch reverts the precaution put into the page allocator to not 
> > attempt reclaim if the allocation order is significantly large and the 
> > return value from compaction specifies it is unlikely to succed on its 
> > own, I believe Vlastimil's patch will cause the same regression that 
> > Andrea saw is the whole host is low on memory and/or significantly 
> > fragmented.  So the suggestion was that he test this change to make sure 
> > we aren't introducing a regression for his workload.
> 
> TLDR: I do not have evidence that Vlastimil's patch causes more swapping
> 	but more information is needed from Andrea on exactly how he's
> 	testing this. It's not clear to me what was originally tested
> 	and whether memory just had to be full or whether it had to be
> 	fragmented. If fragmented, then we have to agree on what an
> 	appropriate mechanism is for fragmenting memory. Hypothetical
> 	kernel modules that don't exist do not count.
> 
> I put together a testcase whereby a virtual machine is deployed, started
> and then time how long it takes to run memhog on 80% of the guests
> physical memory. I varied how large the virtual machine is and ran it on
> a 2-socket machine so that the smaller tests would be single node and
> the larger tests would span both nodes. Before each startup, a large
> file is read to fill the memory with pagecache.
> 

First, thanks very much for the follow-up and considerable amount of time 
testing and benchmarking this.

I, like you, do not have a reliable test case that will reproduce the 
issue that Andrea initially reported over a year ago.  I believe in the 
discussion that repeatedly referred to swap storms that, with the 
__GFP_THISNODE policy, we were not thrashing because the local node was 
low on memory due to page cache.  How memory is filled with page cache 
will naturally effect how it can be reclaimed when compaction fails 
locally, I don't know if it's an accurate representation of the initial 
problem.  I also don't recall details about the swapfile or exactly where 
we were contending while trying to fault local hugepages.

My concern, and it's only a concern at this point and not a regression 
report because we don't have a result from Andrea, is that the result of 
this patch is that the second allocation in alloc_pages_vma() enables the 
exact same allocation policy that Andrea reported was a problem earlier if 
__GFP_DIRECT_RECLAIM is set, which it will be as a result of qemu's use of 
MADV_HUGEPAGE.

That reclaim and compaction is now done over the entire system and not 
isolated only to the local node so there are two plausible outcomes: (1) 
the remote note is not fragmented and we can easily fault a remote 
hugepage or (2) we thrash and cause swap storms remotely as well as 
locally.

(1) is the outcome that Andrea is seeking based on the initial reverts: 
that much we know.  So my concern is that if the *system* is fragmented 
that we have now introduced a much more significant swap storm that will 
result in a much more serious regression.

So my question would be: if we know the previous behavior that allowed 
excessive swap and recalling into compaction was deemed harmful for the 
local node, why do we now believe it cannot be harmful if done for all 
system memory?  The patch subverts the precaution put into place in the 
page allocator to specifically not do this excessive reclaim and recall 
into compaction dance and I believe restores the previous bad behavior if 
remote memory is similarly fragmented.  (What prevents this??)

Andrea was able to test this on several kernel versions with a fragmented 
local node so I *assume* it would not be difficult to measure the extent 
to which this patch can become harmful if all memory is fragmented.  I'm 
hoping that we can quantify that potentially negative impact before 
opening users up to the possibility.  As you said, it behaves better on 
some systems and workloads and worse on others and we both agree more 
information is needed.

I think asking Andrea to test and quantify the change with a fragmented 
system would help us to make a more informed decision and not add a 
potential regression to 5.5 or whichever kernel this would be merged in.
