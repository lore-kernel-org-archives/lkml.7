Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7BECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF7E20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jT6aYSk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfJASPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:15:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfJASPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:15:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so16672170wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgJCteJu2BcK46pwUgWjXEExK/YmgMP+ugfQEXB9MmU=;
        b=jT6aYSk+jwGRAiSBelGcOX1Hrdn93yDj1/lfZzRxeykwZggAXTFeMq3c/+HPhrYvf2
         zvOdnLS4BlOCJR458+IIiSWNr/dxPJd98W32wZ+i7HDNRWFYPsgdIULTvruamcI10VHd
         qKuE3elC5DgnLGe3EjB8i8BldmbM73xm4XfVAHbCIFV/UbXupvr5G7WUUHTN8KqjICwo
         AYIrp3AMWqbFkFMp3qg5GModhNJt0jMXx6KS63g9txBTJ+oJAon4/iqpzV0+Vxxn6rZl
         ntZ1Kcp3eoD8YHGo5umSyJwutTN24cO3uLR5JjsMtmxNlJG5Y4yKivznhJDxm5leYH7S
         6FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgJCteJu2BcK46pwUgWjXEExK/YmgMP+ugfQEXB9MmU=;
        b=O8niBRi8w1j+rOgG5goOUbmVRSr+v2muceSJApmyHM9CiEhD8Tyfd0UH2lQOw/E15X
         xiOA6+H/EZgpTMeMQOA0qN7Kf1V43d+MUddEDgpSQddAPgeW47cJBQjhe3dbPYAhZ/Ab
         t9DjWZosEfr2LjmNGq8Z1NvKz3sJb8GKoLkikNNmWNIWzYosugUyeiAV9Helcnxz73NH
         b0ZG0Clh98wGfwWF2ia/e4yQ5ztW6AE2M77DHeJTvkYZKPE5XqYvgvEuNq3HtGh18WiI
         1hYPzQ3BXmNKbbbBr1w0i/ozHjkW2oZLKuaf/dVgIs6gx5WZa5L3KPNWAmwU9jPF2ffO
         442g==
X-Gm-Message-State: APjAAAXZpl/DpZwtuE4c2Rx0Jx3QUurToh1ifA/jQ1WQvBx+S2JDoRcw
        4+AyAMTDmLyYWVhUPo9CX1fhxaFVSPbYID+4XEuDmA==
X-Google-Smtp-Source: APXvYqzcqO5Pq3kgDizzsdzSixi6NQ83JHy7bqSusFNzosiGFQnYz2xTI+ymA+EZ8oo/TrC+bHz00N1swRHz2cWlepE=
X-Received: by 2002:adf:d08b:: with SMTP id y11mr19827984wrh.50.1569953712760;
 Tue, 01 Oct 2019 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190928123905.GA97048@gmail.com> <CANcMJZB9UrMaJv6OiScZy2e2UFGFOJsFRar9RZUE9HM-00ZXGg@mail.gmail.com>
 <20191001071921.GJ4519@hirez.programming.kicks-ass.net>
In-Reply-To: <20191001071921.GJ4519@hirez.programming.kicks-ass.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 1 Oct 2019 11:15:01 -0700
Message-ID: <CALAqxLUHj8DdiKauwfobS4LzPphhmZdG=GP51zcQMQdmZf=rFg@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joelaf@google.com>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 12:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 30, 2019 at 04:45:49PM -0700, John Stultz wrote:
> > Reverting the following patches:
>
> >   "sched/membarrier: Fix p->mm->membarrier_state racy load"
>
> ARGH, I fudged it... please try:
>
>
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index a39bed2c784f..168479a7d61b 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -174,7 +174,6 @@ static int membarrier_private_expedited(int flags)
>                  */
>                 if (cpu == raw_smp_processor_id())
>                         continue;
> -               rcu_read_lock();
>                 p = rcu_dereference(cpu_rq(cpu)->curr);
>                 if (p && p->mm == mm)
>                         __cpumask_set_cpu(cpu, tmpmask);


Yep. Looks like that solves it!
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for the quick turnaround!
-john
