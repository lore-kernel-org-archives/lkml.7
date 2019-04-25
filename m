Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D265C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C63820656
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556187261;
	bh=a22G66B5D/LmRZKM87Q8YD/ptccO6erKbrQ5kNn8BKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rdm2yIRIkb7cAnV7o0JNhudqK8xnFEN06LkGkm9jEK6dE5kAq6G/F8yQxbBHiVksP
	 Hdgl4GnLGnPXHf1NpXXPiuNCA3H3sLlHlZenbtqdLC8QubDenFoqEea1kwkAHbEpeN
	 hOOqQJ4GBkCN7RkVHS4Tzgt9AAYTYqZXAgINdEgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDYKOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:14:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46416 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfDYKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:14:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so5785766oie.13;
        Thu, 25 Apr 2019 03:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PFhRHLh905/ae2n9ldFIZhiiWQtx1no+9jBJyJ29Hw=;
        b=cE3FseffrbnqAEznhjHR1lwUVxJASt64koah1nGdUGQ07U9CTHFmA2RBhH+7G2LPem
         1noKcCvq0N3QhhhraYTo+fnFm94LZMX3s7snZuws2Pgw7eTpgjOHCCMXeCg7zdd/0EQa
         B64qzzVC4FgfjLK1mpxv0kvd3nixo9cVb9PnDbFpksJB0yooOCOXEgocwK3N/5YEKHUh
         R2LyztR1nzpYQO8Pv1GbOhm9qSES2rM0ri/yZfvyayZzcVrZYjkJEdhnXZLd5BWKVsqH
         0cKEnOQgtar403ijJhHjOflYCWTvDoGoK23Foh6UAlum+g/grDCaK6DdJ8IDaLzvi3iD
         NF7Q==
X-Gm-Message-State: APjAAAV5HD9LUto8cSFgbFrzjOj8sLTnqP8euIfW3jtN5QJVtFLvf5HY
        pklZdgmSd5gviP14QQRYqcnycEBY+CsfpcDszuM=
X-Google-Smtp-Source: APXvYqxR4nfgOudsylfecHigcgh+E+S0uhjeP+wNgjqANYOXzRk4nj+KoayVOgqpUynhhjaMVwV2hbrF0XsVXS8i8Tc=
X-Received: by 2002:aca:6c47:: with SMTP id h68mr2869874oic.57.1556187258168;
 Thu, 25 Apr 2019 03:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com> <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
In-Reply-To: <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 12:14:07 +0200
Message-ID: <CAJZ5v0jTRF1wvcYTxfSd59ByhnzXdLL8CVg1qnUfQhAj1L1qLA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Apr 25, 2019 at 12:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > > because of the virtual device that genpd allocates in this path.
> > >
> > > In this series, this limitation is addressed, together with a few other related
> > > fixes/cleanups.
> > >
> > > Ulf Hansson (4):
> > >   PM / Domains: Use the base device for
> > >     driver_deferred_probe_check_state()
> > >   PM / Domains: Drop unused in-parameter to some genpd functions
> > >   PM / Domains: Search for the CPU device outside the genpd lock
> > >   PM / Domains: Allow to attach a CPU via
> > >     genpd_dev_pm_attach_by_id|name()
> > >
> > >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> > >  include/linux/pm_domain.h   |  1 +
> > >  2 files changed, 36 insertions(+), 38 deletions(-)
> >
> > Are there any dependencies between this and the series you've recently posted?
>
> Yep. I should have stated that, sorry. This should be applied on top.

On top of which series?
