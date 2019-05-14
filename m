Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E7C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F173214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:30:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39014 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfENGar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:30:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so2961081qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 23:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mgFD/HBmqD9tbHso2Ft8IrmU0HCter766u/5lDK5MD4=;
        b=gmZ+nK/L1S2bq89wiQ5Hy2tKJOZRQRY4Lqfb4IcaUxFBXGiga6Ir/41FTMFgY2fD07
         6NUfgfvShoVfoOX0/uW6PiwFNtLJBPJoJjfG4qkQ+MiE4T6hRLOLfHPyCG1qMnYHNfUv
         yelVGaxPEDehyTDFvSBOyO8ORlkob9oTUjmJMIIQ8IdC6NcoQT/SN5S38vbFHRpjq3zQ
         POjIP+h+Tl6AncXLglfF+Xfkm6P0u5sgzq4EYI2+HKb1bUO52ngSv0aYVIMLibffl2OE
         evan7xmTbZeaFeRB3u1woPl59wtceLo8FEiLa/gpy/WRE0fAKTGIcdMy3i5+a0W4iGa3
         1Cvg==
X-Gm-Message-State: APjAAAXohvw1Xb/R9XgjarhJ+8RME8czbpykIWZw/J229KE/+SS74Zq2
        m7+YjrO9lliY1S/8UWYcAZk2sw==
X-Google-Smtp-Source: APXvYqwaf5mn0VEeYyYPcp4R3rX8b8NxqPdRtJziHb0+qXlt8ZvgtZIe0QaDDnNFxHyEY0wLoSEhbg==
X-Received: by 2002:ac8:8ad:: with SMTP id v42mr27107649qth.337.1557815446620;
        Mon, 13 May 2019 23:30:46 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a51sm6532064qta.85.2019.05.13.23.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 23:30:45 -0700 (PDT)
Date:   Tue, 14 May 2019 08:30:43 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190514063043.ojhsb6d3ohxx4wur@butterfly.localdomain>
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
 <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
 <a3870e32-3a27-e6df-fcb2-79080cdd167a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3870e32-3a27-e6df-fcb2-79080cdd167a@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, May 13, 2019 at 03:37:56PM +0300, Kirill Tkhai wrote:
> > Yes, I get your point. But the intention is to avoid another hacky trick
> > (LD_PRELOAD), thus *something* should *preferably* be done on the
> > kernel level instead.
> 
> I don't think so. Does userspace hack introduce some overhead? It does not
> look so. Why should we think about mergeable VMAs in page fault handler?!
> This is the last thing we want to think in page fault handler.
> 
> Also, there is difficult synchronization in page fault handlers, and it's
> easy to make a mistake. So, there is a mistake in [3/4], and you call
> ksm_enter() with mmap_sem read locked, while normal way is to call it
> with write lock (see madvise_need_mmap_write()).
> 
> So, let's don't touch this path. Small optimization for unlikely case will
> introduce problems in optimization for likely case in the future.

Yup, you're right, I've missed the fact that write lock is needed there.
Re-vamping locking there is not my intention, so lets find another
solution.

> > Also, just for the sake of another piece of stats here:
> > 
> > $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> > 526
> 
> This all requires attentive analysis. The number looks pretty big for me.
> What are the pages you get merged there? This may be just zero pages,
> you have identical.
> 
> E.g., your browser want to work fast. It introduces smart schemes,
> and preallocates many pages in background (mmap + write 1 byte to a page),
> so in further it save some time (no page fault + alloc), when page is
> really needed. But your change merges these pages and kills this
> optimization. Sounds not good, does this?
> 
> I think, we should not think we know and predict better than application
> writers, what they want from kernel. Let's people decide themselves
> in dependence of their workload. The only exception is some buggy
> or old applications, which impossible to change, so force madvise
> workaround may help. But only in case there are really such applications...
> 
> I'd researched what pages you have duplicated in these 526 MB. Maybe
> you find, no action is required or a report to userspace application
> to use madvise is needed.

OK, I agree, this is a good argument to move decision to userspace.

> > 2) what kinds of opt-out we should maintain? Like, what if force_madvise
> > is called, but the task doesn't want some VMAs to be merged? This will
> > required new flag anyway, it seems. And should there be another
> > write-only file to unmerge everything forcibly for specific task?
> 
> For example,
> 
> Merge:
> #echo $task > /sys/kernel/mm/ksm/force_madvise

Immediate question: what should be actually done on this? I see 2
options:

1) mark all VMAs as mergeable + set some flag for mmap() to mark all
further allocations as mergeable as well;
2) just mark all the VMAs as mergeable; userspace can call this
periodically to mark new VMAs.

My prediction is that 2) is less destructive, and the decision is
preserved predominantly to userspace, thus it would be a desired option.

> Unmerge:
> #echo -$task > /sys/kernel/mm/ksm/force_madvise

Okay.

> In case of task don't want to merge some VMA, we just should skip it at all.

This way we lose some flexibility, IMO, but I get you point.

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

