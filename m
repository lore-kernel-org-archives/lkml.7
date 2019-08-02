Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63140C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CC7216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1ySagA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393184AbfHBNTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:19:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35243 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393174AbfHBNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:19:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so52898822lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYlIJPvFssOK64x+am/xS2wZWcj/FM4eymxQYdJNO0E=;
        b=l1ySagA5Vavb8EysRzrgjml8hUDMlz1+OS0qxIY9MuS/t4+ISzmv+SatgRNkZes9N4
         NxBnY3tJ4i4w6lZXvX/wi3/LKGu49oc9XLvkdBGMC5vn4ZS0qjvfmYZiRqeGd8sOsnNq
         mzChlxS6LnKnDA804KT9bA2jzbFjy64GLuZ6qhFT32Yor75167thxtgFkXzHU2g6dN8m
         VhsG+JKQ8tDYXVTWdC+k4Jpdq3+3sPRfEC4a72mi0rku3noody1gCMEbSif5LhOTXOUJ
         fD0tVWHzbs/PmTwRUALLRcWk5EVEdFTwixoUDVkEWxPKGH/IZmqHrMmlYXFFvL/omZC9
         PdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYlIJPvFssOK64x+am/xS2wZWcj/FM4eymxQYdJNO0E=;
        b=qXWltiyg8hKW7dESBkGE3kMV6KhQdcwiVuOABI+ysUrdOiBIrii2vKokEXNB7IR8sw
         2kieiL+x8Abv2mV1veKrnwV8r+1QIs6NxcV1Dm9S9rLLx2wxS3GesrIKOVh8WOA8lo0S
         v0CGTHuzDDm9e/pxa0aStUfrR9nbNRIMa4/VqvDoaT0yPoeIM8o1YSD2LrsiHqrL15zS
         Gh7wD5IF4HjQXWlj8pSM+J44DdZDOCToAVUmGlKI9SxUxMv5eJe1pUghv2dSd4E6kg2l
         k1WTkjnO7EApFKl1/ndIJ7CZ3doJFfn/W+YLGfc/wYtyth5lNbLGO1BYEN5CuUpU1uvh
         ++cw==
X-Gm-Message-State: APjAAAUlWeaTOCGOSDNzkvNegfSCkt8BpMLGqdTDlZ27V+uTKbaOEIYJ
        baeG+Rvl/cU65VCg5hZYxmdcTN2D9KSeQhI0mJ5niA==
X-Google-Smtp-Source: APXvYqz47bQkJowsL0czNkaKYpSnYdc6hiS5O1FqH5ObL6RyI/23H5A2jSTq1qZmoQtSLLA93qeYpvHJnfmT/d6Rg94=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr10642487lfa.32.1564751952808;
 Fri, 02 Aug 2019 06:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190802104628.8410-1-qais.yousef@arm.com>
In-Reply-To: <20190802104628.8410-1-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Aug 2019 15:19:02 +0200
Message-ID: <CAKfTPtDxuwhnSrHDK4hq86wEu2JP8OwXVb_TQbo5UL9D+fkoJQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 at 12:46, Qais Yousef <qais.yousef@arm.com> wrote:
>
> scale_irq_capacity() call in schedutil_cpu_util() does
>
>         util *= (max - irq)
>         util /= max
>
> But the comment says
>
>         util *= (1 - irq)
>         util /= max
>
> Fix the comment to match what the scaling function does.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

FWIW
Acked-by:  Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 636ca6f88c8e..e127d89d5974 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -259,9 +259,9 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>          * irq metric. Because IRQ/steal time is hidden from the task clock we
>          * need to scale the task numbers:
>          *
> -        *              1 - irq
> -        *   U' = irq + ------- * U
> -        *                max
> +        *              max - irq
> +        *   U' = irq + --------- * U
> +        *                 max
>          */
>         util = scale_irq_capacity(util, irq, max);
>         util += irq;
> --
> 2.17.1
>
