Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B1B2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dxfzvyoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394348AbfIXVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:43:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33160 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391667AbfIXVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:43:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so4077444qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/I3kJAxeP9vdAUcYchKoI07LQS8bBjcrtLkIzAX8o0=;
        b=dxfzvyoYzd+MaLowVdU8lfd3vRiqV8QDbzsg9zMKqnZatDJWbwAV/uchh+oFmCZjm1
         tnNto9pqqZ1eC1vo0f8Airoj+Sz9bci1GlX+YWQP+4MslqXQh9B+Tq5wEAMgMb3lQT9W
         YAH4AA9ju8lGOW+gJjj/WadWNSauJ+s9s2cuJEodK8AXSzKFeKrnXBOcIT0+rHj5qHEl
         lHXjbfwvyZuGS75wpxOVU9I096RWBw8F2thGg/GqclaRaFc1BMRip6AZUeu+Szt6f2dJ
         Gsiyfk+0lVYkR1+Ck3pBRHmaUzr/7zW5OQZr9fbChajg2BAtL7ggntW50WnR//f4Ogyx
         rlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/I3kJAxeP9vdAUcYchKoI07LQS8bBjcrtLkIzAX8o0=;
        b=aPSVa6uE2JixU8XUWBaDejfkGEWaVjTKJuZpEABROa0ETF1hqwnBLAMv26fg/2u9WY
         H2XGuKBUgkyvOsQALrQXeTe3G9nyUF8M+KTlMwIFa7dkbCufhuYbL8Zd+rYe1urenzx9
         erTeJz+ORYuAepOSiqxqvGlVotmSS/BwnRx+fB1MaTFfAhiM/4N3edEtWpSb/ywjewPF
         FxfDY0PqdCaN/3Hae/tsaJTaNmRjaB5KrylJdvElTsoZtm/Ykd5/EJye5m3ebgyswEVw
         WYB3cMhfJ0TOKJos+y1q9irA3b7UBecCbpm0XKkOk8NTKz2kCP5O1ez6T5GiA5vGsEDm
         vsGg==
X-Gm-Message-State: APjAAAXBEywdUJeX0Ej8B0yzyUqPAAzpW7Bi12/u3ybF0eay+eS1vnAo
        6iSeyPRt0CtpKHgF4/6dDrvThsY4Leo=
X-Google-Smtp-Source: APXvYqxZuK/tsiR10EVASqd0AxUFOlOSht4pnjeIdqOHGLzl6Yqc571pkJ7zuGHtCY/pDVTQH0FL8A==
X-Received: by 2002:ac8:2782:: with SMTP id w2mr5341601qtw.145.1569361418500;
        Tue, 24 Sep 2019 14:43:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::a51])
        by smtp.gmail.com with ESMTPSA id 54sm1746463qts.75.2019.09.24.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:43:37 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:43:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190924214337.GA17405@cmpxchg.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
 <20190924174809.GH1855@bombadil.infradead.org>
 <20190924194238.GA29030@cmpxchg.org>
 <20190924204608.GI1855@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924204608.GI1855@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:46:08PM -0700, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 03:42:38PM -0400, Johannes Weiner wrote:
> > > I'm not a fan of moving file_update_time() to _before_ the
> > > balance_dirty_pages call.
> > 
> > Can you elaborate why? If the filesystem has a page_mkwrite op, it
> > will have already called file_update_time() before this function is
> > entered. If anything, this change makes the sequence more consistent.
> 
> Oh, that makes sense.  I thought it should be updated after all the data
> was written, but it probably doesn't make much difference.
> 
> > > Also, this is now the third place that needs
> > > maybe_unlock_mmap_for_io, see
> > > https://lore.kernel.org/linux-mm/20190917120852.x6x3aypwvh573kfa@box/
> > 
> > Good idea, I moved the helper to internal.h and converted to it.
> > 
> > I left the shmem site alone, though. It doesn't require the file
> > pinning, so it shouldn't pointlessly bump the file refcount and
> > suggest such a dependency - that could cost somebody later quite a bit
> > of time trying to understand the code.
> 
> The problem for shmem is this:
> 
>                         spin_unlock(&inode->i_lock);
>                         schedule();
> 
>                         spin_lock(&inode->i_lock);
>                         finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
>                         spin_unlock(&inode->i_lock);
> 
> While scheduled, the VMA can go away and the inode be reclaimed, making
> this a use-after-free.  The initial suggestion was an increment on
> the inode refcount, but since we already have a pattern which involves
> pinning the file, I thought that was a better way to go.

I completely read over the context of that email you linked - that
there is a bug in the existing code - and looked at it as mere
refactoring patch. My apologies.

Switching that shmem site to maybe_unlock_mmap_for_io() to indirectly
pin the inode (in a separate bug fix patch) indeed makes sense to me.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks, Matthew.
