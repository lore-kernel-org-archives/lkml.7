Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA81C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C620675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bT87HitP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfCDRlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:41:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39894 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfCDRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:41:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so5067413ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6awRhQ5D2b8C+QX/fFUFZuvqk6WDzLKAcqRIT41rUs=;
        b=bT87HitPxDBdLAXvuIqFsNUqqjfxdI/TVOQco68zvJTHMrZHY+Xsd+w6nnhewwPA75
         DIw7h3HoeK4M+hyuBz4Q8SgwfZbTBASvn+V5vFaMeRSQPE40HGg2icpNKmS36Eb99IrY
         aKPuEceBA3E45MoQfdzr0icCM5I4TZ24uTUm0t7Co2QeCabpp7pJv+VPodfi0e4tp7kE
         2XaFDPAEoY3ymzSK/q0ZFQlT48FsYi40X0vUIR1tjfcPBZTLha27mAt6cUPHDxsayG2z
         9+MKIIyVOwYVS0p4TjavZJNc/w9wtvhWqEUcQjKPYMwgbMe37xpUkXObKrWj+xH+YuMg
         oHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6awRhQ5D2b8C+QX/fFUFZuvqk6WDzLKAcqRIT41rUs=;
        b=OJZ34OD3WhVi8K9HT9Rmn4v02nSRoB2SkhOJVS8Vmb73zwS7XxkAJg+rILt0fbWgge
         8Dua5Q5xUwzdPVAjn49OFbCWrBHPo5ig5W95uhK7nR7bSujrL2v41OB8qd8Z/c/Pk0RW
         qCATleS7LqLJ7Gt7IkzrRh+MAeZA3Gk18waMLR9gmq/JyX3q3Cwvp7/u17lb3GMBy3oG
         nvYSGo3MMdFPeVfQUi6+vOlcEie/JeVsKUj/9NVZ7ofX6SWYb1bEB8oFs4U1RE7nH1sc
         nqAXmV3L9oRGNc1sxUEzDJYzKRsqS8ZgGpMGdoLxbuLrqjMMI8CDhUqd6fkqG6sUImZy
         G6qA==
X-Gm-Message-State: APjAAAXVKB7cI3CEPjlrWSdQkNhRXg8yFzOR2k3Z05yPbLdHNq7PUu1N
        8KBqprcn5GfQUeegNLN2HJXg15k9E2nD3FssgD/g1w==
X-Google-Smtp-Source: APXvYqwNQv6ihtTbyyn9B33hq5ED0RkdfGZmltSodXDybRm9XbVyyl87LiUwe3jH5H9B0Sxa4aVaIBIKxsIg/C0E1yk=
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr11081006ljg.34.1551721267690;
 Mon, 04 Mar 2019 09:41:07 -0800 (PST)
MIME-Version: 1.0
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin> <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin> <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
In-Reply-To: <20190304164816.4fnxxesjwzdoqria@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Mar 2019 18:40:56 +0100
Message-ID: <CAKfTPtBn0LyW-ar=E5xLMJ+vT5U6KWJivT8HvF0=U2dVK32nAQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_V4=5D_sched=2Fcpufreq=3A_initialize_iow?=
        =?UTF-8?Q?ait=5Fboost=5Fmax_and_iowait=5Fboost_with_cpu_capacity?=
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?UTF-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 at 17:48, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Monday 04 Mar 2019 at 16:26:16 (+0100), Peter Zijlstra wrote:
> > On Mon, Mar 04, 2019 at 01:58:12PM +0000, Quentin Perret wrote:
> > > You could also update the values in sugov_get_util() at the cost of a
> > > small overhead to compute 'min'. I'm not sure what's preferable since
> > > we wanted to avoid that kind of overhead in the first place ...
> >
> > Or,... we could actually make things simpler.
> >
> > How's the below? I have a feq questions wrt min, mostly:
> >
> >  - what's the difference between policy->min and
> >    policy->cpuinfo.min_freq; it used to be the former, the below uses
> >    the latter.
>
> As mentioned on IRC, IIRC policy->min is something that can be written
> from userspace (for example) to cap the min freq. OTOH, cpuinfo.min_freq
> is read-only and just reports the lowest OPP.
>
> Rafael is this correct ?
>
> >  - should we have a min_freq based value, instead of a constant; the
> >    difference being that with this the actual boost speed depends in the
> >    gap between min/max.
>
> If the above is correct, then I agree. Looking at min_freq simplifies
> things quite a bit since it doesn't need to be updated all the time,
> and the whole policy->min stuff is dealt with at the CPUFreq core level
> so it's not obvious sugov should care.
>
> > Anyway; the below converts iowait_boost to capacity scale (from kHz), it
> > side-steps the whole issue you guys are bickering about by limiting it
> > to SCHED_CAPACITY_SCALE (aka. 1024) on the boost path, and then limiting
> > it to @max by the time we figured out we ought to use it.
> >
> > And since that means we never change @max anymore; we can simplify whole
> > return value thing.
>
> [...]
>
> > @@ -837,7 +818,9 @@ static int sugov_start(struct cpufreq_policy *policy)
> >               memset(sg_cpu, 0, sizeof(*sg_cpu));
> >               sg_cpu->cpu                     = cpu;
> >               sg_cpu->sg_policy               = sg_policy;
> > -             sg_cpu->iowait_boost_max        = policy->cpuinfo.max_freq;
> > +             sg_cpu->min                     =
> > +                     (SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> > +                     policy->cpuinfo.max_freq;
>
> The 'funny' thing is that on big little this 'min' can end up being
> larger than 'max' ...

yes arch_scale_cpu_capacity() should be used instead of
SCHED_CAPACITY_SCALE to be compared with sg_cpu->max and sg_cpu->util

>
> On juno r0 for example, min_freq and max_freq for little CPUs are
> respectively 450MHz and 850MHz. So you get sg_cpu->min=542, but
> sg_cpu->max=446 ... So you'll max out after the first IO wakeup.
> And since iowait_boost is reset whenever it is smaller than sg_cpu->min,
> you end up with something that can either force max freq or apply no
> boost at all ...
>
> Perhaps you could keep the 'util' and 'max' pointers in
> sugov_iowait_apply() and overwrite them like before, but in the
> SCHED_CAPACITY_SCALE scale as you suggest ?
>
> Thanks,
> Quentin
