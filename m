Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E04C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A58420665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562574531;
	bh=oQLMVzZMmfQ9PuIheFfbEQYb+7v3M6/7rYFE+rqp3tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mi3WGYxiY3uFt2WsLUQW7cKPRK/RVythu+CBQa9jP3ch0zvGLc9DW7LpQlW1GJrU1
	 Kd577W4ZScqjYUokJOOp6stMqzhOQtWNZEIEOiYvlA4LgCv8koFprmcjXArzacaDAH
	 y/p8YKZiyEffLt8kFCuyigZ9FF85n9pCjuTmXlhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfGHI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:28:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35221 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:28:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so15369102otq.2;
        Mon, 08 Jul 2019 01:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNx4oFFhnNUMoO4lcMlhw0gwdeffoJB9as6x6krrVFg=;
        b=eksgePamhl5JGpIBtdnE53S5hJnTz5dQPucwbhKyiluW7MaARxp9McEbdUKzcag9C+
         z2Vc2Syuy7ycvpjaE55N9drwTCmFBKC0+LVcsZubyBykZ/W9v3v7FIE464ooMO9NU4SW
         K7aTpcUgKW17iKF2QuIJjJ48DVUrP/ZWfE4O4HU0slW6umcwTLzfF1TzxgSMxp51vwJ+
         MvhJmyfj0TEA6GYvag6t+2hExqYmH4vAHhIkcqo8u1sSzSQfiMLEnnnxBxO4M1WaOyrB
         8PRZgYUxpBZoGGJJG/PX8PFVrwj+WA0nzMb5C1URpA2veANPYVT1r3aJx83SAq8ccKgi
         09Ew==
X-Gm-Message-State: APjAAAUq0mmgqXD7wW6I5S6ntsv0xOdshlSQ6Px5/C9Cf+QtI+y5KZcR
        iAqTB+X+gar2XXHticQMi9zNDcZqIK87kVdQhFI=
X-Google-Smtp-Source: APXvYqzx4KNUW2Mxmc0gmZzR2Bt11FpZ2EU7GUZan9zpP3IWVQqriiyU+ROonqPRbDEfiRefcas1aI9Lolu+jRYJd+0=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr12994933otp.189.1562574529126;
 Mon, 08 Jul 2019 01:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190704192020.GA3771@amd> <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd> <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd> <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
In-Reply-To: <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 10:28:32 +0200
Message-ID: <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 5:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-07-19, 22:30, Pavel Machek wrote:
> > Hi!
> >
> > > Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> > > to happen for you.
> > >
> > > I would try
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=f012a132824fc870b90980540f727c76fc72e244
> > >
> > > to narrow down the scope somewhat.
>
> I couldn't find the original mail, what exactly is the problem with
> suspend in your case ?

Something unusual:

https://lore.kernel.org/linux-pm/20190706190123.GA11603@amd/T/#mca22dd7c1e8836e9253702df9f56a68ab65192a4

> > Bisect says:
> >
> > 572542c81dec533b7dd3778ea9f5949a00595f68 is the first bad commit
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> >
> >     cpufreq: Register notifiers with the PM QoS framework
> >
> >     This registers the notifiers for min/max frequency constraints
> >     with the
> >
> >  Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >  Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Unfortunately, it does not revert cleanly:
>
> I tried following on my ARM board (both single policy and multiple
> policy configurations):
>
> rtcwake --seconds 5 -v -m mem
>
> And everything worked as expected. Please make sure the top commit of
> my series in pm/linux-next is, some issues were fixed on Friday:
>
> 0a811974f3f7 cpufreq: Add QoS requests for userspace constraints

Pavel has tested the latest version of the patch series AFAICS.

The locking added by the commit in question to
refresh_frequency_limits() requires an update of
cpufreq_update_policy(), or it will deadlock in there because of the
lock acquired by cpufreq_cpu_get() if I haven't missed anything.
