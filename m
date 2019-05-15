Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CAC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvIBHM9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfEOVhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:37:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40067 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:37:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so488829plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAyYd7Pec4gg4Zl5/b6GbJ3Lhmz83i6aehOb2aZw1ro=;
        b=EvIBHM9Mo9vFpQUMxFf658yZkkY5dVan5FwYFk7XQjrefRysWBk3ZQvleVivTl8WEg
         yGsgkIci+3QXrOpBs7AluJ54pjlX/BMGjRs+gz/YpHjrgdJbHhmsF1dmVSNbGhtgchVi
         U/adQE+kIwDBIDEQnhjnkHhI0yBiCEF8Y+GLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAyYd7Pec4gg4Zl5/b6GbJ3Lhmz83i6aehOb2aZw1ro=;
        b=Mx3mf1YhGRrD2vgPbU5AMYp6qoGxz1rEvX/7wYZfQMG/McxKeXMuUAzwUDlvUptaT9
         QcXXHCxNUMTfeNqNsHRkMTPuuaRw3dff1ODwZxbHQEuzWBMWze0uHOplik1mcEP/gc6X
         vh8HW9Sd2AmC0UZZtIK8ZCP+2iwjy9ZtT2WAyGRZvtHK190/Az0zFOhpvvORLvRr97gV
         2KNp2wYHly/Kn8nnaLfzZlMn0amihn9uEyTCtuJ8dfjFCpdNrBb+wTkli3aJR+D5X4Kf
         ipKPbBWml3eG//NTkB2UjL1rt8Qv4KAz2lfTCJvQN3BqSN0ipJN3AwagFeugTHuLBzPx
         dqpg==
X-Gm-Message-State: APjAAAXbJiBTn77BBu+SQa4EzzQb2bwyGWZi9MdotAFhlqLCfDRo9Luv
        c3UNNk2vjQAk1H0poFkiEUKqAC3i2ek=
X-Google-Smtp-Source: APXvYqxyhkmCbMue4Dl52l51XVW4EiT6xf/ZY+zI2fdisxugkpbOQnjZfg8mMjHbUnr9gGPnm0w9QQ==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr2363024pls.201.1557956224865;
        Wed, 15 May 2019 14:37:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f29sm8844632pfq.11.2019.05.15.14.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 14:37:03 -0700 (PDT)
Date:   Wed, 15 May 2019 14:37:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dts: rockchip: raise GPU trip point temperature for
 veyron to 72.5 degC
Message-ID: <20190515213703.GE40515@google.com>
References: <20190515153127.24626-1-mka@chromium.org>
 <CAD=FV=U19uAGkwTqg-N6_m5WYQ7yMwjQir3TYUsb3SWWOihTOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=U19uAGkwTqg-N6_m5WYQ7yMwjQir3TYUsb3SWWOihTOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

thanks for the review!

On Wed, May 15, 2019 at 11:30:24AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 15, 2019 at 8:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > This value matches what is used by the downstream Chrome OS 3.14
> > kernel, the 'official' kernel for veyron devices.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm/boot/dts/rk3288-veyron.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> > index 1252522392c7..169da06e1c09 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> > +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> > @@ -446,6 +446,14 @@
> >         status = "okay";
> >  };
> >
> > +&gpu_thermal {
> > +       trips {
> > +               gpu_alert0: gpu_alert0 {
> > +                       temperature = <72500>; /* millicelsius */
> > +               };
> > +       };
> > +};
> > +
> 
> This should be sorted alphabetically.  Thus this should sort right
> after this in rk3288-veyron.dtsi
> 
> &gpu {
>   mali-supply = <&vdd_gpu>;
>   status = "okay";
> };

will do in the next revision.

> Also you don't need to replicate the whole structure?  I think the
> above should just be:
> 
> &gpu_alert0 {
>   temperature = <72500>; /* millicelsius */
> };

ack

> NOTE also that that gpu and cpu critical is 100 C downstream.  Should
> we do that too?

I missed this delta, yes let's do this too in this series.

> Ah, but before we do that I guess we'd need to also  override the
> "rockchip,hw-tshut-temp" to 125000 to match downstream. I guess that
> could be a separate series?

Yes, the value should at least be higher than the critical trip point,
matching downstream seems to make sense.
