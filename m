Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AACC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D6D26BA8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="L7RaHhsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:24:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34170 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:24:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id l17so9580902otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8Vb8qpSXm8bzNNepx05WgAIFrGuf3VkeLRTzDWN0Po=;
        b=L7RaHhsSKsXosswu3wXdWufSUUg3CfskpN/TaYgjCvSi7EvOCG9A99xw2q6b9ZjdTa
         Xt7EJ/0lEOrBZ6TgD4elQYq3YpXCce8p9eOjo6eRZt6ML8pqgA2iLfGokwYjk04odybC
         EwFYNbiCbs0gVHqED/E906ddHHzY0RhbuIoXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8Vb8qpSXm8bzNNepx05WgAIFrGuf3VkeLRTzDWN0Po=;
        b=ZE3qujcO9lhZtElrtS5tenaYmpPo4NCHQjzx5d3iEPOcZE86AUSBKRlyAdRWaYotxH
         xdDv73xxPGHeFzukhAzbafnBhSCtqIHX2EyqUG1EDKvfbyDGvjPtoAHXbBKYFFhEoy/p
         W0KCn4HBSXeWe1RG4DzbLHXIHjKdzApXV/1pXKX1u0vp3m2fBjuTJJAilaBhJUVZiOO/
         iUML03ipuZA7V5BlNSGkZgXdh8rHCRcVS7BfRXjgtXySBbDhUEkN9xeqkW554VvcIofX
         VffskJao122+JSHT7sFFoQ/r8QcQTTakNLd4guDVZVkUciPXgGYV3nO6Z7C4AOEu+FOV
         A8BQ==
X-Gm-Message-State: APjAAAUdAuJvy497uI5scYGnt53r7GA8aT+vNw1JOvwOFDY/CDXH2zvS
        B+wf7p4o+SR5Tx6ogA/dAM0rmyO9eg9x/52xrKkyog==
X-Google-Smtp-Source: APXvYqzceGFjArRnoeJHnuX4OEFDzzPJuFPFXVCB5sHuc4jX9G20ZUyeENpQbE3oYvL5aXyhnj2TKRFedR8im7K5tbs=
X-Received: by 2002:a9d:5788:: with SMTP id q8mr2137440oth.237.1559316240561;
 Fri, 31 May 2019 08:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <a03795e66ed45469ac5b3c1b1d01c8ed33be299f.1559129225.git.vpillai@digitalocean.com>
 <20190531110820.GP2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190531110820.GP2623@hirez.programming.kicks-ass.net>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Fri, 31 May 2019 11:23:48 -0400
Message-ID: <CANaguZCxqsxmsF3pSvgT78bD9KC_qzqU1m2D6tg3KPUNJijdsw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/16] sched: Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I'm confused, how doesn't this break the invariant above?
>
> That is, all CPUs must at all times agree on the value of rq_lockp(),
> and I'm not seeing how that is true with the above changes.
>
While fixing the crash in cpu online/offline, I was focusing on
maintaining the invariance
of all online cpus to agree on the value of rq_lockp(). Would it be
safe to assume that
rq and rq_lock would be used only after a cpu is onlined(sched:active)?.

To maintain the strict invariance, the sibling should also disable
core scheduling, but
we need to empty the rbtree before disabling it. I am trying to see
how to empty the
rbtree safely in the offline context.

Thanks,
Vineeth
