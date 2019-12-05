Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D04C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8442464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rX1D/How"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfLER2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:28:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45734 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLER2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:28:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id d20so4472209ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eduv7g6PONqk9FLS25SFMrmQJW1nsYLLIzhL72oL1nI=;
        b=rX1D/HowH3FTy4uy/H4BL+yPYgOCtn63JhrlRYMemyMGDnEcMPLf141+Wu0pix+Tsv
         WPvI+UqWB5lPbmHRqTq62IdF5dx6x6W5Y7/TyutdiYvmBdEZGkYC+lUo14ECElLpllT5
         8BaSiXLt+wFhjOvEbLuyYo3aICXaqrvk5v/3uTDdlUoCbiYQkmUy14mnSOU2IV5vTiYa
         /SEvij05lwYUezUO4m5NK77dd0nHMk0sSLK5L2YSbM0gqs3dF3hqwiWTPVLjoiN1g9KS
         jv60oeOrcrLhJsLCdZqLVajYGUGbLLCz5+cygEKLDXWRsZP3e8os3fEaG5yqccq/8WBB
         Y45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eduv7g6PONqk9FLS25SFMrmQJW1nsYLLIzhL72oL1nI=;
        b=cZL7D2dwNj49GtLDDX8ex8bbt8M2qoMQoxeOHl9eN0HiiVYC0JkbcQsHk6FTGsFusi
         KzbVLRwD3b5R6d4AsphT8o0yyX8ThSZbEHta4jEi+j5UQqYI+lv3NEvinVH/y8WrwxHd
         k8FZDBMvRawCircqVwGk+n7998NTMZRmkpu5gsf62rrluk5fSRaEMmJKURvWBj8+/emF
         G2aLVJ8Kl1RvvN+Edn+6I9O3UEeR35ZSiOVraCknJ2ZX/RRQsOKBeubAC66b5q+NSKr0
         KJR3LiVjJPg55+GloLLKLM9uwEjxWaObUY7nHdCRK2yRLMJcn00yntO7FY0tpdkX83S+
         1PVQ==
X-Gm-Message-State: APjAAAXMLuH7PMwzdVdibdQbqGCtr23U+YTXkOccHliRaRyXhiWYZahg
        ccIzDbmVPIgxPWG2NYBZJYGgim3/HqcGCQUEKS/kEA==
X-Google-Smtp-Source: APXvYqyZwno5tasOWGdnhbFiG9AGoE0vW2mPP4E8IMZW/ClXPHrOQ0Ws1Qa5hzMAgOvyB+SOu5SBG09JJZMwGsmYKHg=
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr6582491lji.214.1575566882609;
 Thu, 05 Dec 2019 09:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
In-Reply-To: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Dec 2019 18:27:51 +0100
Message-ID: <CAKfTPtBH9ff=efTeJbM4UdzrHCXZs7wwn=pdE4As8pB859e++Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On Thu, 5 Dec 2019 at 18:23, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> Currently we loop through all threads of a core to evaluate if the core
> is idle or not. This is unnecessary. If a thread of a core is not
> idle, skip evaluating other threads of a core.

I think that the goal is also to clear all CPUs of the core from the
cpumask  of the loop above so it will not try the same core next time

>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5709ff..b9d628128cfc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5872,10 +5872,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                 bool idle = true;
>
>                 for_each_cpu(cpu, cpu_smt_mask(core)) {
> -                       __cpumask_clear_cpu(cpu, cpus);
> -                       if (!available_idle_cpu(cpu))
> +                       if (!available_idle_cpu(cpu)) {
>                                 idle = false;
> +                               break;
> +                       }
>                 }
> +               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>
>                 if (idle)
>                         return core;
> --
> 2.18.1
>
