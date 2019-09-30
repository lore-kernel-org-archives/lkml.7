Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655E9C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9621855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUyRV9cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfI3Woo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:44:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36336 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbfI3Woo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:44:44 -0400
Received: by mail-vs1-f68.google.com with SMTP id v19so7993407vsv.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/2IGqkcJxyCfdXVhyfUjNS/geJP3ljERdNj2BWoXsI=;
        b=oUyRV9cBkkkJ238JMstI0DdwTEnHLOMmk7p0pAeK/otfxi+PYeGve1JVKhGcSbwAsR
         CSu8CVq53LDVDBpdq68Vide0GWDTg6SxzAWmZ8HUjVmgywKhOqqFOIx/s2JQ23bHpixT
         PVOqdQ9XsD/nhCYxAO+jahlCJV4O25PbdASrh/bdIvP350tciLMBx/vdKxRaWxYqnJOp
         EixyppQGewnOSKTGeQ74o0JTEQCDzGb/9LioyeEW27yDOeoJHC+tFDJLIX43UNxeIT59
         LLC4yp6CdkXMcOC2X4wnR3Tgl0HRRYyG+GJMQQAOk898MKVC2yP2OliExODnacQh08Ar
         O6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/2IGqkcJxyCfdXVhyfUjNS/geJP3ljERdNj2BWoXsI=;
        b=GWBtzYEhl/WONUwzLN3mpZEbxK1N2jiQWKVTun3jyOf2r6Ug3McOQD1M43gzpt5Rmv
         ujis965m7weiKIUGMHAFl9tX4nVUR4EE4ITIKve/4e0QJzKfU7PeMDdlaxha6G8jWfzx
         c8rKPtsJJ9UCyH8jrwtMhJe/ZJk6IXfQZPh8ZokQlubZMwe4r+vzhagCt2nJ1zun2ri4
         HkZaWc/Rj2ArEWyUZ29Fy76Pn6Trm5NA29vJuYyTLCM155oZ/LooiPYBpGbM3BHxI0td
         bQIKWVUxAFdBjXEFXoIIfUWqk/i9HTGLd/UtEwXzHxYYQYVFwVGkjWsUEqyvEUzIfJ/6
         xTWA==
X-Gm-Message-State: APjAAAXOnjRChLRzRqNyxL01HEL3NXdL4uk5up/4buEtVRrpOSV2WN20
        tuyQ0G26ewHGlk/SuBPZdb8t6XlfXWhAN33i1dlLng==
X-Google-Smtp-Source: APXvYqwQIYB8itddzoh5/J4SJx8QLazwMpE1zHpLumKYYuLabOa9Zhdm6JeD37Zk0WNrsiC7dZ+AhT+pYp2toNtojuQ=
X-Received: by 2002:a67:6044:: with SMTP id u65mr10627844vsb.95.1569883482533;
 Mon, 30 Sep 2019 15:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <49cf5d94beb9af9ef4e78d4c52f3b0ad20b7c63f.1558430617.git.amit.kucheria@linaro.org>
 <CAOCk7NptTHPOdyEkCAofjTPuDQ5dsnPMQgfC0R8=7cp05xKQiA@mail.gmail.com>
In-Reply-To: <CAOCk7NptTHPOdyEkCAofjTPuDQ5dsnPMQgfC0R8=7cp05xKQiA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 1 Oct 2019 04:14:31 +0530
Message-ID: <CAHLCerOS1Hi3XdDZzTKFKnrsATj5cMKtjPEuJknWu-aPtwzP9g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Sibi Sankar <sibis@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try removing just the *SLEEP_1 states from the cpu-idle-states
property? I want to understand if this is triggered just by the deeper
C-state.

On Tue, Oct 1, 2019 at 3:50 AM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> Amit, the merged version of the below change causes a boot failure
> (nasty hang, sometimes with RCU stalls) on the msm8998 laptops.  Oddly
> enough, it seems to be resolved if I remove the cpu-idle-states
> property from one of the cpu nodes.
>
> I see no issues with the msm8998 MTP.
>
> Do you have any suggestions on how we might debug this?
>
> On Tue, May 21, 2019 at 3:38 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Add device bindings for cpuidle states for cpu devices.
> >
> > Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi | 50 +++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > index 3fd0769fe648..54810980fcf9 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -78,6 +78,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x0>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >                         efficiency = <1024>;
> >                         next-level-cache = <&L2_0>;
> >                         L2_0: l2-cache {
> > @@ -97,6 +98,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x1>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >                         efficiency = <1024>;
> >                         next-level-cache = <&L2_0>;
> >                         L1_I_1: l1-icache {
> > @@ -112,6 +114,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x2>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >                         efficiency = <1024>;
> >                         next-level-cache = <&L2_0>;
> >                         L1_I_2: l1-icache {
> > @@ -127,6 +130,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x3>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
> >                         efficiency = <1024>;
> >                         next-level-cache = <&L2_0>;
> >                         L1_I_3: l1-icache {
> > @@ -142,6 +146,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x100>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >                         efficiency = <1536>;
> >                         next-level-cache = <&L2_1>;
> >                         L2_1: l2-cache {
> > @@ -161,6 +166,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x101>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >                         efficiency = <1536>;
> >                         next-level-cache = <&L2_1>;
> >                         L1_I_101: l1-icache {
> > @@ -176,6 +182,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x102>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >                         efficiency = <1536>;
> >                         next-level-cache = <&L2_1>;
> >                         L1_I_102: l1-icache {
> > @@ -191,6 +198,7 @@
> >                         compatible = "arm,armv8";
> >                         reg = <0x0 0x103>;
> >                         enable-method = "psci";
> > +                       cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
> >                         efficiency = <1536>;
> >                         next-level-cache = <&L2_1>;
> >                         L1_I_103: l1-icache {
> > @@ -238,6 +246,48 @@
> >                                 };
> >                         };
> >                 };
> > +
> > +               idle-states {
> > +                       entry-method = "psci";
> > +
> > +                       LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > +                               compatible = "arm,idle-state";
> > +                               idle-state-name = "little-retention";
> > +                               arm,psci-suspend-param = <0x00000002>;
> > +                               entry-latency-us = <43>;
> > +                               exit-latency-us = <86>;
> > +                               min-residency-us = <200>;
> > +                       };
> > +
> > +                       LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> > +                               compatible = "arm,idle-state";
> > +                               idle-state-name = "little-power-collapse";
> > +                               arm,psci-suspend-param = <0x00000003>;
> > +                               entry-latency-us = <100>;
> > +                               exit-latency-us = <612>;
> > +                               min-residency-us = <1000>;
> > +                               local-timer-stop;
> > +                       };
> > +
> > +                       BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> > +                               compatible = "arm,idle-state";
> > +                               idle-state-name = "big-retention";
> > +                               arm,psci-suspend-param = <0x00000002>;
> > +                               entry-latency-us = <41>;
> > +                               exit-latency-us = <82>;
> > +                               min-residency-us = <200>;
> > +                       };
> > +
> > +                       BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> > +                               compatible = "arm,idle-state";
> > +                               idle-state-name = "big-power-collapse";
> > +                               arm,psci-suspend-param = <0x00000003>;
> > +                               entry-latency-us = <100>;
> > +                               exit-latency-us = <525>;
> > +                               min-residency-us = <1000>;
> > +                               local-timer-stop;
> > +                       };
> > +               };
> >         };
> >
> >         firmware {
> > --
> > 2.17.1
> >
