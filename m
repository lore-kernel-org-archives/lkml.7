Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B642073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdwU3Xji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfLDSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:16:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39055 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfLDSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:16:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so124763oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RJiGCVDVNvMUec0vnffC5xd6aiSG8EGa8XBGiB3SH6Y=;
        b=HdwU3Xjio6qVM797Gg+0rVHEecpKj//UQe7Ir9bm8Q6qKRO8u7PxKsO4EqIz9OOmNL
         qkxb6Mj1mCCzt8c6g0GAGfIpjUXDvKhIeokrXfalmO9WWUAc6jlEAMJqkL+gDG9UUrxP
         9o2un3BXIkbLY4IkAWXaEmeYv9bg2nTbVdzAwt9cZJdILY7tMP1FYT7m7P9dmzHZSLdK
         i0ySfs3obSahHJxIDjyUKlo77FqFOTcd3O7DCHqINZzyy57eFYx0T6JNh53HsrQqe6gX
         Il9wj6nwM9k8qXKPjDo/3pD/F4vr/fckjhJ4Px5c9rJC6DVNZDN9QwgeFZFM1Pqo66r/
         DR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RJiGCVDVNvMUec0vnffC5xd6aiSG8EGa8XBGiB3SH6Y=;
        b=qUEOkelf4i0/3n/0hMTvO6ZeHX70WDexemqFa8/ZhLBwrWydACDBiSz8wJboQi9FaI
         9WqLJ96TgUheGzp7ZmAg5PRP9Jb6MQOgYPbHdQKcFdoiM28AHTVQh8jyZn9C1FrZfxqv
         mU4R8k/PNXUqzreaVyILl/1cY7YLqO0zREQaMn5pg6eD0Xiia0gxC2h+pXmPah6SudMP
         Ylp+TgX5/4e7v81rJGQNsTiLEUnF9PSqfhhlwlxaFHBJc72BgH1EXkO82DcpcVs4jMRm
         7+1EdswAYVGGA3Fs/lrHwyNgsXeW5jeQTTvmFMJNHQW6XiD6JR+JOvKeqGaZcrByINSZ
         Oz1A==
X-Gm-Message-State: APjAAAUQ4XP1hRkiOI/ZDA7jal+LpVAxxV2IKwyKTpD9hvIzgWVwLtHL
        azjXwnh9Z754evCCAURMM/tRx+415BZk5kE6kC9GMg==
X-Google-Smtp-Source: APXvYqw3PWCM0wVvL9/6FyExQg2AyBx7rh8aobv8hkKHc/mdV9bLffMBbC21KnXrGEGKgVgVn+uV6PAjz4boZ5E3850=
X-Received: by 2002:aca:b588:: with SMTP id e130mr3680860oif.169.1575483406820;
 Wed, 04 Dec 2019 10:16:46 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com> <20191204100925.GA15727@linaro.org>
In-Reply-To: <20191204100925.GA15727@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 4 Dec 2019 10:16:36 -0800
Message-ID: <CALAqxLWCFNJzNvgrSKSs3s42O=D6EPmnvwPTWV_k-QH7v7VNtQ@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 2:09 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Le Wednesday 04 Dec 2019 =C3=A0 09:42:17 (+0000), Qais Yousef a =C3=A9cri=
t :
> > On 12/04/19 09:06, Vincent Guittot wrote:
> > > Hi John,
> > >
> > > On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> wro=
te:
> > > >
> > > > With today's linus/master on db845c running android, I'm able to
> > > > fairly easily reproduce the following crash. I've not had a chance =
to
> > > > bisect it yet, but I'm suspecting its connected to Vincent's recent
> > > > rework.
> > >
> > > Does the crash happen randomly or after a specific action ?
> > > I have a db845 so I can try to reproduce it locally.
> >
> > Isn't there a chance we use local_sgs without initializing it in that f=
unction?
>
> Normally not because the cpu belongs to its sched_domain
>
> Now, we test that a group has at least one allowed CPU for the task so we
> could skip the local group with the correct/wrong p->cpus_ptr
>
> The path is used for fork/exec ibut also for wakeup path for b.L when the=
 task doesn't fit in the CPUs
>
> So we can probably imagine a scenario where we change task affinity while
> sleeping. If the wakeup happens on a CPU that belongs to the group that i=
s not
> allowed, we can imagine that we skip the local_group
>
> John,
>
> Could you try the fix below ?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e..bcd216d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct =
task_struct *p,
>         if (!idlest)
>                 return NULL;
>
> +       /* The local group has been skipped because of cpu affinity */
> +       if (!local)
> +               return idlest;
> +
>         /*
>          * If the local group is idler than the selected idlest group
>          * don't try and push the task.

This patch does seem to solve the issue for me! Thanks so much!

Tested-by: John Stultz <john.stultz@linaro.org>
-john
