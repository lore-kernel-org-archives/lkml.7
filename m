Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBDEC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984A52173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0AL3jX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfGSNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:44:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46176 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:44:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so17507029lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIJrSY1p95/MsWEaE7bAGnOykei78Y05wtdtPBhOFg4=;
        b=W0AL3jX5zTOxL9DepqDUU6ZdHhIrMnRem5hQE9UThu7jQhSVWr9rKTxFhogaVbp6Nv
         7jex5Baw0RDz+PuX9fWj/kSbnlUQ16H9pOhgSw0orspdOLAR7+m4Tu4VNwAx+aSGrgaM
         aYzAKMcSvrk+0WrIe5LODsnGEltc+/0oYpJ39v/w+AUCytj758eX9iKg+klnhJeXKLar
         GI7pUwv9uCed/aC8oraLLxJZz1poR44gyRUdDNjCZznhFKseNDi4RvT0h/Rv7d5cLVGj
         VtpVecnVLacXfJ0xC2BfyILp+AeJG4GVqnrY+ugMX2oWULk35t9LUIhDaiArwgFbbyy1
         3gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIJrSY1p95/MsWEaE7bAGnOykei78Y05wtdtPBhOFg4=;
        b=OsoL3xlx27QezYaNCV+344DUnqM0qEE7CsuOPSTWD3xqvSXe953cRlYznTUAQEPg8i
         ckgTyWRuBM4Ot7cBML3ylW8++pzOQvtTeu7MdPyLQDtO58N2HQ7jgU24BkeT63T4r655
         koDt/6EW9rD4NVScJlShcMCUSdpGxJMWzKYwEzCsmEPjxjUbiTYdXEvlou3ADF5J0dM5
         +uqWXt+1SeK9JnxMMgcK9knG/Fx4b07Gps8kN8WoHDWb/Yx7lImxurI2eYuMNjahQomR
         pV4IHDh9t2Zfifs/437SYmdt+QkG8znh+4o6E3AfJwVRHhbNq73HsnuPkLi8wv8XgGCd
         ysrA==
X-Gm-Message-State: APjAAAUkMspxtbejucYNDNFW5UMT6eDsi3gTumkI46IXMR6yyW2G0Lo/
        LENfv2qLajLVYyw3lAeN1DhV/HTrc/LqGQ/mL/AscQ==
X-Google-Smtp-Source: APXvYqxIetn0bFPAb8O6A3uiT6E/niez8Qm3FyhHW91muWr/TdqpX2j07MXDjZroPrMnvEL3UJzqcM89oPJNFMrZhPI=
X-Received: by 2002:a19:f603:: with SMTP id x3mr21568032lfe.125.1563543895895;
 Fri, 19 Jul 2019 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-3-git-send-email-vincent.guittot@linaro.org> <20190719125124.GH3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190719125124.GH3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jul 2019 15:44:45 +0200
Message-ID: <CAKfTPtB0Vx9ZJ3dora0U_+B7VGzG2+zM2=T0WdnWF-Wo+2TRDA@mail.gmail.com>
Subject: Re: [PATCH 2/5] sched/fair: rename sum_nr_running to sum_h_nr_running
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 at 14:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 09:58:22AM +0200, Vincent Guittot wrote:
> > sum_nr_running will track rq->nr_running task and sum_h_nr_running
> > will track cfs->h_nr_running so we can use both to detect when other
> > scheduling class are running and preempt CFS.
> >
> > There is no functional changes.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7a530fd..67f0acd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7650,6 +7650,7 @@ struct sg_lb_stats {
> >       unsigned long group_capacity;
> >       unsigned long group_util; /* Total utilization of the group */
> >       unsigned int sum_nr_running; /* Nr tasks running in the group */
> > +     unsigned int sum_h_nr_running; /* Nr tasks running in the group */
> >       unsigned int idle_cpus;
> >       unsigned int group_weight;
> >       enum group_type group_type;
>
> > @@ -8000,6 +8002,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >
> >               sgs->group_load += cpu_runnable_load(rq);
> >               sgs->group_util += cpu_util(i);
> > +             sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> >               sgs->sum_nr_running += rq->cfs.h_nr_running;
> >
> >               nr_running = rq->nr_running;
>
> Maybe completely remove sum_nr_running in this patch, and introduce it
> again later when you change what it counts.

yes
