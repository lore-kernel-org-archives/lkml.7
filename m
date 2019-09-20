Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EABC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769D8217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXyJSqQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfITWKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:10:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43259 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfITWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:10:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id b1so5691835vsr.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCFZWesuoMWk2xOc8j3X9ozx+lw44Tfj14q2/DLRH88=;
        b=TXyJSqQUncep29HPpehCd6YZ1iGmydZ7zX0gP0ZYT2TKlrhwSQEH1CFaKVuq/yjr+P
         7hUPz3nY2wYN8dNkk5pbx1BrVNQjtZhFK1T7cli0/Sv4M5g1hU6NwM/JzyKmz/8CZUPQ
         rBN4eVMQu+Ya/ScHMdQUsjRe5hwKLRO2sBE2eCYd+deRKSaKOAK8q/askOz0GJt/A0cr
         T5sL+sdTrRTGNiMv6arMN4MgQ1bpJniWzn8ChmKl9aNt347SOvUIGbvcdS+TFyQ3s95F
         fYcVjcCPfIXldCbIQGQ3jo/UxmKfjz032QTsVf39Ofa9XNbXx52q6xfezGbI2/OoKblb
         ClPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCFZWesuoMWk2xOc8j3X9ozx+lw44Tfj14q2/DLRH88=;
        b=uZ/FXC7jHAo8sCWDTuvvkvkvP0+THt/nyQt9VjLA0NQV6mUiFYOutF1XR9jVaUjO3s
         OYbORcn+lRoJNhD6r8TTnANX7dqloOajMsF7XPxMz6Wo78pUzHsePlhdztJ1AmRJ4vFU
         Z2NdjZctXqZQ7sSXEr2bYF3eFsbXfKl6WlReja9oLp+gbY3NwFaeW3LBISSzyX0YwivR
         /oz+kxwOv96j+MuhO88qDJ1EswGVIg6CSnz5vg1Y7aO9qSHFxx9sPxlrDToHHV9QocUj
         5PNQ9PPrQIW8chWE7ZJXyZN4DGbBlr6sT1M6P46xHDpYficjYZVUgm4tNFdPQcR1PVLj
         HBxg==
X-Gm-Message-State: APjAAAW4hiozo2TOjhspl2h+/Sefl8opUEkLtVu/j44F/UWLfus9o9WO
        GPl2a8W7WZtYWKxR0ZMKj4dSlfjgR2lann2M5yxyYA==
X-Google-Smtp-Source: APXvYqzMP0yDoV1F22GNCm2oIeyMpTWkrteFOfofvwbJ4rKk9KndnR5dvbPM7DiSHTHZvZdwfNbyqDX9nYmQbYu3PyY=
X-Received: by 2002:a67:2fcf:: with SMTP id v198mr4080245vsv.182.1569017402299;
 Fri, 20 Sep 2019 15:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569015835.git.amit.kucheria@linaro.org>
 <f627e66c455f52b5662bef6526d7c72869808401.1569015835.git.amit.kucheria@linaro.org>
 <5d854c82.1c69fb81.66e1f.96ab@mx.google.com> <CAHLCerPqEK2sSGGtDj85DH+qCzgtWi4ainuQv8BgQ3-Dgi93BQ@mail.gmail.com>
In-Reply-To: <CAHLCerPqEK2sSGGtDj85DH+qCzgtWi4ainuQv8BgQ3-Dgi93BQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Sep 2019 15:09:51 -0700
Message-ID: <CAHLCerPFXYy_udWtZZRvT2crCyXgvNf93HiDsrqjvTA+nfbC2Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] arm64: dts: msm8996: thermal: Add interrupt support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 3:07 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Fri, Sep 20, 2019 at 3:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-09-20 14:52:24)
> > > Register upper-lower interrupts for each of the two tsens controllers.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-------------
> > >  1 file changed, 32 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > index 96c0a481f454..bb763b362c16 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > @@ -175,8 +175,8 @@
> > >
> > >         thermal-zones {
> > >                 cpu0-thermal {
> > > -                       polling-delay-passive = <250>;
> > > -                       polling-delay = <1000>;
> > > +                       polling-delay-passive = <0>;
> > > +                       polling-delay = <0>;
> >
> > I thought the plan was to make this unnecessary to change?
>
> IMO that change should be part of a different series to the thermal
> core. I've not actually started working on it yet (traveling for the
> next 10 days or so) but plan to do it.

In fact, I was thinking of making the entire property optional, so I
started down the path of converting the thermal bindings to YAML but
haven't finished the process yet.
