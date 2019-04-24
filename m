Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB97C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A46218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556090684;
	bh=EsxSRK8/upe+0gx1dmYaLZsXJf4CArnm6lZUDOqEQLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hqYCb7Ed45pFtgfTus34dSysZ796IcrrEfv4hMsqe4DWqLh/iTQaMmhZn4Fz3MgZr
	 0xBxdAJJsUnCoDmd9rbVSSqpa2o1iSi4u1vRPKNTdU4prLzFOZUzuhZV8wnrWezgFb
	 D1LY6OOsztPYU9C2+/cONFo8ynqsZ2VyOCqpz0SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfDXHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:24:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38339 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDXHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:24:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id a6so13465969oie.5;
        Wed, 24 Apr 2019 00:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpGazHaICUGeN5ZTD8i37y2fsljgc3xRCYjtV1tSsKs=;
        b=ZFKbzA0BgJirbcVkrYrHI6Tj5Q2bpW3Lnu6hos+Usl8Mub5al6WxnoEHu/TE+Dx7S0
         09aRuSLWIo8qVp1y6s/QU1j0mNSCgNvZOzNAlFG6U1Fqi9jNYizvvAfBI7MwoBpUfxQU
         +Q3FqrXHEeGgAUiKCD+2378MyhEhCW25dhx2KKr3C0M6RHZ4kEZVURfS18j99lKGWDc8
         hmA9mcjnHJE6sDW06rcRFPaOk2JA4L1wkBnyzD2Z/N0jiJQeyl2QOCI7b2lxY0XLS6aZ
         ERL5zT8MRMN9vvt/bQHt/B4NvuhcqnsXuGdwIVnRpaSm5yo090ScnwBIE0f7eElcwO2Z
         RIHQ==
X-Gm-Message-State: APjAAAVTpWILnHZJo4QFy9CMo9HVmNrnkcgtbh4fEJBIZWGTSq1lL2DC
        8NGr644ZddXYlyNzqccVmkpbeONgqI+Za6fUB7jgxw==
X-Google-Smtp-Source: APXvYqzkS27xtSRDhG+yQ/+cvIY9EB2w1qbGbCVO1m98fxmTpOQ2VxTDMJQdpNknoqEu6dEKhvG75iCnMms3AApgohQ=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr4246705oie.68.1556090682387;
 Wed, 24 Apr 2019 00:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190424023223.29614-1-andy.tang@nxp.com> <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
In-Reply-To: <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 09:24:30 +0200
Message-ID: <CAJZ5v0hSq60Hv44wOVr5J=rHMFUPFrVKxRYOS4w+zg90oUbMag@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Tang <andy.tang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> > From: Yuantian Tang <andy.tang@nxp.com>
> >
> > Enable cpufreq feature on ls1028a chip by adding its compatible
> > string.
> >
> > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > index 4295e54..d308c4d 100644
> > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> >
> >       { .compatible = "fsl,ls1012a-clockgen", },
> >       { .compatible = "fsl,ls1021a-clockgen", },
> > +     { .compatible = "fsl,ls1028a-clockgen", },
> >       { .compatible = "fsl,ls1043a-clockgen", },
> >       { .compatible = "fsl,ls1046a-clockgen", },
> >       { .compatible = "fsl,ls1088a-clockgen", },
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

So do you want me to take this one directly?
