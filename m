Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A649C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FF32080F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsOKc7FR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfKTRnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:43:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41676 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfKTRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:43:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so65052ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVJJ3Wtms7wt1kRD/tsgNBo46B7g+nxnT9NHvY/myOA=;
        b=AsOKc7FRgqYYdZG3UCHIdi9dpI1enb3DOhAgisRCJz9nJglMTxZD5vbrIxI6SG6AX8
         BV4NCcydbmypYT5maJXmaZxI18rTR9YxU6/P7KDKdPkDXw4mCJ+Ect0AIlq4h/nYSB2B
         9G8CqgtQER0uiYVPonrYCc3IF+4TpWz3bMhmhc4wwY5pXM/nCYXn/b8CfVpSk6OlwSRZ
         sArQxdprfF1vLsyyUOlNADxsn0G/WhQXFVhz5eCvfsJXgldFjPknPK1NFb5Yc2BBHEwJ
         sMG2hL4tZPpOeWJT7uMzvFqxLSzTqZoygiwZ10Rr0wrDrsNqZAbyo0Dt9E32tUH3vAEs
         h2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVJJ3Wtms7wt1kRD/tsgNBo46B7g+nxnT9NHvY/myOA=;
        b=tgby2tkUvNuyVv/7mNiK4auNOlgXDME2OuYy5qNPPtsh1HNeUB+PSuoPXxFMRSxoSV
         WZtu5xmYPLtHsuOEnA03ku1CMSeEnefaZXmYY4j3p84wzYAg2fjdzH1KG/Fv4FSmEIb4
         QUmcf7Iv4qZltg1E/8jnghHcOgBuMiJBaLfoIGmJp6RtZpca2s0l5gWUM6LmU9sbnQQ9
         9V5dEA82pqhIfub7Q8mTbLo+fAiqrTnUGUBwqsHXJs4hU+19cnP8r06TFbj5d/BvCjjs
         NlwwfxAaMCCP/L4/db32LGqyNP7OGtl1vWr/JNoYOg8kg4vlwyiaaMEVOGDruGB00joN
         Q28Q==
X-Gm-Message-State: APjAAAXAi/qInTEoIplhbcw+1tFdA9kjOpnOHivtlUt/3/4lr3G9ChXu
        E8kHsDaj55exQCVOn2z6VrDIU48jPymRCCyOhXyamQ==
X-Google-Smtp-Source: APXvYqz+/RP03swN2/qR9wFoKpFQw21xD39RwYlVow1Mo/8fGTfqGSptcLekpXxnN7Ev2gPdPRr6Eba/JHb1/RBP9QI=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr3767152lji.206.1574271811618;
 Wed, 20 Nov 2019 09:43:31 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com> <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Nov 2019 18:43:20 +0100
Message-ID: <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com>
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

On Wed, 20 Nov 2019 at 18:34, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 11/20/19 17:53, Vincent Guittot wrote:
> > On Wed, 20 Nov 2019 at 14:21, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Hi Qais,
> > >
> > > On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > Hi Vincent
> > > >
> > > > On 10/18/19 15:26, Vincent Guittot wrote:
> > > > > The slow wake up path computes per sched_group statisics to select the
> > > > > idlest group, which is quite similar to what load_balance() is doing
> > > > > for selecting busiest group. Rework find_idlest_group() to classify the
> > > > > sched_group and select the idlest one following the same steps as
> > > > > load_balance().
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > >
> > > > LTP test has caught a regression in perf_event_open02 test on linux-next and I
> > > > bisected it to this patch.
> > > >
> > > > That is checking out next-20191119 tag and reverting this patch on top the test
> > > > passes. Without the revert the test fails.
> >
> > I haven't tried linux-next yet but LTP test is passed with
> > tip/sched/core, which includes this patch, on hikey960 which is arm64
> > too.
> >
> > Have you tried tip/sched/core on your juno ? this could help to
> > understand if it's only for juno or if this patch interact with
> > another branch merged in linux next
>
> Okay will give it a go. But out of curiosity, what is the output of your run?
>
> While bisecting on linux-next I noticed that at some point the test was
> passing but all the read values were 0. At some point I started seeing
> none-zero values.

for tip/sched/core
linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
sudo ./perf_event_open02
perf_event_open02    0  TINFO  :  overall task clock: 63724479
perf_event_open02    0  TINFO  :  hw sum: 1800900992, task clock sum: 382170311
perf_event_open02    0  TINFO  :  ratio: 5.997229
perf_event_open02    1  TPASS  :  test passed

for next-2019119
~/ltp/testcases/kernel/syscalls/perf_event_open$ sudo ./perf_event_open02 -v
at iteration:0 value:0 time_enabled:69795312 time_running:0
perf_event_open02    0  TINFO  :  overall task clock: 63582292
perf_event_open02    0  TINFO  :  hw sum: 0, task clock sum: 0
hw counters: 0 0 0 0
task clock counters: 0 0 0 0
perf_event_open02    0  TINFO  :  ratio: 0.000000
perf_event_open02    1  TPASS  :  test passed

>
> --
> Qais Yousef
