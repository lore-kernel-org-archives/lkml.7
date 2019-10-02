Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985820842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3R9DrEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJBWcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:32:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46135 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBWcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:32:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so370741pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=buTOR+XuYU0MIPghMQDv8KGs3GslQzTxyG//kOyO5yE=;
        b=V3R9DrEKTJiR+lD35Y+rqV+QFb9EnkXNafeQ/JsMTj53qD88WbKVhjlr19oqi1kguz
         CFHg5WLfrNgP9BviO23742wbWke64BAuKg6P/N43mhHMWx97oTuu0GnChsYqRVrfYIpK
         +yAkxIMs7bX3M6/9X3xIxMBjY3kKdwOBvDKOc6aRG6gEnfBDHj33Fnf69js2MqrGmrXI
         1SC8VPTq5gqRN3O4YI6aLoSHRy+/e766UipxxutuWfOH9rGwOnl7Kc3Czj4dk1bZXqBC
         XEuOHMKReEOGGCLGECHNChlzTurPZubY4TuSqAjZgjh2K/QgA6R1aQKNw8uidxi5K5KP
         kDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=buTOR+XuYU0MIPghMQDv8KGs3GslQzTxyG//kOyO5yE=;
        b=dU7ylEBP03mNekC3siCuLS5cCIYwWC7EJUYK1kFLcnohjb/8dB1x7L9v7/llgeRLdl
         hdWPxAyzh3H89xakBH+na0WysXtXVlGnkXF6XM5dkdABIpDmp4xWpqiBMPL3P6Yhr4/S
         I4U++dALt+lvWVglp9I0ByTnCR+Ei0VXoyNvzvVw8F4WOG0j76MOUwSVihSp7ceVfuoN
         0SGmQdKzH85WNTcSpdXk+/VpI4Sra1Hysfq43Xst0r2U+5NjmSeNQ/zLxuMnOLuqzLpu
         8o7he3rmqPS0Fn0U5XS/ZyG14L2GP9JCPFzX8zBvGYE70Wxl8yrfiFp+E6iNghRjwXsN
         a58g==
X-Gm-Message-State: APjAAAWf1vDkYtVuyZrzYfCEIxNCqo5YmFjI8f0pTeWLeCV1qbwkLr4w
        we4cHjeszdsrPTJ+vqzH41ZDyQ==
X-Google-Smtp-Source: APXvYqxx0jbEdMhHvJEauSMn7JFmLYEUfpe0GzCgMisdINsQjK1KW6yyPBnZmZtb3hMMgZP2KUZ0+Q==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr7457819pfa.237.1570055541573;
        Wed, 02 Oct 2019 15:32:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u3sm443014pfn.134.2019.10.02.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 15:32:20 -0700 (PDT)
Date:   Wed, 2 Oct 2019 15:32:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191002103422.GJ15624@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1910021525180.63052@chino.kir.corp.google.com>
References: <20190909193020.GD2063@dhcp22.suse.cz> <20190925070817.GH23050@dhcp22.suse.cz> <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com> <20190927074803.GB26848@dhcp22.suse.cz> <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz> <20191001054343.GA15624@dhcp22.suse.cz> <fac13297-424f-33b0-e01d-d72b949a73fe@suse.cz> <alpine.DEB.2.21.1910011318050.38265@chino.kir.corp.google.com> <a5abc877-26de-ed3c-eb33-71474301c852@suse.cz>
 <20191002103422.GJ15624@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019, Michal Hocko wrote:

> > > If 
> > > hugetlb wants to stress this to the fullest extent possible, it already 
> > > appropriately uses __GFP_RETRY_MAYFAIL.
> > 
> > Which doesn't work anymore right now, and should again after this patch.
> 
> I didn't get to fully digest the patch Vlastimil is proposing. (Ab)using
> __GFP_NORETRY is quite subtle but it is already in place with some
> explanation and a reference to THPs. So while I am not really happy it
> is at least something you can reason about.
> 

It's a no-op:

        /* Do not loop if specifically requested */
        if (gfp_mask & __GFP_NORETRY)
                goto nopage;

        /*
         * Do not retry costly high order allocations unless they are
         * __GFP_RETRY_MAYFAIL
         */
        if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
                goto nopage;

So I'm not sure we should spend too much time discussing a hunk of a patch 
that doesn't do anything.

> b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction
> may not succeed") on the other hand has added a much more wider change
> which has clearly broken hugetlb and any __GFP_RETRY_MAYFAIL user of
> pageblock_order sized allocations. And that is much worse and something
> I was pointing at during the review and those concerns were never really
> addressed before merging.
> 
> In any case this is something to be fixed ASAP. Do you have any better
> proposa? I do not assume you would be proposing yet another revert.

I thought Mike Kravetz said[*] that hugetlb was not negatively affected by 
this?  We could certainly disregard this logic for __GFP_RETRY_MAYFAIL if 
anybody is relying on excessive reclaim ("swap storms") that does not 
allow compaction to make forward progress for some reason.

 [*] https://marc.info/?l=linux-kernel&m=156771690024533

If not, for the purposes of this conversation we can disregard 
__GFP_NORETRY per the above because thp does not use __GFP_RETRY_MAYFAIL.
