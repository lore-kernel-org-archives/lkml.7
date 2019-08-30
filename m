Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6382343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XihncdPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfH3UKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:10:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34232 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfH3UKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:10:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id m10so7300251qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykdpZ3lP39dlVnbQ5KDoe1TuBSHZwyVocsneznT9rQE=;
        b=XihncdPfw8Y5WDsLRhGs6fYzbisVgMxlyPdg3ot2eXeQARM6P5zBldtANv5/CC7tTZ
         I7VeOV+dAfznnv1tOjZKqMAtD/BGGyE3UY7Cz+pJ2FGkovFzyna4dY2kTANicHk3KnSj
         qowoCxS3+BeN6WKTh7yjuvkbIumJldeCEaD1Ay39TArzYNQmwTG/OCNQ16bsflwtQ/yt
         SObq3auat+mGZten0jcpsswKU/GuKEaqfzbkS0Rs4vhlltiVvRfZOaFkcDPJ9JQ6NHJf
         GjOH85aABntGnH/QQ1nLRjH2MMpg9XjSmu6upJUUvcZtWDD9PdvM9q4N02NuTTensx7R
         +Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykdpZ3lP39dlVnbQ5KDoe1TuBSHZwyVocsneznT9rQE=;
        b=nlT8fo66G4jJqhf6nxPPqGP+11QMhWy5Ey0cYe3IcQd9/hZWYTbnVf/HEOeRjnYkyL
         dnsXjbSrKEn1do6bue7wh75EKVJU41U10Wh4IVs345+52qiTgMO6Ny7EhYecZKx5oDY6
         fkVrF8g3vIpegwJ1g4QkcEZKNhC1ZogSTBM4cXGyyrc87Zpnn6MD2AXlcASBB+ED1Rrl
         QIgBDNy78UhmBPXb+WXExDRpouzSWAFj/+07F3C5/JbJRrZp+ikvlxxYKqlq/FGV1e30
         /6wy0v4N+yivI4WEbOhtqK74kuICXNt7z+XfyEQdeyW6js+/0JVvAAr09bQKrZyXf6E2
         D78Q==
X-Gm-Message-State: APjAAAW9gPvN2Ica+geS0rIT36C69nR6VEmrKoPT0hAcA7P/rARBDXYg
        B4/QB4f6vQY+y23ek0XJeEXQAOWjKpMlYxUkQWY/fw==
X-Google-Smtp-Source: APXvYqzDwXEeJpjBAbUVp7P1xM0YAYYCf1VtkMTqM0lrwSFZEhZXYIV6mkwoFCy10QW66IskEuQfvlBu/ePB7p183PE=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr16695729qkj.127.1567195822193;
 Fri, 30 Aug 2019 13:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <1cb5ab682bce53d32f3a73b5b29cc6c3e800bfcc.1566907161.git.amit.kucheria@linaro.org>
 <5d65cc4a.1c69fb81.376b6.2486@mx.google.com>
In-Reply-To: <5d65cc4a.1c69fb81.376b6.2486@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sat, 31 Aug 2019 01:40:10 +0530
Message-ID: <CAP245DX1PfszgyL4JB60zqbFynusXUjATrkUr1_Ps6NG-fRx=g@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] arm64: dts: msm8996: thermal: Add interrupt support
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
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 6:05 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-08-27 05:14:05)
> > Register upper-lower interrupts for each of the two tsens controllers.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 96c0a481f454e..bb763b362c162 100644
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
> Is it really necessary to change the configuration here to be 0 instead
> of some number? Why can't we detect that there's an interrupt and then
> ignore these properties?

AFAICT, the thermal core currently depends on the passive and
polling_delay being set to 0 to avoid setting dispatching polling work
to a workqueue. If we leave the values to set, we'll continue to poll
inspite of an interrupt. See
thermal_core.c:thermal_zone_device_set_polling()

But I agree, the core should detect the presence of an interrupt
property and ignore the polling intervals. I'll see if I can fix this
up later.

Regards,
Amit
