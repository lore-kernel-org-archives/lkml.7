Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B37C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D720866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtAzKB09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgABC2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:28:16 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37178 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:28:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so27952566ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGNxaewdrTbTzGKjmUA5ftF1ZGMSdAFvmL1IP1j8rRI=;
        b=MtAzKB09r6Y6cNzd1HZw6Qg4/cwNpGkFiJ7bv5/WSrk9GDJOYHnaIqfIuS0LJm37TT
         0FQMYaer0N1iEqFyZTvmIAHfWLfDDV+26FFjfIhO2cvmWzCNfGviz5BAbbg4PdYW4m+o
         BhTrBfU797iPijrDKOYsLmGuQnWS6gE9QAzd6oPZoQpdYpGE+KQYS8UXf0Sc8zcvBnsR
         FhUm4ZxS/k3Qom/tEULVxnGJTROncEjVLLYySwAGoGVW0yI9iC6yJ3ZHVA2TOfn/5abN
         trw/3s4ToQXe2fb19u10PP5uztQ6bhzqjm0EaeKhqyM3ujVEoKZ54M/MLj2/sNGt+FmW
         Lzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGNxaewdrTbTzGKjmUA5ftF1ZGMSdAFvmL1IP1j8rRI=;
        b=LOnp/yKSMTGoTUCBWi2nMH7/5timzfdGC6f65LBm3l8bQTAFCoKdY3w+YvVfaoOFcB
         8CjL1z7FhmwpbEYQKvqReu1EFVwcwrb+WuYEIFXYdiqBNTCEIPa3AEK3qOU6JIi/LI0J
         ukTFYY7hpe+Awz0TSkwGEnGil+zxYRBjzHB7oYMY26HvYslDMUYUrjC1/w5sRA/bRZoj
         SakalPh5m3coEVCAuMkhIBiI4joX+0UnPOqXW9j6wiKbuLIsj5jWLCAmr9P8R4oX2cPz
         6TLZpKCS4r7L35KuneZuBYoyHGopM0Ga+dkOlKqmaiRnQC3CgObi7u1usb58Qm1w4lqY
         kV4A==
X-Gm-Message-State: APjAAAXujLC5VesH6vwcBZroQaoizBlCifDDqDaioxBGe+AOpRPxNcyq
        OFIokzO1DhdFd75nVR7Ue85Tj5gv79iLT4auVMA=
X-Google-Smtp-Source: APXvYqxyMsFQw72nLr5YMKbtx1ho7BFvoNN0wfVOeQPoBGqrtjiGKTLYbTHSiZ1wdfJCXRvYWUtQX1oEVWtCny0ccas=
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr30923817ljk.112.1577932093904;
 Wed, 01 Jan 2020 18:28:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <20191031184236.GE5738@pauld.bos.csb> <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
 <84ccea513e4ff21bdd374af01574e4bf04946bb6.camel@suse.com>
In-Reply-To: <84ccea513e4ff21bdd374af01574e4bf04946bb6.camel@suse.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 2 Jan 2020 10:28:02 +0800
Message-ID: <CAERHkrs8VRiTmuCbxsHzgcLSu+DgaWsbaEKwE25neMstvorRNA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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

On Tue, Nov 12, 2019 at 9:45 AM Dario Faggioli <dfaggioli@suse.com> wrote:
>
> On Fri, 2019-11-01 at 10:03 -0400, Vineeth Remanan Pillai wrote:
> > Hi Phil,
> >
> > > Unless I'm mistaken 7 of the first 8 of these went into sched/core
> > > and are now in linux (from v5.4-rc1). It may make sense to rebase
> > > on
> > > that and simplify the series.
> > >
> > Thanks a lot for pointing this out. We shall test on a rebased 5.4 RC
> > and post the changes soon, if the tests goes well. For v3, while
> > rebasing
> > to an RC kernel, we saw perf regressions and hence did not check the
> > RC kernel this time. You are absolutely right that we can simplify
> > the
> > patch series with 5.4 RC.
> >
> And, in case it's useful to anybody, here's a rebase of this series on
> top of 5.4-rc7:
>
> https://github.com/dfaggioli/linux/tree/wip/sched/v5.4-rc7-coresched
>

In case it's useful to anyone, I rebased the series on top of v5.5-rc4.
https://github.com/aubreyli/linux/tree/coresched_v4-v5.5-rc4

v5.5 includes a few scheduler rework and fix, so I modified patch1/2/6,
patch-0002 has relatively big changes, but still has no functionality
and logic change.

0001-sched-Wrap-rq-lock-access.patch
0002-sched-Introduce-sched_class-pick_task.patch
0003-sched-Core-wide-rq-lock.patch
0004-sched-Basic-tracking-of-matching-tasks.patch
0005-sched-A-quick-and-dirty-cgroup-tagging-interface.patch
0006-sched-Add-core-wide-task-selection-and-scheduling.patch
0007-sched-fair-Add-a-few-assertions.patch
0008-sched-Trivial-forced-newidle-balancer.patch
0009-sched-Debug-bits.patch
0010-sched-fair-wrapper-for-cfs_rq-min_vruntime.patch
0011-sched-fair-core-wide-vruntime-comparison.patch
0012-sched-fair-Wake-up-forced-idle-siblings-if-needed.patch

I verified by my test suites, it seems to work.

Thanks,
-Aubrey
