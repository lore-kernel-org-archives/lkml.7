Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AE52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQ9VXLFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfEOSnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:43:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39101 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfEOSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:43:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so603218vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNECGk8CnSY+BUMqx/A6sNJnXy1K+tE5/+q6NrpNAeg=;
        b=BQ9VXLFElWFzf7izK1ym/zFCq1WxsSoI7IZR/etFVJ3c6xH3PwVo3az6lB+MkUP/Gj
         PxZMwkXe1rl5EjO3Kxfks/TZY3oYrwLodR/8iZJr/9CDD59tWt7jhU4zsZs0BYYwMRNN
         Iey0Dt7PXFPRad8sX/uvZhi1xQzvN9Br//u9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNECGk8CnSY+BUMqx/A6sNJnXy1K+tE5/+q6NrpNAeg=;
        b=DII7QA+WmkGJqfiSxDmJtwJuoxg1GziA9Crl1+rHICKGaiSFyIFyQPNADRq/aACDSj
         aVJlAkUjhlsgZqt3G7ViKrDpy4mhsH/ut8LAc1XWhBpj08KFS1jjPOUXHIbzPDXDh899
         zIF1jm0XTinYC8IcF2UwCj286aUn1JDuY06+NiFG3lFIF/SBKPK9pOOTpvEO2YXCxW3z
         8OU3yNRBCGludNbkoBkWEPZ/xsudnfQSDpa33vfjgl6o894ztwfxu11H7tZ6sk6sZ/5g
         8gygPAmc4dsdW6MCtN0uxTgv67yMj6HCkaV4uHkV0n2alcu9oP9fkLVu5c+L1jMeNuaX
         0KZA==
X-Gm-Message-State: APjAAAXrusLaIydCi1HzPjxdd0omQtksUfa6ujMZr318c9xfwlYYz2PC
        pAnlOEjuj5g3Y80i2YzENUNV8R5Q58Q=
X-Google-Smtp-Source: APXvYqyckGZ/HC/khmRPlka1IPm1juJRRL3yoU+C3vijIcm3iI80vkFqDcOxIpObt+7w0e40WEmynA==
X-Received: by 2002:a67:8008:: with SMTP id b8mr13756714vsd.33.1557945828925;
        Wed, 15 May 2019 11:43:48 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id g3sm2295945vkb.9.2019.05.15.11.43.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:43:41 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id t15so254474uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:43:41 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr5386901uao.106.1557945821179;
 Wed, 15 May 2019 11:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190424162827.5297-1-mka@chromium.org> <CAD=FV=W+QGLmhEaqGc-=wNFzmaCr_f4rb5e8KQ4ZmeRaNi_xCw@mail.gmail.com>
In-Reply-To: <CAD=FV=W+QGLmhEaqGc-=wNFzmaCr_f4rb5e8KQ4ZmeRaNi_xCw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 11:43:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQ-yAeB_xU5UVHGWgsC=a9t_CtN9bHvZnoxkfuA9=zGw@mail.gmail.com>
Message-ID: <CAD=FV=WQ-yAeB_xU5UVHGWgsC=a9t_CtN9bHvZnoxkfuA9=zGw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 10:59 AM Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Wed, Apr 24, 2019 at 9:28 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> > The Mali GPU of the rk3288 can be used as cooling device, add
> > a #cooling-cells entry for it.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm/boot/dts/rk3288.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> > index ca7d52daa8fb..767e62908a6e 100644
> > --- a/arch/arm/boot/dts/rk3288.dtsi
> > +++ b/arch/arm/boot/dts/rk3288.dtsi
> > @@ -1275,6 +1275,7 @@
> >                 interrupt-names = "job", "mmu", "gpu";
> >                 clocks = <&cru ACLK_GPU>;
> >                 operating-points-v2 = <&gpu_opp_table>;
> > +               #cooling-cells = <2>; /* min followed by max */
> >                 power-domains = <&power RK3288_PD_GPU>;
> >                 status = "disabled";
> >         };
>
> Seems like a good idea to me.  Presumably we should also add this to
> the bindings?
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I guess we could now also do a follow-up CL that starts using the GPU
as a cooling device.  Presumably it's still OK to specify this and it
will just be ignored if there's no GPU driver?  It's a little funny
because the upstream device tree uses the CPU to cool things down if
the GPU temperature sensor trips.  Downstream uses the GPU to cool
down the GPU.  ...though, of course, it's not really all that simple
since everything is packed in so tightly.

The other case that sticks as a sore thumb is the upstream
"rk3288-veyron-mickey" where all the comments still talk about the GPU
cooling but we have only the CPU cooling actually in the device tree.
:-)

-Doug
