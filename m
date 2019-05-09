Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8248DC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7F2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfK/Uume"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEIDAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:00:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43321 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfEIDAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:00:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so402624pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R6mFOl4YJArdXkPl64BdobxdiCxDb1GQAsEcDCxAI1c=;
        b=AfK/Uume2oPASwykEbs/t9IMEMyllPOQopDa9fMIYaD+zAfbeCEUFdQuIappnyEn3z
         dXioYDA9KBXc/pOKOAihi0asuc6L5//SlvzGt4LgklZGtohHhIVNx3Fst2PBNV2u3PTj
         PiUEOpLgZNU8Jggtcbvz1aU0YT/6i8SvYYCA1qUjdlF3Ol/dGwMiw14DGpN5f5vw2ZkJ
         1x/5fvkiDw01ozcsLF/oUJy+2+wue9QV5IIjfdiorrI2SfwTjCWItRF/gla27XbLQFuS
         kMSmjYCnOW8T8itm7LgazU11YQiaDQY2lN50WFLZ8I6Mh/r01WIW/ChsfNTLzuX6T0Oh
         yeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R6mFOl4YJArdXkPl64BdobxdiCxDb1GQAsEcDCxAI1c=;
        b=UvAZbV5XbOxKMOKUa4nxlQYpHb4jhZ9kHfsMkqzD2NIVYJJ0PjOSY9URiTCygJX0BM
         w3ISntFljETMYJnl+R64wmu/y/u4Ct8u4LtBXVYFYnfoU6gOxvBCebqOgZJlCDakPBO+
         4zGVATQtM6r3DHXIaRIKkk6syNqcLzJM/w58gULGZ9lGaT86t7gnSFdpQoTbwgk3ORHK
         ccrxc+oZDKA0OL52vTBKwt07k3h3KE+BSxAlcV55GOgsvhoqOMGHhCwkh5ktMCrxLEMq
         TZiz+jox+MTmz8fRFGgxSuObcKS3s4RmXNZWdKo0Z+7DjLWze8Cvb+1AMrzfguc4nKU3
         Zj/g==
X-Gm-Message-State: APjAAAUuqA4jAoQZQofa0SutzA5rwCFT8tpd8Suncvsj1ctvMEuI6kef
        kyzVbZtS7JlcTc50cgKa6w0bIQ==
X-Google-Smtp-Source: APXvYqxgN704DpczLbGfx053xEiv41Nt6oO0nbwl2oNJfPJaAeEeqFFzx6MkSY1scvkrrW5nHXsfWA==
X-Received: by 2002:a63:5659:: with SMTP id g25mr2416023pgm.59.1557370833308;
        Wed, 08 May 2019 20:00:33 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o5sm901426pfa.135.2019.05.08.20.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 20:00:31 -0700 (PDT)
Date:   Wed, 8 May 2019 20:00:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Brian Masney <masneyb@onstation.org>, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 4/6] ARM: dts: msm8974: add display support
Message-ID: <20190509030047.GE2085@tuxbook-pro>
References: <20190505130413.32253-1-masneyb@onstation.org>
 <20190505130413.32253-5-masneyb@onstation.org>
 <20190507063902.GA2085@tuxbook-pro>
 <20190509021616.GA26228@basecamp>
 <CAF6AEGsM382jB=h7oM3frhZ5fAp+qYUdgiiKSKo1RtR8+ffjrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsM382jB=h7oM3frhZ5fAp+qYUdgiiKSKo1RtR8+ffjrg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 May 19:25 PDT 2019, Rob Clark wrote:

> On Wed, May 8, 2019 at 7:16 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > On Mon, May 06, 2019 at 11:39:02PM -0700, Bjorn Andersson wrote:
> > > On Sun 05 May 06:04 PDT 2019, Brian Masney wrote:
> > > > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > [..]
> > > > +                           clocks = <&mmcc MDSS_MDP_CLK>,
> > > > +                                    <&mmcc MDSS_AHB_CLK>,
> > > > +                                    <&mmcc MDSS_AXI_CLK>,
> > > > +                                    <&mmcc MDSS_BYTE0_CLK>,
> > > > +                                    <&mmcc MDSS_PCLK0_CLK>,
> > > > +                                    <&mmcc MDSS_ESC0_CLK>,
> > > > +                                    <&mmcc MMSS_MISC_AHB_CLK>;
> > > > +                           clock-names = "mdp_core",
> > > > +                                         "iface",
> > > > +                                         "bus",
> > > > +                                         "byte",
> > > > +                                         "pixel",
> > > > +                                         "core",
> > > > +                                         "core_mmss";
> > >
> > > Unless I enable MMSS_MMSSNOC_AXI_CLK and MMSS_S0_AXI_CLK I get some
> > > underrun error from DSI. You don't see anything like this?
> > >
> > > (These clocks are controlled by msm_bus downstream and should be driven
> > > by interconnect upstream)
> > >
> > >
> > > Apart from this, I think this looks nice. Happy to see the progress.
> >
> > No, I'm not seeing an underrun errors from the DSI. I think the clocks
> > are fine since I'm able to get this working with 4.17 using these same
> > clocks. I just sent out v2 and the cover letter has some details, along
> > with the full dmesg.
> 
> since we don't have interconnect driver for 8974, I guess there is
> some chance that things work or not based on how lk leaves things?
> 

Right, I guess the bootloader on my device does not leave the busses
ticking - perhaps there's a boot splash involved on Brian's device?

Regardless, this works on Nexus 5 and allows Brian to make further
progress so I'm all for merging it.

Regards,
Bjorn
