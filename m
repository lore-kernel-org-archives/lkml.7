Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB70C28D16
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7486B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOl0u/Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfFJKWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:22:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35000 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388937AbfFJKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:22:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so4979176vsu.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFMIIVsyJBl8LZ+WUnN+JflDTkBBRBPq/m9+UsHc1js=;
        b=kOl0u/Rhe57ubEv7N22/9aZ//K3tjzZfW3Py8ox3gbRPJ6UjiUgoBGpilHmu/nCgmF
         Ll1a6TJ7+gn0FAn103tRUjuk892mvZfOsB00cLYygk5yPXdQvJrPnZIpzYG3zXELtLMJ
         NLCtkLm8RZc0kCi5TJQfbd9CP/i/0rIJmiJvP1UXVlh0gR4m02y3koKodB6L+b382pE0
         M3zkVPlISPXoI3B7+3H/4zEB5JxriVTdDltIcyAUw50l/asQ0SrKbfQjTlnP9OKVTAjE
         njP6gb75FZQe1lldrnZ7yn8rRe+wgtVpTZ0/WmG3SePMX0wfqy+bDDbLj459+WuP2TPZ
         aefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFMIIVsyJBl8LZ+WUnN+JflDTkBBRBPq/m9+UsHc1js=;
        b=GrMESPKt9BlQHWMLe3hp78ZmZA+TNaMXlYsBnjFPe+g4rdUgIOUpBfKzUT0/+kwc/l
         syQEEWKln4vT2rvWPfpc8N287YJm+e+kbcRocjf5oWqtUto/VETWeIsvnL9mdW5n58ZA
         qC8VFMWdZTMK6ftNl7cuuKfNqUnQd5mTRo265BaJkO3sAKSNKpUP9FNxEPPKm92E3JlF
         Hs6FtbvRQPLLAH+WdrbWGkOz25kpTP2iDPD9HlRuynxS2wOHDvDlSRNNMJgVB3mIOqQv
         8GbBfyp9v7RUeavjz1Eu+9aelBOutPILMJBCKj1p7BmziZpBh2kbFEZqrl3b93QAWF+s
         CPtQ==
X-Gm-Message-State: APjAAAUOvCSONrgBO0cZvRfgyRID8+cbf56mDupkvlaXfOVfvAKMEbb+
        vxuy39iPcE4RdGP6X0oFBHEFkbYYuR/mihCF/AX9vA==
X-Google-Smtp-Source: APXvYqxDX2qJsmmcFSXEA/D7lgBIhL5BcM//GZ2Awrb+ANPG1PdpnIRRbG98Nj437OF6HC5C/S/rLx9BEVMrPwv/lGw=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr24379568vso.34.1560162143163;
 Mon, 10 Jun 2019 03:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-16-ulf.hansson@linaro.org>
 <20190607153114.GI15577@e107155-lin>
In-Reply-To: <20190607153114.GI15577@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 12:21:47 +0200
Message-ID: <CAPDyKFqooMww0B6vGL56BnG-L=13C3oWeDFx4v1cO9=W9QPwVQ@mail.gmail.com>
Subject: Re: [PATCH 15/18] drivers: firmware: psci: Support CPU hotplug for
 the hierarchical model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 17:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:57PM +0200, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU has been put
> > offline (hotplug), that same CPU prevents its PM domain and thus also
> > potential master PM domains, from being powered off. This is because genpd
> > observes the CPU's attached device as being active from a runtime PM point
> > of view.
> >
> > To deal with this, let's decrease the runtime PM usage count by calling
> > pm_runtime_put_sync_suspend() of the attached struct device when putting
> > the CPU offline. Consequentially, we must then increase the runtime PM
> > usage count, while putting the CPU online again.
> >
>
> Why is this firmware/driver specific ? Why can't this be dealt in core
> pm-domain ? I am concerned that if any other architectures or firmware
> method decides to use this feature, this need to be duplicated there.

What is the core pm-domain? Do you refer to the generic PM domain (genpd), no?

In such case, this is not the job of genpd, but rather the opposite
(to *monitor* the reference count).

>
> The way I see this is pure reference counting and is hardware/firmware/
> driver agnostic and can be made generic.

As stated in the another reply, I would rather start with having more
things driver specific rather than generic. Later on we can always
consider to move/split things, when there are more users.

In this particular case, the runtime PM reference counting is done on
the struct device*, that genpd returned via
dev_pm_domain_attach_by_name(). And because
dev_pm_domain_attach_by_name() is called from PSCI code, I decided to
keep this struct device* internal to PSCI.

Kind regards
Uffe
