Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iWPYjGwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfEUQAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:00:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42292 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfEUQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:00:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id w9so11387952oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhMdeTlwpp1ipABlk4vrZFRm+ansgm/gZL6cQawSF+c=;
        b=iWPYjGwyHiS4RY9vwsXeZ8i6fKnHYt4FFltlGbL8zLBXNA8i8brUrULMsuEhL8dHVf
         mFcmOyqSuXprZfVNumy/KKsfMmPjtpula612aIpH4kUKtfFSu1IVVl9/lN7lo1EbO5Di
         Nm953Hx97nGZEsz7iDskJM7qE79xpAl3pv/ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhMdeTlwpp1ipABlk4vrZFRm+ansgm/gZL6cQawSF+c=;
        b=M6tuItgkfZ068A0ugYYQTOca1p3M56V9vrMI6D+bWsBpl4lj4RIFEabb/UWq3NWrMo
         x8IFpP8KYuB/CKpYkYNX+lHhDyAkvOG8aUNAM/g4oQdhX8rCIbj1NgrAoRrlrTCVUvUP
         dOGx8pEvRzYl6lX4mq0OvHSVT7b2zL3zV40YZZHAJBTP+8T8YFOWAom5WBBDPLunoFBm
         AMQvwzJSh8Q8+k4j3xTVlCTaEsKs6e32ONMoT2p5nn41oOVHUAq0ScjCxhlKzSpVqPIl
         qJiksDfSgfUEtsKFW2ebT8TK+TW7J3RSW+uqITW5yQ6Wahr00TK0FenljEXjDgvk98L3
         F5Zw==
X-Gm-Message-State: APjAAAWWaR5evPg2c4ahEOg9AmbG6TDA9S1pHiQFk470P1xNGh9NVm0V
        qeL79sdu/J/EG+tSIPrNFTsYn9NUHRPEuukby75/xw==
X-Google-Smtp-Source: APXvYqz1HRnyxysQSyfGmkEPM6kIYzznd5oq6OhQwPIPC1dkDjzOHTKgjff5dHGhujv1bAcBk2AFzcykzlU6H9OZNBk=
X-Received: by 2002:aca:e4c8:: with SMTP id b191mr4039039oih.110.1558454448157;
 Tue, 21 May 2019 09:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190520213945.17046-4-daniel.vetter@ffwll.ch> <20190521154059.GC3836@redhat.com>
In-Reply-To: <20190521154059.GC3836@redhat.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 21 May 2019 18:00:36 +0200
Message-ID: <CAKMK7uEaKJiT__=dt=ROUP4Kkq1NgwScLJFQcMuBs2GYjMWOLw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, notifier: Add a lockdep map for invalidate_range_start
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:41 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, May 20, 2019 at 11:39:45PM +0200, Daniel Vetter wrote:
> > This is a similar idea to the fs_reclaim fake lockdep lock. It's
> > fairly easy to provoke a specific notifier to be run on a specific
> > range: Just prep it, and then munmap() it.
> >
> > A bit harder, but still doable, is to provoke the mmu notifiers for
> > all the various callchains that might lead to them. But both at the
> > same time is really hard to reliable hit, especially when you want to
> > exercise paths like direct reclaim or compaction, where it's not
> > easy to control what exactly will be unmapped.
> >
> > By introducing a lockdep map to tie them all together we allow lockdep
> > to see a lot more dependencies, without having to actually hit them
> > in a single challchain while testing.
> >
> > Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> > this out for the invaliate_range_start callback. If there's
> > interest, we should probably roll this out to all of them. But my
> > undestanding of core mm is seriously lacking, and I'm not clear on
> > whether we need a lockdep map for each callback, or whether some can
> > be shared.
>
> I need to read more on lockdep but it is legal to have mmu notifier
> invalidation within each other. For instance when you munmap you
> might split a huge pmd and it will trigger a second invalidate range
> while the munmap one is not done yet. Would that trigger the lockdep
> here ?

Depends how it's nesting. I'm wrapping the annotation only just around
the individual mmu notifier callback, so if the nesting is just
- munmap starts
- invalidate_range_start #1
- we noticed that there's a huge pmd we need to split
- invalidate_range_start #2
- invalidate_reange_end #2
- invalidate_range_end #1
- munmap is done

But if otoh it's ok to trigger the 2nd invalidate range from within an
mmu_notifier->invalidate_range_start callback, then lockdep will be
pissed about that.

> Worst case i can think of is 2 invalidate_range_start chain one after
> the other. I don't think you can triggers a 3 levels nesting but maybe.

Lockdep has special nesting annotations. I think it'd be more an issue
of getting those funneled through the entire call chain, assuming we
really need that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
