Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE1620862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8lxVzyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfENI6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:58:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33552 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfENI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:58:41 -0400
Received: by mail-vs1-f67.google.com with SMTP id y6so9836078vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLSCBYZPRnRjPoWF2biQlF2E7iPn0TGMhmM3d3DWvJk=;
        b=q8lxVzyzoXF98rEkWk5wquphTuXEip2RN7SWX+ji6R038d7laVaDsxolVn4Lifr3L4
         nDasZXSsGt9J3K/Dma2aHgNQXDd5PmwH0TmaWaaa1ielTpN5NpWI1KuO6GzoTid1P87V
         W+5QUyaNPx3uISiPfkM3GUlQFtkj6y4HL+j6jrliPgZKgTNgOWzvACEQGlWMm/hygShh
         Hk/tX4mdGKpaW3Nb3aJUV384CKlCitHayN9Zw9WXdnfRaWYon4saa+Za6XYQRGPeEULH
         F5R1ANYbch30daXqS7q1vJFNPngTOJVKDjhVvf3ixaqY34sSs44//FI0jLdvax1IQdpR
         9YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLSCBYZPRnRjPoWF2biQlF2E7iPn0TGMhmM3d3DWvJk=;
        b=NcstbSu+9AM0MBs3xqKpOhcnWVc4+rEAGF5sV6DPMSy2fMGYq2nNHFx5QhTuGWJhGb
         Y5YdZeY0MF2KPHtvZ9trIkQJWWsk/kkXd7dP1cA7PEgpeR9mMxiI6XVg/o8TMtCW41JM
         1EI5ubn9QA/UxhWtr3Zv/SPQZKoYOMYqGCDk6UFGhkN6dYiQU/pARIOcIkRE9IU+ZJBT
         8q4UFPVqdr+MlsZDKJ6HkDAUZCF6aSKC2H5PrKxwuHVzhBkSDYBv7MQyUomBgccJmKwt
         N9cXG1oWHSjFsELhu/3FqDZiG3aeempcJBfg0KHfOO1Ls4PPdwnfbhnSIn4XmJGjCqKJ
         /FxA==
X-Gm-Message-State: APjAAAU00plbp5BxDZoapDGzTSBVc0xjZpEpU3hhbe/KhDNRtgtVRPAs
        rmW+ef14Zya2zuT4tmE9noVgUUi0oUyBjHlOD24Iww==
X-Google-Smtp-Source: APXvYqwycH28jEcSrDkjPUkWW/Zcz25ycb6BQFN7+w/8A+3I/hQsVj2ek7HBD2590jjCbU0ruGu2wcP3lpcGlb4hlPI=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr13449930vso.34.1557824320126;
 Tue, 14 May 2019 01:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 May 2019 10:58:04 +0200
Message-ID: <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > recently was extended to manage devices belonging to CPUs.
>
> ACK for the patches touching cpuidle in this series (from the
> framework perspective), but I'm assuming it to be taken care of by
> ARM/ARM64 maintainers.

Thanks for the ack! Yes, this is for PSCI/ARM maintainers.

BTW, apologize for sending this in the merge window, but wanted to
take the opportunity for people to have a look before OSPM Pisa next
week.

Kind regards
Uffe
