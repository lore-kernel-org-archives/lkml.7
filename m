Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E6217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeZ+7OWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfDYKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:17:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37140 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfDYKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:17:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id w13so12168172vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qn/SF4zlnh80BFSu2CN+Y7IwAK3J6GVY5aWJJEJAYAA=;
        b=JeZ+7OWGWlKsNSaekRzj0MzezMET5nOOS29O2Xphfn8tNjQArrpqOmKc2MD6uFq8fF
         TW7dikZYa5X8b0MtuTXxLqXbsXYKfNs7cx87FjBC3KZfPJg7/CtgTB8lW0mvmaFEH3L5
         kP6Kfm/1nDmEOC46Mdvvee9D7/V/QJN8CdbNtXtEFTbBP0DUFFmAzZF+Oq82DQScDa58
         TVzA5RbXwdwTBLbKeRARE9Z2MWMif/G4kGTP2GUxl8hsQfzR8SVL8qBHq/jJDv4ddzt+
         oaEB0/dQ5JkNrQL9Ml5BP5sqEL2B99/DSoxUABRNJHOsEFRo3QU7Ptm5zSeVcUHgISie
         GrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qn/SF4zlnh80BFSu2CN+Y7IwAK3J6GVY5aWJJEJAYAA=;
        b=QhQaZftM3vCoups4rkOpWggRdXYuM+NwMqn3w2QjiSTi0HM34EoQwfyf8nH68oC+Fk
         hPoYE/C2vfkJOVcK74u5Dk9c/b4WHMaxEH5nhgvC1SCJCvY8P4nNUPPSrbxZqRUr5uOD
         5MZI/5WFVidFHLRqV8Q9zwqp2vgnbL2PpMbH48qlrCflgctwxd3QopN9Hc5Tvy/xJoEu
         YG9OcKE9lTuKuKDAufb9epzlfmTF0daMKzOvwBRpE/AkPyGev9QFdEkzIGgN4Dl2+ant
         zNlf1wodmw54QLuZAq9MAeSQ7/VzsPEds74z3VtCq9CHthwU11G0NVMFIkUTjKlWdDqQ
         9zYA==
X-Gm-Message-State: APjAAAXCq+1TwNnVsB+fdb3OqdGPc5F5A7pHCXHCsf1yAzletDywENso
        RWxXvTu2sGThatfZ29h5/3pOeq6fyb6AJFzruzTaKw==
X-Google-Smtp-Source: APXvYqwN5exsxQWvoie/R8JMCwT8MPM1SUzccjeZD3QDLaM29ui1bFgQ1CEmR+rIKQ0rFF3f/6+s/VHeTgEofKv7xYY=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr20304309vso.165.1556187468216;
 Thu, 25 Apr 2019 03:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
 <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com> <CAJZ5v0jTRF1wvcYTxfSd59ByhnzXdLL8CVg1qnUfQhAj1L1qLA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTRF1wvcYTxfSd59ByhnzXdLL8CVg1qnUfQhAj1L1qLA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Apr 2019 12:17:12 +0200
Message-ID: <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 12:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 25, 2019 at 12:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > > > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > > > because of the virtual device that genpd allocates in this path.
> > > >
> > > > In this series, this limitation is addressed, together with a few other related
> > > > fixes/cleanups.
> > > >
> > > > Ulf Hansson (4):
> > > >   PM / Domains: Use the base device for
> > > >     driver_deferred_probe_check_state()
> > > >   PM / Domains: Drop unused in-parameter to some genpd functions
> > > >   PM / Domains: Search for the CPU device outside the genpd lock
> > > >   PM / Domains: Allow to attach a CPU via
> > > >     genpd_dev_pm_attach_by_id|name()
> > > >
> > > >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> > > >  include/linux/pm_domain.h   |  1 +
> > > >  2 files changed, 36 insertions(+), 38 deletions(-)
> > >
> > > Are there any dependencies between this and the series you've recently posted?
> >
> > Yep. I should have stated that, sorry. This should be applied on top.
>
> On top of which series?

[PATCH 0/3] PM / Domains: Improve support for multi PM domains

and

[PATCH v13 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)

Kind regards
Uffe
