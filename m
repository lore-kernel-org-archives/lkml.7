Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B97B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW4GvuGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDDXX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:23:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44680 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfDDXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:23:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id d11so3787868edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQmFptRCMNJUXqWNlG7Ngtr4WD0bD7Lax90R8JIeGM8=;
        b=NW4GvuGndPKFA7keaygmFDAXwp5CI+w9ZQp3InVI/99p1G8R5xbgp4cTsJRUxSTe9y
         HByHqPrq2noZJX8O6iPPiKq3Zr+cfKmBtF00K9BrznkKnlum0k7Nwrhx7tyF5NlJOHSV
         45LGI+oBdyq/ApcptsqcPK7fsn69vQBkcwAkgYV2vRlBeAlF6VDwjp0AugcTwl3+klQd
         tdGwINuu9wvyOC52mBvm1EauiZIa4wOiVveh90sz2FGRUpJatBthj+H33uXjhIi/rrUS
         RB/vIGXyX/bBgOJJFluSzhcCQEfmW6+Jt1NraodcSkK020RD0FSwwSoGcSozRk7NoeCc
         Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQmFptRCMNJUXqWNlG7Ngtr4WD0bD7Lax90R8JIeGM8=;
        b=amVubAPSc6wEBh1QEH8O37/YZCgCbpMu9wJMGvjBJBlS7oZkae820byHyji90kePq1
         s0MyOTN6qk7aP6Fd2yVtyhgePRuYKmYwm9/r+PPhG5iqJ+VWZoKAkyofmp9qoCFMW6kQ
         DkjNd9c4t0+6aK9UrLk/VYlVbbW3IV8jhMXjMiXa17gHD9ol7j+lKPkcP1EATv3XJKPu
         9a8a4CffXUSco95tqlVh8ehfgxfnM7hdsVc1fgCL0KLfDor+i5pcXVmcWY6nNnmA+nGb
         1zMPeDu7rQnQ2vmY0cNhTAxq362x47c9OhDGbNQ2Svghh8UtihwQ/yVOK+u0jsjZcCzp
         x/4g==
X-Gm-Message-State: APjAAAWMsn2HMabmqfX8co55ZYMQGb9Yga/eRb9JBFsBGjd3eNM+v+je
        5DE4dV5kHx8ahO7fcZqEZDVX40UGaRYFWUKap68=
X-Google-Smtp-Source: APXvYqxBzgnt/PBRH1nTXiLhk4TY1R/NnJ5ZgUWqjraQ1s5vhgvI/k4rRr4Fe8SJrmOB9acp2jJtq/tDPRQwy85M+Jk=
X-Received: by 2002:a50:b6d5:: with SMTP id f21mr5626526ede.105.1554420237228;
 Thu, 04 Apr 2019 16:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com> <20190404163914.GA4229@cmpxchg.org>
In-Reply-To: <20190404163914.GA4229@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 5 Apr 2019 07:23:46 +0800
Message-ID: <CAGWkznHeGeiHWSF-gPmSW=AWQcEybHroOuP4CSbW4rKq12LtNw@mail.gmail.com>
Subject: Re: [PATCH] mm:workingset use real time to judge activity of the file page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Apr 04, 2019 at 11:30:17AM +0800, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > In previous implementation, the number of refault pages is used
> > for judging the refault period of each page, which is not precised as
> > eviction of other files will be affect a lot on current cache.
> > We introduce the timestamp into the workingset's entry and refault ratio
> > to measure the file page's activity. It helps to decrease the affection
> > of other files(average refault ratio can reflect the view of whole system
> > 's memory).
>
> I don't understand what exactly you're saying here, can you please
> elaborate?
>
> The reason it's using distances instead of absolute time is because
> the ordering of the LRU is relative and not based on absolute time.
>
> E.g. if a page is accessed every 500ms, it depends on all other pages
> to determine whether this page is at the head or the tail of the LRU.
>
> So when you refault, in order to determine the relative position of
> the refaulted page in the LRU, you have to compare it to how fast that
> LRU is moving. The absolute refault time, or the average time between
> refaults, is not comparable to what's already in memory.
How do you know how long time did these pages' dropping taken.Actruly,
a quick dropping of large mount of pages will be wrongly deemed as
slow dropping instead of the exact hard situation.That is to say, 100
pages per million second or per second have same impaction on
calculating the refault distance, which may cause less protection on
this page cache for former scenario and introduce page thrashing.
especially when global reclaim, a round of kswapd reclaiming that
waked up by a high order allocation or large number of single page
allocations may cause such things as all pages within the node are
counted in the same lru. This commit can decreasing above things by
comparing refault time of single page with avg_refault_time =
delta_lru_reclaimed_pages/ avg_refault_retio (refault_ratio =
lru->inactive_ages / time).
