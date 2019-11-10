Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE8C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D198B21848
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBl2Q626"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfKJPN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:13:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43519 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfKJPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:13:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so11043350ljh.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcuaDzTn5xcx3GvRhEsUKRkdeQxQHVuFzpLwf2zUomU=;
        b=ZBl2Q626uvo+qPgSkpC2cJabVplXCzF78qFmX7LeouV/27Y6uldo66xhfgL/qXiOhk
         17GqrrfVdKaUU1PoYyKk4nMu2eq6FFgl+yLOvHDNmV5GLe4sVR4aPLHfyFzlGGN3ZrrM
         bGXRBuUCBQvqjEkF+rNkbjPgNxxrSgamRzUbgmmuv9CtRvJ16YmjQyxzmgLKJu0Y0md7
         k7hahzuHJzZwjt5U0/+qSjoqJ6GYNjTLUwKNEMfspSvEcSqvns/YMBelHzfKpKaoJxaf
         30YfYrheitZ/0MXy1KapL+0m2lBWQVURjwT9VWd7aDHupaJTytnxu+OcMPLP9IXfAhm3
         pN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcuaDzTn5xcx3GvRhEsUKRkdeQxQHVuFzpLwf2zUomU=;
        b=MUDWZDgUb+NFdllC+RJJYVca64Tpa2fDqrOH2Er0q8jzZ3DwKc2E+BbpCF9fdZ7d9I
         rZBl/exjou7JpMB0qnZj3Xc5qVUzhLU5Gr++vKpzqHBRsdTqm2AfrcLbu+1srFU3voW3
         0XGgBn5UPZ9KmemVd75L5Wpjo9ABEqnnKNnoIxsutbAKc6vNYPiSr9q1f/LscsqzH1bm
         1WWfDe7Pyd7pgKUpB+8Xoy4yv2TUNLPZY124ZGTiOlRCNtRKh2i6O6hJYllXoS2JojGP
         Jj0p+PXAVhNCWz2SCltTWBQxyv7L90cibPNJgXblyqdBgX8l3vypKMGKmhDDO27HzoPC
         xr5A==
X-Gm-Message-State: APjAAAVfi233FY0bcW95xZ3b6U/rAWO96JhRLBn7jdu8fjk39eSEQuxL
        xSXtLmHRnrn0GVk2llwUVWCfwN3blQN4VHE4oPhhZQ==
X-Google-Smtp-Source: APXvYqz4nQCQX2bf/HJVWQsssPaerxtaX085BJbf2h0MeAOyO8y6e4BeuELkHjJPLJ9vPB+D8crG16Tsaxzu6xA3ARE=
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr12768619ljo.193.1573398805894;
 Sun, 10 Nov 2019 07:13:25 -0800 (PST)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029160210.GA8343@linaro.org>
 <000001d58f2a$fc593200$f50b9600$@net> <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com>
 <20191108091834.GA24402@linaro.org> <000001d5971d$57a90c80$06fb2580$@net>
In-Reply-To: <000001d5971d$57a90c80$06fb2580$@net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 10 Nov 2019 16:13:14 +0100
Message-ID: <CAKfTPtA6+stq0heDa6r29Tyi2D9qEX9KZRcR8J0qw3vp6mdcMg@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Sat, 9 Nov 2019 at 17:47, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Vincent,
>
> Thank you for your item 2 patch.
>
> On 2019.11.08 01:19 Vincent Guittot wrote:
> ...
> >> I have to prepare a patch for this part which is item 2
> >
> > I have finally been able to prepared the patch for item 2. Could you check
> > that it also fixes your problem ?
> ...
> > We can still have some spurious call to cpufreq_util_change in
> > update_blocked_average() with this patch but at least the value will be
> > up to date in both calls, which was not the case before. If this fix
> > Doug's problem, I can prepare an additional one to fix the spurious call
> > but I wanted to make sure that this fix the problem first.
>
> Yes, the issue is solved with this patch.

Thanks for your tests

> I do wonder if I am seeing the effect of the spurious calls.

I don't think so because the spurious calls are in fact a 2nd call
during the same update_blocked_average and from what i have seen ,
intel pstate driver filter call when there is less than 3 or 10ms
between the 2 calls

>
> Details:
>
> Test 1: an 8000 second trace during system idle:
> Maximum duration: 4.00015 seconds. Good.
> Typically, there would have been about 300 durations
> of over 10 seconds in 8000 seconds.
> Number of calls to driver: 103168, which is about 8% more than
> the previous experimental solution.
> (Should be repeated a few times to verify repeatability, but
> not going to.)
>
> Test 2: one 8000 second energy sample, for high accuracy idle power:
> 3.703 watts which is about +0.7% idle power increase.
>
> Test 3: The load-no-load test with only idle state 1 enabled:
> There was never an excessive energy sample for the no load samples.
> The test ran for about 8 hours.
> Maximum: 9.49 watts
> Minimum: 9.13 watts
> Recall that with the issue, the max would have been about 14 watts
>
> Kernel: 5.4-rc6 + your items 1 and item 2 patches.
> Idle governor = menu, because teo fixes are still pending.
> Note: some reference data is from kernel 5.4-rc2, and really
> should have been re-done with 5.4-rc6 as the baseline.
>
> ... Doug
>
>
