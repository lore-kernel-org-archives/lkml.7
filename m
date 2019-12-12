Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C50FC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA6214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="jCiBa2OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfLLQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:56:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37976 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfLLQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:56:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id y195so2062809vsy.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XX6BrAItU8v/kOi+ACqiURlUB/V6CjbYP6V9AUxPwzI=;
        b=jCiBa2OQ+6F9W8XOpKq9C6kUmGb4UM8B9RlqTrbXA3PeSUm+DIu6VfUjnTpgzpchOR
         PwikFEUGPBfOY1BcRheFDz5q4T4x6OWa0rY73lhN5CpwCXSnCwkaEtDFIu7kqxBkx4dd
         zI00qay8Uzzb+oB0G+3pQiUNTEYQA+iqF/Gkg6nGIZf4PpZk7AI71ToiDhp9Vy0D3Weq
         QXDPdN03N2nlsGyprJ8jQ+JcTOL+KZrHh1Z8+G9Vo3riav3MA1HpPKkErPNAmHR+ehom
         4AzJdzdGhWjY3wJdG5tgqRUKNC5HKEAsxoFTXuflvzFPUW14s6VOAU6JqebdZqv8Syjh
         QZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XX6BrAItU8v/kOi+ACqiURlUB/V6CjbYP6V9AUxPwzI=;
        b=eB/JSl0pfB+JR8YrHxcuCffdqL5NeK4g8/avfiYuI8cgIjBLGDd47/mbHxh7Rf0LN/
         1A43H2zW60EMaOsfJUrpj0AZrAyfbV/xs+hvZm1WkOHFOSHk+/PsvECsDBVko8X1eTpN
         fWzLt38PMi74vOpDLDL7HVyFqerQm2S7KRK774Xc2Fl8X34gxj84M3Bd0MVXVcu2DMWi
         WzZ8ZTs4ofwcMILtUXWy2baA0LgzIefZ/x37VQOam0tnxRwWJRLIsrgHXK0GlHc+64e7
         qw+c8G542dMXb1SDwAx20lNWiqaVg5hwFV7uW0+scivh7cdqjrK0at+q3/aYyoJT7K9K
         W2PQ==
X-Gm-Message-State: APjAAAX8u1Na1rsA4ZEwPmh6cjtV+QqO679/Ua7OMr+spnki2x8bvMXZ
        Gz1JQAw1EjKDMuEsY63QN3FmwJqTbzy8wGuKMi4xmA==
X-Google-Smtp-Source: APXvYqwIYF4ycBEfeDnSEX4wtrfkl41k78h32ELjJrH1aPf8wZcDdfzkkmemsHW2HsfV69FZusYgypSl7d8cc9rLT2M=
X-Received: by 2002:a67:fb41:: with SMTP id e1mr7425084vsr.159.1576169788119;
 Thu, 12 Dec 2019 08:56:28 -0800 (PST)
MIME-Version: 1.0
References: <1574934847-30372-1-git-send-email-rkambl@codeaurora.org>
 <1574934847-30372-2-git-send-email-rkambl@codeaurora.org> <CAHLCerOVH1xLjMmDNFVx=YYYTA3MipaOhHZ-AYtxEnDFgRbSJg@mail.gmail.com>
 <CAD=FV=UDGcnLLkBiTBr5GgrzNH20qf9pDQW8wdoqsbO4832M4Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UDGcnLLkBiTBr5GgrzNH20qf9pDQW8wdoqsbO4832M4Q@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 12 Dec 2019 22:26:17 +0530
Message-ID: <CAHLCerPKC2dK0Baom9MguvUfD0L--EeuLYnLnQENis92uzKbgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sc7180: Add device node support
 for TSENS in SC7180
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rajeshwari <rkambl@codeaurora.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, sanm@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:39 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Dec 12, 2019 at 3:00 AM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> >
> > Hi Rajeshwari,
> >
> > On Thu, Nov 28, 2019 at 3:25 PM Rajeshwari <rkambl@codeaurora.org> wrote:
> > >
> > > Add TSENS node and user thermal zone for TSENS sensors in SC7180.
> > >
> > > Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 527 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 527 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index 666e9b9..6656ffc 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -911,6 +911,26 @@
> > >                         status = "disabled";
> > >                 };
> > >
> > > +               tsens0: thermal-sensor@c263000 {
> > > +                       compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
> > > +                       reg = <0 0x0c263000 0 0x1ff>, /* TM */
> > > +                               <0 0x0c222000 0 0x1ff>; /* SROT */
> > > +                       #qcom,sensors = <15>;
> > > +                       interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       interrupt-names = "uplow";
> > > +                       #thermal-sensor-cells = <1>;
> > > +               };
> > > +
> > > +               tsens1: thermal-sensor@c265000 {
> > > +                       compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
> > > +                       reg = <0 0x0c265000 0 0x1ff>, /* TM */
> > > +                               <0 0x0c223000 0 0x1ff>; /* SROT */
> > > +                       #qcom,sensors = <10>;
> > > +                       interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       interrupt-names = "uplow";
> > > +                       #thermal-sensor-cells = <1>;
> > > +               };
> > > +
> > >                 spmi_bus: spmi@c440000 {
> > >                         compatible = "qcom,spmi-pmic-arb";
> > >                         reg = <0 0x0c440000 0 0x1100>,
> > > @@ -1121,6 +1141,513 @@
> > >                 };
> > >         };
> > >
> > > +       thermal-zones {
> > > +               cpu0-thermal {
> > > +                       polling-delay-passive = <250>;
> > > +                       polling-delay = <1000>;
> > > +
> > > +                       thermal-sensors = <&tsens0 1>;
> > > +
> > > +                       trips {
> > > +                               cpu0_alert0: trip-point0 {
> > > +                                       temperature = <90000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               cpu0_alert1: trip-point1 {
> > > +                                       temperature = <95000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               cpu0_crit: cpu_crit {
> > > +                                       temperature = <110000>;
> > > +                                       hysteresis = <1000>;
> > > +                                       type = "critical";
> > > +                               };
> >
> > Where are the cooling maps for all the cpu thermal zones? A passive
> > trip point w/o a cooling map is not of much use. If you are waiting
> > for cpufreq support to land before adding them, then remove the
> > passive trip points for now and add them along with the cooling maps
> > when you have cooling devices.
>
> I will note that cpufreq support has landed in the qcom tree::
>
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=86899d8235ea0d3d7c293404fb43a6fabff866e6
>
> ...so I guess the right thing is to send a patch adding the cooling
> maps for the cpu thermal zones?

Great, then the cooling maps should be added to this patch itself.
