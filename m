Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB26C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A99208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHr9RG0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFYX5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:57:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41051 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:57:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id y185so133501ywy.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYYmoTlsMAXHE1sdf2TkcUfIalvt5FU+r7Wng7vtf2k=;
        b=bHr9RG0tkfub5JlEPuSlccDNn2kaBl57++YE4B9BvBAfrk/lrYZ49HU1Eo9gNT3ehk
         fNU3tQP8gui8q9wB/h1Fc81T9JFeVcZUyl03XKjJ8gOzY53YIyIzh/i5zII6JgrWgqIM
         lkO3DVg7MWoytL4Eb8VJIzvW8QcRR10rlGa08CISiQVyfr2JSdtGwciaMXKI87B1ul24
         1PRqHKieYqB7Sdn81jUAtFn5JbY1GfrO71H4sWFwdVdgOE9Ns1kODIziZwkcUyqk4eHb
         Lull0e5SzkFSpJ4SxrKHhM1n+liVt/Q1fOL4ylNWFL6BIl1nlhx95K+44HpmfXZQO1Ma
         7Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYYmoTlsMAXHE1sdf2TkcUfIalvt5FU+r7Wng7vtf2k=;
        b=sRB4XFHHGkGXXPlRZMoQL42ZmifMLjgNIndGrVmzL69tuxfyHzLgxq3eV4YG5En2Cw
         Ica8jfIxx4Y+HF8jUKPrbtfEO+DWNdyEPLxGjgbCy7gzgN7MwOKe59+GQtcdpVf5VC9I
         h2Z+yqiTc3in5T1Ohv3y99pdShc+Bb+BvutepJ4YWpSb8jLMwv8Nnxgi8x3xUjlJDo2A
         B8ckyYLOOpVBC2g78RqR5MlAh2MmiANXLenWcpSBBRwrPhHRMuGmU5SpUDW+7hHeb3SJ
         VNc/Ra3t5G+nX6LLjrEDEU6TpN4ujO9uc/UEEgyFvanRQVXWYpPCDyeGeZ+u0J5+V20i
         B3Cg==
X-Gm-Message-State: APjAAAUUF1MwdZ5/bQP6l6lNUpyd/YRZRwuHU2mFPP1QF3YNl70PYTmb
        lkgjAQblT6jdc91Xm9EoE8HZTLrCamvWwtcagKraRA==
X-Google-Smtp-Source: APXvYqwLaw1k639FvVXfSfGs08cOnJCQGJfxpqhknTwehsMkT1lTu3zMHVWSGjAgN0vQtarw8VCOzDn0TuQCrm+B3mU=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr978096ywh.308.1561507073185;
 Tue, 25 Jun 2019 16:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-9-guro@fb.com>
In-Reply-To: <20190611231813.3148843-9-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 16:57:42 -0700
Message-ID: <CALvZod7Z=q9YOGpWjv=EsORCy5dHAz+cDv=4qwD5V5xDv60QEw@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] mm: rework non-root kmem_cache lifecycle management
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> Currently each charged slab page holds a reference to the cgroup to
> which it's charged. Kmem_caches are held by the memcg and are released
> all together with the memory cgroup. It means that none of kmem_caches
> are released unless at least one reference to the memcg exists, which
> is very far from optimal.
>
> Let's rework it in a way that allows releasing individual kmem_caches
> as soon as the cgroup is offline, the kmem_cache is empty and there
> are no pending allocations.
>
> To make it possible, let's introduce a new percpu refcounter for
> non-root kmem caches. The counter is initialized to the percpu mode,
> and is switched to the atomic mode during kmem_cache deactivation. The
> counter is bumped for every charged page and also for every running
> allocation. So the kmem_cache can't be released unless all allocations
> complete.
>
> To shutdown non-active empty kmem_caches, let's reuse the work queue,
> previously used for the kmem_cache deactivation. Once the reference
> counter reaches 0, let's schedule an asynchronous kmem_cache release.
>
> * I used the following simple approach to test the performance
> (stolen from another patchset by T. Harding):
>
>     time find / -name fname-no-exist
>     echo 2 > /proc/sys/vm/drop_caches
>     repeat 10 times
>
> Results:
>
>         orig            patched
>
> real    0m1.455s        real    0m1.355s
> user    0m0.206s        user    0m0.219s
> sys     0m0.855s        sys     0m0.807s
>
> real    0m1.487s        real    0m1.699s
> user    0m0.221s        user    0m0.256s
> sys     0m0.806s        sys     0m0.948s
>
> real    0m1.515s        real    0m1.505s
> user    0m0.183s        user    0m0.215s
> sys     0m0.876s        sys     0m0.858s
>
> real    0m1.291s        real    0m1.380s
> user    0m0.193s        user    0m0.198s
> sys     0m0.843s        sys     0m0.786s
>
> real    0m1.364s        real    0m1.374s
> user    0m0.180s        user    0m0.182s
> sys     0m0.868s        sys     0m0.806s
>
> real    0m1.352s        real    0m1.312s
> user    0m0.201s        user    0m0.212s
> sys     0m0.820s        sys     0m0.761s
>
> real    0m1.302s        real    0m1.349s
> user    0m0.205s        user    0m0.203s
> sys     0m0.803s        sys     0m0.792s
>
> real    0m1.334s        real    0m1.301s
> user    0m0.194s        user    0m0.201s
> sys     0m0.806s        sys     0m0.779s
>
> real    0m1.426s        real    0m1.434s
> user    0m0.216s        user    0m0.181s
> sys     0m0.824s        sys     0m0.864s
>
> real    0m1.350s        real    0m1.295s
> user    0m0.200s        user    0m0.190s
> sys     0m0.842s        sys     0m0.811s
>
> So it looks like the difference is not noticeable in this test.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
