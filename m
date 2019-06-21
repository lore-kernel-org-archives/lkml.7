Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F8C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2C9208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkN/qi8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFUVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:16:45 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44667 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:16:44 -0400
Received: by mail-pg1-f180.google.com with SMTP id n2so3924870pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ee7dIZ6uP6QXNcDhtf383EXh+QJWWk7ZjpJlf1hao0g=;
        b=qkN/qi8Kbd8EBvRSeNglafT8WHdsT6KSGK8BbqDwGMfz8caRBQQJWkq7B/DdSQKES3
         vrMUhIY+/V39FxHSDpMgxmgiAbGANCFFyenU+/X3g5PJRqQ/1LYFMfxwEjJ+X+hhr0s9
         OI11/dhh5KjSFQWy+fxuVJv/rxRXBgDS/O3y3B0QzbPR4CD5rM5BjFxUdJlAYCIPX2uz
         cwBj9+6GZ4hAkzdUQqeW3kX1OAgEmwXQZQaZu7xWbPQokIRnaz9ImxOIOAs4MA84phqS
         hnL+9EBdZ55OrbqRLSJahRb3g/mKJsfX6wNPr4lYLuzlmF0Izj0mJyGzP8AxjbWq23tU
         YqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ee7dIZ6uP6QXNcDhtf383EXh+QJWWk7ZjpJlf1hao0g=;
        b=E8WlnH+fpX7rzJOJCY7OqGDyG5tuOqxQVVG8+tvIYdFpzk/VREGbA0qnkY+5BC8hE5
         qbjH+wdWqzWQISORZQNxG8S0egOPKrklojQBfrTxfQYMB0AvY17HyfNO3B92mfTVMp09
         gZOu1EB8mTqeUeikMAGrMwsuuSmjZSxpYA2mpCtktsdLnh5DCS8UDKPC0cNgMq5t79+D
         7CXis0UshjHk8p8z1vtWkxKsWjD+7rRhP3bn/sczaJp1gF0fOAtHV+nWw0gDwIxyT1uc
         5y871rFiAkLuV9limoUF/AZHT8m4v/+U693dCqAqc/x0f8GZkiA3GqdHlLD1GDS+f1UH
         2fKg==
X-Gm-Message-State: APjAAAWUtQHfGlVLwR1dMBEBeEq5LN2BaHQAHbsbroe3uT913HFUPIIQ
        UXzcGltAGgLzHbQI3UmB/PyF+A==
X-Google-Smtp-Source: APXvYqzImg3CJgpFdQNkZkifeLhRrlBNhd3lJLtmXTamXKF6i/FQMziQdLYRjCbUgP1OER/BKZtqhA==
X-Received: by 2002:a63:ed06:: with SMTP id d6mr20481370pgi.267.1561151803708;
        Fri, 21 Jun 2019 14:16:43 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w14sm3691529pfn.47.2019.06.21.14.16.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 14:16:42 -0700 (PDT)
Date:   Fri, 21 Jun 2019 14:16:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
In-Reply-To: <alpine.DEB.2.21.1906061451001.121338@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1906211415050.77141@chino.kir.corp.google.com>
References: <20190503223146.2312-1-aarcange@redhat.com> <20190503223146.2312-3-aarcange@redhat.com> <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com> <20190520153621.GL18914@techsingularity.net> <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org> <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com> <20190531092236.GM6896@dhcp22.suse.cz> <alpine.DEB.2.21.1905311430120.92278@chino.kir.corp.google.com> <20190605093257.GC15685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1906061451001.121338@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019, David Rientjes wrote:

> The idea that I had was snipped from this, however, and it would be nice 
> to get some feedback on it: I've suggested that direct reclaim for the 
> purposes of hugepage allocation on the local node is never worthwhile 
> unless and until memory compaction can both capture that page to use (not 
> rely on the freeing scanner to find it) and that migration of a number of 
> pages would eventually result in the ability to free a pageblock.
> 
> I'm hoping that we can all agree to that because otherwise it leads us 
> down a bad road if reclaim is doing pointless work (freeing scanner can't 
> find it or it gets allocated again before it can find it) or compaction 
> can't make progress as a result of it (even though we can migrate, it 
> still won't free a pageblock).
> 
> In the interim, I think we should suppress direct reclaim entirely for 
> thp allocations, regardless of enabled=always or MADV_HUGEPAGE because it 
> cannot be proven that the reclaim work is beneficial and I believe it 
> results in the swap storms that are being reported.
> 
> Any disagreements so far?
> 
> Furthermore, if we can agree to that, memory compaction when allocating a 
> transparent hugepage fails for different reasons, one of which is because 
> we fail watermark checks because we lack migration targets.  This is 
> normally what leads to direct reclaim.  Compaction is *supposed* to return 
> COMPACT_SKIPPED for this but that's overloaded as well: it happens when we 
> fail extfrag_threshold checks and wheng gfp flags doesn't allow it.  The 
> former matters for thp.
> 
> So my proposed change would be:
>  - give the page allocator a consistent indicator that compaction failed
>    because we are low on memory (make COMPACT_SKIPPED really mean this),
>  - if we get this in the page allocator and we are allocating thp, fail,
>    reclaim is unlikely to help here and is much more likely to be
>    disruptive
>      - we could retry compaction if we haven't scanned all memory and
>        were contended,
>  - if the hugepage allocation fails, have thp check watermarks for order-0 
>    pages without any padding,
>  - if watermarks succeed, fail the thp allocation: we can't allocate
>    because of fragmentation and it's better to return node local memory,
>  - if watermarks fail, a follow up allocation of the pte will likely also
>    fail, so thp retries the allocation with a cleared  __GFP_THISNODE.
> 
> This doesn't sound very invasive and I'll code it up if it will be tested.
> 

Following up on this since there has been no activity in a week, I am 
happy to prototype this.  Andrea, would you be able to test a patch once 
it is ready for you to try?
