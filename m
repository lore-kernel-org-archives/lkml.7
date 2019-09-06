Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C882C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6335E2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392442AbfIFGjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733031AbfIFGjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:39:42 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 731EE7E423
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 06:39:41 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id v15so3815558pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 23:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UhhCs3Gjz8KkswmNBxyzabbpAJS3lTozQZNTTh+7LQ=;
        b=EaEZR3cwSureIKgzQGxBKw1nYUyvJqYAvQ0uk8xodR/UQg1N2fCsjE+RsMvzHMJDvv
         Yod3nCY3QLQo8oznG3k4r+fQKemqFDGJ3VxgTe56t1z3mfNVzES5sULm0OCG3rSCgK7E
         UPHzoyADaU1B/abox46VJFMroFdtFiLLBG/7jRsPyk/dneBkinqXQKZTV1J6ZkF7p+6t
         f8oA6dWAA0t998h9lK7ocJPl3yrdRq9kwFDPzqw0SjlnjIeyCzNv/BzibIEIKxidToO/
         XP6jnvP7HzkrdmIO1OWLOYFvKWeexnymmSp7/2eMJ1VtXRvbCnmr11qDj3KeSQR8sngI
         Wnng==
X-Gm-Message-State: APjAAAUPSRcWlfGl9oPYzH24jHod/7VJ23YvR2fK2j93iFvg4O+EKpz3
        TvMAQyERC6S9VlBW8xtmA55LPKpCbIs6p6nJpRVxCcmTd+6gQEK099dbJQVJNHhymajNdcc2CVt
        CRFjnTDLwUWziVvr/2zfec96Y
X-Received: by 2002:aa7:8dc9:: with SMTP id j9mr8926230pfr.233.1567751981013;
        Thu, 05 Sep 2019 23:39:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykh6T4acsoB5nXpGaTKcGuNsjK7An2OwB89FQoKyunqEduuO2ojQ2KAjKfMDYncUVIzq9Q8g==
X-Received: by 2002:aa7:8dc9:: with SMTP id j9mr8926221pfr.233.1567751980794;
        Thu, 05 Sep 2019 23:39:40 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i9sm11178333pgo.46.2019.09.05.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 23:39:39 -0700 (PDT)
Date:   Fri, 6 Sep 2019 14:39:27 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/7] mm: Page fault enhancements
Message-ID: <20190906063927.GA8813@xz-x1>
References: <20190905101534.9637-1-peterx@redhat.com>
 <CAHk-=wgSwiRsT4=q71jnF_5JrUn5qg76VBw+oMJ-e7SQ17Q1QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSwiRsT4=q71jnF_5JrUn5qg76VBw+oMJ-e7SQ17Q1QA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:06:04PM -0700, Linus Torvalds wrote:
> On Thu, Sep 5, 2019 at 3:15 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > This series is split out of userfaultfd-wp series to only cover the
> > general page fault changes, since it seems to make sense itself.
> 
> The series continues to look sane to me, but I'd like VM people to
> take a look. I see a few reviewed-by's, it would be nice to see more
> comments from people. I'd like to see Andrea in particular say "yeah,
> this looks all good to me".

Yes I agree.  I would appreciate if either Andrea or any of the other
mm experts can comment on this patchset.

> 
> Also a question on how this will get to me - it smells like Andrew's
> -mm tree to me, both from a VM and a userfaultfd angle (and looking
> around, at least a couple of previous patches by Peter have gone that
> way).
> 
> And it would be lovely to have actual _numbers_ for the alleged
> latency improvements. I 100% believe them, but still, numbers rule.

If the question was about the userspace signal handling - IMHO it's
not really a latency number that I can measure, but it's some
functional difference just like what dfa37dc3fc1f6f wanted to solve
previously (though that solution seemed to be causing some other issue
like what have been mentioned in the cover letter on invalid VMA
access), while this series should be a cleaner approach.

To be clear about the functional differnce: if without the userspace
non-fatal handling patch in this series ("mm: Return faster for
non-fatal signals in user mode faults"), we can't use Ctrl-C to stop a
program hanging in handle_userfault(), nor can we use gdb to attach to
that process (we can do it if with dfa37dc3fc1f6f, but again it's not
the clean approach).  And, if with this whole series (hence with "mm:
Return faster for non-fatal signals in user mode faults"), we can do
both (Ctrl-C to stop the process, or gdb attaching to that hanging
process without hanging gdb).

> 
> Talking about latency, what about that retry loop in gup()? That's the
> one I'm not at all convinced about. It doesn't check for signals, so
> if there is some retry logic, it loops forever. Hmm?

Hmm seems to be a valid point... IMHO it'll be fine for non-fatal
signals, because GUPs will still be without FAULT_FLAG_INTERRUPTIBLE
when calling handle_mm_fault(), hence the page fault logic should at
least ignore non-fatal signals.  However I agree that we probably need
a check for fatal signals in __get_user_pages_locked() now.

Thanks,

[1] https://lkml.org/lkml/2017/11/2/833
[2] https://github.com/xzpeter/clibs/blob/master/gpl/userspace/uffd-test/uffd-test.c

-- 
Peter Xu
