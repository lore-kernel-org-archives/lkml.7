Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD607C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC83D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3s9VjML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDLMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:37:43 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44381 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDLMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:37:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id j184so5415922vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDbSkjO31HmcjPpvT5mDG/vFmxaY05rxs+PGYVPbuxE=;
        b=u3s9VjML9yH8TcaoqcwGcwYxQ7E9aem1ukThaeShLi866YWHaCD9dPjRj9Nh4jRxED
         2mqc/khGIm/1Rp/AYp1jIUcXDivx21Zlmx3EsaxzOSeuZ856iGM9Hh8T3Kjs/Ml6PvrI
         aQEbUaDYhzso0jEIO5jaQ191wgLInSXTmY2l7FV/lR164Enlrgad8n5QAeNJVBGAoXZc
         ZGYNSS+olTEcnX2s5xjYF6FNbdaAKU17pFewRpKOzOwgR67DXVSE03Ebgw/1rkCEacCL
         PHmp3s2TCE93i8XX2RiXB58vGUK8AKS6cvzJRiYtmDLRXZqL970BSo4TzqypzMxv9+Wo
         O+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDbSkjO31HmcjPpvT5mDG/vFmxaY05rxs+PGYVPbuxE=;
        b=hHg0bN6W/Ur/lSz3e1oah7JLv4ZsLY6x9SG722pWD/9n/4gN56PX1PkkdMmm2ETWA3
         SqznjlpgUYj1HIP6QDYJCsSPndlckgxnRN5QqYkTd7e92nKFdDeWcO+K52iG1awMt70w
         AglZ6QAk0/x6/n/2SKphpySxJ5UFruH+8WGkjTVQplHuN8zRNeAX0Fb+9/gqZvQV6n7y
         s/IbBj5Xg9sq8aCYvkaMvPUFEAe21mPLqUDsHRU+6YFo18Z3kVBbyKI62XoVsuvQJxbd
         N19L67neC2NMW4OZoRNPJ71atgFktZnCC2KqrkYPR9Pm7iAguf46Y3mpx+Y58thYtEAd
         ybhA==
X-Gm-Message-State: APjAAAXhWy1ERCPRU7NSnSvqirQoL2xyWTV+RVzPG0hNdSoZmI+YNMcI
        hVx7AIWmQ8Fymy2nuYHu3UaHB9v117jYTnt6cDDaNA==
X-Google-Smtp-Source: APXvYqwbCPWGayb6hRGIXjLyN5xJGilWuZMosEY6osRIErdSnbSGLFPRyyz2b8fGR7dTaOLL9yzN1rHIiFhv4cBnb/M=
X-Received: by 2002:a67:2e8c:: with SMTP id u134mr31333926vsu.57.1555072662007;
 Fri, 12 Apr 2019 05:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100227.15024-1-sudeep.holla@arm.com> <2000694.m04KBuNrDd@kreacher>
 <20190412101522.GB12424@e107155-lin>
In-Reply-To: <20190412101522.GB12424@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Apr 2019 14:37:05 +0200
Message-ID: <CAPDyKFrM8hc36vp=2h1CHBZKapy1q242JD3Y5SfrCg-KWA-twg@mail.gmail.com>
Subject: Re: [PATCH v3] firmware/psci: add support for SYSTEM_RESET2
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep, Lorenzo, Mark

On Fri, 12 Apr 2019 at 12:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 12:10:45PM +0200, Rafael J. Wysocki wrote:
> > On Friday, April 12, 2019 12:02:27 PM CEST Sudeep Holla wrote:
> > > PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> > > where the semantics are described by the PSCI specification itself as
> > > well as vendor-specific resets. Currently only system warm reset
> > > semantics is defined as part of architectural resets by the specification.
> > >
> > > This patch implements support for SYSTEM_RESET2 by making using of
> > > reboot_mode passed by the reboot infrastructure in the kernel.
> > >
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/psci.c   | 24 +++++++++++++++++++++++-
> > >  include/uapi/linux/psci.h |  2 ++
> > >  2 files changed, 25 insertions(+), 1 deletion(-)
>
> [...]
>
> > > --
> >
> > So I queued up the PSCI series from Ulf which clashes with this patch.
> >
>
> Ah OK, I wasn't aware(just back from holiday) that it's going through
> your tree. No worries, I will rebase and repost soon. I want testing
> by xilinx or Aaro Koskinen before that.
>
> > I can take this one too, but I'd rather avoid becoming a PSCI maintainer as a
> > result. :-)
> >
>
> I can understand, I assure it's one off :)

Speaking about that. I would gladly help out to host a git tree to
collect patches that you have acked. In this way, we can, for example,
get the patches pre-tested in linux next before we send the
pull-request.

If you think sounds like a good idea, just tell me so I can prepare a
tree for the next release cycle...

Kind regards
Uffe
