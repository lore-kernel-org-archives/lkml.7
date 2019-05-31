Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DF2264BD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwcrjK51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfEaGxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:53:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37945 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:53:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so7019975lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixtzvwr6OAXulCUUC9jq9Xmlzxs9UBVrOck9k45G2oE=;
        b=PwcrjK51/xlqSUlAN4uLHBclRr9umQumstkOA7FMfpqnsXSxeVoQskE+ltGjhobl50
         pgQdDwGtXSc4qqdHAnAiDwoJDcn0iaqYmTGzbznMvBt0/nXfsE9oO7LthGSxaOcrjo8M
         D8rNLQvfcZn+dZJx3fHuxLSvENelhFsnOSPPCyRRkgXQ4xWJ1dJYIeGmoiEv1JFNH6CH
         BFmLRrqtPm/RSMKGia68UH9jg06plIlOThXoPukcrOiQHuBqkjI3W6W3dS5LV13COHzR
         RPXtqvFpc8Pra6dZxgxA0qFZEVfmWWXDyLAKkRoNjrgKs0NY4Bljh18UpTbKn9C2tpEe
         jopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixtzvwr6OAXulCUUC9jq9Xmlzxs9UBVrOck9k45G2oE=;
        b=t1UR1LeG5Fud8NsNu5/6R8ph+X+kDghDc332Uxd5RsMeYpFfIOXIVt3/qC0bmf4zUR
         GTtMVCJu4sw5RpMKnLhQdq1NrTCTjaeYyksO90Mm8WwljzswxKKV5IMK+GKUlW5bcikn
         Fg7MQ9On0YYmKZaA6pIjDoB3iwjHGCyBEYThjR2JwR7DaWWzCHgZ8VPqlkeJ5JjAthjJ
         D5LfRLquaVNw2GSvfXNujOlR3xbRpvQPlH/4733Ad5p2UBHS+4zodPshJIj5Bd6b7U5L
         7qCAscWwkLG3pdQosZF3cdPVadC8akmkQajch98hgpi6h3cbO1YS46uTwQ7A5Qk05lBq
         3OCw==
X-Gm-Message-State: APjAAAX/M7D+hYu0l0jW/K6QQYchUzV39HfnCovbqgpIXuWXtdTpFgHK
        gn1D3exHjrVvmUQgkUNyIajvu38XsZS1QOK0ykc=
X-Google-Smtp-Source: APXvYqwnlM1MWVJTUMAOQIQlbunxi4co5+4jFfP5byz4l0NftRHymUnJ+aAR8fwwdQpHasJ2ZV8VqO/3qLsU69x79BU=
X-Received: by 2002:ac2:42cb:: with SMTP id n11mr4252789lfl.179.1559285612749;
 Thu, 30 May 2019 23:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com> <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
 <21fda627-1d3c-12cc-6389-8c226218e2ce@linux.alibaba.com>
In-Reply-To: <21fda627-1d3c-12cc-6389-8c226218e2ce@linux.alibaba.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 31 May 2019 14:53:21 +0800
Message-ID: <CAERHkrsjTNUssmECksdJnLdDjVJ_9UpvYiHyBDJ3S1toURCbrw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 2:09 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On 2019/5/31 13:12, Aubrey Li wrote:
> > On Fri, May 31, 2019 at 11:01 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >>
> >> This feels like "date" failed to schedule on some CPU
> >> on time.
> >>
> >> My first reaction is: when shell wakes up from sleep, it will
> >> fork date. If the script is untagged and those workloads are
> >> tagged and all available cores are already running workload
> >> threads, the forked date can lose to the running workload
> >> threads due to __prio_less() can't properly do vruntime comparison
> >> for tasks on different CPUs. So those idle siblings can't run
> >> date and are idled instead. See my previous post on this:
> >> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> >> (Now that I re-read my post, I see that I didn't make it clear
> >> that se_bash and se_hog are assigned different tags(e.g. hog is
> >> tagged and bash is untagged).
> >
> > Yes, script is untagged. This looks like exactly the problem in you
> > previous post. I didn't follow that, does that discussion lead to a solution?
>
> No immediate solution yet.
>
> >>
> >> Siblings being forced idle is expected due to the nature of core
> >> scheduling, but when two tasks belonging to two siblings are
> >> fighting for schedule, we should let the higher priority one win.
> >>
> >> It used to work on v2 is probably due to we mistakenly
> >> allow different tagged tasks to schedule on the same core at
> >> the same time, but that is fixed in v3.
> >
> > I have 64 threads running on a 104-CPU server, that is, when the
>
> 104-CPU means 52 cores I guess.
> 64 threads may(should?) spread on all the 52 cores and that is enough
> to make 'date' suffer.

64 threads should spread onto all the 52 cores, but why they can get
scheduled while untagged "date" can not? Is it because in the current
implementation the task with cookie always has higher priority than the
task without a cookie?

Thanks,
-Aubrey
