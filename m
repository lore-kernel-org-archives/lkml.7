Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A36C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD402083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Za9fYZAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbfHONM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:12:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46787 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfHONM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:12:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so5603172otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLAvE7lDJNY/2hXIcylLI9QM83e4RDXFU2y4iIE01K4=;
        b=Za9fYZAvz38c7q5/yD99Bw30IvGPgKhHThVM4vKevIWU3/BW35bi+F3ppSbkTaFkbT
         fo2CpvHM7cVjqc50yRgI9kWHHLUpxwV9lKj2e5yAkPWwg/XLsgOFJ9+5aRlUooRkXMat
         8A59WCTr5lrTYXQcbNjUgSTq+i4lJG3Axdh94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLAvE7lDJNY/2hXIcylLI9QM83e4RDXFU2y4iIE01K4=;
        b=QFt5DEp446KNuxL+oFtMeJZ2TebTj87CiXVZ2N21usCSBGSyqj8/pVZ7tybjdnzLw6
         z6YfKo0yaE7LhHxk0IPpehYxxaOlQ1py4GaRvIoJi4yMA/cdMS4bhsrgzh+0NVF9h6qH
         azuGRqApDB7e7fZs/lRiEMHnamzut3SqNKZoIt6ZBr12J4+yu6u6VniBfzXjpmG/ovQd
         SrxTZHwbQveUGH2oTdkqMf+mDM7Shn/c3OQ0NaYXaAydEk2TTYifnwVTMxcNdHLRth5X
         m/amtK0kl1u0f1giKsItrZ7ExcK5DqMwqzXdqwbEv/xCpsLAFsnKF4Yuqo4I/cJjm3Hs
         JWWg==
X-Gm-Message-State: APjAAAVbVGmq2bSfIsE/Z5fL4I4yiguaijeUTRJkU/7Bcmw56SxGRZR3
        7ir32HujB/PIQOeYETaevF6fLXK2u5i1gL7FAzdnCQ==
X-Google-Smtp-Source: APXvYqwb4/fPJEfbvz7yWzpngUJACAlVMwrTaPlMWn6ej36UzkLB2ub99QrSaO1zkI7AqPQMI7LKYD8gIiKyzGjESHY=
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr3688645otn.188.1565874747163;
 Thu, 15 Aug 2019 06:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch> <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz> <20190815130415.GD21596@ziepe.ca>
In-Reply-To: <20190815130415.GD21596@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 15 Aug 2019 15:12:11 +0200
Message-ID: <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 3:04 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 15, 2019 at 10:44:29AM +0200, Michal Hocko wrote:
>
> > As the oom reaper is the primary guarantee of the oom handling forward
> > progress it cannot be blocked on anything that might depend on blockable
> > memory allocations. These are not really easy to track because they
> > might be indirect - e.g. notifier blocks on a lock which other context
> > holds while allocating memory or waiting for a flusher that needs memory
> > to perform its work.
>
> But lockdep *does* track all this and fs_reclaim_acquire() was created
> to solve exactly this problem.
>
> fs_reclaim is a lock and it flows through all the usual lockdep
> schemes like any other lock. Any time the page allocator wants to do
> something the would deadlock with reclaim it takes the lock.
>
> Failure is expressed by a deadlock cycle in the lockdep map, and
> lockdep can handle arbitary complexity through layers of locks, work
> queues, threads, etc.
>
> What is missing?

Lockdep doens't seen everything by far. E.g. a wait_event will be
caught by the annotations here, but not by lockdep. Plus lockdep does
not see through the wait_event, and doesn't realize if e.g. that event
will never signal because the worker is part of the deadlock loop.
cross-release was supposed to fix that, but seems like that will never
land.

And since we're talking about mmu notifiers here and gpus/dma engines.
We have dma_fence_wait, which can wait for any hw/driver in the system
that takes part in shared/zero-copy buffer processing. Which at least
on the graphics side is everything. This pulls in enormous amounts of
deadlock potential that lockdep simply is blind about and will never
see.

Arming might_sleep catches them all.

Cheers, Daniel

PS: Don't ask me about why we need these semantics for oom_reaper,
like I said just trying to follow the rules.
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
