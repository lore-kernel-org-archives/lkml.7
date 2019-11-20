Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8045C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C172D2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKTSKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:10:07 -0500
Received: from foss.arm.com ([217.140.110.172]:44224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfKTSKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:10:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB3A1FB;
        Wed, 20 Nov 2019 10:10:06 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB763F6C4;
        Wed, 20 Nov 2019 10:10:04 -0800 (PST)
Date:   Wed, 20 Nov 2019 18:10:02 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
Message-ID: <20191120181002.lh7vukjm2ifhysbc@e107158-lin.cambridge.arm.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
 <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
 <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 18:43, Vincent Guittot wrote:
> On Wed, 20 Nov 2019 at 18:34, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 11/20/19 17:53, Vincent Guittot wrote:
> > > On Wed, 20 Nov 2019 at 14:21, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > Hi Qais,
> > > >
> > > > On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
> > > > >
> > > > > Hi Vincent
> > > > >
> > > > > On 10/18/19 15:26, Vincent Guittot wrote:
> > > > > > The slow wake up path computes per sched_group statisics to select the
> > > > > > idlest group, which is quite similar to what load_balance() is doing
> > > > > > for selecting busiest group. Rework find_idlest_group() to classify the
> > > > > > sched_group and select the idlest one following the same steps as
> > > > > > load_balance().
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > >
> > > > > LTP test has caught a regression in perf_event_open02 test on linux-next and I
> > > > > bisected it to this patch.
> > > > >
> > > > > That is checking out next-20191119 tag and reverting this patch on top the test
> > > > > passes. Without the revert the test fails.
> > >
> > > I haven't tried linux-next yet but LTP test is passed with
> > > tip/sched/core, which includes this patch, on hikey960 which is arm64
> > > too.
> > >
> > > Have you tried tip/sched/core on your juno ? this could help to
> > > understand if it's only for juno or if this patch interact with
> > > another branch merged in linux next
> >
> > Okay will give it a go. But out of curiosity, what is the output of your run?
> >
> > While bisecting on linux-next I noticed that at some point the test was
> > passing but all the read values were 0. At some point I started seeing
> > none-zero values.
> 
> for tip/sched/core
> linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
> sudo ./perf_event_open02
> perf_event_open02    0  TINFO  :  overall task clock: 63724479
> perf_event_open02    0  TINFO  :  hw sum: 1800900992, task clock sum: 382170311
> perf_event_open02    0  TINFO  :  ratio: 5.997229
> perf_event_open02    1  TPASS  :  test passed
> 
> for next-2019119
> ~/ltp/testcases/kernel/syscalls/perf_event_open$ sudo ./perf_event_open02 -v
> at iteration:0 value:0 time_enabled:69795312 time_running:0
> perf_event_open02    0  TINFO  :  overall task clock: 63582292
> perf_event_open02    0  TINFO  :  hw sum: 0, task clock sum: 0
> hw counters: 0 0 0 0
> task clock counters: 0 0 0 0
> perf_event_open02    0  TINFO  :  ratio: 0.000000
> perf_event_open02    1  TPASS  :  test passed

Okay that is weird. But ratio, hw sum, task clock sum are all 0 in your
next-20191119. I'm not sure why the counters return 0 sometimes - is it
dependent on some option or a bug somewhere.

I just did another run and it failed for me (building with defconfig)

# uname -a
Linux buildroot 5.4.0-rc8-next-20191119 #72 SMP PREEMPT Wed Nov 20 17:57:48 GMT 2019 aarch64 GNU/Linux

# ./perf_event_open02 -v
at iteration:0 value:260700250 time_enabled:172739760 time_running:144956600
perf_event_open02    0  TINFO  :  overall task clock: 166915220
perf_event_open02    0  TINFO  :  hw sum: 1200718268, task clock sum: 667621320
hw counters: 300179051 300179395 300179739 300180083
task clock counters: 166906620 166906200 166905160 166903340
perf_event_open02    0  TINFO  :  ratio: 3.999763
perf_event_open02    0  TINFO  :  nhw: 0.000100
perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )

It is a funny one for sure. I haven't tried tip/sched/core yet.

Thanks

--
Qais Yousef
