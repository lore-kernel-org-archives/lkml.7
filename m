Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2020C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947FC208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg0uHGtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfITWHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:07:40 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38743 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfITWHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:07:39 -0400
Received: by mail-vs1-f67.google.com with SMTP id b123so5715021vsb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03nfbfvsWWjjBwaHeiInD+GImNWbMhv6TdWghMdfSkE=;
        b=Fg0uHGtz9xrUmln9AWbT87mBPHsSYrvhbyp/Z2l6q5JCSTHmZmnE9NH9JbgABUqdaG
         gUjQSZgrNY0gvGOAiTX28wb9Vj6Rd+qUyBxBIQ2L4UWajRAzETrapZfKgVIt8Hf+QitM
         wGvL/Do5izdrq3ar6vEU5LHT87nhE2ihqb9u+Uq3pHX34e51aW7KNC4EOeo31piZB68x
         Y9wasNwm7hMgASdBb+p7pBu0h6BWMY324irB5UQC6fqLt7K6GZqYYQvAnmSJ35AZW6/0
         eR7lupLa5YgTGE75XoBK0N+zZaOjCC15N58CwMSQRmjdbBHrvl9QAY1J4zoC1tN0XTH9
         g/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03nfbfvsWWjjBwaHeiInD+GImNWbMhv6TdWghMdfSkE=;
        b=rDe/B3+aETvNEl+I99nR++loGrGMY/2LVYnJC5aybUyVvAMMvI43DxnQlLcvcNN2G/
         wH4Co6mwRCsRl351flZQngUV9vgQMxXSczrGz8NKkZnLxWOu5phyvNLPnl0oT3bSlIlN
         dOa8VKxhWK7gK1YEQ1diccCXntY8kb5lTZH6j5pDFHNX2V+BNravABNw1XPRDz/e55h4
         MbRB5SXInd8M9+LKm2tajoWFFXnY6UbR9cjhXpnD7f33kfdhiSO2JNWRHEMJwinLfoMD
         rsrf7N6fxT1bEcuy2rZXCwBtgicoY884WNnGQ4bTtpc9ub/Z1AwpaWl1LbxR1r9+bYNP
         cxzA==
X-Gm-Message-State: APjAAAXFcsoVXuH6EMbCiE7KHYMppl+W3YjrgkSarct6iSUt18Rullym
        IzANR/nkipouSlmvM2mm/QZyFz6NDgiOYLyGHsXUPQ==
X-Google-Smtp-Source: APXvYqyqthmZ/2dM7Axc4UDmIh60LcEGo84Gs0A+ZlbPDaKhFus8SJNw2ooezgIRH2f6v083XtEVhrMYLS8fTXPWU4w=
X-Received: by 2002:a67:f058:: with SMTP id q24mr4000012vsm.27.1569017256934;
 Fri, 20 Sep 2019 15:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569015835.git.amit.kucheria@linaro.org>
 <f627e66c455f52b5662bef6526d7c72869808401.1569015835.git.amit.kucheria@linaro.org>
 <5d854c82.1c69fb81.66e1f.96ab@mx.google.com>
In-Reply-To: <5d854c82.1c69fb81.66e1f.96ab@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Sep 2019 15:07:25 -0700
Message-ID: <CAHLCerPqEK2sSGGtDj85DH+qCzgtWi4ainuQv8BgQ3-Dgi93BQ@mail.gmail.com>
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

On Fri, Sep 20, 2019 at 3:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-09-20 14:52:24)
> > Register upper-lower interrupts for each of the two tsens controllers.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 96c0a481f454..bb763b362c16 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -175,8 +175,8 @@
> >
> >         thermal-zones {
> >                 cpu0-thermal {
> > -                       polling-delay-passive = <250>;
> > -                       polling-delay = <1000>;
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
>
> I thought the plan was to make this unnecessary to change?

IMO that change should be part of a different series to the thermal
core. I've not actually started working on it yet (traveling for the
next 10 days or so) but plan to do it.

Regards,
Amit
