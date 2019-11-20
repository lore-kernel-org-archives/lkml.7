Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC5208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoEsW2ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfKTSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:20:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42052 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKTSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:20:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so305837lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZQwYll5snr062tJhcTonGNrQdpvpN9/3A0Onfaj2Sg=;
        b=MoEsW2ZOIHbzNYuE2MzL2FPd6IIXDkVjV9sgVi40t3FY5baRl9FeOJCd2ds216cvCE
         AkctqWyXEetEECVaO/5qxghc3LZiQvD09kw7QJ118QgYmQ62l+ckDxOmTNWvnbCdIJAK
         mpvX5nglo/rPYRjmg+3VljBJWKAd81tlfj9M+wBa/YlL1hUFAI16z4A9iNXjkiwcB7LM
         Mr/KEx6pdTRjoOYlBklLh0PJrpAvSWsP4wZEPJTq6GG0GKQ6+cYIjdeF5ww7+7zVLimQ
         BWpSojBD3z5s+JkVkDNo81jWKdQQTiQt+hQlCtYAyaFBU4akVgl9SVc+DkkOwu4fhLbn
         Rn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZQwYll5snr062tJhcTonGNrQdpvpN9/3A0Onfaj2Sg=;
        b=KJucY8fR124swvo6VcDa/upNJgxt4zZ2IPGGZxTjkJqspLD7oXZhpKTYgRqEyMUwlP
         NnLKTEvqyHHPNoqbGWNJJWzurhQYyVnLY6GYNITk3SfU+maA/aoxtBnmMI9QZ7wR2G+o
         bKp+yt+jfLMSa00D5/rqZLldSBQe7h9sVf8Vjz37u8aIMWzmy1KmQxPUAYWU4KZAZL+7
         22LvHIvlJMxE6y7gMKpyEMUN+LvSIvTYRKMlacVhD+TYYsFrSKCx2qsZ3uJWyiaXKghu
         WnNLzIa4V6H6oxO/DiOIfUeT5QfLHs09agupvJM2T8fdohQJgzEx5qUiW+p/hSf66MWg
         h4Zg==
X-Gm-Message-State: APjAAAW5xZY7frLJQBYyz/SqW2k6JMLBEjwyWntTMG1jIBwT09g2SKPx
        q71/dPhFHA4why2LxX0LSpnBO/PhBhtC/ivwRuAEdw==
X-Google-Smtp-Source: APXvYqw/7YqB9aCynTqWXqKWx4DxrfCFtNPyq8DHq0bN7x2StDNsl6X29zQB+XMnemUTF/GKhXwfm80idaNSiz5gj1E=
X-Received: by 2002:ac2:5685:: with SMTP id 5mr4314383lfr.32.1574274012189;
 Wed, 20 Nov 2019 10:20:12 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
 <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
 <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com> <20191120181002.lh7vukjm2ifhysbc@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191120181002.lh7vukjm2ifhysbc@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Nov 2019 19:20:00 +0100
Message-ID: <CAKfTPtDCv4jWxODGf8FOefmP6qyWRdfi2QVRT=wZqwYgUKg9HA@mail.gmail.com>
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

On Wed, 20 Nov 2019 at 19:10, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 11/20/19 18:43, Vincent Guittot wrote:
> > On Wed, 20 Nov 2019 at 18:34, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 11/20/19 17:53, Vincent Guittot wrote:
> > > > On Wed, 20 Nov 2019 at 14:21, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > Hi Qais,
> > > > >
> > > > > On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
> > > > > >
> > > > > > Hi Vincent
> > > > > >
> > > > > > On 10/18/19 15:26, Vincent Guittot wrote:
> > > > > > > The slow wake up path computes per sched_group statisics to select the
> > > > > > > idlest group, which is quite similar to what load_balance() is doing
> > > > > > > for selecting busiest group. Rework find_idlest_group() to classify the
> > > > > > > sched_group and select the idlest one following the same steps as
> > > > > > > load_balance().
> > > > > > >
> > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > ---
> > > > > >
> > > > > > LTP test has caught a regression in perf_event_open02 test on linux-next and I
> > > > > > bisected it to this patch.
> > > > > >
> > > > > > That is checking out next-20191119 tag and reverting this patch on top the test
> > > > > > passes. Without the revert the test fails.
> > > >
> > > > I haven't tried linux-next yet but LTP test is passed with
> > > > tip/sched/core, which includes this patch, on hikey960 which is arm64
> > > > too.
> > > >
> > > > Have you tried tip/sched/core on your juno ? this could help to
> > > > understand if it's only for juno or if this patch interact with
> > > > another branch merged in linux next
> > >
> > > Okay will give it a go. But out of curiosity, what is the output of your run?
> > >
> > > While bisecting on linux-next I noticed that at some point the test was
> > > passing but all the read values were 0. At some point I started seeing
> > > none-zero values.
> >
> > for tip/sched/core
> > linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
> > sudo ./perf_event_open02
> > perf_event_open02    0  TINFO  :  overall task clock: 63724479
> > perf_event_open02    0  TINFO  :  hw sum: 1800900992, task clock sum: 382170311
> > perf_event_open02    0  TINFO  :  ratio: 5.997229
> > perf_event_open02    1  TPASS  :  test passed
> >
> > for next-2019119
> > ~/ltp/testcases/kernel/syscalls/perf_event_open$ sudo ./perf_event_open02 -v
> > at iteration:0 value:0 time_enabled:69795312 time_running:0
> > perf_event_open02    0  TINFO  :  overall task clock: 63582292
> > perf_event_open02    0  TINFO  :  hw sum: 0, task clock sum: 0
> > hw counters: 0 0 0 0
> > task clock counters: 0 0 0 0
> > perf_event_open02    0  TINFO  :  ratio: 0.000000
> > perf_event_open02    1  TPASS  :  test passed
>
> Okay that is weird. But ratio, hw sum, task clock sum are all 0 in your
> next-20191119. I'm not sure why the counters return 0 sometimes - is it
> dependent on some option or a bug somewhere.
>
> I just did another run and it failed for me (building with defconfig)
>
> # uname -a
> Linux buildroot 5.4.0-rc8-next-20191119 #72 SMP PREEMPT Wed Nov 20 17:57:48 GMT 2019 aarch64 GNU/Linux
>
> # ./perf_event_open02 -v
> at iteration:0 value:260700250 time_enabled:172739760 time_running:144956600
> perf_event_open02    0  TINFO  :  overall task clock: 166915220
> perf_event_open02    0  TINFO  :  hw sum: 1200718268, task clock sum: 667621320
> hw counters: 300179051 300179395 300179739 300180083
> task clock counters: 166906620 166906200 166905160 166903340
> perf_event_open02    0  TINFO  :  ratio: 3.999763
> perf_event_open02    0  TINFO  :  nhw: 0.000100
> perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )
>
> It is a funny one for sure. I haven't tried tip/sched/core yet.

I confirm that on next-20191119, hw counters always return 0
but on tip/sched/core which has this patch and v5.4-rc7 which has not,
the hw counters are always different from 0

on v5.4-rc7 i have got the same ratio :
linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
sudo ./perf_event_open02 -v
at iteration:0 value:300157088 time_enabled:80641145 time_running:80641145
at iteration:1 value:300100129 time_enabled:63572917 time_running:63572917
at iteration:2 value:300100885 time_enabled:63569271 time_running:63569271
at iteration:3 value:300103998 time_enabled:63573437 time_running:63573437
at iteration:4 value:300101477 time_enabled:63571875 time_running:63571875
at iteration:5 value:300100698 time_enabled:63569791 time_running:63569791
at iteration:6 value:245252526 time_enabled:63650520 time_running:52012500
perf_event_open02    0  TINFO  :  overall task clock: 63717187
perf_event_open02    0  TINFO  :  hw sum: 1800857435, task clock sum: 382156248
hw counters: 149326575 150152481 169006047 187845928 206684169
224693333 206543358 187716226 168865909 150023409
task clock counters: 31694792 31870834 35868749 39866666 43863541
47685936 43822396 39826042 35828125 31829167
perf_event_open02    0  TINFO  :  ratio: 5.997695
perf_event_open02    1  TPASS  :  test passed

Thanks

>
> Thanks
>
> --
> Qais Yousef
