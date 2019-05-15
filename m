Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198EDC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB9320862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLY7sL/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEOKNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:13:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35775 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEOKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:13:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id a39so711860qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5vzb9qbv69BzC3TBeJnpXxGBryRXdu9w9fPfes2sXY=;
        b=bLY7sL/G7Yf8SOp3HqCiZL/Kxke2jlyjmhfdkXZ4DfcbDpQUZHQifT9d1Oju1FPBS1
         Ao0qSpfnJn6I8FO2jf0bAeMaODXJM/0x1q07MfRLBZQNVfB8nCoGWEWkc+S1GqGtDz0/
         9IVRpcLcC2qsGz8hm6MAWrHIShgSy/hOo2J4L6njeSF8PECmqnZATpyreRDrinDXpZEM
         VyaodUXP0ixgqtokO43Dj33+VD8/bq/nbt9LW1grUE3MS5DvJhkPVUlOhAcf/dI2mEkv
         h437g/Nz4hMvkLA4KLeNv3vuyGFSPBmO/HSuM1ElFU2Ncsx4PKs34PWYv6YY/FKawKcy
         IKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5vzb9qbv69BzC3TBeJnpXxGBryRXdu9w9fPfes2sXY=;
        b=pHXQ9SLdXI1mz19TwnLitMGfwk+3rNjVN4toq70tgZLydwpoqLL17eOn+20N1EJ1/A
         F42CTGF4zH8Vp6lt5KN+Gu03f3BP18TTxV2DvmvkkGwZJOV8TQO0uVoozFSpTMoaaHTp
         VOw2NNsuh8RnKAXZqN5elOUdOBzy0VbCYRgTVRRx+79YQ150bwvPpZQJAvP3AXEOYGmI
         ANUIoBMdRkGC64HLPjV1jJBW19qqTRjLcal1zs5O0IvSrhLjWv83l3gHIFeFnjhrnRmb
         uaor/1xE90bmmSQELvEg4cy7r+pgJDgbNJ+HDHrvw151VM/f+cKW9+8Fn3oYxGX1eniJ
         J78Q==
X-Gm-Message-State: APjAAAXF4F6wNMA5fDEYAduHnqyDXnygcWFIGq6O8ZlRv035nZ6LpAf+
        m54SnbiIHd7Eq5yqX1kcEoYVQtl5aiD6Hxfv357iKg==
X-Google-Smtp-Source: APXvYqzLBvSCbKg+8irN8jnpxztkevGoY93//8qdmVE2cBuZ3c+fv+koI6pSANU5lRp7y+543QI3+9VDjONgsSpz/bY=
X-Received: by 2002:ac8:3884:: with SMTP id f4mr35537714qtc.300.1557915210650;
 Wed, 15 May 2019 03:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
 <20190514161220.GC1824@centauri.ideon.se>
In-Reply-To: <20190514161220.GC1824@centauri.ideon.se>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 15 May 2019 15:43:19 +0530
Message-ID: <CAP245DWgfQakjXSTU2AfhkLOjAue83A-X6Qb40DC1QQj01GogQ@mail.gmail.com>
Subject: Re: [PATCHv1 4/8] arm64: dts: qcom: msm8916: Use more generic idle
 state names
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:42 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Fri, May 10, 2019 at 04:59:42PM +0530, Amit Kucheria wrote:
> > Instead of using Qualcomm-specific terminology, use generic node names
> > for the idle states that are easier to understand. Move the description
> > into the "idle-state-name" property.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index ded1052e5693..400b609bb3fd 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -110,7 +110,7 @@
> >                       reg = <0x0>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SPC>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > @@ -122,7 +122,7 @@
> >                       reg = <0x1>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SPC>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > @@ -134,7 +134,7 @@
> >                       reg = <0x2>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SPC>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > @@ -146,7 +146,7 @@
> >                       reg = <0x3>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SPC>;
> > +                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > @@ -160,8 +160,9 @@
> >               idle-states {
> >                       entry-method="psci";
>
> Please add a space before and after "=".
>
> >
> > -                     CPU_SPC: spc {
> > +                     CPU_SLEEP_0: cpu-sleep-0 {
>
> While I like your idea of using power state names from
> Server Base System Architecture document (SBSA) where applicable,
> does each qcom power state have a matching state in SBSA?
>
> These are the qcom power states:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/Documentation/devicetree/bindings/arm/msm/lpm-levels.txt?h=msm-4.4#n53
>
> Note that qcom defines:
> "wfi", "retention", "gdhs", "pc", "fpc"
> while SBSA simply defines "idle_standby" (aka wfi), "idle_retention", "sleep".
>
> Unless you know the equivalent name for each qcom power state
> (perhaps several qcom power states are really the same SBSA state?),
> I think that you should omit the renaming from this patch series.

That is what SLEEP_0, SLEEP_1, SLEEP_2 could be used for.

IOW, all these qcom definitions are nicely represented in the
state-name and we could simply stick to SLEEP_0, SLEEP_1 for the node
names. There is wide variability in the the names of the qcom idle
states across SoC families downstream, so I'd argue against using
those for the node names.

Just for cpu states (non-wfi) I see the use of the following names
downstream across families. The C<num> seems to come from x86
world[1]:

 - C4,   standalone power collapse (spc)
 - C4,   power collapse (fpc)
 - C2D, retention
 - C3,   power collapse (pc)
 - C4,   rail power collapse (rail-pc)

[1] https://www.hardwaresecrets.com/everything-you-need-to-know-about-the-cpu-c-states-power-saving-modes/

> >                               compatible = "arm,idle-state";
> > +                             idle-state-name = "standalone-power-collapse";
> >                               arm,psci-suspend-param = <0x40000002>;
> >                               entry-latency-us = <130>;
> >                               exit-latency-us = <150>;
> > --
> > 2.17.1
> >
