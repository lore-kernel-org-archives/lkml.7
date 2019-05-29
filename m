Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966F24204
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVDIB2aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfE2VYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:24:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE2VYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:24:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so1596514plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/VjnBzka0ntx7tOJYYS02mgCPrG/ZdRlbuD+pRSLDes=;
        b=wVDIB2ajNcHg7hsPFzPNMH3O9KEy1WDcsjQKtoka4U2ZBN1vZ7D+qKxIibQrm38LYC
         Nrdwur3uPpDLwjQ4TnC1AV859Jt1/RP1YMONTS+JgDUk3vIVq+D1t9daEwQF1yAa/OBM
         I107FaouZn5cM26PVMcp6ROnM63unZjjgW6iZCihgLfgxHj3wQMN159WDsbad4Zd4AtL
         yYJ+3l7wbh+b1pmR5gpoJ1aJMSFW2TAby0fYs8G+P6By6Qz34969Jz6sRtm2i3F0KHLa
         m/ZpLlBuMgH5A8ottpc7PubUz1+V7uIL40yY7L+G5EpeFquPpFxl9a0B3pN8+4gIYiV3
         ph0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/VjnBzka0ntx7tOJYYS02mgCPrG/ZdRlbuD+pRSLDes=;
        b=DJLA60daJGCcFy0rXAl1714VZyPU8ZWnMbYcMSz/e2pkN6fitETKYbtKpVp9ATKIyI
         nve+gExukWJ4jioZKweuBfBGnI6cruMXq8YPeSbj5cEgOgGnx6ZF62oYXCvu3rCLJRQ6
         EUxkfnI28EWrP69A2tO49r3B+Br0zPHmJoGK8ldO2J5QoALCukrr68nhAZw02mipFduM
         RzXEgRK9J00i/nUY8Ms7pom6S/bv/vItGVfVQUVcWLDVPrBN/hvyauoOSwfwCPYaTOjZ
         YZk9iFBzoLDo5KqV3X53aTS+yT9nzdm8+OUw8/yU7gYrC5WHjbp6gMlrUu5VnSvksXYI
         A+cA==
X-Gm-Message-State: APjAAAV+kbe+ATBBQ8WHpqAYl3NubyRRqhE0mahfm+tZ/tWQitOqcXXi
        /5K5cfStczljw+b2GMGOiW2zYg==
X-Google-Smtp-Source: APXvYqw5AnaaWWqmrWqXULzKKuTxZx2r0lmDn7r1dm5gO3QKz0czvs4AxpYS2G/AGO46AAVsVkcBwA==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr25680plb.150.1559165075643;
        Wed, 29 May 2019 14:24:35 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m7sm613626pff.44.2019.05.29.14.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:24:34 -0700 (PDT)
Date:   Wed, 29 May 2019 14:24:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
In-Reply-To: <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com>
References: <20190503223146.2312-1-aarcange@redhat.com> <20190503223146.2312-3-aarcange@redhat.com> <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com> <20190520153621.GL18914@techsingularity.net> <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Andrew Morton wrote:

> > We are going in circles, *yes* there is a problem for potential swap 
> > storms today because of the poor interaction between memory compaction and 
> > directed reclaim but this is a result of a poor API that does not allow 
> > userspace to specify that its workload really will span multiple sockets 
> > so faulting remotely is the best course of action.  The fix is not to 
> > cause regressions for others who have implemented a userspace stack that 
> > is based on the past 3+ years of long standing behavior or for specialized 
> > workloads where it is known that it spans multiple sockets so we want some 
> > kind of different behavior.  We need to provide a clear and stable API to 
> > define these terms for the page allocator that is independent of any 
> > global setting of thp enabled, defrag, zone_reclaim_mode, etc.  It's 
> > workload dependent.
> 
> um, who is going to do this work?
> 
> Implementing a new API doesn't help existing userspace which is hurting
> from the problem which this patch addresses.
> 

The problem which this patch addresses has apparently gone unreported for 
4+ years since

commit 077fcf116c8c2bd7ee9487b645aa3b50368db7e1
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Feb 11 15:27:12 2015 -0800

    mm/thp: allocate transparent hugepages on local node

My goal is to reach a solution that does not cause anybody to incur 
performance penalties as a result of it.  It's surprising that such a 
severe swap storm issue that went unnoticed for four years is something 
that can't reach an amicable solution that doesn't cause other users to 
regress.

> It does appear to me that this patch does more good than harm for the
> totality of kernel users, so I'm inclined to push it through and to try
> to talk Linus out of reverting it again.  
> 

(1) The totality of kernel users are not running workloads that span 
multiple sockets, it's the minority, (2) it's changing 4+ year behavior 
based on NUMA locality of hugepage allocations and provides no workarounds 
for users who incur regressions as a result, and (3) does not solve the 
underlying issue if remote memory is also fragmented or low on memory: it 
actually makes the problem worse.

The easiest solution would be to define the MADV_HUGEPAGE behavior 
explicitly in sysfs: local or remote.  Defaut to local as the behavior 
from the past four years and allow users to specify remote if their 
workloads will span multiple sockets.  This is somewhat coarse but no more 
than the thp defrag setting in sysfs today that defines defrag behavior 
for everybody on the system.
