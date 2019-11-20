Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC7C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B9420715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7zqRjHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfKTT3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:29:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35876 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:29:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so444715lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8mggtxU1zp4JDBupngVAB3B8vB3qNT6+jtDLAhJwfY=;
        b=R7zqRjHPN2+U6QPltce6KNHzU2cvypcB1dU0saO7eF1M2zmzXX7bzDZ7uBYN5h71bt
         GpD0BTJrnBfbQxo0/wG4pLANiM4Qn4/6r0sRCj5Cp3CWg7d15y8ctdEDKDfEkMRqrfgG
         YBlXvVZd3A9HSjoGPy9HXTRRYNn83GbGlUJUZthoT0p8hHIeu1njWaB8qA/Tt4qGgdXl
         brKse3KdVXYJvz6i2simx7Y4evr5s1ofIDwGA4FafS1FWoZvX8hWbxtl6l5gvgasFTzQ
         i6X8LDJvYdq90JHeTB0mrYKXm+sHT2VZ15sYx0z5opEu+IZIXXxvyIcq19kzsGh/+L6q
         hP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8mggtxU1zp4JDBupngVAB3B8vB3qNT6+jtDLAhJwfY=;
        b=VmR9mdFRcPsrA3V5KqBURMdgeYlGlI5F1+dq9EqteOhYbbb18319WrSJZ3vtjNtgTZ
         OyOf9DHcvOMatumwHzEWznqHyEBi+2tiPQeryeB0U1R+l/xTzI8MEMheBqVLwozXktU2
         8sw4KItkuGDBGSMwfkgLcQU/veJHB7VGw1IKwkbX2Aej1CyC7wSARegNvOTHXMIqRFwF
         Rspd/HK/5E1WYpYX3aLBr90L6w8wcyByrEEYL46mIFq/SV0dy3X3uiTY+rxKuXQUWuw8
         4LXAUhHCZYAlC1BtsTGRgODmJnkhE/9mdCsv0iPL4E40G/8F3CMf0fRvhjXHTE1APg6V
         d3Sw==
X-Gm-Message-State: APjAAAUhbUE1RN1h2vvV5tqbzaBAecse8QammBo7esf4IF/zyewhDRv8
        1XgHBMmkVLk4RIXmq8nD1SX5wqJAtl48wzoA7ROCgw==
X-Google-Smtp-Source: APXvYqx2G6y4tjddPf3ANE9ZbeXC93VOkJVataHNoGp2fl4B41RC8K2QNrPppdRg7AWc5+ERDXbTHlws0MCPCU+RNF4=
X-Received: by 2002:a2e:982:: with SMTP id 124mr4385167ljj.48.1574278149099;
 Wed, 20 Nov 2019 11:29:09 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
 <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
 <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com>
 <20191120181002.lh7vukjm2ifhysbc@e107158-lin.cambridge.arm.com>
 <CAKfTPtDCv4jWxODGf8FOefmP6qyWRdfi2QVRT=wZqwYgUKg9HA@mail.gmail.com> <20191120182731.z2sh5ju7uir5s3cp@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191120182731.z2sh5ju7uir5s3cp@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Nov 2019 20:28:57 +0100
Message-ID: <CAKfTPtDzVHZpE0XmyPF8AVsmtVMCmKgYERjdW4euj-H6kNu2Rw@mail.gmail.com>
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

On Wed, 20 Nov 2019 at 19:27, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 11/20/19 19:20, Vincent Guittot wrote:
> > On Wed, 20 Nov 2019 at 19:10, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 11/20/19 18:43, Vincent Guittot wrote:
> > > > On Wed, 20 Nov 2019 at 18:34, Qais Yousef <qais.yousef@arm.com> wrote:
> > > > >
> > > > > On 11/20/19 17:53, Vincent Guittot wrote:
> > > > > > On Wed, 20 Nov 2019 at 14:21, Vincent Guittot
> > > > > > <vincent.guittot@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Qais,
> > > > > > >
> > > > > > > On Wed, 20 Nov 2019 at 12:58, Qais Yousef <qais.yousef@arm.com> wrote:
> > > > > > > >
> > > > > > > > Hi Vincent
> > > > > > > >
> > > > > > > > On 10/18/19 15:26, Vincent Guittot wrote:
> > > > > > > > > The slow wake up path computes per sched_group statisics to select the
> > > > > > > > > idlest group, which is quite similar to what load_balance() is doing
> > > > > > > > > for selecting busiest group. Rework find_idlest_group() to classify the
> > > > > > > > > sched_group and select the idlest one following the same steps as
> > > > > > > > > load_balance().
> > > > > > > > >
> > > > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > > > ---
> > > > > > > >
> > > > > > > > LTP test has caught a regression in perf_event_open02 test on linux-next and I
> > > > > > > > bisected it to this patch.
> > > > > > > >
> > > > > > > > That is checking out next-20191119 tag and reverting this patch on top the test
> > > > > > > > passes. Without the revert the test fails.
> > > > > >
> > > > > > I haven't tried linux-next yet but LTP test is passed with
> > > > > > tip/sched/core, which includes this patch, on hikey960 which is arm64
> > > > > > too.
> > > > > >
> > > > > > Have you tried tip/sched/core on your juno ? this could help to
> > > > > > understand if it's only for juno or if this patch interact with
> > > > > > another branch merged in linux next
> > > > >
> > > > > Okay will give it a go. But out of curiosity, what is the output of your run?
> > > > >
> > > > > While bisecting on linux-next I noticed that at some point the test was
> > > > > passing but all the read values were 0. At some point I started seeing
> > > > > none-zero values.
> > > >
> > > > for tip/sched/core
> > > > linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
> > > > sudo ./perf_event_open02
> > > > perf_event_open02    0  TINFO  :  overall task clock: 63724479
> > > > perf_event_open02    0  TINFO  :  hw sum: 1800900992, task clock sum: 382170311
> > > > perf_event_open02    0  TINFO  :  ratio: 5.997229
> > > > perf_event_open02    1  TPASS  :  test passed
> > > >
> > > > for next-2019119
> > > > ~/ltp/testcases/kernel/syscalls/perf_event_open$ sudo ./perf_event_open02 -v
> > > > at iteration:0 value:0 time_enabled:69795312 time_running:0
> > > > perf_event_open02    0  TINFO  :  overall task clock: 63582292
> > > > perf_event_open02    0  TINFO  :  hw sum: 0, task clock sum: 0
> > > > hw counters: 0 0 0 0
> > > > task clock counters: 0 0 0 0
> > > > perf_event_open02    0  TINFO  :  ratio: 0.000000
> > > > perf_event_open02    1  TPASS  :  test passed
> > >
> > > Okay that is weird. But ratio, hw sum, task clock sum are all 0 in your
> > > next-20191119. I'm not sure why the counters return 0 sometimes - is it
> > > dependent on some option or a bug somewhere.
> > >
> > > I just did another run and it failed for me (building with defconfig)
> > >
> > > # uname -a
> > > Linux buildroot 5.4.0-rc8-next-20191119 #72 SMP PREEMPT Wed Nov 20 17:57:48 GMT 2019 aarch64 GNU/Linux
> > >
> > > # ./perf_event_open02 -v
> > > at iteration:0 value:260700250 time_enabled:172739760 time_running:144956600
> > > perf_event_open02    0  TINFO  :  overall task clock: 166915220
> > > perf_event_open02    0  TINFO  :  hw sum: 1200718268, task clock sum: 667621320
> > > hw counters: 300179051 300179395 300179739 300180083
> > > task clock counters: 166906620 166906200 166905160 166903340
> > > perf_event_open02    0  TINFO  :  ratio: 3.999763
> > > perf_event_open02    0  TINFO  :  nhw: 0.000100
> > > perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )
> > >
> > > It is a funny one for sure. I haven't tried tip/sched/core yet.
> >
> > I confirm that on next-20191119, hw counters always return 0
> > but on tip/sched/core which has this patch and v5.4-rc7 which has not,
> > the hw counters are always different from 0
>
> It's the other way around for me. tip/sched/core returns 0 hw counters. I tried
> enabling coresight; that had no effect. Nor copying the .config that failed
> from linux-next to tip/sched/core. I'm not sure what's the dependency/breakage
> :-/

I run few more tests and i can get either hw counter with 0 or not.
The main difference is on which CPU it runs: either big or little
little return always 0 and big always non-zero value

on v5.4-rc7 and tip/sched/core, cpu0-3 return 0 and other non zeroa
but on next, it's the opposite cpu0-3 return non zero ratio

Could you try to run the test with taskset to run it on big or little ?

>
> --
> Qais Yousef
>
> >
> > on v5.4-rc7 i have got the same ratio :
> > linaro@linaro-developer:~/ltp/testcases/kernel/syscalls/perf_event_open$
> > sudo ./perf_event_open02 -v
> > at iteration:0 value:300157088 time_enabled:80641145 time_running:80641145
> > at iteration:1 value:300100129 time_enabled:63572917 time_running:63572917
> > at iteration:2 value:300100885 time_enabled:63569271 time_running:63569271
> > at iteration:3 value:300103998 time_enabled:63573437 time_running:63573437
> > at iteration:4 value:300101477 time_enabled:63571875 time_running:63571875
> > at iteration:5 value:300100698 time_enabled:63569791 time_running:63569791
> > at iteration:6 value:245252526 time_enabled:63650520 time_running:52012500
> > perf_event_open02    0  TINFO  :  overall task clock: 63717187
> > perf_event_open02    0  TINFO  :  hw sum: 1800857435, task clock sum: 382156248
> > hw counters: 149326575 150152481 169006047 187845928 206684169
> > 224693333 206543358 187716226 168865909 150023409
> > task clock counters: 31694792 31870834 35868749 39866666 43863541
> > 47685936 43822396 39826042 35828125 31829167
> > perf_event_open02    0  TINFO  :  ratio: 5.997695
> > perf_event_open02    1  TPASS  :  test passed
