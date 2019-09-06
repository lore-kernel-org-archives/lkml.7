Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D95C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA46C207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdQ+M7bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394441AbfIFUQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:16:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35501 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394415AbfIFUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:16:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so4145471pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XpjoT+t3VPIqNty6+N9T0d42yqs+CXC4vRtjt+q0q7o=;
        b=OdQ+M7bCR/Hs87PAgK5bi456+I3hom4IiTzR1sNybd715+6YInSNgJiLw0rRpHZPMi
         CjaBP3CTTZu9FeC5FWYDLiBUENvXKGWPkVYABWUL4nKCD6fZpf4BG+Iex6F9NdjHFQHj
         8+jMcuOvrvlRn4QQ6U0J+daib7Rrvq/aPr2svANxqeK0EG1D144YDT+sCm9505bEfM1e
         8OfKsXCnkc+BGope+zK89PVKVpHCO099vcN+1Yq+/bRfFe9g7aKQhcDXxCAMf1+TJUzN
         3mXVBcCYm0fGT8t1RitjWRrgQqLraI6TnC3ROOVlyJ/bqS6N1CBFd1oftwe9qSTYHNRM
         n7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XpjoT+t3VPIqNty6+N9T0d42yqs+CXC4vRtjt+q0q7o=;
        b=cnkSXMILXoZMNr7T737VAib3pcxFGqDzDmxckskHTLdGWSAfV48RSLFYGM7KD0T9/y
         KXOtKsBniijXbBD/YoXZ/hl2BUAKXNPAfFOjV7vCG0XXjHiuE4y3HOxzR98x22CKFgOo
         6ju82SL4kAuu9xmZqKq75dh/dJpPcXCb3lvQ+s7jVTA0nCk7REKAoZVJmlU0kd8yFjbl
         fGq/dOrKTETfsah7cOidtIBXkGOmRk4KMkzFmqNmSEhisXIid/I+rMiMtxVWrequremD
         C6nOWMNj2yJvdkYX9OAqJaxRov5tgtUxlZlcNAcU9LCTQLAWSmoWX8DF6lH5WKAh5O4F
         oacQ==
X-Gm-Message-State: APjAAAU1hGEMd7t2GtKCHsLdTTa53zm7lbKBzLM+pGuJuxvQeaXn0Eph
        +X4PLvGTN5SlIbKkLoAVrzwWFA==
X-Google-Smtp-Source: APXvYqy6kmrb6Rqhp74ZrCXwb0I57IQq3ixyKOJRHtKUsywDqn/BCFjE6trl3ESF6oEToJYzNCiNjw==
X-Received: by 2002:a63:c006:: with SMTP id h6mr9416225pgg.290.1567801010246;
        Fri, 06 Sep 2019 13:16:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 11sm5406332pgo.43.2019.09.06.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 13:16:49 -0700 (PDT)
Date:   Fri, 6 Sep 2019 13:16:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc 3/4] mm, page_alloc: avoid expensive reclaim when compaction
 may not succeed
In-Reply-To: <3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com>
Message-ID: <alpine.DEB.2.21.1909061314270.150656@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com> <20190905090009.GF3838@dhcp22.suse.cz> <fab91766-da33-d62f-59fb-c226e4790a91@suse.cz>
 <3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Mike Kravetz wrote:

> I don't have a specific test for this.  It is somewhat common for people
> to want to allocate "as many hugetlb pages as possible".  Therefore, they
> will try to allocate more pages than reasonable for their environment and
> take what they can get.  I 'tested' by simply creating some background
> activity and then seeing how many hugetlb pages could be allocated.  Of
> course, many tries over time in a loop.
> 
> This patch did not cause premature allocation failures in my limited testing.
> The number of pages which could be allocated with and without patch were
> pretty much the same.
> 
> Do note that I tested on top of Andrew's tree which contains this series:
> http://lkml.kernel.org/r/20190806014744.15446-1-mike.kravetz@oracle.com
> Patch 3 in that series causes allocations to fail sooner in the case of
> COMPACT_DEFERRED:
> http://lkml.kernel.org/r/20190806014744.15446-4-mike.kravetz@oracle.com
> 
> hugetlb allocations have the __GFP_RETRY_MAYFAIL flag set.  They are willing
> to retry and wait and callers are aware of this.  Even though my limited
> testing did not show regressions caused by this patch, I would prefer if the
> quick exit did not apply to __GFP_RETRY_MAYFAIL requests.

Good!  I think that is the ideal way of handling it: we can specify the 
preference to actually loop and retry (but still eventually fail) for 
hugetlb allocations specifically for this patch by testing for 
__GFP_RETRY_MAYFAIL.

I can add that to the formal proposal of patches 3 and 4 in this series 
assuming we get 5.3 settled by applying the reverts in patches 1 and 2 so 
that we don't cause various versions of Linux to have different default 
and madvise allocation policies wrt NUMA.
