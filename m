Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15A20873
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llFcOTK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEGNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:55:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45456 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfEGNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so3352622lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GL4GdceTvSBDxGp9W+MspMxjOoV99Lda4j4e4jx38nI=;
        b=llFcOTK+JkPns+fb4NcOVv0q5GX/MkbEvLVrRcmQmQuLjeReEygm2oo4TQK2ESIoeC
         qpk+7qDr4E2vZHh/7r5kzvVev7KuXcBa94RdAlDSZP2KJ1Gt9mKrytjoRTEWRABSm1fZ
         2M02NrzjG4ijQ3/UySGQh39ERffrUwLnuy1nIvh+Q7uRXxsht53qaV3OwxnySPLs1LXb
         VG7PrdYlT+fKUQ2qDmc491dlWBX/1kNkD0W7E4VaZjRKEnDoKkCF8F3X+M3FU6bhgOvq
         MU8xYZ9sk/52vBJFW7GguZBMYBs6u4/tgJQqvutUuyLjJfmy3b2nMc0CGdCqbUtaVsII
         jd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GL4GdceTvSBDxGp9W+MspMxjOoV99Lda4j4e4jx38nI=;
        b=Sm+kV54U5xyxqAbeIdhLAYmTJOLbuMYf3lXvmKRSxHiRvteX3E3zQqmCwQdt6gN4v6
         ssZAa4rvMxCEnG0r3OpsNfur8evqwmVxxqtbK+mBB/7nY5tehWjFEVVA9QF6T31EGD/W
         KgDV7O680/Ns+KQvY3imnRGHu0bNzgmZjwtbxjWu+mWwRkbc9k1fDct0hSg3+Q62aMX8
         0IhawcmAwOmkd9uxajfhHFCpLiRGRThf1398++LJXzwCKdWp7Bia2+47eWT3NbMh4O9z
         9M5mc8Gd0PB7rZQ9l0xuFTKZtLf/bUk/5OMyeP3VCa/LL71gX8T4Dl7NjPu70OqXhGpU
         STog==
X-Gm-Message-State: APjAAAXT2Jt2A/yq3kokqGuivNxWLTA6bs9q3QlXwFQlwu1lkV0NsiC6
        DagbUq3Hz7fmEfl8zr/JSwHscbFQAcvSIUeectsugC7x7BI=
X-Google-Smtp-Source: APXvYqygTLTj7reqA2P0us3hcnaMnc/IWqpf8ylWxz0boCKxN0gY34MsJLpkYv35ahJhmIuRv+P6GjuHd0tle4CILho=
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr17526393ljn.147.1557237348745;
 Tue, 07 May 2019 06:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it> <20190507134850.yreebscc3zigfmtd@queper01-lin>
In-Reply-To: <20190507134850.yreebscc3zigfmtd@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 May 2019 15:55:37 +0200
Message-ID: <CAKfTPtAmekVR59pvBZO-Xp57=qHoxYkvmQwc2fWVa1x4U2_pNg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for
 asymmetric CPU capacities
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 at 15:48, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Luca,
>
> On Monday 06 May 2019 at 06:48:31 (+0200), Luca Abeni wrote:
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index edfcf8d982e4..646d6d349d53 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -36,6 +36,7 @@ DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> >
> >  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
> >  {
> > +     topology_update_cpu_capacity(cpu, per_cpu(cpu_scale, cpu), capacity);
>
> Why is that one needed ? Don't you end up re-building the sched domains
> after this anyways ?

I was looking at the same point.
Also this doesn't take into account if the cpu is offline

Do we also need of the line below in set_rq_online
+               rq->rd->rd_capacity += arch_scale_cpu_capacity(NULL,
cpu_of(rq));

building the sched_domain seems a better place to set rq->rd->rd_capacity

>
> >       per_cpu(cpu_scale, cpu) = capacity;
> >  }
>
> Thanks,
> Quentin
