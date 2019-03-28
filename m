Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03375C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F99206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553768692;
	bh=36p/FkvvjEka8WK2i8cv1YDrl+xJsNptGsQUv7U7jHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FNaf2lTt8iFp+2p/Bf7BtHZvMNXsFlVpYkxsMvnojD2gqEoBlnjrusmLEvWmjH3uK
	 vQ5UqNfLVT2Dcnn/kLQpur/fJP4laH75b3funian8NKtCaoFgjHIAfZ7hxAcN6cZ1C
	 wqMEPHm+cs7wezeLOWwvYN2UxD0Kfh3gomLIYync=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfC1KYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:24:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfC1KYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:24:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so15333484oie.9;
        Thu, 28 Mar 2019 03:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOoLOfscdDb4F8YP4gTl7EOMuBexDNHvnwwrxdjpBPA=;
        b=Ewj4V3kpHV9HmWIAzJMZ09Ck9QEtoJ0HoSzyehkLGvcPhSIYqNC/o9nn8mOvUN7n51
         BqrveN1M0JmZ87HPYpymYm3HuCRTUzX7TD4ioVIg4zLIKQmPCzrk0CuW6E+0oF5vLRxY
         N4K4USvlX5e1nQubcnuEM5lWTYv9SbBXU02V1tuRQFT5Z65yKnVIDUY+FmmcnFhs50lx
         pcx/hKeot8SEeM1VOrZakmq+8M+Ue8tORyH1Db7DzbLntnvVqx2JHKX+XY2oPH1CdFBe
         arMO9f+nXJxodnyvE2HY1j8cqd8gJ5YTg/HfyVya57ESID/B3cec7md+PN+Oq8ELOtr3
         Vd8Q==
X-Gm-Message-State: APjAAAU7ion+BxdLUlclFofpMAf0/GoGQyDsEKTF6kj+J8f0d7RoC1Cj
        sAf9a37mYN4QdXzgxnehAsalirrAaPHHNjl8nGQ=
X-Google-Smtp-Source: APXvYqyxt0KObdeEdMPX0SrjjcEsEPGTf/SiTwWbTOy2LzdMAqufKUhdvrewmqxldZefswwMHhRdCotxW6x3jbopnH0=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr22611472oib.95.1553768690692;
 Thu, 28 Mar 2019 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <11953735.uMqeHy63Iu@aspire.rjw.lan> <2864116.v8IU97Resm@aspire.rjw.lan>
 <20190328094823.y6gyfb6ldq43gojw@queper01-lin>
In-Reply-To: <20190328094823.y6gyfb6ldq43gojw@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Mar 2019 11:24:39 +0100
Message-ID: <CAJZ5v0jx6ZsYaq=YtYfGFDACkT4Gg=mf+hSBOT_RQeMo7AaM3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: schedutil: Simplify iowait boosting
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:48 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Rafael,
>
> On Tuesday 26 Mar 2019 at 12:18:00 (+0100), Rafael J. Wysocki wrote:
> > @@ -13,6 +13,8 @@
> >  #include <linux/sched/cpufreq.h>
> >  #include <trace/events/power.h>
> >
> > +#define IOWAIT_BOOST_MIN     (SCHED_CAPACITY_SCALE / 8)
> > +
> >  struct sugov_tunables {
> >       struct gov_attr_set     attr_set;
> >       unsigned int            rate_limit_us;
> > @@ -51,7 +53,6 @@ struct sugov_cpu {
> >       u64                     last_update;
> >
> >       unsigned long           bw_dl;
> > -     unsigned long           min;
> >       unsigned long           max;
> >
> >       /* The field below is for single-CPU policies only: */
> > @@ -303,7 +304,7 @@ static bool sugov_iowait_reset(struct sua
>
> The comment above this function needs updating I think.
>
> >       if (delta_ns <= TICK_NSEC)
> >               return false;
> >
> > -     sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
> > +     sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
> >       sg_cpu->iowait_boost_pending = set_iowait_boost;
> >
> >       return true;
> > @@ -349,7 +350,7 @@ static void sugov_iowait_boost(struct su
>
> Ditto.

I overlooked these two, thanks for pointing that out!

Will send an update momentarily.

> >       }
> >
> >       /* First wakeup after IO: start with minimum boost */
> > -     sg_cpu->iowait_boost = sg_cpu->min;
> > +     sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
> >  }
> >
> >  /**
> > @@ -389,7 +390,7 @@ static unsigned long sugov_iowait_apply(
> >                * No boost pending; reduce the boost value.
> >                */
> >               sg_cpu->iowait_boost >>= 1;
> > -             if (sg_cpu->iowait_boost < sg_cpu->min) {
> > +             if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
> >                       sg_cpu->iowait_boost = 0;
> >                       return util;
> >               }
> > @@ -826,9 +827,6 @@ static int sugov_start(struct cpufreq_po
> >               memset(sg_cpu, 0, sizeof(*sg_cpu));
> >               sg_cpu->cpu                     = cpu;
> >               sg_cpu->sg_policy               = sg_policy;
> > -             sg_cpu->min                     =
> > -                     (SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> > -                     policy->cpuinfo.max_freq;
> >       }
> >
> >       for_each_cpu(cpu, policy->cpus) {
> >
>
> Other than that, I tried a backport of this on a Pixel 3 with Snapdragon
> 845 (which is relevant because it has tons of OPPs, so starting at 128
> makes it ramp up faster) to check the impact on power, but the only
> differences appeared to be in the noise margin, so it's all good :)

Cool. :-)

> Full test results available at [1]. Note that I did enable the iowait
> boost feature for these tests -- it is disabled by default on P3 ...

Thanks!

> ---
> [1] https://nbviewer.jupyter.org/gist/qperret/69c9bde13aad2d783689e78c9ba2d9bc
