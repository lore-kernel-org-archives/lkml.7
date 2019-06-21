Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B78C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997AC2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRkK4+v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfFUHUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:20:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33973 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFUHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:20:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id a128so4026763oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMhJ1n4qOdtBd/fX0oiTCQ/7TMu0IHm4BE9A21n2lt4=;
        b=BRkK4+v8VVQ1hYjK43YeflGS1uxzyu0aZIt1GSzeQuVKxYcSSTQzAuwV5p1nSPPtrh
         IdalGPmmQjUbiPxsL7xUNeR9FruGaC7W3wsHBkcJi6q6oFz9yJ94q1GGnBEHSaNINCSq
         zekEVDOTttB1y+o+9qQeHAHf19xBgQqTVvmROBGUHhNoZl8jzJXC7h9WidFvmE5MVSOz
         ujmQw+fPIqzUNdkRejpm782phwWKH3xy4AEwvy3nSFuhN+he5YbQE0RFocRWAvScO4C6
         3brCHXTTKo/ppIa/am1Wa3dgL5aQA0b5U3tjNNnzA7aGLl3Saqp9SfoNXJJ2Y7vf3Z/n
         a7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMhJ1n4qOdtBd/fX0oiTCQ/7TMu0IHm4BE9A21n2lt4=;
        b=M22ehMlE2rp/L07A11sFEijm7ZzsfpUGdRV4PjWZ2WiZZAiNCQLyi/sgWAhex7HMwo
         ix/Is9ibPCoB7e6MyTsGu+X1BUzF1H64RCjymeWckGUqlk8fPl+PNduFDMzkQcmb5Ruq
         48GMpSzkK53GbS8GGiMTMF2HZkfoQ3D7jMm2m+orhtmjl2qB7JCP+FTqvB/E6kZmp8l9
         WWNA7DImIYudcef0yubetidq8Zss1H/0oCSRZM3ByKHmuaqpdkxop0uNkQGP9xS7S02p
         VeUa+3bfEl5YxWNwaH9nv7QXJ5Mz0hQaW0x262mtAgxiWZZqs8ZWzgIU4RIrpzosPdEX
         Z0cA==
X-Gm-Message-State: APjAAAVIJl/CfefKWZc+m3VVOcTs4OWpuZi4OQOttSyfUs2xICpTFAsm
        V5aNmOEvnNyAZYUoMmBW34i5euVJECVdXsBPFwM=
X-Google-Smtp-Source: APXvYqyQdpCbmT03bH87iRjoaZkomb+caFAYsy5/Rv4fmw9uCFmXPqA2aVDhhFEeq5vU0pQi0lUH5GIMnwR+uS+n6lE=
X-Received: by 2002:aca:b9d4:: with SMTP id j203mr1805994oif.5.1561101641950;
 Fri, 21 Jun 2019 00:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561080911-22655-1-git-send-email-wanpengli@tencent.com> <20190621065842.GF3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190621065842.GF3436@hirez.programming.kicks-ass.net>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 21 Jun 2019 15:21:54 +0800
Message-ID: <CANRm+CxvtjbhoGtwzK64VcBFVpEnoPFaicvbQx5isc2Wdno+MA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/isolation: Prefer housekeeping cpu in local node
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 at 14:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 21, 2019 at 09:35:11AM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > In real product setup, there will be houseeking cpus in each nodes, it
> > is prefer to do housekeeping from local node, fallback to global online
> > cpumask if failed to find houseeking cpu from local node.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>
> Looks good; did it actually work? :-)

Yeah, it works! :)

>
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 63184cf..3d3fb04 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1726,6 +1726,20 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
> >
> >  #endif /* CONFIG_NUMA */
>
>
> Please double check this function; I wrote it in a hurry :-) Also maybe

So smart. :)

> add a wee comment on top like:
>
> /*
>  * sched_numa_file_closest() - given the NUMA topology, find the cpu
>  *                             closest to @cpu from @cpumask.
>  * cpumask: cpumask to find a cpu from
>  * cpu: cpu to be close to
>  *
>  * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
>  */
>

Will do in v3.

Regards,
Wanpeng Li

> > +int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> > +{
> > +#ifdef CONFIG_NUMA
> > +     int i, j = cpu_to_node(cpu);
> > +
> > +     for (i = 0; i < sched_domains_numa_levels; i++) {
> > +             cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
> > +             if (cpu < nr_cpu_ids)
> > +                     return cpu;
> > +     }
> > +#endif
> > +     return nr_cpu_ids;
> > +}
