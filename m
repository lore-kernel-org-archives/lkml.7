Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30D922521
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeVpR9kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfKTNWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41893 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfKTNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:22:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so20160545lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+fEJbvQrRlIm5amKPzgTUOGJYAL/QTXwvIMqIsCMxs=;
        b=zeVpR9kG6RhnlC8g9BSHP0NoAGUkP0qwAhYse80QhwQEO6r7B8jxxhqmB5Q6bfYZeZ
         AgpzRHSe9SIixtqeUib5xE/5a1qMnlyt6CMEONaOGWj8qZM7Zs4I02BkAtdmXlSilAN7
         9q/5a8dArRMysT+xLuyY2qLNGzmedUiUwLxw7ddXPDHzXrloXK3YcFtSznkJXTLK4waV
         tMiPH1SSNToVlctcX7SsM8Gapk7LtK0eFL8+kj4eJId5ENquQcfkf7wMBCMmbro6v/3n
         tUSBHQowhVnEsHjj1mGo2zRZ/8DOZ3PpiDjXrJXTxZsu19VoLQ2d/HdAuF8Dj5gxl5Lh
         RT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+fEJbvQrRlIm5amKPzgTUOGJYAL/QTXwvIMqIsCMxs=;
        b=uoI6F6FizlWqMeMLtsgxZjMAkJe7stAs1dvTv1k5aqLuNXSXQd/FbFOI8RKOSkeXEO
         jr6yB+bEg4csVOv5bMFQa9DKf53o+mZPmJKCoGyexKKUl11ovH09U5QGQb4u/Dz+z/Ni
         XfCd5CHPmOuARzeqA2qiEJLJKZaH91cRig2uKCzBwxlveCwGuXttlDjEFHeDq4z7dekZ
         xI+ooRBzNCHUh+qQU6eZVTAdmTRQI1QSgQuy7Ggnr+ybQFQlC9JEN/9j16ue1gSZ2TGq
         j+M6aeL57h3PWoh+pQcfQLiB6A//9nS7/1bsyGbfhay9T4Sn1tsfq2+deQP+mA+0TxSd
         eYxw==
X-Gm-Message-State: APjAAAUa+a0OWZeVVvNZ3Qs/27XMTaoXG8N9hEKK/tjL3RRypPkX5sM0
        7+yFQLly6icW0CiEtxUbQ90NUN793ksX5B2KpCU3jg==
X-Google-Smtp-Source: APXvYqz8CxhCRLYddnfjVTSQgo8beMaB6Nzl5wwRbrHMcgPVWoIqlwpus9VXBCQ5Izt8ZswxCNmORREYFDkHLw62w/s=
X-Received: by 2002:a19:c144:: with SMTP id r65mr2806460lff.133.1574256128135;
 Wed, 20 Nov 2019 05:22:08 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org> <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Nov 2019 14:21:56 +0100
Message-ID: <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
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

Hi Qais,

On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> On 10/18/19 15:26, Vincent Guittot wrote:
> > The slow wake up path computes per sched_group statisics to select the
> > idlest group, which is quite similar to what load_balance() is doing
> > for selecting busiest group. Rework find_idlest_group() to classify the
> > sched_group and select the idlest one following the same steps as
> > load_balance().
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
>
> LTP test has caught a regression in perf_event_open02 test on linux-next and I
> bisected it to this patch.
>
> That is checking out next-20191119 tag and reverting this patch on top the test
> passes. Without the revert the test fails.
>
> I think this patch disturbs this part of the test:
>
>         https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c#L209
>
> When I revert this patch count_hardware_counters() returns a non zero value.
> But with it applied it returns 0 which indicates that the condition terminates
> earlier than what the test expects.

Thanks for the report and starting analysing it

>
> I'm failing to see the connection yet, but since I spent enough time bisecting
> it I thought I'll throw this out before I continue to bottom it out in hope it
> rings a bell for you or someone else.

I will try to reproduce the problem and understand why it's failing
because i don't have any clue of the relation between both for now

>
> The problem was consistently reproducible on Juno-r2.
>
> LTP was compiled from 20190930 tag using
>
>         ./configure --host=aarch64-linux-gnu --prefix=~/arm64-ltp/
>         make && make install
>
>
>
> *** Output of the test when it fails ***
>
>         # ./perf_event_open02 -v
>         at iteration:0 value:254410384 time_enabled:195570320 time_running:156044100
>         perf_event_open02    0  TINFO  :  overall task clock: 166935520
>         perf_event_open02    0  TINFO  :  hw sum: 1200812256, task clock sum: 667703360
>         hw counters: 300202518 300202881 300203246 300203611
>         task clock counters: 166927400 166926780 166925660 166923520
>         perf_event_open02    0  TINFO  :  ratio: 3.999768
>         perf_event_open02    0  TINFO  :  nhw: 0.000100     /* I added this extra line for debug */
>         perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )
>
>
>
> *** Output of the test when it passes (this patch reverted) ***
>
>         # ./perf_event_open02 -v
>         at iteration:0 value:300271482 time_enabled:177756080 time_running:177756080
>         at iteration:1 value:300252655 time_enabled:166939100 time_running:166939100
>         at iteration:2 value:300252877 time_enabled:166924920 time_running:166924920
>         at iteration:3 value:300242545 time_enabled:166909620 time_running:166909620
>         at iteration:4 value:300250779 time_enabled:166918540 time_running:166918540
>         at iteration:5 value:300250660 time_enabled:166922180 time_running:166922180
>         at iteration:6 value:258369655 time_enabled:167388920 time_running:143996600
>         perf_event_open02    0  TINFO  :  overall task clock: 167540640
>         perf_event_open02    0  TINFO  :  hw sum: 1801473873, task clock sum: 1005046160
>         hw counters: 177971955 185132938 185488818 185488199 185480943 185477118 179657001 172499668 172137672 172139561
>         task clock counters: 99299900 103293440 103503840 103502040 103499020 103496160 100224320 96227620 95999400 96000420
>         perf_event_open02    0  TINFO  :  ratio: 5.998820
>         perf_event_open02    0  TINFO  :  nhw: 6.000100     /* I added this extra line for debug */
>         perf_event_open02    1  TPASS  :  test passed
>
> Thanks
>
> --
> Qais Yousef
