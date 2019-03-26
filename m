Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3605920823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHQUUckm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfCZTjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:39:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44249 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfCZTjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:39:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so7760665ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryBCGv2xEBNEXU2aXzO4ICzRrxjpGeSrWsqtu4p1C28=;
        b=DHQUUckmM6C45xWtksRRcF6DidaWNCeE2xk9tNguwq0DY/ceSsHGIRUrnQMjgs9sI/
         iuhzH88YVBADhmvapBfhwZHw400mz6KoZHDFXYjum0W+g4+UBji1W8Upy4M1LjD2TljH
         J8RH3Ziv+Z+oHdi43mHvT+HFL/AiZWMbX6S30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryBCGv2xEBNEXU2aXzO4ICzRrxjpGeSrWsqtu4p1C28=;
        b=ZDJ4ib59WW0twjzl3GL4fX0D6vBq6SJIFYGG4WdSbtwazYYwkNLLidpdOtI7HXaKv4
         0QH+CdApMURk+kPcDAx5S12qnFhO8bZmijuFkv8DSAmBCaju2xbFVmT6+9a4NFAIGh7S
         OpSg2DWCU2APCCjQX/ExHrvgAHtrOALj57ULN+Lnh14vC4fYj7gV5BtoPnEM9zBY4ZKn
         KSa6mVbx/94Zy4tcQH0+aiY78pwUswhBT0MhfelIT+A2fRGYNXX3BoNQNsnOt/wqTG1i
         KWfF75xrjKQWLyhOgAJCw0mkt1HcoScXIbkBrsNMqRCF7ySEoKbgvy8q2seokk/aPm30
         lLYw==
X-Gm-Message-State: APjAAAW5k3gEwafC41B1tVISlEetGCEyhu0V2VA+gDDUJEORRB6RkxMo
        5Vuoukl4OG4wAACZzy24tTsjGXLmIsk=
X-Google-Smtp-Source: APXvYqx9NbyVpMUvQgGpgE9CBbvjCim6F6I4vqjnppB/1yfwJmNUK46IzOFTRgLTtE0t9IqfPlzYXg==
X-Received: by 2002:a2e:309:: with SMTP id 9mr5795588ljd.114.1553629186274;
        Tue, 26 Mar 2019 12:39:46 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x2sm3112495lfg.59.2019.03.26.12.39.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:39:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f23so12263627ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:39:45 -0700 (PDT)
X-Received: by 2002:a2e:834d:: with SMTP id l13mr5831798ljh.97.1553629184927;
 Tue, 26 Mar 2019 12:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190326170518.157317-1-evgreen@chromium.org> <71cde29a-aa10-0889-9581-8e961670bc45@free.fr>
In-Reply-To: <71cde29a-aa10-0889-9581-8e961670bc45@free.fr>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Mar 2019 12:39:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft710gv2+k86pwVhucJFxAcN-AUZhGnT9Hm2gLutV+PCpg@mail.gmail.com>
Message-ID: <CAE=gft710gv2+k86pwVhucJFxAcN-AUZhGnT9Hm2gLutV+PCpg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: msm8998: Add UFS phy reset
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andy Gross <andy.gross@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:14 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 26/03/2019 18:05, Evan Green wrote:
>
> > With the new refactoring at [1], the UFS phy now controls its own
> > destiny in toggling the phy reset bit within the UFS host controller.
> > Add the DT pieces needed to 1) expose the reset controller from the
> > HC, and 2) use it from the PHY. This series is based atop linux-next
> > plus Marc's series at [2].
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > [1] https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/
> > [2] https://lore.kernel.org/lkml/43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr/
> >
> > ---
> > I haven't tested this. Marc, I'm hoping you'll test this out and hijack this
> > patch if it needs any fixups.
> >
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > index 3d0aeb3211de..d59a2c5fe83a 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -990,6 +990,7 @@
> >                       interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> >                       phys = <&ufsphy_lanes>;
> >                       phy-names = "ufsphy";
> > +                     #reset-cells = <1>;
> >                       lanes-per-direction = <2>;
> >                       power-domains = <&gcc UFS_GDSC>;
> >
> > @@ -1039,6 +1040,7 @@
> >                               <&gcc GCC_UFS_CLKREF_CLK>,
> >                               <&gcc GCC_UFS_PHY_AUX_CLK>;
> >
> > +                     resets = <&ufshc 0>;
> >                       ufsphy_lanes: lanes@1da7400 {
> >                               reg = <0x01da7400 0x128>,
> >                                     <0x01da7600 0x1fc>,
> >
>
> If it's OK with you, I plan to test this patch tomorrow, and simply squash it
> into my UFS DT submission.

Sounds good, go ahead.
