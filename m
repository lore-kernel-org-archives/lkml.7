Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627DDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953E20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slLLmfP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502954AbfJXO7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:59:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45924 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502933AbfJXO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:59:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so25365577ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbQMeJJ9T8fWlFqiHSQLTmNnq/8kdMOS/oIgpPAnuSg=;
        b=slLLmfP6q3EpXVFMzwJ0ES3wxJsTLqgTsMISi62sdBjEfrvp58m6xQcLvwxfTa5jj+
         Y7X5jtpavnHg72oFovsb+9+Gk+w5uSVAE/P2If9BiXuEG4iW/msDZcWGEexsPTZDb70G
         47jLnQDCGJ5KFVNa5VbKZd2+8QNLQNFt43TVm+hIE0xk0J9Rym0jnYINFDhBcDFuXR18
         Ccv8b3k4XV4FWt86LjsyV8+esnz/ATpT5oInnIDFhe78EZxfFU2pzK9GSo5DDz8pk9VH
         8cwt8ZvIJV+fOuWMLwO55SqKvmpHelfNmo8H0ngjitnSfNNhiGIHN9fQN734cn9hD23X
         gUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbQMeJJ9T8fWlFqiHSQLTmNnq/8kdMOS/oIgpPAnuSg=;
        b=AeZrj9kdaIvGE+xUal0z0PL6R4nAsbRUJPEahtLffMpsXDbI6i//PIsmFXGTnSAod+
         Q/Qb0tbM+4R8WirrcqnEjo4gATvkUik/6WHAneQFLGTbUVucm34m0IKyby9O89NilDxH
         eFX+7ViRUKSAK2Mft6yFzYd4rctGIDmHi5OGtrG1Bpuyw0hhokE++HZ+IYaUi6KNBWlt
         H8GZL23iF6N2MRkoOP+WcZIOWldR72L9OFg8djHxHcQr4tXRYp1fhVTs0bkftgig3vs0
         3IxeEC5u0OEoQt0XITqnxV9J+QyQLOxp7B9BymSVY5lCWJV9yrcHrQYbZ+UwJoUMcsLi
         E26Q==
X-Gm-Message-State: APjAAAUzCALhjQeCxQ9m/hwbXmpQ1Im/chFRyIpu77kXDaj+XKetCm4I
        QLOdCofKrn8CEdYAUfXzj1uVKNAvull6iqYlTOhbFA==
X-Google-Smtp-Source: APXvYqxwUacw9eEIksvXho6kjW10NGc5Ru7v55eIHAfb5TObudzVLJ6rPi6TEYfHLPZBJ/aHCkr3UMsIZyWZqVKgihg=
X-Received: by 2002:a2e:8987:: with SMTP id c7mr1657197lji.225.1571929156491;
 Thu, 24 Oct 2019 07:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com> <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
In-Reply-To: <20191024134650.GD2708@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Oct 2019 16:59:05 +0200
Message-ID: <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 at 15:47, Phil Auld <pauld@redhat.com> wrote:
>
> On Thu, Oct 24, 2019 at 08:38:44AM -0400 Phil Auld wrote:
> > Hi Vincent,
> >
> > On Mon, Oct 21, 2019 at 10:44:20AM +0200 Vincent Guittot wrote:
> > > On Mon, 21 Oct 2019 at 09:50, Ingo Molnar <mingo@kernel.org> wrote:
> > > >

[...]

> > > > A full run on Mel Gorman's magic scalability test-suite would be super
> > > > useful ...
> > > >
> > > > Anyway, please be on the lookout for such performance regression reports.
> > >
> > > Yes I monitor the regressions on the mailing list
> >
> >
> > Our kernel perf tests show good results across the board for v4.
> >
> > The issue we hit on the 8-node system is fixed. Thanks!
> >
> > As we didn't see the fairness issue I don't expect the results to be
> > that different on v4a (with the followup patch) but those tests are
> > queued up now and we'll see what they look like.
> >
>
> Initial results with fix patch (v4a) show that the outlier issues on
> the 8-node system have returned.  Median time for 152 and 156 threads
> (160 cpu system) goes up significantly and worst case goes from 340
> and 250 to 550 sec. for both. And doubles from 150 to 300 for 144

For v3, you had a x4 slow down IIRC.


> threads. These look more like the results from v3.

OK. For v3, we were not sure that your UC triggers the slow path but
it seems that we have the confirmation now.
The problem happens only for this  8 node 160 cores system, isn't it ?

The fix favors the local group so your UC seems to prefer spreading
tasks at wake up
If you have any traces that you can share, this could help to
understand what's going on. I will try to reproduce the problem on my
system

>
> We're re-running the test to get more samples.

Thanks
Vincent

>
>
> Other tests and systems were still fine.
>
>
> Cheers,
> Phil
>
>
> > Numbers for my specific testcase (the cgroup imbalance) are basically
> > the same as I posted for v3 (plus the better 8-node numbers). I.e. this
> > series solves that issue.
> >
> >
> > Cheers,
> > Phil
> >
> >
> > >
> > > >
> > > > Also, we seem to have grown a fair amount of these TODO entries:
> > > >
> > > >   kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
> > > >   kernel/sched/fair.c: * XXX: only do this for the part of runnable > running ?
> > > >   kernel/sched/fair.c:     * XXX illustrate
> > > >   kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> > > >   kernel/sched/fair.c: * can also include other factors [XXX].
> > > >   kernel/sched/fair.c: * [XXX expand on:
> > > >   kernel/sched/fair.c: * [XXX more?]
> > > >   kernel/sched/fair.c: * [XXX write more on how we solve this.. _after_ merging pjt's patches that
> > > >   kernel/sched/fair.c:             * XXX for now avg_load is not computed and always 0 so we
> > > >   kernel/sched/fair.c:            /* XXX broken for overlapping NUMA groups */
> > > >
> > >
> > > I will have a look :-)
> > >
> > > > :-)
> > > >
> > > > Thanks,
> > > >
> > > >         Ingo
> >
> > --
> >
>
> --
>
