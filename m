Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D12CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFFqOhQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ2XZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:25:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46184 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2XZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:25:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id f19so131685pgn.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=byXq8vI93vI2DRTlxFYZJY3Q4kRQbv+vRep7d7kZkRI=;
        b=GFFqOhQiZ21b6sQNZnEkotYH6Evw7iiXFNtAUkxCkPZioqhbKxZ2pWB1D4xqIilEx3
         Pa/Q6AVMaDIm/eqgU2BtZkeRTiyvlBIeU0lGayH9jCP4QjKuWfDGj5y0TpvHfmLwjJiW
         G3+6FNtJu1uAk6A6iooX/mgTM5ssejpPSe36n30n5GVwqLmJF7DNIcdbEsaUisCTMerw
         0FjAkecIn+bnA0WOUqfXLpKZ/cKIQwpXpNR/FRQxCFltDcKU+DZ0E/10ygIzb5sZDjsW
         ju5Tuj4O228+YmEW7udhxjMrSoy9jjfySeCF+cFFAElO84mxSSSb+0APK1wzRQOGDkpP
         emZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=byXq8vI93vI2DRTlxFYZJY3Q4kRQbv+vRep7d7kZkRI=;
        b=p3wF4kgN2Z99H7MI8P8BH+1llg3WySU25smHREZCPmdDol0SoZSiYGXvAhcRCeu9yR
         rtt4JWlV6iFLaAoyurj0q1jXo3BiW0CFAOuXTLzP55E9ylstntOf0ns6OuRye6stO4mL
         5cpsH2Re5C7pAVCMPcqjHh3AvPFHjoZl/8C7dSAfFHIp2FBTZjGwfZ6gEUhVLRxlNfaH
         Eu+v0EXnGD5Tt2NvcVqlhXgdJVvfV/raSTHPXLb6yY3ugMNvXu5NuqHzLRy7kyGmFQV/
         0+orwLkMxe9YR3vNAac0bTKU0u8/uwI5m0LO4v3kXQX/BwqRvMFOyFfsKfpVw5mCYduu
         XFrw==
X-Gm-Message-State: APjAAAVEkGKZ/cCblbl0s7QhPwICXcqkZRoLJLGbT0fKSTTYw2mYcsNE
        VH3VM21kr9s6foyfNR00idM/iQ==
X-Google-Smtp-Source: APXvYqzHXtxraQU0AMWCe0g1F04yfX6wEb0r8Whe9FFVSvnG68JJTH4YmxCo51lguwPxbuJxorGvMw==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr4451187pfi.73.1572391518821;
        Tue, 29 Oct 2019 16:25:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n62sm182096pjc.6.2019.10.29.16.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:25:17 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:25:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com> <20190927074803.GB26848@dhcp22.suse.cz> <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com> <20190930112817.GC15942@dhcp22.suse.cz> <20191001054343.GA15624@dhcp22.suse.cz>
 <20191001083743.GC15624@dhcp22.suse.cz> <20191018141550.GS5017@dhcp22.suse.cz> <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz> <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com> <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz> <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Andrew Morton wrote:

> On Tue, 29 Oct 2019 16:15:49 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > 
> > > 1. local node only THP allocation with no reclaim, just compaction.
> > > 2. for madvised VMA's or when synchronous compaction is enabled always - THP
> > >    allocation from any node with effort determined by global defrag setting
> > >    and VMA madvise
> > > 3. fallback to base pages on any node
> > > 
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > I've given this a try and here are the results of my previous testcase
> > (memory full of page cache).
> 
> Thanks, I'll queue this for some more testing.  At some point we should
> decide on a suitable set of Fixes: tags and a backporting strategy, if any?
> 

I'd strongly suggest that Andrea test this patch out on his workload on 
hosts where all nodes are low on memory because based on my understanding 
of his reported issue this would result in swap storms reemerging but 
worse this time because they wouldn't be constrained only locally.  (This 
patch causes us to no longer circumvent excessive reclaim when using 
MADV_HUGEPAGE.)
