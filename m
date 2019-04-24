Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C49C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C061A20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss4ONKJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfDXNNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:13:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41307 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfDXNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:13:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so14632823lfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARgXNmSzkKlmq4ccihD4uxhUoE7bnpwP+o6PZbdz4R0=;
        b=ss4ONKJ79o3GzVKbigUF93RJvnKdaG491YqDeMvXVGw/UkrtWyALvJ6F6xOWikFL+R
         Y+acTn9EtArMjWKysAhCHgnioWVlcq3Vsci7vxU61o+l+wiEXPMEYFO6qaLazINPyrBY
         U3nynF35GrshzIyjv07nILyDhbidMc+8ggR2+5RQFLMEfafIP6x6YKkphPH48WxGsvp7
         Y69nXi3TsNyNhYpSbHlp10JEx1ToBAGR7WxcyPnjyIQ6cYbUlpwM4oy6YutA/SJl9etg
         PTAT8YlaDi7NVPsis9STYT8alJAg5GFbnS/8Bpox3VEvkPSswnActSSXhvJWbEsVaynz
         Lkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARgXNmSzkKlmq4ccihD4uxhUoE7bnpwP+o6PZbdz4R0=;
        b=luqhOsJ/iO7tgSniQGK05UIUlkTK25vr8/LGkBTtPjOO/IrVzwVXIm+BZnCoQTOW1A
         ffHnDHmn1oVERfAmj1hDtxm8ufZJ7CVPV4HQoUgYoC4I99a48A6Q9xglOaJruweaEr/C
         mCNfyiXhWXnRWlm3d+vdjpv+tsb/+Tca63NNmiZXZ2gxrkRz8omr/I9bmZO0DVk48zPi
         TO6YnoyAqSqBpQyLU6HD0v5rD4FikDXiFcCJM9hWDTNygTEMswUS9RS0EsI7tHS/RoFR
         EdipUZP0IUJ8t5q2EvWNXLtTO07xyQE4PHj8Pk+lup1Lb2toYh49Za5Xr7/ZmMB3Vp80
         5Yew==
X-Gm-Message-State: APjAAAU/h22V+b7Q1XU6NgZNN7yye9NybZ5TB+E+1KnvIFYRGBiGmbCH
        KCnRRI9nXVtQ9oFifK8f3U1cvNnSgVlPeMATMXQ=
X-Google-Smtp-Source: APXvYqyp2hScGrJxAIZY7V6qxJNn/KmP4i4O5eg8gPsb0lsDKeaQvOImncy2k3lRQUBWmk5QPzG/bM0Z4DJhyXIV72c=
X-Received: by 2002:a19:f013:: with SMTP id p19mr16986859lfc.49.1556111601406;
 Wed, 24 Apr 2019 06:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 24 Apr 2019 21:13:10 +0800
Message-ID: <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Second iteration of the core-scheduling feature.
>
> This version fixes apparent bugs and performance issues in v1. This
> doesn't fully address the issue of core sharing between processes
> with different tags. Core sharing still happens 1% to 5% of the time
> based on the nature of workload and timing of the runnable processes.
>
> Changes in v2
> -------------
> - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105

Thanks to post v2, based on this version, here is my benchmarks result.

Environment setup
--------------------------
Skylake server, 2 numa nodes, 104 CPUs (HT on)
cgroup1 workload, sysbench (CPU intensive non AVX workload)
cgroup2 workload, gemmbench (AVX512 workload)

Case 1: task number < CPU num
--------------------------------------------
36 sysbench threads in cgroup1
36 gemmbench threads in cgroup2

core sched off:
- sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
core sched on:
- sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449

Due to core cookie matching, sysbench tasks won't be affect by AVX512
tasks, latency has ~28% improvement!!!

Case 2: task number > CPU number
-------------------------------------------------
72 sysbench threads in cgroup1
72 gemmbench threads in cgroup2

core sched off:
- sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
core sched on:
- sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863

So not only power, now security and performance is a pair of contradictions.
Due to core cookie not matching and forced idle introduced, latency has ~12%
regression.

Any comments?

Thanks,
-Aubrey
