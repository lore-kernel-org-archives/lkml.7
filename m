Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E9C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155920830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551649922;
	bh=KHZn34+J5WHRXxBZYJcuasDJcTwzC4kRbmL8UJ5ec4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PjpVvarsYH03FTggfKyDQZhEOuv1gIfLO0XJJTxmSOwBFYBKm0KDTg48vUMfOHzlg
	 rujYUDbHwyP1K+WkVWqK6d7s25KuXSsweOrXtU+lR2YoITb5E3CXVfI1gGWjOAc+tS
	 rTjtP4QKKHn8L5GmUYgZ2kFDlR5d8wE0zDDJdAZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCCVwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:52:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46870 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfCCVwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 16:52:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so2609187otl.13;
        Sun, 03 Mar 2019 13:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJAKWxNdLPhf1x4Xo3jWbcwM90lY4yAIGKFLWLrrhrY=;
        b=SWVneBRjyAr2/8tN8ZXYSD4dSBZue66eO2QMTAejlwFNzhUNyWDD343g5X3Zhm0x7k
         ei6IyedPx7/CpYJ2LmkGxS9/ilRTcNKU3jidlcYliOV0LuZDmiqEzvCo8GK54YLCZVFo
         qgMN9AylVNNJxiXyqcZPL0+TJwfBYlYIJT/7dC2MGonS+2FyXV6EcUdbg3ZaEf3SaKDD
         odxvBfU+TGqcz6DrSkt+eYKzNdai42j4Y2fSwBP5R2HwdBm3L6dABTEp0XA0j+eS78yJ
         PY1F9KM/EIdHW86Oj9gEjkWT32uKKcg2klkG3MaE66/nHWSJ30TJhYnW6gNwNEQLJqLx
         uW2w==
X-Gm-Message-State: APjAAAX3kiNztwKvuLwyS8jKmf+MaSbRc3v5usTr89sCfSBt21xXTTtk
        19hETdHYfgRkgWf8ZmTbHMvt9b8pUOYnAcbH7B8=
X-Google-Smtp-Source: APXvYqwjjms//CO56jgVmThqWeWVYhaUxnSxuU/Oi1g0CUtP2T5cxCBY2nKv/EuAjb9AS7IUC90/5hVmyiWiMGiN54I=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr10783966otl.343.1551649919266;
 Sun, 03 Mar 2019 13:51:59 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com> <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
In-Reply-To: <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 3 Mar 2019 22:51:46 +0100
Message-ID: <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 10:20 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2019-03-03 at 18:03 +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > This is how I would fix the issue reported in BZ 200759 (see this
> > > > patch series
> > > > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > > .
> > > >
> > > > Patch [1/2] causes intel_pstate to update all policies if it gets
> > > > a
> > > > _PPC change
> > > > notification and sees a global turbo disable/enable change.
> > > >
> > > > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > > > those cases.
> > > >
> > > > The patches here have not been tested yet, so testing would be
> > > > much
> > > > appreciated.
> > > >
> > > > Of course, comments are welcome too!
> > >
> > > This is the only platform, someone reported such issue.
> >
> > I don't think this matters.
> >
> > First, it doesn't mean that no other problems have this problem.
> >
> > Second, the current handling of MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > changes in intel_pstate is not sufficient if the changes is from set
> > to unset anyway.
>
> Any platform with HWP, you can't even notify of this change. So any
> platform beyond SKL is not useful.

Do you mean that HWP platforms don't supply _PPS (as a rule) and so
they don't send _PPC notifications?  Is there anything they do instead
of it?

That's fair enough, but the point is that the driver doesn't do the
right thing even if the platform does send a _PPC notification.

> Fixing is always good :-)

Well, I can only agree with that ...
