Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82275C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CCA2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAnOaztF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfKFBBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:01:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfKFBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:01:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so6801763pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 17:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Txbd1n3WXZhvsgvEStK+7JvEW+gNhvfRDKuQjrimagg=;
        b=bAnOaztFbWE11f3TZekaIQrRKnaPMyTRlYFpZE+okZwn+QrBbdHAKH2ETQBNvxGC8C
         fPGhjhNCmDQ57/Ahb0Ege84BGpJ1Fcy6wF89RbGKmxma+d8WXt9ToPgYWi6RQTPG3hZ/
         x4QmYNZYL169QiRIHBXisIegP2q0myfbur26HDTg+HciPsMXJl+7IcCgADTOooaMer42
         UJ2kOO4YjXQPWztZLpQlpExB2aMVycXlHoRVdui9RExKfSRcc7DkXsOi8MRMWv3ZE5OQ
         st3cSzg5JNOFEeMjtFYuRnxuy8CnPNUb1lW8tiYL2+wsbxF6qYOeftHzwQhPI5Z2Q2xL
         rNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Txbd1n3WXZhvsgvEStK+7JvEW+gNhvfRDKuQjrimagg=;
        b=jOHFbZ0PzD5SB735e5apb5WGsw5y+3GZ1NEPGFDVGbu7JpiFJnwxd3UiKNUZ2dSY6+
         Pb7VSfzdlBxRXyEaQ/qjUij9fNYqXFDRQL7ogGydgKTN8lUK7uqeuVqOtKq2jJGpxYHU
         Q6eXowD9190MZTSzMcwb9oQHK3+Bla4mx5y4H8kWuYf6XSwVbr5Pme58yaAHW/1SSmy+
         A2a7k+mqDvRHEj8dOCm+CYhtH0alYwYzRLF9CygM6F3QR4O56pQmerM8XewBbewVNvA0
         F6bMBhzhhYMcPHOwr5HcLyZr9VmqTGO+lFa3nsP7R6SD3y4EdMvj40qTWV6PYtv7mq9Z
         aDUw==
X-Gm-Message-State: APjAAAWmNDBgbg2tOX3cNfaNWWDdI3p4bZBfU3IJDwwviVh4nGAzFxEJ
        FFlCQ9SWxV83axyep5nDnDRHdw==
X-Google-Smtp-Source: APXvYqx9BUuMVoesQnq7M7zvoWtfFvSxkRRjqLW5cAtjA1k5ivCd6zrmcr9aY0mtelj+Oda/p8qjwA==
X-Received: by 2002:a62:5801:: with SMTP id m1mr42129991pfb.204.1573002062623;
        Tue, 05 Nov 2019 17:01:02 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z21sm19899398pfa.119.2019.11.05.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 17:01:01 -0800 (PST)
Date:   Tue, 5 Nov 2019 17:01:00 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191105130253.GO22672@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
References: <20190930112817.GC15942@dhcp22.suse.cz> <20191001054343.GA15624@dhcp22.suse.cz> <20191001083743.GC15624@dhcp22.suse.cz> <20191018141550.GS5017@dhcp22.suse.cz> <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz> <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
 <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz> <20191029151549.GO31513@dhcp22.suse.cz> <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org> <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com> <20191105130253.GO22672@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Michal Hocko wrote:

> > > Thanks, I'll queue this for some more testing.  At some point we should
> > > decide on a suitable set of Fixes: tags and a backporting strategy, if any?
> > > 
> > 
> > I'd strongly suggest that Andrea test this patch out on his workload on 
> > hosts where all nodes are low on memory because based on my understanding 
> > of his reported issue this would result in swap storms reemerging but 
> > worse this time because they wouldn't be constrained only locally.  (This 
> > patch causes us to no longer circumvent excessive reclaim when using 
> > MADV_HUGEPAGE.)
> 
> Could you be more specific on why this would be the case? My testing is
> doesn't show any such signs and I am effectivelly testing memory low
> situation. The amount of reclaimed memory matches the amount of
> requested memory.
> 

The follow-up allocation in alloc_pages_vma() would no longer use 
__GFP_NORETRY and there is no special handling to avoid swap storms in the 
page allocator anymore as a result of this patch.  I don't see any 
indication that this allocation would behave any different than the code 
that Andrea experienced swap storms with, but now worse if remote memory 
is in the same state local memory is when he's using __GFP_THISNODE.
