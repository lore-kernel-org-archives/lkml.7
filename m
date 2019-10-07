Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5047B205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ki0dU7/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJGP1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:27:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46659 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJGP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:27:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so14114751ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuSSAKxVjo4ULUMqCK9nbWGblBOBwgw2OMwaKqEWY1I=;
        b=ki0dU7/QpkUKFEP+2XbFUIDoX367Pt75Dh80mCFt5AvFdgL/8/7vNypIrJBG84c7di
         SbsVdaGEtaJi0h94Xr02vTz4icSDTbgbbBRW69ohW4kV5MtXUVBh/jcf+x7ka1eQLwwa
         fGbdcZFrU4QmkWG+aXgViNVFsTDr8lWNkT61TNiQ1ssZR/XlF9oUXQP8lamVx2PLneQ/
         UTkwnUnKkLSgXqfHyllNmngaQMSscB9ei/i8ti/yvOAz5Fo3sQF01Cbh6Dxc8sLBnG5x
         1hEg0rq2hfbdrrX/VRaly7XDvOT2iCb7rCSZf/QtMm1sEHzz0/r5Vb/pXa4uhi0dRlZ2
         X4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuSSAKxVjo4ULUMqCK9nbWGblBOBwgw2OMwaKqEWY1I=;
        b=AQwHsjZ1YkcI1Jf1ObBHa3LkpQG/TIkuOfbfew6H0fI6csvXGFwJH/cQ6+qdeT9ujW
         Zo9+6N17l6AQjiZcw0jvik3/DABebJR83RdOr6SQgC95WOkc0aCizmBHiH7esZN2fY1F
         BMoYJoN9XWjXgiX0WYU3o1M+Yw2MKEt34xST5VFukrCLA24Hspfh1mRft6y3dSC+wDj7
         voFxVYnHY4nzQGJvR5kIbPY83zaHuVO/wRZgGxucE5kH2klmaMyXQpx9KmqlMi3Za/5N
         fOi/16Wge7YhI5RK4G+iswIIzWKTHh5BBWIIz6AEc0kdrmuHbdV5KWthcjSUu6KhJdPQ
         lUjQ==
X-Gm-Message-State: APjAAAUHqJyzs7vZ4+BnOWtKM9LZUCz0bZtL4CSlXPq7zD4ncygJKHt8
        QXWSOBrrTN6hoXV/uyNz+vaJYYCw8/jUCOzvZ4fX8A==
X-Google-Smtp-Source: APXvYqy3Zrut0RO25qVsbR7qSjjP0G1xChVlgmy5xLOhudQGjrOEwFXYinEbrBfV2lyhq5mRzFV5jcrdKb5mbT5qfdY=
X-Received: by 2002:a2e:551:: with SMTP id 78mr19319941ljf.48.1570462041808;
 Mon, 07 Oct 2019 08:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-10-git-send-email-vincent.guittot@linaro.org> <bc879bcb34f089e5888f6721aa2365f0832b69da.camel@surriel.com>
In-Reply-To: <bc879bcb34f089e5888f6721aa2365f0832b69da.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Oct 2019 17:27:10 +0200
Message-ID: <CAKfTPtA763zLxToVJpOCKc8TAgD3aZwpwhMZbbzrKiok+UHFaA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] sched/fair: use load instead of runnable load in
 wakeup path
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 at 17:14, Rik van Riel <riel@surriel.com> wrote:
>
> On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> > runnable load has been introduced to take into account the case where
> > blocked load biases the wake up path which may end to select an
> > overloaded
> > CPU with a large number of runnable tasks instead of an underutilized
> > CPU with a huge blocked load.
> >
> > Tha wake up path now starts to looks for idle CPUs before comparing
> > runnable load and it's worth aligning the wake up path with the
> > load_balance.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> On a single socket system, patches 9 & 10 have the
> result of driving a woken up task (when wake_wide is
> true) to the CPU core with the lowest blocked load,
> even when there is an idle core the task could run on
> right now.
>
> With the whole series applied, I see a 1-2% regression
> in CPU use due to that issue.
>
> With only patches 1-8 applied, I see a 1% improvement in
> CPU use for that same workload.

Thanks for testing.
patch 8-9 have just replaced runnable load  by blocked load and then
removed the duplicated metrics in find_idlest_group.
I'm preparing an additional patch that reworks  find_idlest_group() to
behave similarly to find_busiest_group(). It gathers statistics what
it already does, then classifies the groups and finally selects the
idlest one. This should fix the problem that you mentioned above when
it selects a group with lowest blocked load whereas there are idle
cpus in another group with high blocked load.

>
> Given that it looks like select_idle_sibling and
> find_idlest_group_cpu do roughly the same thing, I
> wonder if it is enough to simply add an additional
> test to find_idlest_group to have it return the
> LLC sg, if it is called on the LLC sd on a single
> socket system.

That make sense to me

>
> That way find_idlest_group_cpu can still find an
> idle core like it does today.
>
> Does that seem like a reasonable thing?

That's worth testing

>
> I can run tests with that :)
>
> --
> All Rights Reversed.
