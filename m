Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9921874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvpMdZNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3LdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:33:07 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35627 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfH3LdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:33:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id m8so2204751uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JH8DOOwQtK+X7/b2daR7scxGJ6hjfD5whpOG26LXoDw=;
        b=pvpMdZNedhH1QV+sjozPkOnux4HLnj+LrfUwCIUPHZeKiDux6LH9ehglxbbUGDXs9f
         Ni9mO+JvsAt6qPEw0qayCxsa+bIqiFhxn4J6p0ZWpEmHHk6kA9ctfT6zWcH8z/Wu9cLu
         jEy4WymLK2uLBoeCX4kMxOflJGzYGFHOvzLNykjaSSFmTns/YlOkbDGkpAD1h1WE+Wy2
         kEcp2aVWfrDMiijlNScHwfa+8znc56KTQ5TJry8CYTccpsYv5CYjZOfK19bIXu8y4zoz
         oHq2/Nvg2J8yQ3/EdB+o+8Z3FivsvWNKu+cmLLT1bFbricqFrghabe4iWl1XyTtg562Q
         PdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JH8DOOwQtK+X7/b2daR7scxGJ6hjfD5whpOG26LXoDw=;
        b=iOgiCDkS/OmXURd6ueD2CqUROTEXmqjzCExLoYugVNnxPt56aZNKGshnnK/5oxU3um
         g7pWCVVNG1bnRrHL/BT3tsLK7WZ0zjJJnkxbGi0e3yS6r/TFI1+NaKdjOo/EJi+Bg+SS
         HlLX/lXXNHpUXTdiVXqCwYIRrztWqdCYkP0WMDsaJwgh0h+5EQ4lYOpIqX5pirKOauZH
         qXtNGqQlfRfLQra0Ficl4DFU1PIcZD/5bpbvqYQoPw2XQWcqDz6wRUmFHIyoDgVCq0Y2
         PZe3W7vEjA7nov9QEA2PTspQnwU+B3lN0LB8A8//ZIkik5igTF72IW4LnjMAXz8mVlZN
         Y6Eg==
X-Gm-Message-State: APjAAAXtjEuHqUFUhsC/FCTeUNN8k2c1ajQrdvQFiYwE0T1z/0pV8/+x
        tPVQSPdfQ/Eo3LVarVgSfhgcezipQBCAIS8MQQN+xg==
X-Google-Smtp-Source: APXvYqwyAJiFOtO3nVw0kssYOlaNRtyRQw23dVLbV/BrLdfGSdqNBeAYzUS2CZDujoGL8gkYKGoz2tZmIKXnUBI6x2E=
X-Received: by 2002:ab0:ed:: with SMTP id 100mr2070335uaj.48.1567164784854;
 Fri, 30 Aug 2019 04:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org>
 <5d65cbe9.1c69fb81.1ceb.2374@mx.google.com> <CAP245DWWKsZBHnvSqC40XOH48kGd-hykd+fr-UZfWTmvuG2KaA@mail.gmail.com>
 <5d67e6cf.1c69fb81.5aec9.3b71@mx.google.com> <CAP245DVjgnwGn5rUgbYrkBOi3vtyShz0Qbx_opx80xiOV7uXeA@mail.gmail.com>
In-Reply-To: <CAP245DVjgnwGn5rUgbYrkBOi3vtyShz0Qbx_opx80xiOV7uXeA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 30 Aug 2019 17:02:54 +0530
Message-ID: <CAHLCerMmBmS-59eywxkUJ+5-zSccx8Twx2=NELgBgShYhM7TOw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] dt: thermal: tsens: Document interrupt support
 in tsens driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:04 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Thu, Aug 29, 2019 at 8:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-08-29 01:48:27)
> > > On Wed, Aug 28, 2019 at 6:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Amit Kucheria (2019-08-27 05:14:03)
> > > > > Define two new required properties to define interrupts and
> > > > > interrupt-names for tsens.
> > > > >
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > index 673cc1831ee9d..686bede72f846 100644
> > > > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > @@ -22,6 +22,8 @@ Required properties:
> > > > >
> > > > >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > > > >  - #qcom,sensors: Number of sensors in tsens block
> > > > > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> > > >
> > > > Is it always one? interrupt-names makes it sound like it.
> > > >
> > > > > +- interrupt-names: Must be one of the following: "uplow", "critical"
> > >
> > > Will fix to "one or more of the following"
> > >
> >
> > Can we get a known quantity of interrupts for a particular compatible
> > string instead? Let's be as specific as possible. The index matters too,
> > so please list them in the order that is desired.
>
> I *think* we can predict what platforms have uplow and critical
> interrupts based on IP version currently[1]. For newer interrupt
> types, we might need more fine-grained platform compatibles.
>
> [1] Caveat: this is based only on the list of platforms I've currently
> looked at, there might be something internally that breaks these
> rules.

What do you think if we changed the wording to something like the following,

- interrupt-names: Must be one of the following depending on IP version:
   For compatibles qcom,msm8916-tsens, qcom,msm8974-tsens,
qcom,qcs404-tsens, qcom,tsens-v1, use
              interrupt-names = "uplow";
   For compatibles qcom,msm8996-tsens, qcom,msm8998-tsens,
qcom,sdm845-tsens, qcom,tsens-v2, use
              interrupt-names = "uplow", "critical";
