Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE33C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7D2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0R0vPmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfDYMEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:04:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42429 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfDYMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:04:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id w23so17292226lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vk88TUak2pbwqBxKW3YTfeW3F80e77Imajln7pCJZBo=;
        b=K0R0vPmfgRwaU56XwnhMXtF3AYyyK8fb9iQa2SjPeJiwvQSPHksAE+qvNITnAZUc2W
         Jdx/yh0NKy2mVnrDXUF2ZGkuS8x6l5h899kVtZnRxtbgnZdK70br8xWdXHYnbGiL5T4d
         2u5nCJt1DKhiOdXRkZAVPHOYnAdf5PLjhv5Oqi7r9PsYFzqLSQ0blCYvo75u5IjNHRzj
         2L5DSs+NEEW2z++dS0HFk7ygZS5c4MU9IrZbnnqHIprPI3v/VbpKpW9AMwP3qEmgqal8
         iJaB1x0qn35uh2yMwR6yoMycyf885fUUdAHJ4nq9OgODyPlL7GKoNDOOPDlYHS0ZMQtM
         35XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vk88TUak2pbwqBxKW3YTfeW3F80e77Imajln7pCJZBo=;
        b=FzOFdIBQuPGRc/BvejDfY/i0ZL6luiLOctR2svsk4S4Lzn2VLdV55zzuMcd6Pe52Vm
         b+kbQJ5D8IZucCpv+9m9PZziUE/T4+3ejy/qVQ5vLSlXGVmMMhZX+zeAYddJV6uaUoeo
         INA2rQmy6OvZJtojUvt0vJe0nM4mxMt/eNQZqJvkZ7EC9ssT+b+QGQmeixZwWBZ+pAw0
         dPRil2xsi+zA8CLyzn3mQSzwpaTkLuNhE6Fs62ln16H5SJX4c6qpM4nLEGSnq2HCv633
         0S0kG10mfadEOSjJpaQ4M4yCTj3zz9iC7aexjPF3J04gUVUzjEu2kCW5RdsZEQ/8CmHQ
         gFoQ==
X-Gm-Message-State: APjAAAXatTzzoxXWHXHlv//l4kTPUJqqeeTBNzfncvLqMpiy6GnOCxQm
        JdYePk6NRWMCfV8pX3SxD7aeRhQHWv8WXyWdWZjpeQ==
X-Google-Smtp-Source: APXvYqyJCESUPJIad7AhxEN0jRxxiflBclUttMyhs3fxk+IpKlcXBEYFMz+YSdQpLyYK95stDfjMHh+W1y4O8X/hK5w=
X-Received: by 2002:ac2:4301:: with SMTP id l1mr4533867lfh.54.1556193862034;
 Thu, 25 Apr 2019 05:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin> <5CBF93F6.8000109@linaro.org> <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
In-Reply-To: <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Apr 2019 14:04:10 +0200
Message-ID: <CAKfTPtAmCvQVudPrUzWa-yhPBRATFYr1a1=iPZ3fonv_K5wn5w@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 12:45, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 23 Apr 2019 at 18:38:46 (-0400), Thara Gopinath wrote:
> > I think there is one major difference between user-defined frequency
> > constraints and frequency constraints due to thermal events in terms of
> > the time period the system spends in the the constraint state.
> > Typically, a user constraint lasts for seconds if not minutes and I
> > think in this case cpu_capacity_orig should reflect this constraint and
> > not cpu_capacity like this patch set.
>
> That might not always be true I think. There's tons of userspace thermal
> deamons out there, and I wouldn't be suprised if they were writing into
> the cpufreq sysfs files, although I'm not sure.

They would better use the sysfs set_target interface of cpu_cooling
device in this case.

>
> Another thing is, if you want to change the capacity_orig value, you'll
> need to rebuild the sched domains and all I believe. Otherwise there is
> a risk to 'break' the sd_asym flags. So we need to make sure we're happy
> to pay that price.

That would be the goal, if userspace uses the sysfs interface of
cpufreq to set a new max frequency, it should be considered as a long
change in regards to the scheduling rate and in this case it should be
interesting to update cpacity_orig and rebuild sched_domain.

>
> > Also, in case of the user
> > constraint, there is possibly no need to accumulate and average the
> > capacity constraints and instantaneous values can be directly applied to
> > cpu_capacity_orig. On the other hand thermal pressure is more spiky and
> > sometimes in the order of ms and us requiring the accumulating and
> > averaging.
> > >
> > > Perhaps the Intel boost stuff could be factored in there ? That is,
> > > at times when the boost freq is not reachable capacity_of() would appear
> > > smaller ... Unless this wants to be reflected instantaneously ?
> > Again, do you think intel boost is more applicable to be reflected in
> > cpu_capacity_orig and not cpu_capacity?
>
> I'm not even sure if we want to reflect it at all TBH, but I'd be
> interested to see what Intel folks think :-)
>
> Thanks,
> Quentin
