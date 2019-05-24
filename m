Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B8C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13188217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558659461;
	bh=rxwFvkRmOQ3G9Zun+OPPOUtfAL4LSNfqUCTmRBsD3Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WsDHoCb5vbcrkClkRfzaIDMnHYnB8wBeUbNuX81ipDGiEeWPQx55cfYrjn9PQaMG4
	 Gig+llIXfsM9yp4APNTxDKNcW/lTXHttgb6ILPrVSz7oW5aEi4GmUo7ZePa1qhQ47c
	 GxgPWbh9L5K4sioJKdDWrUgcPsQwQLTs5Tm11uoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfEXA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbfEXA5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:57:39 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AB720862;
        Fri, 24 May 2019 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558659458;
        bh=rxwFvkRmOQ3G9Zun+OPPOUtfAL4LSNfqUCTmRBsD3Oo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vqbDdCyOo/WuyU6rByzMzqY0mLECbjGBEKjm0yfhJCvzkT18gZ4eXDMmUSAy4Mvmy
         d/1bVl3uabwBPZapVb5pB0twkbf8I6uCNMhK70bjUINQxrrUCtG2fnp3kHsFrRzuH9
         R/MjcQhzatl4pRWR1LiaSHTCkCiRrQqEr+hxLLKA=
Date:   Thu, 23 May 2019 17:57:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert
 "mm, thp: restore node-local hugepage allocations"
Message-Id: <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
References: <20190503223146.2312-1-aarcange@redhat.com>
        <20190503223146.2312-3-aarcange@redhat.com>
        <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
        <20190520153621.GL18914@techsingularity.net>
        <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 10:54:16 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> We are going in circles, *yes* there is a problem for potential swap 
> storms today because of the poor interaction between memory compaction and 
> directed reclaim but this is a result of a poor API that does not allow 
> userspace to specify that its workload really will span multiple sockets 
> so faulting remotely is the best course of action.  The fix is not to 
> cause regressions for others who have implemented a userspace stack that 
> is based on the past 3+ years of long standing behavior or for specialized 
> workloads where it is known that it spans multiple sockets so we want some 
> kind of different behavior.  We need to provide a clear and stable API to 
> define these terms for the page allocator that is independent of any 
> global setting of thp enabled, defrag, zone_reclaim_mode, etc.  It's 
> workload dependent.

um, who is going to do this work?

Implementing a new API doesn't help existing userspace which is hurting
from the problem which this patch addresses.

It does appear to me that this patch does more good than harm for the
totality of kernel users, so I'm inclined to push it through and to try
to talk Linus out of reverting it again.  

