Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6733EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF082086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="N6pnDyVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfI3Lxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:53:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45558 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfI3Lxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:53:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so10786254oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFZFfM0846prBEVBYkpm16Wm+bg3bHOMhi+iGvy4A8E=;
        b=N6pnDyVUDYhzKQc1LFdklknQkLbjYs5CQHB5agpN4WJJ805CnbFa4cesHtF9w7IHzN
         JC8WIBJaiTfGsbeJcvV6xqkNa65E0eIFkuRQrSM4bo63xLG44wZQXC/4w68T9pugBZon
         jC10NayRGAYcGKKMrkalSkqSgl8UUzA8aYHFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFZFfM0846prBEVBYkpm16Wm+bg3bHOMhi+iGvy4A8E=;
        b=IwDrlKU7rg4GhD4pcsFIbHfh8It7fQkAUuYUKasNFXtvbapw3rQGT5IaeiHDZK/HPF
         bGHcKmaUDhtMadyvUpAe+SoK+QS1dyhfQZp0LyyDmZpFqvCtRkrMsXlBIqVO5Xsa74fL
         jnSfOJvqLMcUizHeBF83oR3lTsBd31iROGr1JmlYD8DYISJMghxrDkmV53SStzEvkYrK
         xux2/8LgVyBCz+Lt0YlUjryyTOU4ScCI+KXyaOie6mT0BQeGCdcjAYZg5dXPWnLS4UrT
         XFYt+YFeSBfPR0PuAE1aZQy4HMF1IQBTIZHHekXpXezV3l1neoxqsJWqed/i+pAP2RJX
         Br8A==
X-Gm-Message-State: APjAAAUrJ+jOXzoomDR9ljLbB6sqnBSB0y2pJEHblhzTpH4sUAeKGNT0
        rYFNSrwBfdtTbivQ8w0F9yYhjLVdx0Ry1DiJGzyv0Q==
X-Google-Smtp-Source: APXvYqxGse996UY0OaF5FBHZ21HK2m7EwDDbdQFdJjojXyLHpz0n6Jt/rzkqGQiZ1wwv3ysAI/sS7HAd/zy1S/fPsrY=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr18358400oib.110.1569844420639;
 Mon, 30 Sep 2019 04:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com> <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu>
In-Reply-To: <20190912123532.GB16200@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 30 Sep 2019 07:53:30 -0400
Message-ID: <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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

On Thu, Sep 12, 2019 at 8:35 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >
> > I think comparing parent's runtime also will have issues once
> > the task group has a lot more threads with different running
> > patterns. One example is a task group with lot of active threads
> > and a thread with fairly less activity. So when this less active
> > thread is competing with a thread in another group, there is a
> > chance that it loses continuously for a while until the other
> > group catches up on its vruntime.
>
> I actually think this is expected behaviour.
>
> Without core scheduling, when deciding which task to run, we will first
> decide which "se" to run from the CPU's root level cfs runqueue and then
> go downwards. Let's call the chosen se on the root level cfs runqueue
> the winner se. Then with core scheduling, we will also need compare the
> two winner "se"s of each hyperthread and choose the core wide winner "se".
>
Sorry, I misunderstood the fix and I did not initially see the core wide
min_vruntime that you tried to maintain in the rq->core. This approach
seems reasonable. I think we can fix the potential starvation that you
mentioned in the comment by adjusting for the difference in all the children
cfs_rq when we set the minvruntime in rq->core. Since we take the lock for
both the queues, it should be doable and I am trying to see how we can best
do that.

> >
> > As discussed during LPC, probably start thinking along the lines
> > of global vruntime or core wide vruntime to fix the vruntime
> > comparison issue?
>
> core wide vruntime makes sense when there are multiple tasks of
> different cgroups queued on the same core. e.g. when there are two
> tasks of cgroupA and one task of cgroupB are queued on the same core,
> assume cgroupA's one task is on one hyperthread and its other task is on
> the other hyperthread with cgroupB's task. With my current
> implementation or Tim's, cgroupA will get more time than cgroupB. If we
> maintain core wide vruntime for cgroupA and cgroupB, we should be able
> to maintain fairness between cgroups on this core. Tim propose to solve
> this problem by doing some kind of load balancing if I'm not mistaken, I
> haven't taken a look at this yet.
I think your fix is almost close to maintaining a core wide vruntime as you
have a single minvruntime to compare now across the siblings in the core.
To make the fix complete, we might need to adjust the whole tree's
min_vruntime and I think its doable.

Thanks,
Vineeth
