Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4620C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB84216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJn/emhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfETVMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:12:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39265 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfETVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:12:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so7366017pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tvhovIH1bm4mrgIUbDfWITwSqOMdeKUwkQsZnjBp6SQ=;
        b=mJn/emhBX8c/yxwZ7hQePgijl18XX1s/vRudt4ZscYNY1Or30y2GLnLv/dqNjy9che
         21GPsFxyOk3+0Gj3ngYYYLEw8b6ONRvN28APdutqSlt7lem2kqTCJaESPFZscGBNntoH
         dBtkthnI1bc2WDhax+S9lIdKVIVaITT2kjxco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tvhovIH1bm4mrgIUbDfWITwSqOMdeKUwkQsZnjBp6SQ=;
        b=GVEzlx1ZZJeqOL2O6Ga1qW8CiXfGZxDz6bXkXtA0F4YEkNHQDBKR0/vbpwVQQZgSF7
         Yp/3wR9pBYYHHGNI4bEv4S6kneDRKt6oNwogGHokUIR+i4P/ttZmOPPNnOB0w4SZ39d/
         IMtQiv71Cw2go9r4QBBpNOUTJ+VKw9cZ9suSs25RPoSIMzF4kmonl0PfbzNZo5c1DmqP
         1qOKA14uUJpqKs/hgIsHqWSWltVfSDyy4CDd0RuLGyjBWMF5RF/GHUcd6kfY9TjV1DlS
         dYfZyJFzCzr8C1PJv+hSACvG2l0WYR60o4RwOSr4v9YYZmAeySPWIlBGDrRRKFqwAZVp
         QhRQ==
X-Gm-Message-State: APjAAAXYQ0qSa3VwQbK6gnmL4y354sZ/OQk+80xeWR8noIKGWKD3qCwz
        sQ+nKj+ybXEJqo51u4lSioki4w==
X-Google-Smtp-Source: APXvYqzB6kYa9tbEkVpPfd33Hr9ccQ26203/RLTGWxFCSb+WR8HAGD3cPwwEDsdADL80Gr948V9KYg==
X-Received: by 2002:a63:1d05:: with SMTP id d5mr76991884pgd.157.1558386736752;
        Mon, 20 May 2019 14:12:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e16sm33603662pfj.77.2019.05.20.14.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:12:15 -0700 (PDT)
Date:   Mon, 20 May 2019 14:12:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Limit GPU frequency on veyron
 mickey to 300 MHz when the CPU gets very hot
Message-ID: <20190520211215.GG40515@google.com>
References: <20190520170132.91571-1-mka@chromium.org>
 <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 01:16:46PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 20, 2019 at 10:01 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
> > frequency on veyron mickey to 300 MHz for CPU temperatures >= 85°C.
> >
> > This matches the configuration of the downstream Chrome OS 3.14 kernel,
> > the 'official' kernel for mickey.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
> > entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
> > ---
> >  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > index d889ab3c8235..f118d92a49d0 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > +++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > @@ -125,6 +125,12 @@
> >                                          <&cpu2 8 THERMAL_NO_LIMIT>,
> >                                          <&cpu3 8 THERMAL_NO_LIMIT>;
> >                 };
> > +
> > +               /* At very hot, don't let GPU go over 300 MHz */
> > +               cpu_very_hot_limit_gpu {
> > +                       trip = <&cpu_alert_very_hot>;
> > +                       cooling-device = <&gpu 2 2>;
> > +               };
> 
> Two things:
> 
> A) If I'm reading things properly, you're actually limiting things to
> 400 MHz.  This is because you don't have <https://crrev.com/c/1574579>
> which deletes the 500 MHz GPU operating point.  So on upstream the
> available points are:
> 
> 0: 600 MHz
> 1: 500 MHz
> 2: 400 MHz
> 3: 300 MHz
> 4: 200 MHz
> 5: 100 MHz
> 
> ...and downstream:
> 
> 0: 600 MHz
> 1: 400 MHz
> 2: 300 MHz
> 3: 200 MHz
> 4: 100 MHz

Thanks spotting this!

> Thinking about it more, I bet Heiko would actually be OK deleting the
> 500 MHz GPU operating point for veyron.  Technically it's not needed
> upstream because upstream doesn't have our hacks to allow re-purposing
> NPLL for HDMI (so they _can_ make 500 MHz) but maybe we can make the
> argument that these laptops have only ever been tested with the 500
> MHz operating point removed and also that eventually someonje will
> probably figure out a way to re-purpose NPLL for HDMI even upstream...

Looks like Heiko is indeed ok with it, so let's remove the OPP and be
in sync with downstream on this.

> B) It seems like in the same patch you'd want to introduce
> "cpu_warm_limit_gpu", AKA:
> 
> cpu_warm_limit_gpu {
>   trip = <&cpu_alert_warm>;
>   cooling-device =
>   <&gpu 1 1>;
> };

Makes sense to do it in the same patch, will add it in v2.
