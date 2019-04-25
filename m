Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF7C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A5F218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNiyrxKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbfDYDPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:15:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40739 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbfDYDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:15:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so5507296lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+Wa4CNacz7cfEZTyoG1CeJ1cikij3QMnhVi8x3t1b4=;
        b=GNiyrxKKAUbGnY0S3nMtyLScCEyeMDRpLrWTHw3KPXvI87ij64s6qVx5om9C028UFo
         cJFuVJ9TlMYwKiJJSa40XpZhr8QLAneXn/k+pIi1bqlrYksvUyc4BgQjxDRhyu9UrUEH
         Pl8mWFxfnK3pjWR1SA2vdtVQQ1XLEfOHUCMvO2EDk6AHWqORDhX4NOgMafnohxr2XGH6
         vaGmOmhrwZn9A9HTDaarH95m9hvVUaNmONHB1Ma10WL8ji7sc6TP0hARvj9z+ElMWjJt
         Eh4NWAe2HAK8FQKPPrKoFnFOC2w5mFPTCp4vpYCMJ8VY2rdXARFmFkum3bG+sLPIWH0G
         BAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+Wa4CNacz7cfEZTyoG1CeJ1cikij3QMnhVi8x3t1b4=;
        b=PmIFtE1cJjlLjjq0L+TddnlibeumnPJabJpHK5kZEjbHN0Z09LNYxWdSI+a7ABTM8d
         Mt48TThMRgcLInmm/iBrMJmJ7lVzvjAnyUdd0P2G+GOhe5vyuZcrYQSX8utrRdsbnmGc
         GbWGsazyZiy0mpENnC+qhMhTY76XbnXNuLE9mLUj6Ax4//0UPb8xGd9GY3IuDy84FUrM
         4hS67kT3pLlEB0uIlD/T+88dfMDKKyuPN2/5jfj2AtGur10OFLRq41H1BQ1olqQNa3Ry
         xYFsjF5hCWnJra+VD6AD+D09lC8L6K+ps439nRiiitGdAVADNLlNXbDuH7uuyF9r38u9
         vmuQ==
X-Gm-Message-State: APjAAAUusmWG+Ug5Ly1PKAupc+TcwJ3qZTrPJMeKMPh57DxNcR3jjJT3
        QdYqZb6xim8eLxGu27m48ef00N8Yw2uoKqdV+k0=
X-Google-Smtp-Source: APXvYqyXMTforawxalfSCSNARq8MGn6MektaSYGL0hZr13LCTqTzU7qeyJA5fGfJBM/JpE22d2b7B+2jNNsgM2u/wKs=
X-Received: by 2002:a19:c113:: with SMTP id r19mr19471920lff.64.1556162119935;
 Wed, 24 Apr 2019 20:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com> <20190424140013.GA14594@sinkpad>
In-Reply-To: <20190424140013.GA14594@sinkpad>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 25 Apr 2019 11:15:08 +0800
Message-ID: <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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

On Wed, Apr 24, 2019 at 10:00 PM Julien Desfossez
<jdesfossez@digitalocean.com> wrote:
>
> On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> > On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> > <vpillai@digitalocean.com> wrote:
> > >
> > > Second iteration of the core-scheduling feature.
> > >
> > > This version fixes apparent bugs and performance issues in v1. This
> > > doesn't fully address the issue of core sharing between processes
> > > with different tags. Core sharing still happens 1% to 5% of the time
> > > based on the nature of workload and timing of the runnable processes.
> > >
> > > Changes in v2
> > > -------------
> > > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> >
> > Thanks to post v2, based on this version, here is my benchmarks result.
> >
> > Environment setup
> > --------------------------
> > Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > cgroup1 workload, sysbench (CPU intensive non AVX workload)
> > cgroup2 workload, gemmbench (AVX512 workload)
> >
> > Case 1: task number < CPU num
> > --------------------------------------------
> > 36 sysbench threads in cgroup1
> > 36 gemmbench threads in cgroup2
> >
> > core sched off:
> > - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> > core sched on:
> > - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> >
> > Due to core cookie matching, sysbench tasks won't be affect by AVX512
> > tasks, latency has ~28% improvement!!!
> >
> > Case 2: task number > CPU number
> > -------------------------------------------------
> > 72 sysbench threads in cgroup1
> > 72 gemmbench threads in cgroup2
> >
> > core sched off:
> > - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> > core sched on:
> > - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> >
> > So not only power, now security and performance is a pair of contradictions.
> > Due to core cookie not matching and forced idle introduced, latency has ~12%
> > regression.
> >
> > Any comments?
>
> Would it be possible to post the results with HT off as well ?

What's the point here to turn HT off? The latency is sensitive to the
relationship
between the task number and CPU number. Usually less CPU number, more run
queue wait time, and worse result.

Thanks,
-Aubrey
