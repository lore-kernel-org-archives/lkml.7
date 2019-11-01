Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89512CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590FC217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="WuU1Uc5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKAOD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:03:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43778 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKAOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:03:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id s5so8211643oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hj8GKgCi3LluAQfnCo/lc7oZI8RK+Wo9HkTBkn6GITg=;
        b=WuU1Uc5N14JJVuVokcInbaIfCOTAQV4VzRoY4bKLZlRkLtNIj1RLut2Iv6w11/8b1x
         fXQOK/+ZIuu6m2q4BxLvk7zWIjjUJ+CyV6HxKyf2xuX8dBCZV6h62BIUPs16o0pIdTz/
         se3RVfCzCeAphs7WruQsyEyUNlKFQ1gPzLMcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj8GKgCi3LluAQfnCo/lc7oZI8RK+Wo9HkTBkn6GITg=;
        b=cJVd/C11opT5OPMmJpH9W+hXXMVu1JNr08oeNFei0aEo8vs4vUZHRSTrx87dzsHGqg
         q2V1BxxI85NE635DS8ysEPDT9HRhIxv5FPAbInBJ4wskxL/Z318WWVF+fKvY/T+auY+g
         sdgcRTa9umuD9pNNdnzv113B2ujyQ+/pR9Oi7rk2B0E0ZOKbRJFGbLs3zMmLQQ6wHhzq
         bQzcXRynBULO+0AZ2bpZulVUMTrrsLcjb10/yNv/dGpOjcboXexfLw5Enlo9Uck6uXla
         X/WAcX2cG0eJYpbTDlZa6900ya6ZVkmrARFYRtU8ZNj8eneCNZ/WUPa7+p5m5r4LwgD/
         pzjQ==
X-Gm-Message-State: APjAAAUpIbZiwp2nW7HFCDs5co7a+G1JKsjPOZkh1n4YNm6hsoSIUdgi
        OE8PM+5vYk8WzqPDKnqyVFW51YPwDA/rofW0udv9ZA==
X-Google-Smtp-Source: APXvYqzJCMH3nVVKWqiBHFtrRY4ERXVRcubmhdg6GzhenDl8sJ6rXSxBmg9eRFacxgbJ/RM/+sDl4r88tsPT1VOYLxA=
X-Received: by 2002:aca:c753:: with SMTP id x80mr1970083oif.115.1572617004092;
 Fri, 01 Nov 2019 07:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com> <20191031184236.GE5738@pauld.bos.csb>
In-Reply-To: <20191031184236.GE5738@pauld.bos.csb>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 1 Nov 2019 10:03:12 -0400
Message-ID: <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Phil Auld <pauld@redhat.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
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

Hi Phil,

> Unless I'm mistaken 7 of the first 8 of these went into sched/core
> and are now in linux (from v5.4-rc1). It may make sense to rebase on
> that and simplify the series.
>
Thanks a lot for pointing this out. We shall test on a rebased 5.4 RC
and post the changes soon, if the tests goes well. For v3, while rebasing
to an RC kernel, we saw perf regressions and hence did not check the
RC kernel this time. You are absolutely right that we can simplify the
patch series with 5.4 RC.


Thanks
Vineeth
