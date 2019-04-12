Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63235C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E8F205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dy58lTdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDLIAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:00:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45757 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:00:29 -0400
Received: by mail-ua1-f65.google.com with SMTP id c13so2927646uao.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhL6LONnkvIVp0AvYB18vhAHStJG1zjOEGpY9uUIPa0=;
        b=Dy58lTdhTzUOXZtqFPWtrxYCDOSeXk7qK0RM4+qgGI9Dhjwd9lDd87aQRP9f/U9tS9
         wUH6BBPXrnVcpajxSRFev12WOeqtnVuGiLMF+OFH8qy6FEL2Fbx+L33fX2CNvk9f5afn
         tufvfv+bd+76e9sglWxGhZjxbf/42L1KPdT2dHSbGZkaSgQyNKfJ55OdVGGLc8sI/0SC
         4urWlviPzBxvaR5avGXUxX0HHIOBYuZepumTggW/JNZjw3SsfkygykVFl7K25KeDzlOB
         eDFNGqKzziJMdEMTGQbv/HfsqqeR+v1EYoXLzoIJv/K4fhBQ3nLGDWd95JjsEaTZzc+t
         nCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhL6LONnkvIVp0AvYB18vhAHStJG1zjOEGpY9uUIPa0=;
        b=kenPyqrgN+BcMHZDm2hAV1mXI8rglhvX1VR/HYhCNLn117dE5M7FRKtNTfRfSSO7xl
         4wnyUuquF/YigU+hFZ/7JVMn80UDjANg/NxKFQPfVJg0QW0g3VRqzBj657LwQJ7bYT4d
         R1MY8wT0cbXzQaNOQd7OVonEngYrJm+PX1OV16IreE9Bhg7bjK87oOb3uSuOvGR76Jxh
         bbWdXiiCZ6wK/HFqAvDcvO+gvxqlI/B6vckcoJ7CXNAh6JbXz2bXvubx7N9YeL8ZLG9C
         sVwiKgkImpi5IBNf4ZATyiw04qBh9B4Ssmn66/oyNTzckrJO1whOrW9IbA6GOUxtrx2l
         l3uQ==
X-Gm-Message-State: APjAAAXboe/qoiPeMopaIQtwCakBPjTcxEclEFr9Yatrd2Nl1rnfH2uU
        L0geXYu/jpBVEzevUZPY2v5HnNq9BM7hvYUjPshpyA==
X-Google-Smtp-Source: APXvYqyNA9gGrxiVDy4z3apKD3I6B0Av50rojHvvN8/Dj124PwRTQ3xgVEKZOzszA3clDyxv7KvZSNuTgCxTzl6ajrA=
X-Received: by 2002:ab0:7486:: with SMTP id n6mr5073154uap.66.1555056028676;
 Fri, 12 Apr 2019 01:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190411181733.21437-1-ulf.hansson@linaro.org> <CAJZ5v0hVkgF2MYUh4VkXN0L2ZtxMoC8bUV6CY7=fAnSHRLpqUA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVkgF2MYUh4VkXN0L2ZtxMoC8bUV6CY7=fAnSHRLpqUA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Apr 2019 09:59:52 +0200
Message-ID: <CAPDyKFqesUc5PaZGvkMPcpiLUX1cRvFcSCVdv+p6LtpO4QpK3g@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] PM / Domains: Add genpd governor for CPUs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 22:44, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 11, 2019 at 8:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > After some preceding changes, PM domains managed by genpd may contain
> > CPU devices, so idle state residency values should be taken into
> > account during the state selection process. [The residency value is
> > the minimum amount of time to be spent by a CPU (or a group of CPUs)
> > in an idle state in order to save more energy than could be saved
> > by picking up a shallower idle state.]
> >
> > For this purpose, add a new genpd governor, pm_domain_cpu_gov, to be
> > used for selecting idle states of PM domains with CPU devices attached
> > either directly or through subdomains.
> >
> > The new governor computes the minimum expected idle duration for all
> > online CPUs attached to a PM domain and its subdomains.  Next, it
> > finds the deepest idle state whose target residency is within the
> > expected idle duration and selects it as the target idle state of
> > the domain.
> >
> > It should be noted that the minimum expected idle duration computation
> > is based on the closest timer event information stored in the per-CPU
> > variables cpuidle_devices for all of the CPUs in the domain.  That
> > needs to be revisited in future, as obviously there are other reasons
> > why a CPU may be woken up from idle.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > [ rjw: Changelog ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Applied instead of the previous version, thanks!

Thanks - and sorry for the mess!

When things have settled, here's the reposted PSCI cleanup series in
case it slipped through your filters.
https://patchwork.kernel.org/project/linux-pm/list/?series=103537

Kind regards
Uffe
