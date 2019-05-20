Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2259216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="VMqbRHpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfETOEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:04:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40932 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfETOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:04:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so13046484otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UHz2TGHKpk84+X3oUaIARldCLxF/39kE2NgJCOaNxI=;
        b=VMqbRHpx49BNEYXrCjZOdO8zH2orgsVLn3xb+IAJcAx5Yz7tnL7IsEC5ZVjFwOIm3I
         lyqJ0DZ6EPMpzObwrOFB6zXvungD3rxlSF/27MZ/7GV0dybpD1YS0rW58A2Me+CI34cM
         4lnnQwerU5gdQO/s+GRu/loFL1aMjbvzt2KBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UHz2TGHKpk84+X3oUaIARldCLxF/39kE2NgJCOaNxI=;
        b=CTa+99MAFycV0jDTVsLsyRxTTRM/k+An0z+alSMu62W9JCwh+Ee0PuNDEEYoCiIuki
         i14TFMzvOPiFfIH9UmdBwHcTCj/PwmWxa9YxtTHwjOHy1P3HpZ/TmoXZbhK4ZQebaKMN
         TdMn2EoZ1Js+sJizI0KCwkYZdnjyUIeC3dDY65mwTKNImQgFlb/R+gR9WUB8heZt1Zrw
         H/+UKbfOOzonuvyVrc0M6l3qWIEs8Ep2cQNLpXec1DDG0tR0SGPtx1N3nN/de3Z9FOT5
         9m+kigS8jIYNDlFTJ38+UyKEfiBXhFywGQb6ut2YWOHBCfe7l9fuPr7DEZnmK0EK5AIW
         QfTQ==
X-Gm-Message-State: APjAAAUNTepgxPm5oHBw4wjZEAy4D+7o/ozJhNMKDNQNZCi4NfmDHAFk
        bHHJufwLhiQ6cCGDZNq0BQElQzRl4xL+qgQSylC1Ow==
X-Google-Smtp-Source: APXvYqzzSKFyrP9zWKtj4veAWJNOaWgUMzAjblwTesRYkeo2D3nzYwXtkbtuClh1tLYiYK/QYe8O8YFN4+6P9DbKtG0=
X-Received: by 2002:a9d:30d6:: with SMTP id r22mr45025112otg.33.1558361051850;
 Mon, 20 May 2019 07:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com> <20190520130454.GA677@pauld.bos.csb>
In-Reply-To: <20190520130454.GA677@pauld.bos.csb>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Mon, 20 May 2019 10:04:01 -0400
Message-ID: <CANaguZA1Ujahr78wt4pxnLzR_in47_EXvxMQLWrP4NS3mpP91g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and scheduling.
To:     Phil Auld <pauld@redhat.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
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

> > The following patch improved my test cases.
> > Welcome any comments.
> >
>
> This is certainly better than violating the point of the core scheduler :)
>
> If I'm understanding this right what will happen in this case is instead
> of using the idle process selected by the sibling we do the core scheduling
> again. This may start with a newidle_balance which might bring over something
> to run that matches what we want to put on the sibling. If that works then I
> can see this helping.
>
> But I'd be a little concerned that we could end up thrashing. Once we do core
> scheduling again here we'd force the sibling to resched and if we got a different
> result which "helped" him pick idle we'd go around again.
>
> I think inherent in the concept of core scheduling (barring a perfectly aligned set
> of jobs) is some extra idle time on siblings.
>
I was also thinking along the same lines. This change basically always
tries to avoid idle and there by constantly interrupting the sibling.
While this change might benefit a very small subset of workloads, it
might introduce thrashing more often.

One other reason you might be seeing performance improvement is
because of the bugs that caused both siblings to go idle even though
there are runnable and compatible threads in the queue. Most of the
issues are fixed based on all the feedback received in v2. We have a
github repo with the pre v3 changes here:
https://github.com/digitalocean/linux-coresched/tree/coresched

Please try this and see how it compares with the vanilla v2. I think its
time for a v3 now and we shall be posting it soon after some more
testing and benchmarking.

Thanks,
