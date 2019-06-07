Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E376C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639D214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zz2BQtsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfFGLT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:19:59 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37342 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfFGLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:19:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id v6so922197vsq.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4NS4GIrxZAsG8uWe3npx+I+Z55xA/6nCg36DRSR5Ko=;
        b=Zz2BQtszgGrubssBAWgUiM60O2iIdVTkeUPwM80SswhzRCB4r5dCNVh1317J2iTn2E
         nMz8pzbEa/5p0kRJ+WAwNZrBzc02/qm0JDO92qY9J5mFPdb4fJsQ95xElOU6fOfXo0It
         3QLI61/lXGJRWVYH3opjylpwSlgcPfevGBilKS5VMrmI8vXvd62UMLKKdXRhmVKFaBfN
         g6m7CvsQB9SWjxsluHYVbHPaffDmzjUOATrcRORvD7Oe1Vok8NBqXpDxppsSjWsX/NLB
         9nwuy516H/U94g13hV3hg2cAffFDX7oKDf8OJaIiBkwmUdMzRR/4N9/Sc9fQpQp8869g
         tdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4NS4GIrxZAsG8uWe3npx+I+Z55xA/6nCg36DRSR5Ko=;
        b=pGBsMm4SDBKBM1aCj/+o4G2TA1wSqsZspz+t4jwNlJLrDAnVherrq9Rrl1ZslmiEu3
         yGcFE4cjhux3Kj9t+2cxnpOjpopcBc0sbGCUhK8X/lna6JR5+QXFXCGJOXLI4QdIiXuu
         ZSPlSnJjnmdRd93IVQ0F2whDrFzhkE27jXB7XejMJNYTYrzRii7rdcJWeMhi2iSBU2Zc
         kNb2fn6YiKiqAfzpeaS0WS4JetWEVIpsYYMKwOHrqiv0OaSX4NMB5qyb9u9VbAO/zcuQ
         UavGDPs0iPDlq8rs8qK1y7mCgEYefZHzMSd0oPdpI6PW8syUNFIU0heiuDa/srw8zCXz
         NlDg==
X-Gm-Message-State: APjAAAWrDx2use5AC9bQejHe8KKqAlzS99DiRHPzXJ4e5ro8Ob8olwiu
        D2aXNZtHtC48WuFA0LBf7DtTgnmQHDdGhrQt678V3Q==
X-Google-Smtp-Source: APXvYqxJ5Ur/WKk3GslZ+PDxWcG90kOHvxGy+wa7gr6wMTrbViJkGVWxDEzEvNOs4w39xZTxA1LeReQvz0A4eafkN+o=
X-Received: by 2002:a67:706:: with SMTP id 6mr11498566vsh.200.1559906398328;
 Fri, 07 Jun 2019 04:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org>
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jun 2019 13:19:22 +0200
Message-ID: <CAPDyKFo6Hkw=6iAq8fCEKARXeOiFp9C8FrJ4D_r0PoDFASSDRg@mail.gmail.com>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

Sudeep, Lorenzo, Mark,

On Mon, 13 May 2019 at 21:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This series enables support for hierarchical CPU arrangement, managed by PSCI
> for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> recently was extended to manage devices belonging to CPUs.
>
> The last two DTS patches enables the hierarchical topology to be used for the
> Qcom 410c Dragonboard and the Hisilicon Hikey board. The former uses PSCI OS-
> initiated mode, while the latter uses the PSCI Platform-Coordinated mode. In
> other words, the hierarchical description of the topology in DT, is orthogonal
> to the supported PSCI CPU suspend mode.
>
> Do note, these patches have been posted earlier, but then being part of bigger
> series, which at that point also included the needed infrastructure changes to
> genpd and cpuidle. Rather than continue to carry the old version history,
> which may be a bit confusing, I decided to start over. Although, for clarity,
> the changelog below explains what changes that have been made since the last
> submission was made.

Is there anything I can do to help the review to get going here?

FYI, I hosted a talk about "cluster idle" at OSPM in Pisa a few weeks
ago. There is a couple of slides [1] with flowcharts of how it works,
that may be of interest for you.

Kind regards
Uffe

[...]

[1]
http://retis.sssup.it/ospm-summit/Downloads/01_02-ClusterIdle_UlfHansson.pdf
