Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A98206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XY6grJDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFDWs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:48:29 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34549 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFDWs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:48:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id d7so3910496vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yOTYAZZHsN9vSJiFSddF1i+Vhk1s4jxk8U4YBT4J2E=;
        b=XY6grJDuWRpc6A4FNnTuk9YNCNdoSL2AaPa7Rn61s/Bmwv5EE0r0C4ldNxVpvdOjbQ
         Q0fiuZrX5aZi+ehYt9wyEZr3Oj6r+Klx0ItoVVEcCOBtyUUmCikY42wI0XiIHnrijKCy
         rzT8yT7yngP1vnlP0YeRUr5tNjjNKFluG5jds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yOTYAZZHsN9vSJiFSddF1i+Vhk1s4jxk8U4YBT4J2E=;
        b=trfulGA4RKFnw/GbuwLHy2GdFYNXb3Nw9kUDupZ/0r3MZ7CQ97oe3BYe6muVQIsWUx
         P0ICcBrbfD0wNB6rHP1PMHePbMH2in/YfPMG10dNS4xg5PuG8JuBscxD5VI26n5vvxza
         Bb5aYuHioI7tC+cxq8Jrab9wOFLu0SGt21wFsl8fDKIGTK14jW+RodAoqOdn0kOop/i8
         l7aBewOYRXzmpLV+SIDjuB1Fo7PnKhQh4+uZsPUkpb7+AHy6WCMlvtg9XaigoDrGb4Od
         SXQMiXQpHL1DSPSQDjSs4dld5/Ob6oFYNDudgOB1wN07XJWXUvpV46gPAa67hEan/loH
         gzNw==
X-Gm-Message-State: APjAAAXi6aA+Oo6D2r/MDrxe88SSmZUSUUCrzwPwK228YzNlsMjuNYZj
        I++iANI6apAaJXS5vnvw3rZ1vXn5cZo=
X-Google-Smtp-Source: APXvYqyGe102fIyTA03qn0oLAa8XJVRuUMvdaQS0ctLEWyCvEab7U9egwJa1OehRovCzAkWWV9YTqA==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr13422328vkk.26.1559688507292;
        Tue, 04 Jun 2019 15:48:27 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b17sm5741255vka.1.2019.06.04.15.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 15:48:26 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id r7so8451393ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:48:26 -0700 (PDT)
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr4142251uae.19.1559688506041;
 Tue, 04 Jun 2019 15:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190604222939.195471-1-swboyd@chromium.org> <20190604223700.GE4814@minitux>
In-Reply-To: <20190604223700.GE4814@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Jun 2019 15:48:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W08iWhbM_aDjhrz0Rm5O-Gbn6DVFNcWK5X6AB2W9YiLw@mail.gmail.com>
Message-ID: <CAD=FV=W08iWhbM_aDjhrz0Rm5O-Gbn6DVFNcWK5X6AB2W9YiLw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 4, 2019 at 3:37 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 04 Jun 15:29 PDT 2019, Stephen Boyd wrote:
>
> > The SMMU that sits in front of the QUP needs to be programmed properly
> > so that the i2c geni driver can allocate DMA descriptors. Failure to do
> > this leads to faults when using devices such as an i2c touchscreen where
> > the transaction is larger than 32 bytes and we use a DMA buffer.
> >
>
> I'm pretty sure I've run into this problem, but before we marked the
> smmu bypass_disable and as such didn't get the fault, thanks.
>
> >  arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> >  arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000
> >
> > Add the right SID and mask so this works.
> >
> > Cc: Sibi Sankar <sibis@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index fcb93300ca62..2e57e861e17c 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -900,6 +900,7 @@
> >                       #address-cells = <2>;
> >                       #size-cells = <2>;
> >                       ranges;
> > +                     iommus = <&apps_smmu 0x6c0 0x3>;
>
> According to the docs this stream belongs to TZ, the HLOS stream should
> be 0x6c3.

Since you've already got the docs in front of you, how about looking
up the value for qup0 so we can fix both of 'em?

-Doug
