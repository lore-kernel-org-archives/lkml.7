Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3A6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FAE21783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhNep12X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEUITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:19:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45170 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:19:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id n22so12310156lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uypbq/FcCnVlqwXjTWT1VO52O+LoVFoRKGGQXigRvgc=;
        b=HhNep12XcKjILVSX84LR4GhavmMnam7QaFAEowwiZ4PCTmMWbBTNW5qEKQMZniB93+
         yiitMPmyQRp1ygqGQfB/I9ki0zpREPrOfbvi/Rj9yc3lJnwAdtYTsbAqHIrnelpnVAdo
         uDlsoj3BHzFnw8vQy6NlcB8dkY4QXns/SAUKoBu++/F903EYr/A12GSVv4MbraTEdjHd
         I6KE++i/zb8DaLJRyFkwNKrHKCDoqE3yxx+EZYku+NvAHtyWL3DJqtU32WwUijzplclK
         MNbehcD51NFgLdjJjvh21Kw+76qtxvT6BEuag1s4jsXqiJIT52FDk5uDhBEOAVeHRSa6
         424A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uypbq/FcCnVlqwXjTWT1VO52O+LoVFoRKGGQXigRvgc=;
        b=LxR1VVMPrDE2wAO+t3NcXmsjZgApa+1gUxeXs1PY4Wf3VrJDitAJBtV+81RW50U0Py
         a8RMtGg8HNcC9OQRVzbmzTWSl3wCNRAMAzsdEy6ykV5ZZPdG2FH5hvG6JyWKQ+QAQ/tD
         4pZRmOLlRx9ZM/+MlPe4QPkKrQAFIDJ3uwBJrSL9Rh5ZxQZYAVKJY6XLgw8TIafq5063
         hnYiarlWVm35NjyzWxyPhBlQCeleLQFot3AzaULq2yDwAiaid0AQXdN3u5GuC4sHgmyq
         K2L6w4B4tlB4z93gv2t/gFvPB/kivxA5XkIE8cdCPxN4otfCrD6wRlYWYO0s3omHXPAX
         SLyA==
X-Gm-Message-State: APjAAAWXJBnN9jl4XfiZaYZXhJh9FMyd2SH4pv8YOUwXEyEtBqiPBlvB
        7tTHWp4F+85vixuPDjLC6XPvp+8AcDrlmP6THHA=
X-Google-Smtp-Source: APXvYqztUjiXu0XeqmQ4PEZzjNFSVC6Q4eUVjLhOpYx5zvyCEdUFNkzlK+XTUHz/h4CbCp/g96ZtQBbvteNLAP+74VA=
X-Received: by 2002:a19:c194:: with SMTP id r142mr40248788lff.41.1558426753044;
 Tue, 21 May 2019 01:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com>
 <20190520130454.GA677@pauld.bos.csb> <CANaguZA1Ujahr78wt4pxnLzR_in47_EXvxMQLWrP4NS3mpP91g@mail.gmail.com>
In-Reply-To: <CANaguZA1Ujahr78wt4pxnLzR_in47_EXvxMQLWrP4NS3mpP91g@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 21 May 2019 16:19:00 +0800
Message-ID: <CAERHkrtaEEO69ZsDfy8mcU=H_gTFRuTeoKTC0Bc1pUeD7Z3fqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and scheduling.
To:     Vineeth Pillai <vpillai@digitalocean.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:04 PM Vineeth Pillai
<vpillai@digitalocean.com> wrote:
>
> > > The following patch improved my test cases.
> > > Welcome any comments.
> > >
> >
> > This is certainly better than violating the point of the core scheduler :)
> >
> > If I'm understanding this right what will happen in this case is instead
> > of using the idle process selected by the sibling we do the core scheduling
> > again. This may start with a newidle_balance which might bring over something
> > to run that matches what we want to put on the sibling. If that works then I
> > can see this helping.
> >
> > But I'd be a little concerned that we could end up thrashing. Once we do core
> > scheduling again here we'd force the sibling to resched and if we got a different
> > result which "helped" him pick idle we'd go around again.

Thrashing means more IPIs right? That's not what I observed, because idle task
has less chance onto CPU, rescheduling is reduced accordingly.

> > I think inherent in the concept of core scheduling (barring a perfectly aligned set
> > of jobs) is some extra idle time on siblings.

Yeah, I understand and agree with this, but 10-15% idle time on an overloaded
system makes me to try to figure out how this could happen and if we
can improve it.

> >
> >
> I was also thinking along the same lines. This change basically always
> tries to avoid idle and there by constantly interrupting the sibling.
> While this change might benefit a very small subset of workloads, it
> might introduce thrashing more often.

Thrashing is not observed under an overloaded case but may happen under a
light load or a mid load case, I need more investigation.

>
> One other reason you might be seeing performance improvement is
> because of the bugs that caused both siblings to go idle even though
> there are runnable and compatible threads in the queue. Most of the
> issues are fixed based on all the feedback received in v2. We have a
> github repo with the pre v3 changes here:
> https://github.com/digitalocean/linux-coresched/tree/coresched

Okay, thanks, it looks like the core functions pick_next_task() and pick_task()
have a lot of changes against v2. Need more brain power..

>
> Please try this and see how it compares with the vanilla v2. I think its
> time for a v3 now and we shall be posting it soon after some more
> testing and benchmarking.

Is there any potential change between pre v3 and v3? I prefer working
based on v3 so that everyone are on the same page.

Thanks,
-Aubrey
